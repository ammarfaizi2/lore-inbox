Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbTBJFgS>; Mon, 10 Feb 2003 00:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbTBJFgS>; Mon, 10 Feb 2003 00:36:18 -0500
Received: from packet.digeo.com ([12.110.80.53]:49363 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263204AbTBJFgO>;
	Mon, 10 Feb 2003 00:36:14 -0500
Date: Sun, 9 Feb 2003 21:46:05 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.59-mm10
Message-Id: <20030209214605.4fc8eb06.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Feb 2003 05:45:52.0841 (UTC) FILETIME=[AC597B90:01C2D0C7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.59/2.5.59-mm10/
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.59/2.5.59-mm10/


. There's nothing particularly notable here.  Most of the changes were in
  the short-lived -mm9.

. There is an anticipatory I/O scheduler update from Nick in experimantal/.


Changes since 2.5.59-mm9:


+oprofile-braino.patch

 Fix oprofile for P4's.

 It works OK for me.  I find oprofile userspace a bit of a pig to work with.
 The magical command to get P4 support working was

	opcontrol --setup --vmlinux=/boot/vmlinux --ctr0-count=600000 \
		--ctr0-unit-mask=1 --ctr0-event=GLOBAL_POWER_EVENTS

-sched-2.5.59-F3.patch
+sched-2.5.59-F3-update.patch

 Newer version of Ingo's scheduler update.

-generic_file_aio_write_nolock-overflow-fix.patch

 Merged

-dcache_rcu-fast_walk-revert.patch
-dcache_rcu-main.patch

 The presence of dcache_rcu is causing the NFS server to fail to start. 
 Something is going wrong deep down in the portmapper pseudo-fs.

 This could well be a problem in the knfsd code - this problem was not
 observed in earlier testing of the same dcache_rcu code.  It needs analysis.


-vxfs-memleak-fix.patch

 Merged
-sys_exit_group-warning-fix.patch

+hugetlbfs-i_size-fix.patch
+hugepage-address-validation.patch

 hugetlb fixes

+radix-tree-rnode-test.patch

 radix-tree cleanup

+ext3-comment-cleanup.patch

 Whitespace

+ext3-journalled-data-assertion-fix.patch

 data=journal fix.  It is still sick; it needs significantly deep
 surgery to get it right.

+ext3_fill_super-no-unlock_super.patch

 cleanup

+remove-buffer_head_mempool.patch

 Remove the mempool which backs buffer_head allocation.  It can cause
 lockups.

+deadline-hash-fix.patch

 Fix a couple of IO scheduler bugs.



All 46 patches

linus.patch

seqlock-fixes.patch

kgdb.patch

devfs-fix.patch

ptrace-flush.patch
  Subject: [PATCH] ptrace on 2.5.44

buffer-debug.patch
  buffer.c debugging

warn-null-wakeup.patch

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

profiler-per-cpu.patch
  Subject: Re: [patch] Make prof_counter use per-cpu areas patch 1/4 -- x86 arch

oprofile-p4.patch

oprofile_cpu-as-string.patch
  oprofile cpu-as-string

oprofile-braino.patch

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

sched-2.5.59-F3-update.patch
  Subject: Re: [patch] HT scheduler, sched-2.5.59-F3

rml-scheduler-update2.patch
  rml scheduler tree

report-lost-ticks.patch
  make lost-tick detection more informative

lockd-lockup-fix.patch
  Subject: Re: Fw: Re: 2.4.20 NFS server lock-up (SMP)

ll_rw_block-fix.patch
  Fix ll_rw_block() when used for data integrity

rcu-stats.patch
  RCU statistics reporting

cyclone-fixes.patch
  Cyclonetimer fixes

enable-timer_cyclone.patch
  Enable timer_cyclone code

smalldevfs.patch
  smalldevfs

remove-journal_try_start.patch
  ext3: Remove journal_try_start()

dac960-range-fix.patch
  Subject: [PATCH] DAC960 Stanford Checker fix

DAC960-maintainer.patch
  Add David Olien MAINTAINERs for DAC960

nforce2-support.patch
  nforce2 IDE support for the amd74xx driver

hugetlbfs-i_size-fix.patch
  hugetlbfs i_size fix

hugepage-address-validation.patch
  hugetlbpage MAP_FIXED fix

radix-tree-rnode-test.patch
  remoe unneeded test from radix_tree_extend()

ext3-comment-cleanup.patch
  ext3 commenting cleanup

ext3-journalled-data-assertion-fix.patch
  Remove incorrect assertion from ext3

ext3_fill_super-no-unlock_super.patch
  Dont run unlock_super() in ext3_fill_super()

remove-buffer_head_mempool.patch

deadline-hash-fix.patch



