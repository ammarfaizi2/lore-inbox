Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbUDSGDG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 02:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbUDSGDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 02:03:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:65203 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263178AbUDSGBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 02:01:49 -0400
Date: Sun, 18 Apr 2004 23:01:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.6-rc1-mm1
Message-Id: <20040418230131.285aa8ae.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6-rc1/2.6.6-rc1-mm1/


- All of the anonmm rmap work is now merged up.  No pte chains.

- Various cleanups and fixups, as usual.

- The list of external bk trees is getting a little short, due to problems
  at bkbits.net.  The ones which are here are not necessarily very up-to-date
  with the various development trees.




Changes since 2.6.5-mm6:


 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-drm.patch
 bk-input.patch
 bk-netdev.patch

 External trees

-fix-mq_notify-with-sigev_none-notification.patch
-radix-tree-comment-fix.patch
-mq_open-and-close_on_exec.patch
-rmap-4-flush_dcache-revisited.patch
-rmap-5-swap_unplug-page.patch
-rmap-6-nonlinear-truncation.patch
-ext3-journalled-quotas.patch
-slab-panic.patch
-dm-fix-64-32-bit-ioctl-problems.patch
-dm-check-the-uptodate-flag-in-sub-bios.patch
-dm-handle-interrupts-within-suspend.patch
-dm-use-wake_up-rather-than-wake_up_interruptible.patch
-dm-log-an-error-if-the-target-has-unknown-target-type.patch
-dm-correctly-align-the-dm_target_spec-structures.patch
-dm-clarify-a-comment.patch
-dm-retrieve_status-prevent-overrunning-the-ioctl-buffer.patch
-dm-use-an-emit-macro.patch
-kNFSdv4-4-of-10-nfsd4_readdir-fixes.patch
-kNFSdv4-5-of-10-Fix-bad-error-returm-from-svcauth_gss_accept.patch
-kNFSdv4-6-of-10-Keep-state-to-allow-replays-for-close-to-work.patch
-kNFSdv4-7-of-10-Allow-locku-replays-aswell.patch
-kNFSdv4-8-of-10-Improve-how-locking-copes-with-replays.patch
-kNFSdv4-9-of-10-Set-credentials-properly-when-puutrootfh-is-used.patch
-kNFSdv4-10-of-10-Implement-server-side-reboot-recovery-mostly.patch
-kill-submit_bhbio-return-value.patch
-pci-msi-kconfig-consolidation.patch
-remove-buffer_error.patch
-add-mqueue-support-to-x86-64.patch
-light-weight-auditing-framework-for-s390.patch
-posix-messages-queues-for-s390.patch
-ppc64-fix-possible-duplicate-mmu-hash-entries.patch
-fix-mq-32-bit-compatibility.patch
-reiserfs-commit-default.patch
-jbd-journal_dirty_metadata-locking-speedup.patch
-sctp-printk-warnings.patch
-atm-warning-fixes.patch
-sir_dev-warnings.patch
-donauboe-ptr-fix.patch
-strip-warnings.patch
-strip-warnings-2.patch
-print-warning-for-common-symbols-in-modules.patch
-set_anon_super-locking-fix.patch

 Merged

-kstrdup-and-friends.patch
-call_usermodehelper_async.patch
-call_usermodehelper_async-always.patch

 Dropped, replaced with...

+create_singlethread_workqueue.patch

 Extend workqueues so they don't unconditionally create one thread per cpu. 
 (They still display as "khelper/0" in ps though..)

+use-workqueue-for-call_usermodehelper.patch

 Use single-threaded workqueues for call_usermodehelper()
 
+ppc64-rtas-build-fix.patch

 ppc64 compile fix

+rmap-7-object-based-rmap.patch
+ia64-rmap-build-fix.patch
+rmap-8-unmap-nonlinear.patch
+slab-panic.patch
+rmap-9-remove-pte_chains.patch
+rmap-10-add-anonmm-rmap.patch
+rmap-11-mremap-moves.patch
+rmap-12-pgtable-remove-rmap.patch
+rmap-13-include-asm-deletions.patch

 The rest of anonmm-based rmap

-sched-config_sched_numa.patch

 Dropped, wasn't popular.

+sched-fixes.patch

 Scheduler tweaks

+nfs-direct-warning-fix.patch

 Fix warning in nfs-O_DIRECT-fixes.patch

+numa-api-fixes.patch

 Fixes to the NUMA API code

