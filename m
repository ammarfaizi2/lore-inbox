Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbTD3GrO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 02:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbTD3GrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 02:47:14 -0400
Received: from [12.47.58.171] ([12.47.58.171]:18425 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262102AbTD3GrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 02:47:06 -0400
Date: Tue, 29 Apr 2003 23:59:59 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.68-mm3
Message-Id: <20030429235959.3064d579.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Apr 2003 06:59:18.0824 (UTC) FILETIME=[05276280:01C30EE6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.68/2.5.68-mm3/

Bits and pieces.  Nothing major, apart from the dynamic request allocation
patch.  This arbitrarily increases the maximum requests/queue to 1024, and
could well make large (and usually bad) changes to various benchmarks. 
However some will be helped.




Changes since 2.5.68-mm2


 linus.patch

 Latest -bk

-irq-printing.patch
-warning-fixes-01.patch
-irqreturn-usb.patch
-devfs-brown-bag.patch
-eisa-sysfs-update.patch
-devfs-pty-fix.patch
-devfs-partition-fix.patch
-kobj_lock-fix.patch
-ppa-null-pointer-fix.patch
-pmd_alloc_one-typo-fix.patch
-sched_idle-typo-fix.patch
-pcmcia-20030421.patch

 Merged

+generic-subarch.patch
+generic-subarch-fix.patch

 Roll up various ia32 SMP configs into one option, work it out at runtime.

+irqreturn-drivers-net.patch

 IRQ API conversion for remaining net drivers.

+irqreturn-bttv.patch

 And bttv

+xd-warning-fix.patch

 Nail a warning

+slab-magazine-layer.patch

 SMP speedup for slab: add a `magazine' layer for passing objects between
 CPUs, rather than passing them all the way back to the page allocator. 
 Mainly for skb's, where the source and sink CPUs are persistently different.

+DAC960-interface-fixes.patch

 Driver fixes

+alt_instr-__KERNEL__.patch

 Add some ifdef wrappers in a header

+modular-jbd.patch

 Fix Kconfig dependencies

+VM_RESERVED-check.patch

 Debug check in page reclaim

+semop-race-fix.patch

 Fix race in sysv shm. (Not complete)

+hdlc-module-update.patch

 Driver update

+proc_file_read-fix.patch

 Fix truncated /proc reads.

+disk_name-size-check.patch

 Clean up some bounds checking in bdevname()

+mwave-cleanup.patch

 Driver cleanup

+blockdev-aio-support.patch

 Better AIO support for IO against /dev/hdXX

+percpu-counters-fix.patch

 UML build fix

-aio-retval-fix.patch

 Ben didn't like it.

+oom-kill-locking.patch

 SMP locking in the oomkiller

+386-access_ok-race-fix.patch

 usercopy-vs-page reclaim fix for 386's

+swapfile-hold-i_sem.patch

 Hold i_sem on swapfiles while they are in use.

+as-remove-debug-checks.patch

 Remove bogusish debug check in anticipatory scheduler.

+dynamic-request-allocation.patch
+dynamic-request-allocation-fix.patch

 Remove the fixed-size request pools, kmalloc them.

-unmap-page-debugging-fixes.patch
-global_flush_tlb-irqs-check.patch
-unmap-page-debugging-fixes-2.patch

 Folded into unmap-page-debugging.patch

-sched-2.5.68-A9.patch
+sched-2.5.68-B2.patch

 CPU scheduler update update.

-generic-bitops-update.patch

 Wrong - is using deprecated cli()/sti().

+pcmcia-deadlock-fix-2.patch

 New PCMCIA fix.

+restore-modinfo-section.patch
+implement-__module_get.patch

 Modules updates from Rusty.




All 113 patches


linus.patch

mm.patch
  add -mmN to EXTRAVERSION

generic-subarch.patch
  generic subarchitecture for ia32

generic-subarch-fix.patch
  generic subarch: SMP only

ipmi-warning-fixes.patch

irqreturn-i2c.patch

irqreturn-uml.patch
  UML updates for the new IRQ API

irqreturn-sound-2.patch
  irqs: sound fixups

irqreturn-smcc.patch
  IRDA: missing IRQ bits

irqreturn-aic79xx.patch
  Fix aic79xx for new IRQ API

SLAB_NO_GROW-fix.patch
  Fix slab-vs-gfp bitflag clash

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kgdb-ga-ppc64-fix.patch

irqreturn-kgdb-ga.patch

irqreturn-drivers-net.patch

irqreturn-bttv.patch
  bttv: new IRQ API

kgdb-ga-smp_num_cpus.patch

kgdb-ga-discontigmem-fixup.patch
  kgdb: discontigmem fixup

apm-locking-fix.patch
  APM locking fix

xd-warning-fix.patch
  Fix warnings in xd.c

slab-magazine-layer.patch
  magazine layer for slab

DAC960-interface-fixes.patch
  DAC960 patch to entry points with a new fix

alt_instr-__KERNEL__.patch
  Place the alt_instr defns inside #ifdef __KERNEL__

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

config-PAGE_OFFSET.patch
  Configurable kenrel/user memory split

fat-speedup.patch
  fat cluster search speedup

buffer-debug.patch
  buffer.c debugging

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

modular-jbd.patch
  allow modular JBD

VM_RESERVED-check.patch
  VM_RESERVED check

semop-race-fix.patch
  semtimedop(): Fix racy BUG check

hdlc-module-update.patch
  generic HDLC module API update

proc_file_read-fix.patch
  proc_file_read fix

disk_name-size-check.patch
  use snprintf in disk_name

reiserfs_file_write-5.patch

cleanups.patch
  misc cleanups

mwave-cleanup.patch
  simple mwave code cleanup

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

blockdev-aio-support.patch
  aio support for block devices

percpu-counters-fix.patch
  percpu counters cause UML compilation errors in with SMP

airo-schedule-fix.patch
  airo.c: don't sleep in atomic regions

config-menu-aesthetics.patch
  config menu: a combination of aesthetics

oom-kill-locking.patch
  oom-killer locking

386-access_ok-race-fix.patch
  access_ok() race fix for 80386.

synaptics-mouse-support.patch
  Add Synaptics touchpad tweaking to psmouse driver

swapfile-hold-i_sem.patch
  hold i_sem on swapfiles

kblockd.patch
  Create `kblockd' workqueue

cfq-infrastructure.patch

elevator-completion-api.patch
  elevator completion API

as-iosched.patch
  anticipatory I/O scheduler

as-use-completion.patch
  AS use completion notifier

as-remove-debug-checks.patch
  AS: remove debug checks

unplug-use-kblockd.patch
  Use kblockd for running request queues

cfq-2.patch
  CFQ scheduler, #2

dynamic-request-allocation.patch
  rq-dyn-alloc, dynamic request allocation

dynamic-request-allocation-fix.patch
  rq-dyn-alloc fix

unmap-page-debugging.patch
  unmap unused pages for debugging

fremap-all-mappings.patch
  Make all executable mappings be nonlinear

sched-2.5.68-B2.patch
  HT scheduler, sched-2.5.68-B2

sched_idle-typo-fix.patch
  fix sched_idle typo

kgdb-ga-idle-fix.patch

sched-2.5.64-D3.patch
  sched-2.5.64-D3, more interactivity changes

show_task-free-stack-fix.patch
  show_task() fix and cleanup

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

pcmcia-deadlock-fix-2.patch
  Fix PCMCIA deadlock (rev. 2)

restore-modinfo-section.patch
  modules: restore modinfo section

implement-__module_get.patch
  Implement __module_get



