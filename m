Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbTEGGLK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 02:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbTEGGLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 02:11:10 -0400
Received: from [12.47.58.20] ([12.47.58.20]:42420 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262883AbTEGGK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 02:10:56 -0400
Date: Tue, 6 May 2003 23:23:26 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.69-mm2
Message-Id: <20030506232326.7e7237ac.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 May 2003 06:23:24.0636 (UTC) FILETIME=[2A0CA1C0:01C31461]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69-mm2/

Lots of little fixes.  The ia32 IRQ changes may stem the warnings which
people are seeing.



Changes since 2.5.69-mm1:


+linus.patch

 Latest from Linus

-ppc64-pci-patch.patch
-ppc64-update.patch
-ppc64-update-fixes.patch
-ppc64-irqfixes.patch
-ppc64-pci-bogons.patch

 Merged

-generic-subarch-fix.patch
-generic-subarch-missing-bit.patch
-generic-subarch-numaq-fix.patch

 Folded into generic-subarch.patch

+altinstruction-linkage-fix.patch
+cpia-section-fix.patch

 Fixes for the ia32 instruction replacement code.

+opl3sa2-compile-fix.patch

 Compile fix

+alloc_skb-remove-debug-check.patch

 Remove duplicted might_sleep() check.

-kgdb-ga.patch
-kgdb-ga-ppc64-fix.patch
-irqreturn-kgdb-ga.patch
-kgdb-ga-smp_num_cpus.patch
-kgdb-ga-discontigmem-fixup.patch

 Folded into kgdb-ga.patch

+ppc64-ioctl-pci-update.patch

 ppc64 updates

+mwave-build-fix.patch

 Compile fix

+drm-timer-init-fix.patch

 timer initialisation fix

+irqreturn-snd-via-fix.patch

 IRQ fix.

+irq_cpustat-cleanup.patch

 cleanup

-config-PAGE_OFFSET-025G.patch

 Folded into config-PAGE_OFFSET.patch

+irq-check-rate-limit.patch
+irq_desc-others.patch

 Attempt to do something intelligent with the IQ_HANDLED and IRQ_NONE return
 values from irq handlers.

+exit_mmap-TASK_SIZE.patch

 Teach exit_mmap() that TASK_SIZE can depend on current->mm.

+slab-init-fixes.patch

 Fix a slab oops, clean a few things up.

-sysrq-fs-cleanups-fixes.patch

 Folded into sysrq-fs-cleanups.patch

+clustered-io_apic-fix.patch

 Fix APIC handling for cluster mode.

+remove-partition_name.patch
+switch-to-devfs_mk_bdev.patch

 Devfs rationalisation

+ide_setting_sem-fix.patch

 Fix scheduling-inside-spinlock problem

+reslabify-pgds-and-pmds.patch

 Put pgd's and pmd's into a slab cache again

+as-monitor-seek-distance.patch
+as-div64-fix.patch

 Anticipatory scheduler work

-fget-speedup-inline-fput_light.patch

 Folded into fget-speedup.patch

+fget_light-fix.patch

 Fix silly bug

+sched-numa-warning-fix.patch

 Fix a warning in the scheduler update.

+acpi-irq-ret-fix.patch

 Try to fix acpi_irq return value.  May not work.

+sound-irq-hack.patch

 Possibly unneeded sound IRQ notfix.

+oprofile-build-fix.patch

 Compile fix

+sched_best_cpu-fix.patch
+sched_best_cpu-fix-2.patch
+generic_hweight64-fix.patch

 Fix CPU scheduler for unloaded NUMA nodes.

-select-speedup-fix.patch

 Folded into select-speedup.patch

+lsm-setxattr-changes.patch

 Security stuff

+sunrpc-gcc-bug-workaround.patch

 Work around gcc-2.94 bug

+T25-cciss-C69.patch
+T26-cpqarray-C69.patch
+T27-kobject-C69.patch
+T28-tty-C69.patch
+T29-kobj_map-C69.patch
+T30-cdev-C69.patch
+T31-i_cdev-C69.patch

 chardev rework from Al Viro.

+fbdev-updates.patch

 Frame buffer driver update.



All 133 patches:


linus.patch

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

generic-subarch.patch
  generic subarchitecture for ia32

ipmi-warning-fixes.patch

irqreturn-uml.patch
  UML updates for the new IRQ API

irqreturn-aic79xx.patch
  Fix aic79xx for new IRQ API

altinstruction-linkage-fix.patch
  Fix .altinstructions linking failures

cpia-section-fix.patch
  cpia driver __exit fix

opl3sa2-compile-fix.patch
  fix OSS opl3sa2 compilation

alloc_skb-remove-debug-check.patch
  remove debug check from alloc_skb()

irqreturn-drivers-net.patch

slab-magazine-layer.patch
  magazine layer for slab

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-ioctl-pci-update.patch
  From: Anton Blanchard <anton@samba.org>
  Subject: ppc64 stuff

ppc64-reloc_hide.patch

ppc64-aio-32bit-emulation.patch
  32/64bit emulation for aio

ppc64-scruffiness.patch
  Fix some PPC64 compile warnings

sym-do-160.patch
  make the SYM driver do 160 MB/sec

misc.patch
  misc fixes

mwave-build-fix.patch
  mwave build fix

drm-timer-init-fix.patch
  drm timer initialisation fix

irqreturn-snd-via-fix.patch
  via sound irqreturn fix

irq_cpustat-cleanup.patch
  irq_cpustat cleanup

config-PAGE_OFFSET.patch
  Configurable kenrel/user memory split

fat-speedup.patch
  fat cluster search speedup

irq-check-rate-limit.patch
  IRQs: handle bad return values from handlers

irq_desc-others.patch
  Fix up irq_desc initialisation for non-ia32

buffer-debug.patch
  buffer.c debugging

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

3c59x-irq-fix.patch

VM_RESERVED-check.patch
  VM_RESERVED check

exit_mmap-TASK_SIZE.patch
  exit_mmap() TASK_SIZE fix

slab-init-fixes.patch
  slab: initialisation cleanup and oops fix

semop-race-fix-2.patch
  semop race fix #2

nfs-writeback-tweak.patch
  Tweak to NFS memory management for writes...

sysrq-fs-cleanups.patch
  sysrq-S, sysrq-U cleanups

UPDATE_ATIME-update_atime.patch
  s/UPDATE_ATIME/update_atime/ cleanup

irqreturn-pcmcia_cs.patch
  irqreturn_t for drivers/net/pcmcia

printscreen-fix.patch
  keyboard.c Fix CONFIG_MAGIC_SYSRQ+PrintScreen

reiserfs_file_write-5.patch

clustered-io_apic-fix.patch
  Subject: [RFC][PATCH] fix for clusterd io_apics

disk_name-no-devfs.patch
  Don't use devfs names in disk_name()

devfs-01-api-change.patch
  devfs: API changes

remove-partition_name.patch
  Subject: [PATCH] remove partition_name()

switch-to-devfs_mk_bdev.patch
  switch all remaining drivers over to devfs_mk_bdev

rcu-stats.patch
  RCU statistics reporting

ext3-journalled-data-assertion-fix.patch
  Remove incorrect assertion from ext3

ide_setting_sem-fix.patch

reslabify-pgds-and-pmds.patch
  re-slabify i386 pgd's and pmd's

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

386-access_ok-race-fix.patch
  access_ok() race fix for 80386.

synaptics-mouse-support.patch
  Add Synaptics touchpad tweaking to psmouse driver

swapfile-hold-i_sem.patch
  hold i_sem on swapfiles

dont-set-kernel-pgd-on-PAE.patch
  remove unnecessary PAE pgd set

nobody-listens-to-wli.patch
  set_pgd() update

shrink_slab-accounting.patch
  account for slab reclaim in try_to_free_pages()

slab-debugging-improvement.patch
  slab: additional debug checks

rq-dyn-works.patch
  rq-dyn, dynamic request allocation

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

as-iosched-dyn.patch
  AS: update to dynamic request allocation API

as-monitor-seek-distance.patch
  AS: monitor seek distance

as-div64-fix.patch
  as: don't do 64-bit divides

unplug-use-kblockd.patch
  Use kblockd for running request queues

cfq-2.patch
  CFQ scheduler, #2

cfq-iosched-dyn.patch
  CFQ: update to rq-dyn API

unmap-page-debugging.patch
  unmap unused pages for debugging

fremap-all-mappings.patch
  Make all executable mappings be nonlinear

fget-speedup.patch
  reduced overheads in fget/fput

fget_light-fix.patch
  fget_light fix

sched-2.5.68-B2.patch
  HT scheduler, sched-2.5.68-B2

sched-numa-warning-fix.patch
  scheduler warning fix for NUMA

sched_idle-typo-fix.patch
  fix sched_idle typo

kgdb-ga-idle-fix.patch

acpi-irq-ret-fix.patch
  acpi irq return value fix

sound-irq-hack.patch

oprofile-build-fix.patch
  Fix arch/i386/oprofile/init.c build error

sched-2.5.64-D3.patch
  sched-2.5.64-D3, more interactivity changes

sched_best_cpu-fix.patch
  sched_best_cpu does not pick best cpu

sched_best_cpu-fix-2.patch
  sched_best_cpu does not pick best cpu (2/2)

generic_hweight64-fix.patch

show_task-free-stack-fix.patch
  show_task() fix and cleanup

htree-nfs-fix.patch
  Fix ext3 htree / NFS compatibility problems

i8042-share-irqs.patch
  allow i8042 interrupt sharing

select-speedup.patch
  Subject: Re: IA64 changes to fs/select.c

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

security_d_instantiate-movement.patch
  Move security_d_instantiate hook calls

ext3-security-xattr.patch
  ext3 xattr handler for security modules

ext2-security-xattr.patch
  ext2 xattr handler for security modules

lsm-setxattr-changes.patch
  Subject: [PATCH] Change LSM hooks in setxattr 2.5.69

sunrpc-gcc-bug-workaround.patch
  Work around include/linux/sunrpc/svc.h compilation error

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

pcmcia-fix.patch

kexec.patch
  kexec

T25-cciss-C69.patch

T26-cpqarray-C69.patch

T27-kobject-C69.patch

T28-tty-C69.patch

T29-kobj_map-C69.patch

T30-cdev-C69.patch

T31-i_cdev-C69.patch

fbdev-updates.patch
  Fbdev update patch



