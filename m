Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbTDHLLO (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 07:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbTDHLLO (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 07:11:14 -0400
Received: from [12.47.58.221] ([12.47.58.221]:33926 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261306AbTDHLLF (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 07:11:05 -0400
Date: Tue, 8 Apr 2003 04:22:39 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.67-mm1
Message-Id: <20030408042239.053e1d23.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Apr 2003 11:22:24.0640 (UTC) FILETIME=[21254000:01C2FDC1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.67-mm1.gz

  Will appear sometime at

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.67/2.5.67-mm1/


. sparc64 is now using gcc-3.x, so there is a patch here to make gcc-2.95
  the minimum required version.

. A few rmap-speedup patches reduce the rmap CPU tax by 25-30% on a P4

. Various other cleaups, speedups and fixups.




Changes since 2.5.66-mm3:


 linus.patch

 Latest from Linus

-monotonic-clock-hangcheck.patch
-warning-fixes-1.patch
-bio_kmap-fix.patch
-file-limit-checking-cleanup.patch
-tmpfs-1-use-generic_write_checks.patch
-tmpfs-2-remove-shmem_readpage.patch
-tmpfs-3-user-generic_file_llseek.patch
-tmpfs-4-use-mark_page_accessed.patch
-tmpfs-4-use-cond_resched.patch
-tmpfs-6-percentile-sizing.patch
-stat_t-larger-dev_t.patch
-misc.patch
-smp_call_function-barrier.patch
-adaptec-del_timer_sync.patch
-3c59x-980-support.patch
-fadvise-flush-data.patch
-console-scrollback.patch
-devfs-rescan_partitions-fix.patch
-umsdos-fixes.patch
-exp_parent-locking-fix.patch
-real_lookup-race-fix.patch
-remove-dparent_lock.patch
-jbd_expect.patch
-jbd-assert-io-failure-fix.patch
-ext3_mark_inode_dirty-speedup.patch
-ext3_mark_inode_dirty-less-calls.patch
-ext3-handle-cache.patch
-jbd-handle-journal-io-errors.patch

 Merged

+kgdb-ga-up-warning-fix.patch

 Fix a kgb warning

+gcc-295-required.patch

 Require gcc-2.95 or higher.

+dmfe-kfree_skb-fix.patch

 Fix a goes-BUG bug in dmfe.c.

+ppc64-update.patch

 Stuff from Anton.

+remove-nr_reverse_maps.patch

 Remove /proc/meminfo:ReverseMaps.   It is measurably expensive.

+rmap-search-speedup.patch

 Warm up the rmap code.

+rmap-tweaks.patch

 Ditto

+page-lock-is-spin_lock.patch

 Make mapping->page_lock a spinlock.  It is faster than an rwlock.

+file_lock-spinlock.patch

 Ditto file->file_lock

+paride-remove-blk_queue_empty.patch

 Leftovers from the blk_queue_empty() removal

+as-use-queue_empty.patch

 Anticipatory scheduler rework

-fremap-all-mappings.patch

 Accidentally dropped

-objrmap-2.5.62-5.patch
-hugh-04-page_convert_anon-ENOMEM.patch
-hugh-05-page_convert_anon-unlocking.patch
-hugh-06-wrap-below-vm_start.patch
-hugh-07-objrmap-page_table_lock.patch
-hugh-08-rmap-comments.patch
-hugh-11-fix-unuse_pmd-fixme.patch
-tmpfs-blk_congestion_wait-fix.patch
-page_convert_anon-locking-fix.patch
-objrmap-sort-vma-list.patch
-stale-inode-fix.patch

 All rolled together, into objrmap.patch

+objrmap.patch

 Partial objrmap.

+32bit-dev_t-nfs-export-fix.patch

 Make NFS work better with 32-bit dev_t

+jbd-warning-fix.patch

 Fox a compile warning

+earlier-keyboard-init.patch

 Init the keyboard earlier, so sysrq is available

+epoll-cross-thread-deletion-fix.patch

 epoll fix

+mbcache-missing-brelse.patch

 Extended attribute leak fix

+nfs-read-corruption-fix.patch

 NFS read fix from Trond

+MS_ASYNC-more-async.patch

 Make msync(MS_ASYNC) just dirty the pages, and not start any I/O

+tasklist_lock-docco-fix.patch

 Commentary corrections

+dynamic-hd_struct-allocation.patch
+dynamic-hd_struct-allocation-fixes.patch

 Dynamically allocate struct hd_struct, to save RAM with 4000 disks.

+remove-flush_page_to_ram.patch

 Remove flush_page_to_ram()

+nfs-resource-management.patch

 Make NFS play more nicely with the VM/VFS memory balancing.

+compound-page-fix.patch

 Fix futex-in-hugepage, perhaps.

+xfs-dev_t-warning-fix.patch

 Compile warning fix for 32-bit dev-t

+fadvise-file-leak.patch

 fadvise() can leak a file ref



All 97 patches:

linus.patch

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kgdb-ga-warning-fix.patch
  -mm traps.c warning

kgdb-ga-up-warning-fix.patch

wait_on_buffer-debug-fix.patch
  fix wait_on_buffer() debug code

tty-shutdown-race-fix.patch
  fix tty shutdown race

ppa-null-pointer-fix.patch

gcc-295-required.patch
  Enforce gcc-2.95 as the minimum compiler requirement

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

sym-do-160.patch
  make the SYM driver do 160 MB/sec

config-PAGE_OFFSET.patch
  Configurable kenrel/user memory split

ptrace-flush.patch
  cache flushing in the ptrace code

buffer-debug.patch
  buffer.c debugging

warn-null-wakeup.patch

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

reiserfs_file_write-5.patch

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

remove-nr_reverse_maps.patch
  remove nr_reverse_maps VM accounting

rmap-search-speedup.patch
  speed up rmap searching

rmap-tweaks.patch
  misc rmap speedups

page-lock-is-spin_lock.patch
  Replace the radix-tree rwlock with a spinlock

file_lock-spinlock.patch
  convert file_lock to a spinlock

kblockd.patch
  Create `kblockd' workqueue

paride-remove-blk_queue_empty.patch
  fix up the paride driver for blk_queue_empty() removal

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

32bit-dev_t-nfs-export-fix.patch
  Fix nfsd exports with big dev_t

sched-2.5.64-D3.patch
  sched-2.5.64-D3, more interactivity changes

scheduler-tunables.patch
  scheduler tunables

show_task-free-stack-fix.patch
  show_task() fix and cleanup

jbd-warning-fix.patch
  JBD pasting warning fix

yellowfin-set_bit-fix.patch
  yellowfin driver set_bit fix

htree-nfs-fix.patch
  Fix ext3 htree / NFS compatibility problems

task_prio-fix.patch
  simple task_prio() fix

earlier-keyboard-init.patch
  earlier keyboard init

panic-on-oops.patch
  Allow panics and reboots at oops time.

epoll-cross-thread-deletion-fix.patch
  epoll cross-thread deletion fix

mbcache-missing-brelse.patch
  Missing brelse() in ext2/ext3 extended attribute code

nfs-read-corruption-fix.patch
  NFS read corruption fix

MS_ASYNC-more-async.patch
  Make msync(MS_ASYNC) no longer start the I/O

tasklist_lock-docco-fix.patch
  task_lock commentary fixes

posix-timer-hang-fix.patch
  posix_timer hang fix

dynamic-hd_struct-allocation.patch
  Allocate hd_structs dynamically

dynamic-hd_struct-allocation-fixes.patch
  dynamic allocation of hd_structs

remove-flush_page_to_ram.patch
  Remove flush_page_to_ram()

slab_store_user-large-objects.patch
  slab debug: perform redzoning against larger objects

nfs-resource-management.patch
  Subject: Resource management for NFS...

compound-page-fix.patch

htree-nfs-fix-2.patch
  htree nfs fix

put_task_struct-debug.patch

percpu_counter.patch
  percpu_counters: approximate but scalabel counters

blockgroup_lock.patch
  blockgroup_lock: hashed spinlocks for ext2 and ext3 blockgroup locking

ext2-no-lock_super-ng.patch

ext2-ialloc-no-lock_super-ng.patch

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

fadvise-file-leak.patch
  fix file leak in fadvise()

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

usb-disconnect-crash-fix.patch
  Subject: Re: [linux-usb-devel] timer hang with current 2.5 BK

conntrack-use-after-free-fix.patch
  fix use-after-free in ip_conntrack

ext3-no-bkl.patch

journal_dirty_metadata-speedup.patch

journal_get_write_access-speedup.patch

ext3-concurrent-block-inode-allocation.patch
  Subject: [PATCH] concurrent block/inode allocation for EXT3

ext3-concurrent-block-allocation-fix-1.patch

ext3-concurrent-block-allocation-hashed.patch
  Subject: Re: [PATCH] concurrent block/inode allocation for EXT3



