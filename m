Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTEVJBL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 05:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbTEVJBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 05:01:11 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:22407 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262610AbTEVJBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 05:01:02 -0400
Date: Thu, 22 May 2003 02:16:52 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.69-mm8
Message-Id: <20030522021652.6601ed2b.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 May 2003 09:14:05.0285 (UTC) FILETIME=[7E25E950:01C32042]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69-mm8/

. One anticipatory scheduler patch, but it's a big one.  I have not stress
  tested it a lot.  If it explodes please report it and then boot with
  elevator=deadline.

. The slab magazine layer code is in its hopefully-final state.

. Some VFS locking scalability work - stress testing of this would be
  useful.



Changes since 2.5.69-mm7:


-ipv6-compile-fix.patch
-sysfs_create_link-fix.patch
-subarch-circular-dependency-fix.patch
-genarch_clustered_io_apic.patch
-voyager_callout.patch
-sound-core-memalloc-build-fix.patch
-ppp-warning-fix.patch
-misc.patch
-large-dma_addr_t-PAE-only.patch
-3c59x-irq-fix.patch
-reiserfs-multiple-block-insertion.patch
-reiserfs_file_write-6.patch
-apm-module-fix.patch
-vmtruncate-PAGE_SIZE-fix.patch
-v4l-1.patch
-v4l-2.patch
-v4l-3.patch
-v4l-4.patch
-v4l-5.patch
-v4l-6.patch
-v4l-7.patch
-bttv-compile-fix.patch
-radeon-fb-64-bit-fix.patch
-cs4281-cleanup.patch
-stanford-memcy-size-fixes.patch
-BUG-to_BUG_ON.patch
-3c59x-id.patch
-suspend-asm-fix.patch
-handle-sparse-physical-apid-ids.patch
-put_page_testzero-fix.patch
-via-agp-fix.patch
-DAC960-oops-fix.patch
-it87-memset-fix.patch

 Merged

+kmalloc_percpu-interface-change-warning-fix.patch

 kmalloc_percpu() interface change

+ppc64-addnote-warning-fix.patch
+ppc64-fp-warning-fix.patch
+ppc64-do_signal32-fix.patch
+ppc64-xics-warning-fix.patch
+ppc64-prom-warning-fix.patch
+ppc64-compat-build-fix.patch
+ppc64-ioctl32-warning-fix-2.patch
+ppc64-setup-warning-fix.patch
+ppc64-traps-warning-fixes.patch
+ppc64-lpar-warning-fixes.patch
+tty_io-warning-fix.patch
+siocdevprivate_ioctl-warning-fix.patch

 Compile warning massacre

+apm-set_cpus_allowed-fix.patch

 Race fix.

+as-sync-async.patch

 Anticipatory scheduler change

-sched-2.5.68-B2.patch
-sched_idle-typo-fix.patch
-kgdb-ga-idle-fix.patch
-sched-2.5.64-D3.patch

 The HT scheduler (and its fallout) broke.  It needs updating.

+slab-reclaimable-accounting.patch
+slab-reclaimable-accounting-fs.patch

 Account for reclaimable slab pages in slab itself (for vm_enough_memory)

+aio-06-bread_wq-fix.patch

 AIO fixlet

+misc2.patch

 Misc fixes (mainly more warnings)

+io_stats-documentation.patch

 Document the disk accounting stats

+voyager-do_fork-fix.patch

 Fix voyager crash

+cpia-fp-removal.patch

 Don't use float in kernel

+vfsmount_lock.patch
+lockfree-lookup_mnt.patch

 Take some pressure off dcache_lock.




All 129 patches:


linus.patch

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kmalloc_percpu-interface-change.patch
  kmalloc_percpu: interface change.

kmalloc_percpu-interface-change-warning-fix.patch
  nail a warning

irqreturn-drivers-net.patch

slab-magazine-layer.patch
  magazine layer for slab

slab-magazine-tuning.patch
  tuning for slab-magazine-layer.patch

slabinfo-rework.patch
  new statistics for slab

aio-random-cleanups.patch

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

ppc64-addnote-warning-fix.patch
  Squash warning in ppc64 addnote tool

ppc64-fp-warning-fix.patch
  Squash implicit declaration warning in ppc64 align.c

ppc64-do_signal32-fix.patch
  ppc64 do_signal32 warning fix

ppc64-xics-warning-fix.patch
  Squash warning in ppc64 xics.c

ppc64-prom-warning-fix.patch
  Unused variables in ppc64 prom.c

