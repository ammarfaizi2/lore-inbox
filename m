Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265222AbSJaSUJ>; Thu, 31 Oct 2002 13:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265234AbSJaSUJ>; Thu, 31 Oct 2002 13:20:09 -0500
Received: from borg.org ([208.218.135.231]:36736 "HELO borg.org")
	by vger.kernel.org with SMTP id <S265222AbSJaSTk>;
	Thu, 31 Oct 2002 13:19:40 -0500
Date: Thu, 31 Oct 2002 13:26:07 -0500
From: Kent Borg <kentborg@borg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Mark Mielke <mark@mark.mielke.cc>, Adrian Bunk <bunk@fs.tum.de>,
       Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021031132607.E21801@borg.org>
References: <20021030233605.A32411@jaquet.dk> <Pine.NEB.4.44.0210310145300.20835-100000@mimas.fachschaften.tu-muenchen.de> <20021031011002.GB28191@opus.bloom.county> <20021031053310.GB4780@mark.mielke.cc> <20021031143301.GC28191@opus.bloom.county> <20021031165113.GB8565@mark.mielke.cc> <20021031170420.GA30193@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021031170420.GA30193@opus.bloom.county>; from trini@kernel.crashing.org on Thu, Oct 31, 2002 at 10:04:20AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 10:04:20AM -0700, Tom Rini wrote:
> In other words, s/CONFIG_TINY/CONFIG_FINE_TUNE, and ask about
> anything / everything which might want to be tuned up.

Please, no.  Keep this simple.  

I don't want a bunch of configs that abstract out everything I might
want to tamper with to make a small system.  The only way I am going
to make sense out of them will be to look at the source controlled by
each anyway.  I would rather search the source for CONFIG_TINY and see
a single, coherent, and sensible set of concrete changes that make
things smaller.  Let me mangle and customize from there, it will be
much easier for me to understand what I am doing.

> Then this becomes a truely useful set of options, since as Alan
> pointed out in one of the earlier CONFIG_TINY threads, his Athlon
> could benefit from some of these 'tiny' options too.

Certainly, if there are potential config options that would be truly
useful to general folks, then by all means, yes!, make them separate
options.  (Isn't that what has been going on all along?)  But let us
not put in a config for every imaginable tuning and then pretend that
hiding them behind a CONFIG_FINE_TUNE somehow doesn't make them any
less a groady mess.  

Isn't there an attempt with the current config process to set up
dependencies so that any config from "make config" or "make xconfig"
has a crack at being at least self-consistent, if not otherwise
sensible?  Won't this CONFIG_FINE_TUNE become a bloating ground for
every obscure special interest config, related to size or not, whether
it builds or not, whether it runs of not?  (And be so confusing as to
still not help me build a tiny kernel?)

If something is worth a config, give it a config.  (And if it isn't,
don't!)  But not every component of making a tiny system is worth a
standalone config.  Let me grep for CONFIG_TINY and hack my
nonstandard things from there.


-kb, the Kent who thinks the language in which the kernel is written
should remain C and not drift toward being the config file.


P.S.  This reminds me of not littering the code with type defs that
reduce to simple types.  Abstraction for abstraction's sake seems
silly.  Keep it simple.
