Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318711AbSIKKyg>; Wed, 11 Sep 2002 06:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318714AbSIKKyg>; Wed, 11 Sep 2002 06:54:36 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:20734 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S318711AbSIKKyf>;
	Wed, 11 Sep 2002 06:54:35 -0400
Date: Wed, 11 Sep 2002 12:55:52 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Adrian Bunk <bunk@fs.tum.de>
cc: lkml <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Linux 2.4.20-pre6
In-Reply-To: <Pine.NEB.4.44.0209110152380.26432-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.GSO.4.21.0209111252340.27524-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2002, Adrian Bunk wrote:
> On Tue, 10 Sep 2002, Marcelo Tosatti wrote:
> 
> >...
> > Geert Uytterhoeven <geert@linux-m68k.org>:
> >...
> >   o Wrong fbcon_mac dependency
> >...
> 
> It's possible to enable CONFIG_FBCON_MAC on !m68k and after your change
> the compilation breaks on i386 with the following error:
> 
> <--  snip  -->
> 
> ...
> gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-2.4.19-full/include
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
> -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc
> -iwithprefix include -DKBUILD_BASENAME=fbcon  -c -o fbcon.o fbcon.c
> fbcon.c: In function `fbcon_setup':
> fbcon.c:641: `MACH_IS_MAC' undeclared (first use in this function)
> fbcon.c:641: (Each undeclared identifier is reported only once
> fbcon.c:641: for each function it appears in.)
> make[3]: *** [fbcon.o] Error 1
> make[3]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.19-full/drivers/video'

Hmmm... I didn't realize vesafb can use fbcon-mac.

However, it seems to be used if you don't enable any of the fbcon-cfb* modules
only, since fbcon-cfb* takes precendence.

Do people really use 6x11 fonts with vesafb?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

