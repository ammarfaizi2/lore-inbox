Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVANI1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVANI1E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 03:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVANI1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 03:27:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:9136 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261231AbVANIYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 03:24:12 -0500
Date: Fri, 14 Jan 2005 00:23:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc1-mm1
Message-Id: <20050114002352.5a038710.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc1/2.6.11-rc1-mm1/


- Added bk-xfs to the -mm "external trees" lineup.

- Added the Linux Trace Toolkit (and hence relayfs).  Mainly because I
  haven't yet taken as close a look at LTT as I should have.  Probably neither
  have you.

  It needs a bit of work on the kernel<->user periphery, which is not a big
  deal.

  As does relayfs, IMO.  It seems to need some regularised way in which a
  userspace relayfs client can tell relayfs what file(s) to use.  LTT is
  currently using some ghastly stick-a-pathname-in-/proc thing.  Relayfs
  should provide this service.

  relayfs needs a closer look too.  A lot of advanced instrumentation
  projects seem to require it, but none of them have been merged.  Lots of
  people say "use netlink instead" and lots of other people say "err, we think
  relayfs is better".  This is a discussion which needs to be had.

- The 2.6.10-mm3 announcement was munched by the vger filters, sorry.  One of
  the uml patches had an inopportune substring in its name (oh pee tee hyphen
  oh you tee).  Nice trick if you meant it ;)

- Big update to the ext3 extended attribute support.  agruen, tridge and sct
  have been cooking this up for a while.  samba4 proved to be a good
  stress test.

- davej's "2.6 post-Halloween features" document has been added to -mm as
  Documentation/feature-list-2.6.txt in the hope that someone will review it
  and help keep it up-to-date.

- Added FUSE (filesystem in userspace) for people to play with.  Am agnostic
  as to whether it should be merged (haven't read it at all closely yet,
  either), but I am impressed by the amount of care which has obviously gone
  into it.  Opinions sought.




Changes since 2.6.10-mm3:


 linus.patch
 bk-alsa.patch
 bk-arm.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-drm-via.patch
 bk-i2c.patch
 bk-ide-dev.patch
 bk-input.patch
 bk-dtor-input.patch
 bk-kbuild.patch
 bk-kconfig.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-pci.patch
 bk-usb.patch
 bk-xfs.patch

 Latest versions of everyone's bk trees.

