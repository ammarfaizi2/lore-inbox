Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262354AbTCRLBQ>; Tue, 18 Mar 2003 06:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262357AbTCRLBQ>; Tue, 18 Mar 2003 06:01:16 -0500
Received: from packet.digeo.com ([12.110.80.53]:9614 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262354AbTCRLAO>;
	Tue, 18 Mar 2003 06:00:14 -0500
Date: Tue, 18 Mar 2003 03:11:04 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.65-mm1
Message-Id: <20030318031104.13fb34cc.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Mar 2003 11:10:54.0491 (UTC) FILETIME=[0B1C1EB0:01C2ED3F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.65/2.5.65-mm1/

kernel.org is being slow.   Should later appear at

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.65/2.5.65-mm1/


. An updated version of Russell's PCMCIA patches

. Lots more anticipatory scheduler work.

. It turns out that calling disk request_fns from timer/tasklet context is
  not permitted because a few old drivers like to sleep in that function. 

  keventd cannot be used for this because it can deadlock.  So another
  kernel thread per CPU has been reluctantly added.



Changes since 2.5.64-mm8:

-fix-mem-equals.patch
-hugetlb-unmap_vmas-fix.patch
-early-writeback-init.patch
-e100-memleak-fix.patch
-ext2-ext3-noatime-fix.patch
-ext2-balloc-fix.patch
-pci-6.patch
-pci-7.patch
-pci-8.patch
-pci-9.patch
-pci-10.patch
-pci-11.patch
-pci-12.patch
-pci-13.patch
-pci-14.patch
-pci-15.patch
-pci-update-1.patch
-aio-bits-fix.patch
-clean-inode-fix.patch
-affs-lock_kernel-fix.patch
-raid0-oops-fix.patch

 Merged

+kgdb-cleanup.patch

 Tidy up the kgdb stub a little

+kblockd.patch

 Kernel threads for running disk request functions.

+as-np-1.patch
+as-use-kblockd.patch
+as-cleanup-2.patch
+as-as_remove_request-simplification.patch
+as-dont-go-BUG-again.patch
+as-handle-non-block-requests.patch
+as-np-reads-1.patch
+as-np-reads-2.patch

 Anticipatory scheduler work

-unplug-from-timer.patch

 request_fns cannot be called from timer context

+unplug-use-kblockd.patch

 Call request_fns from kblockd, not keventd.

+sched-2.5.64-D3.patch

 Interactivity work

-scheduler-starvation-fixes.patch

 Obsoleted by 2.5.65 fixes

-pcmcia-1-kill-get_foo_map.patch
-pcmcia-2-remove-bus_foo-abstractions.patch
-pcmcia-3-add-SOCKET_CARDBUS_CONFIG.patch
-pcmcia-4-add-locking.patch
-pcmcia-5-add-CONFIG_PCMCIA_PROBE.patch
-pcmcia-6-remove-old-cardbus-clients.patch
+pcmcia-2.patch
+pcmcia-3b.patch
+pcmcia-3.patch
+pcmcia-4.patch
+pcmcia-5.patch
+pcmcia-6.patch
+pcmcia-7b.patch
+pcmcia-7.patch
+pcmcia-8.patch
+pcmcia-9.patch
+pcmcia-10.patch

 Updated pcmcia patch series

-ext2-no-lock-super-whitespace-fixes.patch
-ext2-no-lock_super-fix-1.patch
-ext2-no-lock_super-fix-2.patch
-ext2-no-lock_super-fix-3.patch
-ext2-no-lock_super-fix-4.patch
-ext2-no-lock_super-fix-5.patch
-ext2-no-lock_super-fix-6.patch
-ext2-no-lock_super-fix-7.patch
-ext2-no-lock_super-set-s_dirt.patch

 Folded into ext2-no-lock_super.patch

-ext2-ialloc-no-lock_super-fixes.patch

 Folded into ext2-ialloc-no-lock_super.patch

+CONFIG_NUMA-fixes.patch

 Make CONFIG_NUMA harder to enable

+nfsd-symlink-failpath.patch

 knfsd error handling fix

+ide_probe-init_irq-fix.patch

 Fix the sleep-in-spinlock problem in IDE.

+get_disk-error-checking.patch

 sysfs/kobject fix

+raid1-fix.patch

 Fix broken RAID1 resync

+nmi-watchdog-fix.patch

 Fix i386 NMI watchdog

+vm_enough_memory-speedup.patch

 Make vm_enough_memory() more SMP-friendly

+nanosleep-accuracy-fix.patch

 Fix sys_nanosleep() inaccuracy problem



All 115 patches


mm.patch
  add -mmN to EXTRAVERSION

kgdb.patch

kgdb-cleanup.patch
  make kgdb less invasive (when disabled)

proc-sys-debug.patch
  create /proc/sys/debug/0 ... 7

noirqbalance-fix.patch
  Fix noirqbalance

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-reloc_hide.patch

ppc64-pci-patch.patch
  Subject: pci patch

ppc64-aio-32bit-emulation.patch
  32/64bit emulation for aio

ppc64-64-bit-exec-fix.patch
  Pass the load address into ELF_PLAT_INIT()

ppc64-scruffiness.patch
  Fix some PPC64 compile warnings

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

tcp-wakeups.patch
  Use fast wakeups in TCP/IPV4

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

remove-unused-congestion-stuff.patch
  Subject: [PATCH] remove unused congestion stuff

kblockd.patch
  Create `kblockd' workqueue

as-iosched.patch
  anticipatory I/O scheduler

as-debug-BUG-fix.patch

as-eject-BUG-fix.patch
  AS: don't go BUG during cdrom eject

as-jumbo-fix.patch
  AS: OSDL fixes

as-request_fn-in-timer.patch
  Remove the scheduled_work thing

as-remove-request-fix.patch

as-np-1.patch
  as: cleanups & comments

as-use-kblockd.patch

as-cleanup-2.patch
  AS: cleanup + comments

as-as_remove_request-simplification.patch
  as: as_remove_request simplification

as-dont-go-BUG-again.patch

as-handle-non-block-requests.patch
  AS: handle non-block requests

as-np-reads-1.patch
  AS: read-vs-read fixes

as-np-reads-2.patch
  AS: more read-vs-read fixes

cfq-2.patch
  CFQ scheduler, #2

unplug-use-kblockd.patch
  Use kblockd for running request queues

smalldevfs.patch
  smalldevfs

remap-file-pages-2.5.63-a1.patch
  Subject: [patch] remap-file-pages-2.5.63-A1

hugh-remap-fix.patch
  hugh's file-offset-in-pte fix

fremap-limit-offsets.patch
  fremap: limit remap_file_pages() file offsets

fremap-all-mappings.patch
  Make all executable mappings be nonlinear

filemap_populate-speedup.patch
  filemap_populate speedup

file-offset-in-pte-x86_64.patch
  x86_64: support for file offsets in pte's

file-offset-in-pte-ppc64.patch

objrmap-2.5.62-5.patch
  object-based rmap

objrmap-nonlinear-fixes.patch
  objrmap fix for nonlinear

sched-2.5.64-D3.patch
  sched-2.5.64-D3, more interactivity changes

scheduler-tunables.patch
  scheduler tunables

timer-cleanup.patch
  timer code cleanup

timer-readdition-fix.patch
  timer re-addition lockup fix

show_task-free-stack-fix.patch
  show_task() fix and cleanup

yellowfin-set_bit-fix.patch
  yellowfin driver set_bit fix

htree-nfs-fix.patch
  Fix ext3 htree / NFS compatibility problems

update_atime-ng.patch
  inode a/c/mtime modification speedup

one-sec-times.patch
  Implement a/c/time speedup in ext2 & ext3

task_prio-fix.patch
  simple task_prio() fix

set_current_state-fs.patch
  use set_current_state in fs

set_current_state-mm.patch
  use set_current_state in mm

copy_thread-leak-fix.patch
  Fix memory leak in copy_thread

slab_store_user-large-objects.patch
  slab debug: perform redzoning against larger objects

file_list_lock-contention-fix.patch
  file_list_lock contention fixes

tty_files-fixes.patch
  file->f_list locking in tty_io.c

file_list_cleanup.patch
  file_list cleanup

file_list-remove-free_list.patch
  file_table: remove the private freelist

file-list-less-locking.patch
  file_list: less locking

vt_ioctl-stack-use.patch
  stack reduction in drivers/char/vt_ioctl.c

no-mmu-stubs.patch
  a few missing stubs for !CONFIG_MMU

nommu-slab.patch
  slab changes for !CONFIG_MMU

nfs-memleak-fix.patch
  memleak in fs/nfs/inode.c::nfs_get_sb()

ufs-memleak-fix.patch
  Memleak in fs/ufs/util.c

posix-timers-update.patch
  posix timers update

pcmcia-2.patch

pcmcia-3b.patch

pcmcia-3.patch

pcmcia-4.patch

pcmcia-5.patch

pcmcia-6.patch

pcmcia-7b.patch

pcmcia-7.patch

pcmcia-8.patch

pcmcia-9.patch

pcmcia-10.patch

oops-counters.patch
  OOPS instance counters

io_apic-DO_ACTION-cleanup.patch
  io-apic.c: DO_ACTION cleanup

oprofile-timer-fix.patch
  fix oprofile timer race

htree-nfs-fix-2.patch
  htree nfs fix

ext2-no-lock_super.patch
  concurrent block allocation for ext2

ext2-ialloc-no-lock_super.patch
  concurrent inode allocation for ext2

brlock-removal-1.patch
  Brlock removal 1/5 - core

brlock-removal-2.patch
  brlock removal 2/5: remove brlock from snap and vlan

brlock-removal-3.patch
  brlock removal 3/5: remove brlock from bridge

brlock-removal-4.patch
  brlock removal 4/5: removal from ipv4/ipv6

brlock-removal-5.patch
  brlock removal 5/5: remove brlock code

pgd_index-comments.patch
  pgd_index/pmd_index/pte_index commentary

proc-sysrq-trigger.patch
  /proc/sysrq-trigger: trigger sysrq functions via /proc

lseek-ext2_readdir.patch
  remove lock_kernel() from readdir implementations.

inode_setattr-lock_kernel-removal.patch
  remove lock_kernel() from inode_setattr's vmtruncate() call

CONFIG_NUMA-fixes.patch
  Tighten CONFIG_NUMA preconditions

nfsd-symlink-failpath.patch
  Fix nfsd_symlink() failure path

ide_probe-init_irq-fix.patch
  ide-probe init_irq cleanup

get_disk-error-checking.patch
  Add error checking get_disk().

raid1-fix.patch
  MD RAID1 fix

nmi-watchdog-fix.patch
  NMI watchdog fix

vm_enough_memory-speedup.patch
  speed up vm_enough_memory()

nanosleep-accuracy-fix.patch
  fix nanosleep() granularity bumps



