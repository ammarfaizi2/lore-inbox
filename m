Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267013AbSKSRAE>; Tue, 19 Nov 2002 12:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267010AbSKSRAE>; Tue, 19 Nov 2002 12:00:04 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8428 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267013AbSKSRAC>; Tue, 19 Nov 2002 12:00:02 -0500
Date: Tue, 19 Nov 2002 18:07:00 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-rc2-ac1
Message-ID: <20021119170659.GS11952@fs.tum.de>
References: <200211191619.gAJGJAc08042@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211191619.gAJGJAc08042@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:

hd.c still doesn't compile:

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-2.4.19-full/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6  -I../
-nostdinc -iwithprefix include -DKBUILD_BASENAME=hd  -c -o hd.o hd.c
hd.c:78: conflicting types for `recal_intr'
/home/bunk/linux/kernel-2.4/linux-2.4.19-full/include/linux/ide.h:1487:
previous declaration of `recal_intr'
hd.c: In function `dump_status':
hd.c:171: `QUEUE_EMPTY' undeclared (first use in this function)
hd.c:171: (Each undeclared identifier is reported only once
hd.c:171: for each function it appears in.)
hd.c:171: `CURRENT' undeclared (first use in this function)
hd.c:169: warning: `devc' might be used uninitialized in this function
...
make[4]: *** [hd.o] Error 1
make[4]: Leaving directory
`/home/bunk/linux/kernel-2.4/linux-2.4.19-full/drivers/ide/legacy'

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

