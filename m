Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261772AbTCGUw5>; Fri, 7 Mar 2003 15:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261771AbTCGUw5>; Fri, 7 Mar 2003 15:52:57 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:59073 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261773AbTCGUw4>; Fri, 7 Mar 2003 15:52:56 -0500
Date: Fri, 7 Mar 2003 22:03:23 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>, James Bottomley <james.bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.64-ac3: 3c527.c doesn't compile
Message-ID: <20030307210323.GD19615@fs.tum.de>
References: <200303071756.h27HuiY01551@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303071756.h27HuiY01551@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 12:56:44PM -0500, Alan Cox wrote:

>...
> Linux 2.5.64-ac2
>...
> o	Update 3c527 to modern locking (untested)	(James Bottomley)
>...

It seems even the compilation is untested?

<--  snip  -->

...
  gcc -Wp,-MD,drivers/net/.3c527.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=3c527 -DKBUILD_MODNAME=3c527 -c -o drivers/net/3c527.o 
drivers/net/3c527.c
In file included from include/linux/mca.h:132,
                 from drivers/net/3c527.c:95:
include/linux/mca-legacy.h:10: warning: #warning "MCA legacy - please 
move your driver to the new sysfs api"
drivers/net/3c527.c: In function `mc32_command':
drivers/net/3c527.c:649: `flags' undeclared (first use in this function)
drivers/net/3c527.c:649: (Each undeclared identifier is reported only once
drivers/net/3c527.c:649: for each function it appears in.)
drivers/net/3c527.c: In function `mc32_halt_transceiver':
drivers/net/3c527.c:733: `flags' undeclared (first use in this function)
drivers/net/3c527.c: In function `mc32_open':
drivers/net/3c527.c:951: `unsigned_long' undeclared (first use in this function)
drivers/net/3c527.c:951: parse error before `flags'
drivers/net/3c527.c:953: `flags' undeclared (first use in this function)
make[2]: *** [drivers/net/3c527.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

