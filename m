Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbTDMA5L (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 20:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbTDMA5L (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 20:57:11 -0400
Received: from [12.47.58.73] ([12.47.58.73]:24445 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262674AbTDMA4x (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 20:56:53 -0400
Date: Sat, 12 Apr 2003 18:08:52 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.67-mm2
Message-Id: <20030412180852.77b6c5e8.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Apr 2003 01:08:31.0976 (UTC) FILETIME=[333B7E80:01C30159]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.67/2.5.67-mm2/

. Lots of misc saved-up things.

. I've changed the 32-bit dev_t patch to provide a 12:20 split rather than
  16:16.  This patch is starting to drag a bit and unless someone stops me I
  might just go submit the thing.




Changes since 2.5.67-mm1:


 linus.patch

 Latest -bk

-wait_on_buffer-debug-fix.patch
-gcc-295-required.patch
-remove-nr_reverse_maps.patch
-rmap-search-speedup.patch
-rmap-tweaks.patch
-page-lock-is-spin_lock.patch
-paride-remove-blk_queue_empty.patch
-jbd-warning-fix.patch
-earlier-keyboard-init.patch
-panic-on-oops.patch
-epoll-cross-thread-deletion-fix.patch
-mbcache-missing-brelse.patch
-nfs-read-corruption-fix.patch
-MS_ASYNC-more-async.patch
-tasklist_lock-docco-fix.patch
-posix-timer-hang-fix.patch
-compound-page-fix.patch
-fadvise-file-leak.patch
-conntrack-use-after-free-fix.patch

 Merged

+p4-oprofile-fix.patch

 Try to fix oprofile on P4-HT.  Doesn't work yet.

+flush_workqueue-hang-fix.patch

 Fix a hang with delayed work and workqueue flushing

+ppc64-update-fixes.patch

 Build fixes

+kobject-leak-fix.patch

 Plug an error-path memleak

+radix_tree_delete-api-cleanup.patch

 Return a more useful value from radix_tree_delete()

+gen_rtc-compile-fix.patch

 Fix up gen_rtc.c

-ptrace-flush.patch

 Dropped - it was never right and it conflicted with the flush_page_to_ram()
 removal patch.

+sched_idle-typo-fix.patch

 Use the right priority array

+ext3-quota-deadlock-fix.patch

 Fix a lock ranking problem with ext3 and quotas

+dont-clear-PG_uptodate-on-ENOSPC.patch

 Don't mark a page non-uptodate if writeout ran out of disk space.

+stack-protection-fix.patch

 Use the right permissions on the stack segment

+sparc-PTE_FILE_MAX_BITS-fix.patch

 Teach remap_file_pages() about sparc32.

+bootmem-speedup.patch

 Solve some boot-time search complexity problems

+mem_map-init-arch-hooks.patch

 Let ia64 get at mem_map[] initialisation.  For virtually-addressed
 mem_map[].

+posix-timer-hang-fix-2.patch

 Stuff from George.

+tty-modem-control-api.patch

 Internal API for diddling RTS/CTS/etc.  So other parts of the kernel don't
 have to cook up ioctl() calls.

+kmalloc_sizes-fix.patch

 Fix the fix for the cleanup of the kmalloc_sizes array.

+proc-interrupts-kmalloc-size.patch

 Pile more kludges on the last lot.

+setserial-fix.patch

 Return the right thing from uart_set_info()

+objrmap-sort-vma-list.patch

 Broken back out of the objrmap patch.  It is still in a bit of flux.

+objrmap-vma-sorting-fix.patch

 Fixes for the i_mmap and i_mmap_shared list sorting.

+i8042-share-irqs.patch

 Teach the i8042 driver to share irq12

-earlier-keyboard-init.patch

 Seems to be breaking things.

+vmalloc-stats.patch

 Display info about the vmalloc arena state in /proc/meminfo

+meminfo-doc.patch

 Documentation for /proc/meminfo

+gfp_repeat.patch

 Implement __GFP_REPEAT: so we can consolidate lots of alloc-with-retry code.

+alloc_buffer_head-take-gfp.patch

 alloc_buffer_head() should not be assuming the allocation mode.

+pte_alloc_one-use-gfp_repeat.patch

 Use __GFP_REPEAT for pte page allocations.

+pmd_alloc_one-use-gfp_repeat.patch

 Use __GFP_REPEAT for pmd page allocations.

-dynamic-hd_struct-allocation-fixes.patch

 Folded into dynamic-hd_struct-allocation.patch

+dynamic-hd_struct-devfs-fix.patch

 Fix the dymamic hd_struct allocation patch for devfs

+lockmeter.patch

 Spinlock contention metering code.  See

	http://oss.sgi.com/projects/lockmeter/



All 104 patches

linus.patch

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kgdb-ga-warning-fix.patch
  -mm traps.c warning

kgdb-ga-up-warning-fix.patch

p4-oprofile-fix.patch
  Fix oprofile on P4's

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

kobject-leak-fix.patch
  kobject hotplug fixes

radix_tree_delete-api-cleanup.patch
  radix_tree_delete API improvement

gen_rtc-compile-fix.patch
  Fix gen_rtc compilation error

buffer-debug.patch
  buffer.c debugging

warn-null-wakeup.patch
  remove the test for null waitqueue in __wake_up()

remove-flush_page_to_ram.patch
  Remove flush_page_to_ram()

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

ext3-quota-deadlock-fix.patch
  Fix deadlock with ext3+quota

dont-clear-PG_uptodate-on-ENOSPC.patch
  don't clear PG_uptodate on ENOSPC

stack-protection-fix.patch
  Subject: [patch] correct vm_page_prot on stack pages

sparc-PTE_FILE_MAX_BITS-fix.patch
  Variable PTE_FILE_MAX_BITS

file_lock-spinlock.patch
  convert file_lock to a spinlock

bootmem-speedup.patch
  bootmem speedup from the IA64 tree

mem_map-init-arch-hooks.patch
  architecture hooks for mem_map initialization

posix-timer-hang-fix-2.patch
  Posix timer hang fix

tty-modem-control-api.patch
  Subject: Re: uart_ioctl OOPS with irtty-sir

kmalloc_sizes-fix.patch
  Fix kmalloc_sizes[] indexing

proc-interrupts-kmalloc-size.patch
  /proc/interrupts allocates too much memory

setserial-fix.patch
  Subject: [PATCH 2.5] Minor fix for driver/serial/core.c

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

vmalloc-stats.patch
  vmalloc stats in /proc/meminfo

meminfo-doc.patch
  /proc/meminfo documentation

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

percpu_counter.patch
  percpu_counters: approximate but scalable counters

blockgroup_lock.patch
  blockgroup_lock: hashed spinlocks for ext2 and ext3 blockgroup locking

ext2-no-lock_super-ng.patch
  use spinlocking in the ext2 block allocator

ext2-ialloc-no-lock_super-ng.patch
  use spinlocking in the ext2 inode allocator

dev_t-32-bit.patch
  [for playing only] change type of dev_t

dev_t-remove-B_FREE.patch
  dev_t: eliminate B_FREE

sg-dev_t-fix.patch
  32-bit dev_t fix for sg

xfs-dev_t-warning-fix.patch
  xfs dev_t printk warning fix

init-sections-in-kallsyms.patch
  Put all functions in kallsyms

aggregated-disk-stats.patch
  Aggregated disk statistics

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

usb-disconnect-crash-fix.patch
  Subject: Re: [linux-usb-devel] timer hang with current 2.5 BK

lockmeter.patch

ext3-no-bkl.patch

journal_dirty_metadata-speedup.patch

journal_get_write_access-speedup.patch

ext3-concurrent-block-inode-allocation.patch
  Subject: [PATCH] concurrent block/inode allocation for EXT3

ext3-concurrent-block-allocation-fix-1.patch

ext3-concurrent-block-allocation-hashed.patch
  Subject: Re: [PATCH] concurrent block/inode allocation for EXT3



