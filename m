Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263969AbUEMK3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263969AbUEMK3Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 06:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbUEMK3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 06:29:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:20902 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264022AbUEMK2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 06:28:04 -0400
Date: Thu, 13 May 2004 03:27:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.6-mm2
Message-Id: <20040513032736.40651f8e.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm2/


- Lots of VM changes - fixes from Andrea and generally moving things closer
  to the -aa tree.

- The x86_64 gcc-3.3.3 shipped with SuSE 9.1 miscompiles the post-2.6.6 CPU
  scheduler changes, resulting in lockups after several minutes of heavy load.
  Hence this kernel refuses to build on gcc-3.3.x.  Please use gcc-3.4.0 if
  you're on x86_64.

- Rediscovered and hopefully fixed the page double-freeing bug which was
  identified in August 2002 (!).  I decided it wasn't real, but it is.

- arch updates, rlimits for rt-signals and posix message queues, tons of
  other stuff.



Changes since 2.6.6-mm1:


 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-driver-core.patch
 bk-i2c.patch
 bk-input.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-net-drivers.patch
 bk-pci.patch
 bk-pcmcia.patch
 bk-scsi.patch
 bk-serial.patch
 bk-usb.patch

 External trees.  (bk-pci is currently in disgrace due to BK conflicts.  This
 is an old version).

