Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262351AbSI1X4t>; Sat, 28 Sep 2002 19:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262352AbSI1X4t>; Sat, 28 Sep 2002 19:56:49 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:58120 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262351AbSI1X4o>; Sat, 28 Sep 2002 19:56:44 -0400
Date: Sun, 29 Sep 2002 02:00:50 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.7
In-Reply-To: <20020929004821.A11497@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0209290133380.338-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 29 Sep 2002, Sam Ravnborg wrote:

> 1) Old tools zapped <file:> tags around filenames.

Ok.

> > An issue (which was also mentioned by Jeff Garzik) is the help text
> > format. Jeff likes to have an endhelp, where I think it's redundant.
> 2) The current way forces the layout of the help text. I would prefer a way
> that allowed the tools to use the space available instead.
> Then a "." followed by newline could be interpreted as "forced-new-line"
> or similar.
> If endhelp is needed for that I vote for this as well.

The problem is that the Config.help format has almost no restrictions, so
somehow I have to avoid messing up the content (at least for the
majority of options), so far I tried to avoid to reformat all the help
text.
Another possibility might to use html tags.

> 3) The syntax seems to be:
> config SYMBOL
> 	type-of-symbol optional-text
> I would like "optional-text" to become mandatory. Then you could bail out
> with an error when it does not exist.

Why should it be an error? Symbols without a text are used for derived
symbols.

> 4) Did not find the documentation you mentioned, but on the other hand I
> applied only the 2.3.39 diff.

It's on the web. :)

> 5) Show All intuitively is a shortcut for selecting all the three
> possibilities {NAME, RANGE, DATA}, but is about showing all symbols.
> 6) The ARCH specific options does not fit well into the tree.
> GENERIC_ISA_DMA in top of tree, X86_SMP in bottom of tree.
> Visible only with SHOW ALL enabled.

"Show All" is mostly only a debug option, so what you see here isn't
important to the normal user.

> 7) I can step down in the tree but I need to select each sibling in the tree
> induvidially. I expected to be able to select Cirrus logic under ALSA, and
> let the selection boil up to the top.

This is a planned feature, first I want to have a replacement for the old
tools, new features come later.
I suppose you use QT2 and "Show All" was active? Then it can be a bit
confusing since the usually not visible items are not specially marked.

> 8) File|Save followed by File|Quit. Still it ask if I want to save, even
> no changes made inbetween.

Simple to do.

> 9) Renames a file in a source statement:
> [sam@mars lkc-2.5.39]$ make xconfig
> make[1]: `qconf' is up to date.
> ./scripts/lkc/qconf arch/i386/Build.conf
> can't find file ssound/arm/Build.conf
> make: *** [xconfig] Error 1
>
> Error shall tell where the file is sourced. [.../Build.conf:27]
>
> 10) Deleted endmenu tag in sound/Build.conf:
> [sam@mars lkc-2.5.39]$ make xconfig
> make[1]: `qconf' is up to date.
> ./scripts/lkc/qconf arch/i386/Build.conf
> <none>:0:parse error, unexpected $
> make: *** [xconfig] Error 1
>
> Some errorhandling needs to be improved a little.

I know and it slowly moves to the top of the TODO list. :)

bye, Roman

