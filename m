Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267856AbTAHMOO>; Wed, 8 Jan 2003 07:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267857AbTAHMOO>; Wed, 8 Jan 2003 07:14:14 -0500
Received: from falcon.vispa.uk.net ([62.24.228.11]:59397 "EHLO
	falcon.vispa.com") by vger.kernel.org with ESMTP id <S267856AbTAHMON>;
	Wed, 8 Jan 2003 07:14:13 -0500
Message-ID: <3E1C17E0.2080804@walrond.org>
Date: Wed, 08 Jan 2003 12:21:52 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BUILD PROBLEM - Linux 2.5 BK - smpboot.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing this error:

   gcc -Wp,-MD,arch/i386/kernel/.smpboot.o.d -D__KERNEL__ -Iinclude 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium4 
-Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc 
-iwithprefix include    -DKBUILD_BASENAME=smpboot 
-DKBUILD_MODNAME=smpboot   -c -o arch/i386/kernel/smpboot.o 
arch/i386/kernel/smpboot.c
make -f scripts/Makefile.build obj=fs
make -f scripts/Makefile.build obj=fs/autofs4
arch/i386/kernel/smpboot.c:55:26:make -f scripts/Makefile.build obj=fs/devfs
  mach_wakecpu.h: No such file or directory
make -f scripts/Makefile.build obj=fs/devpts
make -f scripts/Makefile.build obj=fs/exportfs
make -f scripts/Makefile.build obj=fs/lockd
arch/i386/kernel/smpboot.c: In function `smp_callin':
arch/i386/kernel/smpboot.c:351: warning: implicit declaration of 
function `wait_for_init_deassert'arch/i386/kernel/smpboot.c:400: 
warning: implicit declaration of function `smp_callin_clear_local_apic'
make -f scripts/Makefile.build obj=fs/nfs
arch/i386/kernel/smpboot.c: In function `do_boot_cpu':
arch/i386/kernel/smpboot.c:826: warning: implicit declaration of 
function `store_NMI_vector'
arch/i386/kernel/smpboot.c:831: `TRAMPOLINE_HIGH' undeclared (first use 
in this function)
arch/i386/kernel/smpboot.c:831: (Each undeclared identifier is reported 
only once
arch/i386/kernel/smpboot.c:831: for each function it appears in.)
arch/i386/kernel/smpboot.c:833: `TRAMPOLINE_LOW' undeclared (first use 
in this function)
arch/i386/kernel/smpboot.c:839: warning: implicit declaration of 
function `wakeup_secondary_cpu'
arch/i386/kernel/smpboot.c:873: warning: implicit declaration of 
function `inquire_remote_apic'
arch/i386/kernel/smpboot.c: In function `smp_boot_cpus':
arch/i386/kernel/smpboot.c:1048: `boot_cpu_apicid' undeclared (first use 
in this function)
make -f scripts/Makefile.build obj=fs/nfsd
make -f scripts/Makefile.build obj=fs/partitions
make -f scripts/Makefile.build obj=fs/proc
make[1]: *** [arch/i386/kernel/smpboot.o] Error 1
make: *** [arch/i386/kernel] Error 2
make: *** Waiting for unfinished jobs....