-fix-deadlock-in-journalled-quota.patch
-mips-update.patch
-mips-fix-mips-26-fb-setup.patch
-mips-simplify-expression.patch
-mips-newport-driver-fixes.patch
-mips-remove-video_type_sni_rm.patch
-mips-gbe-video-driver.patch
-mips-add-missing-ip22-zilog-bit.patch
-mips-64-bit-mips-needs-compat-stuff.patch
-mips-remove-dz-driver.patch
-mips-sgiwd93-26-fixes-and-crapectomy.patch
-ppc64-extra-barrier-in-i-o-operations.patch
-sched-run_list-cleanup.patch
-sched-find_busiest_node-resolution-fix.patch
-sched-domains.patch
-sched-domain-debugging.patch
-sched-domain-balancing-improvements.patch
-sched-sibling-map-to-cpumask.patch
-sched-domains-i386-ht.patch
-sched-no-drop-balance.patch
-sched-directed-migration.patch
-sched-group-power.patch
-sched-domains-use-cpu_possible_map.patch
-sched-smt-nice-handling.patch
-sched-local-load.patch
-sched-process-migration-speedup.patch
-sched-trivial.patch
-sched-hotplug-cpu-sched_balance_exec-fix.patch
-sched-wakebalance-fixes.patch
-sched-imbalance-fix.patch
-sched-altix-tune1.patch
-sched-fix-activelb.patch
-sched-ppc64-sched-domain-support.patch
-sched-ppc64-sched-domain-support-fix.patch
-sched-domain-setup-lock.patch
-sched-minor-cleanups.patch
-sched-inline-removals.patch
-sched-enqueue_task_head.patch
-sched-more-sync-wakeups.patch
-sched-boot-fix.patch
-sched-cleanups.patch
-sched-damp-passive-balance.patch
-sched-cpu-load-cleanup.patch
-sched-balance-context.patch
-sched-less-idle.patch
-sched-wake_up-speedup.patch
-sched-smt-domain-race.patch
-sched-move-migrate_all_tasks-to-cpu_dead-handling.patch
-sched-sys_sched_getaffinity_lock_cpu_hotplug.patch
-sched-kthread_stop_race_fix.patch
-x86_64-convert-sibling-map-to-masks.patch
-sched-x86_64-sched-domains-support.patch
-fixes-in-32-bit-ioctl-emulation-code.patch
-nmi_watchdog-local-apic-fix.patch
-nmi-1-hz-2.patch
-ext3-bogus-enospc-fix.patch
-sched-in_sched_functions.patch
-sysfs-d_fsdata-race-fix-2.patch
-ext3-error-handling-fixes.patch
-re-open-descriptors-closed-on-exec-by-selinux-to.patch
-cyclades-maintainers-update.patch
-laptop-mode-mutt-noatime-doc-update.patch
-as-increase-batch-expiry.patch
-consolidate-sys32_readv-and-sys32_writev.patch
-consolidate-do_execve32.patch
-consolidate-sys32_select.patch
-consolidate-sys32_nfsservctl.patch
-ppc64-uninline-__pte_free_tlb.patch
-es7000-subarch-update-2.patch
-kernel_ppc8xx_misc.patch
-remove-bootsect_helper-and-a-comment-fix-iii.patch
-remove-bootsect_helper-on-x86_64-and-pc98.patch
-remove-some-unused-variables-in-s2io.patch
-new-version-of-early-cpu-detect.patch
-shrink_slab-handle-GFP_NOFS.patch
-shrink_slab-handle-GFP_NOFS-fix.patch
-fix-3c59xc-to-allow-3c905c-100bt-fd.patch
-use-dos_extended_partition.patch
-reiserfs-commit-default-fix.patch
-reiserfs-acl-mknod.patch
-reiserfs-xattrs-04.patch
-reiserfs-acl-02.patch
-reiserfs-trusted-02.patch
-reiserfs-selinux-02.patch
-reiserfs-xattr-locking-02.patch
-reiserfs-quota.patch
-reiserfs-permission.patch
-reiserfs-warning.patch
-mptfusion-depends-on-scsi.patch
-radeon-fb-screen-corruption-fix.patch
-8139too-suspend-fix.patch
-find_user-locking.patch
-improve-laptop-modes-block_dump-output.patch
-com90xx_message.patch
-parport_doc_arg.patch
-kernel-api-docs.patch
-allow-architectures-to-reenable-interrupts-on-contended-spinlocks.patch
-un-inline-spinlocks-on-ppc64.patch
-only-print-tainted-message-once.patch
-blk_start_queue-use-kblockd.patch
-edd-follow-sysfs-convention-module_version-remove-dead-scsi-symlink.patch
-cmpci-update.patch
-dentry-and-inode-cache-hash-algorithm-performance-changes.patch
-fix-mtd-suspend-resume.patch
-remove-blk_queue_bounce-messages.patch
-fix-deadlock-in-__create_workqueue-2.patch
-throttle-p4-thermal-warnings.patch
-i82365c-warning-fix.patch
-worker_thread-race-fix.patch
-kernel-syscalls-retval-fix.patch
-remove-errno-refs.patch
-warn-when-smp_call_function-is-called-with-interrupts-disabled.patch
-initio-ini-9x00u-uw-error-handling-in-26.patch
-fixup-68360-module-refcounting.patch
-intermezzo-stack-reduction.patch
-lance-racal-interlan-fix.patch
-gcc-340-fixes-for-266-rc3-x86_64-kernel.patch
-ppc64-use-generic-ipc-syscall-translation.patch
-ramdisk-size-warning-fix.patch
-cyclades-cleanups.patch
-jiffies-to-clockt-fix_a1.patch
-readahead-private.patch
-introduce-asm--8253pith.patch
-use-pit_tick_rate-in-spkrc.patch
-use-clock_tick_rate.patch
-265-es7000-subarch-update-for-generic-arch.patch
-new-i2c-video-decoder-calls.patch
-new-i2c-video-decoder-calls-saa7111.patch
-get_thread_area-macros.patch
-update-documentation-mdtxt.patch
-bfs-filesystem-read-past-the-end-of-dir.patch
-simplify-mqueue_inode_info-messages-allocation.patch
-swsusp-documentation-updates.patch
-cache-queue_congestion_on-off_threshold.patch
-report-size-of-printk-buffer-selinux-interface.patch
-fix-race-on-tty-close.patch
-force-ide-cache-flush-on-shutdown-flush.patch
-force-ide-cache-flush-on-shutdown-flush-fix.patch
-as-iosched-cleanups.patch
-pcmcia-tcicc-warning-fix.patch
-lindent-on-arch-i386-kernel-cpuidc.patch
-fix-media-dsbr100c-unused-variable.patch
-fix-warning-in-intermezzo-journalc.patch
-fix-wrong-var-used-in-hotplug-shpchp_ctrlc.patch
-hugepage-add_to_page_cache-fix.patch
-hugetlb_shm_group-sysctl-patch.patch
-cpqarray-update-for-26.patch
-i8042-shutdown-fix.patch
-kill-useless-mod_incdec_use_count-in-sound-oss-msndc.patch
-kill-mod_incdec_use_count-gunk-in-arch-cris-arch-v10-drivers-pcf8563c.patch
-fix-mod_incdec_use_count-gunk-in-arch-um-drivers-net_kernc.patch
-drivers-video-mod_inc_use_count-fixes.patch
-fix-mod_inc_use_count-usage-in-mtd.patch
-remove-mod_inc_use_count-usage-in-arch-um-drivers-harddog_kernc.patch
-minor-rcu-optimization.patch
-binfmt-use-core_initcall.patch
-usermodehelper_init-use-core_initcall.patch
-export-con_set_default_unimap.patch
-crystal-cs4235-mixer-fix.patch
-remove-kernel-22-code-from-drivers-net-hamradio-dmasccc-fwd.patch
-telephony-ixjh-remove-kernel-22-ifdefs-fwd.patch
-fix-some-typos-in-sound-docs.patch
-make-tags-for-selinux.patch
-remove-intermezzo.patch
-ppc-termio-fix.patch
-fix-__down-tainting-kernel-with-config_modversions=y.patch

 Merged