-m32r-include-nodemaskh-for-build-fix.patch
-acpi_smp_processor_id-warning-fix.patch
-sn2-trivial-nodemaskh-include-fix.patch
-split-bprm_apply_creds-into-two-functions.patch
-merge-_vm_enough_memorys-into-a-common-helper.patch
-ppc64-fix-iommu-cleanup-regression.patch
-ppc64-rename-perf-counter-register-defines.patch
-dmi_iterate-fix.patch
-arch-i386-kernel-cpu-mtrr-too-many-bits-are-masked-off-from-cr4.patch
-pm-introduce-pm_message_t.patch
-mark-older-power-managment-as-deprecated.patch
-swsusp-device-power-management-fix.patch
-swsusp-properly-suspend-and-resume-all-devices.patch
-m32r-employ-new-kernel-api-abi.patch
-m68k-update-defconfigs-for-2610.patch
-mmc_wbsd-depends-on-isa.patch
-m68k-remove-nowhere-referenced-files.patch
-direct-write-vs-truncate-deadlock.patch
-random-whitespace-cleanups.patch
-random-remove-pool-resizing-sysctl.patch
-cciss-update-to-version-264.patch
-reiserfs-vs-8115-test-adjustment.patch
-export-get_sb_pseudo.patch
-proc_kcore-correct-double-accounting-of-elf_buflen.patch
-remove-intermezzo-maintainers-entry.patch
-3c59x-reload-eeprom-values-at-rmmod-for-needy-cards.patch
-3c59x-remove-eeprom_reset-for-3c905b.patch
-3c59x-add-eeprom_reset-for-3c900-boomerang.patch
-3c59x-pm-fix.patch
-3c59x-missing-pci_disable_device.patch
-3c59x-use-netdev_priv.patch
-3c59x-make-use-of-generic_mii_ioctl.patch
-3c59x-vortex-select-mii.patch
-3c59x-support-more-ethtool_ops.patch
-inux-269-fs-proc-basec-array-size.patch
-linux-269-fs-proc-proc_ttyc-avoid-array.patch
-optimize-prefetch-usage-in-list_for_each_xxx.patch
-signalc-convert-assertion-to-bug_on.patch
-right-severity-level-for-fatal-message.patch
-remove-unused-drivers-char-rio-cdprotoh.patch
-remove-unused-drivers-char-rsf16fmih.patch
-mtd-added-nec-upd29f064115-support.patch
-ide-cd-is-very-noisy.patch
-signedness-fix-in-deadline-ioschedc.patch
-cleanup-virtual-console-selectionc-interface.patch
-warn-about-cli-sti-co-uses-even-on-up.patch
-remove-umsdos-from-tree.patch
-kill-quota_v2c-printk-of-size_t-warning.patch
-silence-numerous-size_t-warnings-in-drivers-acpi-processor_idlec.patch
-make-irda-string-tables-conditional-on-config_irda_debug.patch
-fix-unresolved-mtd-symbols-in-scx200_docflashc.patch
-fix-module_param-type-mismatch-in-drivers-char-n_hdlcc.patch
-drivers-char-misc-cleanups.patch
-pktcdvd-make-two-functions-static.patch
-pktcdvd-grep-friendly-function-prototypes.patch
-pktcdvd-small-documentation-update.patch
-isofs-remove-useless-include.patch
-synaptics-remove-unused-struct-member-variable.patch
-kill-one-if-x-vfreex-usage.patch
-smbfs-make-some-functions-static.patch
-mips-fixed-build-error-about-nec-vr4100-series.patch
-efs-make-a-struct-static-fwd.patch
-fs-ext3-possible-cleanups.patch
-fs-ext2-xattrc-make-ext2_xattr_list-static.patch
-fs-hugetlbfs-inodec-make-4-functions-static.patch
-remove-nr_super-define.patch
-i2o-fix-init-exit-section-usage.patch
-use-modern-format-for-pci-apic-irq-transform-printks.patch
-coda-bounds-checking.patch
-coda-use-list_for_each_entry_safe.patch
-coda-make-global-code-static.patch
-coda-remove-unused-coda_mknod.patch
-coda-rename-coda_psdev-to-coda.patch
-remove-outdated-smbfs-changelog.patch
-update-geerts-address-in-credits.patch
-cputime-introduce-cputime.patch
-cputime-microsecond-based-cputime-for-s390.patch
-4level-swapoff-hang-fix.patch
-snd-intel8x0-ac97-quirk-entries-for-hp-xw6200-xw8000.patch
-igxb-build-fix.patch
-eepro-build-fix.patch
-3c515-warning-fix.patch
-ixgb-whitespace-fix.patch
-fix-expand_stack-smp-race.patch
-ppc-fix-idle-with-interrupts-disabled.patch
-ppc-remove-duplicate-define.patch
-ppc-include-missing-header.patch
-ppc64-move-hotplug-cpu-functions-to-smp_ops.patch
-ppc64-kprobes-breaks-bug-handling.patch
-ppc64-fix-numa-build.patch
-ppc64-enhance-oops-printing.patch
-ppc64-fix-xmon-longjmp-handling.patch
-ppc64-make-xmon-print-bug-warnings.patch
-ppc64-xtime-gettimeofday-can-get-out-of-sync.patch
-ppc64-pci-cleanup.patch
-ppc64-remove-flush_instruction_cache.patch
-ppc64-interrupt-code-cleanup.patch
-ppc64-fix-rtas_set_indicator9005.patch
-ppc64-make-numa-code-handle-unexpected-layouts.patch
-ppc64-semicolon-in-rtasdc.patch
-improved-wait_8254_wraparound.patch
-kprobes-dont-steal-interrupts-from-vm86.patch
-apic-lapic-hanging-problems-on-nforce2-system.patch
-x86_64-work-around-another-aperture-bios-bug-on-opteron.patch
-x86_64-hack-to-disable-clustered-mode-on-amd-systems.patch
-x86_64-updates-for-x86-64-boot-optionstxt.patch
-x86_64-update-defconfig.patch
-x86_64-remove-old-checksumc.patch
-x86_64-fix-sparse-warnings.patch
-x86_64-fix-some-gcc-4-warnings-in-arch-x86_64.patch
-i386-port-missing-cpuid-bits-from-x86-64-to-i386.patch
-i386-amd-dual-core-support-for-i386.patch
-i386-count-both-multi-cores-and-smp-siblings-in.patch
-i386-count-both-multi-cores-and-smp-siblings-in-fix.patch
-i386-export-phys_proc_id.patch
-x86_64-move-memset_io-out-of-line-to-avoid-warnings.patch
-x86_64-fix-ioremap-attribute-restoration-on-i386-and.patch
-x86_64-fix-tlb-reporting-on-k8.patch
-x86_64-change_page_attr-logic-fixes-from-andrea.patch
-x86_64-fix-mptables-printk.patch
-x86_64-add-new-key-syscalls.patch
-x86_64-remove-direct-mem_map-references.patch
-x86_64-remove-check-that-limited-max-number-of-io-apic.patch
-x86_64-prevent-gcc-from-generating-mmx-code-by-mistake.patch
-x86_64-dont-sync-apic-arbs-on-p4s.patch
-x86_64-cleanups-preparing-for-memory-hotplug.patch
-x86_64-remove-unused-prototypes.patch
-x86_64-fix-a-lot-of-broken-white-space-in.patch
-x86_64-fix-signal-fpu-leak-on-i386-and-x86-64.patch
-x86_64-disable-conforming-bit-on-user32_cs-segment.patch
-x86_64-notify-user-of-mce-events.patch
-uml-add-some-pudding.patch
-uml-use-va_end-wherever-va_args-are-used.patch
-uml-split-out-arch-specific-syscalls-from-generic-ones.patch
-uml-three-level-page-table-support.patch
-uml-x86-64-core-support.patch
-uml-x86-64-config-support.patch
-uml-factor-out-register-saving-and-restoring.patch
-uml-x86_64-ptrace-support.patch
-uml-separate-out-signal-reception.patch
-uml-make-a-common-misconfiguration-impossible.patch
-uml-separate-out-the-time-code.patch
-uml-x86-64-headers.patch
-uml-split-out-arch-link-address-definitions.patch
-uml-dont-use-__nr_waitpid-on-arches-which-dont-have-it.patch
-uml-use-va_copy.patch
-uml-code-tidying.patch
-uml-use-for_each_cpu.patch
-uml-2610-ptrace-updates.patch
-uml-add-the-new-syscalls.patch
-uml-64-bit-cleanups.patch
-uml-silence-some-message-from-the-console-driver.patch
-uml-add-a-missing-include.patch
-uml-sparse-annotations.patch
-uml-fix-sys_call_table-syntax.patch
-uml-fix-make-clean.patch
-uml-define-config_input-better.patch
-uml-fix-a-compile-warning.patch
-seclvl-add-missing-dependency.patch
-binfmt_elf-fix-return-error-codes-and-early-corrupt-binary-detection.patch
-fix-setattr-attr_size-locking-for-nfsd.patch
-pcmcia-new-ds-cs-interface.patch
-pcmcia-call-device-drivers-from-ds-not-from-cs.patch
-pcmcia-unify-bind_mtd-and-pcmcia_bind_mtd.patch
-pcmcia-unfiy-bind_device-and-pcmcia_bind_device.patch
-pcmcia-device-model-integration-can-only-be-submitted-under-gpl.patch
-pcmcia-add-pcmcia_devices.patch
-pcmcia-remove-socket_bind_t-use-pcmcia_devices-instead.patch
-pcmcia-remove-internal-module-use-count-use-module_refcount-instead.patch
-pcmcia-set-drivers-owner-field.patch
-pcmcia-move-pcmcia_unregister_client-to-ds.patch
-pcmcia-device-model-integration-can-only-be-submitted-under-gpl-part-2.patch
-pcmcia-use-kref-instead-of-native-atomic-counter.patch
-pcmcia-add-pcmcia_putget_socket.patch
-pcmcia-grab-a-reference-to-the-cs-socket-in-ds.patch
-pcmcia-get-a-reference-to-ds-socket-for-each-pcmcia_device.patch
-pcmcia-add-a-pointer-to-client-in-struct-pcmcia_device.patch
-pcmcia-use-pcmcia_device-in-send_event.patch
-pcmcia-use-pcmcia_device-to-mark-clients-as-stale.patch
-pcmcia-code-moving-in-ds.patch
-pcmcia-use-pcmcia_device-in-register_client.patch
-pcmcia-direct-ordered-unbind-of-devices.patch
-pcmcia-bug-on-dev_list-=-null.patch
-pcmcia-bug-if-clients-are-kept-too-long.patch
-pcmcia-move-struct-client_t-inside-struct-pcmcia_device.patch
-pcmcia-use-driver_find-in-ds.patch
-pcmcia-set_netdev-for-network-devices.patch
-pcmcia-set_netdev-for-wireless-network-devices.patch
-pcmcia-reduce-stack-usage-in-ds_ioctl-randy-dunlap.patch
-pcmcia-add-disable_clkrun-option.patch
-pcmcia-rename-pcmcia-devices.patch
-pcmcia-pd6729-e-mail-update.patch
-pcmcia-pd6729-cleanups.patch
-pcmcia-pd6729-isa_irq-handling.patch
-pcmcia-remove-obsolete-code.patch
-pcmcia-remove-pending_events.patch
-pcmcia-remove-client_attributes.patch
-pcmcia-remove-unneeded-parameter-from-rsrc_mgr.patch
-pcmcia-remove-dev_info-from-client.patch
-pcmcia-remove-mtd-and-bulkmem-replaced-by-pcmciamtd.patch
-pcmcia-per-socket-resource-database.patch
-pcmcia-validate_mem-only-for-non-statically-mapped-sockets.patch
-pcmcia-adjust_io_region-only-for-non-statically-mapped-sockets.patch
-pcmcia-find_io_region-only-for-non-statically-mapped-sockets.patch
-pcmcia-find_mem_region-only-for-non-statically-mapped-sockets.patch
-pcmcia-adjust_-and-release_resources-only-for-non-statically-mapped-sockets.patch
-pcmcia-move-resource-handling-code-only-for-non-statically-mapped-sockets-to-other-file.patch
-pcmcia-make-rsrc_nonstatic-an-independend-module.patch
-pcmcia-allocate-resource-database-per-socket.patch
-pcmcia-remove-typedef.patch
-pcmcia-grab-lock-in-resource_release.patch
-sched-make-preempt_bkl-depend-on-preempt-alone.patch
-use-mmiowb-in-qla1280c.patch
-bug-on-error-handlings-in-ext3-under-i-o-failure.patch
-bug-on-error-handlings-in-ext3-under-i-o-failure-fix.patch
-scsi-aic7xxx-kill-kernel-22-ifdefs.patch

 Merged

