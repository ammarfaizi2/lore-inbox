Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbQLCL1S>; Sun, 3 Dec 2000 06:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129761AbQLCL1I>; Sun, 3 Dec 2000 06:27:08 -0500
Received: from nat-40.kulnet.kuleuven.ac.be ([134.58.0.40]:40908 "EHLO
	maui.kotnet.org") by vger.kernel.org with ESMTP id <S129733AbQLCL0x>;
	Sun, 3 Dec 2000 06:26:53 -0500
Date: Sun, 3 Dec 2000 11:56:32 +0100 (CET)
From: Frederik Vanrenterghem <frederik@maui.kotnet.org>
To: linux-kernel@vger.kernel.org
Subject: Problems building test10 or test11 with AMD Duron CPU
Message-ID: <Pine.LNX.4.21.0012031150440.15304-100000@maui.kotnet.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been unable to build kernel 2.4.0test10 or test 11 on my new system,
which has an Asus A7V mb and a AMD Duron 700 CPU, running Debian Woody
(gcc 2.95.2). If I select as CPU: Athlon/K7, building the kernel fails. If
I choose PPro, the kernel builds fine, and I can use it.
Is this normal behaviour? I would expect to be able to build a kernel on
this system with Athlon/K7 optimisations, since a Duron is from the same
line of CPU's, or is that incorrect?

Error messages:

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
/usr/src/linux/include/asm/hw_irq.h:198: for each function it appears in.)
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
/usr/src/linux/include/asm/hw_irq.h: In function `x86_do_profile':
/usr/src/linux/include/asm/hw_irq.h:198: `current' undeclared (first use
in this function)
/usr/src/linux/include/asm/hw_irq.h:198: (Each undeclared identifier is
reported only once
/usr/src/linux/include/asm/hw_irq.h:198: for each function it appears in.)
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
/usr/src/linux/include/linux/interrupt.h: In function `tasklet_schedule':
/usr/src/linux/include/linux/interrupt.h:160: `current' undeclared (first
use in this function)
/usr/src/linux/include/linux/interrupt.h: In function
`tasklet_hi_schedule':
/usr/src/linux/include/linux/interrupt.h:174: `current' undeclared (first
use in this function)
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
make[1]: *** [init/main.o] Error 1
make[1]: Leaving directory `/usr/src/linux'
make: *** [stamp-build] Error 2


-- 

Gold coast slave ship bound for cotton fields
Sold in a market down in New Orleans
Scarred old slaver knows he's doing alright
Hear him whip the women, just around midnight

Ah, brown sugar how come you taste so good?
Ah, brown sugar just like a young girl should

Drums beating cold English blood runs hot
Lady of the house wonderin' where it's gonna stop
House boy knows that he's doing alright
You should a heard him just around midnight.
...
I bet your mama was tent show queen
And all her girlfriends were sweet sixteen
I'm no school boy but I know what I like
You should have heard me just around midnight.
		-- Rolling Stones, "Brown Sugar"

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