+page_count-fixups.patch

 Remove all(?) open-coded references to page->count.

+page-freeing-race-fix.patch

 Fix race between page_cache_release() and vmscan.c functions.  Hopefully
 fixes the page double-free in bug 1403.

+arch-atomic_add_negative.patch

 Implement atomic_add_negative() on lots of architectures.  (needed by the
 above)

+arch-atomic_inc_and_test.patch

 Implement atomic_inc_and_test() on lots of architectures.  (needed by the
 above)

+x86_64-doesnt-like-gcc-333.patch

 Some flavours of gcc-3.3.3 compile x86_64 kernels incorrectly.

+yield_irq.patch

 Small bug in sched_yield()

+MSEC_TO_JIFFIES-fixups.patch
+msec_to_jiffies-fixups-speedup.patch

 MSECS_TO_JIFFIES fixes

+revert-process-migration-speedup.patch

 Revert small ia64-only CPU scheduler patch.

+vm-accounting-fix.patch

 Fix VMA merging

+system-state-splitup.patch

 Make system_state more meaningful.  So IDE flushing doesn't spin the disk
 down across reboots. (This enables the IDE change - this kernel does not
 actually implement the IDE change).

+kexec-reserve-syscall-slot.patch

 Reserve a syscall slot for kexec.

+do_mounts_rd-malloc-fix.patch

 Fix a warning.

+acpi-procfs-fix.patch

 Fix ACPI procfs handling

+writeback_inodes-fix.patch

 Fix race in writeback.

+rename-rmap_lock.patch

 Rename rmap_lock() to page_map_lock().

+rmap-5-swap_unplug-page-revert.patch

 Revert pre-2.6.6 swap unplugging changes.

+blk_run_page.patch
+blk_run_page-swap-fixup.patch
+blk_run_page-sync_buffer-revert.patch

 Generalise the per-address-space blockdev unplugging code.

+rmap-7-object-based-rmap-sync_page-fix.patch

 Fix rmap-7-object-based-rmap.patch for the above.
 
+swap-speedups-and-fix.patch

 Simplify, speedup and fix the swapdev unplugging code.

+try_to_unmap_cluster-comment.patch

 Add a comment

-i_shared_lock.patch
+i_mmap_lock.patch

 Rename i_shared_lock to i_mmap_lock

+unmap_mapping_range-comment.patch

 Add another comment.

+rmap-19-arch-prio_tree-parisc.patch
+rmap-20-i_mmap_shared-into-i_mmap-parisc.patch
+rmap-22-flush_dcache_mmap_lock-parisc.patch

 Recent parisc changes broke Hugh's patches.  He fixed them up.

+rmap-33-install_arg_page-vma.patch

 anon_vma preparation work.

+ppc64-uninline-__pte_free_tlb.patch
+export-clear_pages-on-ppc32.patch
+ppc32-fix-__flush_dcache_icache_phys-for-book-e.patch
+ppc32-fix-copy-prefetch-on-non-coherent-ppcs.patch
+ppc32-add-book-e--ppc44x-specific-exception-support.patch
+ppc32-add-book-e--ppc44x-specific-exception-support-2.patch
+ppc32-new-ocp-core-support-updated.patch
+ppc32-bubinga-405ep-for-new-ocp.patch
+ppc32-ppc44x-lib-support.patch
+ppc32-ibm-ppc4xx-specific-ocp-support.patch
+ppc32-4xx-core-fixes-and-440gx-pic-support.patch
+ppc32-update-4xx-defconfigs.patch
+ppc32-ppc40x-ports-for-new-ocp.patch
+ppc32-ppc44x-ports-for-new-ocp.patch

 PPCxx stuff

-CONFIG_STANDALONE-default-to-n.patch

 Dropped, seems unneeded.

-Move-saved_command_line-to-init-mainc.patch
-Move-saved_command_line-to-init-mainc-warnings.patch

 Dropped, was causing x86_64 grief.

+sched-loadup-roundup.patch
+sched-activate-tslt.patch

 CPU scheduler work.

-nfs-O_DIRECT-fixes.patch

 Dropped - was not up to date.

+autofs4-compat-ioctls.patch

 Missing autofs4 compat ioctls.