+sparc64-nodemask-build-fix.patch

 sparc64 compile fix

+selinux-fix-error-handling-code-for-policy-load.patch

 SELinux fix

+generic-irq-code-missing-export-of-probe_irq_mask.patch

 parisc fix

+infiniband-ipoib-use-correct-static-rate-in-ipoib.patch
+infiniband-mthca-trivial-formatting-fix.patch
+infiniband-mthca-support-rdma-atomic-attributes-in-qp-modify.patch
+infiniband-mthca-clean-up-allocation-mapping-of-hca-context-memory.patch
+infiniband-mthca-add-needed-rmb-in-event-queue-poll.patch
+infiniband-core-remove-debug-printk.patch
+infiniband-make-more-code-static.patch
+infiniband-core-set-byte_cnt-correctly-in-mad-completion.patch
+infiniband-core-add-qp-number-to-work-completion-struct.patch
+infiniband-core-add-node_type-and-phys_state-sysfs-attrs.patch
+infiniband-mthca-clean-up-computation-of-hca-memory-map.patch
+infiniband-core-fix-handling-of-0-hop-directed-route-mads.patch
+infiniband-core-add-more-parameters-to-process_mad.patch
+infiniband-core-add-qp_type-to-struct-ib_qp.patch
+infiniband-core-add-ib_find_cached_gid-function.patch
+infiniband-update-copyrights-for-new-year.patch
+infiniband-ipoib-move-structs-from-stack-to-device-private-struct.patch
+infiniband-core-rename-handle_outgoing_smp.patch

 infiniband updates

+seagate-st3200822as-sata-disk-needs-to-be-in-sil_blacklist-as-well.patch

 SATA blacklist entry

-agpgart-allow-multiple-backends-to-be-initialized-fix.patch
-agpgart-add-bridge-assignment-missed-in-agp_allocate_memory.patch

 Folded into agpgart-allow-multiple-backends-to-be-initialized.patch

+agpgart-add-agp_find_bridge-function.patch
+agpgart-allow-drivers-to-allocate-memory-local-to.patch
-agp-x86_64-build-fix.patch

 More work on the support-multiple-agp-busses patches.

+orphaned-pagecache-memleak-fix.patch

 Fix a weird memory leak on the page LRU.  This isn't right yet.

+mark-page-accessed-in-filemapc-not-quite-right.patch

 Page aging fix

+netpoll-fix-napi-polling-race-on-smp.patch

 netpoll oops fix

+tun-tan-arp-monitor-support.patch

 Make the tun/tap driver play right with ARP monitoring.

+atmel_cs-add-support-lg-lw2100n-wlan-pcmcia-card.patch

 Add firmware support for another wlan card.