+numa-api-statistics-2.patch

 Re-add statistical infrastructure to NUMA API.

 These are currently undocumented.  Hint.

+add-omitted-autofs4-super-block-field.patch

 Fixup for the autofs4 patches

+autofs4-fix-handling-of-chdir-and-chroot.patch

 Rework the autofs4 late mounting readdir support.  Removes the racy handling
 in fs/open.c

+as-increase-batch-expiry.patch

 Anticipatory scheduler tuning.

+direct-IO-retval-fix.patch
+direct-io-retval-fix-2.patch

 Fix up the direct-IO code paths to correctly perform >2G I/O's on 64-bit
 architectures.

+populate-rootfs-later.patch

 Call populate_rootfs() much later in boot, when the scheduler is actually
 ready for us to call schedule() without going splat.

+remove-amd7saucy_tco.patch

 Remove defunct driver

+fix-default-value-for-commit-interval-for-older-reiserfs-filesystems.patch

 Laptop-miode reiserfs fix

+consolidate-sys32_readv-and-sys32_writev.patch
+consolidate-do_execve32.patch
+consolidate-sys32_select.patch
+consolidate-sys32_nfsservctl.patch

 Consolidate the code which performs emulation of readv & writev on 64-bit
 architectures.

+kill-off-hugepage_vma.patch

 Remove hugepage_vma()

+ehci-oops-fix.patch

 Fix some USB oops

+h8300-stack-bounds-checking.patch
+m68k-stack-bounds-checking.patch
+m68knommu-stack-bounds-checking.patch
+ppc32-stack-bounds-checking.patch
+sparc32-stack-bounds-checking.patch

 Correctly calculate the top of stack in the backtracing code.

+3c509-oops-fix.patch

 Fix an oops in 3c509.c

+lockfs-vfs-bits.patch
+lockfs-xfs-bits.patch
+lockfs-dm-bits.patch
+lockfs-dm-bits-2.patch

 Move support for LVM snapshotting out of XFS and into core kernel.

+nfs-tokens-initdata.patch

 Save a scrap of RAM.

+warn-if-module_param-and-module_parm-mixed.patch

 Warn if a module uses both module_param() and the old MODULE_PARM()

+ide-cleanups-1.patch
+ide-cleanups-2.patch
+ide-cleanups-3.patch

 IDE cleanups

+intel8x0-resume-fix.patch

 Fix the intel8x0 driver for suspend/resume

+clean-up-asm-pgalloch-include.patch
+clean-up-asm-pgalloch-include-2.patch
+clean-up-asm-pgalloch-include-3.patch

 Attempt to bring some sanity to the memory management include file
 ordering.

+ppc64-uninline-__pte_free_tlb.patch

 Fix the ppc64 build for the above.

+lec-warning-fix.patch

 Fix a warning in an ATM driver






All 212 patches:


linus.patch

create_singlethread_workqueue.patch
  reate_singlethread_workqueue()

use-workqueue-for-call_usermodehelper.patch
  Use workqueue for call_usermodehelper

ppc64-rtas-build-fix.patch
  ppc64: rtas build fix

mc.patch
  Add -mcN to EXTRAVERSION

bk-acpi.patch

bk-agpgart.patch

bk-alsa.patch

bk-cifs.patch

bk-cpufreq.patch

bk-drm.patch

bk-input.patch

bk-netdev.patch

mm.patch
  add -mmN to EXTRAVERSION

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

kgdboe-configuration-logic-fix.patch
  kgdboe: fix configuration of MAC address

kgdboe-configuration-logic-fix-fix.patch

kgdboe-non-ia32-build-fix.patch

kgdb-warning-fixes.patch
  kgdb warning fixes

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3

kgdb-x86_64-warning-fixes.patch
  kgdb-x86_64-warning-fixes

wchan-use-ELF-sections-kgdb-fix.patch
  wchan-use-ELF-sections-kgdb-fix

kgdb-THREAD_SIZE-fixes.patch
  THREAD_SIZE fixes for kgdb

rmap-7-object-based-rmap.patch
  rmap 7 object-based rmap

ia64-rmap-build-fix.patch
  ia64 rmap build fix

rmap-8-unmap-nonlinear.patch
  rmap 8 unmap nonlinear

slab-panic.patch
  slab: consolidate panic code

rmap-9-remove-pte_chains.patch
  rmap 9 remove pte_chains

rmap-10-add-anonmm-rmap.patch
  rmap 10 add anonmm rmap

