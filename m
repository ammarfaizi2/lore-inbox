Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267859AbTBRQan>; Tue, 18 Feb 2003 11:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267860AbTBRQan>; Tue, 18 Feb 2003 11:30:43 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:20185 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S267859AbTBRQam>;
	Tue, 18 Feb 2003 11:30:42 -0500
Date: Tue, 18 Feb 2003 17:40:06 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: John Bradford <john@grabjohn.com>
cc: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       kai@tp1.ruhr-uni-bochum.de
Subject: Re: 2.5.62: Cross-building broken
In-Reply-To: <200302181349.h1IDnX6w001233@darkstar.example.net>
Message-ID: <Pine.GSO.4.21.0302181739490.25787-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2003, John Bradford wrote:
> > Cross-building ARM from HPPA:
> > 
> > $ make config CROSS_COMPILE=/home/rmk/bin/arm-linux- ARCH=arm
> > make: Entering directory `/home/rmk/v2.5/linux-rpc'
> > make -f scripts/Makefile.build obj=scripts
> >   gcc -Wp,-MD,scripts/.empty.o.d -D__KERNEL__ -Iinclude -Wall
> >  -Wstrict-prototypes -Wno-trigraphs -Os -fno-strict-aliasing -fno-common
> >  -mshort-load-bytes -msoft-float -Wa,-mno-fpu -Uarm -nostdinc -iwithprefix
> >  include    -DKBUILD_BASENAME=empty -DKBUILD_MODNAME=empty -c -o
> >  scripts/empty.o scripts/empty.c
> > make: Leaving directory `/home/rmk/v2.5/linux-rpc'
> > cc1: Invalid option `short-load-bytes'
> > make[1]: *** [scripts/empty.o] Error 1
> > make: *** [scripts] Error 2
> > 
> > We seem to be using the wrong compiler here, or the wrong CFLAGS.
> 
> Hmmm, cross compiling for Sparc works:

And for m68k works, too.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