+ppc32-fix-mpc8272ads.patch
+ppc32-add-freescale-pq2fads-support.patch

 ppc32 updates

+ppc64-make-hvlpevent_unregisterhandler-work.patch
+ppc64-make-iseries_veth-call-flush_scheduled_work.patch
+ppc64-iommu-avoid-isa-io-space-on-power3.patch

 ppc64 updates

+frv-remove-mandatory-single-step-debugging-diversion.patch
+frv-excess-whitespace-cleanup.patch

 arch/frv updates

+x86_64-i386-increase-command-line-size.patch
+x86_64-add-brackets-to-bitops.patch
+x86_64-move-early-cpu-detection-earlier.patch
+x86_64-disable-uselib-when-possible.patch
+x86_64-optimize-nodemask-operations-slightly.patch
+x86_64-fix-a-bug-in-timer_suspend.patch
+x86-consolidate-code-segment-base-calculation.patch

 x86_64 update

+swsusp-more-small-fixes.patch
+swsusp-dm-use-right-levels-for-device_suspend.patch
+swsusp-update-docs.patch
+acpi-comment-whitespace-updates.patch
+make-suspend-work-with-ioapic.patch
+swsusp-refrigerator-cleanups.patch

 swsusp update

+uml-avoid-null-dereference-in-linec.patch
+uml-readd-config_magic_sysrq-for-uml.patch
+uml-commentary-addition-to-recent-sysemu-fix.patch
+uml-drop-unused-buffer_headh-header-from-hostfs.patch
+uml-delete-unused-header-umnh.patch
+uml-commentary-about-sigwinch-handling-for-consoles.patch
+uml-fail-xterm_open-when-we-have-no-display.patch
+uml-depend-on-usermode-in-drivers-block-kconfig-and-drop-arch-um-kconfig_block.patch
+uml-makefile-simplification-and-correction.patch
+uml-fix-compilation-for-missing-headers.patch
+uml-fix-some-uml-own-initcall-macros.patch
+uml-refuse-to-run-without-skas-if-no-tt-mode-in.patch
+uml-for-ubd-cmdline-param-use-colon-as-delimiter.patch
+uml-allow-free-ubd-flag-ordering.patch
+uml-move-code-from-ubd_user-to-ubd_kern.patch
+uml-fix-and-cleanup-code-in-ubd_kernc-coming-from-ubd_userc.patch
+uml-add-stack-content-to-dumps.patch
+uml-add-stack-addresses-to-dumps.patch
+uml-update-ld-scripts-to-newer-binutils.patch

 UML update

+reintroduce-export_symboltask_nice-for-binfmt_elf32.patch

 s/390 build fix

+csum_and_copy_from_user-gcc4-warning-fixes-m32r-fix.patch

 m32r build fix

+fixups-for-block2mtd.patch

 block2mtd update

+poll-mini-optimisations.patch

 teeny poll() speedup

+file_tableexpand_files-code-cleanup.patch
+file_tableexpand_files-code-cleanup-remove-debug.patch

 code consolidation

+mtrr-size-and-base-debug.patch

 Debug an mtrr bug.

+minor-ext3-speedup.patch

 Reduce ext3 CPU consumption a little.

+move-read-only-and-immutable-checks-into-permission.patch
+factor-out-common-code-around-follow_link-invocation.patch

 Code cleanups/consolidation

+relayfs-doc.patch
+relayfs-common-files.patch
+relayfs-locking-lockless-implementation.patch
+relayfs-headers.patch

 relayfs

+ltt-core-implementation.patch
+ltt-core-headers.patch
+ltt-kconfig-fix.patch
+ltt-kernel-events.patch
+ltt-kernel-events-tidy.patch
+ltt-kernel-events-build-fix.patch
+ltt-fs-events.patch
+ltt-fs-events-tidy.patch
+ltt-ipc-events.patch
+ltt-mm-events.patch
+ltt-net-events.patch
+ltt-architecture-events.patch

 LTT.

+lock-initializer-cleanup-ppc.patch
+lock-initializer-cleanup-m32r.patch
+lock-initializer-cleanup-video.patch
+lock-initializer-cleanup-ide.patch
+lock-initializer-cleanup-sound.patch
+lock-initializer-cleanup-sh.patch
+lock-initializer-cleanup-ppc64.patch
+lock-initializer-cleanup-security.patch
+lock-initializer-cleanup-core.patch
+lock-initializer-cleanup-media-drivers.patch
+lock-initializer-cleanup-networking.patch
+lock-initializer-cleanup-block-devices.patch
+lock-initializer-cleanup-s390.patch
+lock-initializer-cleanup-usermode.patch
+lock-initializer-cleanup-scsi.patch
+lock-initializer-cleanup-sparc.patch
+lock-initializer-cleanup-v850.patch
+lock-initializer-cleanup-i386.patch
+lock-initializer-cleanup-drm.patch
+lock-initializer-cleanup-firewire.patch
+lock-initializer-cleanup-arm26.patch
+lock-initializer-cleanup-m68k.patch
+lock-initializer-cleanup-network-drivers.patch
+lock-initializer-cleanup-mtd.patch
+lock-initializer-cleanup-x86_64.patch
+lock-initializer-cleanup-filesystems.patch
+lock-initializer-cleanup-ia64.patch
+lock-initializer-cleanup-raid.patch
+lock-initializer-cleanup-isdn.patch
+lock-initializer-cleanup-parisc.patch
+lock-initializer-cleanup-sparc64.patch
+lock-initializer-cleanup-arm.patch
+lock-initializer-cleanup-misc-drivers.patch
+lock-initializer-cleanup-alpha.patch
+lock-initializer-cleanup-character-devices.patch
+lock-initializer-cleanup-drivers-serial.patch
+lock-initializer-cleanup-frv.patch

 spinlock and rwlock initialiser clanups

