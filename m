Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261670AbSI1Ohm>; Sat, 28 Sep 2002 10:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261673AbSI1Ohm>; Sat, 28 Sep 2002 10:37:42 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:51984 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S261670AbSI1Ohl>; Sat, 28 Sep 2002 10:37:41 -0400
Date: Sat, 28 Sep 2002 16:42:50 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.7
Message-ID: <20020928144250.GC3337@louise.pinerecords.com>
References: <Pine.LNX.4.44.0209281529580.338-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209281529580.338-100000@serv>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At http://www.xs4all.nl/~zippel/lc/ you can find the latest version of the
> new config system. Besides the usual archive there is also now a patch
> against a 2.5.39 kernel and finally some documentation.

o  lkc-0.7-2.5.39.diff includes patches to include/linux/autoconf.h
o  'make distclean; make oldconfig' produces

make[1]: Entering directory /usr/src/linux-2.5.39/scripts/lkc'
Makefile:42: *** missing separator (did you mean TAB instead of 8 spaces?).  Stop.
make[1]: Leaving directory /usr/src/linux-2.5.39/scripts/lkc'
make: *** [oldconfig] Error 2

i.e. the patch seems to have foomed up the tabs

o  fix up & continue, 'make distclean; make oldconfig' produces

kala@kirsi:/usr/src/linux-2.5.39$ make oldconfig
make[1]: Entering directory /usr/src/linux-2.5.39/scripts/lkc'
  cat zconf.tab.h_shipped > zconf.tab.h
  gcc -Wp,-MD,./.conf.o.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer   -c -o conf.o conf.c
/bin/sh: /usr/src/linux-2.5.39/scripts/fixdep: No such file or directory
make[1]: *** [conf.o] Error 1
make[1]: Leaving directory /usr/src/linux-2.5.39/scripts/lkc'
make: *** [oldconfig] Error 2

And so on.

T.
