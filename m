Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270385AbTHBWVX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 18:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270386AbTHBWVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 18:21:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:8864 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270385AbTHBWU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 18:20:58 -0400
Date: Sat, 2 Aug 2003 15:22:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-test2-mm3
Message-Id: <20030802152202.7d5a6ad1.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2/2.6.0-test2-mm3/

. Con's CPU scheduler rework has been dropped out and Ingo's changes have
  been added.

  Con's changes demonstrated that additional infrastructure is needed to
  solve these problems correctly.  Ingo's patch adds those.  Con is
  continuing to rebase his work on these changes.

. Added Ingo's 4G/4G memory split patch.  It takes my kernel build from
  1:51 to 1:53 so gee.

  Big fat warning: whenever you change the value of CONFIG_X86_4G you will
  need to run a `make clean'.  Or just remove arch/i386/boot/setup.o.

  The build system seems to not notice that setup.S depends on
  CONFIG_X86_4G and the resulting kernel immediately triplefaults.

. A device mapper update.

. Several reiserfs bugfixes

. I don't think anyone has reported on whether 2.6.0-test2-mm2 fixed any
  PS/2 or synaptics problems.  You are all very bad.




Changes since 2.6.0-test2-mm2:


+linus.patch

 Latest Linus tree

-alsa-bk-2003-07-28.patch
-x86_64-merge.patch
-misc31.patch
-selinux.patch
-reslabify-pgds-and-pmds.patch
-buffer-debug.patch
-centrino-update.patch
-3c59x-pm-fix.patch
-dev_t-printing.patch
-rootdisk-parsing-fix.patch
-3c59x-eisa-fix.patch
-slab-reclaim-accounting-fix.patch
-stack-leak-fix.patch
-unlock_buffer-barrier.patch
-invalidate_mmap_range.patch
-buffer_io_error-readahead-fix.patch
-force_page_cache_readahead.patch
-truncate-pagefault-race-fix.patch
-truncate-pagefault-race-fix-fix.patch
-no_page-memory-barriers.patch
-ext3-elide-inode-block-reading.patch
-ext3_getblk-race-fix.patch
-ext3_write_super-speedup.patch
-alloc_bootmem_low_pages-ordering-fix.patch
-sis-drm-fix.patch
-soundcard-devfs-fix.patch
-6pack-hz-fix.patch
-devfs_lookup-revert-and-refix.patch
-write-mark_page_accessed.patch
-less-kswapd-throttling.patch
-zone-pressure.patch
-reclaim-mapped-pressure.patch
-xfs-dio-unwritten-extents.patch
-force-CONFIG_INPUT.patch
-ipt_helper-build-fix.patch
-select-xoffed-tty-fix.patch
-conntrack-build-fix.patch
-arcnet-typo-fix.patch
-ext3-commit-assertion-fix.patch
-read_dir-fix.patch
-blk_start_queue-fix.patch
-special_file-move.patch
-remove-queue_wait.patch
-uidhash-locking.patch
-osf-partition-handling.patch
-com20020_cs-build-fix.patch
-hdlc-build-fix.patch
-add-mandocs-target.patch
-binfmt_script-argv0-fix.patch
-bttv-driver-update.patch
-ppp-xon-xoff-handling.patch
-dac960-devfs-fix.patch
-dquot-typo-fix.patch
-i810-fix.patch
-intel-agp-oops-fix.patch
-export-agp_memory_reserved.patch
-pci_device_id-devinitdata.patch
-airo-fixes.patch
-ppc32-cpu-registration-fix.patch
-impi-build-fix.patch
-document-nfs-utils.patch
-untested-quota-fix.patch
-generic-hdlc-updates.patch
-stallion-devfs-fix.patch
-dm-rename-resume.patch
-serial-is-not-experimental.patch
-ftl-warning-fix.patch
-watchdog-module-param-fixes.patch

 merged

+execve-fixes.patch

 Fix exeve() emulation for various 64-bit architectures

+x86_64-cpumask_t-fix.patch

 Maybe fix x86_64 merge for cpumask_t

+ppc64-local.patch
+ppc64-sections.patch
+ppc64-sched_clock.patch
+ppc64-prom-compile-fix.patch

 Various ppc64 hacks to make it build and work.

-rcu-stats.patch

 Dropped.  rcu_grace_period.patch broke it.

+rcu-grace-period.patch

 Instrumentation to help solve the rcu-for-route-cache starvation problem.

-o1-interactivity.patch
-o2int.patch
-o3int.patch
-o4int.patch
-o5int-2.patch
-o6int.patch
-o6.1int.patch
-o7int.patch
-o8int.patch
-o9int.patch
-o10int.patch
-o11int.patch
-o11int.1.patch
-o11.2int.patch

 Dropped.

+sched-2.6.0-test2-mm2-A3.patch

 Ingo's CPu scheduler update.

+sched-warning-fix.patch

 Fix a warning in it.

+nforce2-acpi-fixes-fix.patch

 Fix for the fix for ACPI problems with the nforce chipset

+synaptics-mode-set.patch

 Fix old synaptics touchpads.

+4g-2.6.0-test2-mm2-A5.patch

 4G/4G split

+4g4g-cleanups.patch

 Tidy some warnings in it

+kgdb-4g4g-fix-2.patch

 Fix kgdb for 4G/4G

+4g4g-config-fix.patch

 Tidy up the config options.

+dm-1-module-param.patch
+dm-2-blk.patch
+dm-3-use-hex.patch
+dm-4-64-bit-ioctls.patch
+dm-5-missing-include.patch
+dm-6-sector_div.patch
+dm-7-rename-resume.patch

 Device mapper update

+reiserfs-savelinks-endianness-fix.patch
+reiserfs-enospc-fix.patch
+reiserfs-link-unlink-race-fix.patch

 Reiserfs fixes

+mremap-atomicity-fix.patch

 mremap() fix

+spurious-SIGCHLD-fix.patch

 signal fix

+aic7xxx_old-oops-fix.patch

 aic7xxx_old not real fix.

+ide-cd-oops-fix.patch

 Fix oops with ide-cd on end-of-disk errors.

+awe-core.patch
+awe-core-fixes.patch
+awe-use-gfp_flags.patch
+awe-use-gfp_flags-fixes.patch
+awe-fix-truncate-errors.patch
+awe-fix-truncate-errors-fixes.patch

 Report EIO and ENOSPC errors during async writeout to userspace.

+as-remove-hash-valid-stuff.patch

 Anticipatory scheduler leftovers

+usercopy-might_sleep-checks.patch

 might_sleep() checks in usercopy functions.



All 130 patches:

linus.patch
  cset-20030802_1915.txt.gz

mm.patch
  add -mmN to EXTRAVERSION

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)

kgdb-remove-cpu_callout_map.patch
  kgdb: remove cpu_callout_map decls

kgdb-use-ggdb.patch

kgdb-ga-docco-fixes.patch
  kgdb doc. edits/corrections

execve-fixes.patch
  fix 64-bit architectures for the binprm change

cpumask_t-1.patch
  cpumask_t: allow more than BITS_PER_LONG CPUs
  cpumask_t fix for s390
  fix cpumask_t for s390
  Fix cpumask changes for x86_64
  fix cpumask_t for sparc64

cpumask_t-gcc-workaround-46.patch
  cpumask_t: more gcc workarounds

cpumask_t-gcc-workaround-47.patch
  cpumask_t gcc bug workarounds

cpumask-acpi-fix.patch
  cpumask_t: build fix

kgdb-cpumask_t.patch

x86_64-cpumask_t-fix.patch

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-bar-0-fix.patch
  Allow PCI BARs that start at 0

ppc64-reloc_hide.patch

ppc64-semaphore-reimplementation.patch
  ppc64: use the ia32 semaphore implementation

ppc64-local.patch
  ppc64: local.h implementation

ppc64-sections.patch
  ppc64: implement sections.h

ppc64-sched_clock.patch
  ppc64: sched_clock()

ppc64-prom-compile-fix.patch
  ppc64: prom.c compile fix

sym-do-160.patch
  make the SYM driver do 160 MB/sec

ia64-percpu-revert.patch
  revert percpu changes

x86_64-fixes.patch
  x86_64 fixes

delay-ksoftirqd-fallback.patch
  Try harded in IRQ context before falling back to ksoftirqd

ds-09-vicam-usercopy-fix.patch
  vicam usercopy fix

rcu-grace-period.patch
  Monitor RCU grace period

mtrr-hang-fix.patch
  Fix mtrr-related hang

intel8x0-cleanup.patch
  intel8x0 cleanups

bio-too-big-fix.patch
  Fix raid "bio too big" failures

ppa-fix.patch
  ppc fix

linux-isp-2.patch

linux-isp-2-fix-again.patch
  lost feral fix

feral-bounce-fix.patch
  Feral driver - highmem issues

feral-bounce-fix-2.patch
  Feral driver bouncing fix

list_del-debug.patch
  list_del debug check

print-build-options-on-oops.patch
  print a few config options on oops

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

64-bit-dev_t-other-archs.patch
  enable 64-bit dev_t for other archs

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

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

kjournald-PF_SYNCWRITE.patch

sched-2.6.0-test2-mm2-A3.patch
  sched-2.6.0-test2-mm2-A3

sched-warning-fix.patch

sched-balance-tuning.patch
  CPU scheduler balancing fix

ext3-block-allocation-cleanup.patch

nfs-revert-backoff.patch
  nfs: revert backoff changes

floppy-smp-fixes.patch
  floppy smp fixes

1000HZ-time-accuracy-fix.patch
  missing #if for 1000 HZ

signal-race-fix.patch
  signal handling race condition causing reboot hangs

vmscan-defer-writepage.patch
  vmscan: give dirty referenced pages another pass around the LRU

blacklist-asus-L3800C-dmi.patch
  add ASUS l3800P to DMI black list

nforce2-acpi-fixes.patch
  ACPI patch which fixes all my IRQ problems on nforce2

nforce2-acpi-fixes-fix.patch

remove-const-initdata.patch
  __initdata cant be marked const

timer-race-fixes.patch
  timer race fixes

local-apic-enable-fixes.patch
  Local APIC enable fixes

p00001_synaptics-restore-on-close.patch

p00002_psmouse-reset-timeout.patch

p00003_synaptics-multi-button.patch

p00004_synaptics-optional.patch

p00005_synaptics-pass-through.patch

p00006_psmouse-suspend-resume.patch

p00007_synaptics-old-proto.patch

synaptics-mode-set.patch
  Synaptics mode setting

bridge-notification-fix.patch
  Fix bridge notification processing

keyboard-resend-fix.patch
  keyboard resend fix

kobject-paranoia-checks.patch
  Driver core and kobject paranoia checks

4g-2.6.0-test2-mm2-A5.patch
  4G/4G split patch

4g4g-cleanups.patch

kgdb-4g4g-fix-2.patch

4g4g-config-fix.patch

dm-1-module-param.patch
  dm: don't use MODULE_PARM

dm-2-blk.patch
  dm: remove blk.h include

dm-3-use-hex.patch
  dm: decimal device num sscanf

dm-4-64-bit-ioctls.patch
  dm: 64 bit ioctl fixes

dm-5-missing-include.patch
  dm: missing #include

dm-6-sector_div.patch
  dm: use sector_div()

dm-7-rename-resume.patch
  dm: resume() name clash

reiserfs-savelinks-endianness-fix.patch
  reiserfs: fix savelinks on bigendian arches

reiserfs-enospc-fix.patch
  reiserfs: fix problem when fs is out of space

reiserfs-link-unlink-race-fix.patch
  reiserfs: fix races between link and unlink on same file

mremap-atomicity-fix.patch
  move_one_page() atomicity fix

spurious-SIGCHLD-fix.patch
  spurious SIGCHLD from dying thread group leader

aic7xxx_old-oops-fix.patch

ide-cd-oops-fix.patch
  ide-cd error handling oops fix

xfs-use-after-free-fix.patch
  XFS use-after-free fix

awe-core.patch
  async write errors: report truncate and io errors on async writes

awe-core-fixes.patch
  async write errors core: fixes

awe-use-gfp_flags.patch
  async write errors: use flags in address space

awe-use-gfp_flags-fixes.patch
  async write errors: mapping->flags fixes

awe-fix-truncate-errors.patch
  async write errors: fix spurious fs truncate errors

awe-fix-truncate-errors-fixes.patch
  async write errors: truncate handling fixes

as-remove-hash-valid-stuff.patch
  AS: remove hash valid stuff

usercopy-might_sleep-checks.patch
  might_sleep() checks for usercopy functions

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

aio-O_SYNC-fix.patch
  Unify o_sync changes for aio and regular writes

aio-readahead-rework.patch
  Unified page range readahead for aio and regular reads



