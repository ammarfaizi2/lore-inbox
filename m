Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263532AbTDTGBW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 02:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263533AbTDTGBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 02:01:22 -0400
Received: from [12.47.58.203] ([12.47.58.203]:7403 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263532AbTDTGBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 02:01:15 -0400
Date: Sat, 19 Apr 2003 23:13:20 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.68-mm1
Message-Id: <20030419231320.52b2b2ef.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Apr 2003 06:13:08.0126 (UTC) FILETIME=[E98EEBE0:01C30703]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.68/2.5.68-mm1

A few fixes for various things.  mainly a resync with 2.5.68.




Changes since 2.5.67-mm4:


-misc.patch

 merged

-mach_countup-fix.patch

 Fixed in 2.5.68

+3c574-irq-fix.patch

 netdriver fix

+nec98-partitions-fix.patch

 build fix

+timer-pit-race-fix.patch
+lost-tick-fix.patch
-do_timer_overflow-locking-fix.patch

 x86 timer fixes

+pci-bus-ordering-fix.patch

 Make PCI scan ordering the same as 2.4.

-as-iosched.patch
-as-np-reads-1.patch
-as-np-reads-2.patch
-as-predict-data-direction.patch
-as-remove-frontmerge.patch
-as-misc-cleanups.patch
-as-minor-tweaks.patch
-as-remove-stats.patch
-as-locking-fix.patch
-as-use-queue_empty.patch

 Folded into as-iosched.patch

+turn-on-NUMA-rebalancing.patch

 NUMA scheduler fix

+shmdt-speedup.patch

 sysv shm speedup/cleanup

-objrmap-sort-vma-list.patch
-objrmap-vma-sorting-fix.patch

 Folded into objrmap.patch

+shm_get_stat-handle-hugetlb-pages.patch

 shm+hugetlbpage fix

-dynamic-hd_struct-devfs-fix.patch

 Folded into dynamic-hd_struct-allocation.patch

+select-speedup-fix.patch

 Should fix the select() problems in 2.5.67-mm4

+nfsctl-dev_t-fix.patch

 64-bit dev_t fixes.  Replaces 32bit-dev_t-nfs-export-fix.patch





All 106 patches:


mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kobj_lock-fix.patch

3c574-irq-fix.patch
  3c574_cs fixes

nec98-partitions-fix.patch
  Fix nc98 partition parser link error

ppa-null-pointer-fix.patch

dmfe-kfree_skb-fix.patch
  dmfe: don't free skb with local interrupts disabled

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-reloc_hide.patch

ppc64-pci-patch.patch
  Subject: pci patch

ppc64-aio-32bit-emulation.patch
  32/64bit emulation for aio

ppc64-scruffiness.patch
  Fix some PPC64 compile warnings

ppc64-update.patch
  ppc64 update

ppc64-update-fixes.patch

sym-do-160.patch
  make the SYM driver do 160 MB/sec

config-PAGE_OFFSET.patch
  Configurable kenrel/user memory split

buffer-debug.patch
  buffer.c debugging

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

reiserfs_file_write-5.patch

sched_idle-typo-fix.patch
  fix sched_idle typo

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

rpciod-atomic-allocations.patch
  Make rcpiod use atomic allocations

linux-isp.patch

isp-update-1.patch

dentry_stat-accounting-fix.patch
  dentry_stat accounting fix

DCACHE_REFERENCED-fixes.patch
  Fix and clean up DCACHE_REFERENCED usage

posix_timers-CLOCK_MONOTONIC-fix.patch
  Fix POSIX timers to give CLOCK_MONOTONIC full resolution and tie it to xtime instead of jiffies

jiffies_to_timespec-fix.patch
  Fix jiffies_to_time[spec | val] and converse to use actual jiffies increment rather than 1/HZ

timer-pit-race-fix.patch
  get_offset_pit and do_timer_overflow vs IRQ locking

lost-tick-fix.patch
  detect_lost_tick locking fixes

tasklist_lock-dcache_lock-inversion-fix.patch
  Fix deadlock between tasklist_lock and dcache_lock

setserial-fix.patch
  Subject: [PATCH 2.5] Minor fix for driver/serial/core.c

SAK-raw-mode-fix.patch
  keyboard.c Fix SAK in raw mode

pci-bus-ordering-fix.patch
  Make PCI scanning order the same as 2.4

kblockd.patch
  Create `kblockd' workqueue

cfq-infrastructure.patch

elevator-completion-api.patch
  elevator completion API

as-iosched.patch
  anticipatory I/O scheduler

as-use-completion.patch
  AS use completion notifier

unplug-use-kblockd.patch
  Use kblockd for running request queues

cfq-2.patch
  CFQ scheduler, #2

turn-on-NUMA-rebalancing.patch
  Turn on NUMA rebalancing

unmap-page-debugging.patch
  unmap unused pages for debugging

unmap-page-debugging-fixes.patch

global_flush_tlb-irqs-check.patch

unmap-page-debugging-fixes-2.patch

pcmcia-deadlock-fix.patch

move-__set_page_dirty-buffers.patch
  Move __set_page_dirty_buffers to fs/buffer.c

buffers-cleanup.patch
  Clean up various buffer-head dependencies

follow_hugetlb_page-fix.patch
  follow_hugetlb_page fix

hugetlb-overflow-fix.patch
  hugetlb math overflow fix

mach64-build-fix.patch
  ATI Mach64 build fix

sync-all-quotas.patch
  quotactl(): sync all quotas

aio-mmap-fix.patch
  AIO mmap fix

shmdt-speedup.patch
  shmdt() speedup

objrmap.patch
  object-based rmap

fremap-all-mappings.patch
  Make all executable mappings be nonlinear

sched-2.5.64-D3.patch
  sched-2.5.64-D3, more interactivity changes

scheduler-tunables.patch
  scheduler tunables

show_task-free-stack-fix.patch
  show_task() fix and cleanup

yellowfin-set_bit-fix.patch
  yellowfin driver set_bit fix

generic-bitops-update.patch
  include/asm-generic/bitops.h {set,clear}_bit return  void

htree-nfs-fix.patch
  Fix ext3 htree / NFS compatibility problems

task_prio-fix.patch
  simple task_prio() fix

i8042-share-irqs.patch
  allow i8042 interrupt sharing

gfp_repeat.patch
  implement __GFP_REPEAT

alloc_buffer_head-take-gfp.patch
  make alloc_buffer_head take gfp_flags

pte_alloc_one-use-gfp_repeat.patch
  use __GFP_REPEAT in pte_alloc_one()

pmd_alloc_one-use-gfp_repeat.patch
  use __GFP_REPEAT in pmd_alloc_one()

overcommit-stop-swapoff.patch
  Disallow swapoff if there is insufficient memory

interruptible-swapoff.patch
  Permit interruption of swapoff

oomkill-swapoff.patch
  oom-kill: preferentially kill swapoff

dac960-bounce-avoidance.patch
  DAC960: add call to blk_queue_bounce_limit

shm_get_stat-handle-hugetlb-pages.patch
  Handle hugepages in shm_get_stat()

dynamic-hd_struct-allocation.patch
  Allocate hd_structs dynamically

NOMMU-merge-fixes.patch
  fix CONFIG_NOMMU mismerges

vmap-extensions.patch
  Extend map_vm_area()/get_vm_area()

select-speedup.patch
  Subject: Re: IA64 changes to fs/select.c

select-speedup-fix.patch
  select() sleedup fix

slab_store_user-large-objects.patch
  slab debug: perform redzoning against larger objects

dont-shrink-slab-for-highmem.patch
  don't shrink slab for highmem allocations

htree-nfs-fix-2.patch
  htree nfs fix

htree-leak-fix.patch
  ext3: htree memory leak fix

put_task_struct-debug.patch

ia32-mknod64.patch
  mknod64 for ia32

dm-larger-dev_t-fix.patch
  Subject: Re: 2.5.67-mm2

ext2-64-bit-special-inodes.patch
  ext2: support for 64-bit device nodes

ext3-64-bit-special-inodes.patch
  ext3: support for 64-bit device nodes

rdev-for-samba.patch
  From: Andries.Brouwer@cwi.nl
  Subject: [PATCH] rdev for samba

nfsctl-dev_t-fix.patch
  Fix nfsctl for larger dev_t

64-bit-dev_t-kdev_t.patch
  64-bit dev_t and kdev_t

aggregated-disk-stats.patch
  Aggregated disk statistics

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

ext3-no-bkl.patch

journal_dirty_metadata-speedup.patch

journal_get_write_access-speedup.patch

ext3-concurrent-block-inode-allocation.patch
  Subject: [PATCH] concurrent block/inode allocation for EXT3

ext3-orlov-approx-counter-fix.patch
  Fix orlov allocator boundary case

ext3-concurrent-block-allocation-fix-1.patch

ext3-concurrent-block-allocation-hashed.patch
  Subject: Re: [PATCH] concurrent block/inode allocation for EXT3



