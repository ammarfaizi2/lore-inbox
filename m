Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbUANUMK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 15:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbUANUJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 15:09:24 -0500
Received: from [200.29.57.153] ([200.29.57.153]:52438 "EHLO exis.cl")
	by vger.kernel.org with ESMTP id S263510AbUANUFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 15:05:49 -0500
Date: Wed, 14 Jan 2004 17:05:52 -0300
From: Oscar Peredo <oscar.peredo@bunkerchile.net>
To: linux-kernel@vger.kernel.org
Subject: uml compilation error in kernel 2.6.1
Message-Id: <20040114170552.5e87dc85.oscar.peredo@bunkerchile.net>
Organization: bunkerchile
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i try to compile the uml system with the kernel 2.6.1 and when execute "make linux ARCH=um", send me this errors


$ make V=1 linux ARCH=um
make -f scripts/Makefile.build obj=scripts
make -f scripts/Makefile.build obj=scripts/genksyms
  gcc -Wp,-MD,scripts/.modpost.o.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer       -c -o scripts/modpost.o scripts/modpost.c
  gcc  -o scripts/modpost scripts/modpost.o scripts/file2alias.o  
mkdir -p .tmp_versions
make[1]: `arch/um/sys-i386/util/mk_sc' is up to date.
  gcc -Wp,-MD,arch/um/util/.mk_task_kern.o.d -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -U__i386__ -Ui386  -D__arch_um__ -DSUBARCH=\"i386\" -D_LARGEFILE64_SOURCE -Iarch/um/include -Derrno=kernel_errno -I/home/uml/linux-2.6.1/arch/um/kernel/tt/include -I/home/uml/linux-2.6.1/arch/um/kernel/skas/include -O2 -g     -DKBUILD_BASENAME=mk_task_kern -DKBUILD_MODNAME=mk_task_kern -c -o arch/um/util/.tmp_mk_task_kern.o arch/um/util/mk_task_kern.c
In file included from include/asm/system-generic.h:4,
                 from include/asm/system.h:4,
                 from include/linux/list.h:8,
                 from include/linux/signal.h:4,
                 from include/asm/processor-generic.h:14,
                 from include/asm/processor.h:22,
                 from include/asm/thread_info.h:11,
                 from include/linux/thread_info.h:21,
                 from include/linux/spinlock.h:12,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/um/util/mk_task_kern.c:1:
include/asm/arch/system.h:7:28: asm/cpufeature.h: No such file or directory
In file included from include/linux/time.h:28,
                 from include/asm/arch/signal.h:6,
                 from include/asm/signal.h:12,
                 from include/linux/signal.h:6,
                 from include/asm/processor-generic.h:14,
                 from include/asm/processor.h:22,
                 from include/asm/thread_info.h:11,
                 from include/linux/thread_info.h:21,
                 from include/linux/spinlock.h:12,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/um/util/mk_task_kern.c:1:
include/linux/seqlock.h:35: parse error before "spinlock_t"
include/linux/seqlock.h:35: warning: no semicolon at end of struct or union
include/linux/seqlock.h:36: warning: type defaults to `int' in declaration of `seqlock_t'
include/linux/seqlock.h:36: warning: data definition has no type or storage class
include/linux/seqlock.h:50: parse error before '*' token
include/linux/seqlock.h:51: warning: function declaration isn't a prototype
include/linux/seqlock.h: In function `write_seqlock':
include/linux/seqlock.h:52: warning: implicit declaration of function `spin_lock'
include/linux/seqlock.h:52: `sl' undeclared (first use in this function)
include/linux/seqlock.h:52: (Each undeclared identifier is reported only once
include/linux/seqlock.h:52: for each function it appears in.)
include/linux/seqlock.h: At top level:
include/linux/seqlock.h:57: parse error before '*' token
include/linux/seqlock.h:58: warning: function declaration isn't a prototype
include/linux/seqlock.h: In function `write_sequnlock':
include/linux/seqlock.h:60: `sl' undeclared (first use in this function)
include/linux/seqlock.h:61: warning: implicit declaration of function `spin_unlock'
include/linux/seqlock.h: At top level:
include/linux/seqlock.h:64: parse error before '*' token
include/linux/seqlock.h:65: warning: function declaration isn't a prototype
include/linux/seqlock.h: In function `write_tryseqlock':
include/linux/seqlock.h:66: warning: implicit declaration of function `spin_trylock'
include/linux/seqlock.h:66: `sl' undeclared (first use in this function)
include/linux/seqlock.h: At top level:
include/linux/seqlock.h:76: warning: type defaults to `int' in declaration of `seqlock_t'
include/linux/seqlock.h:76: parse error before '*' token
include/linux/seqlock.h:77: warning: function declaration isn't a prototype
include/linux/seqlock.h: In function `read_seqbegin':
include/linux/seqlock.h:78: `sl' undeclared (first use in this function)
include/linux/seqlock.h: At top level:
include/linux/seqlock.h:91: warning: type defaults to `int' in declaration of `seqlock_t'
include/linux/seqlock.h:91: parse error before '*' token
include/linux/seqlock.h:92: warning: function declaration isn't a prototype
include/linux/seqlock.h: In function `read_seqretry':
include/linux/seqlock.h:94: `iv' undeclared (first use in this function)
include/linux/seqlock.h:94: `sl' undeclared (first use in this function)
In file included from include/asm/arch/signal.h:6,
                 from include/asm/signal.h:12,
                 from include/linux/signal.h:6,
                 from include/asm/processor-generic.h:14,
                 from include/asm/processor.h:22,
                 from include/asm/thread_info.h:11,
                 from include/linux/thread_info.h:21,
                 from include/linux/spinlock.h:12,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/um/util/mk_task_kern.c:1:
include/linux/time.h: At top level:
include/linux/time.h:297: parse error before "xtime_lock"
include/linux/time.h:297: warning: type defaults to `int' in declaration of `xtime_lock'
include/linux/time.h:297: warning: data definition has no type or storage class
In file included from include/asm/processor-generic.h:14,
                 from include/asm/processor.h:22,
                 from include/asm/thread_info.h:11,
                 from include/linux/thread_info.h:21,
                 from include/linux/spinlock.h:12,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/um/util/mk_task_kern.c:1:
include/linux/signal.h:16: parse error before "spinlock_t"
include/linux/signal.h:16: warning: no semicolon at end of struct or union
include/linux/signal.h:19: parse error before '}' token
make[1]: *** [arch/um/util/mk_task_kern.o] Error 1
make: *** [arch/um/util] Error 2
$

the version gcc is gcc (GCC) 3.2.2
i have slackware 9.0 and i am running kernel 2.6.0 

--
Oscar Peredo
Chile

