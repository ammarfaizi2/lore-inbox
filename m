Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVATFl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVATFl5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 00:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVATFl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 00:41:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:59058 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262053AbVATFin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 00:38:43 -0500
Date: Wed, 19 Jan 2005 21:38:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc1-mm2
Message-Id: <20050119213818.55b14bb0.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc1/2.6.11-rc1-mm2/

- There are a bunch of ioctl() and compat_ioctl() changes in here which seem
  to be of dubious maturity.  Could people involved in this area please
  review, test and let me know?

- A revamp of the kexec and crashdump patches.  Anyone who is interested in
  this work, please help to get this ball rolling a little faster?

- This kernel isn't particularly well-tested, sorry.  I've been a bit tied
  up with other stuff.



Changes since 2.6.11-rc1-mm1:


 linus.patch
 bk-arm.patch
 bk-cifs.patch
 bk-drm.patch
 bk-drm-via.patch
 bk-ide-dev.patch
 bk-input.patch
 bk-dtor-input.patch
 bk-kbuild.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-xfs.patch

 Latest versions of various BK trees.

-sparc64-nodemask-build-fix.patch
-selinux-fix-error-handling-code-for-policy-load.patch
-generic-irq-code-missing-export-of-probe_irq_mask.patch
-infiniband-ipoib-use-correct-static-rate-in-ipoib.patch
-infiniband-mthca-trivial-formatting-fix.patch
-infiniband-mthca-support-rdma-atomic-attributes-in-qp-modify.patch
-infiniband-mthca-clean-up-allocation-mapping-of-hca-context-memory.patch
-infiniband-mthca-add-needed-rmb-in-event-queue-poll.patch
-infiniband-core-remove-debug-printk.patch
-infiniband-make-more-code-static.patch
-infiniband-core-set-byte_cnt-correctly-in-mad-completion.patch
-infiniband-core-add-qp-number-to-work-completion-struct.patch
-infiniband-core-add-node_type-and-phys_state-sysfs-attrs.patch
-infiniband-mthca-clean-up-computation-of-hca-memory-map.patch
-infiniband-core-fix-handling-of-0-hop-directed-route-mads.patch
-infiniband-core-add-more-parameters-to-process_mad.patch
-infiniband-core-add-qp_type-to-struct-ib_qp.patch
-infiniband-core-add-ib_find_cached_gid-function.patch
-infiniband-update-copyrights-for-new-year.patch
-infiniband-ipoib-move-structs-from-stack-to-device-private-struct.patch
-infiniband-core-rename-handle_outgoing_smp.patch
-mark-page-accessed-in-filemapc-not-quite-right.patch
-restore-net-sched-iptc-after-iptables-kmod-cleanup.patch
-ppc32-fix-mpc8272ads.patch
-ppc32-add-freescale-pq2fads-support.patch
-ppc64-make-hvlpevent_unregisterhandler-work.patch
-ppc64-make-iseries_veth-call-flush_scheduled_work.patch
-ppc64-iommu-avoid-isa-io-space-on-power3.patch
-frv-remove-mandatory-single-step-debugging-diversion.patch
-frv-excess-whitespace-cleanup.patch
-x86_64-i386-increase-command-line-size.patch
-x86_64-add-brackets-to-bitops.patch
-x86_64-move-early-cpu-detection-earlier.patch
-x86_64-disable-uselib-when-possible.patch
-x86_64-optimize-nodemask-operations-slightly.patch
-x86_64-fix-a-bug-in-timer_suspend.patch
-x86-consolidate-code-segment-base-calculation.patch
-swsusp-more-small-fixes.patch
-swsusp-dm-use-right-levels-for-device_suspend.patch
-swsusp-update-docs.patch
-acpi-comment-whitespace-updates.patch
-make-suspend-work-with-ioapic.patch
-swsusp-refrigerator-cleanups.patch
-uml-avoid-null-dereference-in-linec.patch
-uml-readd-config_magic_sysrq-for-uml.patch
-uml-commentary-addition-to-recent-sysemu-fix.patch
-uml-drop-unused-buffer_headh-header-from-hostfs.patch
-uml-delete-unused-header-umnh.patch
-uml-commentary-about-sigwinch-handling-for-consoles.patch
-uml-fail-xterm_open-when-we-have-no-display.patch
-uml-depend-on-usermode-in-drivers-block-kconfig-and-drop-arch-um-kconfig_block.patch
-uml-makefile-simplification-and-correction.patch
-uml-fix-compilation-for-missing-headers.patch
-uml-fix-some-uml-own-initcall-macros.patch
-uml-refuse-to-run-without-skas-if-no-tt-mode-in.patch
-uml-for-ubd-cmdline-param-use-colon-as-delimiter.patch
-uml-allow-free-ubd-flag-ordering.patch
-uml-move-code-from-ubd_user-to-ubd_kern.patch
-uml-fix-and-cleanup-code-in-ubd_kernc-coming-from-ubd_userc.patch
-uml-add-stack-content-to-dumps.patch
-uml-add-stack-addresses-to-dumps.patch
-uml-update-ld-scripts-to-newer-binutils.patch
-reintroduce-export_symboltask_nice-for-binfmt_elf32.patch
-csum_and_copy_from_user-gcc4-warning-fixes.patch
-csum_and_copy_from_user-gcc4-warning-fixes-m32r-fix.patch
-smbfs-fixes.patch
-fixups-for-block2mtd.patch
-lock-initializer-cleanup-networking.patch
-ext3-ea-revert-cleanup.patch
-ext3-ea-revert-old-ea-in-inode.patch
-ext3-ea-mbcache-cleanup.patch
-ext2-ea-race-in-ext-xattr-sharing-code.patch
-ext3-ea-ext3-do-not-use-journal_release_buffer.patch
-ext3-ea-ext3-factor-our-common-xattr-code-unnecessary-lock.patch
-ext3-ea-ext-no-spare-xattr-handler-slots-needed.patch
-ext3-ea-cleanup-and-prepare-ext3-for-in-inode-xattrs.patch
-ext3-ea-hide-ext3_get_inode_loc-in_mem-option.patch
-ext3-ea-in-inode-extended-attributes-for-ext3.patch
-ioctl-rework-2.patch
-ioctl-rework-2-fix.patch
-make-standard-conversions-work-with-compat_ioctl.patch
-fget_light-fput_light-for-ioctls.patch
-macros-to-detect-existance-of-unlocked_ioctl-and-ioctl_compat.patch
-fix-coredump_wait-deadlock-with-ptracer-tracee-on-shared-mm.patch
-fix-race-between-core-dumping-and-exec.patch
-fix-exec-deadlock-when-ptrace-used-inside-the-thread-group.patch
-ptrace-unlocked-access-to-last_siginfo-resending.patch
-clear-false-pending-signal-indication-in-core-dump.patch
-pcmcia-remove-irq_type_time.patch
-pcmcia-ignore-driver-irq-mask.patch
-pcmcia-remove-irq_mask-and-irq_list-parameters-from-pcmcia-drivers.patch
-pcmcia-use-irq_mask-to-mark-irqs-as-unusable.patch
-pcmcia-remove-racy-try_irq.patch
-pcmcia-modify-irq_mask-via-sysfs.patch
-pcmcia-remove-includes-in-rsrc_mgr-which-arent-necessary-any-longer.patch
-mpsc-driver-patch.patch
-fbdev-cleanup-broken-edid-fixup-code.patch
-fbcon-catch-blank-events-on-both-device-and-console-level.patch
-fbcon-fix-compile-error.patch
-fbdev-fbmon-cleanup.patch
-i810fb-module-param-fix.patch
-atyfb-fix-module-parameter-descriptions.patch
-radeonfb-fix-init-exit-section-usage.patch
-pxafb-reorder-add_wait_queue-and-set_current_state.patch
-sa1100fb-reorder-add_wait_queue-and-set_current_state.patch
-backlight-add-backlight-lcd-device-basic-support.patch
-fbdev-add-w100-framebuffer-driver.patch
-fix-typo-in-arch-i386-kconfig.patch
-random-whitespace-doh.patch
-random-entropy-debugging-improvements.patch
-random-run-time-configurable-debugging.patch
-random-periodicity-detection-fix.patch
-random-add_input_randomness.patch
-various-kconfig-fixes.patch

 Merged

+acpi-build-fix-99.patch

 Fix ACPi build

+mips-default-mlock-limit-fix.patch

 MIPS rlimit fix

+shared_policy_replace-fix.patch

 mempolicy fix

+generic_file_buffered_write-handle-partial-dio.patch

 direct-io fix

+cputimeh-seems-to-assume-hz==1000.patch

 partial cputime fix

+ppc32-fix-pmac-kernel-build-with-oprofile.patch

 ppc32 build fix

+spinlocking-fixes.patch

 Fix the rwlock_is_locked snafu - still needs work.

+fix-config_agp-depencies.patch

 AGP Kconfig fix

+ioctl-compatibility-for-tiocmiwait-and-tiocgicount.patch

 Additional compat ioctls

+cls_api-build-fix.patch

 Net build fix

+acpi-sleep-while-atomic-during-s3-resume-from-ram.patch

 Fix sleep-in-spinlock in ACPI

+alsa-conversion-to-compat_ioctl-kconfig.patch
+alsa-conversion-to-compat_ioctl-alsa-pcm-api.patch
+alsa-conversion-to-compat_ioctl-alsa-apis.patch

 ALSA ioctl updates

+ac97-audio-support-for-intel-ich7-2611-rc1.patch

 New audio PCI ID

