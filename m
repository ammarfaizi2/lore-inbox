Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132860AbRA3XC2>; Tue, 30 Jan 2001 18:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132893AbRA3XCT>; Tue, 30 Jan 2001 18:02:19 -0500
Received: from acaxp1.physik.rwth-aachen.de ([137.226.32.200]:32265 "EHLO
	acaxp.physik.rwth-aachen.de") by vger.kernel.org with ESMTP
	id <S132860AbRA3XCA>; Tue, 30 Jan 2001 18:02:00 -0500
Message-ID: <3A7747DC.EE3BBF7@physik.rwth-aachen.de>
Date: Wed, 31 Jan 2001 00:01:48 +0100
From: Arno Heister <heister@physik.rwth-aachen.de>
Reply-To: Arno.Heister@cern.ch
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: can't compile kernel 2.4.1 with Athlon/K7 option
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !
I had a similar problem also for the 2.4.0-test10 kernel ... if I switch
from the standard settings in the .config file and change only the
processor type to Athlon/K7 compilation fails .... and I waited for a
newer kernel ...

I'm using a RedHat 7.0 distribution (with all available updates and
bugfixes for this version).

Actually I'm running a 2.4.0-test11 kernel ... with processor type
Athlon/K7 etc. and everything works (compiles) fine ...

ith the newest kernel 2.4.1 I have these errors:

1.
make dep  (ended with no errors)

2.
[root@home linux]# make boot
scripts/split-include include/linux/autoconf.h include/config
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=athlon    -c -o init/main.o
init/main.c
In file included from /usr/src/linux/include/linux/irq.h:58,
                 from /usr/src/linux/include/asm/hardirq.h:7,
                 from /usr/src/linux/include/linux/interrupt.h:46,
                 from /usr/src/linux/include/asm/string.h:297,
                 from /usr/src/linux/include/linux/string.h:22,
                 from /usr/src/linux/include/linux/fs.h:24,
                 from /usr/src/linux/include/linux/capability.h:18,
                 from /usr/src/linux/include/linux/binfmts.h:6,
                 from /usr/src/linux/include/linux/sched.h:10,
                 from /usr/src/linux/include/linux/mm.h:5,
                 from /usr/src/linux/include/linux/slab.h:15,
                 from /usr/src/linux/include/linux/malloc.h:5,
                 from /usr/src/linux/include/linux/proc_fs.h:6,
                 from init/main.c:16:
/usr/src/linux/include/asm/hw_irq.h: In function `x86_do_profile':
/usr/src/linux/include/asm/hw_irq.h:198: `current' undeclared (first use
in this
 function)
/usr/src/linux/include/asm/hw_irq.h:198: (Each undeclared identifier is
reported
 only once
/usr/src/linux/include/asm/hw_irq.h:198: for each function it appears
in.)
In file included from /usr/src/linux/include/asm/string.h:297,
                 from /usr/src/linux/include/linux/string.h:22,
                 from /usr/src/linux/include/linux/fs.h:24,
                 from /usr/src/linux/include/linux/capability.h:18,
                 from /usr/src/linux/include/linux/binfmts.h:6,
                 from /usr/src/linux/include/linux/sched.h:10,
                 from /usr/src/linux/include/linux/mm.h:5,
                 from /usr/src/linux/include/linux/slab.h:15,
                 from /usr/src/linux/include/linux/malloc.h:5,
                 from /usr/src/linux/include/linux/proc_fs.h:6,
                 from init/main.c:16:
/usr/src/linux/include/linux/interrupt.h: In function `raise_softirq':
/usr/src/linux/include/linux/interrupt.h:89: `current' undeclared (first
use in
this function)
/usr/src/linux/include/linux/interrupt.h: In function
`tasklet_schedule':
/usr/src/linux/include/linux/interrupt.h:160: `current' undeclared
(first use in
 this function)
/usr/src/linux/include/linux/interrupt.h: In function
`tasklet_hi_schedule':
/usr/src/linux/include/linux/interrupt.h:174: `current' undeclared
(first use in
 this function)
In file included from /usr/src/linux/include/linux/string.h:22,
                 from /usr/src/linux/include/linux/fs.h:24,
                 from /usr/src/linux/include/linux/capability.h:18,
                 from /usr/src/linux/include/linux/binfmts.h:6,
                 from /usr/src/linux/include/linux/sched.h:10,
                from /usr/src/linux/include/linux/mm.h:5,
                 from /usr/src/linux/include/linux/slab.h:15,
                 from /usr/src/linux/include/linux/malloc.h:5,
                 from /usr/src/linux/include/linux/proc_fs.h:6,
                 from init/main.c:16:
/usr/src/linux/include/asm/string.h: In function `__constant_memcpy3d':
/usr/src/linux/include/asm/string.h:305: `current' undeclared (first use
in this
 function)
/usr/src/linux/include/asm/string.h: In function `__memcpy3d':
/usr/src/linux/include/asm/string.h:312: `current' undeclared (first use
in this
 function)
In file included from /usr/src/linux/include/linux/raid/md.h:51,
                 from init/main.c:25:
/usr/src/linux/include/linux/raid/md_k.h: In function `pers_to_level':
/usr/src/linux/include/linux/raid/md_k.h:39: warning: control reaches
end of non
-void function
make: *** [init/main.o] Error 1
[root@home linux]#


Should I wait again for newer kernel versions ??

Thanks in advance, Arno Heister.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
