Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261297AbSJUKBX>; Mon, 21 Oct 2002 06:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261298AbSJUKBX>; Mon, 21 Oct 2002 06:01:23 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:64327 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S261297AbSJUKBW>; Mon, 21 Oct 2002 06:01:22 -0400
Date: Mon, 21 Oct 2002 03:15:47 -0700
From: "Matt D. Robinson" <yakker@aparity.com>
Message-Id: <200210211015.g9LAFlv21151@nakedeye.aparity.com>
To: linux-kernel@vger.kernel.org, yakker@aparity.com
Subject: [PATCH] 2.5.44: lkcd (0/9): general description and diffstat
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are the latest LKCD patches for 2.5.44.  We have put in a
number of changes, additions and deletions requested by the
following people on the lkml list between our 2.5.38 and 2.5.44
patches:

	Randy Dunlap
	Andi Kleen
	Christoph Hellwig
	Kai Germaschewski
	Stephen Hemminger

We have tested again on multiple kernels with various types of
dumping devices.  The diffstat output is now at the top of each
patch.  These patches have been well tested.  Feel free to give
them a spin and let us know of any problems.

Thanks,

--Matt

The full diffstat for LKCD in 2.5.44 tree (the majority of the
changes are the addition of the dump modules and headers):

 Makefile                             |   15 
 arch/i386/boot/Makefile              |    2 
 arch/i386/boot/install.sh            |   24 
 arch/i386/config.in                  |    7 
 arch/i386/kernel/Makefile            |    2 
 arch/i386/kernel/irq.c               |    5 
 arch/i386/kernel/nmi.c               |    9 
 arch/i386/kernel/smp.c               |   15 
 arch/i386/kernel/traps.c             |   28 
 arch/i386/mach-generic/irq_vectors.h |    1 
 arch/i386/mm/Makefile                |    2 
 arch/i386/mm/init.c                  |    5 
 arch/s390/boot/install.sh            |   24 
 arch/s390x/boot/install.sh           |   24 
 drivers/Makefile                     |    1 
 drivers/char/sysrq.c                 |   13 
 drivers/dump/Makefile                |   30 
 drivers/dump/dump_base.c             | 1860 +++++++++++++++++++++++++++++++++++
 drivers/dump/dump_blockdev.c         |  392 +++++++
 drivers/dump/dump_gzip.c             |  129 ++
 drivers/dump/dump_i386.c             |  315 +++++
 drivers/dump/dump_rle.c              |  176 +++
 include/asm-i386/dump.h              |   94 +
 include/asm-i386/smp.h               |    1 
 include/linux/dump.h                 |  438 ++++++++
 include/linux/page-flags.h           |    5 
 init/Makefile                        |    5 
 init/kerntypes.c                     |   24 
 init/main.c                          |   10 
 kernel/Makefile                      |    2 
 kernel/panic.c                       |   16 
 kernel/sched.c                       |   30 
 kernel/sys.c                         |   36 
 lib/Config.in                        |    2 
 mm/page_alloc.c                      |   22 
 35 files changed, 3731 insertions(+), 33 deletions(-)
