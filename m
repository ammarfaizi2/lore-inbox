Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbTESIIn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 04:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbTESIIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 04:08:43 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:4243 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262368AbTESIIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 04:08:30 -0400
Date: Mon, 19 May 2003 01:23:36 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.69-mm7
Message-Id: <20030519012336.44d0083a.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 May 2003 08:21:22.0703 (UTC) FILETIME=[A1DCF1F0:01C31DDF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69-mm7/

. Included most of the new AIO code which has been floating about.  This
  all still needs considerable thought and review, but we may as well get it
  under test immediately.

. Lots of little fixes, as usual.




Changes since 2.5.69-mm6:


-stanford-crypto-fixes.patch

 Merged

+ipv6-compile-fix.patch

 Build fix

+sysfs_create_link-fix.patch

 buffer overrun fix

+genarch_clustered_io_apic.patch

 build fix

+voyager_callout.patch

 cleanup

+sound-core-memalloc-build-fix.patch

 build fix

+ppp-warning-fix.patch

 runtime warning fix

+slab-magazine-tuning.patch
+slabinfo-rework.patch

 slab magazine-layer rework.
 
+aio-random-cleanups.patch

 minor AIO cleanups.

+apm-module-fix.patch

 Fix CONFIG_APM=m

+readdir-return-value-fix.patch

 Return EFAULT correctly from readdir

+resurrect-batch_requests.patch

 bring back request batching in the block layer

+proc-pid-attr-fix.patch

 security stuff

+time-interpolation-infrastructure.patch
+time-interpolation-infrastructure-fix.patch

 Infrastructure to stop gettimeofday from going backwards when interrupts
 are blocked for a long time.

+bttv-compile-fix.patch

 Build fix

+vt8237.patch

 Additional IDE support

+aio-01-retry.patch
+aio-01-retry-cleanup.patch
+aio-02-lockpage_wq.patch
+aio-03-fs_read.patch
+aio-04-buffer_wq.patch
+aio-05-fs_write.patch
+aio-06-bread_wq.patch
+aio-07-ext2getblk_wq.patch

 AIO enhancements

+aio-poll.patch
+aio-poll-cleanup.patch

 AIO poll

+via-agp-fix.patch

 AGP fix for VIA components

+DAC960-oops-fix.patch

 oops fix

+overcommit-root-margin.patch

 Give root some protectionin the memory overcommit code

+rpc-ifdef-fix.patch

 typo fix

+notify_count-for-de_thread.patch

 thread exit race fix

+it87-memset-fix.patch

 oops fix

+extend-check_valid_hugepage_range.patch

 cleanup, basis for ppc64 hugepage support.




All 141 patches:

linus.patch

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

ipv6-compile-fix.patch
  ipv6/route: fix .dst.metrics struct init for ip6_null_entry

sysfs_create_link-fix.patch
  sysfs_create_link() fix

subarch-circular-dependency-fix.patch
  ia32 subarch circular dependency fix

genarch_clustered_io_apic.patch
  genarch cpu_mask_to_apicid fix

voyager_callout.patch
  voyager cpu_callout_map fix

sound-core-memalloc-build-fix.patch
  soubd/core/memalloc.c needs mm.h

ppp-warning-fix.patch
  ppp warning fix

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

apm-module-fix.patch
  fix CONFIG_APM=m

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

bttv-compile-fix.patch
  fix tuner.c and tda9887.c

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

aio-07-ext2getblk_wq.patch
  AIO: Async get block for ext2

aio-poll.patch
  aio_poll

aio-poll-cleanup.patch
  aio-poll: don't put extern decls in .c!

via-agp-fix.patch
  Subject: Re: Kernel oops on boot with 2.5.69-mm{5,6}

DAC960-oops-fix.patch
  DAC960 oops fix

overcommit-root-margin.patch
  overcommit root margin

rpc-ifdef-fix.patch
  net/sunrpc/sunrpc_syms.c typo fix

notify_count-for-de_thread.patch
  add notify_count for de_thread

it87-memset-fix.patch
  it87 oopos fix

extend-check_valid_hugepage_range.patch
  rename and extend check_valid_hugepage_range()



