Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267466AbTAQJu2>; Fri, 17 Jan 2003 04:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267469AbTAQJu2>; Fri, 17 Jan 2003 04:50:28 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:14793 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267466AbTAQJu1>; Fri, 17 Jan 2003 04:50:27 -0500
Date: Fri, 17 Jan 2003 10:59:21 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Marc Zyngier <mzyngier@freesurf.fr>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.59
Message-ID: <20030117095921.GW2333@fs.tum.de>
References: <Pine.LNX.4.44.0301161826430.8879-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301161826430.8879-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2003 at 06:28:03PM -0800, Linus Torvalds wrote:

>...
> Summary of changes from v2.5.58 to v2.5.59
> ============================================
>...
> Marc Zyngier <mzyngier@freesurf.fr>:
>...
>   o EISA sysfs updates to 3c509 and 3c59x drivers
>...

This change browke the compilation of 3c509 with CONFIG_PM:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/net/.3c509.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=3c509 -DKBUILD_MODNAME=3c509   -c -o 
drivers/net/3c509.o drivers/net/3c509.c
drivers/net/3c509.c: In function `el3_common_init':
drivers/net/3c509.c:324: `card_idx' undeclared (first use in this function)
drivers/net/3c509.c:324: (Each undeclared identifier is reported only once
drivers/net/3c509.c:324: for each function it appears in.)
drivers/net/3c509.c: In function `el3_probe':
drivers/net/3c509.c:360: warning: `dev' might be used uninitialized in this function
drivers/net/3c509.c: At top level:
drivers/net/3c509.c:268: warning: `nopnp' defined but not used
make[2]: *** [drivers/net/3c509.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

