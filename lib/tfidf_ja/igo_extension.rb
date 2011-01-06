# coding: utf-8
#
#Copyright:: Copyright (c) kyow, 2011
#Authors:: K.Nishi

$:.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'igo-ruby'

#
#
#
module TfIdf
  #
  #
  #
  class IgoExtension
    # コンストラクタ
    def initialize(dir)
#     dir = File::expand_path(dir)
      @tagger = Igo::Tagger.new(dir)
      @tfidf = TfIdf::Ja.new
    end
    
    def reset
      @tfidf.reset
    end
    
    # igo-rubyを利用して形態素解析を行ない、その結果のTF-IDFを返却する
    #text:: テキスト
    def tfidf(text)
      t = @tagger.parse(text)
      words = []
      
      # 品詞が"名詞"の形態素を選択
      t.each{ |m|
        part = m.feature.split(',')[0]
        if(part == '名詞')
          words.push(m.surface)
        end
      }
      
      return @tfidf.tfidf(words)
    end
  end
end