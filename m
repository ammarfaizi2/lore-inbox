Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135520AbRAGBzO>; Sat, 6 Jan 2001 20:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135545AbRAGBzE>; Sat, 6 Jan 2001 20:55:04 -0500
Received: from c-972d.020-11-6b73642.cust.bredbandsbolaget.se ([213.112.13.12]:12805
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S135520AbRAGByy>; Sat, 6 Jan 2001 20:54:54 -0500
Message-ID: <3A57D935.52C7F2C9@xpress.se>
Date: Sun, 07 Jan 2001 02:49:25 +0000
From: Johan Groth <jgroth@xpress.se>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-storm i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel compile trouble
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I wonder if anyone can help me with compilation of kernel 2.4.0. I've
run make mrproper; make menuconfig; make dep and then I try to build the
kernel with make bzImage but that fails utterly. I get the following
message:

tiger:/usr/src/linux# make bzImage
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -c -o
init/main.o init/main.c
In file included from /usr/src/linux/include/linux/irq.h:57,
                 from /usr/src/linux/include/asm/hardirq.h:6,
                 from /usr/src/linux/include/linux/interrupt.h:45,
                 from /usr/src/linux/include/asm/string.h:296,
                 from /usr/src/linux/include/linux/string.h:21,
                 from /usr/src/linux/include/linux/fs.h:23,
                 from /usr/src/linux/include/linux/capability.h:17,
                 from /usr/src/linux/include/linux/binfmts.h:5,
                 from /usr/src/linux/include/linux/sched.h:9,
                 from /usr/src/linux/include/linux/mm.h:4,
                 from /usr/src/linux/include/linux/slab.h:14,
                 from /usr/src/linux/include/linux/malloc.h:4,
                 from /usr/src/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux/include/asm/hw_irq.h: In function `x86_do_profile':
/usr/src/linux/include/asm/hw_irq.h:198: `current' undeclared (first use
in this function)
/usr/src/linux/include/asm/hw_irq.h:198: (Each undeclared identifier is
reported only once
/usr/src/linux/include/asm/hw_irq.h:198: for each function it appears
in.)
In file included from /usr/src/linux/include/asm/string.h:296,
                 from /usr/src/linux/include/linux/string.h:21,
                 from /usr/src/linux/include/linux/fs.h:23,
                 from /usr/src/linux/include/linux/capability.h:17,
                 from /usr/src/linux/include/linux/binfmts.h:5,
                 from /usr/src/linux/include/linux/sched.h:9,
                 from /usr/src/linux/include/linux/mm.h:4,
                 from /usr/src/linux/include/linux/slab.h:14,
                 from /usr/src/linux/include/linux/malloc.h:4,
                 from /usr/src/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux/include/linux/interrupt.h: In function `raise_softirq':
/usr/src/linux/include/linux/interrupt.h:89: `current' undeclared (first
use in this function)
/usr/src/linux/include/linux/interrupt.h: In function
`tasklet_schedule':
/usr/src/linux/include/linux/interrupt.h:160: `current' undeclared
(first use in this function)
/usr/src/linux/include/linux/interrupt.h: In function
`tasklet_hi_schedule':
/usr/src/linux/include/linux/interrupt.h:174: `current' undeclared
(first use in this function)
In file included from /usr/src/linux/include/linux/string.h:21,
                 from /usr/src/linux/include/linux/fs.h:23,
                 from /usr/src/linux/include/linux/capability.h:17,
                 from /usr/src/linux/include/linux/binfmts.h:5,
                 from /usr/src/linux/include/linux/sched.h:9,
                 from /usr/src/linux/include/linux/mm.h:4,
                 from /usr/src/linux/include/linux/slab.h:14,
                 from /usr/src/linux/include/linux/malloc.h:4,
                 from /usr/src/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux/include/asm/string.h: In function `__constant_memcpy3d':
/usr/src/linux/include/asm/string.h:305: `current' undeclared (first use
in this function)
/usr/src/linux/include/asm/string.h: In function `__memcpy3d':
/usr/src/linux/include/asm/string.h:312: `current' undeclared (first use
in this function)
make: *** [init/main.o] Error 1

I using Storm Linux 2000 Deluxe (based on Debian 2.2r2) if that has
anything to with it. I could compile the kernel under Red Hat but not
now.

TIA,
Johan

-- 
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
   "Better to ask questions and seem stupid
    than not to ask questions and remain stupid" -Unknown
           Johan Groth <jgroth@xpress.se> Kupolen Data
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
