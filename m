Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTENIQX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 04:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbTENIQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 04:16:23 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:62768 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261249AbTENIPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 04:15:48 -0400
Date: Wed, 14 May 2003 01:29:47 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.69-mm5
Message-Id: <20030514012947.46b011ff.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 May 2003 08:28:28.0243 (UTC) FILETIME=[CB707230:01C319F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69-mm5/

Various fixes.  It should even compile on uniprocessor.

I dropped all the NFS client changes, which have been in -mm for ages.  A
number of fixes have been merged into Linus's tree and they need testing on
their own.



Changes since 2.5.69-mm4:


-SLAB_STORE_USER-larger-objects.patch
-remove-verify_write-leftovers.patch
-irqreturn-aic79xx.patch
-hrtimers-fix-signone.patch
-module_arch_cleanup-2.patch
-remove-devfs_register.patch
-pnp-irqreturn-fix.patch
-fat-speedup.patch
-vma-merging-missing-fput.patch
-cpufreq-commented-out-code-bogon.patch
-small-cleanup-for-__rmqueue.patch
-cpufreq-oops-fix.patch
-netif_receive_skb-warning-fix.patch
-ext3-quota-reservation-fix.patch
-quota-reference-drop-fix.patch
-bump-module-ref-during-init.patch
-exit_mmap-TASK_SIZE.patch
-semop-race-fix-2.patch
-visws-logo-fix.patch
-clustered-io_apic-fix.patch
-emergency-sync-printk.patch
-clone-retval-fix.patch
-de_thread-fix.patch
-vmalloc-race-fix.patch
-reserve-lustre-EAs.patch
-oprofile-build-fix.patch
-setfont-loadkeys-fix.patch
-htree-nfs-fix.patch
-htree-nfs-fix-2.patch
-htree-leak-fix.patch

 Merged

+sound-strncmp-fix.patch

 thinko fix

+dac960-typedef-cleanup.patch

 cleanup

+loop-warning-fix.patch

 compile warning fix

+make-KOBJ_NAME-match-BUS_ID_SIZE.patch

 fix susfs string truncation

+xirc2ps_cs-irqreturn-fix.patch

 xircom driver IRQ fix

-nfs-speedup.patch
-nfs-oom-fix.patch
-sk-allocation.patch
-nfs-more-oom-fix.patch
-rpciod-atomic-allocations.patch

 Dropped.

+vmtruncate-PAGE_SIZE-fix.patch

 s/PAGE_CACHE_SIZE/PAGE_SIZE/

+proc-pid-security-labels.patch

 security stuff

+reinstate-task-freeing-hack-for-ia64.patch

 implement minimal task_struct cache for ia64.  Apparently this is required
 because the refcounting is wonky.

+kexec-revert-NORET_TYPE.patch

 Remove the NORET_TYPE stuff from kexec.  It causes pain for non-ia32.

-fbdev-updates.patch

 Other merges broke it.

+kexec-warning-fixes-2.patch

 Fix more kexec warnings

+miropcm-fix.patch

 Build fix.

+ide-tcq-1.patch

 Resurrect IDE TCQ, perhaps.

+synclink_cs-update.patch

 driver update

+radeon-fb-64-bit-fix.patch

 driver fix

+usb-gadget-preproc-fix.patch

 build fix

+net2280-writel-fix.patch

 don't writel(outer_space)

+aic-errno-removal.patch

 build fix

+aic-non-i386-build-fix.patch

 build fix

+aic7xxx-fixes.patch

 4G wraparound fixes

+CONFIG_FUTEX.patch

 configurable futex code

+scsi_ioctl-fix.patch

 CDR detection fix




All 120 patches:


linus.patch

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

ipmi-warning-fixes.patch

irqreturn-uml.patch
  UML updates for the new IRQ API

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

sound-strncmp-fix.patch
  Subject: Small sound/core fix

irqreturn-snd-via-fix.patch
  via sound irqreturn fix

irq_cpustat-cleanup.patch
  irq_cpustat cleanup

config-PAGE_OFFSET.patch
  Configurable kenrel/user memory split

misc.patch
  Misc fixes

large-dma_addr_t-PAE-only.patch
  64-bit dma_addr_t is only needed with PAE

irq-check-rate-limit.patch
  IRQs: handle bad return values from handlers

irq_desc-others.patch
  Fix up irq_desc initialisation for non-ia32

put_dirty_page-protection-fix.patch

dcache_lock-vs-tasklist_lock-take-3.patch
  Fix dcache_lock/tasklist_lock ranking bug

hugetlbpage-extern-fix.patch
  fix hugetlbpage scoping

buffer-debug.patch
  buffer.c debugging

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

3c59x-irq-fix.patch

VM_RESERVED-check.patch
  VM_RESERVED check

dac960-typedef-cleanup.patch
  DAC960 typedef cleanup patch

reiserfs_file_write-5.patch

rcu-stats.patch
  RCU statistics reporting

ext3-journalled-data-assertion-fix.patch
  Remove incorrect assertion from ext3

loop-warning-fix.patch
  loop.c warning removal

mtrr-not-used-fix.patch
  kernel prints "mtrr: MTRR 2 not used" twice when exiting X

make-KOBJ_NAME-match-BUS_ID_SIZE.patch
  Make KOBJ_NAME_LEN match BUS_ID_SIZE

xirc2ps_cs-irqreturn-fix.patch
  xirc2ps_cs irq return fix

ide_setting_sem-fix.patch

reslabify-pgds-and-pmds.patch
  re-slabify i386 pgd's and pmd's

linux-isp.patch

isp-update-1.patch

list_del-debug.patch
  list_del debug check

airo-schedule-fix.patch
  airo.c: don't sleep in atomic regions

synaptics-mouse-support.patch
  Add Synaptics touchpad tweaking to psmouse driver

clear-smi-fix.patch
  Subject: [PATCH] linux-2.5.69_clear-smi-fix_A1

inode-unhashing-fix-2.patch
  Don't remove inode from hash until filesystem has deleted it

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

vmtruncate-PAGE_SIZE-fix.patch
  Fix for latent bug in vmtruncate()

sched-2.5.64-D3.patch
  sched-2.5.64-D3, more interactivity changes

sched_best_cpu-fix.patch
  sched_best_cpu does not pick best cpu

sched_best_cpu-fix-2.patch
  sched_best_cpu does not pick best cpu (2/2)

generic_hweight64-fix.patch

sched_best_cpu_fix-4.patch
  Even more sched_best_cpu fixes

show_task-free-stack-fix.patch
  show_task() fix and cleanup

spinlock-debugging-improvement.patch
  Make debugging variant of spinlocks a bit more robust

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

proc-pid-security-labels.patch
  /proc/pid inode security labels

thread-info-in-task_struct.patch
  allow thread_info to be allocated as part of task_struct

reinstate-task-freeing-hack-for-ia64.patch
  reinstate lame task_struct (non)-refcounting hack/fix

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

pcmcia-deadlock-fix-3.patch
  Fix PCMCIA deadlock (rev. 2)

reboot_on_bsp.patch

kexec-revert-NORET_TYPE.patch

apic_shutdown.patch

i8259-shutdown.patch

hwfixes-x86kexec.patch

kexec-warning-fixes-2.patch

v4l-1.patch
  Subject: [patch] v4l: #1 - video-buf update

v4l-2.patch
  Subject: [patch] v4l: #2 - v4l1-compat update

v4l-3.patch
  Subject: [patch] v4l: #3 - bttv driver update

v4l-4.patch
  Subject: [patch] v4l: #4 - bttv docmentation update

v4l-5.patch
  Subject: [patch] v4l: #5 - i2c module updates.

v4l-6.patch
  Subject: [patch] v4l: #6 - tuner module update

v4l-7.patch
  Subject: [patch] v4l: #7 - saa7134 driver update

checker-1.patch

miropcm-fix.patch
  miropcm20-rds.c build fix

ide-tcq-1.patch
  First part of getting ide-tcq in line...

synclink_cs-update.patch
  synclink_cs update

radeon-fb-64-bit-fix.patch
  radeonfb.c 64-bit fixes

usb-gadget-preproc-fix.patch
  usb gadget typo fix

net2280-writel-fix.patch
  net2280 writel fix

aic-errno-removal.patch
  aic7xxx build fix

aic-non-i386-build-fix.patch
  aic7xxx non-i386 build fix

aic7xxx-fixes.patch

CONFIG_FUTEX.patch
  FUTEX support should be optional

scsi_ioctl-fix.patch
  scsi_ioctl fix for CDR detection



