Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136186AbRD0Tdv>; Fri, 27 Apr 2001 15:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136191AbRD0Tdm>; Fri, 27 Apr 2001 15:33:42 -0400
Received: from pc-62-30-139-56-nm.blueyonder.co.uk ([62.30.139.56]:54788 "EHLO
	gate.leinster") by vger.kernel.org with ESMTP id <S136186AbRD0TdX>;
	Fri, 27 Apr 2001 15:33:23 -0400
Date: Fri, 27 Apr 2001 23:33:26 +0100 (BST)
From: Shaw Carruthers <shaw@shawc.freeserve.co.uk>
To: lkml <linux-kernel@vger.kernel.org>
Subject: sched.h problem with kernel 2.4.3
Message-ID: <Pine.LNX.4.05.10104272324230.496-100000@leaf.leinster>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have just tried to upgrade to kernel 2.4.3 and my home grown modules
won't compile e.g:

The offending line 27 is:

#include <linux/sched.h>

Could some kind kernel guru point to a source which explains the error of
my ways?


In file included from lm78.c:13:
/usr/src/linux/include/linux/kernel.h:71: parse error before `int'
/usr/src/linux/include/linux/mount.h: In function `mntput':
In file included from /usr/src/linux/include/linux/dcache.h:7,
                 from /usr/src/linux/include/linux/fs.h:19,
                 from /usr/src/linux/include/linux/capability.h:17,
                 from /usr/src/linux/include/linux/binfmts.h:5,
                 from /usr/src/linux/include/linux/sched.h:9,
                 from lm78.c:27:
/usr/src/linux/include/linux/mount.h:46: warning: implicit declaration of function `printk_R1b7d4074'
/usr/src/linux/include/asm/semaphore.h: At top level:
In file included from /usr/src/linux/include/linux/fs.h:199,
                 from /usr/src/linux/include/linux/capability.h:17,
                 from /usr/src/linux/include/linux/binfmts.h:5,
                 from /usr/src/linux/include/linux/sched.h:9,
                 from lm78.c:27:
/usr/src/linux/include/asm/semaphore.h:99: parse error before `void'
/usr/src/linux/include/asm/semaphore.h:100: parse error before `int'
/usr/src/linux/include/asm/semaphore.h:101: parse error before `int'
/usr/src/linux/include/asm/semaphore.h:102: parse error before `void'
/usr/src/linux/include/asm/semaphore.h:104: parse error before `void'
/usr/src/linux/include/asm/semaphore.h:105: parse error before `int'
/usr/src/linux/include/asm/semaphore.h:106: parse error before `int'
/usr/src/linux/include/asm/semaphore.h:107: parse error before `void'
In file included from /usr/src/linux/include/linux/capability.h:17,
                 from /usr/src/linux/include/linux/binfmts.h:5,
                 from /usr/src/linux/include/linux/sched.h:9,
                 from lm78.c:27:
/usr/src/linux/include/linux/fs.h:962: parse error before `long'
/usr/src/linux/include/linux/fs.h:963: parse error before `long'
In file included from /usr/src/linux/include/linux/sched.h:10,
                 from lm78.c:27:
/usr/src/linux/include/linux/personality.h:66: parse error before `long'
In file included from /usr/src/linux/include/linux/sched.h:25,
                 from lm78.c:27:
/usr/src/linux/include/linux/sem.h:124: parse error before `long'
/usr/src/linux/include/linux/sem.h:125: parse error before `long'
/usr/src/linux/include/linux/sem.h:126: parse error before `long'
In file included from lm78.c:27:
/usr/src/linux/include/linux/sched.h:152: parse error before `void'
/usr/src/linux/include/linux/sched.h:569: parse error before `long'
/usr/src/linux/include/linux/vmalloc.h: In function `vmalloc':
In file included from /usr/src/linux/include/asm/io.h:108,
                 from lm78.c:31:
/usr/src/linux/include/linux/vmalloc.h:35: `boot_cpu_data_R0657d037' undeclared (first use this function)
/usr/src/linux/include/linux/vmalloc.h:35: (Each undeclared identifier is reported only once
/usr/src/linux/include/linux/vmalloc.h:35: for each function it appears in.)
/usr/src/linux/include/linux/vmalloc.h: In function `vmalloc_dma':
/usr/src/linux/include/linux/vmalloc.h:44: `boot_cpu_data_R0657d037' undeclared (first use this function)
/usr/src/linux/include/linux/vmalloc.h: In function `vmalloc_32':
/usr/src/linux/include/linux/vmalloc.h:53: `boot_cpu_data_R0657d037' undeclared (first use this function)
lm78.c: At top level:
lm78.c:49: warning: initialization from incompatible pointer type
lm78.c: In function `lm78_get_info':
lm78.c:68: warning: implicit declaration of function `sprintf_R3c2c5af5'
lm78.c: In function `init_module':
lm78.c:156: warning: implicit declaration of function `proc_register'
lm78.c: In function `cleanup_module':
lm78.c:195: warning: implicit declaration of function `proc_unregister'
make: *** [lm78.o] Error 1

-- 
Shaw Carruthers - shaw@shawc.freeserve.co.uk
London SW14 7JW UK
This is not a sig( with homage to Magritte).
  

