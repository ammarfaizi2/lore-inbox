Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbUCHGde (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 01:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUCHGdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 01:33:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:29605 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262413AbUCHGcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 01:32:20 -0500
Date: Sun, 7 Mar 2004 22:32:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.4-rc2-mm1
Message-Id: <20040307223221.0f2db02e.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4-rc2/2.6.4-rc2-mm1/


- Added Jens's patch which teaches the kernel to use DMA when reading
  audio from IDE CDROM drives.  These devices tend to be flakey, and we
  need lots of testing please.

- Re-added the device mapper update

- Brought back Ingo's patch which permits remap_file_pages() to set the
  memory access permissions on a per-page basis.  This is mainly interesting
  for its very significant performance benefits to UML.

  Breaks the build on most architectures.  There are how-to-fix-it
  instructions in the changelog.

- A new version of the patch which permits ext3 quota updates to be fully
  journalled.




Changes since 2.6.4-rc1-mm2:


 linus.patch
 bk-acpi.patch
 bk-alsa.patch
 bk-input.patch
 bk-netdev.patch
 bk-scsi.patch
 bk-usb.patch

 Latest external trees

-fastcall-warning-fixes.patch
-fastcall-warning-fixes-2.patch
-ppc64-xmon-survival-fix.patch
-put_compat_timespec-prototype-fix.patch
-sparc-sys_ioperm-fix.patch
-support-zillions-of-scsi-disks.patch
-tulip-printk-cleanup.patch
-parport-01-move-exports.patch
-parport-02-use-module_init.patch
-parport-03-sysctls-use-module_init.patch
-parport-04-move-option-parsing.patch
-parport-irq-warning-fix.patch
-parport-05-parport_pc_probe_port-fixes.patch
-parport-06-refcounting-fixes.patch
-parport-07-unregister-fixes.patch
-parport-08-parport_announce-cleanups.patch
-parport-09-track-used-ports.patch
-parport-09-track-used-ports-fix.patch
-parport-10-sunbpp-track-ports.patch
-parport-11-remove-parport_enumerate.patch
-parport-12-driver-list-cleanup.patch
-hitachi-scsi_devinfo-fix.patch
-zwane-is-floppy-maintainer-now.patch
-rioctrl-retval-fixes.patch
-initrd-kconfig-dependencies.patch
-queue-congestion-callout.patch
-queue-congestion-dm-implementation.patch
-cs46_xx-c99-fix.patch
-remove-nlmclnt_grace_wait.patch
-HPFS3-hpfs_iget-RC4-rc1.patch
-HPFS4-hpfs_lock_iget-RC4-rc1.patch
-HPFS5-hpfs_locking-RC4-rc1.patch
-HPFS6-hpfs_cleanup-RC4-rc1.patch
-HPFS7-hpfs_cleanup2-RC4-rc1.patch
-HPFS8-hpfs_race2-RC4-rc1.patch
-HPFS9-hpfs_deadlock-RC4-rc1.patch
-HPFS10-fix-RC4-rc1.patch
-alpha-switch-semaphores.patch
-serial_core-build-fix.patch
-sb16-sample-size-fix.patch
-ext2-ext3-ENOSPC-fix.patch
-missing-MODULE_LICENSEs.patch
-v4l1-compatibility-module-fix.patch
-i2o-fixes.patch

 Merged

+move-dma_consistent_dma_mask-sn-fix.patch

 Fix move-dma_consistent_dma_mask.patch for SN platforms

+export-filemap_flush.patch

 XFS needs this symbol.

+vma-corruption-fix.patch

 Fix nasty memory management race.

-ext3-journalled-quotas.patch
-ext3-journalled-quotas-warning-fix.patch
-ext3-journalled-quotas-cleanups.patch
+ext3-journalled-quotas-2.patch

 New journal-quotas-on-ext3 patch.

+sched-smt-nice-optimisation.patch

 CPU scheduler tuneup for SMT hardware.

+ide-scsi-error-handling-update.patch

 Update to ide-scsi-error-handling-fixes.patch

-doc2000-warning-fixes.patch

 Dropped - this driver is otherwise broken.

-scsi-host-allocation-fix.patch

 A perfectly good patch dropped :( Apparently it will expose races in
 userspace's handling of the existing /proc API's.

-remove-more-KERNEL_SYSCALLS-build-fix.patch
-remove-more-KERNEL_SYSCALLS-build-fix-2.patch

 Folded into remove-more-KERNEL_SYSCALLS.patch

+mq-security-fix.patch

 POSIX message queue fix

+dm-01-endio-method.patch
+dm-03-list_for_each_entry-audit.patch
+dm-04-default-queue-limits-fix.patch
+dm-05-list-targets-command.patch
+dm-06-stripe-width-fix.patch

 Device Mapper update

+dm-maplock.patch

 Add an rwlock to the device mapper maptable management so that
 +queue-congestion-dm-implementation.patch does not try to take a semaphore
 inside a spinlock.

-blk-unplug-when-max-request-queued.patch

 This was buggy, and is hard to fix.

-pdc_202xx_old-update.patch

 This broke, and was a duplicate of other IDE patches.  I think.  It got
 very confusing in there.

+cdromaudio-use-dma.patch

 Use IDE DMA for reading audio CDROMs

+sysfs-pin-kobject.patch

 I was asked to bring back this sysfs race fix.

+ATI-IXP-IDE-support.patch

 ATI IXP IDE support

+ipmi-updates-3.patch
+ipmi-socket-interface.patch

 IPMI driver updates

+md-use-schedule_timeout.patch

 Don't use yield() in the RAID drivers

+md-array-assembly-fix.patch

 RAID fix

+compiler_h-scope-fixes.patch

 Header file fix

+remap-file-pages-prot-2.6.4-rc1-mm1-A1.patch

 Per-page permissions for remap_file_pages()

+nmi_watchdog-local-apic-fix.patch
+nmi-1-hz.patch

 NMI watchdog fixes

+elf-mmap-fix.patch

 Don't hardwire the mmap size.

+kbuild-more-cleaning.patch

 Make `make clean' delete more things

+loop-setup-race-fix.patch

 Loop race fix.

+handle-dot-o-paths.patch

 kbuild pathname fix

+acpi-asmlinkage-fix.patch

 ACPI build fix for current gcc

+ipc-sem-extra-sem_unlock.patch

 Missing unlock in the IPC code.

+procfs-dangling-subdir-fix.patch

 Trap buggy /proc users

+AMD-768MPX-bootmem-fix.patch

 "works around the infamous "only works stable when a mouse is plugged in"
 problem some AMD 768MPX Dual Athlon chipsets have"

+i810fb-on-x86_64.patch

 Enable i810fb on x86_64

+ext23-remove-acl-limits.patch

 ACL uture-proofness

+watchdog-moduleparam-patches.patch

 Watchdog driver module parameter updates

+amd-elan-fix.patch

 Conig fix for AMD ELAN.

+pcmcia-netdev-ordering-fixes.patch

 Attempt to fix some ordering problems with PCMCIA netdevices.

-shrink-inode-cache-harder.patch

 Drop this - it was entirely too speculative and might actually slow things
 down.

+4g4g-handle_BUG-fix.patch

 Fix the handling of BUG()s when using the 4:4 split.

+ppc-fixes-dependency-fix.patch

 Make dependency fix

+restore-writeback-trylock.patch

 More fiddling with the writebakc locking for the O_DIRECT-vs-buffered
 problem.  Am getting a bit tired of this problem.

+aio-direct-io-oops-fix.patch

 Fix an AIO oops due to aio-fallback-bio_count-race-fix-2.patch





All 232 patches:


linus.patch

bk-acpi.patch

bk-alsa.patch

bk-input.patch

bk-netdev.patch

bk-scsi.patch

bk-usb.patch

mm.patch
  add -mmN to EXTRAVERSION

dma_sync_for_device-cpu.patch
  dma_sync_for_{cpu,device}()

move-dma_consistent_dma_mask.patch
  move consistent_dma_mask to the generic device

move-dma_consistent_dma_mask-x86_64-fix.patch

move-dma_consistent_dma_mask-sn-fix.patch
  Fix dma_mask patch for sn platform

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix
  kgdb buffer overflow fix
  kgdbL warning fix
  kgdb: CONFIG_DEBUG_INFO fix
  x86_64 fixes
  correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)

kgdb-ga-recent-gcc-fix.patch
  kgdb: fix for recent gcc

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll

kgdboe-non-ia32-build-fix.patch

kgdb-warning-fixes.patch
  kgdb warning fixes

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3

kgdb-THREAD_SIZE-fixes.patch
  THREAD_SIZE fixes for kgdb

export-filemap_flush.patch
  export filemap_flush() to modules

vma-corruption-fix.patch
  vma corruption fix

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

ppc64-reloc_hide.patch

compat-signal-noarch-2004-01-29.patch
  Generic 32-bit compat for copy_siginfo_to_user

compat-generic-ipc-emulation.patch
  generic 32 bit emulation for System-V IPC

remove-sys_ioperm-stubs.patch
  Clean up sys_ioperm stubs

readdir-cleanups.patch
  readdir() cleanups

ext3-journalled-quotas-2.patch
  ext3: journalled quota

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

cfq-4.patch
  CFQ io scheduler
  CFQ fixes

config_spinline.patch
  uninline spinlocks for profiling accuracy.

pdflush-diag.patch

zap_page_range-debug.patch
  zap_page_range() debug

get_user_pages-handle-VM_IO.patch
  fix get_user_pages() against mappings of /dev/mem

pci_set_power_state-might-sleep.patch

CONFIG_STANDALONE-default-to-n.patch
  Make CONFIG_STANDALONE default to N

extra-buffer-diags.patch

CONFIG_SYSFS.patch
  From: Pat Mochel <mochel@osdl.org>
  Subject: [PATCH] Add CONFIG_SYSFS

CONFIG_SYSFS-boot-from-disk-fix.patch

slab-leak-detector.patch
  slab leak detector
  mm/slab.c warning in cache_alloc_debugcheck_after

scale-nr_requests.patch
  scale nr_requests with TCQ depth

truncate_inode_pages-check.patch

local_bh_enable-warning-fix.patch

sched-find_busiest_node-resolution-fix.patch
  sched: improved resolution in find_busiest_node

sched-domains.patch
  sched: scheduler domain support
  sched: fix for NR_CPUS > BITS_PER_LONG
  sched: clarify find_busiest_group
  sched: find_busiest_group arithmetic fix

sched-domains-improvements.patch
  sched domains kernbench improvements

sched-clock-fixes.patch
  fix sched_clock()

sched-sibling-map-to-cpumask.patch
  sched: cpu_sibling_map to cpu_mask
  p4-clockmod sibling_map fix
  p4-clockmod: handle more than two siblings

sched-domains-i386-ht.patch
  sched: implement domains for i386 HT
  sched: Fix CONFIG_SMT oops on UP
  sched: fix SMT + NUMA bug
  Change arch_init_sched_domains to use cpu_online_map
  Fix build with NR_CPUS > BITS_PER_LONG

sched-domain-tweak.patch
  i386-sched-domain code consolidation

sched-no-drop-balance.patch
  sched: handle inter-CPU jiffies skew

sched-directed-migration.patch
  sched_balance_exec(): don't fiddle with the cpus_allowed mask

sched-domain-debugging.patch
  sched_domain debugging

sched-domain-balancing-improvements.patch
  scheduler domain balancing improvements

sched-group-power.patch
  sched-group-power
  sched-group-power warning fixes

sched-domains-use-cpu_possible_map.patch
  sched_domains: use cpu_possible_map

sched-smt-nice-handling.patch
  sched: SMT niceness handling

sched-smt-nice-optimisation.patch
  sched: SMT-ice optimisation

fa311-mac-address-fix.patch
  wrong mac address with netgear FA311 ethernet card

laptop-mode-2.patch
  laptop-mode for 2.6, version 6
  Documentation/laptop-mode.txt
  laptop-mode documentation updates
  Laptop mode documentation addition
  laptop mode simplification

pid_max-fix.patch
  Bug when setting pid_max > 32k

use-soft-float.patch
  Use -msoft-float

DRM-cvs-update.patch
  DRM cvs update

drm-include-fix.patch

process-migration-speedup.patch
  Reduce TLB flushing during process migration

hotplugcpu-generalise-bogolock.patch
  Atomic Hotplug CPU: Generalize Bogolock

hotplugcpu-generalise-bogolock-fix-for-kthread-stop-using-signals.patch

hotplugcpu-use-bogolock-in-modules.patch
  Atomic Hotplug CPU: Use Bogolock in module.c

hotplugcpu-core.patch
  Atomic Hotplug CPU: Hotplug CPU Core

stop_machine-warning-fix.patch

hotplugcpu-core-sparc64-build-fix.patch
  hotplugcpu-core sparc64 build fix

hotplugcpu-core-fix-for-kthread-stop-using-signals.patch

migrate_to_cpu-dependency-fix.patch
  migrate_to_cpu() dependency fix

hotplugcpu-core-drain_local_pages-fix.patch
  split drain_local_pages

hotplugcpu-rcupdate-many-cpus-fix.patch
  CPU hotplug, rcupdate high NR_CPUS fix

nfs-31-attr.patch
  NFSv2/v3/v4: New attribute revalidation code

nfs-reconnect-fix.patch

nfs-mount-fix.patch
  Update to NFS mount....

nfs-d_drop-lowmem.patch
  NFS: handle nfs_fhget() error

nfs-avoid-i_size_write.patch
  NFS: avoid unlocked i_size_write()

nfs_unlink-oops-fix.patch
  nfs: fix "busy inodes after umount"

nfs-remove-XID-spinlock.patch
  nfs: Remove an unnecessary spinlock from XID generation...

nfs-misc-rpc-fixes.patch
  nfs: Misc RPC fixes...

nfs-improved-writeback-strategy.patch
  nfs: improve writeback caching

nfs-simplify-config-options.patch
  nfs: simplify client configuration options.

nfs-fix-msync.patch
  nfs: fix msync()

nfs-mount-return-useful-errors.patch
  nfs: make mount command return more useful errors

nfs-misc-minor-fixes.patch
  nfs: misc minor fixes

nfs-lockd-sync-01.patch
  nfs: sync lockd to 2.4.x

nfs-lockd-sync-02.patch
  nfs: sync lockd to 2.4.x

nfs-lockd-sync-03.patch
  nfs: sync lockd to 2.4.x

nfs-lockd-sync-04.patch
  nfs: sync lockd to 2.4.x

nfs-rpc-remove-redundant-memset.patch
  nfs: remove unnecessary memset() in RPC

nfs-tunable-rpc-slot-table.patch
  nfs: make the RPC slot table size a tunable value.

nfs-short-read-fix.patch
  nfs: fix an NFSv2 read bug

nfs-server-in-root_server_path.patch
  Pull NFS server address out of root_server_path

non-readable-binaries.patch
  Handle non-readable binfmt_misc executables

binfmt_misc-credentials.patch
  binfmt_misc: improve calaulation of interpreter's credentials

initramfs-search-for-init.patch
  search for /init for initramfs boots

centaur-crypto-core-support.patch
  First steps toward VIA crypto support

adaptive-lazy-readahead.patch
  adaptive lazy readahead

sysfs_remove_dir-race-fix.patch
  sysfs_remove_dir-vs-dcache_readdir race fix

sysfs_remove_subdir-dentry-leak-fix.patch
  Fix dentry refcounting in sysfs_remove_group()

per-node-rss-tracking.patch
  Track per-node RSS for NUMA

aic7xxx-deadlock-fix.patch
  aic7xxx deadlock fix

futex_wait-debug.patch
  futex_wait debug

module_exit-deadlock-fix.patch
  module unload deadlock fix

selinux-inode-race-trap.patch
  Try to diagnose Bug 2153

ext3-dirty-debug-patch.patch
  ext3 debug patch

ufs2-01.patch
  read-only support for UFS2

ide-scsi-error-handling-fixes.patch
  ide-scsi error handling fixes

ide-scsi-error-handling-update.patch
  ide-scsi error handler update

fb_console_init-fix.patch
  fb_console_init fix

poll-select-longer-timeouts.patch
  poll()/select(): support longer timeouts

poll-select-range-check-fix.patch
  poll()/select() range checking fix

poll-select-handle-large-timeouts.patch
  poll()/select(): handle long timeouts

pcmcia-debugging-rework-1.patch
  Overhaul PCMCIA debugging (1)

cs_err-compile-fix.patch
  pcmcia: workaround for gcc-2.95 bug in cs_err()

pcmcia-debugging-rework-2.patch
  Overhaul PCMCIA debugging (2)

distribute-early-allocations-across-nodes.patch
  Manfred's patch to distribute boot allocations across nodes

time-interpolator-fix.patch
  time interpolator fix

kmsg-nonblock.patch
  teach /proc/kmsg about O_NONBLOCK

mixart-build-fix.patch
  CONFIG_SND_MIXART doesn't compile

add-a-slab-for-ethernet.patch
  Add a kmalloc slab for ethernet packets

remove-__io_virt_debug.patch
  remove __io_virt_debug

genrtc-cleanups.patch
  genrtc: cleanups

piix_ide_init-can-be-__init.patch
  piix_ide_init can be __init

fusion-use-min-max.patch
  message/fusion: use kernel min/max

i386-early-memory-cleanup.patch
  i386 very early memory detection cleanup patch

modular-mce-handler.patch
  Allow X86_MCE_NONFATAL to be a module

remove-more-KERNEL_SYSCALLS.patch
  further __KERNEL_SYSCALLS__ removal
  build fix for remove-more-KERNEL_SYSCALLS.patch
  fix the build for remove-more-KERNEL_SYSCALLS

mq-01-codemove.patch
  posix message queues: code move

mq-02-syscalls.patch
  posix message queues: syscall stubs

mq-03-core.patch
  posix message queues: implementation

mq-03-core-update.patch
  posix message queues: update to core patch

mq-04-linuxext-poll.patch
  posix message queues: linux-specific poll extension

mq-05-linuxext-mount.patch
  posix message queues: made user mountable

mq-update-01.patch
  posix message queue update

mq-security-fix.patch
  security bugfix for mqueue

dm-01-endio-method.patch
  dm: endio method

dm-03-list_for_each_entry-audit.patch
  dm: list_for_each_entry audit

dm-04-default-queue-limits-fix.patch
  dm: default queue limits

dm-05-list-targets-command.patch
  dm: list targets cmd

dm-06-stripe-width-fix.patch
  dm: stripe width fix

queue-congestion-callout.patch
  Add queue congestion callout

queue-congestion-dm-implementation.patch
  Implement queue congestion callout for device mapper

dm-maplock.patch
  devicemapper: use rwlock for map alterations

use-wait_task_inactive-in-kthread_bind.patch
  use wait_task_inactive() in kthread_bind()

HPFS1-hpfs2-RC4-rc1.patch

HPFS2-hpfs_namei-RC4-rc1.patch

selinux-cleanup-binary-mount-data.patch
  selinux: clean up binary mount data

udffs-update.patch
  UDF filesystem update

kbuild-redundant-CFLAGS.patch
  kbuild: Remove CFLAGS assignment in i386/mach-*/Makefile

numa-aware-zonelist-builder.patch
  NUMA-aware zonelist builder
  numa-aware zonelist builder fix
  numa-aware node builder fix #2

remove-redundant-unplug_timer-deletion.patch
  Redundant unplug_timer deletion

queue_work_on_cpu.patch
  Add queue_work_on_cpu() workqueue function

m68k-rename-sys_functions.patch
  m68k: rename sys_* functions

pdc202xx_new-update.patch
  ide: update for pdc202xx_new driver

siimage-update.patch
  ide: update for siimage driver

ide-cleanups-01.patch
  ide: IDE cleanups

ide-cleanups-02.patch
  ide: IDE cleanups

ide-cleanups-03.patch
  ide: IDE cleanups

cdromaudio-use-dma.patch
  use DMA for CDROM audio reading

sysfs-pin-kobject.patch
  sysfs: pin kobjects to fix use-after-free crashes

ATI-IXP-IDE-support.patch
  ATI IXP IDE support

ipmi-updates-3.patch
  IPMI driver updates

ipmi-socket-interface.patch
  IPMI: socket interface

md-use-schedule_timeout.patch
  md: use "shedule_timeout(2)" instead of yield()

md-array-assembly-fix.patch
  md: allow assembling of partitioned arrays at boot time.

compiler_h-scope-fixes.patch
  compiler.h scoping fixes

remap-file-pages-prot-2.6.4-rc1-mm1-A1.patch
  per-page protections for remap_file_pages()

nmi_watchdog-local-apic-fix.patch
  Fix nmi_watchdog=2 and P4 HT

nmi-1-hz.patch
  set nmi_hz to 1 with nmi_watchdog=2 and SMP

elf-mmap-fix.patch
  Fix elf mapping of the zero page

kbuild-more-cleaning.patch
  kbuild: Cause `make clean' to remove more files

LOOP_CHANGE_FD.patch
  LOOP_CHANGE_FD ioctl

loop-setup-race-fix.patch
  loop setup race fix

handle-dot-o-paths.patch
  kbuild: fix usage with directories containing '.o'

acpi-asmlinkage-fix.patch
  gcc-3.5: acpi build fix

ipc-sem-extra-sem_unlock.patch
  Remove unneeded unlock in ipc/sem.c

procfs-dangling-subdir-fix.patch
  /proc data corruption check

AMD-768MPX-bootmem-fix.patch
  Work around an AMD768MPX erratum

i810fb-on-x86_64.patch
  Enable i810 fb on x86-64

ext23-remove-acl-limits.patch
  Remove arbitrary #acl entries limits on ext[23] when reading

watchdog-moduleparam-patches.patch
  watchdog: moduleparam-patches

amd-elan-fix.patch
  AMD ELAN Kconfig fix

pcmcia-netdev-ordering-fixes.patch
  PCMCIA netdevice ordering issues

instrument-highmem-page-reclaim.patch
  vm: per-zone vmscan instrumentation

blk_congestion_wait-return-remaining.patch
  return remaining jiffies from blk_congestion_wait()

vmscan-remove-priority.patch
  mm/vmscan.c: remove unused priority argument.

kswapd-throttling-fixes.patch
  kswapd throttling fixes

vm-refill_inactive-preserve-referenced.patch
  vmscan: preserve page referenced info in refill_inactive()

shrink_slab-precision-fix.patch
  shrink_slab: math precision fix

try_to_free_pages-shrink_slab-evenness.patch
  vm: shrink slab evenly in try_to_free_pages()

vmscan-total_scanned-fix.patch
  vmscan: fix calculation of number of pages scanned

shrink_slab-for-all-zones-2.patch
  vm: scan slab in response to highmem scanning

zone-balancing-fix-2.patch
  vmscan: zone balancing fix

vmscan-control-by-nr_to_scan-only.patch
  vmscan: drive everything via nr_to_scan

vmscan-balance-zone-scanning-rates.patch
  Balance inter-zone scan rates

vmscan-dont-throttle-if-zero-max_scan.patch
  vmscan: avoid bogus throttling

kswapd-avoid-higher-zones.patch
  kswapd: avoid unnecessary reclaiming from higher zones

kswapd-avoid-higher-zones-reverse-direction.patch
  kswapd: fix lumpy page reclaim

kswapd-avoid-higher-zones-reverse-direction-fix.patch
  fix the kswapd zone scanning algorithm

vmscan-throttle-later.patch
  vmscan: less throttling of page allocators and kswapd

vm-batch-inactive-scanning.patch
  vmscan: batch up inactive list scanning work

vm-batch-inactive-scanning-fix.patch
  fix vm-batch-inactive-scanning.patch

vm-balance-refill-rate.patch
  vm: balance inactive zone refill rates

slab-no-higher-order.patch
  slab: avoid higher-order allocations

list_del-debug.patch
  list_del debug check

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch
  lockmeter

lockmeter-ia64-fix.patch
  ia64 CONFIG_LOCKMETER fix

4g-2.6.0-test2-mm2-A5.patch
  4G/4G split patch
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g/4g usercopy atomicity fix
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g/4g usercopy atomicity fix
  4G/4G preempt on vstack
  4G/4G: even number of kmap types
  4g4g: fix __get_user in slab
  4g4g: Remove extra .data.idt section definition
  4g/4g linker error (overlapping sections)
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g4g: show_registers() fix
  4g/4g usercopy atomicity fix
  4g4g: debug flags fix
  4g4g: Fix wrong asm-offsets entry
  cyclone time fixmap fix
  4G/4G preempt on vstack
  4G/4G: even number of kmap types
  4g4g: fix __get_user in slab
  4g4g: Remove extra .data.idt section definition
  4g/4g linker error (overlapping sections)
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g4g: show_registers() fix
  4g/4g usercopy atomicity fix
  4g4g: debug flags fix
  4g4g: Fix wrong asm-offsets entry
  cyclone time fixmap fix
  use direct_copy_{to,from}_user for kernel access in mm/usercopy.c
  4G/4G might_sleep warning fix
  4g/4g pagetable accounting fix
  Fix 4G/4G and WP test lockup
  4G/4G KERNEL_DS usercopy again
  Fix 4G/4G X11/vm86 oops
  Fix 4G/4G athlon triplefault
  4g4g SEP fix
  Fix 4G/4G split fix for pre-pentiumII machines
  4g/4g PAE ACPI low mappings fix
  zap_low_mappings() cannot be __init
  4g/4g: remove printk at boot

4g4g-THREAD_SIZE-fixes.patch

4g4g-locked-userspace-copy.patch
  Do a locked user-space copy for 4g/4g

ia32-4k-stacks.patch
  ia32: 4Kb stacks (and irqstacks) patch

ia32-4k-stacks-build-fix.patch
  4k stacks build fix

4k-stacks-in-modversions-magic.patch
  Add 4k stacks to module version magic

4g4g-handle_BUG-fix.patch
  4g4g: fix handle_BUG()

ppc-fixes.patch
  make mm4 compile on ppc

ppc-fixes-dependency-fix.patch
  ppc-fixes dependency fix

O_DIRECT-race-fixes-rollup.patch
  O_DIRECT data exposure fixes

O_DIRECT-ll_rw_block-vs-block_write_full_page-fix.patch
  Fix race between ll_rw_block() and block_write_full_page()

blockdev-direct-io-speedup.patch
  blockdev direct-io speedups

O_DIRECT-vs-buffered-fix.patch
  Fix O_DIRECT-vs-buffered data exposure bug

O_DIRECT-vs-buffered-fix-pdflush-hang-fix.patch
  pdflush hang fix

serialise-writeback-fdatawait.patch
  serialize_writeback_fdatawait patch

restore-writeback-trylock.patch
  writeback trylock patch

dio-aio-fixes.patch
  direct-io AIO fixes

aio-fallback-bio_count-race-fix-2.patch
  AIO+DIO bio_count race fix

aio-direct-io-oops-fix.patch
  AIO/direct-io oops fix



