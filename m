Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262693AbTCPRtf>; Sun, 16 Mar 2003 12:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262705AbTCPRtf>; Sun, 16 Mar 2003 12:49:35 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:24811 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262693AbTCPRte>; Sun, 16 Mar 2003 12:49:34 -0500
Date: Sun, 16 Mar 2003 19:00:20 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       chas@cmf.nrl.navy.mil, linux-atm-general@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.64-mm8: drivers/atm/idt77252.c doesn't compile
Message-ID: <20030316180020.GD10253@fs.tum.de>
References: <20030316024239.484f8bda.akpm@digeo.com> <20030316130211.GL24791@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030316130211.GL24791@fs.tum.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 16, 2003 at 02:02:11PM +0100, Adrian Bunk wrote:
> On Sun, Mar 16, 2003 at 02:42:39AM -0800, Andrew Morton wrote:
> >...
> > All 124 patches:
> > 
> > linus.patch
> >   Latest from Linus
> >...
> 
> The following problem seems to come from Linus' tree:
> 
> tx_inuse was removed from struct atm_vcc in include/linux/atmdev.h but 
> drivers/atm/idt77252.c still needs it:
>...

I got a third (and last since the kernel compilation is now finished) 
compile error:

<--  snip  -->

...
  gcc -Wp,-MD,net/sched/.sch_atm.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -g -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=sch_atm -DKBUILD_MODNAME=sch_atm -c -o 
net/sched/sch_atm.o net/sched/sch_atm.c
net/sched/sch_atm.c: In function `sch_atm_dequeue':
net/sched/sch_atm.c:511: structure has no member named `tx_inuse'
make[2]: *** [net/sched/sch_atm.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

