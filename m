Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbTDNIlm (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 04:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262879AbTDNIlm (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 04:41:42 -0400
Received: from [12.47.58.203] ([12.47.58.203]:20073 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262872AbTDNIlb (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 04:41:31 -0400
Date: Mon, 14 Apr 2003 01:53:13 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.67-mm3
Message-Id: <20030414015313.4f6333ad.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Apr 2003 08:53:13.0467 (UTC) FILETIME=[484F24B0:01C30263]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.67/2.5.67-mm3/

A bunch of new fixes, and a framebuffer update.  This should work a bit
better than -mm2.


Changes since 2.5.67-mm2:

-kobject-leak-fix.patch
-radix_tree_delete-api-cleanup.patch
-gen_rtc-compile-fix.patch
-warn-null-wakeup.patch
-remove-flush_page_to_ram.patch
-ext3-quota-deadlock-fix.patch
-dont-clear-PG_uptodate-on-ENOSPC.patch
-stack-protection-fix.patch
-sparc-PTE_FILE_MAX_BITS-fix.patch
-file_lock-spinlock.patch
-bootmem-speedup.patch
-mem_map-init-arch-hooks.patch
-tty-modem-control-api.patch
-kmalloc_sizes-fix.patch
-proc-interrupts-kmalloc-size.patch
-vmalloc-stats.patch
-meminfo-doc.patch
-percpu_counter.patch
-blockgroup_lock.patch
-ext2-no-lock_super-ng.patch
-ext2-ialloc-no-lock_super-ng.patch
-init-sections-in-kallsyms.patch

 Merged

+devclass-oops-workaround.patch

 Work around a kobject oops-on-boot

+ipip_err-compile-fix.patch

 Fix a build problem

 p4-oprofile-fix.patch

 This works now.

+genrtc-jiffies-fix.patch

 Compile warning fix (bugfix on 64-bit machines)

+export-kernel_fpu_begin.patch

 Fix modular RAID build

+tasklist_lock-dcache_lock-inversion-fix.patch

 Fix a deadlock

+vsyscall-unwinding.patch

 Stack unwinding code for vsyscalls

+mce-workqueue-startup-fix.patch

 Should fix a startup oops

+1394-compile-fix.patch

 Fix 1394 build

+nfs-resource-management.patch

 Fix NFS VM conniptions.

+fremap-all-mappings.patch

 Bring this back: it prefaults executable mmaps and speeds up
 application launching.

+lockmeter-fixes.patch

 Fix CONFIG_PREEMPT

+fbdev.patch

 Framebuffer update




All 94 patches

linus.patch

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kgdb-ga-warning-fix.patch
  -mm traps.c warning

kgdb-ga-up-warning-fix.patch

devclass-oops-workaround.patch
  work around oops in devclass_add_driver()

ipip_err-compile-fix.patch

p4-oprofile-fix.patch
  Fix oprofile on hyperthreaded P4's

flush_workqueue-hang-fix.patch
  flush_work_queue() fixes

tty-shutdown-race-fix.patch
  fix tty shutdown race

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

genrtc-jiffies-fix.patch
  genrtc: jiffies type fix

export-kernel_fpu_begin.patch
  export kernel_fpu_begin() to modules

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

posix-timer-hang-fix-2.patch
  Posix timer hang fix

tasklist_lock-dcache_lock-inversion-fix.patch
  Fix deadlock between tasklist_lock and dcache_lock

vsyscall-unwinding.patch
  Subject: unwinding for vsyscall code

mce-workqueue-startup-fix.patch
  fix MCE startup ordering problems

setserial-fix.patch
  Subject: [PATCH 2.5] Minor fix for driver/serial/core.c

1394-compile-fix.patch
  Fix iee1394 nodemgr.c compile

nfs-resource-management.patch
  Subject: Resource management for NFS...

kblockd.patch
  Create `kblockd' workqueue

as-iosched.patch
  anticipatory I/O scheduler

as-np-reads-1.patch
  AS: read-vs-read fixes

as-np-reads-2.patch
  AS: more read-vs-read fixes

as-predict-data-direction.patch
  as: predict direction of next IO

as-remove-frontmerge.patch
  AS: remove frontmerge tunable

as-misc-cleanups.patch
  AS: misc cleanups

as-minor-tweaks.patch
  AS: tuning and tweaks

as-remove-stats.patch
  AS: remove statistics

as-locking-fix.patch
  AS: Fix minor race

as-disable-thinktime.patch

as-use-queue_empty.patch
  AS: Use the queue_empty API

cfq-2.patch
  CFQ scheduler, #2

unplug-use-kblockd.patch
  Use kblockd for running request queues

objrmap.patch
  object-based rmap

objrmap-sort-vma-list.patch
  objrmap: optimise per-mapping vma searches

objrmap-vma-sorting-fix.patch
  fix obj vma sorting

fremap-all-mappings.patch
  Make all executable mappings be nonlinear

32bit-dev_t-nfs-export-fix.patch
  Fix nfsd exports with big dev_t

sched-2.5.64-D3.patch
  sched-2.5.64-D3, more interactivity changes

scheduler-tunables.patch
  scheduler tunables

show_task-free-stack-fix.patch
  show_task() fix and cleanup

yellowfin-set_bit-fix.patch
  yellowfin driver set_bit fix

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

dynamic-hd_struct-allocation.patch
  Allocate hd_structs dynamically

dynamic-hd_struct-devfs-fix.patch
  Fix dynamic hd_struct allocation for devfs

slab_store_user-large-objects.patch
  slab debug: perform redzoning against larger objects

htree-nfs-fix-2.patch
  htree nfs fix

put_task_struct-debug.patch

dev_t-32-bit.patch
  [for playing only] change type of dev_t

dev_t-remove-B_FREE.patch
  dev_t: eliminate B_FREE

sg-dev_t-fix.patch
  32-bit dev_t fix for sg

xfs-dev_t-warning-fix.patch
  xfs dev_t printk warning fix

aggregated-disk-stats.patch
  Aggregated disk statistics

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

usb-disconnect-crash-fix.patch
  Subject: Re: [linux-usb-devel] timer hang with current 2.5 BK

lockmeter.patch

lockmeter-fixes.patch

ext3-no-bkl.patch

journal_dirty_metadata-speedup.patch

journal_get_write_access-speedup.patch

ext3-concurrent-block-inode-allocation.patch
  Subject: [PATCH] concurrent block/inode allocation for EXT3

ext3-concurrent-block-allocation-fix-1.patch

ext3-concurrent-block-allocation-hashed.patch
  Subject: Re: [PATCH] concurrent block/inode allocation for EXT3

fbdev.patch



