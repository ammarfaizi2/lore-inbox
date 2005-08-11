Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbVHKSj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVHKSj5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 14:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbVHKSj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 14:39:56 -0400
Received: from adsl-266.mirage.euroweb.hu ([193.226.239.10]:4622 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932352AbVHKSj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 14:39:56 -0400
To: akpm@osdl.org, blaisorblade@yahoo.it
CC: linux-kernel@vger.kernel.org, jdike@addtoit.com
Subject: UML build broken on 2.6.13-rc5-mm1
Message-Id: <E1E3HxJ-0003Uf-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 11 Aug 2005 20:39:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UML is broken again in -mm.

Maybe UML should be added to one of the automatic build suites.

Miklos


ccache gcc -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding -O2     -fno-omit-frame-pointer -fno-optimize-sibling-calls -g  -D__arch_um__ -DSUBARCH=\"i386\" -Iarch/um/include  -I/usr/src/quilt/linux/arch/um/kernel/tt/include  -I/usr/src/quilt/linux/arch/um/kernel/skas/include -Dvmap=kernel_vmap -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask  -U__i386__ -Ui386  -D_LARGEFILE64_SOURCE    -nostdinc -isystem /usr/lib/gcc-lib/i486-linux/3.3.4/include -D__KERNEL__ -Iinclude  -S -o arch/um/kernel-offsets.s arch/um/sys-i386/kernel-offsets.c
In file included from include/asm/ptrace-generic.h:17,
                 from include/asm/ptrace.h:12,
                 from include/asm/processor-generic.h:14,
                 from include/asm/processor.h:46,
                 from include/asm/thread_info.h:12,
                 from include/linux/thread_info.h:21,
                 from include/linux/spinlock.h:53,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/um/sys-i386/kernel-offsets.c:3:
include/asm/arch/ptrace.h:60:26: mach_segment.h: No such file or directory
In file included from include/asm/system-generic.h:4,
                 from include/asm/system.h:4,
                 from include/linux/spinlock.h:57,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/um/sys-i386/kernel-offsets.c:3:
include/asm/arch/system.h:414:25: mach_system.h: No such file or directory
In file included from include/asm/system-generic.h:4,
                 from include/asm/system.h:4,
                 from include/linux/spinlock.h:57,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/um/sys-i386/kernel-offsets.c:3:
include/asm/arch/system.h: In function `sched_cacheflush':
include/asm/arch/system.h:439: warning: implicit declaration of function `wbinvd'
make: *** [arch/um/kernel-offsets.s] Error 1