+ext3-ea-revert-cleanup.patch
+ext3-ea-revert-old-ea-in-inode.patch
+ext3-ea-mbcache-cleanup.patch
+ext2-ea-race-in-ext-xattr-sharing-code.patch
+ext3-ea-ext3-do-not-use-journal_release_buffer.patch
+ext3-ea-ext3-factor-our-common-xattr-code-unnecessary-lock.patch
+ext3-ea-ext-no-spare-xattr-handler-slots-needed.patch
+ext3-ea-cleanup-and-prepare-ext3-for-in-inode-xattrs.patch
+ext3-ea-hide-ext3_get_inode_loc-in_mem-option.patch
+ext3-ea-in-inode-extended-attributes-for-ext3.patch

 Big ext3+EA update with various fixes

+fix-race-between-core-dumping-and-exec.patch
+fix-exec-deadlock-when-ptrace-used-inside-the-thread-group.patch
+ptrace-unlocked-access-to-last_siginfo-resending.patch
+clear-false-pending-signal-indication-in-core-dump.patch

 Various ptrace/signal/coredump fixes

+pcmcia-remove-irq_type_time.patch
+pcmcia-ignore-driver-irq-mask.patch
+pcmcia-remove-irq_mask-and-irq_list-parameters-from-pcmcia-drivers.patch
+pcmcia-use-irq_mask-to-mark-irqs-as-unusable.patch
+pcmcia-remove-racy-try_irq.patch
+pcmcia-modify-irq_mask-via-sysfs.patch
+pcmcia-remove-includes-in-rsrc_mgr-which-arent-necessary-any-longer.patch

 pcmcia udpates.

+sched-fix-preemption-race-core-i386.patch
+sched-make-use-of-preempt_schedule_irq-ppc.patch
+sched-make-use-of-preempt_schedule_irq-arm.patch

 CPU scheduler preemption fix

+fbdev-cleanup-broken-edid-fixup-code.patch
+fbcon-catch-blank-events-on-both-device-and-console-level.patch
+fbcon-fix-compile-error.patch
+fbdev-fbmon-cleanup.patch
+i810fb-module-param-fix.patch
+atyfb-fix-module-parameter-descriptions.patch
+radeonfb-fix-init-exit-section-usage.patch
+pxafb-reorder-add_wait_queue-and-set_current_state.patch
+sa1100fb-reorder-add_wait_queue-and-set_current_state.patch
+backlight-add-backlight-lcd-device-basic-support.patch
+fbdev-add-w100-framebuffer-driver.patch

 fbdev/fbcon update

+post-halloween-doc.patch

 davej's 2.6 feature list

+fuse-maintainers-kconfig-and-makefile-changes.patch
+fuse-core.patch
+fuse-device-functions.patch
+fuse-read-only-operations.patch
+fuse-read-write-operations.patch
+fuse-file-operations.patch
+fuse-mount-options.patch
+fuse-extended-attribute-operations.patch
+fuse-readpages-operation.patch
+fuse-nfs-export.patch
+fuse-direct-i-o.patch

 Filesystem in userspace.

+ieee1394-adds-a-disable_irm-option-to-ieee1394ko.patch

 New command line option for firewire.

+fix-typo-in-arch-i386-kconfig.patch

 Fix a tpyo.

+random-whitespace-doh.patch
+random-entropy-debugging-improvements.patch
+random-run-time-configurable-debugging.patch
+random-periodicity-detection-fix.patch
+random-add_input_randomness.patch

 random driver updates

+various-kconfig-fixes.patch

 Fix a huge number of Kconfig typos and brainos.





number of patches in -mm: 434
number of changesets in external trees: 314
number of patches in -mm only: 417
total patches: 731




All 434 patches:


linus.patch

sparc64-nodemask-build-fix.patch
  sparc64: nodemask build fix

selinux-fix-error-handling-code-for-policy-load.patch
  SELinux: fix error handling code for policy load

generic-irq-code-missing-export-of-probe_irq_mask.patch
  generic irq code missing export of probe_irq_mask()

infiniband-ipoib-use-correct-static-rate-in-ipoib.patch
  InfiniBand/IPoIB: use correct static rate in IpoIB

infiniband-mthca-trivial-formatting-fix.patch
  InfiniBand/mthca: trivial formatting fix

infiniband-mthca-support-rdma-atomic-attributes-in-qp-modify.patch
  InfiniBand/mthca: support RDMA/atomic attributes in QP modify

infiniband-mthca-clean-up-allocation-mapping-of-hca-context-memory.patch
  InfiniBand/mthca: clean up allocation mapping of HCA context memory

infiniband-mthca-add-needed-rmb-in-event-queue-poll.patch
  InfiniBand/mthca: add needed rmb() in event queue poll

infiniband-core-remove-debug-printk.patch
  InfiniBand/core: remove debug printk

infiniband-make-more-code-static.patch
  InfiniBand: make more code static

infiniband-core-set-byte_cnt-correctly-in-mad-completion.patch
  InfiniBand/core: set byte_cnt correctly in MAD completion

infiniband-core-add-qp-number-to-work-completion-struct.patch
  InfiniBand/core: add QP number to work completion struct

infiniband-core-add-node_type-and-phys_state-sysfs-attrs.patch
  InfiniBand/core: add node_type and phys_state sysfs attrs

infiniband-mthca-clean-up-computation-of-hca-memory-map.patch
  InfiniBand/mthca: clean up computation of HCA memory map

infiniband-core-fix-handling-of-0-hop-directed-route-mads.patch
  InfiniBand/core: fix handling of 0-hop directed route MADs

infiniband-core-add-more-parameters-to-process_mad.patch
  InfiniBand/core: add more parameters to process_mad

infiniband-core-add-qp_type-to-struct-ib_qp.patch
  InfiniBand/core: add qp_type to struct ib_qp

infiniband-core-add-ib_find_cached_gid-function.patch
  InfiniBand/core: add ib_find_cached_gid function

infiniband-update-copyrights-for-new-year.patch
  InfiniBand: update copyrights for new year

infiniband-ipoib-move-structs-from-stack-to-device-private-struct.patch
  InfiniBand/ipoib: move structs from stack to device private struct

