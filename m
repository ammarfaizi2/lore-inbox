Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264659AbTGBDY5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 23:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbTGBDY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 23:24:56 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:38680 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264659AbTGBDXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 23:23:40 -0400
Date: Tue, 1 Jul 2003 20:38:30 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.73-mm3
Message-Id: <20030701203830.19ba9328.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jul 2003 03:38:03.0228 (UTC) FILETIME=[578FE9C0:01C3404B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.73/2.5.73-mm3/

. The ext2 "free inodes corrupted" problem which Martin saw should be
  fixed.

. The ext3 assertion failure which Maneesh hit should be fixed (I can't
  reproduce this, please retest?)

. A patch from Neil which will hopefully fix the RAID "bio too big" bug. 
  Neil cannot reproduce that, so we are asking anyone who _can_ make this
  happen to test this out.

. The weird behaviour with time-n-date on SpeedStep machines should be
  fixed.  Some of the weird behaviour, at least.

. A tweak to the oom killer here may cause earlier oom-killings.  I was
  able to trigger just the one.  Keep an eye on that please.


And on a personal note: The OSDL will now be sponsoring my kernel work at
Digeo.  This means that I shall become akpm@osdl.org.  akpm@digeo.com still
will work.  Many thanks to the OSDL and Digeo teams who put this together.






Changes since 2.5.73-mm2:



-handle-no-readpage-2.patch
-pppoe-revert.patch
-ppc64-fixes-2.patch
-ppc64-bat-initialisation-fix.patch
-reiserfs-unmapped-buffer-fix.patch
-pcmcia-event-20030623-1.patch
-pcmcia-event-20030623-2.patch
-pcmcia-event-20030623-3.patch
-pcmcia-event-20030623-4.patch
-pcmcia-event-20030623-5.patch
-pcmcia-event-20030623-6.patch
-sym2-bus_addr-fix.patch
-lost-tick-speedstep-fix.patch
-sym2-remove-broken-bios-check.patch
-syslog-efault-reporting.patch
-dvd-ram-rw-fix.patch
-mixcomwd-update.patch
-arc-rimi-race-fix.patch
-slab-drain-all-objects-fix.patch
-ext3-remove-version.patch
-cdrom-eject-hang-fix.patch

 Merged

-numa-memory-reporting-fix.patch
+numa-memory-reporting-fix-2.patch

 Updated

+ramfs-use-generic_file_llseek.patch
+inode_change_ok-remove-lock_kernel.patch
+nommu-vmtruncate-no_lock_kernel.patch
+proc-lock_kernel-removal.patch
+fops-flush-no-lock_kernel.patch
+block_llseek-no-lock_kernel.patch

 lock_kernel()ectomy

+intel8x0-cleanup.patch

 Small driver cleanup

+TC35815-config-fix.patch

 Build fix

+CLONE_DETACHED-exit-fix.patch

 Report CLONE_DETACHED threads to gdb

+bio-too-big-fix.patch

 Might fix the RAID "bio too big" problems.

-linux-isp.patch
-isp-update-1.patch
-isp-remove-pci_detect.patch
-feral-fix.patch
+linux-isp-2.patch

 Slightly updated feral qlogic driver.

+aio-dio-no-readahead.patch

 Don't do readahead for AIO-over-direct-io

+nbd-ioctl-compat.patch

 NBD userspace compatibility.

-rename-timer.patch
+rename-timer-A1.patch
+lost-tick-speedstep-fix-A1.patch
+lost-tick-corner-fix-A0.patch

 Updated timer patches.  Mainly for addressing odd behaviour on SpeedStep
 machines.

-init_timer-debug-trap.patch

 Dropped due to lack of interest.

+ext2_new_inode-race-fix.patch

 Fix a race which causes ext2 to bogusly claim that the free inodes count
 was corrupted.

+oomkill-if-free-swap.patch

 Remove bogus test in the oom-killer.

+exec_mmap-is-the-point-of-no-return.patch

 Fix execve() bug

+double-mmdrop-fix.patch

 Fix another execve() bug

+cciss-hang-fix.patch

 cciss fix

+journal_release_buffer-race-fix.patch

 Fix ext3 assertion failure (?)





All 133 patches:


linus.patch

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kgdb-use-ggdb.patch

kgdb-ga-docco-fixes.patch
  kgdb doc. edits/corrections

HZ-100.patch

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-pci-update.patch

ppc64-reloc_hide.patch

ppc64-semaphore-reimplementation.patch
  ppc64: use the ia32 semaphore implementation

sym-do-160.patch
  make the SYM driver do 160 MB/sec

x86_64-fixes.patch
  x86_64 fixes

irqreturn-snd-via-fix.patch
  via sound irqreturn fix

config-PAGE_OFFSET.patch
  Configurable kenrel/user memory split

lru_cache_add-check.patch
  lru_cache_add debug check

delay-ksoftirqd-fallback.patch
  Try harded in IRQ context before falling back to ksoftirqd

fb-image-depth-fix.patch
  fbdev image depth fix

move_vma-VM_LOCKED-fix.patch
  move_vma() make_pages_present() fix

ds-09-vicam-usercopy-fix.patch
  vicam usercopy fix

buffer-debug.patch
  buffer.c debugging

e100-use-after-free-fix.patch

3-unmap-page-debugging.patch
  page unmappng debug patch

VM_RESERVED-check.patch
  VM_RESERVED check

ipcsem-speedup.patch
  ipc semaphore optimization

rcu-stats.patch
  RCU statistics reporting

mtrr-hang-fix.patch
  Fix mtrr-related hang

reslabify-pgds-and-pmds.patch
  re-slabify i386 pgd's and pmd's

numa-memory-reporting-fix-2.patch
  NUMA mamory reporting fix

ramfs-use-generic_file_llseek.patch
  ramfs: use ramfs-use-generic_file_llseek

inode_change_ok-remove-lock_kernel.patch
  inode_change_ok(): remove lock_kernel()

nommu-vmtruncate-no_lock_kernel.patch
  nommu vmtruncate: remove lock_kernel()

proc-lock_kernel-removal.patch
  procfs: remove some unneeded lock_kernel()s

fops-flush-no-lock_kernel.patch
  remove lock_kernel() from file_ops.flush()

block_llseek-no-lock_kernel.patch
  block_llseek(): remove lock_kernel()

intel8x0-cleanup.patch
  intel8x0 cleanups

TC35815-config-fix.patch
  Make CONFIG_TC35815 depend on CONFIG_TOSHIBA_JMR3927

CLONE_DETACHED-exit-fix.patch
  Report detached thread exit to the debugger

bio-too-big-fix.patch
  Fix raid "bio too big" failures

linux-isp-2.patch

list_del-debug.patch
  list_del debug check

airo-schedule-fix.patch
  airo.c: don't sleep in atomic regions

resurrect-batch_requests.patch
  bring back the batch_requests function

kblockd.patch
  Create `kblockd' workqueue

cfq-infrastructure.patch

elevator-completion-api.patch
  elevator completion API

as-iosched.patch
  anticipatory I/O scheduler
  AS: pgbench improvement
  AS: discrete read fifo batches
  AS sync/async batches
  AS: hash removal fix
  AS jumbo patch (for SCSI and TCQ)
  AS: fix stupid thinko
  AS: no batch-antic-limit
  AS: autotune write batches
  AS: divide by zero fix
  AS: more HZ != 1000 fixes
  AS: update_write_batch tuning
  AS locking
  AS HZ fixes

as-double-free-and-debug.patch
  AS: fix a leak + more debugging

as-fix-seek-estimation.patch
  AS: maybe repair performance drop of random read O_DIRECT

as-fix-seeky-loads.patch
  AS: fix IBM's seek load

unplug-use-kblockd.patch
  Use kblockd for running request queues

per-queue-nr_requests.patch
  per queue nr_requests

blk-invert-watermarks.patch
  blk_congestion_wait threshold cleanup

blk-as-hint.patch
  blk-as-hint

get_request_wait-oom-fix.patch
  handle OOM in get_request_wait().

blk-fair-batches.patch
  blk-fair-batches

blk-fair-batches-2.patch
  blk fair batches #2

generic-io-contexts.patch
  generic io contexts

blk-request-batching.patch
  block request batching

get_io_context-fix.patch
  get_io_context fixes

blk-allocation-commentary.patch
  block allocation comments

blk-batching-throttle-fix.patch
  blk batch requests fix

blk-batching-cleanups.patch
  block batching cleanups

print-build-options-on-oops.patch
  print a few config options on oops

mmap-prefault.patch
  prefault of executable mmaps

bio-debug-trap.patch
  BIO debugging patch

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

invalidate_mmap_range.patch
  Interface to invalidate regions of mmaps

aio-mm-refcounting-fix.patch
  fix /proc mm_struct refcounting bug

aio-01-retry.patch
  AIO: Core retry infrastructure

io_submit_one-EINVAL-fix.patch
  Fix aio process hang on EINVAL

aio-02-lockpage_wq.patch
  AIO: Async page wait

aio-03-fs_read.patch
  AIO: Filesystem aio read

aio-04-buffer_wq.patch
  AIO: Async buffer wait

aio-05-fs_write.patch
  AIO: Filesystem aio write

aio-05-fs_write-fix.patch

aio-06-bread_wq.patch
  AIO: Async block read

aio-06-bread_wq-fix.patch

aio-07-ext2getblk_wq.patch
  AIO: Async get block for ext2

O_SYNC-speedup-2.patch
  speed up O_SYNC writes

aio-09-o_sync.patch
  aio O_SYNC

aio-10-BUG-fix.patch
  AIO: fix a BUG

aio-11-workqueue-flush.patch
  AIO: flush workqueues before destroying ioctx'es

aio-12-readahead.patch
  AIO: readahead fixes

aio-dio-no-readahead.patch
  aio O_DIRECT no readahead

lock_buffer_wq-fix.patch
  lock_buffer_wq fix

unuse_mm-locked.patch
  AIO: hold the context lock across unuse_mm

aio-take-task_lock.patch
  From: Suparna Bhattacharya <suparna@in.ibm.com>
  Subject: Re: 2.5.72-mm1 - Under heavy testing with AIO,.. vmstat seems to blow the kernel

vfsmount_lock.patch
  From: Maneesh Soni <maneesh@in.ibm.com>
  Subject: [patch 1/2] vfsmount_lock

sched-hot-balancing-fix.patch
  fix for CPU scheduler load distribution

truncate-pagefault-race-fix.patch
  Fix vmtruncate race and distributed filesystem race

truncate-pagefault-race-fix-fix.patch
  Make sure truncate fix has no race

sleepometer.patch
  sleep instrumentation

time-goes-backwards.patch
  demonstrate do_gettimeofday() going backwards

skip-apic-ids-on-boot.patch
  skip apicids on boot

printk-oops-mangle-fix.patch
  disentangle printk's whilst oopsing on SMP

20-odirect_enable.patch

21-odirect_cruft.patch

22-read_proc.patch

23-write_proc.patch

24-commit_proc.patch

25-odirect.patch

nfs-O_DIRECT-always-enabled.patch
  Force CONFIG_NFS_DIRECTIO

seqcount-locking.patch
  i_size atomic access: infrastructure

i_size-atomic-access.patch
  i_size atomic access

aha152x-oops-fix.patch
  aha152X oops fixes

security_vm_enough_memory.patch
  Security hook for vm_enough_memory

nbd-cleanups.patch
  NBD: cosmetic cleanups

nbd-enhanced-diagnostics.patch
  nbd: enhanced diagnostics support

nbd-remove-blksize-bits.patch
  nbd: remove unneeded blksize_bits field

nbd-kobject-oops-fix.patch
  nbd: initialise the embedded kobject

nbd-paranioa-cleanups.patch
  nbd: cleanup PARANOIA usage & code

nbd-locking-fixes.patch
  nbd: fix locking issues with ioctl UI

nbd-ioctl-compat.patch
  nbd: add compatibility with previous ioctl user interface

rename-timer-A1.patch
  timer renaming and cleanups

lost-tick-speedstep-fix-A1.patch
  fix lost_tick detector for speedstep

lost-tick-corner-fix-A0.patch
  fix lost-tick compensation corner-case

lowmem_page_address-cleanup.patch
  cleanup and generalise lowmem_page_address

acpismp-fix.patch
  ACPI_HT_ONLY acpismp=force

div64-cleanup.patch
  Kill div64.h dupes and parenthesize do_div() parameters

ext2_new_inode-race-fix.patch
  ext2: inode allocation race fix

oomkill-if-free-swap.patch
  Don't skip oomkilling if there's free swap

exec_mmap-is-the-point-of-no-return.patch
  after exec_mmap(), exec cannot fail

double-mmdrop-fix.patch
  fix double mmdrop() on exec path

cciss-hang-fix.patch
  cciss: fix io hang

journal_release_buffer-race-fix.patch
  ext3: fix journal_release_buffer() race