+disable-sidewinder-debug-messages.patch

 Kill noisy debug

+prevent-pci_name_bus-buffer-overflows.patch

 Avoid possible buffer overruns

+scsi-ncr53c9x-fixes.patch
+maintainers-add-entry-for-qla2xxx-driver.patch

 SCSI fixes

+swapspace-layout-improvements.patch

 Rework the way in which we lay out swapspace.

+uninline-mod_page_state.patch

 Code uninlining

+fix-audit-control-message-checks.patch
+fix-audit-control-message-checks-tidy.patch

 audit+security system fixes

+selinux-add-netlink-message-types-for-the-tc-action-code.patch

 SELinux update

+ppc32-pmac-sleep-support-update.patch
+add-try_acquire_console_sem.patch
+update-aty128fb-sleep-wakeup-code-for-new-powermac-changes.patch
+radeonfb-massive-update-of-pm-code.patch
+radeonfb-build-fix.patch
+ppc32-update-cpu-state-save-restore.patch
+ppc32-add-missing-prototype.patch
+ppc32-system-platform_device-description-discovery-and-management.patch
+ppc32-infrastructure-changes-to-mpc85xx-sub-arch-from-ocp-to-platform_device.patch
+ppc32-convert-boards-from-using-ocp-to-platform_device.patch
+ppc32-convert-gianfar-ethernet-driver-from-using-an-ocp-to-platform_device.patch
+ppc32-remove-cli-sti-in-arch-ppc-4xx_io-serial_siccc.patch
+ppc32-remove-cli-sti-in-arch-ppc-8xx_io-cs4218_tdmc.patch
+ppc32-remove-cli-sti-in-arch-ppc-8xx_io-fecc.patch
+ppc32-remove-cli-sti-in-arch-ppc-platforms-apus_setupc.patch
+ppc32-remove-cli-sti-in-arch-ppc-platforms-pal4_setupc.patch
+ppc32-remove-cli-sti-in-arch-ppc-syslib-m8xx_setupc.patch
+ppc32-remove-cli-sti-in-arch-ppc-syslib-qspan_pcic.patch
+ppc32-mpc8xx-tlb-miss-vs-tlb-error-fix.patch
+ppc32-update_process_times-simplification.patch
+ppc32-add-defconfigs-for-85xx-boards.patch

 ppc32 and radeon driver updates

+ppc64-remove-config_irq_all_cpus.patch
+ppc64-pci-eeh-documentation.patch
+ppc64-ppc-cleanup-pci-skipping.patch
+ppc64-minimum-hashtable-size.patch
+ppc64-remove-some-unused-iseries-functions.patch

 ppc64 update

+fix-xenu-kernel-crash-in-dmi_iterate.patch

 Check ioremap return value.

+x86-use-cpumask_t-instead-of-unsigned-long.patch

 cpumask fix

+i386-init_intel_cacheinfo-can-be-__init.patch

 Add an __init

+x86-no-interrupts-from-secondary-cpus-until-officially-online.patch

 Fix x86 secondary CPU startup race

+arch-i386-kernel-signalc-fix-err-test-twice.patch

 Simplify x86 signal handling code

+fix-num_online_nodes-warning-on-numa-q.patch

 Fix NUMA warning

+x86_64-fix-cmp-with-interleaving.patch
+x86_64-fix-flush-race-on-context-switch.patch
+i386-x86-64-fix-smp-nmi-watchdog-race.patch
+x86-64-fix-pud-typo-in-ioremap.patch
+x86-64-fix-do_suspend_lowlevel.patch
+x86-64-clean-up-cpuid-level-detection.patch
+kprobes-x86_64-memory-allocation-changes.patch

 x86_64 updates

+h8-300-defconfig-update.patch
+h8-300-mm-update.patch

 h8/300 update

+swsusp-remove-on2-algorithm-in-page-relocation.patch
+driver-model-pass-pm_message_t-down-to-pci-drivers.patch

 swsusp/PM update

+uml-provide-an-arch-specific-define-for-register-file-size.patch
+uml-provide-some-initcall-definitions-for-userspace-code.patch
+uml-provide-a-release-method-for-the-ubd-driver.patch
+uml-allow-ubd-devices-to-provide-partial-end-blocks.patch
+uml-change-for_each_cpu-to-for_each_online_cpu.patch
+uml-eliminate-unhandled-sigprof-on-halt.patch
+uml-fix-__pud_alloc-definition-to-match-the-declaration.patch
+uml-fix-a-stack-corruption-crash.patch
+uml-define-__have_arch_cmpxchg-on-x86.patch

 UML update

+radio-typhoon-use-correct-module_param-data-type.patch

 module_param fix

+cleanup-vc-array-access.patch
+remove-console_macrosh.patch
+merge-vt_struct-into-vc_data.patch

 Console code cleanup

+avoid-sparse-warning-due-to-time-interpolator.patch

 sparse fix

+allow-all-architectures-to-set-config_debug_preempt.patch

 CONFIG_DEBUG_PREEMPT is now kernel-wide

+binfmt_elf-allow-mips-to-overrid-e_flags.patch

 mips build fix

+remove-bogus-softirq_pending-usage-in-cris.patch

 cris cleanup

+switch-frw-to-use-local_soft_irq_pending.patch

 Use local_softirq_pending() in arch/FRV

+kill-softirq_pending.patch

 Remove softirq_pending().  This breaks net/core/pktgen.c.

+scripts-referencepl-treat-built-ino-as-conglomerate.patch

 reference.pl fix

+vgacon-fixes-to-help-font-restauration-in-x11.patch

 Make vgacon play nicer with X

+clean-up-uts_release-usage.patch

 Remove some UTS_RELEASE usages

+use-official-unicodes-for-dec-vt-characters.patch

 console unicode fix

+ext3-commit-superblock-before-panicking.patch

 panic later on in ext3_panic()

+consolidate-arch-specific-resourceh-headers.patch

 Common-up the reqource.h implementations

+use-wno-pointer-sign-for-gcc-40.patch

 Avoid some gcc-4 warnings

+3c59x-ethtool-provide-nic-specific-stats.patch

 3com driver ethtool fixes

+fix-init_sighand-warning-on-mips.patch

 MIPS warning fix

+add-page_offset-to-mmh.patch

 Add kernel-wide page_offset() helper.

+minor-ipmi-driver-updates.patch

 IPMI driver update

+ext3-ea-no-lock-needed-when-freeing-inode.patch
+ext3-ea-set-the-ext3_feature_compat_ext_attr-for-in-inode-xattrs.patch
+ext3-ea-documentation-fix.patch
+ext3-ea-fix-i_extra_isize-check.patch
+ext3-ea-disallow-in-inode-attributes-for-reserved-inodes.patch

 ext3/extended attribute fixes

+completion-api-additions.patch

 Add some additional completion functions.