infiniband-core-rename-handle_outgoing_smp.patch
  InfiniBand/core: rename handle_outgoing_smp

ia64-acpi-build-fix.patch
  ia64 acpi build fix

ia64-config_apci_numa-fix.patch
  ia64 CONFIG_APCI_NUMA fix

bk-acpi-revert-20041210.patch
  bk-acpi-revert-20041210

acpi-report-errors-in-fanc.patch
  ACPI: report errors in fan.c

acpi-flush-tlb-when-pagetable-changed.patch
  acpi: flush TLB when pagetable changed

acpi-kfree-fix.patch
  a

bk-alsa.patch

bk-arm.patch

bk-cifs.patch

bk-cpufreq.patch

bk-drm-via.patch

bk-i2c.patch

bk-ide-dev.patch

ide-dev-build-fix.patch
  ide-dev-build-fix

bk-input.patch

bk-dtor-input.patch

alps-touchpad-detection-fix.patch
  ALPS touchpad detection fix

bk-kbuild.patch

bk-kconfig.patch

seagate-st3200822as-sata-disk-needs-to-be-in-sil_blacklist-as-well.patch
  Seagate ST3200822AS SATA disk needs to be in sil_blacklist as well

bk-netdev.patch

bk-ntfs.patch

bk-pci.patch

bk-usb.patch

bk-xfs.patch

mm.patch
  add -mmN to EXTRAVERSION

fix-smm-failures-on-e750x-systems.patch
  fix SMM failures on E750x systems

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

vm-pageout-throttling.patch
  vm: pageout throttling

make-tree_lock-an-rwlock.patch
  make mapping->tree_lock an rwlock

orphaned-pagecache-memleak-fix.patch
  orphaned pagecache memleak fix

mark-page-accessed-in-filemapc-not-quite-right.patch
  mark-page-accessed in filemap.c not quite right

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

restore-net-sched-iptc-after-iptables-kmod-cleanup.patch
  Restore net/sched/ipt.c After iptables Kmod Cleanup

b44-bounce-buffer-fix.patch
  b44 bounce buffering fix

netpoll-fix-napi-polling-race-on-smp.patch
  netpoll: fix NAPI polling race on SMP

tun-tan-arp-monitor-support.patch
  tun/tap ARP monitor support

atmel_cs-add-support-lg-lw2100n-wlan-pcmcia-card.patch
  atmel_cs: Add support LG LW2100N WLAN PCMCIA card

ppc32-fix-mpc8272ads.patch
  ppc32: Fix mpc8272ads

ppc32-add-freescale-pq2fads-support.patch
  ppc32: Add Freescale PQ2FADS support

ppc64-make-hvlpevent_unregisterhandler-work.patch
  ppc64: make HvLpEvent_unregisterHandler() work

ppc64-make-iseries_veth-call-flush_scheduled_work.patch
  ppc64: make iseries_veth call flush_scheduled_work()

ppc64-iommu-avoid-isa-io-space-on-power3.patch
  ppc64: iommu: avoid ISA io space on POWER3

ppc64-reloc_hide.patch

frv-remove-mandatory-single-step-debugging-diversion.patch
  FRV: Remove mandatory single-step debugging diversion

frv-excess-whitespace-cleanup.patch
  FRV: Excess whitespace cleanup

superhyway-bus-support.patch
  SuperHyway bus support

x86_64-i386-increase-command-line-size.patch
  x86_64/i386: increase command line size

x86_64-add-brackets-to-bitops.patch
  x86_64: Add brackets to bitops

x86_64-move-early-cpu-detection-earlier.patch
  x86_64: Move early CPU detection earlier

x86_64-disable-uselib-when-possible.patch
  x86_64: Disable uselib when possible

x86_64-optimize-nodemask-operations-slightly.patch
  x86_64: Optimize nodemask operations slightly

x86_64-fix-a-bug-in-timer_suspend.patch
  Fix a bug in timer_suspend() on x86_64

x86-consolidate-code-segment-base-calculation.patch
  x68: consolidate code segment base calculation

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

swsusp-more-small-fixes.patch
  swsusp: more small fixes

swsusp-dm-use-right-levels-for-device_suspend.patch
  swsusp/dm: Use right levels for device_suspend()

swsusp-update-docs.patch
  swsusp: update docs

acpi-comment-whitespace-updates.patch
  acpi: comment/whitespace updates

make-suspend-work-with-ioapic.patch
  make suspend work with ioapic

swsusp-refrigerator-cleanups.patch
  swsusp: refrigerator cleanups

uml-avoid-null-dereference-in-linec.patch
  uml: avoid NULL dereference in line.c

uml-readd-config_magic_sysrq-for-uml.patch
  uml: readd CONFIG_MAGIC_SYSRQ for UML

uml-commentary-addition-to-recent-sysemu-fix.patch
  uml: Commentary addition to recent SYSEMU fix.

uml-drop-unused-buffer_headh-header-from-hostfs.patch
  uml: drop unused buffer_head.h header from hostfs

uml-delete-unused-header-umnh.patch
  uml: delete unused header umn.h

uml-commentary-about-sigwinch-handling-for-consoles.patch
  uml: commentary about SIGWINCH handling for consoles

uml-fail-xterm_open-when-we-have-no-display.patch
  uml: fail xterm_open when we have no $DISPLAY

uml-depend-on-usermode-in-drivers-block-kconfig-and-drop-arch-um-kconfig_block.patch
  uml: depend on !USERMODE in drivers/block/Kconfig and drop arch/um/Kconfig_block

uml-makefile-simplification-and-correction.patch
  uml: Makefile simplification and correction.

uml-fix-compilation-for-missing-headers.patch
  uml: fix compilation for missing headers

uml-fix-some-uml-own-initcall-macros.patch
  uml: fix some UML own initcall macros

uml-refuse-to-run-without-skas-if-no-tt-mode-in.patch
  uml: refuse to run without skas if no tt mode in

