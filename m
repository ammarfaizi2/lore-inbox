Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318219AbSIJXvm>; Tue, 10 Sep 2002 19:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318222AbSIJXvl>; Tue, 10 Sep 2002 19:51:41 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:47346 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318219AbSIJXvl>; Tue, 10 Sep 2002 19:51:41 -0400
Date: Wed, 11 Sep 2002 01:56:27 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre6
In-Reply-To: <Pine.LNX.4.44.0209101501200.16518-100000@freak.distro.conectiva>
Message-ID: <Pine.NEB.4.44.0209110152380.26432-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2002, Marcelo Tosatti wrote:

>...
> Geert Uytterhoeven <geert@linux-m68k.org>:
>...
>   o Wrong fbcon_mac dependency
>...

It's possible to enable CONFIG_FBCON_MAC on !m68k and after your change
the compilation breaks on i386 with the following error:

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-2.4.19-full/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc
-iwithprefix include -DKBUILD_BASENAME=fbcon  -c -o fbcon.o fbcon.c
fbcon.c: In function `fbcon_setup':
fbcon.c:641: `MACH_IS_MAC' undeclared (first use in this function)
fbcon.c:641: (Each undeclared identifier is reported only once
fbcon.c:641: for each function it appears in.)
make[3]: *** [fbcon.o] Error 1
make[3]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.19-full/drivers/video'

<--  snip   -->

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