ppc64-compat-build-fix.patch
  ppc64 build fix

ppc64-ioctl32-warning-fix-2.patch
  ppc64 ioctl32 warning fix

ppc64-setup-warning-fix.patch
  nail warnings in arch/ppc64/kernel/setup.c

ppc64-traps-warning-fixes.patch
  arch/ppc64/kernel/traps.c warning fixes

ppc64-lpar-warning-fixes.patch
  ppc64: more warning fixes

tty_io-warning-fix.patch
  tty_io warning fix

siocdevprivate_ioctl-warning-fix.patch
  siocdevprivate_ioctl warning fix

aic-errno-removal.patch
  aic7xxx build fix

aic-non-i386-build-fix.patch
  aic7xxx non-i386 build fix

aic7xxx-fixes.patch

sym-do-160.patch
  make the SYM driver do 160 MB/sec

irqreturn-snd-via-fix.patch
  via sound irqreturn fix

irq_cpustat-cleanup.patch
  irq_cpustat cleanup

config-PAGE_OFFSET.patch
  Configurable kenrel/user memory split

irq-check-rate-limit.patch
  IRQs: handle bad return values from handlers

irq_desc-others.patch
  Fix up irq_desc initialisation for non-ia32

dcache_lock-vs-tasklist_lock-take-3.patch
  Fix dcache_lock/tasklist_lock ranking bug

apm-set_cpus_allowed-fix.patch
  APM does unsafe conditional set_cpus_allowed

buffer-debug.patch
  buffer.c debugging

ext3-truncate-ordered-pages.patch
  ext3: explicitly free truncated pages

VM_RESERVED-check.patch
  VM_RESERVED check

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

readdir-return-value-fix.patch
  Fix readdir error return value

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

resurrect-batch_requests.patch
  bring back the batch_requests function

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

as-sync-async.patch
  AS sync/async batches

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

sched-numa-warning-fix.patch
  scheduler warning fix for NUMA

acpi-irq-ret-fix.patch
  acpi irq return value fix

sound-irq-hack.patch

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

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

slab-reclaimable-accounting.patch
  slab: account for reclaimable caches

slab-reclaimable-accounting-fs.patch
  mark shrinkable slabs as being reclaimable

security-process-attribute-api.patch
  Process Attribute API for Security Modules

proc-pid-attr-fix.patch
  Process Attribute API for Security Modules (fixlet)

proc-pid-security-labels.patch
  /proc/pid inode security labels

time-interpolation-infrastructure.patch
  improved core support for time-interpolation

time-interpolation-infrastructure-fix.patch
  make timer interpolation patch compile

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

CONFIG_FUTEX.patch
  FUTEX support should be optional

CONFIG_EPOLL.patch
  eventpollfs configuration option

invalidate_mmap_range.patch
  Interface to invalidate regions of mmaps

devpts-xattr-handler.patch
  devpts xattr handler for security labels 2.5.69-bk

unregister_netdev-cleanup.patch

vt8237.patch
  vt8237 IDE support

aio-01-retry.patch
  AIO: Core retry infrastructure

aio-01-retry-cleanup.patch
  aio trivia

aio-02-lockpage_wq.patch
  AIO: Async page wait

aio-03-fs_read.patch
  AIO: Filesystem aio read

aio-04-buffer_wq.patch
  AIO: Async buffer wait

aio-05-fs_write.patch
  AIO: Filesystem aio write

aio-06-bread_wq.patch
  AIO: Async block read

aio-06-bread_wq-fix.patch

aio-07-ext2getblk_wq.patch
  AIO: Async get block for ext2

aio-poll.patch
  aio_poll

aio-poll-cleanup.patch
  aio-poll: don't put extern decls in .c!

overcommit-root-margin.patch
  overcommit root margin

rpc-ifdef-fix.patch
  net/sunrpc/sunrpc_syms.c typo fix

notify_count-for-de_thread.patch
  add notify_count for de_thread

extend-check_valid_hugepage_range.patch
  rename check_valid_hugepage_range()

misc2.patch
  misc fixes

io_stats-documentation.patch
  Documentation for disk iostats

voyager-do_fork-fix.patch
  do_fork fixes for voyager x86 subarch

cpia-fp-removal.patch
  Remove floating point use in cpia.c

vfsmount_lock.patch
  From: Maneesh Soni <maneesh@in.ibm.com>
  Subject: [patch 1/2] vfsmount_lock

lockfree-lookup_mnt.patch
  lockfree lookup_mnt



