Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274396AbRITJ44>; Thu, 20 Sep 2001 05:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274397AbRITJ4r>; Thu, 20 Sep 2001 05:56:47 -0400
Received: from prfdec.natur.cuni.cz ([195.113.56.1]:39180 "EHLO
	prfdec.natur.cuni.cz") by vger.kernel.org with ESMTP
	id <S274396AbRITJ4n>; Thu, 20 Sep 2001 05:56:43 -0400
X-Envelope-From: mmokrejs
Posted-Date: Thu, 20 Sep 2001 11:57:03 +0200 (MET DST)
Date: Thu, 20 Sep 2001 11:57:02 +0200 (MET DST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: Shane Wegner <shane@cm.nu>
cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Cannot compile 2.4.10pre12aa1 with 2.95.2 on Debian
In-Reply-To: <20010919193128.A8650@cm.nu>
Message-ID: <Pine.OSF.4.21.0109201149110.3983-100000@prfdec.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  first of all, thanks to Andrea. I had a bit hard time to find sources of
his kernel-patches.

Note to the FAQ maintainer: there isn't mentioned the source for -ac and
-aa kernels.

  I found that I need 2.4.9 patched to -pre12 and patched afterwards with 
http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.10pre12aa1.bz2


  Using my old configuration for kernel I get after "make dep; make bzImage"

gcc -D__KERNEL__ -I/usr/src/linux-2.4.10-pre12/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686   -c -o init/main.o init/main.c
In file included from /usr/src/linux-2.4.10-pre12/linux/include/linux/mm.h:4,
                 from /usr/src/linux-2.4.10-pre12/linux/include/linux/slab.h:14,
                 from /usr/src/linux-2.4.10-pre12/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux-2.4.10-pre12/linux/include/linux/sched.h:423: warning: `PF_USEDFPU' redefined
/usr/src/linux-2.4.10-pre12/linux/include/linux/sched.h:421: warning: this is the location of the previous definition
. scripts/mkversion > .version
gcc -D__KERNEL__ -I/usr/src/linux-2.4.10-pre12/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -DUTS_MACHINE='"i386"' -c -o init/version.o init/version.c
make CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.10-pre12/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 " -C  kernel
make[1]: Entering directory `/usr/src/linux-2.4.10-pre12/linux/kernel'
make all_targets
make[2]: Entering directory `/usr/src/linux-2.4.10-pre12/linux/kernel'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.10-pre12/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686    -fno-omit-frame-pointer -c -o sched.o sched.c
In file included from /usr/src/linux-2.4.10-pre12/linux/include/linux/mm.h:4,
                 from sched.c:24:
/usr/src/linux-2.4.10-pre12/linux/include/linux/sched.h:423: warning: `PF_USEDFPU' redefined
/usr/src/linux-2.4.10-pre12/linux/include/linux/sched.h:421: warning: this is the location of the previous definition
sched.c: In function `reschedule_idle':
sched.c:234: warning: `oldest_idle' might be used uninitialized in this function
sched.c: In function `sys_sched_yield':
sched.c:1130: warning: control reaches end of non-void function
sched.c: At top level:
sched.c:1135: parse error before `if'
sched.c:1142: parse error before `->'
make[2]: *** [sched.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.10-pre12/linux/kernel'

 Note to Andrea, while you mention in your post to linux-kernel list
Changelog of your kernel relase, you do not mention for newbies like me se
source site and maybe "How to apply" would help also. ;) 

Thanks for replies! ;-)
-- 
Martin Mokrejs - PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany

