Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292150AbSBTTg2>; Wed, 20 Feb 2002 14:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292229AbSBTTgS>; Wed, 20 Feb 2002 14:36:18 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:24078 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S292150AbSBTTgH>; Wed, 20 Feb 2002 14:36:07 -0500
Date: Wed, 20 Feb 2002 20:36:00 +0100
From: Jurriaan on Alpha <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.5 compile on alpha bombs
Message-ID: <20020220193600.GA24486@alpha.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure if it is meant to work, it being a development kernel and
all, but if anybody is interested:

ALPHA :make boot
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o scripts/split-include scripts/split-include.c
scripts/split-include include/linux/autoconf.h include/config
gcc -D__KERNEL__ -I/usr/src/linux-2.5.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasin
g -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6   -DKBUILD_BASENAME=main -c -o init/main.o init/main.c
In file included from /usr/src/linux-2.5.5/include/linux/pagemap.h:16,
                 from /usr/src/linux-2.5.5/include/linux/blkdev.h:9,
                 from /usr/src/linux-2.5.5/include/linux/blk.h:4,
                 from init/main.c:25:
/usr/src/linux-2.5.5/include/linux/highmem.h: In function `memclear_highpage_flush':
/usr/src/linux-2.5.5/include/linux/highmem.h:112: warning: implicit declaration of function `flush_dcache_page'
/usr/src/linux-2.5.5/include/linux/highmem.h:113: warning: implicit declaration of function `flush_page_to_ram'
. scripts/mkversion > .tmpversion
gcc -D__KERNEL__ -I/usr/src/linux-2.5.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasin
g -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6  -DUTS_MACHINE='"alpha"' -DKBUILD_BASENAME=version -c -o init/version
.o init/version.c
gcc -D__KERNEL__ -I/usr/src/linux-2.5.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasin
g -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6   -c -o init/do_mounts.o init/do_mounts.c
In file included from /usr/src/linux-2.5.5/include/linux/pagemap.h:16,
                 from /usr/src/linux-2.5.5/include/linux/blkdev.h:9,
                 from /usr/src/linux-2.5.5/include/linux/blk.h:4,
                 from init/do_mounts.c:9:
/usr/src/linux-2.5.5/include/linux/highmem.h: In function `memclear_highpage_flush':
/usr/src/linux-2.5.5/include/linux/highmem.h:112: warning: implicit declaration of function `flush_dcache_page'
/usr/src/linux-2.5.5/include/linux/highmem.h:113: warning: implicit declaration of function `flush_page_to_ram'
init/do_mounts.c: At top level:
init/do_mounts.c:958: warning: `crd_load' defined but not used
make CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.5.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-stric
t-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6 " -C  kernel
make[1]: Entering directory `/usr/src/linux-2.5.5/kernel'
make all_targets
make[2]: Entering directory `/usr/src/linux-2.5.5/kernel'
gcc -D__KERNEL__ -I/usr/src/linux-2.5.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasin
g -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6   -DKBUILD_BASENAME=sched  -fno-omit-frame-pointer -c -o sched.o sche
d.c
In file included from sched.c:22:
/usr/src/linux-2.5.5/include/asm/mmu_context.h:32: #error update this function.
sched.c:440: macro `switch_to' used with only 2 args
In file included from sched.c:24:
/usr/src/linux-2.5.5/include/linux/highmem.h: In function `memclear_highpage_flush':
/usr/src/linux-2.5.5/include/linux/highmem.h:112: warning: implicit declaration of function `flush_dcache_page'
/usr/src/linux-2.5.5/include/linux/highmem.h:113: warning: implicit declaration of function `flush_page_to_ram'
sched.c: In function `context_switch':
sched.c:440: parse error before `)'
make[2]: *** [sched.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.5/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.5/kernel'
make: *** [_dir_kernel] Error 2
ALPHA :

Jurriaan
-- 
Lack of skill dictates economy of style.
	Joey Ramone
GNU/Linux 2.4.18-rc1 on Debian/Alpha 988 bogomips 5 users load:0.00 0.09 0.21
