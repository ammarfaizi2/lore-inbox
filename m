Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129744AbRAIMEu>; Tue, 9 Jan 2001 07:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129789AbRAIMEl>; Tue, 9 Jan 2001 07:04:41 -0500
Received: from pi4.informatik.uni-mannheim.de ([134.155.48.96]:35490 "EHLO
	pi4.informatik.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S129632AbRAIMEX>; Tue, 9 Jan 2001 07:04:23 -0500
From: Walter Mueller <walt@pi4.informatik.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14938.65088.590283.342@anaxagoras.informatik.uni-mannheim.de>
Date: Tue, 9 Jan 2001 13:04:16 +0100
To: linux-kernel@vger.kernel.org
Subject: Problem compiling linux-2.4.0 for Athlon/K7
X-Mailer: VM 6.89 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

if  Athlon/K7 is selected as processor type i get the following error
messages when compiling

make -C  kernel CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.x/linux-2.4.0/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.x/linux-2.4.0/include/linux/modversions.h" MAKING_MODULES=1 modules
make[1]: Entering directory `/usr/src/linux-2.4.x/linux-2.4.0/kernel'
make[1]: Nothing to be done for `modules'.
make[1]: Leaving directory `/usr/src/linux-2.4.x/linux-2.4.0/kernel'
make -C  drivers CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.x/linux-2.4.0/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.x/linux-2.4.0/include/linux/modversions.h" MAKING_MODULES=1 modules
make[1]: Entering directory `/usr/src/linux-2.4.x/linux-2.4.0/drivers'
make -C block modules
make[2]: Entering directory `/usr/src/linux-2.4.x/linux-2.4.0/drivers/block'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.x/linux-2.4.0/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.x/linux-2.4.0/include/linux/modversions.h   -DEXPORT_SYMTAB -c loop.c
In file included from /usr/src/linux-2.4.x/linux-2.4.0/include/linux/irq.h:57,
                 from /usr/src/linux-2.4.x/linux-2.4.0/include/asm/hardirq.h:6,
                 from /usr/src/linux-2.4.x/linux-2.4.0/include/linux/interrupt.h:45,
                 from /usr/src/linux-2.4.x/linux-2.4.0/include/asm/string.h:296,
                 from /usr/src/linux-2.4.x/linux-2.4.0/include/linux/string.h:21,
                 from /usr/src/linux-2.4.x/linux-2.4.0/include/linux/fs.h:23,
                 from /usr/src/linux-2.4.x/linux-2.4.0/include/linux/capability.h:17,
                 from /usr/src/linux-2.4.x/linux-2.4.0/include/linux/binfmts.h:5,
                 from /usr/src/linux-2.4.x/linux-2.4.0/include/linux/sched.h:9,
                 from loop.c:53:
/usr/src/linux-2.4.x/linux-2.4.0/include/asm/hw_irq.h: In function `x86_do_profile':
/usr/src/linux-2.4.x/linux-2.4.0/include/asm/hw_irq.h:198: `current' undeclared (first use in this function)
/usr/src/linux-2.4.x/linux-2.4.0/include/asm/hw_irq.h:198: (Each undeclared identifier is reported only once
/usr/src/linux-2.4.x/linux-2.4.0/include/asm/hw_irq.h:198: for each function it appears in.)
In file included from /usr/src/linux-2.4.x/linux-2.4.0/include/asm/string.h:296,
                 from /usr/src/linux-2.4.x/linux-2.4.0/include/linux/string.h:21,
                 from /usr/src/linux-2.4.x/linux-2.4.0/include/linux/fs.h:23,
                 from /usr/src/linux-2.4.x/linux-2.4.0/include/linux/capability.h:17,
                 from /usr/src/linux-2.4.x/linux-2.4.0/include/linux/binfmts.h:5,
                 from /usr/src/linux-2.4.x/linux-2.4.0/include/linux/sched.h:9,
                 from loop.c:53:
/usr/src/linux-2.4.x/linux-2.4.0/include/linux/interrupt.h: In function `raise_softirq':
/usr/src/linux-2.4.x/linux-2.4.0/include/linux/interrupt.h:89: `current' undeclared (first use in this function)
/usr/src/linux-2.4.x/linux-2.4.0/include/linux/interrupt.h: In function `tasklet_schedule':
/usr/src/linux-2.4.x/linux-2.4.0/include/linux/interrupt.h:160: `current' undeclared (first use in this function)
/usr/src/linux-2.4.x/linux-2.4.0/include/linux/interrupt.h: In function `tasklet_hi_schedule':
/usr/src/linux-2.4.x/linux-2.4.0/include/linux/interrupt.h:174: `current' undeclared (first use in this function)
In file included from /usr/src/linux-2.4.x/linux-2.4.0/include/linux/string.h:21,
                 from /usr/src/linux-2.4.x/linux-2.4.0/include/linux/fs.h:23,
                 from /usr/src/linux-2.4.x/linux-2.4.0/include/linux/capability.h:17,
                 from /usr/src/linux-2.4.x/linux-2.4.0/include/linux/binfmts.h:5,
                 from /usr/src/linux-2.4.x/linux-2.4.0/include/linux/sched.h:9,
                 from loop.c:53:
/usr/src/linux-2.4.x/linux-2.4.0/include/asm/string.h: In function `__constant_memcpy3d':
/usr/src/linux-2.4.x/linux-2.4.0/include/asm/string.h:305: `current' undeclared (first use in this function)
/usr/src/linux-2.4.x/linux-2.4.0/include/asm/string.h: In function `__memcpy3d':
/usr/src/linux-2.4.x/linux-2.4.0/include/asm/string.h:312: `current' undeclared (first use in this function)
{standard input}: Assembler messages:
{standard input}:8: Warning: Ignoring changed section attributes for .modinfo
make[2]: *** [loop.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.x/linux-2.4.0/drivers/block'
make[1]: *** [_modsubdir_block] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.x/linux-2.4.0/drivers'
make: *** [_mod_drivers] Error 2




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
