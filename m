Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264584AbUEJJqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264584AbUEJJqo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 05:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264577AbUEJJqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 05:46:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:9963 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264584AbUEJJpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 05:45:30 -0400
Date: Mon, 10 May 2004 02:45:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.6-mm1
Message-Id: <20040510024506.1a9023b6.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm1/


- x86_64 sched-domains support

- Added the sysfs-backing-store patches

- A number of patches to shrink/consolidate dentry fields.  Needs careful
  testing.   The relevant diffs are:

	d_flags-locking-fix.patch
	d_vfs_flags-locking-fix.patch
	dentry-shrinkage.patch
	dentry-qstr-consolidation.patch
	dentry-qstr-consolidation-fix.patch
	dentry-d_bucket-fix.patch
	dentry-d_flags-consolidation.patch
	dentry-layout-tweaks.patch

- The ia64 CPU hotplug stuff is all here now and doesn't appear to break
  anything.

- Lots of fixes/cleanups/etc.




Changes since 2.6.6-rc3-mm2:


 bk-agpgart.patch
 bk-alsa.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-driver-core.patch
 bk-drm.patch
 bk-i2c.patch
 bk-libata.patch
 bk-netdev.patch
 bk-pci.patch
 bk-scsi.patch
 bk-usb.patch

 External trees (dropped bk-input because it has nasty merge errors against
 Linus's tree)

-page_mapping-race-fix.patch
-ppc-ppc64-cleanup-ppc970-cpu-initialization.patch
-benh-credits-update.patch
-ppc32-add-missing-dma_mapping_error.patch
-fix-warn_on-on-xfs-module-unload.patch
-nforce-disconnect-fix.patch
-delete-posix-conformance-testing-by-unifix-message.patch
-netpoll-attributions.patch

 Merged

-frame-pointer-based-stack-dumps-tweaks.patch

 Folded into frame-pointer-based-stack-dumps.patch

+bk-driver-core-module-fix.patch

 Fix compilation of bk-driver-core.patch

+small-numa-api-fixups-fix.patch

 Fix small-numa-api-fixups.patch

+rmap-24-no-rmap-fastcalls.patch
+rmap-27-memset-0-vma.patch
+rmap-28-remove_vm_struct.patch
+rmap-29-vm_reserved-safety.patch
+rmap-30-fix-bad-mapcount.patch
+rmap-31-unlikely-bad-memory.patch
+rmap-32-zap_pmd_range-wrap.patch

 MM work.

-fix-deadlock-in-journalled-quota-fix.patch

 Folded into fix-deadlock-in-journalled-quota.patch

+ppc64-extra-barrier-in-i-o-operations.patch

 PPC64 fix

+Move-saved_command_line-to-init-mainc-warnings.patch

 Fix warnings due to Move-saved_command_line-to-init-mainc.patch

 (serial console work OK for me on x86_64)

-sched-move-cold-task.patch
-sched-migrate-shortcut.patch

 Nick wanted these dropped

+sched-enqueue_task_head.patch

 But not this part.

-sched-move-migrate_all_tasks-to-cpu_dead-handling-up-fix.patch
-sched-move-migrate_all_tasks-to-cpu_dead-handling-unlikely-cleanup.patch

 Folded into sched-move-migrate_all_tasks-to-cpu_dead-handling.patch

+x86_64-convert-sibling-map-to-masks.patch
+sched-x86_64-sched-domains-support.patch

 x86_64 sched-domains support

-binfmt_misc-credentials-fixes.patch
-binfmt_misc-credentials-fixes-2.patch

 Folded into binfmt_misc-credentials.patch

+ext3_reservation_discard_race_fix.patch

 Fix a race in the ext3 reservation code

-neomagic-driver-update-fix.patch

 Folded into neomagic-driver-update.patch

+remove-bootsect_helper-on-x86_64-and-pc98.patch

 Removed unneeded code

-new-version-of-early-cpu-detect-fix.patch

 Folded into new-version-of-early-cpu-detect.patch

-writepage-retval-warning.patch

 Dropped - it was temp debug stuff.

+q40-fbdev-updates.patch

 Update this fbdev driver

-allow-architectures-to-reenable-interrupts-on-contended-spinlocks-fix.patch

 Folded into  allow-architectures-to-reenable-interrupts-on-contended-spinlocks.patch

+un-inline-spinlocks-on-ppc64.patch

 Make the ppc64 spinlock slowpath not inline.

+ia64-cpu-hotplug-cpu_present-2.patch
+ia64-cpu-hotplug-cpu_present-2-fix.patch
+ia64-cpuhotplug-hotcpu.patch

 Finish off the ia64 CPU hotplug work

-proc-sys-kernel-vermagic.patch

 This broke, and it's not clear that we need it.

-cyclades-cleanups-cleanups.patch

 Folded into cyclades-cleanups.patch

-static-define_per_cpu-vs-modules-2.patch

 Dropped - this issue will be fixed in s390 code

-filtered-wakeups-core.patch
-filtered-buffer_head-wakeups.patch
-filtered-buffer_head-wakeups-tweaks.patch
-wake-one-pg_locked-bh_lock-semantics.patch
-wake-one-pg_locked-bh_lock-semantics-tweaks.patch
+wakefunc.patch
+wakeup.patch
+filtered_page.patch
+filtered_buffer.patch

 The filtered-wakeup code was redone.

+swsusp-documentation-updates.patch

 Documentation

+fix-sysfs-symlinks.patch
+sysfs-leaves-mount.patch
+sysfs-leaves-dir.patch
+sysfs-leaves-file.patch
+sysfs-leaves-symlink.patch
+sysfs-leaves-bin.patch
+sysfs-leaves-misc.patch

 sysfs backing store

+cache-queue_congestion_on-off_threshold.patch

 Code simplification

+report-size-of-printk-buffer-selinux-interface.patch

 Security hook for the recent syslog ehhancement.

+fix-race-on-tty-close.patch

 Fix a workqueue flushing race

+die_386_graphic.patch

 Make oops messages more entertaining

+force-ide-cache-flush-on-shutdown-flush.patch
+force-ide-cache-flush-on-shutdown-flush-fix.patch

 IDE cache flushing fixes

+as-iosched-cleanups.patch

 Anticipatory scheduler cleanups/simplifiactions/fixes

+fix-net-tulip-winbond-840c-warning.patch

 Fix a warning

+pcmcia-tcicc-warning-fix.patch

 And another

+lindent-on-arch-i386-kernel-cpuidc.patch

 Lindent cpuid.c

+fix-media-dsbr100c-unused-variable.patch
+fix-warning-in-intermezzo-journalc.patch
+fix-wrong-var-used-in-hotplug-shpchp_ctrlc.patch

 Fix warnings

+hugepage-add_to_page_cache-fix.patch

 Fix hugetlb error-path handling

+hugetlb_shm_group-sysctl-patch.patch

 Add /proc/sys/vm/hugetlb_shm_group: this holds the group ID of users who may
 allocate hugetlb shm segments without CAP_IPC_LOCK.  For Oracle.

+mlock_group-sysctl.patch

 /proc/sys/vm/mlock_group: group ID of users who can do mlock() without
 CAP_IPC_LOCK.  Not sure that we need this.

+nfs_writepage_sync-stack-reduction.patch

 Stack space reduction in NFS

+cpqarray-update-for-26.patch

 Update this driver

+i8042-shutdown-fix.patch

 Fix a shutdown race in this input driver

+kill-useless-mod_incdec_use_count-in-sound-oss-msndc.patch
+kill-mod_incdec_use_count-gunk-in-arch-cris-arch-v10-drivers-pcf8563c.patch
+fix-mod_incdec_use_count-gunk-in-arch-um-drivers-net_kernc.patch
+drivers-video-mod_inc_use_count-fixes.patch
+fix-mod_inc_use_count-usage-in-mtd.patch
+remove-mod_inc_use_count-usage-in-arch-um-drivers-harddog_kernc.patch

 Module refcounting modernisations

+nfs4-stack-reduction.patch

 Stack reduction in nfs4

+minor-rcu-optimization.patch

 Save a few instructions in the RCU core

+idr-overflow-fixes.patch
+idr-overflow-fixes-fix.patch
+idr-overflow-fixes-2.patch

 Fix overflow problems in the IDR code, and a posix-timer race

+timers-signals-rlimits.patch
+timers-signals-rlimits-setuid-fix.patch
+timers-signals-rlimits-fix.patch
+timers-signals-rlimits-rename-stuff.patch

 Add rlimits to the posix-timer and rt-signal allocation code.  To avoid
 various out-of-memory DoS scenarii.

+call-might_sleep-in-tasklet_kill.patch

 tasklet_kill() might sleep.

+d_flags-locking-fix.patch

 dentry->d_flags will require dentry->d_lock

+d_vfs_flags-locking-fix.patch

 cover dentry->d_vfs_flags with dentry->d_lock

+dentry-shrinkage.patch

 Reduce the dentry size

+dentry-qstr-consolidation.patch
+dentry-qstr-consolidation-fix.patch

 Cleanup/simplify/shrink the dentry qstr handling

+dentry-d_bucket-fix.patch

 Be saver and faster about the locking around dentry->d_bucket in __d_lookup()

+dentry-d_flags-consolidation.patch

 Move all the d_vfs_flags bits into d_flags, remove d_vfs_flags

+dentry-layout-tweaks.patch

 Optimise the layout of dentry fields for lookup.

+binfmt-use-core_initcall.patch

 Use core_initcall() to initialise the binfmt handlers.  So subsequent
 initcalls can call out to userspace executables.

+usermodehelper_init-use-core_initcall.patch

 Use core_initcall() to initialise call_usermodehelper().
 
+export-con_set_default_unimap.patch

 Missing EXPORT_SYMBOL()

+crystal-cs4235-mixer-fix.patch

 Sound driver fix

+to-fix-i2o_proc-kernel-panic-on-access-of-proc-i2o-iop0-lct.patch

 Fix i2o_proc oops, convert to seq_file.

+i2o_proc-module-owner-fix.patch

 Set the module owner correctly

+remove-kernel-22-code-from-drivers-net-hamradio-dmasccc-fwd.patch
+telephony-ixjh-remove-kernel-22-ifdefs-fwd.patch

 Remove some 2.2 back-compat code

+fix-some-typos-in-sound-docs.patch

 Fix tpyos

+make-tags-for-selinux.patch

 `make tags' was missing out of some SELinux directories

+remove-intermezzo.patch

 Remove references to fs/intermezzo, in preparation for removing intermezzo
 altogether.

+ppc-termio-fix.patch

 PPC character driver fix

+fix-__down-tainting-kernel-with-config_modversions=y.patch

 Fix bogus kernel tainting problem on ppc.

+add-qsort-library-function.patch

 lib/qsort.c

+have-xfs-use-kernel-provided-qsort.patch

 Use lib/qsort.c in XFS.




All 391 patches:


bk-agpgart.patch

bk-alsa.patch

bk-cifs.patch

bk-cpufreq.patch

bk-driver-core.patch

bk-drm.patch

bk-i2c.patch

bk-libata.patch

bk-netdev.patch

bk-pci.patch

bk-scsi.patch

bk-usb.patch

mm.patch
  add -mmN to EXTRAVERSION

frame-pointer-based-stack-dumps.patch
  x86: stack dumps using frame pointers

fealnx-bogon-fix.patch
  fealnx.c spinlock fix

bk-driver-core-module-fix.patch
  bk-driver-core-module-fix

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix
  kgdb buffer overflow fix
  kgdbL warning fix
  kgdb: CONFIG_DEBUG_INFO fix
  x86_64 fixes
  correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)
  kgdb: fix for recent gcc
  kgdb warning fixes
  THREAD_SIZE fixes for kgdb

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes

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

rmap-9-page_add_anon_rmap-bug-fix.patch
  page_add_anon_rmap BUG fix

rmap-10-add-anonmm-rmap.patch
  rmap 10 add anonmm rmap

rmap-anonhd-locking-fix.patch
  rmap anonhd locking fix

rmap-11-mremap-moves.patch
  rmap 11 mremap moves

rmap-12-pgtable-remove-rmap.patch
  rmap 12 pgtable remove rmap

rmap-13-include-asm-deletions.patch
  rmap 13 include/asm deletions

i_shared_lock.patch
  Convert i_shared_sem back to a spinlock
  i_shared_lock fix 1
  i_shared_lock fix 2
  i_shared_lock mremap fix

rmap-14-i_shared_lock-fixes.patch
  rmap 14: i_shared_lock fixes

numa-api-x86_64.patch
  numa api: -64 support
  numa api: Bitmap bugfix

numa-api-i386.patch
  numa api: Add i386 support

numa-api-ia64.patch
  numa api: Add IA64 support

numa-api-core.patch
  numa api: Core NUMA API code
  numa api: docs and policy_vma() locking fix
  numa-api-core-tweaks
  Some fixes for NUMA API
  From: Matthew Dobson <colpatch@us.ibm.com>
  Subject: [PATCH] include/linux/gfp.h cleanup for NUMA API
  numa-api-core bitmap_clear fixes

mpol-in-copy_vma.patch
  mpol in copy_vma

numa-api-core-slab-panic.patch
  numa-api-core-slab-panic

numa-api-statistics-2.patch
  Re-add NUMA API statistics

numa-api-vma-policy-hooks.patch
  numa api: Add VMA hooks for policy
  numa-api-vma-policy-hooks fix

numa-api-shared-memory-support.patch
  numa api: Add shared memory support
  numa-api-shared-memory-support-tweaks

small-numa-api-fixups.patch
  small numa api fixups

small-numa-api-fixups-fix.patch
  small-numa-api-fixups-fix

numa-api-statistics.patch
  numa api: Add statistics

numa-api-anon-memory-policy.patch
  numa api: Add policy support to anonymous  memory

rmap-15-vma_adjust.patch
  rmap 15: vma_adjust

rmap-16-pretend-prio_tree.patch
  rmap 16: pretend prio_tree

rmap-17-real-prio_tree.patch
  rmap 17: real prio_tree

rmap-18-i_mmap_nonlinear.patch
  rmap 18: i_mmap_nonlinear

rmap-19-arch-prio_tree.patch
  rmap 19: arch prio_tree

vm_area_struct-size-comment.patch
  vm_area_struct size comment

rmapc-comment-style-fixups.patch
  rmap.c comment/style fixups

rmap-20-i_mmap_shared-into-i_mmap.patch
  rmap 20 i_mmap_shared into i_mmap

rmap-21-try_to_unmap_one-mapcount.patch
  rmap 21 try_to_unmap_one mapcount

rmap-22-flush_dcache_mmap_lock.patch
  rmap 22 flush_dcache_mmap_lock

rmap-23-empty-flush_dcache_mmap_lock.patch
  rmap 23 empty flush_dcache_mmap_lock

rmap-24-no-rmap-fastcalls.patch
  rmap 24 no rmap fastcalls

rmap-27-memset-0-vma.patch
  rmap 27 memset 0 vma

rmap-28-remove_vm_struct.patch
  rmap 28 remove_vm_struct

rmap-29-vm_reserved-safety.patch
  rmap 29 VM_RESERVED safety

rmap-30-fix-bad-mapcount.patch
  rmap 30 fix bad mapcount

rmap-31-unlikely-bad-memory.patch
  rmap 31 unlikely bad memory

rmap-32-zap_pmd_range-wrap.patch
  rmap 32 zap_pmd_range wrap

partial-prefetch-for-vma_prio_tree_next.patch
  partial prefetch for vma_prio_tree_next

fix-deadlock-in-journalled-quota.patch
  Fix deadlock in journalled quota

mips-update.patch
  MIPS update

mips-fix-mips-26-fb-setup.patch
  mips: fix 2.6 fb setup

mips-simplify-expression.patch
  mips: Simplify expression

mips-newport-driver-fixes.patch
  mips: newport driver fixes

mips-remove-video_type_sni_rm.patch
  mips: remove VIDEO_TYPE_SNI_RM

mips-gbe-video-driver.patch
  mips: GBE Video Driver

mips-add-missing-ip22-zilog-bit.patch
  mips: add missing IP22 Zilog bit

mips-64-bit-mips-needs-compat-stuff.patch
  mips: 64-bit MIPS needs compat stuff

mips-remove-dz-driver.patch
  mips: remove dz driver

mips-sgiwd93-26-fixes-and-crapectomy.patch
  mips: sgiwd93 2.6 fixes and crapectomy

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

ppc64-extra-barrier-in-i-o-operations.patch
  ppc64: extra barrier in I/O operations

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

slab-leak-detector.patch
  slab leak detector
  mm/slab.c warning in cache_alloc_debugcheck_after

local_bh_enable-warning-fix.patch

Move-saved_command_line-to-init-mainc.patch
  Move saved_command_line to init/main.c

Move-saved_command_line-to-init-mainc-warnings.patch
  arch/i386/boot/compressed/misc.c warning fixes

sched-run_list-cleanup.patch
  small scheduler cleanup

sched-find_busiest_node-resolution-fix.patch
  sched: improved resolution in find_busiest_node

sched-domains.patch
  sched: scheduler domain support

sched-domain-debugging.patch
  sched_domain debugging

sched-domain-balancing-improvements.patch
  scheduler domain balancing improvements

sched-sibling-map-to-cpumask.patch
  sched: cpu_sibling_map to cpu_mask

sched-domains-i386-ht.patch
  sched: implement domains for i386 HT

sched-no-drop-balance.patch
  sched: handle inter-CPU jiffies skew

sched-directed-migration.patch
  sched_balance_exec(): don't fiddle with the cpus_allowed mask

sched-group-power.patch
  sched-group-power

sched-domains-use-cpu_possible_map.patch
  sched_domains: use cpu_possible_map

sched-smt-nice-handling.patch
  sched: SMT niceness handling

sched-local-load.patch
  sched: add local load metrics

sched-process-migration-speedup.patch
  Reduce TLB flushing during process migration

sched-trivial.patch
  sched: trivial fixes, cleanups

sched-hotplug-cpu-sched_balance_exec-fix.patch
  Hotplug CPU sched_balance_exec Fix

sched-wakebalance-fixes.patch
  sched: wakeup balancing fixes

sched-imbalance-fix.patch
  sched: fix imbalance calculations

sched-altix-tune1.patch
  sched: altix tuning

sched-fix-activelb.patch
  sched: oops fix

sched-ppc64-sched-domain-support.patch
  ppc64: sched-domain support

sched-ppc64-sched-domain-support-fix.patch
  ARCH_HAS_SCHED_WAKE_BALANCE doesnt exist

sched-domain-setup-lock.patch
  sched: fix setup races

sched-minor-cleanups.patch
  sched: minor cleanups

sched-inline-removals.patch
  sched: uninlinings

sched-enqueue_task_head.patch
  sched: add enqueeu_task_head()

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

sched-smt-domain-race.patch
  sched: Look at another CPU's domain

sched-move-migrate_all_tasks-to-cpu_dead-handling.patch
  Move migrate_all_tasks to CPU_DEAD handling

sched-sys_sched_getaffinity_lock_cpu_hotplug.patch
  sched_getaffinity vs cpu hotplug race fix

sched-kthread_stop_race_fix.patch
  migration_thread() race fix

x86_64-convert-sibling-map-to-masks.patch
  x86-64: convert sibling map to masks

sched-x86_64-sched-domains-support.patch
  Add SMT setup for domain scheduler on x86-64

schedstats.patch
  sched: scheduler statistics

fixes-in-32-bit-ioctl-emulation-code.patch
  Fixes in 32 bit ioctl emulation code

cond_resched-might-sleep.patch
  cond_resched() might sleep

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

shm-do_munmap-check.patch

stack-overflow-test-fix.patch
  Fix stack overflow test for non-8k stacks

jbd-remove-livelock-avoidance.patch
  JBD: remove livelock avoidance code in journal_dirty_data()

logitech-keyboard-fix.patch
  2.6.5-rc2 keyboard breakage

stack-reductions-nfsread.patch
  stack reductions: nfs read

speed-up-sata.patch
  speed up SATA

advansys-fix.patch
  advansys check_region() fix

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

nfs-O_DIRECT-fixes.patch
  NFS: O_DIRECT fixes

list_del-debug.patch
  list_del debug check

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch
  lockmeter
  ia64 CONFIG_LOCKMETER fix

cciss-logical-device-queues.patch
  cciss: per logical device queues

sk98lin-buggy-vpd-workaround.patch
  net/sk98lin: correct buggy VPD in ASUS MB

unplug-can-sleep.patch
  unplug functions can sleep

firestream-warnings.patch
  firestream warnings

ext3_rsv_cleanup.patch
  ext3 block reservation patch set -- ext3 preallocation cleanup

ext3_rsv_base.patch
  ext3 block reservation patch set -- ext3 block reservation
  ext3 reservations: fix performance regression
  ext3 block reservation patch set -- mount and ioctl feature
  ext3 block reservation patch set -- dynamically increase reservation window

ext3-reservation-default-on.patch
  ext3 reservation: default to on

ext3-reservation-ifdef-cleanup-patch.patch
  ext3 reservation ifdef cleanup patch

ext3-reservation-max-window-size-check-patch.patch
  ext3 reservation max window size check patch

ext3-reservation-file-ioctl-fix.patch
  ext3 reservation file ioctl fix

ext3-lazy-discard-reservation-window-patch.patch
  ext3 lazy discard reservation window patch

ext3-discard-reservation-in-last-iput-fix-patch.patch
  ext3 discard reservation in last iput fix patch

ext3-discard-reservation-in-last-iput-fix-patch-fix.patch
  Fix lazy reservation discard

ext3-reservation-bad-inode-fix.patch
  ext3 reservations: bad_inode fix

ext3_reservation_discard_race_fix.patch
  ext3 reservation discard race fix

ext3-bogus-enospc-fix.patch
  Fix ext3 bogus ENOSPC

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

4-autofs4-260-expire-20040405-fix.patch
  4-autofs4-2.6.0-expire-20040405 locking fix

4-autofs4-260-expire-20040405-fix-fix.patch
  autofs expiry fix

4-autofs4-2.6.0-expire-20040405-may_umount_tree-cleanup.patch
  autofs4: may_umount_tree() cleanup

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

autofs-locking-fix.patch
  autofs locking fix

autofs4-race-fix.patch
  autofs4 race fix

ext3-error-handling-fixes.patch
  ext3 error handling fixes

re-open-descriptors-closed-on-exec-by-selinux-to.patch
  selinux: reopen descriptors closed on exec to /dev/null

cyclades-maintainers-update.patch
  cyclades MAINTAINERS update

laptop-mode-mutt-noatime-doc-update.patch
  Laptop Mode doc update

as-increase-batch-expiry.patch
  AS: increase batch expiry intervals

consolidate-sys32_readv-and-sys32_writev.patch
  Consolidate sys32_readv and sys32_writev

consolidate-do_execve32.patch
  Consolidate do_execve32

consolidate-sys32_select.patch
  Consolidate sys32_select

consolidate-sys32_nfsservctl.patch
  Consolidate sys32_nfsservctl

clean-up-asm-pgalloch-include.patch
  Clean up asm/pgalloc.h include

clean-up-asm-pgalloch-include-2.patch
  Clean up asm/pgalloc.h include

clean-up-asm-pgalloch-include-3.patch
  Clean up asm/pgalloc.h include 3

ppc64-uninline-__pte_free_tlb.patch
  ppc64: uninline __pte_free_tlb()

es7000-subarch-update-2.patch
  es7000 subarch update

input-tsdev-fixes.patch
  tsdev.c fixes

fix-scancode-keycode-scancode-conversion-for-265.patch
  Fix scancode->keycode->scancode conversion

use-less-stack-in-ide_unregister.patch
  use less stack in ide_unregister

psmouse-fix-mouse-hotplugging.patch
  psmouse: fix mouse hotplugging

kernel_ppc8xx_misc.patch
  ppc32: ppc8xx build fixes

remove-bootsect_helper-and-a-comment-fix-iii.patch
  Remove bootsect_helper and a comment fix

remove-bootsect_helper-on-x86_64-and-pc98.patch
  Remove bootsect_helper on x86_64 and pc98

fealnx-mac-address-and-other-issues.patch
  Fealnx. Mac address and other issues

remove-some-unused-variables-in-s2io.patch
  remove some unused variables in s2io

new-version-of-early-cpu-detect.patch
  New version of early CPU detect

shrink_slab-handle-GFP_NOFS.patch
  shrink_slab: improved handling of GFP_NOFS allocations

shrink_slab-handle-GFP_NOFS-fix.patch
  shrink_slab-handle-GFP_NOFS-fix

fix-3c59xc-to-allow-3c905c-100bt-fd.patch
  fix 3c59x.c to allow 3c905c 100bT-FD

use-dos_extended_partition.patch
  partitioning cleanup: use DOS_EXTENDED_PARTITION

reiserfs-commit-default-fix.patch
  From: Bart Samwel <bart@samwel.tk>
  Subject: [PATCH] Reiserfs commit default fix

reiserfs-acl-mknod.patch
  reiserfs: acl device node initialization

reiserfs-xattrs-04.patch
  reiserfs: xattr support

reiserfs-acl-02.patch
  reiserfs: ACL support

reiserfs-trusted-02.patch
  reiserfs: support trusted xattrs

reiserfs-selinux-02.patch
  reiserfs: selinux support

reiserfs-xattr-locking-02.patch
  reiserfs: xattr locking fixes

reiserfs-quota.patch
  reiserfs: quota support

reiserfs-permission.patch
  reiserfs: xattr permission fix

reiserfs-warning.patch
  reiserfs: add device info to diagnostic messages

reiserfs-group-alloc-9.patch
  reiserfs: block allocator optimizations

reiserfs-remove-debugging-warning-from-block-allocator.patch
  reiserfs: remove debugging warning from block allocator

reiserfs-group-alloc-9-build-fix.patch
  reiserfs-group-alloc-9 build fix

reiserfs-search_reada-5.patch
  reiserfs: btree readahead

reiserfs-data-logging-support.patch
  reiserfs data logging support

problems-with-atkbd_command--atkbd_interrupt-interaction.patch
  Problems with atkbd_command & atkbd_interrupt interaction

mptfusion-depends-on-scsi.patch
  mptfusion depends on scsi

mark-config_mac_serial-drivers-macintosh-macserialc-as-broken.patch
  Mark CONFIG_MAC_SERIAL (drivers/macintosh/macserial.c) as broken

radeon-garbled-screen-fix.patch
  radeonfb: fix garbled screen

neomagic-driver-update.patch
  Neomagic driver update.

radeon-fb-screen-corruption-fix.patch
  radeonfb display corruption fix

tridentfbc-warning-fix.patch
  video/tridentfb.c warning fix

hgafbc-warning-fix.patch
  video/hgafb.c warning fix

tdfxfbc-warning-fix.patch
  video/tdfxfb.c warning fix

imsttfbc-warning-fix.patch
  video/imsttfb.c. warning fix

fbdev-logo-handling-fix.patch
  fbdev: clean up logo handling

fbdev-redundant-prows-calculation-removal.patch
  fbdev: remove redundant p->vrows calculation

fbdev-remove-redundant-local.patch
  fbdev: remove redundant local

fbdev-access_align-default.patch
  fbdev: set a default access_align value

fix-null-ptr-dereference-in-pm2fb_probe-2.patch
  Fix NULL-ptr dereference in pm2fb_probe

virtual-fbdev-updates.patch
  Virtual fbdev updates

vesa-fbdev-update.patch
  Vesa Fbdev update

vesa-fbdev-update-fix.patch
  Vesa Fbdev update fix

sis-agp-updates.patch
  SIS AGP updates

new-asiliant-framebuffer-driver.patch
  New Asiliant framebuffer driver.

fbcon-and-unimap.patch
  Fix fbcon and unimap

videodev-handle-class_register-failure.patch
  videodev: handle class_register() failure

q40-fbdev-updates.patch
  Q40 fbdev updates.

8139too-suspend-fix.patch
  8139too not running s3 suspend/resume pci fix

acpiphp_glue-oops-fix.patch
  acpiphp_glue.c oops fix

clear_backing_dev_congested.patch
  clear_baking_dev_congested

dpt_i2o.patch
  Fix dpt_i2o

find_user-locking.patch
  find_user-locking

improve-laptop-modes-block_dump-output.patch
  Improve laptop mode's block_dump output

com90xx_message.patch
  com90xx error message patch: check_region() gone

parport_doc_arg.patch
  Kill a warning while making pdfdocs.

kernel-api-docs.patch
  Kill some 'No description found...' warnings. (kernel-api.sgml)

allow-architectures-to-reenable-interrupts-on-contended-spinlocks.patch
  Allow architectures to reenable interrupts on contended spinlocks

allow-i386-to-reenable-interrupts-on-lock-contention.patch
  Allow i386 to reenable interrupts on lock contention

un-inline-spinlocks-on-ppc64.patch
  Un-inline spinlocks on ppc64

only-print-tainted-message-once.patch
  Only Print Taint Message Once

ia64-cpuhotplug-core_kernel_init.patch
  oa64 cpu hotplug: core kernel initialisation

ia64-cpuhotplug-init_removal.patch
  ia64 cpu hotplug: init section fixes

ia64-cpuhotplug-sysfs_ia64.patch
  ia64 cpu hotplug: sysfs additions

ia64-cpuhotplug-irq_affinity_fix.patch
  ia64 cpu hotplug: IRQ affinity work

ia64-cpuhotplug-palinfo.patch
  ia64 cpu hotplug: /proc rework

ia64-cpu-hotplug-cpu_present-2.patch
  Revisited: ia64-cpu-hotplug-cpu_present.patch

ia64-cpu-hotplug-cpu_present-2-fix.patch
  ia64-cpu-hotplug-cpu_present-2-fix

ia64-cpuhotplug-hotcpu.patch
  ia64 cpu hotplug: core

blk_start_queue-use-kblockd.patch
  blk_start_queue() should use kblockd

module-ref-counting-for-vt-console-drivers.patch
  Module ref counting for vt console drivers

edd-follow-sysfs-convention-module_version-remove-dead-scsi-symlink.patch
  EDD: follow sysfs convention, MODULE_VERSION, remove dead SCSI symlink

cmpci-update.patch
  cmpci OSS driver update

i2o-subsystem-fixing-and-cleanup-for-26-i2o-config-cleanpatch.patch
  I2O subsystem fixing and cleanup for 2.6 - i2o-config-clean.patch

i2o-subsystem-fixing-and-cleanup-for-26-i2o-passthrupatch.patch
  I2O subsystem fixing and cleanup for 2.6 - i2o-passthru.patch

i2o-subsystem-fixing-and-cleanup-for-26-i2o_block-cleanuppatch.patch
  I2O subsystem fixing and cleanup for 2.6 - i2o_block-cleanup.patch

i2o-subsystem-fixing-and-cleanup-for-26-i2o-64-bit-fixpatch.patch
  I2O subsystem fixing and cleanup for 2.6 - i2o-64-bit-fix.patch

i2o-subsystem-fixing-and-cleanup-for-26-i2o-makefile-cleanuppatch.patch
  I2O subsystem fixing and cleanup for 2.6 - i2o-makefile-cleanup.patch

dentry-and-inode-cache-hash-algorithm-performance-changes.patch
  dentry and inode cache hash algorithm performance changes.

fix-mtd-suspend-resume.patch
  From: Russell King <rmk@arm.linux.org.uk>
  Subject: [MTD] Fix MTD suspend/resume

remove-blk_queue_bounce-messages.patch
  remove blk_queue_bounce() printks

fix-deadlock-in-__create_workqueue-2.patch
  a

throttle-p4-thermal-warnings.patch
  throttle P4 thermal warnings

i82365c-warning-fix.patch
  pcmcia/i82365.c warning fix

make-4k-stacks-permanent.patch
  make 4k stacks permanent

worker_thread-race-fix.patch
  worker_thread-race-fix

force-config_regparm-to-y.patch
  Force CONFIG_REGPARM to `y'

kernel-syscalls-retval-fix.patch
  a

remove-errno-refs.patch
  remove-errno-refs

ia64-remove-errno-refs.patch
  ia64-remove-errno-refs

warn-when-smp_call_function-is-called-with-interrupts-disabled.patch
  Warn when smp_call_function() is called with interrupts disabled

initio-ini-9x00u-uw-error-handling-in-26.patch
  Initio INI-9X00U/UW error handling

fixup-68360-module-refcounting.patch
  fixup 68360 module refcounting

missing-closing-n-in-printk.patch
  missing closing n in printk

intermezzo-stack-reduction.patch
  intermezzos stack usage reduction

lance-racal-interlan-fix.patch
  lance.c: fix for card with signature 0x52 0x49

gcc-340-fixes-for-266-rc3-x86_64-kernel.patch
  gcc-3.4.0 fixes for 2.6.6-rc3 x86_64 kernel

ppc64-use-generic-ipc-syscall-translation.patch
  ppc64: use generic ipc syscall translation

ramdisk-size-warning-fix.patch
  fix ramdisk size assembler warning

cyclades-cleanups.patch
  cyclades cleanups

jiffies-to-clockt-fix_a1.patch
  jiffies-to-clockt fix

readahead-private.patch
  hack2

introduce-asm--8253pith.patch
  CLOCK_TICK_RATE: introduce asm-*/8253pit.h, #define PIT_TICK_RATE constant.

use-pit_tick_rate-in-spkrc.patch
  CLOCK_TICK_RATE: use PIT_TICK_RATE in *spkr.c

use-clock_tick_rate.patch
  CLOCK_TICK_RATE: use CLOCK_TICK_RATE

265-es7000-subarch-update-for-generic-arch.patch
  es7000 subarch update for generic arch

new-i2c-video-decoder-calls.patch
  new i2c video decoder calls

new-i2c-video-decoder-calls-saa7111.patch
  new i2c video decoder calls: saa7111 driver

get_thread_area-macros.patch
  get_thread_area macro fixes

update-documentation-mdtxt.patch
  update Documentation/md.txt

invalid-notify_changesymlink-in-nfsd.patch
  Invalid notify_change(symlink, [ATTR_MODE]) in nfsd

bfs-filesystem-read-past-the-end-of-dir.patch
  bfs filesystem read past the end of dir

simplify-mqueue_inode_info-messages-allocation.patch
  simplify mqueue_inode_info->messages allocation

wakefunc.patch
  filtered wakeups

wakeup.patch
  filtered wakeups: wakeup enhancements

filtered_page.patch
  filtered wakeups: apply to pagecache functions

filtered_buffer.patch
  filtered wakeups: apply to buffer_head functions

swsusp-documentation-updates.patch
  swsusp documentation updates

fix-sysfs-symlinks.patch
  fix sysfs symlinks

sysfs-leaves-mount.patch
  sysfs backing store: sysfs_direct

sysfs-leaves-dir.patch
  sysfs backing store: inode operations

sysfs-leaves-file.patch
  sysfs backing store: sysfs operations

sysfs-leaves-symlink.patch
  sysfs backing store: sysfs_create_link changes

sysfs-leaves-bin.patch
  sysfs backing store: bin file attribute changes

sysfs-leaves-misc.patch
  sysfs backing store: attribute groups

cache-queue_congestion_on-off_threshold.patch
  blk: cache queue_congestion_on/off_threshold values

report-size-of-printk-buffer-selinux-interface.patch
  SElinux interface for reporting size of printk buffer

fix-race-on-tty-close.patch
  Fix race on tty close

die_386_graphic.patch
  ia32 oops diagnostic fix

force-ide-cache-flush-on-shutdown-flush.patch
  Force IDE cache flush on shutdown

force-ide-cache-flush-on-shutdown-flush-fix.patch
  force-ide-cache-flush-on-shutdown-flush-fix

as-iosched-cleanups.patch
  as-iosched cleanups

fix-net-tulip-winbond-840c-warning.patch
  fix net/tulip/winbond-840.c warning.

pcmcia-tcicc-warning-fix.patch
  pcmcia/tcic.c warning fix.

lindent-on-arch-i386-kernel-cpuidc.patch
  Lindent arch/i386/kernel/cpuid.c

fix-media-dsbr100c-unused-variable.patch
  fix media/dsbr100.c unused variable.

fix-warning-in-intermezzo-journalc.patch
  fix warning in intermezzo/journal.c.

fix-wrong-var-used-in-hotplug-shpchp_ctrlc.patch
  fix wrong var used in hotplug/shpchp_ctrl.c.

hugepage-add_to_page_cache-fix.patch
  hugepage: fix add_to_page_cache() error handling

hugetlb_shm_group-sysctl-patch.patch
  Add sysctl to define a hugetlb-capable group

mlock_group-sysctl.patch
  mlock_group sysctl

nfs_writepage_sync-stack-reduction.patch
  nfs_writepage_sync stack reduction

cpqarray-update-for-26.patch
  cpqarray update for 2.6

i8042-shutdown-fix.patch
  i8042 shutdown fix

kill-useless-mod_incdec_use_count-in-sound-oss-msndc.patch
  kill useless MOD_{INC,DEC}_USE_COUNT in sound/oss/msnd.c

kill-mod_incdec_use_count-gunk-in-arch-cris-arch-v10-drivers-pcf8563c.patch
  kill MOD_{INC,DEC}_USE_COUNT gunk in arch/cris/arch-v10/drivers/pcf8563.c

fix-mod_incdec_use_count-gunk-in-arch-um-drivers-net_kernc.patch
  fix MOD_{INC,DEC}_USE_COUNT gunk in arch/um/drivers/net_kern.c

drivers-video-mod_inc_use_count-fixes.patch
  drivers/video/* MOD_INC_USE_COUNT fixes

fix-mod_inc_use_count-usage-in-mtd.patch
  fix MOD_INC_USE_COUNT usage in mtd

remove-mod_inc_use_count-usage-in-arch-um-drivers-harddog_kernc.patch
  remove MOD_INC_USE_COUNT usage in arch/um/drivers/harddog_kern.c

nfs4-stack-reduction.patch
  nfs4 stack reduction

minor-rcu-optimization.patch
  minor RCU optimization

idr-overflow-fixes.patch
  Fixes for idr code
  idr-overflow-fixes fix
  More fixes for idr code
  Fixes for POSIX timers
  timers-signals-rlimits-setuid-fix
  timers-signals-rlimits-fix
  timers-signals-rlimits-rename-stuff

idr-overflow-fixes-fix.patch
  idr-overflow-fixes fix

idr-overflow-fixes-2.patch
  More fixes for idr code

timers-signals-rlimits.patch
  Fixes for POSIX timers

timers-signals-rlimits-setuid-fix.patch
  timers-signals-rlimits-setuid-fix

timers-signals-rlimits-fix.patch
  timers-signals-rlimits-fix

timers-signals-rlimits-rename-stuff.patch
  timers-signals-rlimits-rename-stuff

call-might_sleep-in-tasklet_kill.patch
  Call might_sleep() in tasklet_kill

d_flags-locking-fix.patch
  d_flags locking fixes

d_vfs_flags-locking-fix.patch
  d_vfs_flags locking fix

dentry-shrinkage.patch
  dentry shrinkage

dentry-qstr-consolidation.patch
  dentry qstr consolidation

dentry-qstr-consolidation-fix.patch
  dentry qstr consolidation fix

dentry-d_bucket-fix.patch
  dentry d_bucket fix

dentry-d_flags-consolidation.patch
  more dentry shrinkage

dentry-layout-tweaks.patch
  dentry layout tweaks

binfmt-use-core_initcall.patch
  use core_initcall for binfmt initialisation

usermodehelper_init-use-core_initcall.patch
  Make usermodehelper_init() use core_initcall()

export-con_set_default_unimap.patch
  export con_set_default_unimap()

crystal-cs4235-mixer-fix.patch
  Crystal cs4235 mixer fix

to-fix-i2o_proc-kernel-panic-on-access-of-proc-i2o-iop0-lct.patch
  Fix i2o_proc kernel panic on access of /proc/i2o/iop0/lct

i2o_proc-module-owner-fix.patch
  i2o_proc module owner fix

remove-kernel-22-code-from-drivers-net-hamradio-dmasccc-fwd.patch
  remove kernel 2.2 code from drivers/net/hamradio/dmascc.c

telephony-ixjh-remove-kernel-22-ifdefs-fwd.patch
  telephony/ixj.h: remove kernel 2.2 #ifdef's

fix-some-typos-in-sound-docs.patch
  fix some typos in sound docs

make-tags-for-selinux.patch
  make tags for selinux

remove-intermezzo.patch
  remove-intermezzo

ppc-termio-fix.patch
  PPC termio fix

fix-__down-tainting-kernel-with-config_modversions=y.patch
  Fix __down Tainting Kernel with CONFIG_MODVERSIONS=y

add-qsort-library-function.patch
  add qsort library function

have-xfs-use-kernel-provided-qsort.patch
  Have XFS use kernel-provided qsort

 

