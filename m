Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131018AbRAAAMt>; Sun, 31 Dec 2000 19:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131141AbRAAAMj>; Sun, 31 Dec 2000 19:12:39 -0500
Received: from adsl-64-164-24-146.dsl.snfc21.pacbell.net ([64.164.24.146]:9988
	"EHLO po.teletubbies.dhs.org") by vger.kernel.org with ESMTP
	id <S131018AbRAAAMZ>; Sun, 31 Dec 2000 19:12:25 -0500
Date: Sun, 31 Dec 2000 16:42:37 -0800 (PST)
From: Matt Wright <matt@teletubbies.dhs.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-testX fails to compile on my Athlon
Message-ID: <Pine.LNX.4.21.0012311635530.1649-100000@po.teletubbies.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've looked for answers to this question before, but all I could find was
someone asking a similar question and no replies...

I'm having great trouble getting 2.4.0-testX to compile on my system when
I select Athlon/K7 as the Processor Family....

I've attached below the error's I'm getting.... the kernel DOES compile if
I select anything else... but I don't have anything else :)

gcc version = 2.95.2
GNU Make version 3.79.1
GNU ld version 2.9.1 (with BFD 2.9.1.0.25)
fdformat from util-linux-2.10o
insmod version 2.3.21

I'd hope someone has an answer on how to fix this

Matt Wright


----------------------------------------------------------------------------
[root@dipsy linux]# make bzImage            
gcc -D__KERNEL__ -I/root/source/linux/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -c -o
init/main.o init/main.c
In file included from /root/source/linux/include/linux/irq.h:57,
                 from /root/source/linux/include/asm/hardirq.h:6,
                 from /root/source/linux/include/linux/interrupt.h:45,
                 from /root/source/linux/include/asm/string.h:296,
                 from /root/source/linux/include/linux/string.h:21,
                 from /root/source/linux/include/linux/fs.h:23,
                 from /root/source/linux/include/linux/capability.h:17,
                 from /root/source/linux/include/linux/binfmts.h:5,
                 from /root/source/linux/include/linux/sched.h:9,
                 from /root/source/linux/include/linux/mm.h:4,
                 from /root/source/linux/include/linux/slab.h:14,
                 from /root/source/linux/include/linux/malloc.h:4,
                 from /root/source/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/root/source/linux/include/asm/hw_irq.h: In function `x86_do_profile':
/root/source/linux/include/asm/hw_irq.h:198: `current' undeclared (first
use in this function)
/root/source/linux/include/asm/hw_irq.h:198: (Each undeclared identifier
is reported only once
/root/source/linux/include/asm/hw_irq.h:198: for each function it appears
in.)
In file included from /root/source/linux/include/asm/string.h:296,
                 from /root/source/linux/include/linux/string.h:21,
                 from /root/source/linux/include/linux/fs.h:23,
                 from /root/source/linux/include/linux/capability.h:17,
                 from /root/source/linux/include/linux/binfmts.h:5,
                 from /root/source/linux/include/linux/sched.h:9,
                 from /root/source/linux/include/linux/mm.h:4,
                 from /root/source/linux/include/linux/slab.h:14,
                 from /root/source/linux/include/linux/malloc.h:4,
                 from /root/source/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/root/source/linux/include/linux/interrupt.h: In function `raise_softirq':
/root/source/linux/include/linux/interrupt.h:89: `current' undeclared
(first use in this function)
/root/source/linux/include/linux/interrupt.h: In function
`tasklet_schedule':
/root/source/linux/include/linux/interrupt.h:160: `current' undeclared
(first use in this function)
/root/source/linux/include/linux/interrupt.h: In function
`tasklet_hi_schedule':/root/source/linux/include/linux/interrupt.h:174: `current'
undeclared (first use in this function)
In file included from /root/source/linux/include/linux/string.h:21,
                 from /root/source/linux/include/linux/fs.h:23,
                 from /root/source/linux/include/linux/capability.h:17,
                 from /root/source/linux/include/linux/binfmts.h:5,
                 from /root/source/linux/include/linux/sched.h:9,
                 from /root/source/linux/include/linux/mm.h:4,
                 from /root/source/linux/include/linux/slab.h:14,
                 from /root/source/linux/include/linux/malloc.h:4,
                 from /root/source/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/root/source/linux/include/asm/string.h: In function
`__constant_memcpy3d':
/root/source/linux/include/asm/string.h:305: `current' undeclared (first
use in this function)
/root/source/linux/include/asm/string.h: In function `__memcpy3d':
/root/source/linux/include/asm/string.h:312: `current' undeclared (first
use in this function)
make: *** [init/main.o] Error 1
[root@dipsy linux]# 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