rmap-11-mremap-moves.patch
  rmap 11 mremap moves

rmap-12-pgtable-remove-rmap.patch
  rmap 12 pgtable remove rmap

rmap-13-include-asm-deletions.patch
  rmap 13 include/asm deletions

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

ppc64-reloc_hide.patch

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

config_spinline.patch
  uninline spinlocks for profiling accuracy.

pdflush-diag.patch

get_user_pages-handle-VM_IO.patch
  fix get_user_pages() against mappings of /dev/mem

pci_set_power_state-might-sleep.patch

CONFIG_STANDALONE-default-to-n.patch
  Make CONFIG_STANDALONE default to N

selinux-inode-race-trap.patch
  Try to diagnose Bug 2153

slab-leak-detector.patch
  slab leak detector
  mm/slab.c warning in cache_alloc_debugcheck_after

local_bh_enable-warning-fix.patch

Move-saved_command_line-to-init-mainc.patch
  Move saved_command_line to init/main.c

sched-run_list-cleanup.patch
  small scheduler cleanup

sched-find_busiest_node-resolution-fix.patch
  sched: improved resolution in find_busiest_node

sched-domains.patch
  sched: scheduler domain support
  sched: fix for NR_CPUS > BITS_PER_LONG
  sched: clarify find_busiest_group
  sched: find_busiest_group arithmetic fix

sched-find-busiest-fix.patch
  sched-find-busiest-fix

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

sched-local-load.patch
  sched: add local load metrics

process-migration-speedup.patch
  Reduce TLB flushing during process migration

sched-trivial.patch
  sched: trivial fixes, cleanups

sched-misc-fixes.patch
  sched: misc fixes

sched-wakebalance-fixes.patch
  sched: wakeup balancing fixes

sched-imbalance-fix.patch
  sched: fix imbalance calculations

sched-altix-tune1.patch
  sched: altix tuning

sched-fix-activelb.patch
  sched: oops fix

ppc64-sched-domain-support.patch
  ppc64: sched-domain support

sched-domain-setup-lock.patch
  sched: fix setup races

ppc64-sched_domains-fix.patch
  ppc64-sched_domains-fix

sched-domain-setup-lock-ppc64-fix.patch

sched-minor-cleanups.patch
  sched: minor cleanups

sched-inline-removals.patch
  sched: uninlinings

sched-move-cold-task.patch
  sched: move cold task in mysteriouis ways

sched-migrate-shortcut.patch
  sched: add migration shortcut

sched-more-sync-wakeups.patch
  sched: extend sync wakeups

sched-boot-fix.patch
  sched: lock cpu_attach_domain for hotplug

sched-cleanups.patch
  sched: cleanups

sched-damp-passive-balance.patch
  sched: passive balancing damping

sched-cpu-load-cleanup.patch
  sched: cpu load management cleanup

sched-balance-context.patch
  sched: balance-on-clone

sched-less-idle.patch
  sched: reduce idle time

sched-wake_up-speedup.patch
  sched: micro-optimisation for wake_up

sched-fixes.patch
  sched: clean up leftovers

schedstats.patch
  sched: scheduler statistics

fa311-mac-address-fix.patch
  wrong mac address with netgear FA311 ethernet card

pid_max-fix.patch
  Bug when setting pid_max > 32k

use-soft-float.patch
  Use -msoft-float

non-readable-binaries.patch
  Handle non-readable binfmt_misc executables

binfmt_misc-credentials.patch
  binfmt_misc: improve calaulation of interpreter's credentials

aic7xxx-deadlock-fix.patch
  aic7xxx deadlock fix

poll-select-longer-timeouts.patch
  poll()/select(): support longer timeouts

poll-select-range-check-fix.patch
  poll()/select() range checking fix

poll-select-handle-large-timeouts.patch
  poll()/select(): handle long timeouts

add-a-slab-for-ethernet.patch
  Add a kmalloc slab for ethernet packets

siimage-update.patch
  ide: update for siimage driver

nmi_watchdog-local-apic-fix.patch
  Fix nmi_watchdog=2 and P4 HT

nmi-1-hz-2.patch
  reduce NMI watchdog call frequency with local APIC.

pcmcia-netdev-ordering-fixes.patch
  PCMCIA netdevice ordering issues

3ware-update.patch
  3ware driver update

idr-extra-features.patch
  idr.c: extra features enhancements

shm-do_munmap-check.patch

