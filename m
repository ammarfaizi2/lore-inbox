Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265727AbTABRJs>; Thu, 2 Jan 2003 12:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266115AbTABRJs>; Thu, 2 Jan 2003 12:09:48 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:9154 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265727AbTABRJq>; Thu, 2 Jan 2003 12:09:46 -0500
Date: Thu, 2 Jan 2003 18:18:04 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jaroslav Kysela <perex@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.54
Message-ID: <20030102171803.GQ6114@fs.tum.de>
References: <Pine.LNX.4.44.0301011935410.8506-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301011935410.8506-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2003 at 07:43:40PM -0800, Linus Torvalds wrote:

>...
> Summary of changes from v2.5.53 to v2.5.54
> ============================================
>...
> Jaroslav Kysela <perex@suse.cz>:
>   o PnP update
>...

FYI:

This change broke the compilation of drivers/ide/ide-pnp.c:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/ide/.ide-pnp.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=ide_pnp -DKBUILD_MODNAME=ide_pnp   -c -o 
drivers/ide/ide-pnp.o drivers/ide/ide-pnp.c
drivers/ide/ide-pnp.c: In function `pnpide_init':
drivers/ide/ide-pnp.c:117: structure has no member named `deactivate'
drivers/ide/ide-pnp.c:118: structure has no member named `deactivate'
drivers/ide/ide-pnp.c:124: warning: implicit declaration of function `isapnp_find_dev'
drivers/ide/ide-pnp.c:125: warning: assignment makes pointer from integer without a cast
drivers/ide/ide-pnp.c:127: structure has no member named `active'
drivers/ide/ide-pnp.c:130: structure has no member named `prepare'
drivers/ide/ide-pnp.c:130: structure has no member named `prepare'
drivers/ide/ide-pnp.c:135: structure has no member named `activate'
drivers/ide/ide-pnp.c:135: structure has no member named `activate'
drivers/ide/ide-pnp.c:142: structure has no member named `deactivate'
drivers/ide/ide-pnp.c:143: structure has no member named `deactivate'
make[2]: *** [drivers/ide/ide-pnp.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

