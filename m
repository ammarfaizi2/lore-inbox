Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbTBEU23>; Wed, 5 Feb 2003 15:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbTBEU22>; Wed, 5 Feb 2003 15:28:28 -0500
Received: from packet.digeo.com ([12.110.80.53]:58524 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264844AbTBEU20>;
	Wed, 5 Feb 2003 15:28:26 -0500
Message-ID: <3E417624.2762A635@digeo.com>
Date: Wed, 05 Feb 2003 12:37:56 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.59-mm8 with contest
References: <200302052221.55663.conman@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Feb 2003 20:37:56.0437 (UTC) FILETIME=[76D55850:01C2CD56]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> ..
> 
> This seems to be creeping up to the same as 2.5.59
> ...
> and this seems to be taking significantly longer
> ...
> And this load which normally changes little has significantly different
> results.
> 

There were no I/O scheduler changes between -mm7 and -mm8.  I
demand a recount!

 Makefile                               |   32 
 arch/alpha/kernel/time.c               |   12 
 arch/arm/kernel/time.c                 |    8 
 arch/i386/Kconfig                      |   18 
 arch/i386/kernel/Makefile              |    3 
 arch/i386/kernel/apm.c                 |   16 
 arch/i386/kernel/io_apic.c             |    2 
 arch/i386/kernel/time.c                |   14 
 arch/i386/mm/hugetlbpage.c             |   72 
 arch/ia64/kernel/time.c                |   12 
 arch/m68k/kernel/time.c                |    8 
 arch/m68knommu/kernel/time.c           |    8 
 arch/mips/au1000/common/time.c         |   12 
 arch/mips/baget/time.c                 |    8 
 arch/mips/dec/time.c                   |   16 
 arch/mips/ite-boards/generic/time.c    |   16 
 arch/mips/kernel/sysirix.c             |    4 
 arch/mips/kernel/time.c                |   12 
 arch/mips/mips-boards/generic/time.c   |   16 
 arch/mips/philips/nino/time.c          |    8 
 arch/mips64/mips-boards/generic/time.c |   16 
 arch/mips64/sgi-ip22/ip22-timer.c      |   16 
 arch/mips64/sgi-ip27/ip27-timer.c      |   12 
 arch/parisc/kernel/sys_parisc32.c      |    4 
 arch/parisc/kernel/time.c              |   16 
 arch/ppc/kernel/time.c                 |   12 
 arch/ppc/platforms/pmac_time.c         |    8 
 arch/ppc64/kernel/time.c               |   16 
 arch/s390/kernel/time.c                |   12 
 arch/s390x/kernel/time.c               |   12 
 arch/sh/kernel/time.c                  |   12 
 arch/sparc/kernel/pcic.c               |    8 
 arch/sparc/kernel/time.c               |   12 
 arch/sparc64/kernel/time.c             |   16 
 arch/um/kernel/time_kern.c             |    4 
 arch/v850/kernel/time.c                |    8 
 arch/x86_64/kernel/time.c              |   12 
 drivers/char/Makefile                  |    7 
 drivers/scsi/aic7xxx/aic79xx_osm.c     |   18 
 drivers/scsi/aic7xxx/aic79xx_osm.h     |    3 
 drivers/scsi/aic7xxx/aic7xxx_osm.c     |   15 
 drivers/scsi/aic7xxx/aic7xxx_osm.h     |    3 
 drivers/scsi/scsi_error.c              |   98 
 fs/exec.c                              |    4 
 fs/fs-writeback.c                      |   12 
 fs/hugetlbfs/inode.c                   |  227 
 fs/super.c                             |  138 
 include/linux/hugetlb.h                |   10 
 include/linux/module.h                 |    2 
 include/linux/sched.h                  |   47 
 include/linux/sysctl.h                 |    4 
 include/linux/time.h                   |    4 
 init/Kconfig                           |    3 
 init/main.c                            |   14 
 kernel/ksyms.c                         |    8 
 kernel/module.c                        |   53 
 kernel/sched.c                         |  512 
 kernel/sysctl.c                        |    4 
 kernel/time.c                          |   19 
 kernel/timer.c                         |    6 
 mm/Makefile                            |    2 
 mm/memory.c                            |   10 
 mm/mmap.c                              |    5 
 mm/page_alloc.c                        |    5 
 scripts/Makefile.build                 |   29 
 scripts/Makefile.lib                   |    1 
 scripts/Makefile.modver                |   18 
 sound/pci/rme9652/hammerfall_mem.c     |    7 
 sound/sound_firmware.c                 |30559 +++++++++++++++++++++------------
 69 files changed, 21001 insertions(+), 11339 deletions(-)