-psmouse-fix-mouse-hotplugging.patch

 Dropped, it broke things.

+i2o-64-bit-fixes.patch

 Fix the i2o patches for 64-bit.

+invalid-notify_changesymlink-in-nfsd-fix.patch

 NFSD fix

+sysfs-backing-store-sysfs_rename_dir-fix.patch

 Fix oops in the sysfs-backing-store patches

+hugetlb_shm_group-sysctl-gid-0-fix.patch

 Don't make gid 0 special for hugetlb shm.

-idr-overflow-fixes-fix.patch
-idr-overflow-fixes-2.patch

 Folded into idr-overflow-fixes.patch

+idr-remove-counter.patch

 Remove that funny 8-bit counter from the MSB's of idr_get_new()'s return
 value.

-timers-signals-rlimits.patch
-timers-signals-rlimits-setuid-fix.patch
-timers-signals-rlimits-fix.patch
-timers-signals-rlimits-rename-stuff.patch
+rlim-add-rlimit-entry-for-controlling-queued-signals.patch
+rlim-add-sigpending-field-to-user_struct.patch
+rlim-pass-task_struct-in-send_signal.patch
+rlim-add-simple-get_uid-helper.patch
+rlim-enforce-rlimits-on-queued-signals.patch
+rlim-remove-unused-queued_signals-global-accounting.patch
+rlim-add-rlimit-entry-for-posix-mqueue-allocation.patch
+rlim-add-mq_bytes-to-user_struct.patch
+rlim-add-mq_attr_ok-helper.patch
+rlim-enforce-rlimits-for-posix-mqueue-allocation.patch
+rlim-adjust-default-mqueue-sizes.patch

 Reworked rlimits for signals and posix message queues.

+slabify-iocontext-request_queue.patch
+slabify-iocontext-request_queue-SLAB_PANIC.patch

 Add some slab caches for the block layer

+show-last-kernel-image-symbol-in-proc-kallsyms.patch

 Fix /proc/kallsyms output

+raid-locking-fix.patch

 Fix illegal sleep in RAID

+include-aliases-in-kallsyms.patch

 Enhance kallsyms

+make-buildcheck.patch
+make-buildcheck-license-fix.patch

 Add reference_discarded.pl to the build system.

+efivars-fix.patch

 Fix oops with efivars enabled but not avaialble.

+serial-fifo-size-is-ignored.patch

 Serial driver fix

+expose-backing-dev-max-read-ahead.patch

 Expose the per-disk readahead tunable in /sys/block/hda/queue

+ib700wdt-fix.patch
+ib700wdt-fix-2.patch

 Watchdog driver fixes

+laptop-doc-bugfix.patch

 Documentation fix

+create_workqueue-locking-bogon.patch

 workqueue locking fixlet

+problem-with-aladdincard-entry-in-parport_pc.patch

 parport fix

