Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbTEHI1Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 04:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbTEHI1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 04:27:25 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:62803 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261218AbTEHI1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 04:27:14 -0400
Date: Thu, 8 May 2003 01:39:58 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.69-mm3
Message-Id: <20030508013958.157b27b7.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 May 2003 08:39:44.0977 (UTC) FILETIME=[60535C10:01C3153D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.69-mm3.gz

  Will appear sometime at

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69-mm3/


Small things.  Mainly a resync for various people...




Changes since 2.5.69-mm2:


 linus.patch

 Latest from Linus

-generic-subarch.patch
-altinstruction-linkage-fix.patch
-cpia-section-fix.patch
-opl3sa2-compile-fix.patch
-alloc_skb-remove-debug-check.patch
-misc.patch
-mwave-build-fix.patch
-drm-timer-init-fix.patch
-slab-init-fixes.patch
-sysrq-fs-cleanups.patch
-UPDATE_ATIME-update_atime.patch
-irqreturn-pcmcia_cs.patch
-printscreen-fix.patch
-disk_name-no-devfs.patch
-devfs-01-api-change.patch
-remove-partition_name.patch
-switch-to-devfs_mk_bdev.patch
-386-access_ok-race-fix.patch
-swapfile-hold-i_sem.patch
-dont-set-kernel-pgd-on-PAE.patch
-nobody-listens-to-wli.patch
-shrink_slab-accounting.patch
-slab-debugging-improvement.patch
-fget-speedup.patch
-fget_light-fix.patch
-i8042-share-irqs.patch
-select-speedup.patch
-security_d_instantiate-movement.patch
-ext3-security-xattr.patch
-ext2-security-xattr.patch
-lsm-setxattr-changes.patch
-sunrpc-gcc-bug-workaround.patch

 Merged

+ppc64-xics-irq-fix.patch

 ppc64 IRQ return fix

+hrtimers-fix-signone.patch

 High-res timers fix

+netfilter-skbuff-fix.patch

 Might fix a netfilter oops

+ext3-quota-reservation-fix.patch

 Fix possible BUG with ext3+quotas

+quota-reference-drop-fix.patch

 Quota fix

+visws-logo-fix.patch

 visws fbcon logo fix

-dcache_lock-vs-tasklist_lock-take-2.patch

 Dropped for now - Manfred is redoing it.

+vmalloc-race-fix.patch

 Fix nasty race in vmalloc/vfree.  Seems to only happen on preempt.  This
 will fix the select()-related oops whch Felix von Leitner reported.  Kudos
 to Mister Irwin.

+as-small-hashes.patch

 Reduce anticipatory scheduler memory footprint

+tty-64-bit-dev_t-warning-fix.patch

 Warning fix

+security-process-attribute-api.patch

 Security API work

+thread-info-in-task_struct.patch

 Infrastructure for supporting ia64 oddness

-T25-cciss-C69.patch
-T26-cpqarray-C69.patch
-T27-kobject-C69.patch
-T28-tty-C69.patch
-T29-kobj_map-C69.patch
-T30-cdev-C69.patch
-T31-i_cdev-C69.patch

 The tty changes broke these.




All 104 patches:


linus.patch

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

ipmi-warning-fixes.patch

irqreturn-uml.patch
  UML updates for the new IRQ API

irqreturn-aic79xx.patch
  Fix aic79xx for new IRQ API

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

ppc64-xics-irq-fix.patch
  PPC64 irq return fix

sym-do-160.patch
  make the SYM driver do 160 MB/sec

hrtimers-fix-signone.patch
  hrtimers: fix timer_create(2) && SIGEV_NONE

netfilter-skbuff-fix.patch
  netfilter skbuff BUGfix

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

ext3-quota-reservation-fix.patch
  Quota write transaction size fix

quota-reference-drop-fix.patch
  dquot_transfer() fix

buffer-debug.patch
  buffer.c debugging

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

3c59x-irq-fix.patch

VM_RESERVED-check.patch
  VM_RESERVED check

exit_mmap-TASK_SIZE.patch
  exit_mmap() TASK_SIZE fix

semop-race-fix-2.patch
  semop race fix #2

nfs-writeback-tweak.patch
  Tweak to NFS memory management for writes...

reiserfs_file_write-5.patch

visws-logo-fix.patch
  visws: fix penguin with sgi logo

clustered-io_apic-fix.patch
  Subject: [RFC][PATCH] fix for clusterd io_apics

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

clone-retval-fix.patch
  copy_process return value fix

de_thread-fix.patch
  de_thread memory corruption fix

list_del-debug.patch
  list_del debug check

airo-schedule-fix.patch
  airo.c: don't sleep in atomic regions

synaptics-mouse-support.patch
  Add Synaptics touchpad tweaking to psmouse driver

vmalloc-race-fix.patch
  vmalloc race fix

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

as-small-hashes.patch
  AS: smaller hashes

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

tty-64-bit-dev_t-warning-fix.patch
  tty layer 64-bit dev_t printk warning fix

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

security-process-attribute-api.patch
  Process Attribute API for Security Modules

thread-info-in-task_struct.patch
  allow thread_info to be allocated as part of task_struct

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

fbdev-updates.patch
  Fbdev update patch



