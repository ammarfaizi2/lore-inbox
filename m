Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266322AbTAKJfE>; Sat, 11 Jan 2003 04:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266379AbTAKJfE>; Sat, 11 Jan 2003 04:35:04 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:20187 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266322AbTAKJfD>; Sat, 11 Jan 2003 04:35:03 -0500
Date: Sat, 11 Jan 2003 10:43:45 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.56
Message-ID: <20030111094345.GI10486@fs.tum.de>
References: <Pine.LNX.4.44.0301101222510.1856-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301101222510.1856-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 12:26:56PM -0800, Linus Torvalds wrote:

>...
> Summary of changes from v2.5.55 to v2.5.56
> ============================================
>...
> Dave Jones <davej@codemonkey.org.uk>:
>...
>   o [WATCHDOG] Add several new watchdog drivers from 2.4
>...

FYI:

drivers/char/watchdog/sc1200wdt.c doesn't compile:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/char/watchdog/.sc1200wdt.o.d -D__KERNEL__ 
-Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6 -Iinclude/asm-i386/mach-default 
-nostdinc -iwithprefix include    -DKBUILD_BASENAME=sc1200wdt 
-DKBUILD_MODNAME=sc1200wdt   -c -o drivers/char/watchdog/sc1200wdt.o 
drivers/char/watchdog/sc1200wdt.c
drivers/char/watchdog/sc1200wdt.c: In function `sc1200wdt_isapnp_probe':
drivers/char/watchdog/sc1200wdt.c:339: warning: implicit declaration of function `isapnp_find_dev'
drivers/char/watchdog/sc1200wdt.c:339: warning: assignment makes pointer from integer without a cast
drivers/char/watchdog/sc1200wdt.c:343: structure has no member named `prepare'
drivers/char/watchdog/sc1200wdt.c:353: structure has no member named `activate'
drivers/char/watchdog/sc1200wdt.c: In function `sc1200wdt_init':
drivers/char/watchdog/sc1200wdt.c:427: structure has no member named `deactivate'
drivers/char/watchdog/sc1200wdt.c: In function `sc1200wdt_exit':
drivers/char/watchdog/sc1200wdt.c:440: structure has no member named `deactivate'
make[3]: *** [drivers/char/watchdog/sc1200wdt.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

