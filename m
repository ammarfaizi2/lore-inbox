Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261491AbTCGDBH>; Thu, 6 Mar 2003 22:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261492AbTCGDBH>; Thu, 6 Mar 2003 22:01:07 -0500
Received: from [66.21.109.1] ([66.21.109.1]:51467 "EHLO
	mail.dynastytechnologies.net") by vger.kernel.org with ESMTP
	id <S261491AbTCGDBD>; Thu, 6 Mar 2003 22:01:03 -0500
Subject: 2.5.64(-ac1) UML broken
From: Ro0tSiEgE LKML <lkml@ro0tsiege.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1047006690.5778.4.camel@gandalf.ro0tsiege.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 06 Mar 2003 21:11:32 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this when trying to build UML in 2.5.64-ac1 (tried both
with/without the patch from their site):

  Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=
make -f scripts/Makefile.build obj=init
  gcc -Wp,-MD,init/.main.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2  -Iinclude/asm-i386/mach-default
-fomit-frame-pointer -nostdinc -iwithprefix include   
-DKBUILD_BASENAME=main -DKBUILD_MODNAME=main -c -o init/main.o
init/main.c
In file included from include/asm/thread_info.h:13,
                 from include/linux/thread_info.h:21,
                 from include/linux/spinlock.h:12,
                 from include/linux/mmzone.h:8,
                 from include/linux/gfp.h:4,
                 from include/linux/slab.h:14,
                 from include/linux/proc_fs.h:5,
                 from init/main.c:15:
include/asm/processor.h:65: `CONFIG_X86_L1_CACHE_SHIFT' undeclared here
(not in a function)
include/asm/processor.h:65: requested alignment is not a constant
In file included from include/linux/fs.h:17,
                 from include/linux/proc_fs.h:6,
                 from init/main.c:15:
include/linux/dcache.h:99: `CONFIG_X86_L1_CACHE_SHIFT' undeclared here
(not in a function)
include/linux/dcache.h:99: requested alignment is not a constant
In file included from include/linux/mm.h:197,
                 from include/linux/pagemap.h:7,
                 from include/linux/blkdev.h:10,
                 from include/linux/blk.h:4,
                 from init/main.c:26:
include/linux/page-flags.h:118: `CONFIG_X86_L1_CACHE_SHIFT' undeclared
here (not in a function)
include/linux/page-flags.h:118: requested alignment is not a constant
In file included from include/asm/hardirq.h:6,
                 from include/linux/interrupt.h:9,
                 from include/asm/highmem.h:24,
                 from include/linux/highmem.h:12,
                 from include/linux/pagemap.h:10,
                 from include/linux/blkdev.h:10,
                 from include/linux/blk.h:4,
                 from init/main.c:26:
include/linux/irq.h:65: `CONFIG_X86_L1_CACHE_SHIFT' undeclared here (not
in a function)
include/linux/irq.h:65: requested alignment is not a constant
In file included from include/linux/interrupt.h:9,
                 from include/asm/highmem.h:24,
                 from include/linux/highmem.h:12,
                 from include/linux/pagemap.h:10,
                 from include/linux/blkdev.h:10,
                 from include/linux/blk.h:4,
                 from init/main.c:26:
include/asm/hardirq.h:16: `CONFIG_X86_L1_CACHE_SHIFT' undeclared here
(not in a function)
include/asm/hardirq.h:16: requested alignment is not a constant
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2