uml-for-ubd-cmdline-param-use-colon-as-delimiter.patch
  uml: for ubd cmdline param use colon as delimiter

uml-allow-free-ubd-flag-ordering.patch
  uml: allow free ubd flag ordering

uml-move-code-from-ubd_user-to-ubd_kern.patch
  uml: move code from ubd_user to ubd_kern

uml-fix-and-cleanup-code-in-ubd_kernc-coming-from-ubd_userc.patch
  uml: fix and cleanup code in ubd_kern.c coming from ubd_user.c

uml-add-stack-content-to-dumps.patch
  uml: add stack content to dumps

uml-add-stack-addresses-to-dumps.patch
  uml: add stack addresses to dumps

uml-update-ld-scripts-to-newer-binutils.patch
  uml: update ld scripts to newer binutils

reintroduce-export_symboltask_nice-for-binfmt_elf32.patch
  reintroduce task_nice export for binfmt_elf32

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

csum_and_copy_from_user-gcc4-warning-fixes.patch
  csum_and_copy_from_user gcc4 warning fixes

csum_and_copy_from_user-gcc4-warning-fixes-m32r-fix.patch
  csum_and_copy_from_user-gcc4-warning-fixes m32r fix

smbfs-fixes.patch
  smbfs fixes

irqpoll.patch
  irqpoll

fixups-for-block2mtd.patch
  fixups for block2mtd

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

relayfs-doc.patch
  relayfs: doc

relayfs-common-files.patch
  relayfs: common files

relayfs-locking-lockless-implementation.patch
  relayfs: locking/lockless implementation

relayfs-headers.patch
  relayfs: headers

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

lock-initializer-cleanup-networking.patch
  Lock initializer cleanup: Networking

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

ext3-ea-revert-cleanup.patch
  ext3-ea-revert-cleanup

ext3-ea-revert-old-ea-in-inode.patch
  revert old ea-in-inode patch

ext3-ea-mbcache-cleanup.patch
  ext3/EA: mbcache cleanup

ext2-ea-race-in-ext-xattr-sharing-code.patch
  ext3/EA: Race in ext[23] xattr sharing code

ext3-ea-ext3-do-not-use-journal_release_buffer.patch
  ext3/EA: Ext3: do not use journal_release_buffer

ext3-ea-ext3-factor-our-common-xattr-code-unnecessary-lock.patch
  ext3/EA: Ext3: factor our common xattr code; unnecessary lock

ext3-ea-ext-no-spare-xattr-handler-slots-needed.patch
  ext3/EA: Ext[23]: no spare xattr handler slots needed

ext3-ea-cleanup-and-prepare-ext3-for-in-inode-xattrs.patch
  ext3/EA: Cleanup and prepare ext3 for in-inode xattrs

ext3-ea-hide-ext3_get_inode_loc-in_mem-option.patch
  ext3/EA: Hide ext3_get_inode_loc in_mem option

ext3-ea-in-inode-extended-attributes-for-ext3.patch
  ext3/EA: In-inode extended attributes for ext3

speedup-proc-pid-maps.patch
  Speed up /proc/pid/maps

speedup-proc-pid-maps-fix.patch
  Speed up /proc/pid/maps fix

speedup-proc-pid-maps-fix-fix.patch
  speedup-proc-pid-maps fix fix

speedup-proc-pid-maps-fix-fix-fix.patch
  speedup /proc/<pid>/maps(4th version)

inotify.patch
  inotify

ioctl-rework-2.patch
  ioctl rework #2

ioctl-rework-2-fix.patch
  ioctl-rework-2 fix

make-standard-conversions-work-with-compat_ioctl.patch
  make standard conversions work with compat_ioctl.

fget_light-fput_light-for-ioctls.patch
  fget_light/fput_light for ioctls

macros-to-detect-existance-of-unlocked_ioctl-and-ioctl_compat.patch
  macros to detect existance of unlocked_ioctl and ioctl_compat

fix-coredump_wait-deadlock-with-ptracer-tracee-on-shared-mm.patch
  fix coredump_wait deadlock with ptracer & tracee on shared mm

fix-race-between-core-dumping-and-exec.patch
  fix race between core dumping and exec with shared mm

fix-exec-deadlock-when-ptrace-used-inside-the-thread-group.patch
  fix exec deadlock when ptrace used inside the thread group

ptrace-unlocked-access-to-last_siginfo-resending.patch
  ptrace: unlocked access to last_siginfo (resending)

clear-false-pending-signal-indication-in-core-dump.patch
  clear false pending signal indication in core dump

pcmcia-remove-irq_type_time.patch
  pcmcia: remove IRQ_TYPE_TIME

pcmcia-ignore-driver-irq-mask.patch
  pcmcia: ignore driver IRQ mask

pcmcia-remove-irq_mask-and-irq_list-parameters-from-pcmcia-drivers.patch
  pcmcia: remove irq_mask and irq_list parameters from PCMCIA drivers

pcmcia-use-irq_mask-to-mark-irqs-as-unusable.patch
  pcmcia: use irq_mask to mark IRQs as (un)usable

pcmcia-remove-racy-try_irq.patch
  pcmcia: remove racy try_irq()

pcmcia-modify-irq_mask-via-sysfs.patch
  pcmcia: modify irq_mask via sysfs

pcmcia-remove-includes-in-rsrc_mgr-which-arent-necessary-any-longer.patch
  pcmcia: remove #includes in rsrc_mgr which aren't necessary any longer

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

assign_irq_vector-section-fix.patch
  assign_irq_vector __init section fix

kexec-i8259-shutdowni386.patch
  kexec: i8259-shutdown.i386

kexec-i8259-shutdown-x86_64.patch
  kexec: x86_64 i8259 shutdown

kexec-apic-virtwire-on-shutdowni386patch.patch
  kexec: apic-virtwire-on-shutdown.i386.patch

kexec-apic-virtwire-on-shutdownx86_64.patch
  kexec: apic-virtwire-on-shutdown.x86_64

kexec-ioapic-virtwire-on-shutdowni386.patch
  kexec: ioapic-virtwire-on-shutdown.i386