+seeky-readahead-speedups.patch

 readahead speedups (I hope - haven't benched it)

+watchdog-timer-for-intel-ixp4xx-cpus.patch

 New watchdog driver

+i810_audio-fixes-from-herbert-xu.patch

 Audio driver fixes

+ide-diskc-revert-to-previous-24-way-of-handling-flush-cache-commands.patch

 More IDE disk flushing fun

+update-laptop-mode-control-script-with-xfs_hz=100.patch

 Documentation fix

+del_singleshot_timer_sync.patch
+del_singleshot_timer_sync-tweaks.patch

 Faster version of del_timer_sync()

+really-ptrace-single-step-2.patch

 Fix ptracing across int $80.

+dquot_release-oops-workaround.patch

 Hopefully hackily fix the dquot oops, until Jan fixes it for real

+h8-300-update-1-9-bitopsh-add-find_next_bit.patch
+h8-300-update-2-9-ldscripts-fix.patch
+h8-300-update-3-9-pic-support.patch
+h8-300-update-4-9-preempt-support.patch
+h8-300-update-5-9-sci-driver-fix.patch
+h8-300-update-6-9-ne-driver.patch
+h8-300-update-7-9-kconfig.patch
+h8-300-update-8-9-delete-headers.patch
+h8-300-update-9-9-more-cleanup.patch

 H8/300 updates

+calculate-ngroups_per_block-from-page_size.patch

 Fix nasty ia64-affecting NGROUPS_MAX bug

+pci-debug-compile-fix-in-sis_router_probe.patch

 Compile fix

+remove-empty-build-of-capabilityo.patch

 Don't compile an empty file.

+minor-cleanups-in-capabilityc.patch

 capability.c tidy up

+add-disable-param-to-capabilities-module.patch

 Add a "disable=1" option to the capabilities module.

+fix-linux-doc-errors.patch

 Fix kerneldoc generation

+fix-block-layer-ioctl-bug.patch

 Handle strange blockdev ioctl return values.

+fix-crash-on-modprobe-ohci1394.patch

 Fix a firewire problem

+x86_64-has-buggy-ffs-implementation.patch

 Fix x86_64 ffs() implementation

+make-reiserfs-not-to-crash-on-oom.patch

 reiserfs error path handling fix

+implement-print_modules.patch

 Provide an implementation of print_modules()

+m68k-print_modules.patch

 Use it in m68k

+fix-endianess-in-modpost-when-cross-compiling-for-sparc-on-i386.patch

 Fix cross-compilation

+fix-cyclades-compile-with-pci.patch
+fix-tlanc-for-pci.patch
+fix-aic7xxx_oldc-for-pci.patch

 CONFIG_PCI=n build fixes

+powernow-k8-buggy-bios-override-for-266.patch

 Work around a BIOS bug

+x86_64-msr-warning-fix.patch

 Fix a compile warning

+abs-cleanup.patch

 Fix problems with abs().  (I'll probably drop this, in favour of simply
 nuking abs() althogether).

  





All 334 patches:


linus.patch

page_count-fixups.patch
  Make users of page->count use the provided macros

page-freeing-race-fix.patch
  Fix page double-freeing race

arch-atomic_add_negative.patch
  Implement atomic_add_negative() on various architectures

arch-atomic_inc_and_test.patch
  Implement atomic_inc_and_test() on various architectures

x86_64-doesnt-like-gcc-333.patch
  x86_64 doesn't like gcc-3.3.3

yield_irq.patch
  sched: add missing local_irq_enable()

MSEC_TO_JIFFIES-fixups.patch
  MSEC_TO_JIFFIES consolidation

msec_to_jiffies-fixups-speedup.patch
  MSEC_TO_JIFFIES speedup

revert-process-migration-speedup.patch
  revert the process-migration-speedup patch

vm-accounting-fix.patch
  VM accounting fix

system-state-splitup.patch
  system_state splitup

kexec-reserve-syscall-slot.patch
  reserve a syscall slot for kexec

do_mounts_rd-malloc-fix.patch
  do_mounts_rd-malloc-fix

bk-acpi.patch

bk-agpgart.patch

bk-alsa.patch

bk-cifs.patch

bk-cpufreq.patch

bk-driver-core.patch

bk-i2c.patch

bk-input.patch

bk-netdev.patch

bk-ntfs.patch

bk-net-drivers.patch

bk-pci.patch

bk-pcmcia.patch

bk-scsi.patch

bk-serial.patch

bk-usb.patch

mm.patch
  add -mmN to EXTRAVERSION

frame-pointer-based-stack-dumps.patch
  x86: stack dumps using frame pointers

fealnx-bogon-fix.patch
  fealnx.c spinlock fix

bk-driver-core-module-fix.patch
  bk-driver-core-module-fix

acpi-procfs-fix.patch
  acpi procfs fix

writeback_inodes-fix.patch
  Fix writeback_inodes-vs-umount race

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

kgdb-in-sched_functions.patch

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes

kgdb-in-sched_functions-x86_64.patch

wakefunc.patch
  filtered wakeups

wakeup.patch
  filtered wakeups: wakeup enhancements

filtered_page.patch
  filtered wakeups: apply to pagecache functions

filtered_buffer.patch
  filtered wakeups: apply to buffer_head functions

rename-rmap_lock.patch
  rename rmap_lock to page_map_lock

rmap-5-swap_unplug-page-revert.patch
  rmap-5-swap_unplug-page-revert

blk_run_page.patch
  Add blk_run_page()

blk_run_page-swap-fixup.patch
  blk_run_page-swap-fixup

blk_run_page-sync_buffer-revert.patch
  blk_run_page-sync_buffer-revert

rmap-7-object-based-rmap.patch
  rmap 7 object-based rmap

rmap-7-object-based-rmap-sync_page-fix.patch
  rmap-7-object-based-rmap-sync_page-fix

swap-speedups-and-fix.patch
  swap speedups and fix

ia64-rmap-build-fix.patch
  ia64 rmap build fix

rmap-8-unmap-nonlinear.patch
  rmap 8 unmap nonlinear

try_to_unmap_cluster-comment.patch
  try_to_unmap_cluster-comment

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

i_mmap_lock.patch
  Convert i_shared_sem back to a spinlock
  i_mmap_lock fix 1
  i_mmap_lock fix 2
  i_mmap_lock mremap fix

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

unmap_mapping_range-comment.patch
  unmap_mapping_range-comment

rmap-19-arch-prio_tree.patch
  rmap 19: arch prio_tree

rmap-19-arch-prio_tree-parisc.patch
  rmap-19-arch-prio_tree-parisc

vm_area_struct-size-comment.patch
  vm_area_struct size comment

rmapc-comment-style-fixups.patch
  rmap.c comment/style fixups

rmap-20-i_mmap_shared-into-i_mmap.patch
  rmap 20 i_mmap_shared into i_mmap

rmap-20-i_mmap_shared-into-i_mmap-parisc.patch
  rmap-20-i_mmap_shared-into-i_mmap-parisc

rmap-21-try_to_unmap_one-mapcount.patch
  rmap 21 try_to_unmap_one mapcount

rmap-22-flush_dcache_mmap_lock.patch
  rmap 22 flush_dcache_mmap_lock

rmap-22-flush_dcache_mmap_lock-parisc.patch
  rmap-22-flush_dcache_mmap_lock-parisc

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

rmap-33-install_arg_page-vma.patch
  rmap 33 install_arg_page vma

partial-prefetch-for-vma_prio_tree_next.patch
  partial prefetch for vma_prio_tree_next

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

ppc64-uninline-__pte_free_tlb.patch
  ppc64: uninline __pte_free_tlb()

export-clear_pages-on-ppc32.patch
  export clear_pages on ppc32

ppc32-fix-__flush_dcache_icache_phys-for-book-e.patch
  PPC32: Fix __flush_dcache_icache_phys() for Book E

ppc32-fix-copy-prefetch-on-non-coherent-ppcs.patch
  PPC32: Fix copy prefetch on non coherent PPCs

ppc32-add-book-e--ppc44x-specific-exception-support.patch
  PPC32: Add Book E / PPC44x specific exception support

ppc32-add-book-e--ppc44x-specific-exception-support-2.patch
  PPC32: Add Book E / PPC44x specific exception support

ppc32-new-ocp-core-support-updated.patch
  PPC32: New OCP core support (updated)

ppc32-bubinga-405ep-for-new-ocp.patch
  PPC32: Bubinga/405EP for new OCP

ppc32-ppc44x-lib-support.patch
  PPC32: PPC44x lib support

ppc32-ibm-ppc4xx-specific-ocp-support.patch
  PPC32: IBM PPC4xx-specific OCP support

ppc32-4xx-core-fixes-and-440gx-pic-support.patch
  PPC32: 4xx core fixes and 440gx PIC support

ppc32-update-4xx-defconfigs.patch
  PPC32: Update 4xx defconfigs

ppc32-ppc40x-ports-for-new-ocp.patch
  PPC32: PPC40x ports for new OCP

ppc32-ppc44x-ports-for-new-ocp.patch
  PPC32: PPC44x ports for new OCP

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

slab-leak-detector.patch
  slab leak detector
  mm/slab.c warning in cache_alloc_debugcheck_after

local_bh_enable-warning-fix.patch

sched-loadup-roundup.patch
  sched: improved cpu_load rounding

sched-activate-tslt.patch
  sched: fix scheduler for unsynched processor sched_clock

schedstats.patch
  sched: scheduler statistics

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

autofs4-compat-ioctls.patch
  autofs compat ioctls

clean-up-asm-pgalloch-include.patch
  Clean up asm/pgalloc.h include

clean-up-asm-pgalloch-include-2.patch
  Clean up asm/pgalloc.h include

clean-up-asm-pgalloch-include-3.patch
  Clean up asm/pgalloc.h include 3

input-tsdev-fixes.patch
  tsdev.c fixes

fix-scancode-keycode-scancode-conversion-for-265.patch
  Fix scancode->keycode->scancode conversion

use-less-stack-in-ide_unregister.patch
  use less stack in ide_unregister

fealnx-mac-address-and-other-issues.patch
  Fealnx. Mac address and other issues

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

mark-config_mac_serial-drivers-macintosh-macserialc-as-broken.patch
  Mark CONFIG_MAC_SERIAL (drivers/macintosh/macserial.c) as broken

radeon-garbled-screen-fix.patch
  radeonfb: fix garbled screen

neomagic-driver-update.patch
  Neomagic driver update.

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

acpiphp_glue-oops-fix.patch
  acpiphp_glue.c oops fix

clear_backing_dev_congested.patch
  clear_baking_dev_congested

dpt_i2o.patch
  Fix dpt_i2o

allow-i386-to-reenable-interrupts-on-lock-contention.patch
  Allow i386 to reenable interrupts on lock contention

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

module-ref-counting-for-vt-console-drivers.patch
  Module ref counting for vt console drivers

i2o-subsystem-fixing-and-cleanup-for-26-i2o-config-cleanpatch.patch
  I2O subsystem fixing and cleanup for 2.6 - i2o-config-clean.patch

i2o-subsystem-fixing-and-cleanup-for-26-i2o-passthrupatch.patch
  I2O subsystem fixing and cleanup for 2.6 - i2o-passthru.patch

i2o-64-bit-fixes.patch
  i2o: 64-bit fixes

i2o-subsystem-fixing-and-cleanup-for-26-i2o_block-cleanuppatch.patch
  I2O subsystem fixing and cleanup for 2.6 - i2o_block-cleanup.patch

i2o-subsystem-fixing-and-cleanup-for-26-i2o-64-bit-fixpatch.patch
  I2O subsystem fixing and cleanup for 2.6 - i2o-64-bit-fix.patch

i2o-subsystem-fixing-and-cleanup-for-26-i2o-makefile-cleanuppatch.patch
  I2O subsystem fixing and cleanup for 2.6 - i2o-makefile-cleanup.patch

make-4k-stacks-permanent.patch
  make 4k stacks permanent

force-config_regparm-to-y.patch
  Force CONFIG_REGPARM to `y'

ia64-remove-errno-refs.patch
  ia64-remove-errno-refs

missing-closing-n-in-printk.patch
  missing closing n in printk

invalid-notify_changesymlink-in-nfsd.patch
  Invalid notify_change(symlink, [ATTR_MODE]) in nfsd

invalid-notify_changesymlink-in-nfsd-fix.patch
  Fix "Invalid notify_change(symlink, [ATTR_MODE]) in nfsd"

fix-sysfs-symlinks.patch
  fix sysfs symlinks

sysfs-backing-store-sysfs_rename_dir-fix.patch
  sysfs backing store negative dentry hashing fix

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

die_386_graphic.patch
  ia32 oops diagnostic fix

fix-net-tulip-winbond-840c-warning.patch
  fix net/tulip/winbond-840.c warning.

hugetlb_shm_group-sysctl-gid-0-fix.patch
  hugetlb_shm_group-sysctl-gid-0-fix

mlock_group-sysctl.patch
  mlock_group sysctl

nfs_writepage_sync-stack-reduction.patch
  nfs_writepage_sync stack reduction

nfs4-stack-reduction.patch
  nfs4 stack reduction

idr-overflow-fixes.patch
  Fixes for idr code
  idr-overflow-fixes fix
  More fixes for idr code
  Fixes for POSIX timers
  timers-signals-rlimits-setuid-fix
  timers-signals-rlimits-fix
  timers-signals-rlimits-rename-stuff
  idr-overflow-fixes fix
  More fixes for idr code

idr-remove-counter.patch
  idr: remove counter bits from id's

rlim-add-rlimit-entry-for-controlling-queued-signals.patch
  RLIM: add rlimit entry for controlling queued signals

rlim-add-sigpending-field-to-user_struct.patch
  RLIM: add sigpending field to user_struct

rlim-pass-task_struct-in-send_signal.patch
  RLIM: pass task_struct in send_signal()

rlim-add-simple-get_uid-helper.patch
  RLIM: add simple get_uid() helper

rlim-enforce-rlimits-on-queued-signals.patch
  RLIM: enforce rlimits on queued signals

rlim-remove-unused-queued_signals-global-accounting.patch
  RLIM: remove unused queued_signals global accounting

rlim-add-rlimit-entry-for-posix-mqueue-allocation.patch
  RLIM: add rlimit entry for POSIX mqueue allocation

rlim-add-mq_bytes-to-user_struct.patch
  RLIM: add mq_bytes to user_struct

rlim-add-mq_attr_ok-helper.patch
  RLIM: add mq_attr_ok() helper

rlim-enforce-rlimits-for-posix-mqueue-allocation.patch
  RLIM: enforce rlimits for POSIX mqueue allocation

rlim-adjust-default-mqueue-sizes.patch
  RLIM: adjust default mqueue sizes

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

to-fix-i2o_proc-kernel-panic-on-access-of-proc-i2o-iop0-lct.patch
  Fix i2o_proc kernel panic on access of /proc/i2o/iop0/lct

i2o_proc-module-owner-fix.patch
  i2o_proc module owner fix

add-qsort-library-function.patch
  add qsort library function

have-xfs-use-kernel-provided-qsort.patch
  Have XFS use kernel-provided qsort

slabify-iocontext-request_queue.patch
  slabify iocontext + request_queue

slabify-iocontext-request_queue-SLAB_PANIC.patch
  slabify-iocontext-request_queue: use SLAB_PANIC

show-last-kernel-image-symbol-in-proc-kallsyms.patch
  show last kernel-image symbol in /proc/kallsyms

raid-locking-fix.patch
  raid locking fix.

include-aliases-in-kallsyms.patch
  Include Aliases in kallsyms

make-buildcheck.patch
  make buildcheck

make-buildcheck-license-fix.patch
  make buildcheck license fix

efivars-fix.patch
  efivars: check that it's enabled

serial-fifo-size-is-ignored.patch
  serial fifo size is ignored

expose-backing-dev-max-read-ahead.patch
  expose backing dev max read-ahead

ib700wdt-fix.patch
  ib700wdt watchdog driver fix

ib700wdt-fix-2.patch
  ib700wdt watchdog driver fix #2

laptop-doc-bugfix.patch
  laptop-mode documentation fix

create_workqueue-locking-bogon.patch
  create_workqueue locking fix

problem-with-aladdincard-entry-in-parport_pc.patch
  Fix AladdinCard entry in parport_pc

seeky-readahead-speedups.patch
  speed up readahead for seeky loads

watchdog-timer-for-intel-ixp4xx-cpus.patch
  Watchdog timer for Intel IXP4xx CPUs

i810_audio-fixes-from-herbert-xu.patch
  i810_audio fixes from Herbert Xu

ide-diskc-revert-to-previous-24-way-of-handling-flush-cache-commands.patch
  ide-disk.c: revert to previous (2.4) way of handling flush cache commands

update-laptop-mode-control-script-with-xfs_hz=100.patch
  Update laptop mode control script with XFS_HZ=100

del_singleshot_timer_sync.patch
  Add del_single_shot_timer()

del_singleshot_timer_sync-tweaks.patch
  del_singleshot_timer_sync-tweaks

really-ptrace-single-step-2.patch
  ptrace single-stepping fix

dquot_release-oops-workaround.patch
  dquot_release oops workaround

h8-300-update-1-9-bitopsh-add-find_next_bit.patch
  H8/300: bitops.h add find_next_bit

h8-300-update-2-9-ldscripts-fix.patch
  H8/300: ldscripts fix

h8-300-update-3-9-pic-support.patch
  H8/300: pic support

h8-300-update-4-9-preempt-support.patch
  H8/300: preempt support

h8-300-update-5-9-sci-driver-fix.patch
  H8/300: SCI driver fix

h8-300-update-6-9-ne-driver.patch
  H8/300: ne driver

h8-300-update-7-9-kconfig.patch
  H8/300: Kconfig

h8-300-update-8-9-delete-headers.patch
  H8/300: delete headers

h8-300-update-9-9-more-cleanup.patch
  H8/300: more cleanup

calculate-ngroups_per_block-from-page_size.patch
  calculate NGROUPS_PER_BLOCK from PAGE_SIZE

pci-debug-compile-fix-in-sis_router_probe.patch
  PCI debug compile fix in sis_router_probe()

remove-empty-build-of-capabilityo.patch
  security: remove empty build of capability.o

minor-cleanups-in-capabilityc.patch
  security: minor cleanups in capability.c

add-disable-param-to-capabilities-module.patch
  security: add disable param to capabilities module

fix-linux-doc-errors.patch
  fix linux doc errors

fix-block-layer-ioctl-bug.patch
  fix block layer ioctl bug

fix-crash-on-modprobe-ohci1394.patch
  fix crash on `modprobe ohci1394; modprobe -r ohci1394'

x86_64-has-buggy-ffs-implementation.patch
  x86_64 has buggy ffs() implementation

make-reiserfs-not-to-crash-on-oom.patch
  Fix reiserfs oom crash

implement-print_modules.patch
  implement print_modules()

m68k-print_modules.patch
  m68k: use print_modules()

fix-endianess-in-modpost-when-cross-compiling-for-sparc-on-i386.patch
  Fix endianess in modpost when cross-compiling for sparc on i386

fix-cyclades-compile-with-pci.patch
  fix cyclades compile with !PCI

fix-tlanc-for-pci.patch
  fix tlan.c for !PCI

fix-aic7xxx_oldc-for-pci.patch
  fix aic7xxx_old.c for !PCI

powernow-k8-buggy-bios-override-for-266.patch
  Powernow-k8 buggy BIOS override for 2.6.6

x86_64-msr-warning-fix.patch
  x86_64 msr.c warning fix

abs-cleanup.patch
  abs() cleanup


