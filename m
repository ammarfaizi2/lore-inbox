Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264935AbSJPGsH>; Wed, 16 Oct 2002 02:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264938AbSJPGsH>; Wed, 16 Oct 2002 02:48:07 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:3318 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264935AbSJPGsF>; Wed, 16 Oct 2002 02:48:05 -0400
Date: Wed, 16 Oct 2002 08:53:55 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre11
In-Reply-To: <Pine.LNX.4.44L.0210152109360.31342-100000@freak.distro.conectiva>
Message-ID: <Pine.NEB.4.44.0210160849180.20607-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2002, Marcelo Tosatti wrote:

>...
> Summary of changes from v2.4.20-pre10 to v2.4.20-pre11
> ============================================
>...
> Alan Cox <alan@lxorguk.ukuu.org.uk>:
>...
>   o update the SiS framebuffer
>...

This patch broke the compilation of sis_main.c:

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-2.4.19-full/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc
-iwithprefix include -DKBUILD_BASENAME=sis_main  -c -o sis_main.o
sis_main.c
In file included from sis_main.c:67:
sis_main.h:348: parse error before `sisvga_engine'
sis_main.h:348: warning: type defaults to `int' in declaration of
`sisvga_engine'
sis_main.h:348: `UNKNOWN_VGA' undeclared here (not in a function)
sis_main.h:348: warning: data definition has no type or storage class
sis_main.h:363: parse error before `sisfbinfo'
sis_main.h:363: warning: type defaults to `int' in declaration of
`sisfbinfo'
sis_main.h:363: warning: data definition has no type or storage class
...
make[4]: *** [sis_main.o] Error 1
make[4]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.19-full/drivers/video/sis'

<--  snip  -->

line 348 in sis_main.h is:

  VGA_ENGINE sisvga_engine = UNKNOWN_VGA;



cu
Adrian

-- 

"Is there not promise of rain?" Ling Tan asked suddenly out
of the darkness. There had been need of rain for many days.
"Only a promise," Lao Er said.
                                Pearl S. Buck - Dragon Seed


