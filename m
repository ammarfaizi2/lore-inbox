Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292589AbSB0Svo>; Wed, 27 Feb 2002 13:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292891AbSB0Sv1>; Wed, 27 Feb 2002 13:51:27 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:54540 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S292889AbSB0SvP>; Wed, 27 Feb 2002 13:51:15 -0500
Date: Wed, 27 Feb 2002 19:51:04 +0100
From: Jurriaan on Alpha <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: compiling 2.5.6pre1 on Alpha bombs
Message-ID: <20020227185104.GB17359@alpha.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ALPHA :make boot
gcc -D__KERNEL__ -I/usr/src/linux-2.5.6pre1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6   -DKBUILD_BASENAME=main -c -o init/main.o init/main.c
In file included from /usr/src/linux-2.5.6pre1/include/linux/pagemap.h:16,
                 from /usr/src/linux-2.5.6pre1/include/linux/blkdev.h:9,
                 from /usr/src/linux-2.5.6pre1/include/linux/blk.h:4,
                 from init/main.c:25:
/usr/src/linux-2.5.6pre1/include/linux/highmem.h: In function `memclear_highpage_flush':
/usr/src/linux-2.5.6pre1/include/linux/highmem.h:112: warning: implicit declaration of function `flush_dcache_page'
/usr/src/linux-2.5.6pre1/include/linux/highmem.h:113: warning: implicit declaration of function `flush_page_to_ram'
. scripts/mkversion > .tmpversion

<these warnings continue for a while, snipped>

make[3]: Entering directory `/usr/src/linux-2.5.6pre1/drivers/md'
gcc -D__KERNEL__ -I/usr/src/linux-2.5.6pre1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6   -DKBUILD_BASENAME=raid5  -c -o raid5.o raid5.c
In file included from /usr/src/linux-2.5.6pre1/include/linux/pagemap.h:16,
                 from /usr/src/linux-2.5.6pre1/include/linux/locks.h:8,
                 from raid5.c:21:
/usr/src/linux-2.5.6pre1/include/linux/highmem.h: In function `memclear_highpage_flush':
/usr/src/linux-2.5.6pre1/include/linux/highmem.h:112: warning: implicit declaration of function `flush_dcache_page'
/usr/src/linux-2.5.6pre1/include/linux/highmem.h:113: warning: implicit declaration of function `flush_page_to_ram'
In file included from raid5.c:23:
/usr/src/linux-2.5.6pre1/include/linux/raid/raid5.h: At top level:
/usr/src/linux-2.5.6pre1/include/linux/raid/raid5.h:218: parse error before `md_wait_queue_head_t'
/usr/src/linux-2.5.6pre1/include/linux/raid/raid5.h:218: warning: no semicolon at end of struct or union
/usr/src/linux-2.5.6pre1/include/linux/raid/raid5.h:222: parse error before `device_lock'
/usr/src/linux-2.5.6pre1/include/linux/raid/raid5.h:222: warning: type defaults to `int' in declaration of `device_lock'
/usr/src/linux-2.5.6pre1/include/linux/raid/raid5.h:222: warning: data definition has no type or storage class
/usr/src/linux-2.5.6pre1/include/linux/raid/raid5.h:226: parse error before `}'
raid5.c: In function `__release_stripe':
raid5.c:67: dereferencing pointer to incomplete type
raid5.c:71: dereferencing pointer to incomplete type
raid5.c:73: dereferencing pointer to incomplete type
raid5.c:74: dereferencing pointer to incomplete type

<lots of the same warnings removed, in almost every line>
<in the following lines, lots of duplicate warnings have>
<been removed>

raid5.c:329: warning: implicit declaration of function `md_spin_unlock_irq'
raid5.c:453: warning: implicit declaration of function `md_spin_lock_irqsave'
raid5.c:459: warning: implicit declaration of function `md_spin_unlock_irqrestore'
raid5.c:490: warning: value computed is not used
raid5.c:485: warning: `disk' might be used uninitialized in this function
raid5.c:584: warning: unreachable code at beginning of switch statement
raid5.c:712: structure has no member named `b_reqnext'
raid5.c:1145: structure has no member named `b_rdev'
raid5.c:1146: structure has no member named `b_rsector'
raid5.c:1147: warning: passing arg 1 of `generic_make_request' makes pointer from integer without a cast
raid5.c:1147: too many arguments to function `generic_make_request'
raid5.c:850: warning: `rbh2' might be used uninitialized in this function
raid5.c:929: warning: `wbh2' might be used uninitialized in this function
raid5.c:1370: warning: implicit declaration of function `md__get_free_pages'
raid5.c:1370: warning: cast to pointer from integer of different size
raid5.c:1374: `MD_SPIN_LOCK_UNLOCKED' undeclared (first use in this function)
raid5.c:1374: (Each undeclared identifier is reported only once
raid5.c:1374: for each function it appears in.)
raid5.c:1375: warning: implicit declaration of function `md_init_waitqueue_head'
raid5.c:1719: warning: `i' might be used uninitialized in this function
raid5.c:1721: warning: `tmp' might be used uninitialized in this function
raid5.c:1721: warning: `sdisk' might be used uninitialized in this function
raid5.c:1721: warning: `adisk' might be used uninitialized in this function
raid5.c:1993: warning: initialization from incompatible pointer type
raid5.c:2002: warning: initialization from incompatible pointer type
raid5.c:2004: parse error before `raid5_init'
raid5.c:2005: warning: return-type defaults to `int'
make[3]: *** [raid5.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.6pre1/drivers/md'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.6pre1/drivers/md'
make[1]: *** [_subdir_md] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.6pre1/drivers'
make: *** [_dir_drivers] Error 2
ALPHA :

I just provide this as a data-point for interested parties :-)

Good luck,
Jurriaan
-- 
'Yeah,' said Hazel. 'Apparently being utterly destroyed by point-
blank disrupter cannon was only a temporary setback.'
	Simon R Green - Deathstalker Destiny
GNU/Linux 2.4.19pre1 on Debian/Alpha 990 bogomips load:1.15 0.86 0.53
