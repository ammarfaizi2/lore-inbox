Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267084AbTBKQee>; Tue, 11 Feb 2003 11:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267035AbTBKQee>; Tue, 11 Feb 2003 11:34:34 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:64192 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267084AbTBKQed>; Tue, 11 Feb 2003 11:34:33 -0500
Date: Tue, 11 Feb 2003 17:44:14 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Pablo Menichini <pablo@menichini.com.ar>,
       Rusty Russell <rusty@rustcorp.com.au>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.60: arlan.c no longer compiles
Message-ID: <20030211164414.GN17128@fs.tum.de>
References: <Pine.LNX.4.44.0302101103570.1348-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302101103570.1348-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 11:08:28AM -0800, Linus Torvalds wrote:
>...
> Summary of changes from v2.5.59 to v2.5.60
> ============================================
>...
> Rusty Russell <rusty@rustcorp.com.au>:
>...
>   o Memory leak in drivers_net_arlan.c (1)
>...

This change broke the compilation of arlan.c:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/net/.arlan.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=arlan -DKBUILD_MODNAME=arlan -c -o drivers/net/arlan.o 
drivers/net/arlan.c
drivers/net/arlan.c: In function `arlan_allocate_device':
drivers/net/arlan.c:1202: structure has no member named `config'
drivers/net/arlan.c:1212: structure has no member named `config'
drivers/net/arlan.c: At top level:
drivers/net/arlan.c:26: warning: `probe' defined but not used
drivers/net/arlan.c:1128: warning: `arlan_find_devices' defined but not used
make[2]: *** [drivers/net/arlan.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