stack-overflow-test-fix.patch
  Fix stack overflow test for non-8k stacks

jbd-remove-livelock-avoidance.patch
  JBD: remove livelock avoidance code in journal_dirty_data()

jgarzik-warnings.patch

logitech-keyboard-fix.patch
  2.6.5-rc2 keyboard breakage

signal-race-fix.patch
  signal handling race fix

signal-race-fix-ia64.patch
  signal-race-fix: ia64

signal-race-fix-s390.patch
  signal-race fixes for s390

signal-race-fix-x86_64.patch
  signal-race-fixes: x86-64 support

signal-race-fixes-ppc.patch
  signal-race fixes for ppc32 and ppc64

warn-on-mdelay-in-irq-handlers.patch
  Warn on mdelay() in irq handlers

stack-reductions-nfsread.patch
  stack reductions: nfs read

speed-up-sata.patch
  speed up SATA

advansys-fix.patch
  advansys check_region() fix

aic7xxx-unload-fix.patch
  aic7xxx: fix oops whe hardware is not present

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

nfs-O_DIRECT-fixes.patch
  NFS: O_DIRECT fixes

nfs-direct-warning-fix.patch
  nfs/direct.c warning fix

aic7xxx-swsusp-support.patch
  support swsusp for aic7xxx

xfs-laptop-mode.patch
  Laptop mode support for XFS

xfs-laptop-mode-syncd-synchronization.patch
  Synchronize XFS sync daemon with laptop mode syncs.

list_del-debug.patch
  list_del debug check

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch
  lockmeter
  ia64 CONFIG_LOCKMETER fix

cciss-logical-device-queues.patch
  cciss: per logical device queues

numa-api-x86_64.patch
  numa api: -64 support

numa-api-bitmap-fix.patch
  numa api: Bitmap bugfix

numa-api-i386.patch
  numa api: Add i386 support

numa-api-ia64.patch
  numa api: Add IA64 support

numa-api-core.patch
  numa api: Core NUMA API code

mpol-in-copy_vma.patch
  mpol in copy_vma

numa-api-core-slab-panic.patch
  numa-api-core-slab-panic

numa-api-core-tweaks.patch
  numa-api-core-tweaks

numa-api-fixes.patch
  Some fixes for NUMA API

numa-api-statistics-2.patch
  Re-add NUMA API statistics

numa-api-core-bitmap_clear-fixes.patch
  numa-api-core bitmap_clear fixes

numa-api-vma-policy-hooks.patch
  numa api: Add VMA hooks for policy

numa-api-vma-policy-hooks-fix.patch
  numa-api-vma-policy-hooks fix

numa-api-shared-memory-support.patch
  numa api: Add shared memory support

numa-api-shared-memory-support-tweaks.patch
  numa-api-shared-memory-support-tweaks

numa-api-statistics.patch
  numa api: Add statistics

numa-api-anon-memory-policy.patch
  numa api: Add policy support to anonymous  memory

sk98lin-buggy-vpd-workaround.patch
  net/sk98lin: correct buggy VPD in ASUS MB
  skvpd-build-fix

unplug-can-sleep.patch
  unplug functions can sleep

fix-load_elf_binary-error-path-on-unshare_files-error.patch
  fix load_elf_binary error path on unshare_files error

firestream-warnings.patch
  firestream warnings

cpufreq_userspace-warning.patch
  cpufreq_userspace warning

compute-creds-race-fix.patch
  compute_creds race

compute-creds-race-fix-fix.patch
  compute-creds-race-fix-fix

compute-creds-race-fix-fix-fix.patch
  fix must_not_trace_exec() even more

rndis-fix.patch
  usb/gadget/rndis.c fix

pc300_drv-warnings.patch
  pc300_drv-warnings

fix-acer-travelmate-360-interrupt-routing.patch
  fix Acer TravelMate 360 interrupt routing

ext3_rsv_cleanup.patch
  ext3 block reservation patch set -- ext3 preallocation cleanup

ext3_rsv_base.patch
  ext3 block reservation patch set -- ext3 block reservation

ext3_rsv_mount.patch
  ext3 block reservation patch set -- mount and ioctl feature

ext3_rsv_dw.patch
  ext3 block reservation patch set -- dynamically increase reservation window

ext3-reservation-default-on.patch
  ext3 reservation: default to on

sched-in_sched_functions.patch
  sched: in_sched_functions() cleanup

sysfs-d_fsdata-race-fix-2.patch
  kobject/sysfs race fix

