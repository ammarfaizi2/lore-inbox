Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267758AbTBGJ3U>; Fri, 7 Feb 2003 04:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267761AbTBGJ3U>; Fri, 7 Feb 2003 04:29:20 -0500
Received: from packet.digeo.com ([12.110.80.53]:58606 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267758AbTBGJ3E>;
	Fri, 7 Feb 2003 04:29:04 -0500
Date: Fri, 7 Feb 2003 01:39:21 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.59-mm9
Message-Id: <20030207013921.0594df03.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Feb 2003 09:38:36.0374 (UTC) FILETIME=[B0064760:01C2CE8C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.59/2.5.59-mm9/

. Adam's cleanup and cutdown of devfs has been put back in again.  We
  really need devfs users to test this and to report, please.  (And not just
  to me!  I'll only bounce it to Adam J.  Richter <adam@yggdrasil.com>
  anyway)

  Adam has a userspace helper app `devfs-helper' at

  	ftp://ftp.yggdrasil.com/pub/dist/device_control/devfs/

. The I/O scheduler changes here are stable now.  All-round peformance is
  OK.

  I've been using it on the desktop for a week.  Certain operations are
  noticeably different; for example a big `cvs co' would previously have had
  several-second stalls every 20 seconds or so.  Now, things slow down but it
  keeps going.  I'm sure the overall runtime will be slightly increased, but
  overall the decreased read latency is good.

. dcache_rcu has been put back.



Changes since 2.5.59-mm8:


-reiserfs-readpages.patch
-fadvise.patch
-auto-unplug.patch
-less-unplugging.patch
-kirq.patch
-kirq-up-fix.patch
-agp-warning-fix.patch
-prune-icache-stats.patch
-vma-file-merge.patch
-mmap-whitespace.patch
-read_cache_pages-cleanup.patch
-remove-GFP_HIGHIO.patch
-wli-11_pgd_ctor.patch
-wli-11_pgd_ctor-update.patch
-smaller-slab-batches.patch
-printk-locking.patch
-hangcheck-timer.patch
-jbd-documentation.patch
-sendfile-security-hooks.patch
-mmzone-parens.patch
-no_space_in_slabnames.patch
-remove-will_become_orphaned_pgrp.patch
-MAX_IO_APICS-ifdef.patch
-dac960-error-retry.patch
-topology-remove-underbars.patch
-put_user-warning-fix.patch
-hash-warnings.patch
-mark_inode_dirty-race.patch
-lost-tick.patch
-seq_file-page-defn.patch
-scsi-iothread.patch
-writeback-sync-cleanup.patch
-dont-wait-on-inode.patch
-unlink-latency-fix.patch
-pin_page-fix.patch
-pin_page-pmd.patch
-frlock-xtime.patch
-frlock-xtime-i386.patch
-frlock-xtime-ia64.patch
-frlock-xtime-other.patch
-seqlock.patch
-do_gettimeofday-speedup.patch
-default_idle-speedup.patch
-pte_chain_alloc-fixes.patch
-hugetlbfs-set_page_dirty.patch
-compound-pages.patch
-compound-pages-hugetlb.patch
-hugetlbfs-get_unmapped_area.patch
-hugetlbfs-truncate-fix.patch
-hugetlbfs-i_size-fix.patch
-hugetlbfs-cleanup.patch
-hugetlbfs-nopage-cleanup.patch
-hugetlbfs-fault-fix.patch
-hugetlbpage-cleanup.patch
-hugetlb_vmtruncate-fixes.patch
-hugetlb-mremap-fix.patch
-mremap-cleanup.patch
-up-spinlock-debugging.patch

 Merged

+seqlock-fixes.patch

 seqlock tweak

+profiler-per-cpu.patch

 Use per-cpu data for the kernel profiler

+disassociate_tty-fix.patch

 TTY layer race fix

+crc32-speedup.patch

 Faster crc32 implementation

+report-lost-ticks.patch

 Add some controls to the ia32 lost tick detector.

-scheduler-update.patch
+sched-2.5.59-F3.patch

 Ingo's latest HT-aware CPU scheduler changes

+generic_file_aio_write_nolock-overflow-fix.patch

 Fix huge writes on 64-bit machines.

+lockd-lockup-fix.patch

 Maybe fix a knfsd deadlock

+ll_rw_block-fix.patch

 Fix obscure incorrectness when ll_rw_block() is used for IS_SYNC
 operations.

+rcu-stats.patch

 Resusrrect RCU statistics in /proc

+dcache_rcu-fast_walk-revert.patch
+dcache_rcu-main.patch

 Use RCU technology for relieving dcache_lock stress

+cyclone-fixes.patch
+enable-timer_cyclone.patch

 Add support for the x440's timer

+vxfs-memleak-fix.patch

 Fix a memory leak

+smalldevfs.patch

 Simplified devfs

+remove-journal_try_start.patch

 Remove the ext3 code which attempts to avoid blocking kswapd on
 journal_start().

+dac960-range-fix.patch

 DAC960 fix.

+DAC960-maintainer.patch

 Add David

+sys_exit_group-warning-fix.patch

 Fix a compile warning

+nforce2-support.patch

 Support nforce2 IDE controllers




All 43 patches:

linus.patch

seqlock-fixes.patch

kgdb.patch

devfs-fix.patch

ptrace-flush.patch
  Subject: [PATCH] ptrace on 2.5.44

buffer-debug.patch
  buffer.c debugging

warn-null-wakeup.patch

htlb-2.patch
  hugetlb: fix MAP_FIXED handling

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

profiler-per-cpu.patch
  Subject: Re: [patch] Make prof_counter use per-cpu areas patch 1/4 -- x86 arch

oprofile-p4.patch

oprofile_cpu-as-string.patch
  oprofile cpu-as-string

disassociate_tty-fix.patch
  Subject: [PATCH][RESEND 3] disassociate_ctty SMP fix

epoll-update.patch
  epoll timeout and syscall return types ...

mandlock-oops-fix.patch
  ftruncate/truncate oopses with mandatory locking

reiserfs_file_write.patch
  Subject: reiserfs file_write patch

user-process-count-leak.patch
  fix current->user->processes leak

misc.patch
  misc fixes

numaq-ioapic-fix2.patch
  NUMAQ io_apic programming fix

deadline-np-42.patch
  (undescribed patch)

deadline-np-43.patch
  (undescribed patch)

batch-tuning.patch
  I/O scheduler tuning

starvation-by-read-fix.patch
  fix starvation-by-readers in the IO scheduler

crc32-speedup.patch
  crc32 improvements for 2.5

scheduler-tunables.patch
  scheduler tunables

sched-2.5.59-F3.patch
  HT scheduler, sched-2.5.59-F3

rml-scheduler-update2.patch
  rml scheduler tree

report-lost-ticks.patch
  make lost-tick detection more informative

generic_file_aio_write_nolock-overflow-fix.patch
  generic_file_write() overflow fix

lockd-lockup-fix.patch
  Subject: Re: Fw: Re: 2.4.20 NFS server lock-up (SMP)

ll_rw_block-fix.patch
  Fix ll_rw_block() when used for data integrity

rcu-stats.patch
  RCU statistics reporting

dcache_rcu-fast_walk-revert.patch
  dcache_rcu: revert fast_walk code

dcache_rcu-main.patch
  dcache_rcu

cyclone-fixes.patch
  Cyclonetimer fixes

enable-timer_cyclone.patch
  Enable timer_cyclone code

vxfs-memleak-fix.patch
  fix leaks in vxfs_read_fshead()

smalldevfs.patch
  smalldevfs

remove-journal_try_start.patch
  ext3: Remove journal_try_start()

dac960-range-fix.patch
  Subject: [PATCH] DAC960 Stanford Checker fix

DAC960-maintainer.patch
  Add David Olien MAINTAINERs for DAC960

sys_exit_group-warning-fix.patch

nforce2-support.patch
  nforce2 IDE support for the amd74xx driver


