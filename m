Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbQKTRBA>; Mon, 20 Nov 2000 12:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129165AbQKTRAv>; Mon, 20 Nov 2000 12:00:51 -0500
Received: from ds5500.cemr.wvu.edu ([157.182.83.20]:31502 "EHLO
	ds5500.cemr.wvu.edu") by vger.kernel.org with ESMTP
	id <S129136AbQKTRAm>; Mon, 20 Nov 2000 12:00:42 -0500
Date: Mon, 20 Nov 2000 11:30:21 -0500 (EST)
From: Andrei Smirnov <andrei@ds5500.cemr.wvu.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.2.16 does not compile
Message-ID: <Pine.ULT.3.96.1001120110905.28412A-100000@ds5500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a newly installed RH-7.0 distribution on a Celeron Pentium 400.
When I tried to compile the kernel I got the following:

1. I ran make xconfig (or make menuconfig) and saved without changing any
   options - completed OK

2. make dep: OK.

3. make zImage: produced the following output:


kgcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -fno-strength-reduce -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686 -DUTS_MACHINE='"i386"' -c -o init/version.o i
nit/version.c
make -C  kernel
make[1]: Entering directory `/usr/src/linux-2.2.16/kernel'
make all_targets
make[2]: Entering directory `/usr/src/linux-2.2.16/kernel'
kgcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -fno-strength-reduce -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686   -DEXPORT_SYMTAB -c ksyms.c
In file included from /usr/src/linux/include/linux/modversions.h:50,
                 from /usr/src/linux/include/linux/module.h:19,
                 from ksyms.c:14:
/usr/src/linux/include/linux/modules/i386_ksyms.ver:6: warning: `cpu_data' redefined
/usr/src/linux/include/asm/processor.h:96: warning: this is the location of the previous definition
/usr/src/linux/include/linux/modules/i386_ksyms.ver:28: warning: `smp_num_cpus' redefined
/usr/src/linux/include/linux/smp.h:77: warning: this is the location of the previous definition
/usr/src/linux/include/linux/modules/i386_ksyms.ver:118: warning: `smp_call_function' redefined
/usr/src/linux/include/linux/smp.h:83: warning: this is the location of the previous definition
In file included from /usr/src/linux/include/linux/interrupt.h:51,
                 from ksyms.c:21:
/usr/src/linux/include/asm/hardirq.h:23: warning: `synchronize_irq' redefined
/usr/src/linux/include/linux/modules/i386_ksyms.ver:138: warning: this is the location of the previous definition
In file included from /usr/src/linux/include/linux/interrupt.h:52,
                 from ksyms.c:21:
/usr/src/linux/include/asm/softirq.h:75: warning: `synchronize_bh' redefined
/usr/src/linux/include/linux/modules/i386_ksyms.ver:142: warning: this is the location of the previous definition
/usr/src/linux/include/linux/kernel_stat.h: In function `kstat_irqs':
In file included from ksyms.c:17:
/usr/src/linux/include/linux/kernel_stat.h:47: `smp_num_cpus' undeclared (first use in this function)
/usr/src/linux/include/linux/kernel_stat.h:47: (Each undeclared identifier is reported only once
/usr/src/linux/include/linux/kernel_stat.h:47: for each function it appears in.)
make[2]: *** [ksyms.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.2.16/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.2.16/kernel'
make: *** [_dir_kernel] Error 2

-----------------------------------------------------------------------
Kernel compilation worked before on RH-6.1 and RH-6.2 and I never changed
any other soft/hardware features on my computer. I would appreciate any
comments or a hint where I can find an answer to this problem. 

Best regards,

-----------------------------------------------------------------------
Dr. Andrei Smirnov        Tel:+1(304)293 3111 x2466. Fax:+1(304)2936689
West Virginia University. Dept. of Mechanical and Aerospace Engineering
Morgantown WV, 26506-6106             Email: AsmirNo2@wvu.edu
-----------------------------------------------------------------------


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