+convert-xfs-to-unlocked_ioctl-and-compat_ioctl.patch
+some-fixes-for-compat-ioctl.patch
+convert-infiniband-mad-driver-to-compat-unlocked_ioctl.patch
+support-compat_ioctl-for-block-devices.patch
+convert-cciss-to-compat_ioctl.patch
+add-compat_ioctl-to-frame-buffer-layer.patch
+convert-sis-fb-driver-to-compat_ioctl.patch
+convert-dv1394-driver-to-compat_ioctl.patch
+convert-video1394-driver-to-compat_ioctl.patch
+convert-amdtp-driver-to-compat_ioctl.patch

 Update various ioctl(), compat-ioctl() and actual ioctl)( implementation code

+random-pt2-cleanup-waitqueue-logic-fix-missed-wakeup.patch
+random-pt2-kill-pool-clearing.patch
+random-pt2-combine-legacy-ioctls.patch
+random-pt2-re-init-all-pools-on-zero.patch
+random-pt2-simplify-initialization.patch
+random-pt2-kill-memsets-of-static-data.patch
+random-pt2-kill-dead-extract_state-struct.patch
+random-pt2-kill-22-compat-waitqueue-defs.patch
+random-pt2-kill-redundant-rotate_left-definitions.patch
+random-pt2-kill-misnamed-log2.patch
+random-pt3-more-meaningful-pool-names.patch
+random-pt3-static-allocation-of-pools.patch
+random-pt3-static-sysctl-bits.patch
+random-pt3-catastrophic-reseed-checks.patch
+random-pt3-entropy-reservation-accounting.patch
+random-pt3-reservation-flag-in-pool-struct.patch
+random-pt3-reseed-pointer-in-pool-struct.patch
+random-pt3-break-up-extract_user.patch
+random-pt3-remove-dead-md5-copy.patch
+random-pt3-simplify-hash-folding.patch
+random-pt3-clean-up-hash-buffering.patch
+random-pt3-remove-entropy-batching.patch

 random driver cleanups and fixes

+fat-kill-fatfs_symsc.patch
+fat-merge-msdos_fs_isbh-into-msdos_fsh.patch
+fat-is_badchar-is_replacechr-is_skipchar-cleanup.patch
+fat-is_badchar-is_replacechr-is_skipchar-cleanup-cleanup.patch
+fat-return-better-error-codes-from.patch
+fat-manually-inline-shortname_info_to_lcase.patch
+fat-use-vprintk-instead-of-snprintf-with-static.patch
+fat-kill-unnecessary-kmap.patch
+fat-fs-fat-cachec-make-__fat_access-static.patch
+fat-lindent-fs-msdos-nameic.patch
+fat-lindent-fs-vfat-nameic.patch
+fat-lindent-fs-vfat-nameic-fix.patch
+fat-fs-fat-cleanup.patch
+fat-reserved-clusters-cleanup.patch
+fat-show-current-nls-config-even-if-its-default.patch

 fatfs update

+relayfs-remove-klog-debugging-channel.patch
+relayfs-remove-klog-debugging-channel-headers.patch

 remove the log stuff from relayfs

+fix-loss-of-records-on-size-4096-in-proc-pid-maps.patch
+speedup-proc-pid-maps-fix-fix-fix-fix.patch

 More work on the /proc/pid/maps speedup

+pcmcia-tcic-eleminate-deprecated-check_region.patch
+pcmcia-i82365-use-config_pnp-instead-of-__isapnp__.patch
+pcmcia-i82092-fix-checking-of-return-value-from-request_region.patch
+pcmcia-socket-acregion-are-unused.patch
+pcmcia-use-unsigned-long-for-io-port-address.patch

 small pcmcia updates

+nfs-fix_vfsflock.patch
+nfs-flock.patch

 BSD flocking for the NFS client.

+sched-isochronous-class-for-unprivileged-soft-rt-scheduling.patch

 Add SCHED_ISO

-assign_irq_vector-section-fix.patch
-kexec-i8259-shutdowni386.patch
-kexec-i8259-shutdown-x86_64.patch
-kexec-apic-virtwire-on-shutdowni386patch.patch
-kexec-apic-virtwire-on-shutdownx86_64.patch
-kexec-ioapic-virtwire-on-shutdowni386.patch
-kexec-apic-virt-wire-fix.patch
-kexec-ioapic-virtwire-on-shutdownx86_64.patch
-kexec-e820-64bit.patch
+x86-rename-apic_mode_exint.patch
+x86-local-apic-fix.patch
+x86_64-e820-64bit.patch
+x86-i8259-shutdown.patch
+x86_64-i8259-shutdown.patch
+x86-apic-virtwire-on-shutdown.patch
+x86_64-apic-virtwire-on-shutdown.patch
+vmlinux-fix-physical-addrs.patch
+x86-vmlinux-fix-physical-addrs.patch
+x86_64-vmlinux-fix-physical-addrs.patch
+x86_64-entry64.patch
+x86-config-kernel-start.patch
+x86_64-config-kernel-start.patch
-kexec-ide-spindown-fix.patch
-kexec-ifdef-cleanup.patch
-kexec-machine_shutdownx86_64.patch
-kexec-kexecx86_64.patch
-kexec-kexecx86_64-4level-fix.patch
-kexec-kexecx86_64-4level-fix-unfix.patch
-kexec-machine_shutdowni386.patch
-kexec-kexeci386.patch
-kexec-use_mm.patch
-kexec-loading-kernel-from-non-default-offset.patch
-kexec-loading-kernel-from-non-default-offset-fix.patch
-kexec-enabling-co-existence-of-normal-kexec-kernel-and-panic-kernel.patch
+x86-machine_shutdown.patch
+x86-kexec.patch
+x86-crashkernel.patch
+x86_64-machine_shutdown.patch
+x86_64-kexec.patch
+x86_64-crashkernel.patch
+x86-crash_shutdown-nmi-shootdown.patch
+x86-crash_shutdown-snapshot-registers.patch
+x86-crash_shutdown-apic-shutdown.patch
-crashdump-memory-preserving-reboot-using-kexec-fix.patch
-kdump-config_discontigmem-fix.patch
-crashdump-routines-for-copying-dump-pages-kmap-fiddle.patch
-crashdump-kmap-build-fix.patch
-crashdump-register-snapshotting-before-kexec-boot.patch
-crashdump-minor-bug-fixes-to-kexec-crashdump-code.patch
-crashdump-cleanups-to-the-kexec-based-crashdump-code.patch
-x86-rename-apic_mode_exint.patch
-x86-local-apic-fix.patch

 Big kexec/crashdump update

+radeonfb-set-accelerator-id.patch
+vesafb-change-return-error-id.patch
+intelfb-workaround-for-830m.patch
+fbcon-save-blank-state-last.patch
+backlight-fix-compile-error-if-config_fb-is-unset.patch
+matroxfb-fb_matrox_g-kconfig-changes.patch

 fbdev/fbcon updates

+include-type-information-as-module-info-where-possible.patch

 include type info in module parameter wrappers

-waiting-10s-before-mounting-root-filesystem.patch

 This broke stuff

+fuse-make-two-functions-static.patch
+fuse-fix-variable-with-confusing-name.patch
+fuse-dont-check-against-zero-fsuid.patch
+fuse-remove-mount_max-and-user_allow_other-module-parameters.patch
+fuse-transfer-readdir-data-through-device.patch

 FUSE updates/fixes

+cryptoapi-prepare-for-processing-multiple-buffers-at.patch
+cryptoapi-update-padlock-to-process-multiple-blocks-at.patch

 crypto API updates

+update-email-address-of-andrea-arcangeli.patch
+compile-error-blackbird_load_firmware.patch
+i386-x86_64-apicc-make-two-functions-static.patch
+i386-cyrixc-make-a-function-static.patch
+mtrr-some-cleanups.patch
+i386-cpu-commonc-some-cleanups.patch
+i386-cpuidc-make-two-functions-static.patch
+i386-efic-make-some-code-static.patch
+i386-x86_64-io_apicc-misc-cleanups.patch
+i386-mpparsec-make-mp_processor_info-static.patch
+i386-x86_64-msrc-make-two-functions-static.patch
+3w-abcdh-tw_device_extension-remove-an-unused-filed.patch
+hpet-make-some-code-static.patch
+26-patch-i386-trapsc-make-a-function-static.patch
+i386-semaphorec-make-4-functions-static.patch
+i386-rebootc-cleanups.patch
+kill-aux_device_present.patch
+i386-setupc-make-4-variables-static.patch
+mostly-i386-mm-cleanup.patch
+scsi-megaraid_mmc-make-some-code-static.patch
+update-email-address-of-benjamin-lahaise.patch
+update-email-address-of-philip-blundell.patch
+mm-filemapc-make-a-function-static.patch
+kernel-acctc-make-a-function-static.patch
+kernel-auditc-make-some-functions-static.patch
+kernel-capabilityc-make-a-spinlock-static.patch
+mm-thrashc-make-a-variable-static.patch
+lib-kernel_lockc-make-kernel_sem-static.patch
+saa7146_vv_ksymsc-remove-two-unused-export_symbol_gpls.patch
+fix-placement-of-static-inline-in-nfsdh.patch
+drivers-block-umemc-make-two-functions-static.patch
+drivers-block-xdc-make-a-variable-static.patch
+typo-in-arch-x86_64-kconfig.patch
+misc-isapnp-cleanups.patch
+some-pnp-cleanups.patch
+if-0-cx88_risc_disasm.patch

 Various little fixes and cleanups

+add-map_populate-sys_remap_file_pages-support-to-xfs.patch

 Teach XFS about filemap_populate()




number of patches in -mm: 519
number of changesets in external trees: 233
number of patches in -mm only: 507
total patches: 740




All 519 patches:


linus.patch

acpi-build-fix-99.patch
  acpi build fix

mips-default-mlock-limit-fix.patch
  mips default mlock limit fix

shared_policy_replace-fix.patch
  shared_policy_replace() fix

generic_file_buffered_write-handle-partial-dio.patch
  generic_file_buffered_write: handle partial DIO writes with multiple iovecs

cputimeh-seems-to-assume-hz==1000.patch
  cputime.h assumes HZ==1000

ppc32-fix-pmac-kernel-build-with-oprofile.patch
  ppc32: Fix pmac kernel build with oprofile

spinlocking-fixes.patch
  spinlocking fixes

fix-config_agp-depencies.patch
  fix CONFIG_AGP depencies

ioctl-compatibility-for-tiocmiwait-and-tiocgicount.patch
  ioctl compatibility for TIOCMIWAIT and TIOCGICOUNT

cls_api-build-fix.patch
  cls_api-build-fix

ia64-acpi-build-fix.patch
  ia64 acpi build fix

ia64-config_apci_numa-fix.patch
  ia64 CONFIG_APCI_NUMA fix

acpi-sleep-while-atomic-during-s3-resume-from-ram.patch
  acpi: sleep-while-atomic during S3 resume from ram

bk-acpi-revert-20041210.patch
  bk-acpi-revert-20041210

acpi-report-errors-in-fanc.patch
  ACPI: report errors in fan.c

acpi-flush-tlb-when-pagetable-changed.patch
  acpi: flush TLB when pagetable changed

acpi-kfree-fix.patch
  a

alsa-conversion-to-compat_ioctl-kconfig.patch
  ALSA: Conversion to compat_ioctl: Kconfig

alsa-conversion-to-compat_ioctl-alsa-pcm-api.patch
  ALSA: Conversion to compat_ioctl: PCM API

alsa-conversion-to-compat_ioctl-alsa-apis.patch
  ALSA: Conversion to compat_ioctl: ALSA APIs

ac97-audio-support-for-intel-ich7-2611-rc1.patch
  AC'97 Audio support for Intel ICH7 - 2.6.11-rc1

bk-arm.patch

bk-cifs.patch

bk-drm.patch

bk-drm-via.patch

bk-ide-dev.patch

ide-dev-build-fix.patch
  ide-dev-build-fix

bk-input.patch

disable-sidewinder-debug-messages.patch
  Disable Sidewinder debug messages

bk-dtor-input.patch

alps-touchpad-detection-fix.patch
  ALPS touchpad detection fix

bk-kbuild.patch

seagate-st3200822as-sata-disk-needs-to-be-in-sil_blacklist-as-well.patch
  Seagate ST3200822AS SATA disk needs to be in sil_blacklist as well

bk-netdev.patch

bk-ntfs.patch

prevent-pci_name_bus-buffer-overflows.patch
  prevent pci_name_bus() buffer overflows

scsi-ncr53c9x-fixes.patch
  SCSI NCR53C9x.c fixes

maintainers-add-entry-for-qla2xxx-driver.patch
  MAINTAINERS: add entry for qla2xxx driver.

bk-xfs.patch

mm.patch
  add -mmN to EXTRAVERSION

fix-smm-failures-on-e750x-systems.patch
  fix SMM failures on E750x systems

vm-pageout-throttling.patch
  vm: pageout throttling

orphaned-pagecache-memleak-fix.patch
  orphaned pagecache memleak fix

swapspace-layout-improvements.patch
  swapspace-layout-improvements

uninline-mod_page_state.patch
  uninline mod_page_state(offset, delta)

make-tree_lock-an-rwlock.patch
  make mapping->tree_lock an rwlock

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update
  must-fix update
  mustfix lists

pcnet32-79c976-with-fiber-optic.patch
  pcnet32: 79c976 with fiber optic fix

add-omap-support-to-smc91x-ethernet-driver.patch
  Add OMAP support to smc91x Ethernet driver

b44-bounce-buffer-fix.patch
  b44 bounce buffering fix

netpoll-fix-napi-polling-race-on-smp.patch
  netpoll: fix NAPI polling race on SMP

tun-tan-arp-monitor-support.patch
  tun/tap ARP monitor support

atmel_cs-add-support-lg-lw2100n-wlan-pcmcia-card.patch
  atmel_cs: Add support LG LW2100N WLAN PCMCIA card

fix-audit-control-message-checks.patch
  Fix audit control message checks

fix-audit-control-message-checks-tidy.patch
  fix-audit-control-message-checks-tidy

selinux-add-netlink-message-types-for-the-tc-action-code.patch
  SELinux: add Netlink message types for the TC action code.

ppc32-pmac-sleep-support-update.patch
  ppc32: pmac sleep support update

add-try_acquire_console_sem.patch
  Add try_acquire_console_sem

update-aty128fb-sleep-wakeup-code-for-new-powermac-changes.patch
  update aty128fb sleep/wakeup code for new powermac changes

radeonfb-massive-update-of-pm-code.patch
  radeonfb: massive update of PM code

radeonfb-build-fix.patch
  radeonfb-build-fix

ppc32-update-cpu-state-save-restore.patch
  ppc32: update cpu state save/restore

ppc32-add-missing-prototype.patch
  ppc32: Add missing prototype

ppc32-system-platform_device-description-discovery-and-management.patch
  ppc32: System platform_device description, discovery and management

ppc32-infrastructure-changes-to-mpc85xx-sub-arch-from-ocp-to-platform_device.patch
  ppc32: Infrastructure changes to MPC85xx sub-arch from OCP to platform_device

ppc32-convert-boards-from-using-ocp-to-platform_device.patch
  ppc32: convert boards from using OCP to platform_device

ppc32-convert-gianfar-ethernet-driver-from-using-an-ocp-to-platform_device.patch
  ppc32: Convert gianfar ethernet driver from using an OCP to platform_device

ppc32-remove-cli-sti-in-arch-ppc-4xx_io-serial_siccc.patch
  ppc32: remove cli()/sti() in arch/ppc/4xx_io/serial_sicc.c

ppc32-remove-cli-sti-in-arch-ppc-8xx_io-cs4218_tdmc.patch
  ppc32: remove cli()/sti() in arch/ppc/8xx_io/cs4218_tdm.c

ppc32-remove-cli-sti-in-arch-ppc-8xx_io-fecc.patch
  ppc32: remove cli()/sti() in arch/ppc/8xx_io/fec.c

ppc32-remove-cli-sti-in-arch-ppc-platforms-apus_setupc.patch
  ppc32: remove cli()/sti() in arch/ppc/platforms/apus_setup.c

ppc32-remove-cli-sti-in-arch-ppc-platforms-pal4_setupc.patch
  ppc32: remove cli()/sti() in arch/ppc/platforms/pal4_setup.c

ppc32-remove-cli-sti-in-arch-ppc-syslib-m8xx_setupc.patch
  ppc32: remove cli()/sti() in arch/ppc/syslib/m8xx_setup.c

ppc32-remove-cli-sti-in-arch-ppc-syslib-qspan_pcic.patch
  ppc32: remove cli()/sti() in arch/ppc/syslib/qspan_pci.c

ppc32-mpc8xx-tlb-miss-vs-tlb-error-fix.patch
  ppc32: MPC8xx TLB Miss vs TLB Error fix

ppc32-update_process_times-simplification.patch
  ppc32: update_process_times simplification

ppc32-add-defconfigs-for-85xx-boards.patch
  ppc32: Add defconfigs for 85xx boards

ppc64-remove-config_irq_all_cpus.patch
  ppc64: Remove CONFIG_IRQ_ALL_CPUS

ppc64-pci-eeh-documentation.patch
  ppc64: PCI EEH documentation

ppc64-ppc-cleanup-pci-skipping.patch
  ppc64/ppc: Cleanup PCI skipping

ppc64-minimum-hashtable-size.patch
  ppc64: Minimum hashtable size

ppc64-remove-some-unused-iseries-functions.patch
  ppc64: remove some unused iSeries functions

ppc64-reloc_hide.patch

agpgart-allow-multiple-backends-to-be-initialized.patch
  agpgart: allow multiple backends to be initialized
  agpgart-allow-multiple-backends-to-be-initialized fix
  agpgart: add bridge assignment missed in agp_allocate_memory
  x86_64 agp failure fix

agpgart-add-agp_find_bridge-function.patch
  agpgart: add agp_find_bridge function

agpgart-allow-drivers-to-allocate-memory-local-to.patch
  agpgart: allow drivers to allocate memory local to the bridge

drm-add-support-for-new-multiple-agp-bridge-agpgart-api.patch
  drm: add support for new multiple agp bridge agpgart api

fb-add-support-for-new-multiple-agp-bridge-agpgart-api.patch
  fb: add support for new multiple agp bridge agpgart api

agpgart-add-bridge-parameter-to-driver-functions.patch
  agpgart: add bridge parameter to driver functions

superhyway-bus-support.patch
  SuperHyway bus support

fix-xenu-kernel-crash-in-dmi_iterate.patch
  fix xenU kernel crash in dmi_iterate

x86-use-cpumask_t-instead-of-unsigned-long.patch
  x86: use cpumask_t instead of unsigned long

i386-init_intel_cacheinfo-can-be-__init.patch
  i386: init_intel_cacheinfo() can be __init

x86-no-interrupts-from-secondary-cpus-until-officially-online.patch
  x86: no interrupts from secondary CPUs until officially online

arch-i386-kernel-signalc-fix-err-test-twice.patch
  arch/i386/kernel/signal.c: fix err test twice

fix-num_online_nodes-warning-on-numa-q.patch
  Fix num_online_nodes() warning on NUMA-Q

x86_64-fix-cmp-with-interleaving.patch
  x86_64: Fix CMP with interleaving

x86_64-fix-flush-race-on-context-switch.patch
  x86_64: fix flush race on context switch

i386-x86-64-fix-smp-nmi-watchdog-race.patch
  i386/x86-64: Fix SMP NMI watchdog race

x86-64-fix-pud-typo-in-ioremap.patch
  x86-64: Fix pud typo in ioremap

x86-64-fix-do_suspend_lowlevel.patch
  x86-64: Fix do_suspend_lowlevel

x86-64-clean-up-cpuid-level-detection.patch
  x86-64: Clean up cpuid level detection

kprobes-x86_64-memory-allocation-changes.patch
  kprobes: x86_64 memory allocation changes

xen-vmm-4-add-ptep_establish_new-to-make-va-available.patch
  Xen VMM #4: add ptep_establish_new to make va available

xen-vmm-4-return-code-for-arch_free_page.patch
  Xen VMM #4: return code for arch_free_page

xen-vmm-4-return-code-for-arch_free_page-fix.patch
  Get rid of arch_free_page() warning

xen-vmm-4-runtime-disable-of-vt-console.patch
  Xen VMM #4: runtime disable of VT console

xen-vmm-4-has_arch_dev_mem.patch
  Xen VMM #4: HAS_ARCH_DEV_MEM

xen-vmm-4-split-free_irq-into-teardown_irq.patch
  Xen VMM #4: split free_irq into teardown_irq

h8-300-defconfig-update.patch
  H8/300 defconfig update

h8-300-mm-update.patch
  H8/300 mm update

swsusp-remove-on2-algorithm-in-page-relocation.patch
  swsusp: remove O(n^2) algorithm in page relocation

driver-model-pass-pm_message_t-down-to-pci-drivers.patch
  driver model: pass pm_message_t down to pci drivers

uml-provide-an-arch-specific-define-for-register-file-size.patch
  uml: provide an arch-specific define for register file size

uml-provide-some-initcall-definitions-for-userspace-code.patch
  uml: provide some initcall definitions for userspace code

uml-provide-a-release-method-for-the-ubd-driver.patch
  uml: provide a release method for the ubd driver

uml-allow-ubd-devices-to-provide-partial-end-blocks.patch
  uml: allow ubd devices to provide partial end blocks

uml-change-for_each_cpu-to-for_each_online_cpu.patch
  uml: change for_each_cpu to for_each_online_cpu

uml-eliminate-unhandled-sigprof-on-halt.patch
  uml: eliminate unhandled SIGPROF on halt

uml-fix-__pud_alloc-definition-to-match-the-declaration.patch
  uml: fix __pud_alloc definition to match the declaration

uml-fix-a-stack-corruption-crash.patch
  uml: fix a stack corruption crash

uml-define-__have_arch_cmpxchg-on-x86.patch
  uml: define __HAVE_ARCH_CMPXCHG on x86

wacom-tablet-driver.patch
  wacom tablet driver

force-feedback-support-for-uinput.patch
  Force feedback support for uinput

kmap_atomic-takes-char.patch
  kmap_atomic takes char*

kmap_atomic-takes-char-fix.patch
  kmap_atomic-takes-char-fix

kmap_atomic-fallout.patch
  kmap_atomic fallout

kunmap-fallout-more-fixes.patch
  kunmap-fallout-more-fixes

make-sysrq-f-call-oom_kill.patch
  make sysrq-F call oom_kill()

allow-admin-to-enable-only-some-of-the-magic-sysrq-functions.patch
  Allow admin to enable only some of the Magic-Sysrq functions

sort-out-pci_rom_address_enable-vs-ioresource_rom_enable.patch
  Sort out PCI_ROM_ADDRESS_ENABLE vs IORESOURCE_ROM_ENABLE

irqpoll.patch
  irqpoll

poll-mini-optimisations.patch
  poll: mini optimisations

file_tableexpand_files-code-cleanup.patch
  file_table:expand_files() code cleanup

file_tableexpand_files-code-cleanup-remove-debug.patch
  file_tableexpand_files-code-cleanup-remove-debug

mtrr-size-and-base-debug.patch
  mtrr size-and-base debugging

minor-ext3-speedup.patch
  Minor ext3 speedup

move-read-only-and-immutable-checks-into-permission.patch
  move read-only and immutable checks into permission()

factor-out-common-code-around-follow_link-invocation.patch
  factor out common code around ->follow_link invocation

radio-typhoon-use-correct-module_param-data-type.patch
  radio-typhoon: use correct module_param data type

cleanup-vc-array-access.patch
  cleanup vc array access

remove-console_macrosh.patch
  remove console_macros.h

merge-vt_struct-into-vc_data.patch
  merge vt_struct into vc_data

avoid-sparse-warning-due-to-time-interpolator.patch
  avoid sparse warning due to time-interpolator

allow-all-architectures-to-set-config_debug_preempt.patch
  allow all architectures to set CONFIG_DEBUG_PREEMPT

binfmt_elf-allow-mips-to-overrid-e_flags.patch
  binfmt_elf: allow mips to overrid e_flags

remove-bogus-softirq_pending-usage-in-cris.patch
  remove bogus softirq_pending() usage in cris

switch-frw-to-use-local_soft_irq_pending.patch
  switch frw to use local_soft_irq_pending

kill-softirq_pending.patch
  kill softirq_pending()

scripts-referencepl-treat-built-ino-as-conglomerate.patch
  scripts/reference*.pl - treat built-in.o as conglomerate

vgacon-fixes-to-help-font-restauration-in-x11.patch
  vgacon fixes to help font restauration in X11

clean-up-uts_release-usage.patch
  clean up UTS_RELEASE usage

use-official-unicodes-for-dec-vt-characters.patch
  Use official Unicodes for DEC VT characters

ext3-commit-superblock-before-panicking.patch
  ext3: commit superblock before panicking

consolidate-arch-specific-resourceh-headers.patch
  consolidate arch specific resource.h headers

use-wno-pointer-sign-for-gcc-40.patch
  Use -Wno-pointer-sign for gcc 4.0

3c59x-ethtool-provide-nic-specific-stats.patch
  3c59x ethtool: provide NIC-specific stats

fix-init_sighand-warning-on-mips.patch
  fix INIT_SIGHAND warning on mips

add-page_offset-to-mmh.patch
  add page_offset to mm.h

minor-ipmi-driver-updates.patch
  Minor IPMI driver updates

ext3-ea-no-lock-needed-when-freeing-inode.patch
  ext3/ea: no lock needed when freeing inode

ext3-ea-set-the-ext3_feature_compat_ext_attr-for-in-inode-xattrs.patch
  ext3/ea: set the EXT3_FEATURE_COMPAT_EXT_ATTR for in-inode xattrs

ext3-ea-documentation-fix.patch
  ext3/ea: documentation fix

ext3-ea-fix-i_extra_isize-check.patch
  ext3/ea: ix i_extra_isize check

ext3-ea-disallow-in-inode-attributes-for-reserved-inodes.patch
  ext3/ea: disallow in-inode attributes for reserved inodes

completion-api-additions.patch
  completion API additions

convert-xfs-to-unlocked_ioctl-and-compat_ioctl.patch
  Convert XFS to unlocked_ioctl and compat_ioctl

some-fixes-for-compat-ioctl.patch
  Some fixes for compat ioctl

convert-infiniband-mad-driver-to-compat-unlocked_ioctl.patch
  Convert Infiniband MAD driver to compat/unlocked_ioctl

support-compat_ioctl-for-block-devices.patch
  Support compat_ioctl for block devices

convert-cciss-to-compat_ioctl.patch
  Convert cciss to compat_ioctl

add-compat_ioctl-to-frame-buffer-layer.patch
  Add compat_ioctl to frame buffer layer

convert-sis-fb-driver-to-compat_ioctl.patch
  Convert sis fb driver to compat_ioctl

convert-dv1394-driver-to-compat_ioctl.patch
  Convert dv1394 driver to compat_ioctl

convert-video1394-driver-to-compat_ioctl.patch
  Convert video1394 driver to compat_ioctl

convert-amdtp-driver-to-compat_ioctl.patch
  Convert amdtp driver to compat_ioctl

random-pt2-cleanup-waitqueue-logic-fix-missed-wakeup.patch
  random: cleanup waitqueue logic, fix missed wakeup

random-pt2-kill-pool-clearing.patch
  random: kill pool clearing

random-pt2-combine-legacy-ioctls.patch
  random: combine legacy ioctls

random-pt2-re-init-all-pools-on-zero.patch
  random: re-init all pools on zero

random-pt2-simplify-initialization.patch
  random: simplify initialization

random-pt2-kill-memsets-of-static-data.patch
  random: kill memsets of static data

random-pt2-kill-dead-extract_state-struct.patch
  random: kill dead extract_state struct

random-pt2-kill-22-compat-waitqueue-defs.patch
  random: kill 2.2 compat waitqueue defs

random-pt2-kill-redundant-rotate_left-definitions.patch
  random: kill redundant rotate_left definitions

random-pt2-kill-misnamed-log2.patch
  random: kill misnamed log2

random-pt3-more-meaningful-pool-names.patch
  random: More meaningful pool names

random-pt3-static-allocation-of-pools.patch
  random: Static allocation of pools

random-pt3-static-sysctl-bits.patch
  random: Static sysctl bits

random-pt3-catastrophic-reseed-checks.patch
  random: Catastrophic reseed checks

random-pt3-entropy-reservation-accounting.patch
  random: Entropy reservation accounting

random-pt3-reservation-flag-in-pool-struct.patch
  random: Reservation flag in pool struct

random-pt3-reseed-pointer-in-pool-struct.patch
  random: Reseed pointer in pool struct

random-pt3-break-up-extract_user.patch
  random: Break up extract_user

random-pt3-remove-dead-md5-copy.patch
  random: Remove dead MD5 copy

random-pt3-simplify-hash-folding.patch
  random: Simplify hash folding

random-pt3-clean-up-hash-buffering.patch
  random: Clean up hash buffering

random-pt3-remove-entropy-batching.patch
  random: Remove entropy batching

fat-kill-fatfs_symsc.patch
  fat: kill fatfs_syms.c

fat-merge-msdos_fs_isbh-into-msdos_fsh.patch
  fat: merge msdos_fs_{i,sb}.h into msdos_fs.h

fat-is_badchar-is_replacechr-is_skipchar-cleanup.patch
  fat: IS_BADCHAR/IS_REPLACECHR/IS_SKIPCHAR cleanup

fat-is_badchar-is_replacechr-is_skipchar-cleanup-cleanup.patch
  FAT: Further IS_BADCHAR/IS_REPLACECHR/IS_SKIPCHAR cleanup

fat-return-better-error-codes-from.patch
  fat: Return better error codes from vfat_valid_longname()

fat-manually-inline-shortname_info_to_lcase.patch
  fat: Manually inline shortname_info_to_lcase()

fat-use-vprintk-instead-of-snprintf-with-static.patch
  fat: use vprintk instead of snprintf with static buffer

fat-kill-unnecessary-kmap.patch
  fat: kill unnecessary kmap()

fat-fs-fat-cachec-make-__fat_access-static.patch
  fat: fs/fat/cache.c: make __fat_access static

fat-lindent-fs-msdos-nameic.patch
  fat: Lindent fs/msdos/namei.c

fat-lindent-fs-vfat-nameic.patch
  fat: Lindent fs/vfat/namei.c

fat-lindent-fs-vfat-nameic-fix.patch
  FAT: Lindent fs/vfat/namei.c fix

fat-fs-fat-cleanup.patch
  fat: fs/fat/* cleanup

fat-reserved-clusters-cleanup.patch
  fat: reserved clusters cleanup

fat-show-current-nls-config-even-if-its-default.patch
  fat: show current nls config even if it's default.

relayfs-doc.patch
  relayfs: doc

relayfs-common-files.patch
  relayfs: common files

relayfs-remove-klog-debugging-channel.patch
  relayfs - remove klog debugging channel

relayfs-locking-lockless-implementation.patch
  relayfs: locking/lockless implementation

relayfs-headers.patch
  relayfs: headers

relayfs-remove-klog-debugging-channel-headers.patch
  relayfs - remove klog debugging channel

ltt-core-implementation.patch
  ltt: core implementation

ltt-core-headers.patch
  ltt: core headers

ltt-kconfig-fix.patch
  ltt kconfig fix

ltt-kernel-events.patch
  ltt: kernel/ events

ltt-kernel-events-tidy.patch
  ltt-kernel-events tidy

ltt-kernel-events-build-fix.patch
  ltt-kernel-events-build-fix

ltt-fs-events.patch
  ltt: fs/ events

ltt-fs-events-tidy.patch
  ltt-fs-events tidy

ltt-ipc-events.patch
  ltt: ipc/ events

ltt-mm-events.patch
  ltt: mm/ events

ltt-net-events.patch
  ltt: net/ events

ltt-architecture-events.patch
  ltt: architecture events

lock-initializer-cleanup-ppc.patch
  Lock initializer cleanup: PPC

lock-initializer-cleanup-m32r.patch
  Lock initializer cleanup: M32R

lock-initializer-cleanup-video.patch
  Lock initializer cleanup: Video

lock-initializer-cleanup-ide.patch
  Lock initializer cleanup: IDE

lock-initializer-cleanup-sound.patch
  Lock initializer cleanup: sound

lock-initializer-cleanup-sh.patch
  Lock initializer cleanup: SH

lock-initializer-cleanup-ppc64.patch
  Lock initializer cleanup: PPC64

lock-initializer-cleanup-security.patch
  Lock initializer cleanup: Security

lock-initializer-cleanup-core.patch
  Lock initializer cleanup: Core

lock-initializer-cleanup-media-drivers.patch
  Lock initializer cleanup: media drivers

lock-initializer-cleanup-block-devices.patch
  Lock initializer cleanup: Block devices

lock-initializer-cleanup-s390.patch
  Lock initializer cleanup: S390

lock-initializer-cleanup-usermode.patch
  Lock initializer cleanup: UserMode

lock-initializer-cleanup-scsi.patch
  Lock initializer cleanup: SCSI

lock-initializer-cleanup-sparc.patch
  Lock initializer cleanup: SPARC

lock-initializer-cleanup-v850.patch
  Lock initializer cleanup: V850

lock-initializer-cleanup-i386.patch
  Lock initializer cleanup: I386

lock-initializer-cleanup-drm.patch
  Lock initializer cleanup: DRM

lock-initializer-cleanup-firewire.patch
  Lock initializer cleanup: Firewire

lock-initializer-cleanup-arm26.patch
  Lock initializer cleanup - (ARM26)

lock-initializer-cleanup-m68k.patch
  Lock initializer cleanup: M68K

lock-initializer-cleanup-network-drivers.patch
  Lock initializer cleanup: Network drivers

lock-initializer-cleanup-mtd.patch
  Lock initializer cleanup: MTD

lock-initializer-cleanup-x86_64.patch
  Lock initializer cleanup: X86_64

lock-initializer-cleanup-filesystems.patch
  Lock initializer cleanup: Filesystems

lock-initializer-cleanup-ia64.patch
  Lock initializer cleanup: IA64

lock-initializer-cleanup-raid.patch
  Lock initializer cleanup: Raid

lock-initializer-cleanup-isdn.patch
  Lock initializer cleanup: ISDN

lock-initializer-cleanup-parisc.patch
  Lock initializer cleanup: PARISC

lock-initializer-cleanup-sparc64.patch
  Lock initializer cleanup: SPARC64

lock-initializer-cleanup-arm.patch
  Lock initializer cleanup: ARM

lock-initializer-cleanup-misc-drivers.patch
  Lock initializer cleanup: Misc drivers

lock-initializer-cleanup-alpha.patch
  Lock initializer cleanup - (ALPHA)

lock-initializer-cleanup-character-devices.patch
  Lock initializer cleanup: character devices

lock-initializer-cleanup-drivers-serial.patch
  Lock initializer cleanup: drivers/serial

lock-initializer-cleanup-frv.patch
  Lock initializer cleanup: FRV

speedup-proc-pid-maps.patch
  Speed up /proc/pid/maps

speedup-proc-pid-maps-fix.patch
  Speed up /proc/pid/maps fix

speedup-proc-pid-maps-fix-fix.patch
  speedup-proc-pid-maps fix fix

speedup-proc-pid-maps-fix-fix-fix.patch
  speedup /proc/<pid>/maps(4th version)

fix-loss-of-records-on-size-4096-in-proc-pid-maps.patch
  fix loss of records on size > 4096 in proc/<pid>/maps

speedup-proc-pid-maps-fix-fix-fix-fix.patch
  speedup-proc-pid-maps-fix-fix-fix fix

inotify.patch
  inotify

pcmcia-tcic-eleminate-deprecated-check_region.patch
  pcmcia: tcic: eleminate deprecated check_region()

pcmcia-i82365-use-config_pnp-instead-of-__isapnp__.patch
  pcmcia: i82365: use CONFIG_PNP instead of __ISAPNP__

pcmcia-i82092-fix-checking-of-return-value-from-request_region.patch
  pcmcia: i82092: fix checking of return value from request_region

pcmcia-socket-acregion-are-unused.patch
  pcmcia: socket->{a,c}region are unused

pcmcia-use-unsigned-long-for-io-port-address.patch
  pcmcia: use unsigned long for IO port address

nfs-fix_vfsflock.patch
  VFS: Fix structure initialization in locks_remove_flock()

nfs-flock.patch
  NFS: Add NFS support for BSD flock()

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
  Fix stack overflow test for non-8k stacks
  kgdb-ga.patch fix for i386 single-step into sysenter
  fix TRAP_BAD_SYSCALL_EXITS on i386
  add TRAP_BAD_SYSCALL_EXITS config for i386
  kgdb-is-incompatible-with-kprobes
  kgdb-ga-build-fix
  kgdb-ga-fixes

kgdb-kill-off-highmem_start_page.patch
  kgdb: kill off highmem_start_page

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes
  kgdb-x86_64-fix
  kgdb-x86_64-serial-fix
  kprobes exception notifier fix

dev-mem-restriction-patch.patch
  /dev/mem restriction patch

dev-mem-restriction-patch-allow-reads.patch
  dev-mem-restriction-patch: allow reads

jbd-remove-livelock-avoidance.patch
  JBD: remove livelock avoidance code in journal_dirty_data()

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

list_del-debug.patch
  list_del debug check

unplug-can-sleep.patch
  unplug functions can sleep

firestream-warnings.patch
  firestream warnings

perfctr-core.patch
  perfctr: core
  perfctr: remove bogus perfctr_sample_thread() calls

perfctr-i386.patch
  perfctr: i386

perfctr-x86-core-updates.patch
  perfctr x86 core updates

perfctr-x86-driver-updates.patch
  perfctr x86 driver updates

perfctr-x86-driver-cleanup.patch
  perfctr: x86 driver cleanup

perfctr-prescott-fix.patch
  Prescott fix for perfctr

perfctr-x86-update-2.patch
  perfctr x86 update 2

perfctr-x86_64.patch
  perfctr: x86_64

perfctr-x86_64-core-updates.patch
  perfctr x86_64 core updates

perfctr-ppc.patch
  perfctr: PowerPC

perfctr-ppc32-driver-update.patch
  perfctr: ppc32 driver update

perfctr-ppc32-mmcr0-handling-fixes.patch
  perfctr ppc32 MMCR0 handling fixes

perfctr-ppc32-update.patch
  perfctr ppc32 update

perfctr-ppc32-update-2.patch
  perfctr ppc32 update

perfctr-virtualised-counters.patch
  perfctr: virtualised counters

perfctr-remap_page_range-fix.patch

virtual-perfctr-illegal-sleep.patch
  virtual perfctr illegal sleep

make-perfctr_virtual-default-in-kconfig-match-recommendation.patch
  Make PERFCTR_VIRTUAL default in Kconfig match recommendation  in help text

perfctr-ifdef-cleanup.patch
  perfctr ifdef cleanup

perfctr-update-2-6-kconfig-related-updates.patch
  perfctr: Kconfig-related updates

perfctr-virtual-updates.patch
  perfctr virtual updates

perfctr-virtual-cleanup.patch
  perfctr: virtual cleanup

perfctr-ppc32-preliminary-interrupt-support.patch
  perfctr ppc32 preliminary interrupt support

perfctr-update-5-6-reduce-stack-usage.patch
  perfctr: reduce stack usage

perfctr-interrupt-support-kconfig-fix.patch
  perfctr interrupt_support Kconfig fix

perfctr-low-level-documentation.patch
  perfctr low-level documentation

perfctr-inheritance-1-3-driver-updates.patch
  perfctr inheritance: driver updates

perfctr-inheritance-2-3-kernel-updates.patch
  perfctr inheritance: kernel updates

perfctr-inheritance-3-3-documentation-updates.patch
  perfctr inheritance: documentation updates

perfctr-inheritance-locking-fix.patch
  perfctr inheritance locking fix

perfctr-api-changes-first-step.patch
  perfctr API changes: first step

perfctr-virtual-update.patch
  perfctr virtual update

perfctr-x86-64-ia32-emulation-fix.patch
  perfctr x86-64 ia32 emulation fix

perfctr-sysfs-update-1-4-core.patch
  perfctr sysfs update: core

perfctr-sysfs-update.patch
  Perfctr sysfs update

perfctr-sysfs-update-2-4-x86.patch
  perfctr sysfs update: x86

perfctr-sysfs-update-3-4-x86-64.patch
  perfctr sysfs update: x86-64
  perfctr: syscall numbers in x86-64 ia32-emulation
  perfctr x86_64 native syscall numbers fix

perfctr-sysfs-update-4-4-ppc32.patch
  perfctr sysfs update: ppc32

sched-fix-preemption-race-core-i386.patch
  sched: fix preemption race (Core/i386)

sched-make-use-of-preempt_schedule_irq-ppc.patch
  sched: make use of preempt_schedule_irq() (PPC)

sched-make-use-of-preempt_schedule_irq-arm.patch
  sched: make use of preempt_schedule_irq (ARM)

sched-isochronous-class-for-unprivileged-soft-rt-scheduling.patch
  sched: Isochronous class for unprivileged soft rt scheduling

add-do_proc_doulonglongvec_minmax-to-sysctl-functions.patch
  Add do_proc_doulonglongvec_minmax to sysctl functions
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions-fix
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions fix 2

add-sysctl-interface-to-sched_domain-parameters.patch
  Add sysctl interface to sched_domain parameters

allow-modular-ide-pnp.patch
  allow modular ide-pnp

allow-x86_64-to-reenable-interrupts-on-contention.patch
  Allow x86_64 to reenable interrupts on contention

i386-cpu-hotplug-updated-for-mm.patch
  i386 CPU hotplug updated for -mm

ppc64-fix-cpu-hotplug.patch
  ppc64: fix hotplug cpu

serialize-access-to-ide-devices.patch
  serialize access to ide devices

disable-atykb-warning.patch
  disable atykb "too many keys pressed" warning

export-file_ra_state_init-again.patch
  Export file_ra_state_init() again

cachefs-filesystem.patch
  CacheFS filesystem

numa-policies-for-file-mappings-mpol_mf_move-cachefs.patch
  numa-policies-for-file-mappings-mpol_mf_move for cachefs

cachefs-release-search-records-lest-they-return-to-haunt-us.patch
  CacheFS: release search records lest they return to haunt us

fix-64-bit-problems-in-cachefs.patch
  Fix 64-bit problems in cachefs

cachefs-fixed-typos-that-cause-wrong-pointer-to-be-kunmapped.patch
  cachefs: fixed typos that cause wrong pointer to be kunmapped

cachefs-return-the-right-error-upon-invalid-mount.patch
  CacheFS: return the right error upon invalid mount

fix-cachefs-barrier-handling-and-other-kernel-discrepancies.patch
  Fix CacheFS barrier handling and other kernel discrepancies

remove-error-from-linux-cachefsh.patch
  Remove #error from linux/cachefs.h

cachefs-warning-fix-2.patch
  cachefs warning fix 2

cachefs-linkage-fix-2.patch
  cachefs linkage fix

cachefs-build-fix.patch
  cachefs build fix

cachefs-documentation.patch
  CacheFS documentation

add-page-becoming-writable-notification.patch
  Add page becoming writable notification

add-page-becoming-writable-notification-fix.patch
  do_wp_page_mk_pte_writable() fix

add-page-becoming-writable-notification-build-fix.patch
  add-page-becoming-writable-notification build fix

provide-a-filesystem-specific-syncable-page-bit.patch
  Provide a filesystem-specific sync'able page bit

provide-a-filesystem-specific-syncable-page-bit-fix.patch
  provide-a-filesystem-specific-syncable-page-bit-fix

provide-a-filesystem-specific-syncable-page-bit-fix-2.patch
  provide-a-filesystem-specific-syncable-page-bit-fix-2

make-afs-use-cachefs.patch
  Make AFS use CacheFS

afs-cachefs-dependency-fix.patch
  afs-cachefs-dependency-fix

split-general-cache-manager-from-cachefs.patch
  Split general cache manager from CacheFS

turn-cachefs-into-a-cache-backend.patch
  Turn CacheFS into a cache backend

rework-the-cachefs-documentation-to-reflect-fs-cache-split.patch
  Rework the CacheFS documentation to reflect FS-Cache split

update-afs-client-to-reflect-cachefs-split.patch
  Update AFS client to reflect CacheFS split

x86-rename-apic_mode_exint.patch
  kexec: x86: rename APIC_MODE_EXINT

x86-local-apic-fix.patch
  kexec: x86: local apic fix

x86_64-e820-64bit.patch
  kexec: x86_64: e820 64bit fix

x86-i8259-shutdown.patch
  kexec: x86: i8259 shutdown: disable interrupts

x86_64-i8259-shutdown.patch
  kexec: x86_64: add i8259 shutdown method

x86-apic-virtwire-on-shutdown.patch
  kexec: x86: resture apic virtual wire mode on shutdown

x86_64-apic-virtwire-on-shutdown.patch
  kexec: x86_64: restore apic virtual wire mode on shutdown

vmlinux-fix-physical-addrs.patch
  kexec: vmlinux: fix physical addresses

x86-vmlinux-fix-physical-addrs.patch
  kexec: x86: vmlinux: fix physical addresses

x86_64-vmlinux-fix-physical-addrs.patch
  kexec: x86_64: vmlinux: fix physical addresses

x86_64-entry64.patch
  kexec: x86_64: add 64-bit entry

x86-config-kernel-start.patch
  kexec: x86: add CONFIG_PYSICAL_START

x86_64-config-kernel-start.patch
  kexec: x86_64: add CONFIG_PHYSICAL_START

kexec-kexec-generic.patch
  kexec: add kexec syscalls

x86-machine_shutdown.patch
  kexec: x86: factor out apic shutdown code

x86-kexec.patch
  kexec: x86 kexec core

x86-crashkernel.patch
  crashdump: x86 crashkernel option

x86_64-machine_shutdown.patch
  kexec: x86_64: factor out apic shutdown code

x86_64-kexec.patch
  kexec: x86_64 kexec implementation

x86_64-crashkernel.patch
  crashdump: x86_64: crashkernel option

kexec-ppc-support.patch
  kexec: kexec ppc support

x86-crash_shutdown-nmi-shootdown.patch
  crashdump: x86: add NMI handler to capture other CPUs

x86-crash_shutdown-snapshot-registers.patch
  kexec: x86: snapshot registers during crash shutdown

x86-crash_shutdown-apic-shutdown.patch
  kexec: x86 shutdown APICs during crash_shutdown

crashdump-documentation.patch
  crashdump: documentation

crashdump-memory-preserving-reboot-using-kexec.patch
  crashdump: memory preserving reboot using kexec

crashdump-routines-for-copying-dump-pages.patch
  crashdump: routines for copying dump pages

crashdump-elf-format-dump-file-access.patch
  crashdump: elf format dump file access

crashdump-linear-raw-format-dump-file-access.patch
  crashdump: linear raw format dump file access

new-bitmap-list-format-for-cpusets.patch
  new bitmap list format (for cpusets)

cpusets-big-numa-cpu-and-memory-placement.patch
  cpusets - big numa cpu and memory placement

cpusets-config_cpusets-depends-on-smp.patch
  Cpusets: CONFIG_CPUSETS depends on SMP

cpusets-move-cpusets-above-embedded.patch
  move CPUSETS above EMBEDDED

cpusets-fix-cpuset_get_dentry.patch
  cpusets : fix cpuset_get_dentry()

cpusets-fix-race-in-cpuset_add_file.patch
  cpusets: fix race in cpuset_add_file()

cpusets-remove-more-casts.patch
  cpusets: remove more casts

cpusets-make-config_cpusets-the-default-in-sn2_defconfig.patch
  cpusets: make CONFIG_CPUSETS the default in sn2_defconfig

cpusets-document-proc-status-allowed-fields.patch
  cpusets: document proc status allowed fields

cpusets-dont-export-proc_cpuset_operations.patch
  Cpusets - Dont export proc_cpuset_operations

cpusets-display-allowed-masks-in-proc-status.patch
  cpusets: display allowed masks in proc status

cpusets-simplify-cpus_allowed-setting-in-attach.patch
  cpusets: simplify cpus_allowed setting in attach

cpusets-remove-useless-validation-check.patch
  cpusets: remove useless validation check

cpusets-tasks-file-simplify-format-fixes.patch
  Cpusets tasks file: simplify format, fixes

cpusets-simplify-memory-generation.patch
  Cpusets: simplify memory generation

cpusets-interoperate-with-hotplug-online-maps.patch
  cpusets: interoperate with hotplug online maps

cpusets-alternative-fix-for-possible-race-in.patch
  cpusets: alternative fix for possible race in  cpuset_tasks_read()

cpusets-remove-casts.patch
  cpusets: remove void* typecasts

reiser4-sb_sync_inodes.patch
  reiser4: vfs: add super_operations.sync_inodes()

reiser4-allow-drop_inode-implementation.patch
  reiser4: export vfs inode.c symbols

reiser4-truncate_inode_pages_range.patch
  reiser4: vfs: add truncate_inode_pages_range()

reiser4-export-remove_from_page_cache.patch
  reiser4: export pagecache add/remove functions to modules

reiser4-export-page_cache_readahead.patch
  reiser4: export page_cache_readahead to modules

reiser4-reget-page-mapping.patch
  reiser4: vfs: re-check page->mapping after calling try_to_release_page()

reiser4-rcu-barrier.patch
  reiser4: add rcu_barrier() synchronization point

reiser4-export-inode_lock.patch
  reiser4: export inode_lock to modules

reiser4-export-pagevec-funcs.patch
  reiser4: export pagevec functions to modules

reiser4-export-radix_tree_preload.patch
  reiser4: export radix_tree_preload() to modules

reiser4-export-find_get_pages.patch

reiser4-radix-tree-tag.patch
  reiser4: add new radix tree tag

reiser4-radix_tree_lookup_slot.patch
  reiser4: add radix_tree_lookup_slot()

reiser4-perthread-pages.patch
  reiser4: per-thread page pools

reiser4-include-reiser4.patch
  reiser4: add to build system

reiser4-doc.patch
  reiser4: documentation

reiser4-only.patch
  reiser4: main fs

reiser4-recover-read-performance.patch
  reiser4: recover read performance

reiser4-export-find_get_pages_tag.patch
  reiser4-export-find_get_pages_tag

reiser4-add-missing-context.patch

add-acpi-based-floppy-controller-enumeration.patch
  Add ACPI-based floppy controller enumeration.

possible-dcache-bug-debugging-patch.patch
  Possible dcache BUG: debugging patch

serial-add-support-for-non-standard-xtals-to-16c950-driver.patch
  serial: add support for non-standard XTALs to 16c950 driver

add-support-for-possio-gcc-aka-pcmcia-siemens-mc45.patch
  Add support for Possio GCC AKA PCMCIA Siemens MC45

generic-serial-cli-conversion.patch
  generic-serial cli() conversion

specialix-io8-cli-conversion.patch
  Specialix/IO8 cli() conversion

sx-cli-conversion.patch
  SX cli() conversion

revert-allow-oem-written-modules-to-make-calls-to-ia64-oem-sal-functions.patch
  revert "allow OEM written modules to make calls to ia64 OEM SAL functions"

md-add-interface-for-userspace-monitoring-of-events.patch
  md: add interface for userspace monitoring of events.

make-acpi_bus_register_driver-consistent-with-pci_register_driver-again.patch
  make acpi_bus_register_driver() consistent with pci_register_driver()

remove-lock_section-from-x86_64-spin_lock-asm.patch
  remove LOCK_SECTION from x86_64 spin_lock asm

kfree_skb-dump_stack.patch
  kfree_skb-dump_stack

cancel_rearming_delayed_work.patch
  cancel_rearming_delayed_work()
  make cancel_rearming_delayed_workqueue static

ipvs-deadlock-fix.patch
  ipvs deadlock fix

minimal-ide-disk-updates.patch
  Minimal ide-disk updates

use-find_trylock_page-in-free_swap_and_cache-instead-of-hand-coding.patch
  use find_trylock_page in free_swap_and_cache instead of hand coding

radeonfb-set-accelerator-id.patch
  radeonfb: Set accelerator id

vesafb-change-return-error-id.patch
  vesafb: Change return error id

intelfb-workaround-for-830m.patch
  intelfb: Workaround for 830M

fbcon-save-blank-state-last.patch
  fbcon: Save blank state last

backlight-fix-compile-error-if-config_fb-is-unset.patch
  backlight: Fix compile error if CONFIG_FB is unset

matroxfb-fb_matrox_g-kconfig-changes.patch
  matroxfb: FB_MATROX_G Kconfig changes

raid5-overlapping-read-hack.patch
  raid5 overlapping read hack

include-type-information-as-module-info-where-possible.patch
  Include type information as module info where possible

figure-out-who-is-inserting-bogus-modules.patch
  Figure out who is inserting bogus modules

detect-atomic-counter-underflows.patch
  detect atomic counter underflows

post-halloween-doc.patch
  post halloween doc

periodically-scan-redzone-entries-and-slab-control-structures.patch
  periodically scan redzone entries and slab control structures

fuse-maintainers-kconfig-and-makefile-changes.patch
  Subject: [PATCH 1/11] FUSE - MAINTAINERS, Kconfig and Makefile changes

fuse-core.patch
  Subject: [PATCH 2/11] FUSE - core

fuse-device-functions.patch
  Subject: [PATCH 3/11] FUSE - device functions

fuse-make-two-functions-static.patch
  fuse: make two functions static

fuse-fix-variable-with-confusing-name.patch
  fuse: fix variable with confusing name

fuse-read-only-operations.patch
  Subject: [PATCH 4/11] FUSE - read-only operations

fuse-read-write-operations.patch
  Subject: [PATCH 5/11] FUSE - read-write operations

fuse-file-operations.patch
  Subject: [PATCH 6/11] FUSE - file operations

fuse-mount-options.patch
  Subject: [PATCH 7/11] FUSE - mount options

fuse-dont-check-against-zero-fsuid.patch
  fuse: don't check against zero fsuid

fuse-remove-mount_max-and-user_allow_other-module-parameters.patch
  fuse: remove mount_max and user_allow_other module parameters

fuse-extended-attribute-operations.patch
  Subject: [PATCH 8/11] FUSE - extended attribute operations

fuse-readpages-operation.patch
  Subject: [PATCH 9/11] FUSE - readpages operation

fuse-nfs-export.patch
  Subject: [PATCH 10/11] FUSE - NFS export

fuse-direct-i-o.patch
  Subject: [PATCH 11/11] FUSE - direct I/O

fuse-transfer-readdir-data-through-device.patch
  fuse: transfer readdir data through device

ieee1394-adds-a-disable_irm-option-to-ieee1394ko.patch
  ieee1394: add a disable_irm option to ieee1394.ko

cryptoapi-prepare-for-processing-multiple-buffers-at.patch
  CryptoAPI: prepare for processing multiple buffers at a time

cryptoapi-update-padlock-to-process-multiple-blocks-at.patch
  CryptoAPI: Update PadLock to process multiple blocks at  once

update-email-address-of-andrea-arcangeli.patch
  update email address of Andrea Arcangeli

compile-error-blackbird_load_firmware.patch
  blackbird_load_firmware compile fix

i386-x86_64-apicc-make-two-functions-static.patch
  i386/x86_64 apic.c: make two functions static

i386-cyrixc-make-a-function-static.patch
  i386 cyrix.c: make a function static

mtrr-some-cleanups.patch
  mtrr: some cleanups

i386-cpu-commonc-some-cleanups.patch
  i386 cpu/common.c: some cleanups

i386-cpuidc-make-two-functions-static.patch
  i386 cpuid.c: make two functions static

i386-efic-make-some-code-static.patch
  i386 efi.c: make some code static

i386-x86_64-io_apicc-misc-cleanups.patch
  i386/x86_64 io_apic.c: misc cleanups

i386-mpparsec-make-mp_processor_info-static.patch
  i386 mpparse.c: make MP_processor_info static

i386-x86_64-msrc-make-two-functions-static.patch
  i386/x86_64 msr.c: make two functions static

3w-abcdh-tw_device_extension-remove-an-unused-filed.patch
  3w-abcd.h: TW_Device_Extension: remove an unused field

hpet-make-some-code-static.patch
  hpet: make some code static

26-patch-i386-trapsc-make-a-function-static.patch
  i386 traps.c: make a function static

i386-semaphorec-make-4-functions-static.patch
  i386 semaphore.c: make 4 functions static

i386-rebootc-cleanups.patch
  i386: reboot.c cleanups

kill-aux_device_present.patch
  kill aux_device_present

i386-setupc-make-4-variables-static.patch
  i386 setup.c: make 4 variables static

mostly-i386-mm-cleanup.patch
  (mostly i386) mm cleanup

scsi-megaraid_mmc-make-some-code-static.patch
  SCSI megaraid_mm.c: make some code static

update-email-address-of-benjamin-lahaise.patch
  Update email address of Benjamin LaHaise

add-map_populate-sys_remap_file_pages-support-to-xfs.patch
  add MAP_POPULATE/sys_remap_file_pages support to XFS

update-email-address-of-philip-blundell.patch
  Update email address of Philip Blundell

mm-filemapc-make-a-function-static.patch
  mm/filemap.c: make a function static

kernel-acctc-make-a-function-static.patch
  kernel/acct.c: make a function static

kernel-auditc-make-some-functions-static.patch
  kernel/audit.c: make some functions static

kernel-capabilityc-make-a-spinlock-static.patch
  kernel/capability.c: make a spinlock static

mm-thrashc-make-a-variable-static.patch
  mm/thrash.c: make a variable static

lib-kernel_lockc-make-kernel_sem-static.patch
  lib/kernel_lock.c: make kernel_sem static

saa7146_vv_ksymsc-remove-two-unused-export_symbol_gpls.patch
  saa7146_vv_ksyms.c: remove two unused EXPORT_SYMBOL_GPL's

fix-placement-of-static-inline-in-nfsdh.patch
  fix placement of static inline in nfsd.h

drivers-block-umemc-make-two-functions-static.patch
  drivers/block/umem.c: make two functions static

drivers-block-xdc-make-a-variable-static.patch
  drivers/block/xd.c: make a variable static

typo-in-arch-x86_64-kconfig.patch
  Typo in arch/x86_64/Kconfig

misc-isapnp-cleanups.patch
  misc ISAPNP cleanups

some-pnp-cleanups.patch
  some PNP cleanups

if-0-cx88_risc_disasm.patch
  #if 0 cx88_risc_disasm