kexec-apic-virt-wire-fix.patch
  kexec: apic-virt-wire fix

kexec-ioapic-virtwire-on-shutdownx86_64.patch
  kexec: ioapic-virtwire-on-shutdown.x86_64

kexec-e820-64bit.patch
  kexec: e820-64bit

kexec-kexec-generic.patch
  kexec: kexec-generic

kexec-ide-spindown-fix.patch
  kexec-ide-spindown-fix

kexec-ifdef-cleanup.patch
  kexec ifdef cleanup

kexec-machine_shutdownx86_64.patch
  kexec: machine_shutdown.x86_64

kexec-kexecx86_64.patch
  kexec: kexec.x86_64

kexec-kexecx86_64-4level-fix.patch
  kexec-kexecx86_64-4level-fix

kexec-kexecx86_64-4level-fix-unfix.patch
  kexec-kexecx86_64-4level-fix unfix

kexec-machine_shutdowni386.patch
  kexec: machine_shutdown.i386

kexec-kexeci386.patch
  kexec: kexec.i386

kexec-use_mm.patch
  kexec: use_mm

kexec-loading-kernel-from-non-default-offset.patch
  kexec: loading kernel from non-default offset

kexec-loading-kernel-from-non-default-offset-fix.patch
  kdump: fix bss compile error

kexec-enabling-co-existence-of-normal-kexec-kernel-and-panic-kernel.patch
  kexec: nabling co-existence of normal kexec kernel and  panic kernel

kexec-ppc-support.patch
  kexec: ppc support

crashdump-documentation.patch
  crashdump: documentation

crashdump-memory-preserving-reboot-using-kexec.patch
  crashdump: memory preserving reboot using kexec

crashdump-memory-preserving-reboot-using-kexec-fix.patch
  kdump: Fix for boot problems on SMP

kdump-config_discontigmem-fix.patch
  kdump: CONFIG_DISCONTIGMEM fix

crashdump-routines-for-copying-dump-pages.patch
  crashdump: routines for copying dump pages

crashdump-routines-for-copying-dump-pages-kmap-fiddle.patch
  crashdump-routines-for-copying-dump-pages-kmap-fiddle

crashdump-kmap-build-fix.patch
  crashdump kmap build fix

crashdump-register-snapshotting-before-kexec-boot.patch
  crashdump: register snapshotting before kexec boot

crashdump-elf-format-dump-file-access.patch
  crashdump: ELF format dump file access

crashdump-linear-raw-format-dump-file-access.patch
  crashdump: linear/raw format dump file access

crashdump-minor-bug-fixes-to-kexec-crashdump-code.patch
  crashdump: minor bug fixes to kexec crashdump code

crashdump-cleanups-to-the-kexec-based-crashdump-code.patch
  crashdump: cleanups to the kexec based crashdump code

x86-rename-apic_mode_exint.patch
  x86: rename APIC_MODE_EXINT

x86-local-apic-fix.patch
  x86: local apic fix

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

mpsc-driver-patch.patch
  serial: MPSC driver

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

fbdev-cleanup-broken-edid-fixup-code.patch
  fbdev: Cleanup broken edid fixup code

fbcon-catch-blank-events-on-both-device-and-console-level.patch
  fbcon: Catch blank events on both device and console level

fbcon-fix-compile-error.patch
  fbcon: Fix compile error

fbdev-fbmon-cleanup.patch
  fbdev: Fbmon cleanup

i810fb-module-param-fix.patch
  i810fb: Module param fix

atyfb-fix-module-parameter-descriptions.patch
  atyfb: Fix module parameter descriptions

radeonfb-fix-init-exit-section-usage.patch
  radeonfb: Fix init/exit section usage

pxafb-reorder-add_wait_queue-and-set_current_state.patch
  pxafb: Reorder add_wait_queue() and set_current_state()

sa1100fb-reorder-add_wait_queue-and-set_current_state.patch
  sa1100fb: Reorder add_wait_queue() and set_current_state()

backlight-add-backlight-lcd-device-basic-support.patch
  backlight: Add Backlight/LCD device basic support

fbdev-add-w100-framebuffer-driver.patch
  fbdev: Add w100 framebuffer driver

raid5-overlapping-read-hack.patch
  raid5 overlapping read hack

figure-out-who-is-inserting-bogus-modules.patch
  Figure out who is inserting bogus modules

detect-atomic-counter-underflows.patch
  detect atomic counter underflows

waiting-10s-before-mounting-root-filesystem.patch
  retry mounting the root filesystem at boot time

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

fuse-read-only-operations.patch
  Subject: [PATCH 4/11] FUSE - read-only operations

fuse-read-write-operations.patch
  Subject: [PATCH 5/11] FUSE - read-write operations

fuse-file-operations.patch
  Subject: [PATCH 6/11] FUSE - file operations

fuse-mount-options.patch
  Subject: [PATCH 7/11] FUSE - mount options

fuse-extended-attribute-operations.patch
  Subject: [PATCH 8/11] FUSE - extended attribute operations

fuse-readpages-operation.patch
  Subject: [PATCH 9/11] FUSE - readpages operation

fuse-nfs-export.patch
  Subject: [PATCH 10/11] FUSE - NFS export

fuse-direct-i-o.patch
  Subject: [PATCH 11/11] FUSE - direct I/O

ieee1394-adds-a-disable_irm-option-to-ieee1394ko.patch
  ieee1394: add a disable_irm option to ieee1394.ko

fix-typo-in-arch-i386-kconfig.patch
  Fix typo in arch/i386/Kconfig

random-whitespace-doh.patch
  random: whitespace doh

random-entropy-debugging-improvements.patch
  random: entropy debugging improvements

random-run-time-configurable-debugging.patch
  random: run-time configurable debugging

random-periodicity-detection-fix.patch
  random: periodicity detection fix

random-add_input_randomness.patch
  random: add_input_randomness

various-kconfig-fixes.patch
  various Kconfig fixes



