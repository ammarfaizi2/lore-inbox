Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262192AbSJJTzq>; Thu, 10 Oct 2002 15:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262180AbSJJTyo>; Thu, 10 Oct 2002 15:54:44 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:9806 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S262178AbSJJTuP>; Thu, 10 Oct 2002 15:50:15 -0400
Date: Thu, 10 Oct 2002 13:04:17 -0700
From: "Matt D. Robinson" <yakker@aparity.com>
Message-Id: <200210102004.g9AK4Hw29542@nakedeye.aparity.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com, yakker@aparity.com
Subject: [PATCH] 2.5.41: lkcd (0/8): general description and diffstat
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are the latest LKCD patches for 2.5.41.  We have put in the
changes requested by Randy Dunlap and Andi Kleen, and have tested
again on multiple kernels (UP/SMP, IDE/SCSI) with various types
of dumping.  The diffstat output is now at the top of each patch.
These patches have been well tested.  Feel free to give them a
spin and let us know of any problems.

Copying Linus.  Linus, please include these in the next 2.5.42
image, or let me know if you have any issues.

Thanks,

--Matt

Diffstat for LKCD in 2.5.41 tree:

 linux-2.5.41+lkcd/arch/i386/kernel/Makefile            |    2
 linux-2.5.41+lkcd/arch/i386/kernel/irq.c               |    3
 linux-2.5.41+lkcd/arch/i386/kernel/nmi.c               |    8
 linux-2.5.41+lkcd/arch/i386/kernel/traps.c             |   25
 linux-2.5.41+lkcd/arch/i386/mm/Makefile                |    2
 linux-2.5.41+lkcd/arch/i386/mm/init.c                  |    5
 linux-2.5.41+lkcd/drivers/Makefile                     |    1
 linux-2.5.41+lkcd/drivers/char/sysrq.c                 |   13
 linux-2.5.41+lkcd/drivers/dump/Makefile                |   30
 linux-2.5.41+lkcd/drivers/dump/dump_base.c             | 1867 +++++++++++++++++
 linux-2.5.41+lkcd/drivers/dump/dump_blockdev.c         |  411 +++
 linux-2.5.41+lkcd/drivers/dump/dump_gzip.c             |  129 +
 linux-2.5.41+lkcd/drivers/dump/dump_i386.c             |  315 ++
 linux-2.5.41+lkcd/drivers/dump/dump_rle.c              |  176 +
 linux-2.5.41+lkcd/include/asm-i386/dump.h              |   94
 linux-2.5.41+lkcd/include/linux/dump.h                 |  440 ++++
 linux-2.5.41+lkcd/init/main.c                          |   10
 linux-2.5.41+lkcd/kernel/Makefile                      |    2
 linux-2.5.41+lkcd/kernel/panic.c                       |   18
 linux-2.5.41+lkcd/kernel/sched.c                       |   32
 linux-2.5.41.lkcd/Makefile                             |   11
 linux-2.5.41.lkcd/arch/i386/boot/Makefile              |    2
 linux-2.5.41.lkcd/arch/i386/boot/install.sh            |   20
 linux-2.5.41.lkcd/arch/i386/config.in                  |    7
 linux-2.5.41.lkcd/arch/i386/kernel/smp.c               |   15
 linux-2.5.41.lkcd/arch/i386/mach-generic/irq_vectors.h |    1
 linux-2.5.41.lkcd/fs/Makefile                          |    2
 linux-2.5.41.lkcd/fs/block_dev.c                       |    2
 linux-2.5.41.lkcd/include/asm-i386/smp.h               |    1
 linux-2.5.41.lkcd/include/linux/page-flags.h           |    5
 linux-2.5.41.lkcd/init/kerntypes.c                     |   28
 linux-2.5.41.lkcd/kernel/sys.c                         |   36
 linux-2.5.41.lkcd/lib/Config.in                        |    2
 linux-2.5.41.lkcd/mm/page_alloc.c                      |   23
 34 files changed, 3721 insertions(+), 17 deletions(-)
