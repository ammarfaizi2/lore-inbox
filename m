Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263342AbTB0KsJ>; Thu, 27 Feb 2003 05:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263366AbTB0KsJ>; Thu, 27 Feb 2003 05:48:09 -0500
Received: from packet.digeo.com ([12.110.80.53]:39920 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263342AbTB0KsC>;
	Thu, 27 Feb 2003 05:48:02 -0500
Date: Thu, 27 Feb 2003 02:59:00 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.63-mm1
Message-Id: <20030227025900.1205425a.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Feb 2003 10:58:14.0635 (UTC) FILETIME=[205A0BB0:01C2DE4F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.63/2.5.63-mm1/

. Tons of changes to the anticipatory scheduler.  It may not be working
  very well at present.  Please use "elevator=deadline" if it causes
  problems.

. Updated smalldevfs patch.

. A fix for the VMA-based reverse mapping patch.

. Added Ingo's latest CPU scheduler update.

. Lots of random fixes.



 linus.patch

 Latest from Linus

-initial-jiffies.patch
-user-times-jiffies-wrap-fix.patch
-put_page-speedup.patch
-slab-batchcount-limit-fix.patch
-crc32-speedup-2.patch
-flush-tlb-all-2.patch
-linux-2.5.62-early_ioremap_A0.patch
-linux-2.5.62-x440disco_A0.patch
-use-find_get_page.patch
-irda-interruptible-sleep.patch
-dget-BUG.patch
-disk-accounting-fix.patch
-hugh-inode-pruning-race-fix.patch
-kill-bogus-wakeup-messge.patch
-dont-sync-with-stopped-pdflush.patch
-irq-balance-disable-fix.patch
-oom-killer-dont-spin-on-same-task.patch
-add-missing-global_flush_tlb-calls.patch
-ext3-O_SYNC-speedup.patch
-remove-MAX_BLKDEV-from-genhd.patch

 Merged

+separate.patch

 My contribution to the spelling bee.

+rpc_rmdir-fix.patch

 Fix the NFS oops

+ppc64-scruffiness.patch

 Fix some warnings

-reiserfs_file_write-4.patch
+reiserfs_file_write-5.patch

 Updated (I don't think it changed)

+limit-write-latency.patch

 Fix potential source of write-vs-write latency in VFS

+lockd-lockup-fix-2.patch

 Updated patch from Neil for an NFS server deadlock

+loop-hack.patch

 Fix an OOM and oops in loop

+flock-fix.patch

 File locking fix from Matthew

+sysfs-dget-fix-2.patch

 Fix a sysfs dentry race (this isn't right)

+irq-sharing-fix.patch

 Fix SA_INTERRUPT for shared interrupts

+anticipation_is_killing_me.patch
+as-fix-hughs-problem.patch
+as-cleanup.patch
+as-start-stop-anticipation-helpers.patch
+as-cleanup-2.patch
+as-cleanup-3.patch
+as-cleanup-3-write-latency-fix.patch
+as-handle-exitted-tasks.patch
+as-handle-exitted-tasks-fix.patch
+as-no-plugging-and-cleanups.patch
+as-remove-debug.patch
+as-track-queued-reads.patch
+as-accounting-fix.patch
+as-nr_reads-fix.patch
+as-tuning.patch
+as-disable-nr_reads.patch

 Anticipatory scheduler work

 smalldevfs.patch

 Updated

-smalldevfs-dcache_rcu-fix.patch

 Folded into smalldevfs.patch

+objrmap-X-fix.patch

 Fix VMA-based reverse mapping

+per-cpu-disk-stats.patch

 Use per-cpu data for disk accounting

+presto_get_sb-fix.patch

 Fix an intermezzo oops

+on_each_cpu.patch
+on_each_cpu-ldt-cleanup.patch

 preempt-safety for smp_call_function()

+notsc-panic.patch

 x86 TSC cleanup

+alloc_pages_cleanup.patch

 Code consolidation

+ext2-handle-htree-flag.patch

 ext2 htree back-compatibility

+sched-a3.patch

 CPU scheduler update

+mpparse-typo-fix.patch

 Fix a printk bug

+i386-no-swap-fix.patch

 Fix ia32 CONFIG_SWAP=n

+remove-hugetlb_key.patch
+hugetlbpage-doc-update.patch
+hugetlb-valid-page-ranges.patch

 Hugetlbpage work




All 88 patches:

linus.patch
  Latest from Linus

separate.patch

mm.patch
  add -mmN to EXTRAVERSION

rpc_rmdir-fix.patch
  Fix nfs oops during mount

ppc64-reloc_hide.patch

ppc64-pci-patch.patch
  Subject: pci patch

ppc64-e100-fix.patch
  fix e100 for big-endian machines

ppc64-aio-32bit-emulation.patch
  32/64bit emulation for aio

ppc64-64-bit-exec-fix.patch
  Subject: 64bit exec

ppc64-scruffiness.patch
  Fix some PPC64 compile warnings

sym-do-160.patch
  make the SYM driver do 160 MB/sec

kgdb.patch

nfsd-disable-softirq.patch
  Fix race in svcsock.c in 2.5.61

report-lost-ticks.patch
  make lost-tick detection more informative

devfs-fix.patch

ptrace-flush.patch
  cache flushing in the ptrace code

buffer-debug.patch
  buffer.c debugging

warn-null-wakeup.patch

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

deadline-dispatching-fix.patch
  deadline IO scheduler dispatching fix

nfs-unstable-pages.patch
  "unstable" page accounting for NFS.

limit-write-latency.patch

reiserfs_file_write-5.patch

tcp-wakeups.patch
  Use fast wakeups in TCP/IPV4

lockd-lockup-fix-2.patch
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

linux-isp.patch

isp-update-1.patch

remove-unused-congestion-stuff.patch
  Subject: [PATCH] remove unused congestion stuff

aic-makefile-fix.patch
  aicasm Makefile fix

loop-hack.patch
  loop: Fix OOM and oops

atm_dev_sem.patch
  convert atm_dev_lock from spinlock to semaphore

flock-fix.patch
  flock fixes for 2.5.62

sysfs-dget-fix-2.patch

irq-sharing-fix.patch
  fix irq sharing and SA_INTERRUPT on x86

as-iosched.patch
  anticipatory I/O scheduler

as-comments-and-tweaks.patch
  antsched: commentary and

as-hz-1000-fix.patch
  Fix anticipatory scheduler for HZ=100

as-tidy-up-rename.patch
  tidy up AS rename

anticipation_is_killing_me.patch

as-update-1.patch
  AS update

as-break-anticipation-on-write.patch
  AS break on write

as-break-if-readahead.patch
  detect overlapping reads and writes

as-fix-hughs-problem.patch
  Add a pointer to the queue into struct as_data

as-cleanup.patch
  anticipatory scheduler cleanups

as-start-stop-anticipation-helpers.patch
  AS: add anticipation stop/start helper functions

as-cleanup-2.patch
  Subject: [PATCH] some cleanups 2

as-cleanup-3.patch
  AS: more cleanups

as-cleanup-3-write-latency-fix.patch
  Fix as-cleanup-3

as-handle-exitted-tasks.patch

as-handle-exitted-tasks-fix.patch
  fix for as IO contexts

as-no-plugging-and-cleanups.patch
  AS no plugging + cleanups

as-remove-debug.patch

as-track-queued-reads.patch
  AS: track queued reads

as-accounting-fix.patch
  AS: track queued reads (fix)

as-nr_reads-fix.patch
  AS: read accounting fix

as-tuning.patch
  AS: tuning

as-disable-nr_reads.patch
  AS: disable per-process in-flight read logic

readahead-shrink-to-zero.patch
  Allow VFS readahead to fall to zero

cfq-2.patch
  CFQ scheduler, #2

smalldevfs.patch
  smalldevfs

objrmap-2.5.62-5.patch
  object-based rmap

objrmap-X-fix.patch
  objrmap fix for X

oprofile-up-fix.patch
  fix oprofile on UP (lockless sync)

update_atime-speedup.patch
  speed up update_atime()

ext2-update_atime_speedup.patch
  Use one_sec_update_atime in ext2

ext3-update_atime_speedup.patch
  Use one_sec_update_atime in ext2

UPDATE_ATIME-to-update_atime.patch
  Rename UPDATE_ATIME to update_atime

per-cpu-disk-stats.patch
  Make diskstats per-cpu using kmalloc_percpu

presto_get_sb-fix.patch
  fix presto_get_sb() return value and oops.

on_each_cpu.patch
  fix preempt-issues with smp_call_function()

on_each_cpu-ldt-cleanup.patch

notsc-panic.patch
  Don't panic if TSC is enabled and notsc is used

alloc_pages_cleanup.patch
  clean up redundant code for alloc_pages

ext2-handle-htree-flag.patch
  ext2: clear ext3 htree flag on directories

sched-a3.patch
  "HT scheduler", sched-2.5.63-A3

mpparse-typo-fix.patch
  fix typo in arch/i386/kernel/mpparse.c in printk

i386-no-swap-fix.patch
  allow CONFIG_SWAP=n for i386

remove-hugetlb_key.patch
  remove dead hugetlb_key forward decl

hugetlbpage-doc-update.patch
  hugetlbpage documentation update

hugetlb-valid-page-ranges.patch
  hugetlb: fix MAP_FIXED handling