0-autofs4-2.6.0-signal-20040405.patch
  autofs: dnotify + autofs may create signal/restart syscall loop

add-omitted-autofs4-super-block-field.patch
  add omitted autofs4 super block field

1-autofs4-2.6.4-cleanup-20040405.patch
  autofs: printk cleanups

2-autofs4-2.6.4-fill_super-20040405.patch

3-autofs4-2.6.0-bkl-20040405.patch
  autofs: locking rework

4-autofs4-2.6.0-expire-20040405.patch
  autofs: expiry refcount fixes

5-autofs4-2.6.0-readdir-20040405.patch
  autofs: readdir fixes

umount-after-bad-chdir.patch
  fix umount after bad chdir

autofs4-fix-handling-of-chdir-and-chroot.patch
  autofs4: fix handling of chdir and chroot

6-autofs4-2.6.0-may_umount-20040405.patch
  autofs: add ioctl to query unmountability

7-autofs4-2.6.0-extra-20040405.patch
  autofs: readdir futureproofing

lindent-rwsem.patch
  cleanup lib/rwsem.c lib/rwsem-spinlock.c

de-racify-rwsem-take-2.patch
  de-racify rwsem take 2

scale-rwsem-take-2.patch
  scale rwsem take 2

increase-number-of-dynamic-inodes-in-procfs-265.patch
  Increase number of dynamic inodes in procfs

increase-number-of-dynamic-inodes-in-procfs-265-idr-init.patch
  increase-number-of-dynamic-inodes-in-procfs-265-idr-init

ext3-data-leak-fix.patch
  ext3 avoid writing kernel memory to disk

as-increase-batch-expiry.patch
  AS: increase batch expiry intervals

direct-IO-retval-fix.patch
  direct-IO-retval-fix

direct-io-retval-fix-2.patch
  more direct-io retval fixes

populate-rootfs-later.patch
  Call populate_rootfs later in boot

remove-amd7saucy_tco.patch
  remove amd7xx_tco

fix-default-value-for-commit-interval-for-older-reiserfs-filesystems.patch
  Fix default value for commit interval for older reiserfs filesystems.

consolidate-sys32_readv-and-sys32_writev.patch
  Consolidate sys32_readv and sys32_writev

consolidate-do_execve32.patch
  Consolidate do_execve32

consolidate-sys32_select.patch
  Consolidate sys32_select

consolidate-sys32_nfsservctl.patch
  Consolidate sys32_nfsservctl

kill-off-hugepage_vma.patch
  From: David Gibson <david@gibson.dropbear.id.au>
  Subject: Kill off hugepage_vma()

ehci-oops-fix.patch
  oops when loading ehci_hcd

h8300-stack-bounds-checking.patch
  h8300 stack bounds checking

m68k-stack-bounds-checking.patch
  m68k stack bounds checking

m68knommu-stack-bounds-checking.patch
  m68knommu stack bounds checking

ppc32-stack-bounds-checking.patch
  ppc32 stack bounds checking

sparc32-stack-bounds-checking.patch
  sparc32 stack bounds checking

3c509-oops-fix.patch
  3c509 oops fix

lockfs-vfs-bits.patch
  lockfs - vfs bits

lockfs-xfs-bits.patch
  lockfs - xfs bits

lockfs-dm-bits.patch
  lockfs - dm bits

lockfs-dm-bits-2.patch
  lockfs - dm bits

nfs-tokens-initdata.patch
  nfs token table can be  __initdata

warn-if-module_param-and-module_parm-mixed.patch
  Warn if module_param and MODULE_PARM mixed

ide-cleanups-1.patch
  IDE cleanups/fixups for 2.6.6-rc1 [1/3]

ide-cleanups-2.patch
  IDE cleanups/fixups for 2.6.6-rc1 [2/3]

ide-cleanups-3.patch
  IDE cleanups/fixups for 2.6.6-rc1 [3/3]

intel8x0-resume-fix.patch
  intel8x0 suspend/resume fix

clean-up-asm-pgalloch-include.patch
  Clean up asm/pgalloc.h include

clean-up-asm-pgalloch-include-2.patch
  Clean up asm/pgalloc.h include

clean-up-asm-pgalloch-include-3.patch
  Clean up asm/pgalloc.h include 3

ppc64-uninline-__pte_free_tlb.patch
  ppc64: uninline __pte_free_tlb()

lec-warning-fix.patch
  ATM warning fix



