Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262951AbTCSJKT>; Wed, 19 Mar 2003 04:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262952AbTCSJKS>; Wed, 19 Mar 2003 04:10:18 -0500
Received: from packet.digeo.com ([12.110.80.53]:52660 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262951AbTCSJKM>;
	Wed, 19 Mar 2003 04:10:12 -0500
Date: Wed, 19 Mar 2003 01:21:15 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.65-mm2
Message-Id: <20030319012115.466970fd.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Mar 2003 09:20:55.0300 (UTC) FILETIME=[D8193C40:01C2EDF8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.65/2.5.65-mm2/

will appear sometime at:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.65/2.5.65-mm2/


. Added all the 32-bit dev_t patches.

. An update to the brlock-removal patches which might fix the reported
  netfilter problems (would like confirmation of this please).



Changes since 2.5.65-mm1:


+linus.patch

 Latest from Linus

-noirqbalance-fix.patch
-ppc64-64-bit-exec-fix.patch
-remove-unused-congestion-stuff.patch
-smalldevfs.patch
-timer-cleanup.patch
-timer-readdition-fix.patch
-set_current_state-fs.patch
-set_current_state-mm.patch
-copy_thread-leak-fix.patch
-file_list_lock-contention-fix.patch
-tty_files-fixes.patch
-file_list_cleanup.patch
-file_list-remove-free_list.patch
-file-list-less-locking.patch
-vt_ioctl-stack-use.patch
-no-mmu-stubs.patch
-nommu-slab.patch
-nfs-memleak-fix.patch
-ufs-memleak-fix.patch
-posix-timers-update.patch
-oops-counters.patch
-io_apic-DO_ACTION-cleanup.patch
-oprofile-timer-fix.patch
-pgd_index-comments.patch
-proc-sysrq-trigger.patch
-CONFIG_NUMA-fixes.patch
-nfsd-symlink-failpath.patch
-get_disk-error-checking.patch
-nanosleep-accuracy-fix.patch

 Merged

+as-predict-data-direction.patch

 Anticipatory scheduler work: starting to track per-process behaviour a
 little more.

-brlock-removal-1.patch
+brlock-1b.patch

 Updated (might fix a netfilter problem)

+nanosleep-accuracy-fix-2.patch

 Another go at fixing the nanosleep() inaccuracy.

+linear-oops-fix-1.patch

 Fix oops in the MD linear driver

+dev_t-1-kill-cdev.patch
+dev_t-2-remove-MAX_CHRDEV.patch
+dev_t-3-major_h-cleanup.patch
+dev_t-32-bit.patch
+dev_t-drm-warnings.patch
+dev_t-remove-B_FREE.patch

 32-bit dev_t work

+cpufreq-xtime-locking.patch

 locking fix

+cs46xx-fixes.patch

 Minor fixes

+notsclock-option.patch

 Add "notsclock" boot option for misbehaving SpeedStep machines.

+tty-put_user-checks.patch

 Fix some missing uaccess checks.

+fail-setup_irq-for-unconfigured-IRQs.patch

 Stuff from Zwane.

+raw-fix-address_space-rewriting.patch
+raw-cleanups-and-fixlets.patch

 Fixes for the raw driver

+oops-dump-preceding-code.patch

 Make the ia32 oops code dump instructions which preceded the failing EIP. 
 Keith has ksymoops support for this and it works nicely.  I'm not sure what
 his plans are for adding it to a released version.



All 105 patches:

linus.patch
  Latest from Linus

mm.patch
  add -mmN to EXTRAVERSION

kgdb.patch

kgdb-cleanup.patch
  make kgdb less invasive (when disabled)

proc-sys-debug.patch
  create /proc/sys/debug/0 ... 7

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-reloc_hide.patch

ppc64-pci-patch.patch
  Subject: pci patch

ppc64-aio-32bit-emulation.patch
  32/64bit emulation for aio

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

as-predict-data-direction.patch
  as: predict direction of next IO

cfq-2.patch
  CFQ scheduler, #2

unplug-use-kblockd.patch
  Use kblockd for running request queues

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

slab_store_user-large-objects.patch
  slab debug: perform redzoning against larger objects

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

htree-nfs-fix-2.patch
  htree nfs fix

ext2-no-lock_super.patch
  concurrent block allocation for ext2

ext2-ialloc-no-lock_super.patch
  concurrent inode allocation for ext2

brlock-1b.patch
  Re: 2.5.64-mm8 breaks MASQ

brlock-removal-2.patch
  brlock removal 2/5: remove brlock from snap and vlan

brlock-removal-3.patch
  brlock removal 3/5: remove brlock from bridge

brlock-removal-4.patch
  brlock removal 4/5: removal from ipv4/ipv6

brlock-removal-5.patch
  brlock removal 5/5: remove brlock code

lseek-ext2_readdir.patch
  remove lock_kernel() from readdir implementations.

inode_setattr-lock_kernel-removal.patch
  remove lock_kernel() from inode_setattr's vmtruncate() call

ide_probe-init_irq-fix.patch
  ide-probe init_irq cleanup

raid1-fix.patch
  MD RAID1 fix

nmi-watchdog-fix.patch
  NMI watchdog fix

vm_enough_memory-speedup.patch
  speed up vm_enough_memory()

nanosleep-accuracy-fix-2.patch
  fix nanosleep() granularity bumps

linear-oops-fix-1.patch
  md/linear oops fix

dev_t-1-kill-cdev.patch
  dev_t [1/3]: kill cdev

dev_t-2-remove-MAX_CHRDEV.patch
  dev_t [2/3] - remove MAX_CHRDEV

dev_t-3-major_h-cleanup.patch
  dev_t [3/3]: major.h cleanups

dev_t-32-bit.patch
  [for playing only] change type of dev_t

dev_t-drm-warnings.patch
  dev_t: fix drm printk warnings

dev_t-remove-B_FREE.patch
  dev_t: eliminate B_FREE

smalldevfs.patch
  smalldevfs

cpufreq-xtime-locking.patch
  add write_seqlock to cpufreq change notifier for TSC

cs46xx-fixes.patch
  cs46xx minor fixes

notsclock-option.patch
  boot time parameter to turn of TSC usage

tty-put_user-checks.patch
  Add missing put_user checks in n_tty

fail-setup_irq-for-unconfigured-IRQs.patch
  Fail setup_irq for unconfigured IRQs

raw-fix-address_space-rewriting.patch
  raw driver: rewrite i_mapping only on final close

raw-cleanups-and-fixlets.patch
  raw driver: cleanups and small fixes

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code



