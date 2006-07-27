Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161018AbWG0I4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161018AbWG0I4r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 04:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161008AbWG0I4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 04:56:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25484 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1160999AbWG0I4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 04:56:45 -0400
Date: Thu, 27 Jul 2006 01:56:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc2-mm1
Message-Id: <20060727015639.9c89db57.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/2.6.18-rc2-mm1/

- git-klibc has been dropped due to very bad parallel-make problems.

- Added a new line to the boilerplate, below!

- Added Sam's lxdialog tree, as git-lxdialog.patch.  You no longer need
  x-ray spectacles to read the menuconfig screens.

- Lots of random patches.  Many of them are bugfixes and I shall, as usual,
  go through them all identifying 2.6.18 material.  But I can miss things, so
  please don't be afraid to point 2.6.18 candidates out to me.

  I also have, as usual, a number of bugfixes agains the git trees.  I'll
  send these to the maintainers until they stick and then I lose track of
  them.  So don't be afraid to send reminders to the subsystem maintainers
  either.



Boilerplate:

- See the `hot-fixes' directory for any important updates to this patchset.

- To fetch an -mm tree using git, use (for example)

  git fetch git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git v2.6.16-rc2-mm1

- -mm kernel commit activity can be reviewed by subscribing to the
  mm-commits mailing list.

        echo "subscribe mm-commits" | mail majordomo@vger.kernel.org

- If you hit a bug in -mm and it is not obvious which patch caused it, it is
  most valuable if you can perform a bisection search to identify which patch
  introduced the bug.  Instructions for this process are at

        http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt

  But beware that this process takes some time (around ten rebuilds and
  reboots), so consider reporting the bug first and if we cannot immediately
  identify the faulty patch, then perform the bisection search.

- When reporting bugs, please try to Cc: the relevant maintainer and mailing
  list on any email.

- Semi-daily snapshots of the -mm lineup are uploaded to
  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/ and are announced on
  the mm-commits list.





Changes since 2.6.18-rc2-mm1:


 origin.patch
 git-alsa.patch
 git-agpgart.patch
 git-arm.patch
 git-cifs.patch
 git-cpufreq.patch
 git-dvb.patch
 git-geode.patch
 git-gfs2.patch
 git-ia64.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-input.patch
 git-intelfb.patch
 git-jfs.patch
 git-kbuild.patch
 git-libata-all.patch
 git-lxdialog.patch
 git-mtd.patch
 git-netdev-all.patch
 git-net.patch
 git-nfs.patch
 git-ocfs2.patch
 git-pcmcia.patch
 git-powerpc.patch
 git-sas.patch
 git-s390.patch
 git-scsi-target.patch
 git-supertrak.patch
 git-watchdog.patch
 git-xfs.patch
 git-cryptodev.patch

 git trees

-struct-file-leakage.patch
-struct-file-leakage-tweak.patch
-cpufreq-add-__find_governor-helper-and-clean-up-some.patch
-cpufreq-demand-load-governor-modules.patch
-videodev-check-return-values.patch
-ib-mthca-fix-static-rate-returned-by-mthca_ah_query.patch
-ib-mthca-comment-fix.patch
-ib-cm-drop-req-when-out-of-memory.patch
-ib-addr-gid-structure-alignment-fix.patch
-srp-fix-fmr-error-handling.patch
-ib-cm-set-private-data-length-for-reject-messages.patch
-fmr-pool-remove-unnecessary-pointer-dereference.patch
-ib-core-use-correct-gfp_mask-in-sa_query.patch
-git-input-list_for_each_entry-fix.patch
-git-input-list_for_each_entry-fix-fix.patch
-input-move-fixp-arithh-to-drivers-input.patch
-input-new-force-feedback-interface.patch
-input-adapt-hid-force-feedback-drivers-for-the-new-interface.patch
-input-adapt-uinput-for-the-new-force-feedback-interface.patch
-input-adapt-iforce-driver-for-the-new-force-feedback-interface.patch
-input-force-feedback-driver-for-pid-devices.patch
-input-force-feedback-driver-for-zeroplus-devices.patch
-input-update-documentation-of-force-feedback.patch
-input-drop-the-remains-of-the-old-ff-interface.patch
-input-drop-the-old-pid-driver.patch
-input-fix-comments-and-blank-lines-in-new-ff-code.patch
-input-must_check-fixes.patch
-pata-ata_generic-generic-bios-setup-sff-ata-driver.patch
-fixes-for-piix-driver.patch
-my-name-is-ingo-molnar-you-killed-my-make-allyesconfig-prepare-to-die.patch
-lockdep-annotate-8390c-disable_irq-2.patch
-add-lookup-hint-for-network-file-systems.patch
-fs-nfs-make-2-functions-static.patch
-megaraid-gcc-41-warning-fix.patch
-megaraid-dell-cerc-ata100-4ch-support.patch
-NCR_D700-section-fix.patch
-megaraid-fix-warnings-when-config_proc_fs=n.patch
-scsi_debug-must_check-fixes.patch
-mm-fix-oom-roll-back-of-__vmalloc_area_node.patch
-ia64-race-flushing-icache-in-cow-path.patch
-x86-re-enable-generic-numa.patch
-i386-require-acpi-for-numa-with-generic-architecture.patch
-i386-handle_bug-dont-print-garbage-if-debug-info.patch
-fix-a-memory-leak-in-the-i386-setup-code.patch
-i386-kexec-allow-the-kexec-on-panic-support-to-compile-on-voyager.patch
-i386-remove-redundant-might_sleep-in-user-accessors.patch
-x86-dont-randomize-stack-unless-current-personality-permits-it.patch
-uml-tidy-longjmp-macro.patch
-uml-tidy-biarch-gcc-support.patch
-uml-header-formatting-cleanups.patch
-null-terminate-over-long-proc-kallsyms-symbols.patch
-null-terminate-over-long-proc-kallsyms-symbols-fix.patch
-remove-kernel-kthreadckthread_stop_sem.patch
-del_timer_sync-add-cpu_relax.patch
-hdrinstall-remove-asm-irqh-from-user-visibility.patch
-hdrinstall-remove-asm-atomich-from-user-visibility.patch
-hdrinstall-remove-asm-ioh-from-user-visibility.patch
-nommu-export-two-symbols-for-drivers-to-use.patch
-update-ramdisk-documentation.patch
-ramdisk-blocksize-kconfig-entry.patch
-rtc-subsystem-add-isl1208-support.patch
-rtc-subsystem-add-isl1208-support-tweaks.patch
-lockdep-annotate-the-blkpg_del_partition-ioctl.patch
-add-try_to_freeze-to-rt-test-kthreads.patch
-drivers-block-cpqarrayc-remove-an-unused-variable.patch
-unexport-open_softirq.patch
-scx200_gpio-1-cdev-for-n-minors-cleanup.patch
-scx200_gpio-use-1-cdev-for-n-minors-not-n.patch
-improve-timekeeping-resume-robustness.patch
-fix-sighand-siglock-usage-in-kernel-acctc.patch
-net48xx-led-cleanups.patch
-reiserfs-fix-handling-of-device-names-with-s-in-them.patch
-reiserfs-fix-handling-of-device-names-with-s-in-them-tidy.patch
-convert-idrs-internal-locking-to-_irqsave-variant.patch
-add-function-documentation-for-register_chrdev.patch
-add-function-documentation-for-register_chrdev-fix.patch
-remove-pci_dac_set_dma_mask-from-documentation-dma-mappingtxt.patch
-gpio-drop-vtable-members-gpio_set_high-gpio_set_low.patch
-gpio-cosmetics-remove-needless-newlines.patch
-gpio-rename-exported-vtables-to-better-match.patch
-vfs-fix-accessfile-x_ok-in-the-presence-of-acls.patch
-vfs-remove-redundant-open-coded-mode-bit-check-in-prepare_binfmt.patch
-vfs-remove-redundant-open-coded-mode-bit-checks-in-open_exec.patch
-lockdep-core-fix-rq-lock-handling-on-__arch_want_unlocked_ctxsw.patch
-tpm-fix-failure-path-leak.patch
-actual-mailing-list-in-maintainers.patch
-symlink-nesting-level-change.patch
-tpm-interrupt-clear-fix.patch
-tpm-add-force-device-probe-option.patch
-tpm_tis-use-resource_size_t.patch
-let-the-the-lockdep-options-depend-on-debug_kernel.patch
-fix-security-check-for-joint-context=-and-fscontext=-mount.patch
-list_islast-utility.patch
-per-task-delay-accounting-setup.patch
-per-task-delay-accounting-sync-block-i-o-and-swapin-delay-collection.patch
-per-task-delay-accounting-cpu-delay-collection-via-schedstats.patch
-per-task-delay-accounting-utilities-for-genetlink-usage.patch
-per-task-delay-accounting-taskstats-interface.patch
-per-task-delay-accounting-taskstats-interface-fix.patch
-per-task-delay-accounting-delay-accounting-usage-of-taskstats-interface.patch
-per-task-delay-accounting-delay-accounting-usage-of-taskstats-interface-fix.patch
-per-task-delay-accounting-documentation.patch
-per-task-delay-accounting-proc-export-of-aggregated-block-i-o-delays.patch
-delay-accounting-taskstats-interface-send-tgid-once.patch
-per-task-delay-accounting-taskstats-interface-documentation-fix.patch
-per-task-delay-accounting-avoid-send-without-listeners.patch
-per-task-delay-accounting-taskstats-interface-control-exit-data-through-cpumasks.patch
-per-task-delay-accounting-taskstats-interface-control-exit-data-through-cpumasks-fix.patch
-per-task-delay-accounting-taskstats-interface-control-exit-data-through-cpumasks-fix-2.patch
-per-task-delay-accounting-taskstats-interface-control-exit-data-through-cpumasks-fix-3.patch
-per-task-delay-accounting-taskstats-interface-control-exit-data-through-cpumasks-fix-cleanup.patch
-per-task-delay-accounting-taskstats-interface-control-exit-data-through-cpumasks-fix-cleanup-fix.patch
-remove-down_write-from-taskstats-code-invoked-on-the-exit-path.patch
-mbxfb-add-framebuffer-driver-for-the-intel-2700g.patch

 Merged into mainline or a subsystem tree.

+sched-build_sched_domains-fix.patch
+ext3-avoid-triggering-ext3_error-on-bad-nfs-file-handle.patch
+ext3-avoid-triggering-ext3_error-on-bad-nfs-file-handle-fix.patch
+process-events-fix-biarch-compatibility-issue-use-__u64-timestamp.patch
+gpio-rename-exported-vtables-to-better-match-tidy.patch
+genirq-endisable_irq_wake-need-refcounting-too.patch
+make-taskstats-sending-completely-independent-of-delay.patch
+taskstats-free-skb-avoid-returns-in.patch
+delay-accounting-temporarily-enable-by-default.patch
+fix-ppc32-zimage-inflate.patch
+mce-section-fix.patch

 2.6.18 queue (partial)

+gregkh-driver-mem-devices.patch
+gregkh-driver-driver-multithread.patch

 Driver tree updates

+drivers-base-check-errors-fix.patch
+drivers-base-check-errors-fix-2.patch
+fix-bus_rescan_devices-in-mm.patch
+more-driver-core-fixes-for-mm.patch
+yet-further-driver-core-fixes-for-mm.patch

 More driver core error-checking.

+dvb-core-needs-i2c.patch
+git-dvb-radio-sf16fmi-build-fix.patch

 DVB fixes

+ieee1394-remove-include-asm-semaphoreh.patch
+ieee1394-sbp2-safer-last_orb-and.patch
+ieee1394-sbp2-discard-return-value-of.patch
+ieee1394-sbp2-optimize-dma-direction-of.patch
+ieee1394-sbp2-safer-initialization-of.patch
+ieee1394-sbp2-more-checks-of-status.patch
+ieee1394-sbp2-convert.patch

 1394 updates

+logips2pp-fix-mx300-button-layout.patch
+logips2pp-fix-mx300-button-layout-fix.patch

 Input fixes.

-sane-menuconfig-colours.patch

 Dropped - git-lxdialog 

+remove-rpm_build_root-from-asm-offsetsh.patch

 kbuild fix

-git-hdrcleanup-vs-git-klibc-on-ia64.patch
-git-hdrcleanup-vs-git-klibc-on-ia64-2.patch
-make-variables-static-after-klibc-merge.patch

 git-klibc droppage side-effects.

+rework-legacy-handling-to-remove-much-of-the-cruft.patch
+rework-legacy-handling-to-remove-much-of-the-cruft-fix.patch
+rework-legacy-handling-to-remove-much-of-the-cruft-powerpc-fix.patch

 IDE cleanups

+fix-the-unlock-addr-lookup-bug-in-mtd-jedec-probe.patch

 MTD maybe-fix.

-qla3xxx-nic-driver-updates.patch

 Folded into qla3xxx-NIC-driver.patch

+net-add-netconsole-support-to-dm9000-driver.patch
+smc911x-re-release-spinlock-on-spurious-interrupt.patch
+uli526x-driver-cleanups.patch
+via-rhine-napi-support.patch
+via-rhine-napi-poll-enable.patch
+stop-calling-phy_stop_interrupts-twice.patch

 netdev updates

+git-net-selinux_xfrm_decode_session-build-fix.patch

 Fix git-net.patch.

+lockdep-split-the-skb_queue_head_init-lock-class-tidy.patch
+ppp-handle-kmalloc-failures.patch
+ppp-handle-kmalloc-failures-leak-fix.patch
+irda-replace-hard-coded-dev_self-array-sizes-with-array_size.patch
+acrnet-sohard-pci-support.patch

 Networkng things.

+powerpc-use-check_irq_per_cpu.patch

 powerpc tweak.

-revert-VIA-quirk-fixup-additional-PCI-IDs.patch
-revert-PCI-quirk-VIA-IRQ-fixup-should-only-run-for-VIA-southbridges.patch

 Unneeded.

+pci-quirk_via_irq-behaviour-change.patch
+pci-hotplug-acpiphp-fix-kconfig-for-dock-dependencies-2.patch

 PCI fixes

+git-kbuild-build-fix.patch

 Fix git-s390.patch for git-kbuild changes.

+pci_module_init-conversion-in-scsi-subsys-2nd-try.patch
+scsi-megaraid_mmmbox-64-bit-dma-capability-checker.patch
+scsi-megaraid_mmmbox-a-fix-on-inquiry-with-evpd.patch
+scsi-megaraid_mmmbox-a-fix-on-kernel-unaligned-access-address-issue.patch
+megaraid-gcc-41-warning-fix.patch
+megaraid-fix-warnings-when-config_proc_fs=n.patch
+megaraid-dell-cerc-ata100-4ch-support.patch

 SCSI updates

+gregkh-usb-usb-ark3116-add-tiocgserial-and-tiocsserial-ioctl-calls.patch
+gregkh-usb-usb-ark3116-formatting-cleanups.patch

 USB tree updates.

+add-all-wacom-device-to-hid-corec-blacklist.patch
+net1080-inherent-pad-length.patch

 USB updates

+ieee80211-tkip-requires-crc32.patch
+kthread-airoc.patch
+kthread-airoc-race-fix.patch

 Wireless updates

+x86_64-mm-defconfig-update.patch
-x86_64-mm-i386-numa-summit-check.patch
-x86_64-mm-x86_64-mm-remove-un-set_nmi_callback-and-reserve-release_lapic_nmi-functions-x86-fix.patch
-x86_64-mm-x86_64-mm-remove-un-set_nmi_callback-and-reserve-release_lapic_nmi-functions-x86-fix-fix.patch
-x86_64-mm-x86_64-mm-remove-un-set_nmi_callback-and-reserve-release_lapic_nmi-functions-x86_64-fix.patch
+x86_64-mm-unknown-nmi-panic.patch
+x86_64-mm-generic-getcpu-syscall.patch
+x86_64-mm-randomize-check.patch
+x86_64-mm-add-user-mode.patch
+x86_64-mm-int80-save-args.patch
+x86_64-mm-i386-profile-pc.patch
+x86_64-mm-simplify-profile-pc.patch
+x86_64-mm-enlarge-debug-stack.patch
+x86_64-mm-backtrace-fallback.patch
+x86_64-mm-backtracer-docs.patch
+x86_64-mm-i386-backtrace-fallback.patch
+x86_64-mm-asm-alternative.patch
+x86_64-mm-rwlock-lock-prefix.patch
+x86_64-mm-rwlock-cleanup.patch
+x86_64-mm-i386-asm-alternative.patch
+x86_64-mm-i386-semaphore-to-asm.patch
+x86_64-mm-remove-thunk-cvs-id.patch
+x86_64-mm-tce-comment.patch
+x86_64-mm-intel-no-tsc-in-c3.patch
+x86_64-mm-remove-apic-ifdefs.patch
+x86_64-mm-remove-apic-mismatch.patch
+x86_64-mm-remove-focus-disabled-workaround.patch
+x86_64-mm-calgary-iommu-fix-off-by-one-error.patch
+x86_64-mm-calgary-iommu-multi-node-null-pointer-dereference-fix.patch
+x86_64-mm-tlb-flush-cleanup.patch
+x86_64-mm-i386-tlbflush-fixes.patch
+x86_64-mm-remove-timer-fallback.patch
+x86_64-mm-entry-comments.patch
+x86_64-mm-remove-pirq.patch
+x86_64-mm-remove-mca-eisa.patch
+x86_64-mm-remove-pic-mode.patch
+x86_64-mm-remove-mpparse-checks.patch
+x86_64-mm-io-apic-access.patch
+x86_64-mm-i386-io-apic-access.patch
+x86_64-mm-remove-apic-renumbering.patch
+x86_64-mm-quirks-own-file.patch
+x86_64-mm-mp-bus-type-bitmap.patch
+x86_64-mm-remove-mpparse-wrapper.patch
+x86_64-mm-remove-acpi-externs-in-mpparse.patch
+x86_64-mm-mpparse-acpi-style.patch
+x86_64-mm-i386-mpparse-acpi-style.patch
+x86_64-mm-apic-build-bug-on.patch
+x86_64-mm-detect-cfi.patch
+x86_64-mm-revert-k8-bus-change.patch
+x86_64-mm-kernel-asm-remove-cvs-id.patch
+x86_64-mm-via-force-dma-mask.patch
+x86_64-mm-fix-swiotlb-force.patch

 x86_64 tree updates

+fix-x86_64-mm-via-force-dma-mask-config_pcin-fix.patch
+fix-x86_64-mm-i386-backtrace-fallback.patch
+fix-x86_64-mm-allow-users-to-force-a-panic-on-nmi.patch

 Fix it.

+calgary-iommu-rearrange-struct-iommu_table.patch
+calgary-iommu-consolidate-per-bus-data.patch
+calgary-iommu-break-out-of.patch
+calgary-iommu-fix-error-path-memleak-in.patch
+calgary-iommu-fix-reference-counting-of.patch
+calgary-iommu.patch
+calgary-iommu-save-a-bit-of-space-in-bus_info.patch

 Clagary update

+xfs-add-lock-annotations-to-xfs_trans_update_ail-and-xfs_trans_delete_ail.patch

 XFS sparse annotation.

+cpu-hotplug-compatible-alloc_percpu.patch

 alloc_percpu feature work.

+add-kerneldocs-for-some-functions-in-mm-memoryc.patch

 Documentation

+selinux-fix-memory-leak.patch
+selinux-fix-bug-in-security_compute_sid.patch

 SELinux fixes

+synchronize_tsc-fixes.patch

 Small fixes for x86 TSC synchronisation

+machine_kexecc-fix-the-description-of-segment-handling.patch
+add-force-of-use-mmconfig.patch
+add-force-of-use-mmconfig-fix.patch
+kprobe-booster-disable-in-preemptible-kernel.patch
+i386-fix-recursive-faults-during-oops-when-current.patch
+i386-show_registers-try-harder-to-print-failing.patch
+convert-i386-summit-subarch-to-use-srat-info-for-apicid_to_node-calls.patch
+convert-i386-summit-subarch-to-use-srat-info-for-apicid_to_node-calls-tidy.patch
+i386-make-config_efi-depend-on-experimental.patch
+add-efi-e820-memory-mapping-on-x86.patch
+add-efi-e820-memory-mapping-on-x86-tidy.patch
+add-efi-e820-memory-mapping-on-x86-fix.patch
+i386-switch_to-misplaced-parentheses.patch

 x86 updates

+arch-alpha-use-array_size-macro.patch

 Alpha cleanup

+ia64-kprobe-invalidate-icache-of-jump-buffer-s390-fix.patch

 Fix ia64-kprobe-invalidate-icache-of-jump-buffer.patch for s390

-swsusp-try-to-handle-holes-better.patch
+make-swsusp-avoid-memory-holes-and-reserved-memory-regions-on-x86_64.patch

 Updated.

+v850-remove-symbol-exports-which-duplicate-global-ones.patch
+v850-call-init_page_count-instead-of-set_page_count.patch

 v850 fixes

+inode_diet-replace-inodeugeneric_ip-with-inodei_private-gfs-fix.patch

 Fix gfs2 for inode_diet-replace-inodeugeneric_ip-with-inodei_private.patch

-eisa-bus-modalias-attributes-support-1-fix-git-kbuild-fix-2.patch

 Fix eisa-bus-modalias-attributes-support-1 some more.

+pass-io-size-to-batch_write-address-space-operation.patch

 Tweak VFS features in -mm.

+invalidate_bdev-speedup.patch
+ide-touch-nmi-watchdog-during-resume-from-str.patch
+ide-touch-nmi-watchdog-during-resume-from-str-fix.patch
+make-touch_nmi_watchdog-imply-touch_softlockup_watchdog-on.patch
+remove-unnecessary-barrier-in-rtc_get_rtc_time.patch
+drivers-char-scx200_gpioc-make-code-static.patch
+drivers-char-pc8736x_gpioc-remove-unused-static-functions.patch
+let-warn_on-warn_on_once-return-the-condition.patch
+let-warn_on-warn_on_once-return-the-condition-fix.patch
+let-warn_on-warn_on_once-return-the-condition-fix-2.patch
+net-use-warn_on_once-for-checksum-checks.patch
+lockdep-annotate-pktcdvd-natural-device-hierarchy.patch
+scx200_gpio-export-cleanups.patch
+make-net48xx-led-use-scx200_gpio_ops.patch
+nbd-check-magic-before-doing-anything-else.patch
+nbd-abort-request-on-data-reception-failure.patch
+always-define-irq_per_cpu.patch
+panic_on_oops-remove-ssleep.patch
+replace-__devinit-with-__cpuinit-for-cpu-notifications.patch
+fix-hotplug-cpu-documentation-for-proper-usage.patch
+use-hotplug-version-of-registration-in-late-inits.patch
+fix-bad-macro-param-in-timerc.patch
+fix-cond_resched-fix.patch
+fix-kernel-api-doc-for-kernel-resourcec.patch
+kernel-doc-ignore-__devinit.patch
+pci-search-cleanups-add-to-kernel-apitmpl.patch
+libfs-remove-page-up-to-date-check-from-simple_readpage.patch
+add-docbook-documentation-for-workqueue-functions.patch
+doc-submittingpatches-cleanups.patch
+kernel-doc-for-relay-interface.patch
+kernel-doc-fixes-for-debugfs.patch
+kernel-doc-move-filesystems-together.patch
+kthread-convert-loopc-to-kthread.patch
+fs-conversions-from-kmallocmemset-to-kzcalloc.patch
+include-documentation-for-functions-in-drivers-base-classc.patch
+fix-parameter-names-in-drivers-base-classc.patch
+fs-removing-useless-casts.patch
+sgiioc4-always-share-irq.patch
+spinlock_debug-dont-recompute-jiffies_per_loop.patch
+omap-add-smc91x-support-for-ti-omap2420-h4-board.patch
+omap-add-watchdog-driver-support.patch
+omap-add-watchdog-driver-support-tweaks.patch
+omap-fix-rng-driver-build.patch
+mdacon-fix-__init-section-warnings.patch
+pcmcia-fix-ioctl-for-get_status-and-get_configuration_info.patch
+pcmcia-fix-ioctl-get_configuration_info-for-pcmcia_cards.patch
+use-gcc-o1-in-fs-reiserfs-only-for-ancient-gcc-versions.patch
+enable-mac-partition-label-per-default-on-pmac.patch
+hide-onboard-graphics-drivers-on-g5.patch
+hptiop-wrong-register-used-in-hptiop_reset_hba.patch
+pi-futex-robust-futex-exit.patch
+pi-futex-missing-pi_waiters-plist-initialization.patch
+irq-fixed-coding-style.patch
+irq-removed-a-extra-line.patch
+sgiioc4-fixup-use-of-mmio-ops.patch
+add-linux-mm-mailing-list-for-memory-management-in.patch
+inotify-fix-deadlock-found-by-lockdep.patch
+fix-swsusp-with-pnp-bios.patch
+remove-incorrect-unlock_kernel-from-allocation.patch
+remove-incorrect-unlock_kernel-from-failure-path-in.patch
+add-entry-for-efs-filesystem-to-maintainers-as-orphan.patch
+ufs-remove-incorrect-unlock_kernel-from-failure-path-in-ufs_symlink.patch
+efi-add-lock-annotations-for-efi_call_phys_prelog-and-efi_call_phys_epilog.patch
+mbcache-add-lock-annotation-for-__mb_cache_entry_release_unlock.patch
+afs-add-lock-annotations-to-afs_proc_cell_servers_startstop.patch
+fuse-add-lock-annotations-to-request_end-and-fuse_read_interrupt.patch
+hugetlbfs-add-lock-annotation-to-hugetlbfs_forget_inode.patch
+lockdep-dont-pull-in-includes-when-lockdep-disabled.patch
+jbd-add-lock-annotation-to-jbd_sync_bh.patch
+fix-typo-in-maintainers-s-devics-devices.patch
+bluetooth-guard-bt_proto-with-rwlock.patch
+typo-in-ub-clause-of-devicestxt.patch
+reducing-local_bh_enable-disable-overhead-in-irqtrace.patch
+add-parenthesis-around-arguments-in-the-sh_div-macro.patch
+reference-rt-mutex-design-in-rtmutexc.patch
+fix-kmem_cache_alloc-been-documented-twice.patch
+hwrng-fix-intel-probe-error-unwind.patch
+hwrng-fix-geode-probe-error-unwind.patch
+fs-add-lock-annotation-to-grab_super.patch
+rcu-add-lock-annotations-to-rcu_bh_torture_read_lockunlock.patch
+vdso-hash-style-fix.patch
+kthread-drivers-base-firmware_classc.patch

 Misc.

+streamline-generic_file_-interfaces-and-filemap-gfs-fix.patch

 Fix gfs2 for streamline-generic_file_-interfaces-and-filemap.patch

-task-watchers-refactor-process-events-fix.patch

 Not sure where this went.

+knfsd-knfsd-add-some-missing-newlines-in-printks.patch
+knfsd-knfsd-remove-an-unused-variable-from-e_show.patch
+knfsd-knfsd-remove-an-unused-variable-from-auth_unix_lookup.patch
+knfsd-add-a-callback-for-when-last-rpc-thread-finishes.patch
+knfsd-add-a-callback-for-when-last-rpc-thread-finishes-tidy.patch
+knfsd-add-a-callback-for-when-last-rpc-thread-finishes-fix.patch
+knfsd-be-more-selective-in-which-sockets-lockd-listens-on.patch
+knfsd-remove-nfsd_versbits-as-intermediate-storage-for-desired-versions.patch
+knfsd-separate-out-some-parts-of-nfsd_svc-which-start-nfs-servers.patch
+knfsd-separate-out-some-parts-of-nfsd_svc-which-start-nfs-servers-tweaks.patch
+knfsd-define-new-nfsdfs-file-portlist-contains-list-of-ports.patch
+knfsd-define-new-nfsdfs-file-portlist-contains-list-of-ports-tidy.patch
+knfsd-define-new-nfsdfs-file-portlist-contains-list-of-ports-fix.patch
+knfsd-allow-sockets-to-be-passed-to-nfsd-via-portlist.patch
+knfsd-use-seq_start_token-instead-of-hardcoded-magic-void1.patch
+nfsd-add-lock-annotations-to-e_start-and-e_stop.patch

 nfsd updates.

+ecryptfs-mmap-operations-fix.patch

 Fix ecryptfs-mmap-operations.patch

+namespaces-utsname-switch-to-using-uts-namespaces-uml-fix.patch

 Fix namespaces-utsname-switch-to-using-uts-namespaces.patch for UML

+namespaces-utsname-switch-to-using-uts-namespaces-klibc-bit.patch
+namespaces-utsname-use-init_utsname-when-appropriate-klibc-bit.patch
+namespaces-utsname-switch-to-using-uts-namespaces-klibc-bit-2.patch
+namespaces-utsname-switch-to-using-uts-namespaces-klibc-bit-sparc.patch

 Bring these patches back when klibc isn't present.

+reiser4-bug-fixes.patch

 Reiser4 update

+ide-remove-dma_base2-field-from-ide_hwif_t.patch

 IDE cleanup

+radeonfb-sleep-fixes.patch
+powermac-more-powermac-backlight-fixes.patch
+powermac-more-powermac-backlight-fixes-fix.patch
+nvidiafb-remove-redundant-config_pci-check.patch
+rivafb-nvidiafb-race-between-register_framebuffer-and-_bl_init.patch

 fbdev updates.

+statistics-use-the-enhanced-percpu-interface.patch

 Update stats patches for the new alloc_percpu features.

+genirq-x86_64-irq-make-vector_irq-per-cpu-fix.patch

 Fix genirq-x86_64-irq-make-vector_irq-per-cpu.patch

+schedule-obsolete-oss-drivers-for-removal-2nd-round.patch

 Put more OSS drivers on death row.



All 909 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/2.6.18-rc2-mm1/patch-list

