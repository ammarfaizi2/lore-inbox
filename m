Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbTBRJrs>; Tue, 18 Feb 2003 04:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264790AbTBRJrs>; Tue, 18 Feb 2003 04:47:48 -0500
Received: from packet.digeo.com ([12.110.80.53]:32431 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264739AbTBRJrm>;
	Tue, 18 Feb 2003 04:47:42 -0500
Date: Tue, 18 Feb 2003 01:58:44 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.62-mm1
Message-Id: <20030218015844.5320578a.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Feb 2003 09:57:37.0132 (UTC) FILETIME=[2A8362C0:01C2D734]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.62/2.5.62-mm1

. There is an updated qlogic driver here from Matthew.  This one works.

  We need help testing this please.  Neither Matthew nor I have a qlogic
  controller on a highmem machine, so we need to know whether it is correctly
  DMAing into high memory.

  The standalone patch is at

    ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.62/2.5.62-mm1/broken-out/linux-isp.patch

  and it applies OK to 2.5.62.

. The CPU scheduler update is leaking mm_structs - this is what caused
  Randy Hron's oom-killing event.  Dropped that out for now.



Changes since 2.5.61-mm1

+linus.patch

 Latest from Linus

-deadline-alias-3.patch
-ppc64-time-warning.patch
-ppc64-smp_prepare_cpus-warning.patch
-jfs-build-fix.patch
-linear-gcc-workaround.patch
-flush_tlb_all-preempt-safety.patch
-mandlock-fix.patch
-fault_in_pages-move.patch
-generic_write_checks.patch
-ext3-eio-fix.patch
-crc32-speedup.patch
-dcache_rcu-fast_walk-revert.patch
-dcache_rcu-main.patch
-kernel_lock_bug2.patch
-ext2_ext3_listxattr-bug.patch
-xattr-flags.patch
-xattr-flags-policy.patch
-xattr-trusted.patch
-balance_dirty_pages-lockup-fix.patch
-cciss-1.patch
-cciss-overrun-fix.patch
-direct-io-retval-fix.patch
-dio-eof-read.patch
-ext3_debug-fix.patch
-fix-Wundef.patch
-scsi-fix-NCR53C9x.patch
-radix_tree_maxindex-cleanup.patch

 Merged

+anton-1.patch
+ppc64-pci-patch.patch
+ppc64-e100-fix.patch
+ppc64-aio-32bit-emulation.patch

 Things from Anton to make ppc64 kernels work.

+nfsd-disable-softirq.patch

 NFS corruption race fix

+drm-timer-init.patch

 Timer initialisation fix

+deadline-dispatching-fix.patch

 Deadline scheduler fix

+cifs-exports.patch

 Export some VFS functions

+nfs-unstable-pages.patch

 Experimental patch from Trond to make NFS play better with VFS writeback.

+mk_pte_huge-header.patch

 Allow x86_64 to share the ia32 hugetlbpage implementation

+summit-numaq-kirq-fix.patch

 Fix IRQ balancing for Summit and NUMA-Q

+initial-jiffies.patch

 Force a jiffies wrap 5 minutes after booting.  (This found an anticipatory
 scheduler bug).

-scheduler-tunables.patch
-sched-f3.patch
-rml-scheduler-bits.patch

 Leaky.

+remove-MAX_BLKDEV-from-nfsd.patch

 nfsd cleanup

+const-warning-fix-1.patch
+const-warning-fix-2.patch
+const-warning-fix-3.patch

 Yes, it's a compiler bug.  But clean builds are important.

 linux-isp.patch

 Updated

-linux-isp-update.patch

 Folded into linux-isp.patch

+visws-pci-fix.patch

 Fix a compile warning in the visws code.

+profiler-make-static.patch

 Profiler cleanups and Voyager fix.

+deadline-jiffies-wrap.patch

 Fix the anticipatory scheduler for "negative" jiffies values.

+smalldevfs.patch
+smalldevfs-dcache_rcu-fix.patch

 Back.  Maneesh fixed it up.




All 68 patches


linus.patch

ppc64-reloc_hide.patch

anton-1.patch
  ppc64 patch

ppc64-pci-patch.patch
  Subject: pci patch

ppc64-e100-fix.patch
  fix e100 for ppc64

ppc64-aio-32bit-emulation.patch
  32/64bit emulation for aio

kgdb.patch

nfsd-disable-softirq.patch
  Fix race in svcsock.c in 2.5.61

xfs-warning-fixes.patch

xfs-cli-fix.patch
  xfs interrupt flags fix

report-lost-ticks.patch
  make lost-tick detection more informative

devfs-fix.patch

ptrace-flush.patch
  Subject: [PATCH] ptrace on 2.5.44

buffer-debug.patch
  buffer.c debugging

warn-null-wakeup.patch

drm-timer-init.patch
  Subject: [PATCH] fix for uninitialized timer in drm_drv.h

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

deadline-dispatching-fix.patch
  deadline IO scheduler dispatching fix

cifs-exports.patch
  export add_to_page_cache() and __pagevec_lru_add to modules

nfs-unstable-pages.patch
  "unstable" page accounting for NFS.

mk_pte_huge-header.patch
  Move mk_pte_huge() into pgtable.h

summit-numaq-kirq-fix.patch
  Subject: [PATCH] fix kirq for clustered apic mode

initial-jiffies.patch
  make jiffies wrap 5 min after boot

reiserfs_file_write-3.patch

tcp-wakeups.patch
  Use fast wakeups in TCP/IPV4

deadline-np-42.patch
  (undescribed patch)

deadline-np-43.patch
  (undescribed patch)

batch-tuning.patch
  I/O scheduler tuning

starvation-by-read-fix.patch
  fix starvation-by-readers in the IO scheduler

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

remove-MAX_BLKDEV-from-nfsd.patch
  Remove MAX_BLKDEV from nfsd

const-warning-fix-1.patch
  Fix warnings from CIFS on 2.5.61

const-warning-fix-2.patch
  Fix warnings for XFS on 2.5.61

const-warning-fix-3.patch
  Fix warnings for NTFS 2.5.61

linux-isp.patch

visws-1.patch
  visws: allow SMP kernel build without io_apic.c (1/13)

visws-2.patch
  visws: export some functions from i8259.c (2/13)

visws-3.patch
  visws: make startup_32 kernel entry point (3/13)

visws-4.patch
  visws: export boottime gdt descriptor (4/13)

visws-5.patch
  visws: boot changes (5/13)

visws-6.patch
  Subject: [PATCH] visws: move header file into asm/arch-visws (6/13)

visws-7.patch
  visws: add missing mach_apic.h file (7/13)

visws-8.patch
  visws: pci support (8/13)

visws-9.patch
  visws: core (9/13)

visws-10.patch
  visws: framebuffer driver update (10/13)

visws-11.patch
  visws: sound update (11/13)

visws-12.patch
  visws: MAINTAINERS file update (12/13)

visws-13.patch
  visws: i386/KConfig update (13/13)

visws-pci-fix.patch
  fix a visws compile warning

profiling-cleanup.patch
  Subject: [PATCH]: consolidate and cleanup profiling code.

profiler-make-static.patch
  more ia32 profiler cleanups

remove-unused-congestion-stuff.patch
  Subject: [PATCH] remove unused congestion stuff

tty-module-refcounting.patch
  TYT module refcounting fix

anticipatory_io_scheduling.patch
  Subject: [PATCH] 2.5.59-mm3 antic io sched

deadline-jiffies-wrap.patch

cfq-2.patch
  CFQ scheduler, #2

elevator-selection.patch
  boot-time selection of disk elevator type

smalldevfs.patch
  smalldevfs

smalldevfs-dcache_rcu-fix.patch
  Subject: Re: 2.5.61-mm1



