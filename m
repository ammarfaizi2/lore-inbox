Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263361AbTDCMDG>; Thu, 3 Apr 2003 07:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263362AbTDCMDG>; Thu, 3 Apr 2003 07:03:06 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:16618 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S263361AbTDCMDE>; Thu, 3 Apr 2003 07:03:04 -0500
Date: Thu, 3 Apr 2003 14:14:22 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@digeo.com>, chas@cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.66-mm3: drivers/atm/iphase.c doesn't compile
Message-ID: <20030403121422.GJ3693@fs.tum.de>
References: <20030403005817.69a29d7b.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030403005817.69a29d7b.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 12:58:17AM -0800, Andrew Morton wrote:
>...
> All 112 patches:
> 
> 
> linus.patch
>...

It seems the following compile error comes from Linus' tree:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/atm/.iphase.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include  -g  
-DKBUILD_BASENAME=iphase -DKBUILD_MODNAME=iphase -c -o 
drivers/atm/iphase.o drivers/atm/iphase.c
drivers/atm/iphase.c: In function `ia_pkt_tx':
drivers/atm/iphase.c:2979: `pad' undeclared (first use in this function)
drivers/atm/iphase.c:2979: (Each undeclared identifier is reported only once
drivers/atm/iphase.c:2979: for each function it appears in.)
make[2]: *** [drivers/atm/iphase.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

