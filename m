Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264383AbTEPIkC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 04:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264385AbTEPIkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 04:40:02 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:32632 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264383AbTEPIjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 04:39:40 -0400
Date: Fri, 16 May 2003 01:54:07 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.69-mm6
Message-Id: <20030516015407.2768b570.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 May 2003 08:52:26.0077 (UTC) FILETIME=[794800D0:01C31B88]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69-mm6/

. A forward-port of reiserfs `chattr' support.

. Some anticipatory scheduler work.  It will affect performance, hopefully
  positively.

. Random other fixes, cleanups and featurettes.




Changes since 2.5.69-mm5:


-ipmi-warning-fixes.patch
-irqreturn-uml.patch
-sound-strncmp-fix.patch
-put_dirty_page-protection-fix.patch
-hugetlbpage-extern-fix.patch
-dac960-typedef-cleanup.patch
-loop-warning-fix.patch
-mtrr-not-used-fix.patch
-clear-smi-fix.patch
-spinlock-debugging-improvement.patch
-pcmcia-deadlock-fix-3.patch
-checker-1.patch
-miropcm-fix.patch
-ide-tcq-1.patch
-synclink_cs-update.patch
-usb-gadget-preproc-fix.patch
-net2280-writel-fix.patch
-scsi_ioctl-fix.patch

 Merged

+subarch-circular-dependency-fix.patch

 ia32 build fix

-reiserfs_file_write-5.patch
+reiserfs-multiple-block-insertion.patch
+reiserfs_file_write-6.patch

 Split up. No change.

+reiserfs-inode-attribute-support.patch

 chattr features for reiserfs - see changelog for details.

-as-use-completion.patch
-as-remove-debug-checks.patch
-as-iosched-dyn.patch
-as-monitor-seek-distance.patch
-as-div64-fix.patch
-as-small-hashes.patch

 Folded into as-iosched.patch

+as-proc-read-write.patch
+as-discrete-read-fifo-batches.patch

 Anticipatory scheduler work

-sched_best_cpu-fix.patch
-sched_best_cpu-fix-2.patch
-generic_hweight64-fix.patch
-sched_best_cpu_fix-4.patch

 Dropped.  Too many patches flying about and I lost the plot.  Please try
 again when it's finished.

+CONFIG_EPOLL.patch

 Make epoll disableable.

+cs4281-cleanup.patch

 Driver cleanup

+stanford-memcy-size-fixes.patch
+stanford-crypto-fixes.patch

 memcpy/memset size fixes

+invalidate_mmap_range.patch

 pagetable teardown for middle-of-file (generalisation of vmtruncate_list)

+BUG-to_BUG_ON.patch

 Cleanup

+3c59x-id.patch

 Couple of new PCI IDs

+suspend-asm-fix.patch

 swsusp build fix

+handle-sparse-physical-apid-ids.patch

 Fix odd ia32 SMP boxes which have sparse APIC mappings

+put_page_testzero-fix.patch

 Fix thinko

+devpts-xattr-handler.patch

 EAs for the devpts filesystem

+unregister_netdev-cleanup.patch

 Minor cleanups




All 109 patches


linus.patch

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

subarch-circular-dependency-fix.patch
  ia32 subarch circular dependency fix

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

dcache_lock-vs-tasklist_lock-take-3.patch
  Fix dcache_lock/tasklist_lock ranking bug

buffer-debug.patch
  buffer.c debugging

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

3c59x-irq-fix.patch

VM_RESERVED-check.patch
  VM_RESERVED check

reiserfs-multiple-block-insertion.patch
  reiserfs: allow multiple block insertion into the tree

reiserfs_file_write-6.patch
  reiserfs: reiserfs_file_write implementation

reiserfs-inode-attribute-support.patch
  reiserfs: inode attributes support.

rcu-stats.patch
  RCU statistics reporting

ext3-journalled-data-assertion-fix.patch
  Remove incorrect assertion from ext3

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

inode-unhashing-fix-2.patch
  Don't remove inode from hash until filesystem has deleted it

kblockd.patch
  Create `kblockd' workqueue

cfq-infrastructure.patch

elevator-completion-api.patch
  elevator completion API

as-iosched.patch
  anticipatory I/O scheduler

as-proc-read-write.patch
  AS: pgbench improvement

as-discrete-read-fifo-batches.patch
  AS: discrete read fifo batches

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

show_task-free-stack-fix.patch
  show_task() fix and cleanup

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

reboot_on_bsp.patch

kexec-revert-NORET_TYPE.patch

apic_shutdown.patch

i8259-shutdown.patch

hwfixes-x86kexec.patch

kexec-warning-fixes-2.patch

v4l-1.patch
  v4l: #1 - video-buf update

v4l-2.patch
  v4l: #2 - v4l1-compat update

v4l-3.patch
  v4l: #3 - bttv driver update

v4l-4.patch
  v4l: #4 - bttv docmentation update

v4l-5.patch
  v4l: #5 - i2c module updates.

v4l-6.patch
  v4l: #6 - tuner module update

v4l-7.patch
  v4l: #7 - saa7134 driver update

radeon-fb-64-bit-fix.patch
  radeonfb.c 64-bit fixes

aic-errno-removal.patch
  aic7xxx build fix

aic-non-i386-build-fix.patch
  aic7xxx non-i386 build fix

aic7xxx-fixes.patch

CONFIG_FUTEX.patch
  FUTEX support should be optional

CONFIG_EPOLL.patch
  eventpollfs configuration option

cs4281-cleanup.patch
  use %p to print pointers in cs4281

stanford-memcy-size-fixes.patch
  memcpy/memset fixes

stanford-crypto-fixes.patch
  memcpy/memset fixes

invalidate_mmap_range.patch
  Interface to invalidate regions of mmaps

BUG-to_BUG_ON.patch
  BUG() -> BUG_ON() conversions.

3c59x-id.patch
  3c59x: add support for 3c905B-T4, 3C920B-EMB-WNM

suspend-asm-fix.patch
  CONFIG_ACPI_SLEEP compile fix

handle-sparse-physical-apid-ids.patch
  fix handling of spares physical APIC ids

put_page_testzero-fix.patch
  put_page_testzero() fix

devpts-xattr-handler.patch
  devpts xattr handler for security labels 2.5.69-bk

unregister_netdev-cleanup.patch



