Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287001AbRL1U1A>; Fri, 28 Dec 2001 15:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287009AbRL1U0k>; Fri, 28 Dec 2001 15:26:40 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:46070 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S287008AbRL1U0i>;
	Fri, 28 Dec 2001 15:26:38 -0500
Date: Fri, 28 Dec 2001 15:26:32 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
In-Reply-To: <20011228141211.B15338@thyrsus.com>
Message-ID: <Pine.GSO.4.21.0112281459380.3924-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 28 Dec 2001, Eric S. Raymond wrote:

> The design reason is that having a single file with all the symbol-to-prompt
> mappings in it is really helpful when you want to localize the rulebase for
> another language.  I'm still leaning towards keeping symbols.cml together
> just to make it easier for people to do and distribute translations of it.
> 
> I think this is an issue that is rising in importance.  I have no problem
> with assuming that kernel hackers are English-literate, but it's no longer
> an assumption we should make about people *building* kernels.  I want
> to encourage CML2 and question-string localizations for French.  And
> German.  And Thai.  And Ethiopian.

You are nuts.  OK, you've got these translations.  Now what?  $FOO adds
a new option.  Should he, by any chance, supply all relevant translations
in the same patch?  No?  Good, so we are going to have them permanently
out of sync.  Better yet, option changes its meaning.  Now we have
English variant with new semantics and Thai one with the old.  Happy,
happy, joy, joy...

And that's aside of the real problem with "internationalization" - quality
of translations _sucks_.  Always.  Yes, USAnian to English is easy.  But
that's it.  I've tried to use LANG=ru_RU.koi8-r.  It had lasted a couple
of days.  You end up reconstructing the English original and translating
it to Russian - and boy, does that process annoy...

Frankly, I find it very amusing that advocates of i18n efforts tend to
be either British or USAnians.  Folks, get real - your languages are
too close to show where the problems are.  I can see how doing that
gives you a warm fuzzy feeling, but could you please listen to those
of us who have to deal with the resulting mess for real?

