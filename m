Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWATLQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWATLQQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 06:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWATLQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 06:16:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17353 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750829AbWATLQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 06:16:15 -0500
Date: Fri, 20 Jan 2006 03:15:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc1-mm2
Message-Id: <20060120031555.7b6d65b7.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm2/


- This kernel has a big ACPI update

- reiser3 should be safe(r) to use.


Known problems:

- You'll probably see something like this

Memory: 4017084k/6291456k available (2896k kernel code, 176452k reserved, 1868k data, 208k init)
BUG: sleeping function called from invalid context at kernel/mutex.c:84         in_atomic():1, irqs_disabled():0
Call Trace: <ffffffff8012374e>{__might_sleep+177} <ffffffff803cd7da>{mutex_lock+26}
<ffffffff8016b533>{kmem_cache_create+161} <ffffffff8063b0fb>{free_all_boo


  in early boot.  Please ignore.

- drivers/i2c/busses/scx200_acb.c doesn't compile on architectures which
  don't have asm/msr.h.



Boilerplate:

- -mm kernel commit activity can be reviewed by subscribing to the
  mm-commits mailing list.

        echo "subscribe mm-commits" | mail majordomo@vger.kernel.org

- If you hit a bug in -mm and it's not obvious which patch caused it, it is
  most valuable if you can perform a bisection search to identify which patch
  introduced the bug.  Instructions for this process are at

        http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt

  But beware that this process takes some time (around ten rebuilds and
  reboots), so consider reporting the bug first and if we cannot immediately
  identify the faulty patch, then perform the bisection search.

- When reporting bugs, please try to Cc: the relevant maintainer and mailing
  list on any email.



Changes since 2.6.16-rc1-mm1:


 linus.patch
 git-acpi.patch
 git-agpgart.patch
 git-alsa.patch
 git-audit.patch
 git-blktrace.patch
 git-block.patch
 git-cfq.patch
 git-cpufreq.patch
 git-ia64.patch
 git-infiniband.patch
 git-kbuild.patch
 git-libata-all.patch
 git-netdev-all.patch
 git-ntfs.patch
 git-ocfs2.patch
 git-powerpc.patch
 git-sym2.patch
 git-pcmcia.patch
 git-sas-jg.patch
 git-watchdog.patch

 External trees

-x86_64-fix-mce-exception-stack-for-boot-cpu.patch
-scsi_transport_spi-build-fix.patch
-synclink_gt-fix-size-of-register-value-storage.patch
-dsp_spos_scb_lib-assignment-fix.patch
-sem2mutex-drivers-hwmon.patch
-sem2mutex-i2c-2.patch
-sem2mutex-arch-ia64-ia32-sys_ia32c.patch
-sem2mutex-arch-ia64-kernel-perfmonc.patch
-ia64-eliminate-softlockup-warning.patch
-RT_CACHE_STAT_INC-warning-fix.patch
-net-fix-1.patch
-gregkh-pci-pci-msi-vector-targeting-abstractions-fix.patch
-sem2mutex-drivers-pcmcia.patch
-sem2mutex-drivers-usb.patch
-usb-iomega-umini-is-unusual.patch
-net2280-warning-fix.patch
-auerswald-support-more-tk-devices.patch
-libusual-fix-warning-on-64bit-boxes.patch
-mm-dirty_exceeded-speedup.patch
-mm-dirty_exceeded-speedup-fix.patch
-mm-migration-page-refcounting-fix.patch
-mm-migration-page-refcounting-fix-warning-fix.patch
-mm-migration-page-refcounting-fix-warning-fix-2.patch
-mm-migration-page-refcounting-fix-2.patch
-simplify-migrate_page_add.patch
-zone-reclaim-resurrect-may_swap.patch
-zone-reclaim-reclaim-logic.patch
-zone-reclaim-reclaim-logic-tidy.patch
-zone-reclaim-reclaim-logic-tweaks.patch
-zone-reclaim-proc-override.patch
-sem2mutex-mm-slabc.patch
-numa-policies-in-the-slab-allocator-v2.patch
-mm-optimize-numa-policy-handling-in-slab-allocator.patch
-uml-add-__raw_writel-definition.patch
-uml-move-ldt-creation.patch
-uml-move-libc-dependent-utility-procedures.patch
-uml-move-libc-dependent-time-code.patch
-uml-change-interface-to-boot_timer_handler.patch
-uml-move-headers-to-arch-um-include.patch
-uml-move-libc-dependent-skas-memory-mapping-code.patch
-uml-move-libc-dependent-skas-process-handling.patch
-uml-eliminate-some-globals.patch
-uml-implement-soft-interrupts.patch
-uml-use-setjmp-longjmp-instead-of-sigsetjmp-siglongjmp.patch
-uml-tt-mode-softint-fixes.patch
-uml-remove-leftover-from-patch-revertal.patch
-uml-make-daemon-transport-behave-properly.patch
-uml-networking-clear-transport-specific-structure.patch
-uml-fix-spinlock-recursion-and-sleep-inside-spinlock-in-error-path.patch
-uml-sigio-code-reduce-spinlock-hold-time.patch
-uml-avoid-malloc-to-sleep-in-atomic-sections.patch
-uml-arch-kconfig-menu-cleanups.patch
-uml-allow-again-to-move-backing-file-and-to-override-saved-location.patch
-uml-ubd-code-fix-a-bit-of-whitespace.patch
-prevent-trident-driver-from-grabbing-pcnet32-hardware.patch
-sem2mutex-drivers-macintosh-windfarm_corec.patch
-elevator=as-back-compatibility.patch
-v9fs-add-readpage-support.patch
-fix-sched_setscheduler-semantics.patch
-add-missing-syscall-declarations.patch
-hfs-cleanup-hfsplus-prints.patch
-hfs-cleanup-hfs-prints.patch
-hfs-add-hfsx-support.patch
-hfs-set-correct-ctime.patch
-hfs-set-correct-create-date-for-links.patch
-hfs-set-type-creator-for-symlinks.patch
-edac-atomic-scrub-operations.patch
-edac-drivers-for-amd-76x-and-intel-e750x-e752x.patch
-edac-drivers-for-intel-i82860-i82875.patch
-edac-drivers-for-radisys-82600.patch
-edac-core-edac-support-code.patch
-edac-core-edac-support-code-fix.patch
-edac-with-sysfs-interface-added.patch
-edac-with-sysfs-interface-added-tidy.patch
-edac-swsusp-fixes.patch
-edac-change-default-also-handle-pulled-hardware.patch
-nfsd-check-error-status-from-nfsd_sync_dir.patch
-nfsd-remove-inline-from-a-couple-of-large-nfs-functions.patch
-svcrpc-save-and-restore-the-daddr-field-when-request-deferred.patch
-nfsd4-misc-lock-fixes.patch
-nfsd4-fix-nfsd4_lock-cleanup-on-failure.patch
-nfsd4-rename-lk_stateowner.patch
-nfsd4-remove-release_state_owner.patch
-nfsd4-fix-check_for_locks.patch
-nfsd4-operation-debugging.patch
-svcrpc-gss-handle-the-gss_s_continue.patch
-svcrpc-gss-server-context-init-failure-handling.patch
-svcrpc-gss-svc-context-creation-error-handling.patch
-nfsd4-fix-open-of-recovery-directory.patch
-nfsd4-recovery-lookup-dir-check.patch
-nfsd4-handle-replays-of-failed-open-reclaims.patch
-nfsd4-no-replays-on-unconfirmed-owners.patch
-nfsd4-nfs4statec-miscellaneous-goto-removals.patch
-nfsd4-simplify-process-open1-logic.patch
-nfsd4-dont-create-on-open-that-fails-due-to-err_grace.patch
-nfsd4-fix-open_downgrade.patch
-nfsd4-fix-bug-in-rdattr_error-return.patch
-nfsd4-clean-up-settattr-code.patch
-nfsd-vfsc-endianness-fixes.patch
-nfsd4_truncate-bogus-return-value.patch
-nfserr_serverfault-returned-host-endian.patch
-nfsd4_lock-returns-bogus-values-to-clients.patch
-knfsd-fix-some-more-errno-nfserr-confusion-in-vfsc.patch
-knfsd-provide-missing-nfsv2-part-of-patch-for-checking-vfs_getattr.patch
-exportfs-add-find_acceptable_alias-helper.patch
-vfa-at-functions-core.patch
-vfs-at-functions-i386.patch
-vfs-at-functions-x86_64.patch
-generic-sys_rt_sigsuspend.patch
-generic-sys_rt_sigsuspend-asmlinkage-fix.patch
-handle-tif_restore_sigmask-for-frv.patch
-handle-tif_restore_sigmask-for-i386.patch
-tif_restore_sigmask-support-for-arch-powerpc.patch
-uml-add-tif_restore_sigmask-support.patch
-uml-use-generic-sys_rt_sigsuspend.patch
-add-pselect-ppoll-system-call-implementation.patch
-add-pselect-ppoll-system-call-implementation-rename-types.patch
-add-pselect-ppoll-system-call-implementation-tidy.patch
-add-pselect-ppoll-system-call-implementation-fix.patch
-add-pselect-ppoll-system-calls-on-i386.patch

 Merged

+x86_64-compat_sys_futimesat-fix.patch

 x86_64 fix

+config_isa-does-not-make-sense-for-config_ppc_pseries.patch

 pSeries lacks ISA.

+prototypes-for-at-functions-typo-fix.patch
+prototypes-for-at-functions-typo-fix-fix.patch

 syscalls.h additions.

+knfsd-restore-recently-broken-acl-functionality-to-nfs-server.patch

 knfsd fix

+config_doublefault-kconfig-fix.patch

 Kconfig cleanup

+hdspm-printk-warning-fixes.patch
+pcxhr-printk-warning-fix.patch

 Warning fixes

+git-audit-fixup.patch

 Fix reject due to git-audit.

-sem2mutex-audit_netlink_sem-fix.patch

 Folded into sem2mutex-audit_netlink_sem.patch

+gregkh-driver-drivers-base-proper-prototypes.patch
+gregkh-driver-empty_release_functions_are_broken.patch
-gregkh-driver-aoe-type-cleanups.patch-added-to-mm-tree.patch
-gregkh-driver-aoe-skb_check-cleanup.patch
+gregkh-driver-aoe-update-driver-compatibility-string.patch

 Driver tree updates

+drm-ati-use-null-instead-of-0.patch
+ati_pcigart-simplify-page_count-manipulations.patch

 DRM cleanups

+gregkh-i2c-hwmon-f71805f-add-documentation.patch
+gregkh-i2c-hwmon-f71805f-new-driver.patch
+gregkh-i2c-hwmon-it87-probe-i2c-0x2d-only.patch
-gregkh-i2c-hwmon-f71805f-new-driver.patch
-gregkh-i2c-hwmon-f71805f-add-documentation.patch
+gregkh-i2c-i2c-scx200_acb-01-whitespace.patch
+gregkh-i2c-i2c-scx200_acb-02-debug.patch
+gregkh-i2c-i2c-scx200_acb-03-refactor.patch
+gregkh-i2c-i2c-scx200_acb-04-lock_kernel.patch
+gregkh-i2c-i2c-scx200_acb-05-cs5535.patch
+gregkh-i2c-i2c-scx200_acb-06-poll.patch
+gregkh-i2c-i2c-scx200_acb-07-docs.patch
+gregkh-i2c-hwmon-sensor-attr-array-2.patch
+gregkh-i2c-hwmon-w83792d-use-attr-arrays.patch
+gregkh-i2c-hwmon-w83792d-drop-useless-macros.patch
+gregkh-i2c-i2c-speedup-block-transfers.patch
+gregkh-i2c-i2c-convert-semaphores-to-mutexes-2.patch
+gregkh-i2c-i2c-convert-semaphores-to-mutexes-3.patch
+gregkh-i2c-hwmon-convert-semaphores-to-mutexes.patch
+gregkh-i2c-hwmon-f71805f-convert-semaphore-to-mutex.patch
+gregkh-i2c-hwmon-w83627hf-add-w83687thf-support.patch

 I2C tree updates

+sem2mutex-input-layer-3.patch

 More mutex conversions

+m25p80-printk-warning-fix.patch

 Warning fix

+drivers-mtd-small-cleanups.patch

 MTD cleanups

-git-netdev-all-revert-e1000-changes.patch

 e1000 got fixed.

+kbuild-menu-hide-empty-netdevices-menu-when-net-is-disabled.patch
+tweak-orinoco_cs-debugging-message.patch

 netdev fixlets

-gregkh-pci-pci-msi-vector-targeting-abstractions.patch
-gregkh-pci-pci-per-platform-ia64_-first-last-_device_vector-definitions.patch
+gregkh-pci-powerpc-pci-hotplug-remove-rpaphp_find_bus.patch
+gregkh-pci-powerpc-pci-hotplug-remove-rpaphp_fixup_new_pci_devices.patch
+gregkh-pci-powerpc-pci-hotplug-merge-config_pci_adapter.patch
+gregkh-pci-powerpc-pci-hotplug-remove-remove_bus_device.patch
+gregkh-pci-powerpc-pci-hotplug-de-convolute-rpaphp_unconfig_pci_adap.patch
+gregkh-pci-powerpc-pci-hotplug-merge-rpaphp_enable_pci_slot.patch
+gregkh-pci-powerpc-pci-hotplug-cleanup-add-prefix.patch
+gregkh-pci-powerpc-pci-hotplug-minor-cleanup-forward-decls.patch
+gregkh-pci-powerpc-pci-hotplug-shuffle-error-checking-to-better-location.patch
+gregkh-pci-pci-cyblafb-remove-pci_module_init-return-really.patch
+gregkh-pci-msi-vector-targeting-abstractions.patch
+gregkh-pci-per-platform-ia64_-first-last-_device_vector-definitions.patch
+gregkh-pci-altix-msi-support.patch

 PCI tree updates

+git-pcmcia-orinoco_cs-fix.patch

 git-pcmcia fix

+megaraid-unused-variable.patch

 Warning fix

+drivers-scsi-aic7xxx-possible-cleanups.patch
+module_alias_blockchardev_major-for-drivers-scsi.patch

 SCSI cleanups and fix.

+gregkh-usb-usb-remove-misc-devfs-droppings.patch
+gregkh-usb-usb-net2280-warning-fix.patch
+gregkh-usb-add-might_sleep-to-usb_unlink_urb.patch
+gregkh-usb-usb-add-new-pl2303-device-ids.patch
+gregkh-usb-usb-cp2101-add-new-device-ids.patch
+gregkh-usb-usb-arm26-fix-compilation-of-drivers-usb-core-message.c.patch
+gregkh-usb-usbatm-trivial-modifications.patch
+gregkh-usb-usbatm-add-flags-field.patch
+gregkh-usb-usbatm-remove-.owner.patch
+gregkh-usb-usbatm-kzalloc-conversion.patch
+gregkh-usb-usbatm-xusbatm-rewrite.patch
+gregkh-usb-usbatm-shutdown-open-connections-when-disconnected.patch
+gregkh-usb-usbatm-return-correct-error-code-when-out-of-memory.patch
+gregkh-usb-usbatm-use-dev_kfree_skb_any-rather-than-dev_kfree_skb.patch
+gregkh-usb-usbatm-measure-buffer-size-in-bytes-force-valid-sizes.patch
+gregkh-usb-usbatm-allow-isochronous-transfer.patch
+gregkh-usb-usbatm-handle-urbs-containing-partial-cells.patch
+gregkh-usb-usbatm-bump-version-numbers.patch
+gregkh-usb-usbatm-eilseq-workaround.patch
+gregkh-usb-usbatm-semaphore-to-mutex-conversion.patch
+gregkh-usb-ueagle-add-iso-support.patch
+gregkh-usb-ueagle-cosmetic.patch
+gregkh-usb-ueagle-cmv-name-bug.patch
+gregkh-usb-usb-add-new-auerswald-device-ids.patch
+gregkh-usb-usb-libusual-fix-warning-on-64bit-boxes.patch
+gregkh-usb-usb-core-and-hcds-don-t-put_device-while-atomic.patch

 USB tree updates

+usb-yealink-printk-warning-fixes.patch
+usb-usbip-warning-fixes.patch

 Warning fixes

+x86_64-defconfig-update.patch
+x86_64-config-unwind-info.patch
+x86_64-vsyscall-patch-xen.patch
+x86_64-nmi-kprobes.patch
+x86_64-apic-main-timer.patch
+x86_64-apic-main-timer-default.patch
+x86_64-timer-resume.patch

 x86_64 tree update

+hrtimers-fixup-itimer-conversion.patch
+hrtimers-fix-possible-use-of-null-pointer-in.patch
+hrtimers-fix-oldvalue-return-in-setitimer.patch
+hrtimers-fix-posix-timer-requeue-race.patch
+hrtimers-cleanups-and-simplifications.patch
+hrtimers-add-back-lost-credit-lines.patch
+hrtimers-set-correct-initial-expiry-time-for-relative.patch
+hrtimers-set-correct-initial-expiry-time-for-relative-fix.patch

 hrtimers fixes

+optimize-off-node-performance-of-zone-reclaim.patch
+zone_reclaim-reclaim-on-memory-only-node-support.patch
+gfp_zonetypes-add-commentry-on-how-to-calculate.patch
+gfp_zonetypes-calculate-from-gfp_zonemask.patch
+mm-improve-function-of-sc-may_writepage.patch

 mm fixes and updates.

+produce-useful-info-for-kzalloc-with-debug_slab.patch

 Make kzalloc() play properly with slab debugging

+dump_stack-in-oom.patch

 Do a stack dump in oom-killings.

+selinux-fix-and-cleanup-mprotect-checks.patch
+selinux-change-file_alloc_security-to-use-gfp_kernel.patch

 SELinux updates

+i386-multi-column-stack-backtraces-update.patch

 Make the x86 stack dumps default to two columns.

+i386-print-kernel-version-in-register.patch

 Print build number in oopses.

+arm26-fix-find_first_zero_bit-related-warnings.patch
+arm26-fix-warnings-about-nr_irqs-being-not-defined.patch
+arm26-remove-irq_exit-from-hardirqh.patch
+arm26-select-system-type-via-choice.patch
+arm26-fixup-get_signal_to_deliver-call.patch
+arm26-fixup-asm-statement-in-kernel-fiqc.patch
+arm26-drop-local-task_running-copy.patch
+arm26-drop-first-arg-of-prepare_arch_switch-finish_arch_switch.patch
+arm26-add-__kernel_old_dev_t-for-nfsd.patch
+arm26-select-blk_dev_fd-only-on-a5k.patch

 arm25 fixes

+efi-dev-mem-simplify-efi_mem_attribute_range.patch
+ia64-ioremap-check-efi-for-valid-memory-attributes.patch
+ia64-ioremap-check-efi-for-valid-memory-attributes-fix.patch
+dmi-only-ioremap-stuff-we-actually-need.patch
+efi-keep-physical-table-addresses-in-efi-structure.patch
+acpi-clean-up-memory-attribute-checking-for-map-read-write.patch

 ia64/DMI work.

+uml-typo-fixup.patch
+uml-comments-about-libc-conflict-guards.patch
+uml-fix-hugest-stack-users.patch
+uml-fix-apples-bananas-typo.patch
+uml-tt-syscall_debug-fix-buglet-introduced-in-cleanup.patch
+uml-skas0-hold-own-ldt-fixups-for-x86-64.patch
+uml-some-harmless-sparse-warning-fixes.patch
+uml-avoid-config_nr_cpus-undeclared-bogus-error-messages.patch

 UML updates

+s390-build-dasd_cmd-into-dasd_mod.patch
+s390-dasd-remove-dynamic-ioctl-registration.patch
+s390-remove-cvs-generated-information.patch
+s390-overflow-in-sched_clock.patch
+s390-monotonic_clock-interface.patch
+s390-hangcheck-timer-support.patch
+s390-ccw_device_probe_console-return-value.patch
+s390-dasd-open-counter.patch
+s390-dasd-wait-for-clear-i-o-interrupt.patch

 s390 updates

+work-around-ppc64-bootup-bug-by-making-mutex-debugging-save-restore-irqs.patch

 Don't accidentally enable interrupts in mutex debugging code: powerpc falls
 over.

+kernel-kernel-cpuc-to-mutexes.patch

 Bring back this mutex conversion.

+sbc-epx-does-not-check-claim-i-o-ports-it-uses-2nd-edition-fix.patch

 Fix watchdog driver

+parport-fix-printk-format-warning.patch
+dvb-fix-printk-format-warning.patch

 Warning fixes

+fix-cpucontrol-cache_chain_mutex-lock-inversion-bug.patch

 Fix deadlock.

+make-bug-messages-more-consistent.patch
+make-bug-messages-more-consistent-update.patch

 Make the bug messages say "BUG:"

+add-trylock_kernel.patch
+add-trylock_kernel-fix.patch

 More workarounds for the enabling of might_sleep() debugging in early boot.

+turn-on-might_sleep-in-early-bootup-code-too.patch

 Enable might_sleep() debugging in early boot.

+dont-allow-users-to-set-config_broken=y.patch

 CONFIG_BROKEN really means it.

+kill-_inline_.patch

 Remove _INLINE_

+pause_on_oops-command-line-option.patch

 I wrote a patch!  If your oopses are scrolling off the screen, add
 `pause_on_oops=100000' to the kernel boot command line.

+pnpbios-missing-small_tag_enddep-tag.patch

 pnpbios fix.

+fix-i2o_scsi-oops-on-abort.patch

 i2o driver fix

+build_lock_ops-cleanup-preempt_disable-usage.patch

 spinlock speedup

+tpm_infineon-fix-printk-format-warning.patch
+tpm_bios-needs-more-securityfs_-functions.patch
+tpm_bios-securityfs-error-checking-fix.patch
+tpm_bios-indexing-fix.patch

 tpm driver fixes

+someone-broke-reiserfs-v3-mount-options-this-fixes-it.patch

 Fix reiser3 mount option handling.

+parport_serial-printk-warning-fix.patch
+quota_v2-printk-warning-fixes.patch
+sxc-printk-warning-fixes.patch

 Warning fixes.

+autofs4-lookup-white-space-cleanup.patch
+autofs4-use-libfs-routines-for-readdir.patch
+autofs4-cant-mount-due-to-mount-point-dir-not-empty.patch
+autofs4-expire-code-readability-cleanup.patch
+autofs4-simplify-expire-tree-traversal.patch
+autofs4-fix-false-negative-return-from-expire.patch
+autofs4-expire-mounts-that-hold-no-extra-references-only.patch
+autofs4-expire-mounts-that-hold-no-extra-references-only-fix.patch
+autofs4-remove-update_atime-unused-function.patch
+autofs4-add-a-show-mount-options-for-proc-filesystem.patch
+autofs4-white-space-cleanup-for-waitqc.patch
+autofs4-rename-simple_empty_nolock-function.patch
+autofs4-change-may_umount-functions-to-boolean.patch
+autofs4-increase-module-version.patch

 Autofs4 updates.

-reiserfs-fix-is_reusable-bitmap-check-to-not-traverse-the-bitmap-info-array.patch
-reiserfs-clean-up-bitmap-block-buffer-head-references.patch
-reiserfs-move-bitmap-loading-to-bitmapc.patch
-reiserfs-on-demand-bitmap-loading.patch
-reiserfs-on-demand-bitmap-loading-fix.patch
-reiserfs-on-demand-bitmap-loading-warning-fix.patch

 Dropped - baaaad.

+ext3-get-blocks-multiple-block-allocation-cleanup.patch

 Tidy ext3-get-blocks-multiple-block-allocation.patch

-powerpc-fastpaths-for-mutex-subsystem.patch

 Dropped.

+x86-blacklist-tsc-from-systems-where-it-is-known-to-be-bad.patch

 Work around dodgy TSCs

+kernel-kprobesc-fix-a-warning-ifndef-arch_supports_kretprobes.patch

 Warning fix.

+dlm-recovery-remove-true-false-defines.patch
+dlm-device-interface-missing-variable.patch
+dlm-device-interface-check-allocation.patch
+dlm-device-interface-fix-unlock-race.patch
+dlm-device-interface-use-kzalloc.patch
+dlm-sem2mutex.patch

 DLM updates.

+drivers-ide-ide-ioc-make-__ide_end_request-static.patch

 IDE cleanup

+epoll_pwait.patch

 epoll feature addition (controversial).

+documentation-ioctl-messtxt-update.patch

 ioctl() documentation update.




All 761 patches:


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm2/patch-list


