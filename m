Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267126AbTBUHgA>; Fri, 21 Feb 2003 02:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267235AbTBUHgA>; Fri, 21 Feb 2003 02:36:00 -0500
Received: from packet.digeo.com ([12.110.80.53]:22466 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267126AbTBUHfx>;
	Fri, 21 Feb 2003 02:35:53 -0500
Date: Thu, 20 Feb 2003 23:47:33 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.62-mm2
Message-Id: <20030220234733.3d4c5e6d.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2003 07:45:53.0831 (UTC) FILETIME=[43049B70:01C2D97D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.62/2.5.62-mm2/

Various little bits and pieces.  Mainly work against the anticipatory
scheduler.

The anticipatory scheduler has been moved into its own file now, and
deadline-iosched is unaltered from 2.5.62 base (apart from a small bugfix).

So this tree has three elevators (apart from the no-op elevator).  You can
select between them via the kernel boot commandline:

	elevator=as
	elevator=cfq
	elevator=deadline

The default is AS.



Changes since 2.5.62-mm1:


-xfs-warning-fixes.patch
-xfs-cli-fix.patch
-drm-timer-init.patch
-cifs-exports.patch
-mk_pte_huge-header.patch
-summit-numaq-kirq-fix.patch
-remove-MAX_BLKDEV-from-nfsd.patch
-const-warning-fix-1.patch
-const-warning-fix-2.patch
-const-warning-fix-3.patch
-visws-1.patch
-visws-2.patch
-visws-3.patch
-visws-4.patch
-visws-5.patch
-visws-6.patch
-visws-7.patch
-visws-8.patch
-visws-9.patch
-visws-10.patch
-visws-11.patch
-visws-12.patch
-visws-13.patch
-visws-pci-fix.patch
-profiling-cleanup.patch
-profiler-make-static.patch
-tty-module-refcounting.patch

 Merged

+ppc64-timer-fix.patch
+ppc-entry-build-fix.patch
+ppc64-time-warning-fix.patch
+ppc64-64-bit-exec-fix.patch

 Various ppc64 fixes

+sym-do-160.patch

 Make sym-2 driver do 160 MB/sec (this patch is wrong)

-reiserfs_file_write-3.patch
+reiserfs_file_write-4.patch

 Latest from Namesys

-deadline-np-42.patch
-deadline-np-43.patch
-batch-tuning.patch
-starvation-by-read-fix.patch
-anticipatory_io_scheduling.patch
-deadline-jiffies-wrap.patch

 Rolled into the new drivers/block/as-iosched.c

+as-iosched.patch

 Break the anticipatory scheduler out into a new file.

+as-comments-and-tweaks.patch

 Anticipatory scheduler Update from Nick.

+isp-update-1.patch

 Fix the linux-isp driver's shutdown handling.

+crc32-speedup-2.patch

 speed up the crc32 code

+aic-makefile-fix.patch

 Fix the aicasm build

+atm_dev_sem.patch

 ATM locking fix

+flush-tlb-all-2.patch

 preempt safety for x86_64, ia64

+linux-2.5.62-early_ioremap_A0.patch
+linux-2.5.62-x440disco_A0.patch
+srat-config-fix.patch

 summit support fixes

+dget-BUG.patch

 Make dget() go BUG() again on zero-ref dentries

+sysfs-dget-fix.patch

 Fix sysfs's dget() of zero-ref dentries

+disk-accounting-fix.patch

 Fix the SARD accounting

+hugh-inode-pruning-race-fix.patch

 Fix race between inode reclaim and unmount

-elevator-selection.patch

 Folded into as-iosched.patch and cfq-2.patch




All 53 patches:


linus.patch

ppc64-reloc_hide.patch

anton-1.patch
  ppc64 patch

ppc64-pci-patch.patch
  Subject: pci patch

ppc64-e100-fix.patch
  fix e100 for big-endian machines

ppc64-aio-32bit-emulation.patch
  32/64bit emulation for aio

ppc64-timer-fix.patch
  ppc64: fix the build for posix timer changes

ppc-entry-build-fix.patch
  ppc64: Fix the build for linux/sys.h changes

ppc64-time-warning-fix.patch
  ppc64: time warning fixes

ppc64-64-bit-exec-fix.patch
  Subject: 64bit exec

sym-do-160.patch
  make the SYM driver do 160 MB/sec

kgdb.patch

nfsd-disable-softirq.patch
  Fix race in svcsock.c in 2.5.61

report-lost-ticks.patch
  make lost-tick detection more informative

devfs-fix.patch

ptrace-flush.patch
  Subject: [PATCH] ptrace on 2.5.44

buffer-debug.patch
  buffer.c debugging

warn-null-wakeup.patch

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

deadline-dispatching-fix.patch
  deadline IO scheduler dispatching fix

nfs-unstable-pages.patch
  "unstable" page accounting for NFS.

initial-jiffies.patch
  make jiffies wrap 5 min after boot

reiserfs_file_write-4.patch
  ReiserFS CPU efficient large writes for  2.5

tcp-wakeups.patch
  Use fast wakeups in TCP/IPV4

lockd-lockup-fix.patch
  Subject: Re: Fw: Re: 2.4.20 NFS server lock-up (SMP)

rcu-stats.patch
  RCU statistics reporting

ext3-journalled-data-assertion-fix.patch
  Remove incorrect assertion from ext3

nfs-speedup.patch

nfs-oom-fix.patch
  nfs oom fix

sk-allocation.patch
  Subject: Re: nfs oom

nfs-more-oom-fix.patch

nfs-sendfile.patch
  Implement sendfile() for NFS

rpciod-atomic-allocations.patch
  Make rcpiod use atomic allocations

put_page-speedup.patch
  hugetlb put_page speedup

linux-isp.patch

isp-update-1.patch

remove-unused-congestion-stuff.patch
  Subject: [PATCH] remove unused congestion stuff

crc32-speedup-2.patch
  Subject: [PATCH]  crc32 improvements for 2.5, more optimizations

aic-makefile-fix.patch
  aicasm Makefile fix

atm_dev_sem.patch
  convert atm_dev_lock from spinlock to semaphore

flush-tlb-all-2.patch
  flush_tlb_all preempt safety for voyager and x86_64

linux-2.5.62-early_ioremap_A0.patch
  Early ioremap support for ia32

linux-2.5.62-x440disco_A0.patch

srat-config-fix.patch

dget-BUG.patch
  Check for zero d_count in dget()

sysfs-dget-fix.patch
  sysfs dget() fix

disk-accounting-fix.patch
  SARD accounting fix

hugh-inode-pruning-race-fix.patch
  Fix race between umount and iprune

as-iosched.patch
  anticipatory I/O scheduler

as-comments-and-tweaks.patch
  antsched: commentary and

cfq-2.patch
  CFQ scheduler, #2

smalldevfs.patch
  smalldevfs

smalldevfs-dcache_rcu-fix.patch
  Subject: Re: 2.5.61-mm1



