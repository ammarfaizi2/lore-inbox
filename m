Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261783AbSI1PLv>; Sat, 28 Sep 2002 11:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261865AbSI1PLv>; Sat, 28 Sep 2002 11:11:51 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:26891 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261783AbSI1PLu>; Sat, 28 Sep 2002 11:11:50 -0400
Date: Sat, 28 Sep 2002 17:15:31 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Tomas Szepe <szepe@pinerecords.com>
cc: linux-kernel@vger.kernel.org,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: linux kernel conf 0.7
In-Reply-To: <20020928144250.GC3337@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.44.0209281704410.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 28 Sep 2002, Tomas Szepe wrote:

> > At http://www.xs4all.nl/~zippel/lc/ you can find the latest version of the
> > new config system. Besides the usual archive there is also now a patch
> > against a 2.5.39 kernel and finally some documentation.
>
> o  lkc-0.7-2.5.39.diff includes patches to include/linux/autoconf.h

Ok, easily fixed (and the reject can be easily ignored).

> o  'make distclean; make oldconfig' produces
>
> make[1]: Entering directory /usr/src/linux-2.5.39/scripts/lkc'
> Makefile:42: *** missing separator (did you mean TAB instead of 8 spaces?).  Stop.
> make[1]: Leaving directory /usr/src/linux-2.5.39/scripts/lkc'
> make: *** [oldconfig] Error 2
>
> i.e. the patch seems to have foomed up the tabs

Hmm, my make ignores this and obviously Kai's make too, as I copied this
from his patch.

> o  fix up & continue, 'make distclean; make oldconfig' produces
>
> kala@kirsi:/usr/src/linux-2.5.39$ make oldconfig
> make[1]: Entering directory /usr/src/linux-2.5.39/scripts/lkc'
>   cat zconf.tab.h_shipped > zconf.tab.h
>   gcc -Wp,-MD,./.conf.o.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer   -c -o conf.o conf.c
> /bin/sh: /usr/src/linux-2.5.39/scripts/fixdep: No such file or directory
> make[1]: *** [conf.o] Error 1
> make[1]: Leaving directory /usr/src/linux-2.5.39/scripts/lkc'
> make: *** [oldconfig] Error 2

I have to pass on this one to Kai too. Personally I think fixdep shouldn't
be used for host programs. An "make scripts/fixdep" gets you past this
for now.

bye, Roman

