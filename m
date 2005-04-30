Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262526AbVD3GUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbVD3GUW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 02:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbVD3GUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 02:20:22 -0400
Received: from fire.osdl.org ([65.172.181.4]:49343 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262526AbVD3GRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 02:17:21 -0400
Date: Fri, 29 Apr 2005 23:16:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc3-mm1
Message-Id: <20050429231653.32d2f091.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm1/

- There's still a bug in the new timer code.  If you think you hit it,
  please revert 

	timers-fixes-improvements-fix.patch			then
	timers-fixes-improvements-smp_processor_id-fix.patch	then
	timers-fixes-improvements.patch

  or, better, fix the bug.

- If you use mpt-fusion, beware that the CONFIG_* names got changed - if you
  blindly do `make oldconfig' you won't have any disks.

- ia64 crashes when doing a PM poweroff.  It's triggered by
  properly-stop-devices-before-poweroff.patch but appears to be an ia64 bug.

- Lots of bk trees were dropped and lots of git trees and patch serieses
  were picked up.  I think all the subsystem trees are here, but the bk ones
  are starting to rot.  As far as I can tell, no subsystem maintainers are
  updating their bk trees (apart from acpi).

- We're still miles away from 2.6.12.  Lots of patches here, plus my
  collection of bugs-post-2.6.11 is vast.  I'll start working through them
  again after 2.6.12-rc4 is available to testers.




Changes since 2.6.12-rc2-mm3:

+linus.patch

 Latest Linus tree

-re-export-cancel_rearming_delayed_workqueue.patch
-fix-acl-oops.patch
-fix-crash-in-entrys-restore_all.patch
-fix-get_compat_sigevent.patch
-fix-bug-4395-modprobe-bttv-freezes-the-computer.patch
-selinux-fix-bug-in-netlink-message-type-detection.patch
-r128_statec-break-missing-in-switch-statement.patch
-bk-acpi-alpha-build-fix.patch
-acpi-toshiba-failure-handling.patch
-acpi-video-pointer-size-fix.patch
-acpi-fix-reloading-gdt-on-acpi-s3-wakeup.patch
-add-suspend-method-to-cpufreq-core.patch
-add-suspend-method-to-cpufreq-core-warning-fix.patch
-bk-driver-core-usb-klist_node_attached-fix.patch
-i2c-adaptor-for-coldfire-5282-cpu.patch
-i2c-adaptor-for-coldfire-5282-cpu-fix.patch
-ia64-fix-fls.patch
-gregkh-pci-kconfig-fix.patch
-pci_module_init-pci_register_driver.patch
-acpi-hotplug-convert-acpiphp-to-use-generic-resource-code.patch
-acpi-hotplug-clean-up-notify-handlers-on-acpiphp-unload.patch
-acpi-hotplug-fix-slot-power-down-problem-with-acpiphp.patch
-acpi-hotplug-acpi-based-root-bridge-hot-add.patch
-acpi-hotplug-decouple-slot-power-state-changes-from-physical-hotplug.patch
-pm-support-for-zd1201.patch
-usb-turn-a-user-mode-driver-error-into-a-hard-error.patch
-usb-storage-debugc-missing-include.patch
-freepgt-free_pgtables-use-vma-list.patch
-freepgt-remove-mm_vm_sizemm.patch
-freepgt-hugetlb_free_pgd_range.patch
-freepgt-hugetlb_free_pgd_range-fix-aio-panic-fix.patch
-freepgt-remove-arch-pgd_addr_end.patch
-freepgt-mpnt-to-vma-cleanup.patch
-freepgt-hugetlb-area-is-clean.patch
-freepgt2-free_pgtables-from-first_user_address.patch
-freepgt2-sys_mincore-ignore-first_user_pgd_nr.patch
-freepgt2-arm-first_user_address-page_size.patch
-freepgt2-arm26-first_user_address-page_size.patch
-freepgt2-arch-first_user_address-0.patch
-freepgt2-remove-first_user_address-hack.patch
-filemap_getpage-can-block-when-map_nonblock-specified.patch
-oom-killer-disable-for-iscsi-lvm2-multipath-userland-critical-sections.patch
-vmscan-pageout-remove-unneeded-test.patch
-end_buffer_write_sync-avoid-pointless-assignments.patch
-meminfo-add-cached-underflow-check.patch
-eni155p-error-handling-fix.patch
-fix-linux-atalkh-header.patch
-dont-call-kmem_cache_create-with-a-spinlock-held.patch
-fix-dst_destroy-race.patch
-irda_device-oops-fix.patch
-net-ieee80211-ieee80211_txc-swapped-memset-arguments.patch
-selinux-add-support-for-netlink_kobject_uevent.patch
-ppc32-fix-bogosity-in-process-freezing-code.patch
-ppc32-ppc4xx_pic-add-acknowledge-when-enabling-level-sensitive-irq.patch
-ppc32-improve-timebase-sync-for-smp.patch
-ppc32-oops-on-kernel-altivec-assist-exceptions.patch
-ppc32-fix-single-stepping-of-emulated-instructions.patch
-ppc32-fix-cpufreq-problems.patch
-ppc32-fix-agp-and-sleep-again.patch
-ppc32-fix-pte_update-for-64-bit-ptes.patch
-ppc32-make-usage-of-config_pte_64bit-config_phys_64bit.patch
-ppc32-allow-adjust-of-pfn-offset-in-pte.patch
-ppc32-support-36-bit-physical-addressing-on-e500.patch
-ppc32-fix-mpc8xx-watchdog.patch
-ppc32-fix-a-problem-with-ntp-on-chrpgemini.patch
-ppc32-fix-building-32bit-kernel-for-64bit-machines.patch
-ppc32-make-the-powerstack-ii-pro4000-boot-again.patch
-pmac-sound-support-for-latest-laptops.patch
-pmac-improve-sleep-code-of-tumbler-driver.patch
-ppc64-fix-semantics-of-__ioremap.patch
-ppc64-fix-export-of-wrong-symbol.patch
-ppc64-kconfig-memory-models.patch
-ppc64-improve-mapping-of-vdso.patch
-ppc64-detect-altivec-via-firmware-on-unknown-cpus.patch
-ppc64-remove-bogus-f50-hack-in-promc.patch
-ppc64-remove-fno-omit-frame-pointer.patch
-ppc64-no-prefetch-for-null-pointers.patch
-mips-remove-obsolete-vr41xx-rtc-function.patch
-mips-update-vr41xx-cpu-pci-bridge.patch
-mips-remove-include-linux-audith-two.patch
-irq-and-pci_ids-patch-for-intel-esb2.patch
-piix-ide-pata-patch-for-intel-esb2.patch
-intel8x0-ac97-audio-patch-for-intel-esb2.patch
-ata_piix-ide-mode-sata-patch-for-intel-esb2.patch
-ahci-ahci-mode-sata-patch-for-intel-esb2.patch
-i2c-i801-i2c-patch-for-intel-esb2.patch
-i386-use-loaddebug-macro-consistently.patch
-i386-vdso-add-pt_note-segment.patch
-x86-64-i386-vdso-add-pt_note-segment.patch
-x86-64-i386-revert-cpuinfo-siblings-behaviour-back-to-2610.patch
-x86-64-fix-bug.patch
-x86_64-disable-interrupts-during-smp-bogomips-checking.patch
-x86_64-genapic-update.patch
-x86_64-show_stack-touch_nmi_watchdog.patch
-x86_64-use-a-vma-for-the-32bit-vsyscall.patch
-x86_64-make-irda-devices-are-not-really-isa-devices-not.patch
-x86_64-from-i386-originally-from-linus.patch
-x86_64-some-fixes-for-single-step-handling.patch
-x86_64-handle-programs-that-set-tf-in-user-space-using.patch
-x86_64-use-a-common-function-to-find-code-segment-bases.patch
-x86_64-use-a-common-function-to-find-code-segment-bases-fix.patch
-x86_64-dump-stack-and-prevent-recursion-on-early-fault.patch
-x86_64-fix-interaction-of-single-stepping-with-debuggers.patch
-x86_64-minor-microoptimization-in-syscall-entry-slow-path.patch
-x86_64-call-do_notify_resume-unconditionally-in-entrys.patch
-x86_64-regularize-exception-stack-handling.patch
-x86_64-fix-a-small-missing-schedule-race.patch
-x86_64-remove-unused-macro-in-preempt-support.patch
-x86_64-support-constantly-ticking-tscs.patch
-x86_64-make-kernel-math-errors-a-die-now.patch
-x86_64-dont-assume-future-amd-cpus-have-k8-compatible.patch
-x86_64-correct-wrong-comment-in-localh.patch
-x86_64-use-the-extended-rip-msr-for-machine-check.patch
-x86_64-remove-excessive-stack-allocation-in-mce-code.patch
-x86_64-always-use-cpuid-80000008-to-figure-out-mtrr.patch
-x86_64-always-use-cpuid-80000008-to-figure-out-mtrr-fix.patch
-x86_64-port-over-e820-gap-detection-from-i386.patch
-x86_64-use-the-e820-hole-to-map-the-iommu-agp-aperture.patch
-x86_64-keep-only-a-single-debug-notifier-chain.patch
-x86_64-remove-duplicated-syscall-entry.patch
-x86_64-adds-support-for-intel-dual-core-detection-and-displaying.patch
-x86_64-final-support-for-amd-dual-core.patch
-x86_64-final-support-for-amd-dual-core-fix.patch
-x86_64-final-support-for-amd-dual-core-fix-2.patch
-x86_64-final-support-for-amd-dual-core-fix-fix.patch
-x86_64-final-support-for-amd-dual-core-fix-fix-fix.patch
-x86_64-rewrite-exception-stack-backtracing.patch
-x86_64-add-acpi_skip_timer_override-option.patch
-x86_64-rename-the-extended-cpuid-level-field.patch
-x86_64-switch-smp-bootup-over-to-new-cpu-hotplug-state.patch
-x86_64-switch-smp-bootup-over-to-new-cpu-hotplug-state-fix.patch
-h8300-header-update.patch
-pm_message_t-more-fixes-in-common-and-i386.patch
-fix-u32-vs-pm_message_t-in-drivers-char.patch
-u32-vs-pm_message_t-fixes-for-drivers-net.patch
-fix-u32-vs-pm_message_t-in-pcmcia.patch
-fix-u32-vs-pm_message_t-in-drivers-media.patch
-fix-u32-vs-pm_message_t-in-drivers-message.patch
-fix-u32-vs-pm_message_t-in-drivers-mmcmtdscsi.patch
-fix-pm_message_t-vs-u32-in-alsa.patch
-fix-u32-vs-pm_message_t-in-x86-64.patch
-fix-u32-vs-pm_message_t-in-drivers-macintosh.patch
-fix-u32-vs-pm_message_t-in-pci-pcie.patch
-u32-vs-pm_message_t-in-ppc-and-radeon.patch
-power-videotxt-update-documentation-with-more-systems.patch
-fix-u32-vs-pm_message_t-in-drivers.patch
-fix-u32-vs-pm_message_t-in-driver-video.patch
-fix-u32-vs-pm_message_t-in-rest-of-the-tree.patch
-swsusp-smp-fix.patch
-uml-fix-compilation-for-__choose_mode-addition.patch
-possible-use-after-free-of-bio.patch
-async-io-using-rt-signals.patch
-kernel-paramc-dont-use-max-when-num-is-null-in.patch
-fix-module_param_string-calls.patch
-use-cheaper-elv_queue_empty-when-unplug-a-device.patch
-fixup-newly-added-jsm-driver.patch
-ext2-corruption-regression-between-269-and-2610.patch
-quota-fix-possible-oops-on-quotaoff.patch
-quota-possible-bug-in-quota-format-v2-support.patch
-kill-ifndef-have_arch_get_signal_to_deliver-in-signalc.patch
-officially-deprecate-register_ioctl32_conversion.patch
-undo-do_readv_writev-behavior-change.patch
-kprobes-incorrect-handling-of-probes-on-ret-lret-instruction.patch
-show-thread_info-flags-in-proc-pid-status.patch
-direct-io-async-short-read-fix.patch
-fix-comment-in-listh-that-refers-to-nonexistent-api.patch
-pnpbios-eliminate-bad-section-references.patch
-hd-eliminate-bad-section-references.patch
-efi-eliminate-bad-section-references.patch
-add-big-endian-variants-of-ioread-iowrite.patch
-opl3sa2-module_parm_desc.patch
-update-maintainer-for-dev-random.patch
-add-dontdiff-file.patch
-as-limit-queue-depth-fix.patch
-kprobes-multiple-probes-feature-at-given-address.patch
-credits-update.patch
-pci-enumeration-on-ixp2000-overflow-in-kernel-resourcec.patch
-cpuset-remove-function-attribute-const.patch
-let-sound_ad1889-depend-on-pci.patch
-maintainers-remove-obsolete-acp-mwave-modem-entry.patch
-ipoib-set-skb-macraw-on-receive.patch
-ipoib-fix-static-rate-calculation.patch
-ipoib-convert-to-debugfs.patch
-ipoib-document-conversion-to.patch
-ib-keep-mad-work-completion-valid.patch
-ib-remove-unneeded-includes.patch
-ib-fix-fmr-pool-crash.patch
-ib-trivial-fmr-printk-cleanup.patch
-ib-fix-user-mad-registrations-with-class-0.patch
-ib-remove-incorrect-comments.patch
-ib-mthca-map-mpt-mtt-context-in-mem-free-mode.patch
-ib-mthca-fill-in-more-device-query-fields.patch
-ib-mthca-fix-calculation-of-rdb-shift.patch
-ib-mthca-fix-posting-sends-with-immediate-data.patch
-ib-mthca-allow-unaligned-memory-regions.patch
-ib-mthca-allocate-correct-number-of-doorbell-pages.patch
-ib-mthca-clean-up-mthca_dereg_mr.patch
-ib-mthca-fix-mr-allocation-error-path.patch
-ib-mthca-release-mutex-on-doorbell-alloc-error-path.patch
-ib-mthca-print-assigned-irq-when-interrupt-test-fails.patch
-ib-mthca-only-free-doorbell-records-in-mem-free-mode.patch
-ib-mthca-fix-format-of-cq-number-for-cq-events.patch
-ib-mthca-implement-rdma-atomic-operations-for-mem-free-mode.patch
-ib-mthca-fix-mtt-allocation-in-mem-free-mode.patch
-ib-mthca-fill-in-opcode-field-for-send-completions.patch
-ib-mthca-allow-address-handle-creation-in-interrupt-context.patch
-ib-mthca-encapsulate-mtt-buddy-allocator.patch
-ib-mthca-add-sync_tpt-firmware-command.patch
-ib-mthca-add-mthca_write64_raw-for-writing-to-mtt-table-directly.patch
-ib-mthca-add-mthca_table_find-function.patch
-ib-mthca-split-mr-key-munging-routines.patch
-ib-mthca-add-fast-memory-region-implementation.patch
-ib-mthca-tweaks-to-mthca_cmdc.patch
-ib-mthca-encapsulate-mem-free-check-into-mthca_is_memfree.patch
-ib-mthca-map-context-for-rdma-responder-in-mem-free-mode.patch
-ib-mthca-update-receive-queue-initialization-for-new-hcas.patch
-ib-mthca-add-support-for-new-mt25204-hca.patch
-ib-mthca-add-support-for-new-mt25204-hca-fix.patch
-jbd-dirty-buffer-leak-fix.patch
-nfsd-clear-signals-before-exiting-the-nfsd-thread.patch
-nfsd4-callback-create-rpc-client-returns.patch
-nfsd4-fix-struct-file-leak.patch
-fbdev-maintainers-update.patch
-md-close-a-small-race-in-md-thread-deregistration.patch
-md-remove-a-number-of-misleading-calls-to-md_bug.patch
-tpm-fix-gcc-printk-warnings.patch
-net-atm-resourcesc-remove-__free_atm_dev.patch

 Merged

+ultrastor-build-fix.patch

 scsi driver compile fix

-bk-agpgart.patch

 Dropped

+agp-AGP-01-printk-levels.patch

 davej's agp tree

-bk-alsa.patch

 Dropped

+intel8x0-fix-for-intel-ac97-audio-driver.patch
+interwave-needs-isa-pnp.patch

 Audio driver fixes

-bk-cifs.patch

 Dropped

-bk-cpufreq.patch

 Dropped

+cpufreq-CPUFREQ-01-powernow-k7-No-FSB-KHz.patch
+cpufreq-CPUFREQ-02-core-reduce-warning-msgs.patch
+cpufreq-CPUFREQ-03-speedstep-centrino-P4M-HT-support.patch
+cpufreq-CPUFREQ-04-ondemand-cleanups.patch
+cpufreq-CPUFREQ-05-speedstep-smi-p4m.patch
+cpufreq-CPUFREQ-06-default-governor-warning.patch
+cpufreq-CPUFREQ-07-AMD-Elan-driver.patch

 cpufreq tree

-gregkh-driver.patch

 Dropped

+gregkh-01-driver-gregkh-driver-001_driver-name-const-01.patch
+gregkh-01-driver-gregkh-driver-002_driver-name-const-02.patch
+gregkh-01-driver-gregkh-driver-003_driver-name-const-03.patch
+gregkh-01-driver-gregkh-driver-004_driver-name-const-04.patch
+gregkh-01-driver-gregkh-driver-005_driver-name-const-05.patch
+gregkh-01-driver-gregkh-driver-006_class-01-core.patch
+gregkh-01-driver-gregkh-driver-007_class-02-tty.patch
+gregkh-01-driver-gregkh-driver-008_class-03-input.patch
+gregkh-01-driver-gregkh-driver-009_class-04-usb.patch
+gregkh-01-driver-gregkh-driver-010_class-05-sound.patch
+gregkh-01-driver-gregkh-driver-011_class-06-block.patch
+gregkh-01-driver-gregkh-driver-012_class-07-char.patch
+gregkh-01-driver-gregkh-driver-013_class-08-ieee1394.patch
+gregkh-01-driver-gregkh-driver-014_class-09-scsi.patch
+gregkh-01-driver-gregkh-driver-015_class-10-arch.patch
+gregkh-01-driver-gregkh-driver-016_class-11-drivers.patch
+gregkh-01-driver-gregkh-driver-017_class-12-the_rest.patch
+gregkh-01-driver-gregkh-driver-018_class-13-kerneldoc.patch
+gregkh-01-driver-gregkh-driver-019_class-14-no_more_class_simple.patch
+gregkh-01-driver-gregkh-driver-020_class-15-typo-01.patch
+gregkh-01-driver-gregkh-driver-021_class-16-typo-02.patch
+gregkh-01-driver-gregkh-driver-022_class-17-attribute.patch
+gregkh-01-driver-gregkh-driver-023_klist-01.patch
+gregkh-01-driver-gregkh-driver-024_klist-02.patch
+gregkh-01-driver-gregkh-driver-025_klist-03.patch
+gregkh-01-driver-gregkh-driver-026_klist-04.patch
+gregkh-01-driver-gregkh-driver-027_klist-05.patch
+gregkh-01-driver-gregkh-driver-028_klist-06.patch
+gregkh-01-driver-gregkh-driver-029_klist-07.patch
+gregkh-01-driver-gregkh-driver-030_klist-08.patch
+gregkh-01-driver-gregkh-driver-031_klist-09.patch
+gregkh-01-driver-gregkh-driver-032_klist-10.patch
+gregkh-01-driver-gregkh-driver-033_klist-11.patch
+gregkh-01-driver-gregkh-driver-034_klist-12.patch
+gregkh-01-driver-gregkh-driver-035_klist-13.patch
+gregkh-01-driver-gregkh-driver-036_klist-14.patch
+gregkh-01-driver-gregkh-driver-037_klist-15.patch
+gregkh-01-driver-gregkh-driver-038_klist-16.patch
+gregkh-01-driver-gregkh-driver-039_klist-17.patch
+gregkh-01-driver-gregkh-driver-040_klist-18.patch
+gregkh-01-driver-gregkh-driver-041_klist-scsi-01.patch
+gregkh-01-driver-gregkh-driver-042_klist-scsi-02.patch
+gregkh-01-driver-gregkh-driver-043_klist-20.patch
+gregkh-01-driver-gregkh-driver-044_klist-21.patch
+gregkh-01-driver-gregkh-driver-045_klist-22.patch
+gregkh-01-driver-gregkh-driver-046_klist-23.patch
+gregkh-01-driver-gregkh-driver-047_klist-ieee1394.patch
+gregkh-01-driver-gregkh-driver-048_klist-pcie.patch
+gregkh-01-driver-gregkh-driver-049_klist-24.patch
+gregkh-01-driver-gregkh-driver-050_klist-25.patch
+gregkh-01-driver-gregkh-driver-051_klist-26.patch
+gregkh-01-driver-gregkh-driver-052_klist-usb_node_attached_fix.patch

 Greg's driver tree

-gregkh-i2c.patch

 Dropped

+gregkh-02-i2c-gregkh-i2c-001_i2c-address_range_removal.patch
+gregkh-02-i2c-gregkh-i2c-002_i2c-address_merge_video.patch

 Greg's i2c tree

-bk-ia64.patch

 Dropped

+git-ia64.patch

 Tony Luck's ia64 tree

+git-audit.patch

 Davie Woodhouse'e audit subsystem tree

+netlink-audit-warning-fix.patch

 Fix a warning in it

-bk-jfs.patch

 Dropped

+toshiba-driver-cleanup.patch

 Toshiba legacy driver cleanup

+i8k-pass-through-lindent.patch
+i8k-use-standard-dmi-interface.patch
+i8k-use-standard-dmi-interface-fix.patch
+i8k-convert-to-seqfile.patch
+i8k-initialization-code-cleanup-formatting.patch
+i8k-add-new-bios-signatures.patch

 i8k updates

+jfs-reduce-number-of-synchronous-transactions.patch
+jfs-simplify-creation-of-new-iag.patch
+jfs-changes-for-larger-page-size.patch
+jfs-support-page-sizes-greater-than-4k.patch
+jfs-write-journal-sync-points-more-often.patch
+jfs-dont-allocate-extents-that-overlap-existing-extents.patch

 Dave Kleikamp's JFS tree

-bk-kconfig.patch

 Dropped

+preserve-arch-and-cross_compile-in-the-build-directory-generated-makefile.patch

 kbuild fix

-remove-inter-module-mtd.patch

 Dropped, was wrong.

+natsemi-multicast-initialisation-fix.patch
+r8169-new-pci-id.patch

 Net driver fixes

-gregkh-pci.patch

 Dropped

+gregkh-03-pci-gregkh-pci-001_pci-is_enabled_fix.patch
+gregkh-03-pci-gregkh-pci-002_pci-pci_get_slot-docs.patch
+gregkh-03-pci-gregkh-pci-003_pci-stale_pm_docs.patch
+gregkh-03-pci-gregkh-pci-004_pci-sparse_cleanup.patch
+gregkh-03-pci-gregkh-pci-005_pci-sysfs-pciconfig-readwrite.patch
+gregkh-03-pci-gregkh-pci-006_pci_shutdown.patch
+gregkh-03-pci-gregkh-pci-007_pci-ibmphp-bugfix.patch
+gregkh-03-pci-gregkh-pci-008_pci-hance_quirk.patch
+gregkh-03-pci-gregkh-pci-009_pci-pci-transparent-bridge-handling-improvements-pci-core.patch
+gregkh-03-pci-gregkh-pci-010_pci-pirq_table_addr-out-of-range.patch
+gregkh-03-pci-gregkh-pci-011_pci-get_device-01.patch
+gregkh-03-pci-gregkh-pci-012_pci-get_device-02.patch
+gregkh-03-pci-gregkh-pci-013_pci-acpiphp-01.patch
+gregkh-03-pci-gregkh-pci-014_pci-acpiphp-02.patch
+gregkh-03-pci-gregkh-pci-015_pci-acpiphp-03.patch
+gregkh-03-pci-gregkh-pci-016_pci-acpiphp-04.patch
+gregkh-03-pci-gregkh-pci-017_pci-acpiphp-05.patch

 Greg's PCI tree

+acpi-based-i-o-apic-hot-plug-add-interfaces.patch
+acpi-based-i-o-apic-hot-plug-ia64-support.patch
+acpi-based-i-o-apic-hot-plug-acpiphp-support.patch

 I/O APIC hotplug support

-bk-scsi.patch

 Dropped

+git-scsi-misc.patch

 James's scsi tree

+mptfusion-fix-panic-loading-driver-statically-com.patch

 Fix non-modular MPT-Fusion driver

+git-scsi-rc-fixes.patch

 James's -rc fixes scsi tree

-gregkh-usb.patch

 Dropped

+gregkh-04-USB-gregkh-usb-015_usb-storage_build_fix.patch
+gregkh-04-USB-gregkh-usb-018_usb-airprime.patch
+gregkh-04-USB-gregkh-usb-019_usb-airprime-num_devices.patch
+gregkh-04-USB-gregkh-usb-020_usb-g_file_storage_min.patch
+gregkh-04-USB-gregkh-usb-021_usb-g_file_storage_stall.patch
+gregkh-04-USB-gregkh-usb-022_usb-ehci_power_fixes.patch
+gregkh-04-USB-gregkh-usb-023_usb-omap_udc_update.patch
+gregkh-04-USB-gregkh-usb-024_usb-isp116x-hcd-add.patch
+gregkh-04-USB-gregkh-usb-025_usb-isp116x-hcd-fix.patch
+gregkh-04-USB-gregkh-usb-026_usb-turn-a-user-mode-driver-error-into-a-hard-error.patch
+gregkh-04-USB-gregkh-usb-027_usb-uhci-01.patch
+gregkh-04-USB-gregkh-usb-028_usb-uhci-02.patch
+gregkh-04-USB-gregkh-usb-029_usb-uhci-03.patch
+gregkh-04-USB-gregkh-usb-030_usb-uhci-04.patch
+gregkh-04-USB-gregkh-usb-031_usb-uhci-05.patch
+gregkh-04-USB-gregkh-usb-032_usb-uhci-06.patch
+gregkh-04-USB-gregkh-usb-033_usb-uhci-07.patch
+gregkh-04-USB-gregkh-usb-034_usb-root_hub_irq.patch
+gregkh-04-USB-gregkh-usb-035_usb-cdc_acm.patch
+gregkh-04-USB-gregkh-usb-036_usb-usbtest.patch
+gregkh-04-USB-gregkh-usb-037_usb-ohci_reboot_notifier.patch
+gregkh-04-USB-gregkh-usb-038_usb_serial_status.patch
+gregkh-04-USB-gregkh-usb-039_usb-zd1201_pm.patch
+gregkh-04-USB-gregkh-usb-040_usb-remove_hub_set_power_budget.patch
+gregkh-04-USB-gregkh-usb-041_usb-device_pointer.patch
+gregkh-04-USB-gregkh-usb-042_usb-hcd_fix_for_remove_hub_set_power_budget.patch
+gregkh-04-USB-gregkh-usb-043_usb-usbcore_usb_add_hcd.patch
+gregkh-04-USB-gregkh-usb-044_usb-hcds_no_more_register_root_hub.patch

 Greg's USB tree

+mm-kconfig-kill-unused-arch_flatmem_disable.patch
+mm-kconfig-hide-memory-model-selection-menu.patch
+mm-kconfig-give-discontig-more-help-text.patch
+ppc64-kconfig-memory-models.patch

 More sparsemem preparatory work

+generic_file_buffered_write-fixes.patch

 pagecache I/O function fixes

+rlimit_as-checking-fix.patch

 Fix checking of RLIMIT_AS

+mm-add-proc-zoneinfo.patch
+mm-add-proc-zoneinfo-tidy.patch

 Add /proc/zoneinfo

+mm-rmapc-cleanup.patch

 rmap.c cleanup

+mm-pcp-use-non-powers-of-2-for-batch-size.patch

 Cache-colouring friendliness in per-cpu-pages

+mempool-nomemalloc-and-noretry.patch
+mempool-simplify-alloc.patch
+mempool-simplify-alloc-fix.patch
+mm-use-__gfp_nomemalloc.patch

 Various mm cleanups

+doc-locking-update.patch

 Update VFS Locking document

+count-bounce-buffer-pages-in-vmstat.patch

 Add bounce-buffer accounting to /proc/vmstat

+rlimit_memlock-checking-fix.patch

 Fix checking of RLIMIT_MEMLOCK

+sync_page-smp_mb-comment.patch

 Comment update

+vm-merge_lru_pages.patch
+vm-page-cache-reclaim-core.patch
+vm-page-cache-reclaim-core-tidy.patch
+vm-reclaim_page_cache_node-syscall.patch
+vm-reclaim_page_cache_node-syscall-x86.patch
+vm-automatic-reclaim-through-mempolicy.patch

 A whole bunch of stuff to permit program-controlled freeing of per-zone
 pagecache pages.  For big NUMA machines.  This will probably be dropped -
 seems too complex.

+mpage_writepages-page-locking-fix.patch
+drop-buffers-oops-fix.patch

 VFS fixes

+proc-pid-smaps.patch
+proc-pid-smaps-tidy.patch

 Add /proc/pid/smaps: detailed info about each vma's occupancy

+netfilter-debug-locking-fix.patch
+wireless-3crwe154g72-kconfig-help-fix.patch
+smc91c92_cs-reduce-stack-usage-in-smc91c92_event.patch
+typo-in-tulip-driver.patch
+tulip-fixes-for-uli5261.patch

 Net fixes

-chelsio-build-fix.patch

 Folded into a-new-10gb-ethernet-driver-by-chelsio-communications.patch

+selinux-cleanup-ipc_has_perm.patch
+selinux-add-finer-grained-permissions-to-netlink-audit.patch

 SELinux fixes

+ppc32-refactor-fpu-exception-handling-2.patch
+ppc32-fix-for-misreported-sdram-size-on-radstone-ppc7d-platform.patch
+ppc32-add-rtc-hooks-in-ppc7d-platform-file.patch
+ppc32-fix-ide-related-crash-on-wakeup.patch
+macintosh-adbhidc-adb-buttons-support-for.patch
+ppc32-fix-a-sleep-issues-on-some-laptops.patch
+ppc32-fix-address-checking-on-lmw-stmw-align-exception.patch
+ppc32-workaround-for-spurious-irqs-on-pq2.patch
+ppc64-improve-g5-sound-headphone-mute.patch
+ppc32-add-sound-support-for-mac-mini.patch
+pmac-save-master-volume-on-sleep.patch
+ppc64-add-pt_note-section-to-vdso.patch
+ppc64-remove-unused-argument-to-create_slbe.patch
+ppc64-fix-irq-parsing-on-powermac.patch
+ppc64-nvram-cleanups.patch
+ppc64-update-to-use-the-new-4l-headers.patch
+ppc64-tell-firmware-about-kernel-capabilities.patch
+ppc64-remove-hot-busy-wait-loop-in-__hash_page.patch
+ppc64-noexec-fixes.patch
+ppc64-remove-unnecessary-include.patch
+ppc64-firmware-workaround.patch
+ppc64-enforce-medium-thread-priority-in-hypervisor-calls.patch
+ppc64-use-smp_mb-and-smp_wmb.patch
+use-smp_mb-wmb-rmb-where-possible.patch
+ppc64-reverse-prediction-on-spinlock-busy-loop-code.patch
+ppc64-fix-32-bit-signal-frame-back-link.patch

 ppc32/ppc64 updates

+x86-reboot-add-reboot-fixup-for-gx1-cs5530a.patch
+x86-entrys-trap-return-fixes.patch
+enable-write-combining-for-server-works-le-rev-6.patch
+platform-smis-and-their-interferance-with-tsc-based-delay-calibration.patch
+cpuid-bug-and-inconsistency-fix.patch
+i386-fix-hpet-for-systems-that-dont-support.patch
+irq-and-pci_ids-for-intel-ich7dh-ich7-m-dh.patch
+hda_intel-intel-esb2-support.patch
+x86-port-lockless-mce-preparation.patch
+x86-port-lockless-mce-implementation.patch
+x86-port-lockless-mce-implementation-fix.patch
+cpuid-x87-bit-on-amd-falsely-marked-as-pni.patch
+x86_64-interrupt-handling-fix.patch
+increase-number-of-e820-entries-hard-limit-from-32-to-128.patch
+broadcast-ipi-race-condition-on-cpu-hotplug.patch
+linux-26x-vm86-interrupt-emulation-fixes.patch

 Lots of x86 updates

+x86_64-dont-assume-bp-to-be-the-first-one-in-madt-mps.patch
+x86_64-i8259c-iso99-structure-initialization.patch
+x86-64-handle-empty-e820-regions-correctly.patch
+x86_64-fix-hpet-for-systems-that-dont-support-legacy.patch
+x86_64-saved_command_line-overflow-fix.patch
+x86-x86_64-deferred-handling-of-writes-to-proc-irq-xx-smp_affinitypatch-added-to-mm-tree.patch

 x86_64 updates

+xen-x86-add-macro-for-debugreg.patch
+xen-x86-use-new-macro-for-debugreg.patch
+xen-x86-rename-usermode-macro.patch
+xen-x86-rename-usermode-macro-fix.patch
+xen-x86-use-more-usermode-macro.patch
+xen-x86_64-add-macro-for-debugreg.patch
+xen-x86_64-use-more-usermode-macro.patch

 Preparatory abstractions for Xen support

+sep-initializing-rework.patch
+sibling-map-initializing-rework.patch
+init-call-cleanup.patch
+cpu-state-clean-after-hot-remove.patch
+cpu-state-clean-after-hot-remove-fix.patch
+physical-cpu-hot-add.patch
+suspend-resume-smp-support.patch
+suspend-resume-smp-support-fix-2.patch
+swsusp-documentation-updates.patch
+swsusp-kill-config_pm_disk.patch
+s-t-ram-load-gdt-the-right-way.patch
+acpi-fix-video-docs.patch
+properly-stop-devices-before-poweroff.patch
+properly-stop-devices-before-poweroff-fix.patch
+hp100-fix-card-names.patch
+swsusp-kill-unneccessary-does_collide_order.patch
+swsusp-cleanup-whitespace.patch
+swsusp-fix-nr_copy_pages.patch

 Power management stuff

+uml-fix-oops-related-to-exception-table.patch
+uml-add-nfsd-syscall-when-nfsd-is-modular.patch
+uml-fix-handling-of-no-fpx_regs.patch
+uml-workaround-old-problematic-sed-behaviour.patch
+uml-support-aes-i586-crypto-driver.patch
+uml-inline-empty-proc.patch
+uml-move-va_copy-conditional-def.patch
+uml-fix-syscall-table-by-including-subarchs-one-for-i386.patch
+uml-quick-fix-syscall-table-for-x86_64.patch
+uml-fix-syscall-table-by-including-subarchs-one-for-x86-64.patch
+uml-redo-console-locking.patch
+uml-hostfs-avoid-buffers.patch
+uml-commentary-about-forking-flag.patch
+uml-ubd-handle-readonly-status.patch

 UML updates

+s390-regenerate-defconfig.patch
+s390-idle-timer-setup.patch
+s390-fix-memory-holes-and-cleanup-setup_arch.patch
+s390-default-storage-key.patch
+s390-cmm-guest-sender-id.patch
+s390-allow-longer-debug-feature-names.patch
+s390-dasd-readonly-attribute.patch
+s390-enable-write-barriers-in-the-dasd-driver.patch
+s390-dont-pad-cdl-blocks-for-write-requests.patch
+s390-remove-ioctl32-from-dasdcmb.patch
+s390-remove-ioctl32-from-crypto-driver.patch
+s390-cio-documentation.patch

 S/390 update

+blk-use-find_first_zero_bit-in-blk_queue_start_tag.patch
+blk-remove-blk_queue_tag-real_max_depth-optimization.patch
+blk-remove-blk_tags_per_longmask.patch
+blk-cleanup-generic-tag-support-error-messages.patch

 Block layer cleanups

+create-a-kstrdup-library-function-ppc-fix.patch
+kstrdup-convert-a-few-existing-implementations.patch

 kstrdup() fixes

+kprobes-incorrect-handling-of-probes-on-ret-lret-instruction.patch
+kprobes-oops-in-unregister_kprobe.patch

 kprobes fixes

+patch-kernel-support-non-incremental-26xy-stable-patches.patch

 Mysterious kbuild futzing

+lifeview-flytv-platinum-fm-remote-control-support.patch
+lifeview-flytv-platinum-fm-remote-control-support-fix.patch

 v4l device support

+kallsyms-c_symbol_prefix-support.patch

 kallsyms fix

+noop-iosched-kill-on-merge-scan.patch

 Make the no-op scheduler more no-oppy

+add-eownerdead-and-enotrecoverable-version-2.patch

 Add errnos for robust mutexes

+nbd-dont-create-all-max_nbd-devices-by-default-all-the-time.patch
+nbd-dont-create-all-max_nbd-devices-by-default-all-the-time-fix.patch

 Redce nbd reosurce consumption

+fix-rewriting-on-a-full-reiserfs-filesystem.patch

 reiserfs fix

+generate-hotplug-events-for-cpu-online.patch

 CPU hotplug feature

+vgacon-set-vc_hi_font_mask-correctly.patch

 vgacon fix

+hangcheck-timer-update-to-090.patch

 hangcheck timer update

+w1_therm-support-for-ds18b20-ds1822-thermal-sensors.patch

 w1 driver update

+3c59x-only-put-the-device-into-d3-when-were-actually-using-wol.patch

 3c59x power management fix

+consolidate-sigev_pad_size.patch

 cleanup

+misc-verify_area-cleanups.patch

 cleanup

+__attribute__-placement-fixes.patch

 Be more consistent about placement of gcc extended keywords.

+leadtek-winfast-remote-controls.patch

 Leadtek Winfast IR driver remote controls.

+fix-race-in-__block_prepare_write.patch
+fix-race-in-block_write_full_page.patch

 VFS fixes

+reiserfs-journal_init-fix.patch

 resierfs fix

+dontdiff-file-sorted-in-alphabet-order.patch

 Alphasort the dontdiff file

+optimise-loop-driver-a-bit.patch
+optimise-loop-driver-a-bit-tidy.patch

 Speed up the loop driver

+ipmi-fix-for-handling-bad-dmi-data.patch
+ipmi-fix-for-handling-bad-acpi-data.patch
+ipmi-fix-watchdog-so-the-device-can-be-reopened-on-an-unexpected-close.patch
+ipmi-enable-interrupts-on-the-bt-driver.patch
+ipmi-fix-a-deadlock.patch

 IPMI driver updates

+streamline-preempt_count-type-across-archs.patch
+preempt_count-is-int-remove-cast-and-dont-assign-to.patch

 Regularise preempt_count

+sn_console-make-sal_console_uart-static-again.patch

 Make a symbol static

+consolidate-sys_shmat.patch

 cleanup

+remove-redundant-vm_flags-clearing-from-madvisec.patch

 Remove unneeded code

+fix-tpm-driver-maintainers-entry.patch

 MAINTAINERS update

+fortuna-random-driver-fix.patch

 halfmd4.o needs to be unconditionally linked

+new-valid_signal-function.patch
+convert-code-that-currently-tests-_nsig-directly-to-use-valid_signal.patch

 Clean up and fix _NSIG checking.

+fix-include-order-in-mthca_memfreec.patch

 infiniband driver niceness

+scan-all-enabled-ports-on-ata_piix.patch

 Intel PIIX fix

+serial_cs-reduce-stack-usage-in-serial_event.patch

 Reduce stack consumption

+makefile-fix-for-compatibility-with-emacs-ctags.patch

 ctags fix

+timeout-at-boottime-with-nec3500a-and-others-when-inserted-a-cd-in-it.patch

 Some CDROMs are really slow

+add-check-to-proc-devices-read-routines.patch

 Add overrun checking to /proc/devices handler

+aio-remove-superfluous.patch
+aio-ring-tail.patch
+aio-remove-debug.patch
+aio-run-iocb.patch

 AIO fixes

+hfs-hfsplus-dont-leak-s_fs_info-and-fix-an-oops.patch

 HFS filesystem fix

-inotify-022-for-2612-rc1-mm4.patch
+inotify-44.patch

 Another inotify release

+reiserfs-endianness-clone-struct-reiserfs_key.patch
+reiserfs-endianness-annotate-little-endian-objects.patch
+reiserfs-endianness-fix-endianness-bugs.patch
+reiserfs-endianness-comp_short_keys-cleanup.patch
+reiserfs-endianness-sanitize-reiserfs_key-union.patch

 reiserfs endianness fixes

+cx88-dvb-oops-fix.patch
+dvb-cx22702-frontend-driver-update.patch
+v4l-msp3400-update.patch

 Media driver updates

+ext3-reduce-allocate-with-reservation-lock-latencies.patch
+ext3-reduce-allocate-with-reservation-lock-latencies-tidy.patch

 ext3 latency reduction

+kgdb-move-config-option-for-bad_syscall_exit.patch
+kgdb-fix-bad_syscall_exit-lockup.patch
+kgdb-x86_64-support-fix.patch

 kgdb fixes

+rock-remove-MAYBE_CONTINUE-fix.patch

 Fix rock-remove-MAYBE_CONTINUE.patch

-perfctr-core.patch
-perfctr-i386.patch
-perfctr-x86-core-updates.patch
-perfctr-x86-driver-updates.patch
-perfctr-x86-driver-cleanup.patch
-perfctr-prescott-fix.patch
-perfctr-x86-update-2.patch
-perfctr-x86_64.patch
-perfctr-x86_64-core-updates.patch
-perfctr-ppc.patch
-perfctr-ppc32-driver-update.patch
-perfctr-ppc32-mmcr0-handling-fixes.patch
-perfctr-ppc32-update.patch
-perfctr-ppc32-update-2.patch
-perfctr-virtualised-counters.patch
-perfctr-remap_page_range-fix.patch
-virtual-perfctr-illegal-sleep.patch
-make-perfctr_virtual-default-in-kconfig-match-recommendation.patch
-perfctr-ifdef-cleanup.patch
-perfctr-update-2-6-kconfig-related-updates.patch
-perfctr-virtual-updates.patch
-perfctr-virtual-cleanup.patch
-perfctr-ppc32-preliminary-interrupt-support.patch
-perfctr-update-5-6-reduce-stack-usage.patch
-perfctr-interrupt-support-kconfig-fix.patch
-perfctr-low-level-documentation.patch
-perfctr-inheritance-1-3-driver-updates.patch
-perfctr-inheritance-2-3-kernel-updates.patch
-perfctr-inheritance-3-3-documentation-updates.patch
-perfctr-inheritance-locking-fix.patch
-perfctr-api-changes-first-step.patch
-perfctr-virtual-update.patch
-perfctr-x86-64-ia32-emulation-fix.patch
-perfctr-sysfs-update-1-4-core.patch
-perfctr-sysfs-update.patch
-perfctr-sysfs-update-2-4-x86.patch
-perfctr-sysfs-update-3-4-x86-64.patch
-perfctr-sysfs-update-4-4-ppc32.patch
-perfctr-2710-api-update-1-4-common.patch
-perfctr-2710-api-update-2-4-i386.patch
-perfctr-2710-api-update-3-4-x86_64.patch
-perfctr-2710-api-update-4-4-ppc32.patch
-perfctr-api-update-1-9-physical-indexing-x86.patch
-perfctr-api-update-2-9-physical-indexing-ppc32.patch
-perfctr-api-update-3-9-cpu_control_header-x86.patch
-perfctr-api-update-4-9-cpu_control_header-ppc32.patch
-perfctr-api-update-5-9-cpu_control_header-common.patch
-perfctr-api-update-6-9-cpu_control-access-common.patch
-perfctr-api-update-7-9-cpu_control-access-x86.patch
-perfctr-api-update-8-9-cpu_control-access-ppc32.patch
-perfctr-api-update-9-9-domain-based-read-write-syscalls.patch
-perfctr-ia32-syscalls-on-x86-64-fix.patch
-perfctr-cleanups-1-3-common.patch
-perfctr-cleanups-2-3-ppc32.patch
-perfctr-cleanups-3-3-x86.patch
-perfctr-x86-fix-and-cleanups.patch
-perfctr-ppc32-fix-and-cleanups.patch
-perfctr-64-bit-values-in-register-descriptors.patch
-perfctr-64-bit-values-in-register-descriptors-fix.patch
-perfctr-mapped-state-cleanup-x86.patch
-perfctr-mapped-state-cleanup-ppc32.patch
-perfctr-mapped-state-cleanup-common.patch
-perfctr-ppc64-arch-hooks.patch
-perfctr-common-updates-for-ppc64.patch
-perfctr-ppc64-driver-core.patch
-perfctr-x86-abi-update.patch
-perfctr-ppc32-abi-update.patch
-perfctr-ppc64-abi-update.patch
+perfctr.patch

 Roll all the perfctr work into a single patch (for now)

+sched2-fix-smt-scheduling-problems-fix.patch

 Folded into sched2-fix-smt-scheduling-problems.patch

+sched-remove-degenerate-domains-fix.patch

 Folded into sched-remove-degenerate-domains.patch

+sched-rcu-domains-fix.patch

 Folded into sched-rcu-domains.patch

-sched-unlocked-context-switches.patch

 Dropped - nasty buggy.

+sched-changing-rt-priority-without-cap_sys_nice.patch

 Permit tasks to reduce their realtime priority without CAP_SYS_NICE

+saa7134-add-oem-version-of-already-supported-card.patch

 saa driver update

+split-general-cache-manager-from-cachefs-fix.patch

 Fix split-general-cache-manager-from-cachefs.patch

+kexec-disable-preempt-in-panic.patch
+kexec-kexec-generic-fix.patch
+x86_64-kexec-build-fix.patch

 kexec fixes

+kexec-s390-support.patch
+s390-kexec-fixes.patch

 kexec-for-s390

+kdump-documentation-for-kdump-update.patch

 Update kdump documentation

-add-acpi-based-floppy-controller-enumeration.patch

 Dropped - we won't need this

+serial-update-nec-vr4100-series-serial-support.patch
+serial-add-siig-quartet-support.patch

 MIPS serial driver updates

+altix-ioc4-serial-set-hfc-from-ioctl.patch
+altix-ioc4-serial-set-a-better-timeout-threshold.patch
+altix-ioc4-serial-small-uart-setup-mods.patch
+altix-ioc4-serial-arm-the-read-timeout-timer-before-the-first-read.patch

 Altix serial driver updates

-kfree_skb-dump_stack.patch

 Debug stuff dropped

+nvidiafb-ioremap-and-i2c-fixes.patch
+nvidiafb-ioremap-and-i2c-fixes-fix.patch
+fbdev-edidh-cleanups.patch
+fbcon-fix-check-after-use.patch
+intelfb-remove-intelfbdrvh.patch
+i810fb-fix-default-monitor-sync-timings.patch
+imxfb-add-freescale-imx-framebuffer-driver.patch
+better-pll-frequency-matching-for-tdfxfb-driver.patch
+clean-up-and-bug-fix-for-tdfxfb-framebuffer-size-detection.patch

 framebuffer driver updates

+md-allow-md-to-update-multiple-superblocks-in-parallel-fix.patch

 Fix md-allow-md-to-update-multiple-superblocks-in-parallel.patch

+docbook-use-custom-stylesheet.patch
+docbook-fix-html-link.patch

 kernel-doc fixes

+documentation-remove-super-nr-max-to-reflect-fs-superc.patch

 Documentation fix

+fuse-device-functions-comments-and-documentation-document-security-measures.patch
+fuse-read-only-operations-multiple-links-to-directory-fix.patch
+fuse-file-operations-interrupted-open-fix.patch
+fuse-mount-options-reference-counting-fix.patch
+fuse-mount-options-remove-allow_root-mount-option.patch
+fuse-tighten-check-for-processes-allowed-access.patch
+fuse-direct-i-o-disable-sendfile-with-direct_io.patch
+fuse-direct-i-o-nfsd-with-direct_io-fix.patch
+fuse-add-fsync-operation-for-directories-fix.patch

 FUSE updates

+alsa-3073.patch
+alsa-3074.patch
+alsa-3075.patch
+alsa-3076.patch
+alsa-3077.patch
+alsa-3078.patch
+alsa-3079.patch
+alsa-3080.patch
+alsa-3081.patch
+alsa-3082.patch
+alsa-3083.patch
+alsa-3084.patch
+alsa-3085.patch
+alsa-3086.patch
+alsa-3087.patch
+alsa-3088.patch
+alsa-3091.patch
+alsa-3092.patch
+alsa-3093.patch
+alsa-3094.patch
+alsa-3095.patch
+alsa-3096.patch
+alsa-3097.patch
+alsa-3098.patch
+alsa-3099.patch
+alsa-3100.patch
+alsa-3101.patch
+alsa-3102.patch
+alsa-3103.patch
+alsa-3104.patch
+alsa-3105.patch
+alsa-3106.patch
+alsa-3107.patch
+alsa-3108.patch
+alsa-3111.patch
+alsa-3112.patch
+alsa-3113.patch
+alsa-3114.patch
+alsa-3115.patch
+alsa-3116.patch
+alsa-3117.patch
+alsa-3118.patch
+alsa-3119.patch
+alsa-3120.patch
+alsa-3121.patch
+alsa-3122.patch
+alsa-3123.patch
+alsa-3126.patch
+alsa-3128.patch
+alsa-3129.patch
+alsa-3130.patch
+alsa-3131.patch
+alsa-3132.patch
+alsa-3133.patch
+alsa-3134.patch
+alsa-3135.patch
+alsa-3136.patch
+alsa-3137.patch
+alsa-3138.patch
+alsa-3139.patch
+alsa-3140.patch
+alsa-3141.patch

 ALSA tree

+drivers-serial-8250c-make-a-variable-static.patch
+kernel-irq-spuriousc-make-a-function-static.patch
+drivers-media-video-bttv-driverc-make-2-functions-static.patch
+drivers-media-video-cx88-possible-cleanups.patch
+drivers-media-video-saa7134-saa7134-dvbc-make-a-struct-static.patch

 Make a few symbols static

+fs-udf-udftimec-fix-off-by-one-error.patch

 UDF fix

+drivers-scsi-dpt-remove-versionh-dependencies.patch
+sound-oss-sscapec-remove-dead-code.patch

 Cleanups

+unexport-uts_sem.patch

 Don't export uts_sem to modules



number of patches in -mm: 963
number of changesets in external trees: 468
number of patches in -mm only: 950
total patches: 1418



All 963 patches:

See ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm1/patch-list

