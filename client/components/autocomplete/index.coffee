#
# A lightweight wrapper around typeahead to add styling/common behavior.
#

_ = require 'underscore'
Backbone = require 'backbone'
require 'typeahead.js'

module.exports = class Autocomplete extends Backbone.View

    initialize: (options) ->
      search = new Bloodhound
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value')
        queryTokenizer: Bloodhound.tokenizers.whitespace
        remote:
          url: options.url
          filter: options.filter
      search.initialize()
      $(@el).typeahead null,
        name: options.name or _.uniqueId()
        source: search.ttAdapter()
      $(@el).on 'typeahead:selected', options.selected