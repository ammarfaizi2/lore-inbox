Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136357AbRAMLeu>; Sat, 13 Jan 2001 06:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136618AbRAMLek>; Sat, 13 Jan 2001 06:34:40 -0500
Received: from kiln.isn.net ([198.167.161.1]:14656 "EHLO kiln.isn.net")
	by vger.kernel.org with ESMTP id <S136357AbRAMLe1>;
	Sat, 13 Jan 2001 06:34:27 -0500
Message-ID: <3A603D1B.DAC9C8F4@isn.net>
Date: Sat, 13 Jan 2001 07:33:47 -0400
From: "Garst R. Reese" <reese@isn.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.1pre3 compile problems
Content-Type: multipart/mixed;
 boundary="------------0B585D2FAB5859E7ABBA5273"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0B585D2FAB5859E7ABBA5273
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

log attached.
same problem with ac8
gcc-2.95.2.1
UP
Garst
--------------0B585D2FAB5859E7ABBA5273
Content-Type: text/plain; charset=us-ascii;
 name="makebzlilo.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="makebzlilo.log"

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i586  -DUTS_MACHINE='"i386"' -c -o init/version.o init/version.c
make CFLAGS="-D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i586 " -C  kernel
make[1]: Entering directory `/usr/src/linux/kernel'
make all_targets
make[2]: Entering directory `/usr/src/linux/kernel'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i586    -DEXPORT_SYMTAB -c ksyms.c
In file included from /usr/src/linux/include/linux/modversions.h:93,
                 from /usr/src/linux/include/linux/module.h:21,
                 from ksyms.c:14:
/usr/src/linux/include/linux/modules/i386_ksyms.ver:76: warning: `cpu_data' redefined
/usr/src/linux/include/asm/processor.h:78: warning: this is the location of the previous definition
/usr/src/linux/include/linux/modules/i386_ksyms.ver:80: warning: `smp_num_cpus' redefined
/usr/src/linux/include/linux/smp.h:80: warning: this is the location of the previous definition
/usr/src/linux/include/linux/modules/i386_ksyms.ver:82: warning: `cpu_online_map' redefined
/usr/src/linux/include/linux/smp.h:88: warning: this is the location of the previous definition
/usr/src/linux/include/linux/modules/i386_ksyms.ver:96: warning: `smp_call_function' redefined
/usr/src/linux/include/linux/smp.h:87: warning: this is the location of the previous definition
In file included from /usr/src/linux/include/linux/modversions.h:117,
                 from /usr/src/linux/include/linux/module.h:21,
                 from ksyms.c:14:
/usr/src/linux/include/linux/modules/ksyms.ver:504: warning: `del_timer_sync' redefined
/usr/src/linux/include/linux/timer.h:34: warning: this is the location of the previous definition
In file included from /usr/src/linux/include/linux/interrupt.h:45,
                 from ksyms.c:21:
/usr/src/linux/include/asm/hardirq.h:37: warning: `synchronize_irq' redefined
/usr/src/linux/include/linux/modules/i386_ksyms.ver:84: warning: this is the location of the previous definition
In file included from ksyms.c:17:
/usr/src/linux/include/linux/kernel_stat.h: In function `kstat_irqs':
/usr/src/linux/include/linux/kernel_stat.h:48: `smp_num_cpus' undeclared (first use in this function)
/usr/src/linux/include/linux/kernel_stat.h:48: (Each undeclared identifier is reported only once
/usr/src/linux/include/linux/kernel_stat.h:48: for each function it appears in.)
make[2]: *** [ksyms.o] Error 1
make[2]: Leaving directory `/usr/src/linux/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux/kernel'
make: *** [_dir_kernel] Error 2

--------------0B585D2FAB5859E7ABBA5273--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
