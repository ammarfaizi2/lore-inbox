Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263984AbTDWIIJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 04:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263985AbTDWIIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 04:08:09 -0400
Received: from [12.47.58.232] ([12.47.58.232]:34121 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263984AbTDWIIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 04:08:00 -0400
Date: Wed, 23 Apr 2003 01:20:46 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.68-mm2
Message-Id: <20030423012046.0535e4fd.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Apr 2003 08:19:59.0381 (UTC) FILETIME=[21758450:01C30971]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.68/2.5.68-mm2.gz

   Will appear sometime at:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.68/2.5.68-mm2/

. Zillions of new fixes.

. I got tired of the objrmap code going BUG under stress, so it is now in
  disgrace in the experimental/ directory.



Changes since 2.5.68-mm1:

+linus.patch

 Latest from Linus

-3c574-irq-fix.patch
-nec98-partitions-fix.patch
-dmfe-kfree_skb-fix.patch
-dentry_stat-accounting-fix.patch
-DCACHE_REFERENCED-fixes.patch
-tasklist_lock-dcache_lock-inversion-fix.patch
-setserial-fix.patch
-SAK-raw-mode-fix.patch
-pci-bus-ordering-fix.patch
-turn-on-NUMA-rebalancing.patch
-yellowfin-set_bit-fix.patch
-move-__set_page_dirty-buffers.patch
-buffers-cleanup.patch
-follow_hugetlb_page-fix.patch
-hugetlb-overflow-fix.patch
-mach64-build-fix.patch
-sync-all-quotas.patch
-aio-mmap-fix.patch
-shmdt-speedup.patch
-task_prio-fix.patch
-gfp_repeat.patch
-alloc_buffer_head-take-gfp.patch
-pte_alloc_one-use-gfp_repeat.patch
-pmd_alloc_one-use-gfp_repeat.patch
-overcommit-stop-swapoff.patch
-interruptible-swapoff.patch
-oomkill-swapoff.patch
-dac960-bounce-avoidance.patch
-shm_get_stat-handle-hugetlb-pages.patch
-dynamic-hd_struct-allocation.patch
-NOMMU-merge-fixes.patch
-vmap-extensions.patch
-dont-shrink-slab-for-highmem.patch
-dm-larger-dev_t-fix.patch
-rdev-for-samba.patch
-nfsctl-dev_t-fix.patch
-aggregated-disk-stats.patch

 Merged

+irq-printing.patch

 Print friendly info when the new IRQ code detects a problem

+warning-fixes-01.patch
+ipmi-warning-fixes.patch

 Fix some warnings

+irqreturn-i2c.patch
+irqreturn-usb.patch
+irqreturn-uml.patch
+irqreturn-sound-2.patch
+irqreturn-smcc.patch
+irqreturn-aic79xx.patch

 More IRQ fixes

+devfs-brown-bag.patch

 devfs fix

+eisa-sysfs-update.patch

 EISA update

+devfs-pty-fix.patch
+devfs-partition-fix.patch

 More devfs fixes

+SLAB_NO_GROW-fix.patch

 Fix slab/memory allocation interaction

+kgdb-ga-ppc64-fix.patch

 the kgdb patch broke other architectures

+irqreturn-kgdb-ga.patch

 Teach the kgdb stub about the new IRQ API

+kgdb-ga-smp_num_cpus.patch

 smp_num_cpus doesn't exist.

+kgdb-ga-discontigmem-fixup.patch

 Teach the kgdb stub about discontigmem.

+apm-locking-fix.patch

 Locking fix in APM

+ppc64-irqfixes.patch

 Update the pppc64 port for the new IRQ API

+ppc64-pci-bogons.patch

 nail some warnings

+misc.patch

 Minor fixes

+pmd_alloc_one-typo-fix.patch

 Typo fix

+fat-speedup.patch

 Speed up fatfs cluster searching

+cleanups.patch

 Clean up something

+ext3-ro-mount-fix.patch

 Fix ext3 mount-time bug

+nr_threads-docco-fix.patch

 Correct some comments

+lost-tick-HZ-fix.patch

 lost tick detector fixes

+nr_inactive-race-fix.patch

 Fix zone accounting inconsistency in page reclaim

+dcache_lock-vs-tasklist_lock-take-2.patch

 Another attempt at fixing the tasklist_lock/dcache_lock inversion problem

+clone-retval-fix.patch

 Clean up the error returns from clone()

+de_thread-fix.patch

 Fix possible memory corruption in de_thread()

+list_del-debug.patch

 Debugging for list_del()

+airo-schedule-fix.patch

 Don't schedule() in interrupts.

+config-menu-aesthetics.patch

 Config menu cleanup

+aio-retval-fix.patch

 Fix error return value in AIO

+synaptics-mouse-support.patch

 Add support for synaptics inout devices

+pcmcia-20030421.patch

 PCMCIA update (should fix the startup deadlock, but this is not final)

-objrmap.patch

 Is BUGgy

+sched-2.5.68-A9.patch

 HT-aware scheduler

+kgdb-ga-idle-fix.patch

 Update the kgdb stub for the HT-aware scheduler changes

-scheduler-tunables.patch

 It broke again




All 103 patches:


linus.patch

mm.patch
  add -mmN to EXTRAVERSION

irq-printing.patch
  print IRQ handler addresses

warning-fixes-01.patch
  warning fixes

ipmi-warning-fixes.patch

irqreturn-i2c.patch

irqreturn-usb.patch

irqreturn-uml.patch
  UML updates for the new IRQ API

irqreturn-sound-2.patch
  irqs: sound fixups

irqreturn-smcc.patch
  IRDA: missing IRQ bits

irqreturn-aic79xx.patch
  Fix aic79xx for new IRQ API

devfs-brown-bag.patch
  2.5.68-bk renames IDE disks, /dev/hda is directory

eisa-sysfs-update.patch
  EISA/sysfs update

devfs-pty-fix.patch

devfs-partition-fix.patch

SLAB_NO_GROW-fix.patch
  Fix slab-vs-gfp bitflag clash

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kgdb-ga-ppc64-fix.patch

irqreturn-kgdb-ga.patch

kgdb-ga-smp_num_cpus.patch

kgdb-ga-discontigmem-fixup.patch
  kgdb: discontigmem fixup

apm-locking-fix.patch
  APM locking fix

kobj_lock-fix.patch

ppa-null-pointer-fix.patch

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

ppc64-irqfixes.patch

ppc64-pci-bogons.patch

sym-do-160.patch
  make the SYM driver do 160 MB/sec

misc.patch

pmd_alloc_one-typo-fix.patch
  fix typo in m68k mm code

config-PAGE_OFFSET.patch
  Configurable kenrel/user memory split

fat-speedup.patch
  From: Bjorn Stenberg <bjorn@haxx.se>
  fat cluster search speedup

buffer-debug.patch
  buffer.c debugging

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

reiserfs_file_write-5.patch

cleanups.patch
  misc cleanups

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

ext3-ro-mount-fix.patch
  fs/ext3/super.c fix for orphan recovery error path

nr_threads-docco-fix.patch
  update nr_threads commentary

lost-tick-HZ-fix.patch
  lost_tick fixes

nr_inactive-race-fix.patch
  zone accounting race fix

dcache_lock-vs-tasklist_lock-take-2.patch
  Fix dcache_lock/tasklist_lock ranking bug

clone-retval-fix.patch
  copy_process return value fix

de_thread-fix.patch
  de_thread memory corruption fix

list_del-debug.patch
  list_del debug check

airo-schedule-fix.patch
  airo.c: don't sleep in atomic regions

config-menu-aesthetics.patch
  config menu: a combination of aesthetics

aio-retval-fix.patch
  aio: fix sys_io_setup error return value

synaptics-mouse-support.patch
  Add Synaptics touchpad tweaking to psmouse driver

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

unmap-page-debugging.patch
  unmap unused pages for debugging

unmap-page-debugging-fixes.patch

global_flush_tlb-irqs-check.patch

unmap-page-debugging-fixes-2.patch

pcmcia-20030421.patch

fremap-all-mappings.patch
  Make all executable mappings be nonlinear

sched-2.5.68-A9.patch
  HT scheduler, sched-2.5.68-A9

kgdb-ga-idle-fix.patch

sched-2.5.64-D3.patch
  sched-2.5.64-D3, more interactivity changes

show_task-free-stack-fix.patch
  show_task() fix and cleanup

generic-bitops-update.patch
  include/asm-generic/bitops.h {set,clear}_bit return  void

htree-nfs-fix.patch
  Fix ext3 htree / NFS compatibility problems

i8042-share-irqs.patch
  allow i8042 interrupt sharing

select-speedup.patch
  Subject: Re: IA64 changes to fs/select.c

select-speedup-fix.patch
  select() sleedup fix

slab_store_user-large-objects.patch
  slab debug: perform redzoning against larger objects

htree-nfs-fix-2.patch
  htree nfs fix

htree-leak-fix.patch
  ext3: htree memory leak fix

put_task_struct-debug.patch

ia32-mknod64.patch
  mknod64 for ia32

ext2-64-bit-special-inodes.patch
  ext2: support for 64-bit device nodes

ext3-64-bit-special-inodes.patch
  ext3: support for 64-bit device nodes

64-bit-dev_t-kdev_t.patch
  64-bit dev_t and kdev_t

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



