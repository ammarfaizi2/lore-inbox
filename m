Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265061AbTF1DHi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 23:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265065AbTF1DHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 23:07:38 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:65117 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265061AbTF1DHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 23:07:03 -0400
Date: Fri, 27 Jun 2003 20:21:30 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.73-mm2
Message-Id: <20030627202130.066c183b.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jun 2003 03:21:18.0892 (UTC) FILETIME=[574766C0:01C33D24]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.73/2.5.73-mm2/

Just bits and pieces.





Changes since 2.5.73-mm1:


 linus.patch

 Latest Linus tree

-show_stack-fix.patch
-pci-1.patch
-pci-2.patch
-pci-3.patch
-pci-4.patch
-pci-5.patch
-alsa-pnp-fix.patch
-setscheduler-fix.patch
-ide_setting_sem-fix.patch
-misc6.patch
-AT_SECURE-auxv-entry.patch
-common-kernel-DSO-name.patch
-get_unmapped_area-speedup.patch
-d_invalidate-fix.patch
-nfs_unlink-d_count-fix.patch
-hpfs-d_count-fix.patch
-smbfs-oops-workaround.patch
-enable-cardbus-bursting.patch
-n_tty-column-counting-fix.patch
-numa-normalised-node-load.patch
-enable-local-apic-on-p4.patch
-knfsd-umount-fix.patch
-getrlimit-ifdef-fix.patch
-amd64-monotonic-clock.patch

 Merged

+kgdb-ga-docco-fixes.patch

 kgdb documentation fixes

+pppoe-revert.patch

 Back out broken pppoe changes until it gets fixed up.

+move_vma-VM_LOCKED-fix.patch

 Fix the mremap use-after-free fix

+ipcsem-speedup.patch

 Speed up sysv semaphore operations

+feral-fix.patch

 Fix the linux_isp qlogic driver for non-odular builds.

-cfq-2.patch

 Dropped.  I'm firming up the IO scheduler rework for a merge and the -mm
 CFQ inplementation is way out of date.

+blk-batching-cleanups.patch

 Minor touchups

+truncate-pagefault-race-fix-fix.patch

 Tighten up the MP synchronisation

-security-vm_enough_memory.patch
+security_vm_enough_memory.patch

 New version

+nbd-remove-blksize-bits.patch
+nbd-kobject-oops-fix.patch
+nbd-paranioa-cleanups.patch
+nbd-locking-fixes.patch

 More NBD work

-nr_running-speedup.patch

 Dropped.  It seemed to have no net benefit.

+lowmem_page_address-cleanup.patch

 Simplify lowmem_page_address()

+numa-memory-reporting-fix.patch

 Fix NUMA memory reporting (needs more work)

+syslog-efault-reporting.patch

 check copy_*_user return values

+acpismp-fix.patch

 Fix `acpismp=force'

+div64-cleanup.patch

 Consolidate and fix div64 code

+init_timer-debug-trap.patch

 Debug code to catch people running init_timer() against a running timer.

+dvd-ram-rw-fix.patch

 ide-scsi RW mount fix

+mixcomwd-update.patch
+arc-rimi-race-fix.patch

 minor fixups

+slab-drain-all-objects-fix.patch

 Make slab free up all the objects when destroying caches.

+ext3-remove-version.patch

 Remove the version information from ext3.

+cdrom-eject-hang-fix.patch

 Fix mount-time hangs caused by CDROM eject commands.





All 138 patches:


linus.patch
  cset-1.1348.16.4-to-1.1516.txt.gz

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kgdb-use-ggdb.patch

kgdb-ga-docco-fixes.patch
  kgdb doc. edits/corrections

HZ-100.patch

handle-no-readpage-2.patch
  check for presence of readpage() in the readahead code

pppoe-revert.patch
  PPPOE reversion

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-fixes-2.patch
  Maek ppc64 compile

ppc64-bat-initialisation-fix.patch
  ppc64: BAT initialisation fix

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

reiserfs-unmapped-buffer-fix.patch
  Fix reiserfs BUG

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

linux-isp.patch

isp-update-1.patch

isp-remove-pci_detect.patch

feral-fix.patch
  linux-isp fix

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

pcmcia-event-20030623-1.patch

pcmcia-event-20030623-2.patch

pcmcia-event-20030623-3.patch

pcmcia-event-20030623-4.patch

pcmcia-event-20030623-5.patch

pcmcia-event-20030623-6.patch

sym2-bus_addr-fix.patch
  sym53c8xx_2 bus_addr fix

lost-tick-speedstep-fix.patch
  Fix lost tick detection for speedstep

sym2-remove-broken-bios-check.patch
  remove a bogus check in sym2 driver

rename-timer.patch
  timer cleanups

lowmem_page_address-cleanup.patch
  cleanup and generalise lowmem_page_address

numa-memory-reporting-fix.patch
  fix NUMA memory reporting ... again

syslog-efault-reporting.patch
  Fix syslog(2) EFAULT reporting

acpismp-fix.patch
  ACPI_HT_ONLY acpismp=force

div64-cleanup.patch
  Kill div64.h dupes and parenthesize do_div() parameters

init_timer-debug-trap.patch
  init_timer debugging

dvd-ram-rw-fix.patch
  2.5.73 can't mount DVD-RAM via ide-scsi

mixcomwd-update.patch
  Remove check_region and MOD_*_USE_COUNT from mixcomwd.c

arc-rimi-race-fix.patch
  Remove racy check_mem_region() call from arc-rimi.c

slab-drain-all-objects-fix.patch
  kmem_cache_destroy() forgets to drain all objects

ext3-remove-version.patch
  ext3: remove the version number

cdrom-eject-hang-fix.patch
  cdrom eject scribbles on the request flags



