Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129225AbRBNAMh>; Tue, 13 Feb 2001 19:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129784AbRBNAM1>; Tue, 13 Feb 2001 19:12:27 -0500
Received: from snowbird.megapath.net ([216.200.176.7]:11017 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S129225AbRBNAMN>;
	Tue, 13 Feb 2001 19:12:13 -0500
Message-ID: <3A89CDDC.1000909@megapathdsl.net>
Date: Tue, 13 Feb 2001 16:14:20 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-pre2 i686; en-US; 0.8) Gecko/20010212
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.1-ac12 -- SMP build for Athlon still broken -- hw_irq.h:198: `current' undeclared
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i686 
-malign-functions=4    -c -o init/main.o init/main.c
/usr/src/linux/include/asm/hw_irq.h: In function `x86_do_profile':
In file included from /usr/src/linux/include/linux/irq.h:57,
                  from /usr/src/linux/include/asm/hardirq.h:6,
                  from /usr/src/linux/include/linux/interrupt.h:45,
                  from /usr/src/linux/include/asm/string.h:296,
                  from /usr/src/linux/include/linux/string.h:25,
                  from /usr/src/linux/include/linux/fs.h:23,
                  from /usr/src/linux/include/linux/capability.h:17,
                  from /usr/src/linux/include/linux/binfmts.h:5,
                  from /usr/src/linux/include/linux/sched.h:9,
                  from /usr/src/linux/include/linux/mm.h:4,
                  from /usr/src/linux/include/linux/slab.h:14,
                  from /usr/src/linux/include/linux/proc_fs.h:5,
                  from init/main.c:15:
/usr/src/linux/include/asm/hw_irq.h:198: `current' undeclared (first use 
in this function)
/usr/src/linux/include/asm/hw_irq.h:198: (Each undeclared identifier is 
reported only once
/usr/src/linux/include/asm/hw_irq.h:198: for each function it appears in.)
/usr/src/linux/include/linux/interrupt.h: In function `raise_softirq':
In file included from /usr/src/linux/include/asm/string.h:296,
                  from /usr/src/linux/include/linux/string.h:25,
                  from /usr/src/linux/include/linux/fs.h:23,
                  from /usr/src/linux/include/linux/capability.h:17,
                  from /usr/src/linux/include/linux/binfmts.h:5,
                  from /usr/src/linux/include/linux/sched.h:9,
                  from /usr/src/linux/include/linux/mm.h:4,
                  from /usr/src/linux/include/linux/slab.h:14,
                  from /usr/src/linux/include/linux/proc_fs.h:5,
                  from init/main.c:15:
/usr/src/linux/include/linux/interrupt.h:89: `current' undeclared (first 
use in this function)
/usr/src/linux/include/linux/interrupt.h: In function `tasklet_schedule':
/usr/src/linux/include/linux/interrupt.h:160: `current' undeclared 
(first use in this function)
/usr/src/linux/include/linux/interrupt.h: In function `tasklet_hi_schedule':
/usr/src/linux/include/linux/interrupt.h:174: `current' undeclared 
(first use in this function)
/usr/src/linux/include/asm/string.h: In function `__constant_memcpy3d':
In file included from /usr/src/linux/include/linux/string.h:25,
                  from /usr/src/linux/include/linux/fs.h:23,
                  from /usr/src/linux/include/linux/capability.h:17,
                  from /usr/src/linux/include/linux/binfmts.h:5,
                  from /usr/src/linux/include/linux/sched.h:9,
                  from /usr/src/linux/include/linux/mm.h:4,
                  from /usr/src/linux/include/linux/slab.h:14,
                  from /usr/src/linux/include/linux/proc_fs.h:5,
                  from init/main.c:15:
/usr/src/linux/include/asm/string.h:305: `current' undeclared (first use 
in this function)
/usr/src/linux/include/asm/string.h: In function `__memcpy3d':
/usr/src/linux/include/asm/string.h:312: `current' undeclared (first use 
in this function)
make: *** [init/main.o] Error 1

