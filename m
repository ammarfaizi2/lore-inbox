Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268141AbTBYNFh>; Tue, 25 Feb 2003 08:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268144AbTBYNFh>; Tue, 25 Feb 2003 08:05:37 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:62676 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S268141AbTBYNFh>; Tue, 25 Feb 2003 08:05:37 -0500
Date: Tue, 25 Feb 2003 14:15:46 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: chas@locutus.cmf.nrl.navy.mil
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.63: fore200e.c doesn't compile
Message-ID: <20030225131546.GL7685@fs.tum.de>
References: <Pine.LNX.4.44.0302241127050.13335-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302241127050.13335-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 11:32:07AM -0800, Linus Torvalds wrote:
>...
> Summary of changes from v2.5.62 to v2.5.63
> ============================================
>...
> <chas@locutus.cmf.nrl.navy.mil>:
>   o [ATM]: use sock timestamp
>...

This change broke the compilation of fore200e.c:

<--  snip  -->

  gcc -Wp,-MD,drivers/atm/.fore200e.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include  -g  
-DKBUILD_BASENAME=fore200e -DKBUILD_MODNAME=fore_200e -c -o 
drivers/atm/fore200e.o drivers/atm/fore200e.c
drivers/atm/fore200e.c: In function `fore200e_push_rpd':
drivers/atm/fore200e.c:1135: structure has no member named `timestamp'
drivers/atm/fore200e.c:1136: structure has no member named `timestamp'
make[2]: *** [drivers/atm/fore200e.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

