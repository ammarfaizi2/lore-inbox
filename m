Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263137AbVCXMty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbVCXMty (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 07:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbVCXMtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 07:49:47 -0500
Received: from fire.osdl.org ([65.172.181.4]:29333 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263122AbVCXMlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 07:41:46 -0500
Date: Thu, 24 Mar 2005 04:41:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc1-mm2
Message-Id: <20050324044114.5aa5b166.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.12-rc1-mm2/


- Added David Miller's networking tree to the -mm lineup as bk-net.patch. 

- Added Herbert Xu's crypto development tree to the -mm lineup as
  bk-cryptodev.patch.

  -mm kernels now aggregate Linus's tree and 34 subsystem trees.  Usually
  they are pulled 3-4 hours before the release of the -mm kernel.  

  Usually it is possible to determine the latest cset from each tree by
  looking at the first couple of lines of the relevant patch in the
  broken-out/ directory.  Although sometimes it isn't there if I had to
  massage the diff.

- There may be an x86_64 problem here, although it works for me.  If it
  fails early in boot, try reverting
  x86_64-separate-amd-cmp-detection-from-hyper-threading.patch

- There's some work here on the recent USB PM resume bugs.  If you had
  problems there, please test and be sure to cc
  linux-usb-devel@lists.sourceforge.net in any reports.

- Some fixes for the recent DRM problems.

- Big DVB update

- md updates

- nfs4 server updates

- Lots more fixes

- Lots more bugs.



Chages since 2.6.12-rc1-mm1:


 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-arm.patch
 bk-audit.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-cryptodev.patch
 bk-driver-core.patch
 bk-drm.patch
 bk-drm-via.patch
 bk-i2c.patch
 bk-ia64.patch
 bk-ieee1394.patch
 bk-input.patch
 bk-jfs.patch
 bk-kbuild.patch
 bk-libata.patch
 bk-net.patch
 bk-netdev.patch
 bk-nfs.patch
 bk-ntfs.patch
 bk-pci.patch
 bk-scsi.patch
 bk-scsi-rc-fixes.patch
 bk-serial.patch
 bk-usb.patch
 bk-watchdog.patch
 bk-xfs.patch

 Latest versions of external trees

-input-fix-fast-scrolling-scancodes-in-atkbdc.patch
-b44-allocate-tx-bounce-bufs-as-needed.patch
-drivers-net-myri_codeh-cleanup.patch
-e100-napi-state-machine-fix.patch
-fix-pci_disable_device-in-8139too.patch
-bonding-needs-inet.patch
-drivers-net-sis900c-fix-a-warning.patch
-fix-suspend-resume-on-via-velocity.patch
-we-18-aka-wpa.patch
-smc91x-addr-config-check.patch
-smc91x-warning-fix.patch
-tcp-infrastructure-split-out.patch
-tcp-bic-11-support.patch
-tcp-westwood-support.patch
-tcp-westwood-support-kconfig-fix.patch
-tcp-vegas-support.patch
-tcp-high-speed-support.patch
-drivers-net-arcnet-arcnetc-gcc4-fixes.patch
-drivers-net-depcac-gcc4-fix.patch

 Merged

-fix-agp_backend-usage-in-drm_agp_init.patch

 Fixed differently in bk-drm.patch

-tcp-infrastructure-split-out.patch
-tcp-bic-11-support.patch
-tcp-westwood-support.patch
-tcp-westwood-support-kconfig-fix.patch
-tcp-vegas-support.patch
-tcp-high-speed-support.patch

 These broke changes in bk-net.patch.

+ppc64-fix-aio-panic-caused-by-is_hugepage_only_range.patch

 AIO-vs-hugetlb oops fix

+acpi-ec-warning-fix.patch

 Fix bk-acpi warning

+agp-fix-for-xen-vmm.patch

 Xen preparatory work

+3dfx-drm-depends-on-pci.patch

 Fixes for bk-drm.patch

+alps-printk-tidy.patch

 Fix up a bk-input printk.

+nfs4-empty-array-fix.patch

 bk-nfs build fix

+debug-for-pci-io-mem-allocation.patch

 Extra pci layer debugging support

+usb_cdc-build-fix.patch

 Fix build for old gcc

+fix-harmful-typos-in-zd1201c.patch

 Fix zd1201c bogons

+usb-resume-fixes.patch
+usb-suspend-updates-interface-suspend.patch
+hcd-suspend-uses-pm_message_t.patch

 Fixes for USB PM resume.

+fix-mmap-of-dev-kmem.patch

 Fix oopses with mmapping of /dev/kmem

+unused-size-assignment-in-filemap_nopage.patch

 Remove some dead code and a warning

+freepgt-free_pgtables-use-vma-list.patch
+freepgt-remove-mm_vm_sizemm.patch
+freepgt-hugetlb_free_pgd_range.patch
+freepgt-remove-arch-pgd_addr_end.patch
+freepgt-mpnt-to-vma-cleanup.patch
+freepgt-hugetlb-area-is-clean.patch

 Core mm pagetable handling simplification (hah), cleanup, speedup.

+a-new-10gb-ethernet-driver-by-chelsio-communications-update.patch

 Updates to the Chelsio 10GB ethernet driver

+restore-ports-module-parameter-for-ip_nat_ftp-and-ip_nat_irc.patch

 netfilter fix

+e1000-flush-work-queues-on-remove.patch

 e1000 shutdown fix

+ipt-leak-fix.patch

 net fix

+selinux-make-code-static-and-remove-unused-code.patch
+selinux-allow-mounting-of-filesystems-with-invalid-root-inode-context.patch
+selinux-audit-unrecognized-netlink-messages.patch
+selinux-add-name_connect-permission-check.patch

 SELinux updates and cleanups

+ppc32-typo-fix-in-load-store-string-emulation.patch
+ppc32-report-chipset-version-in-common-proc-cpuinfo-handling.patch
+ppc32-dmasound-compilation-fix.patch
+ppc32-fix-sandpoint-soft-reboot.patch
+ppc32-64-map-prefetchable-pci-without-guarded-bit.patch

 ppc32 updates

+ppc64-fix-gcc4-compile-error-in-pacah.patch
+ppc64-fix-compile-error-in-promc.patch
+ppc64-fix-linkage-error-on-g5.patch
+ppc64-fix-semtimedop-compat-syscall.patch
+ppc64-fix-pseries-hcall-stubs.patch
+ppc64-make-numa=off-command-line-argument-work-again.patch
+ppc64-fix-ethernet-phy-reset-on-imac-g5.patch

 ppc64 updates

-via-irq-fixup-fix.patch
+x86-via-workaround.patch

 Updated version of the VIA IRQ handling workaround

+x86-fix-esp-corruption-cpu-bug-take-2-fix.patch

 Fix x86-fix-esp-corruption-cpu-bug-take-2.patch

+x86_64-update-defconfig.patch
+x86_64-separate-amd-cmp-detection-from-hyper-threading.patch
+x86_64-add-new-amd-cpuid-flags-to-cpuinfo.patch
+x86_64-add-an-64bit-entry-path-for-exec.patch
+x86_64-busses-array-is-only-indexed-with-a-8bit-value.patch
+x86_64-fix-compilation-with-config_proc_fs=n.patch
+x86_64-move-hpet-selection-into-processor-specific.patch
+x86_64-remove-never-used-obsolete-file.patch
+x86_64-fix-indentation-in-vsyscallc-no-functional.patch
+x86_64-nop-out-system-call-instruction-in-vsyscall-page.patch
+x86_64-remove-obsolete-comments-in-vsyscallc-and-fix.patch
+x86_64-remove-noisy-printk-in-k8-bus-detection-code.patch
+x86_64-remove-unused-and-broken-code-in-ioh.patch
+x86_64-remove-stale-unused-file.patch
+x86_64-move-put_user-out-of-line.patch
+x86_64-give-out-of-line-get_user-better-calling.patch
+x86_64-work-around-tyan-bios-mtrr-initialization-bug.patch
+x86_64-include-pci-express-configuration.patch
+x86_64-cleanups-in-new-backtrace-code-in-oprofile.patch
+x86_64-fix-special-isa-case-in-iounmap.patch
+x86_64-fix-formatting-and-white-space-in-signal-code.patch
+x86_64-mem=xxx-will-now-limit-kernel-memory-to-xxx.patch
+x86_64-resume-pit-for-x86_64.patch
+x86_64-fix-nmi-rtc-access-race.patch
+x86_64-minor-fix-to-tlb-flush-ipi.patch
+x86_64-always-reload-cr3-completely-when-a-lazy-mm.patch
+x86_64-fix-ldt-descriptor.patch
+x86_64-change-the-y2069-bug-in-the-rtc-timer-code-to-be.patch
+x86_64-only-free-pmds-and-puds-after-other-cpus-have.patch
+x86_64-dont-enable-interrupts-in-oopses.patch
+x86_64-fix-smp-fallback-to-up.patch
+x86_64-fix-config_preempt.patch
+x86_64-fix-exception-stack-detection-during-backtraces.patch
+x86_64-fix-gcc-34-warning-in-bitopsc.patch
+x86_64-clean-up-the-iommu-initialisation-a-bit.patch

 x86_64 update

+alpha-spinlockh-update.patch

 alpha build fix

+m32r-update-mmu-less-support-1.patch
+m32r-update-mmu-less-support-2.patch
+m32r-update-mmu-less-support-3.patch
+m32r-fix-m32102-i-cache-invalidation.patch
+m32r_sio-driver-update.patch

 m32r update

+m68k-update-signal-delivery-handling.patch
+m68k-stdma-replace-sleep_on-with-wait_event.patch
+zorro-replace-printk-with-pr_info-in-drivers-zorro-zorroc.patch
+mac-ncr5380-scsi-fix-bus-error.patch
+m68k-ip-checksum-updates.patch
+sun-3-3x-enable-sun-partition-tables-support-by-default.patch
+m68k-add-missing-pieces-of-thread-info-tif_memdie-support.patch
+tpm-depends-on-pci.patch

 m68k update and other stuff from Gerd.

-uml-cope-with-uml_net-security-fix.patch
+uml-cope-with-uml_net-security-fix-2.patch

 Updated

+uml-fix-compile.patch
+uml-cpu_relax-fix.patch
+uml-extend-cmd-line-limits.patch
+uml-disable-more-hardware-kconfig-opt-and-rename-usermode-to-uml.patch
+uml-little-build-fixes.patch
+uml-factor-out-common-code-in-user-obj-handling.patch
+uml-kbuild-link-cmd.patch
+uml-add-kconfig-debug-deps.patch
+uml-real-fix-for-__gcov_init-symbols.patch
+uml-fix-cond-expr-as-lvalues-warning.patch

 UML update

+s390-swapped-memset-arguments.patch

 s390 dyslexia fix

-building-areca-arcmsr-driver-outside-kernel-source-tree.patch

 Folded into the ever-updated areca-raid-linux-scsi-driver.patch

+keys-pass-session-keyring-to-call_usermodehelper.patch
+keys-pass-session-keyring-to-call_usermodehelper-warning-fix.patch
+keys-use-rcu-to-manage-session-keyring-pointer.patch
+keys-make-request-key-create-an-authorisation-key.patch

 Key management updates

+fix-mmap-return-value-to-conform-to-posix.patch

 Make mmap posixly correct again.

+timers-enable-irqs-in-__mod_timer.patch
+timers-enable-irqs-in-__mod_timer-tidy.patch

 More updates to the core kernel timer code.

+fat-set-ms_noatime-to-msdos.patch
+fat-fix-msdos-datetime.patch

 fatfs fixes

+fix-compile-warning-in-drivers-pnp-resourcec-with-config_pci.patch

 Warning fix

+nlm-fix-f_count-leak.patch

 nfsd fix

+module-parameter-fixes.patch

 Fix some module parameters

+fs-hpfs-fix-hpfs-support-under-64-bit-kernel.patch

 Fix hpfs for 64-bit machines

+arch-hook-for-notifying-changes-in-pte-protections-bits.patch

 ia64 core mm hook

+serial-digi-neo-driver.patch

 New serial driver

+netmos-parallel-serial-combo-support.patch

 Improved netmos parport support.

+consolidate-asm-ipch.patch

 ipx.h cleanups

+bt819-array-indexing-fix.patch

 Fix bogon in a v4l driver

+unified-spinlock-initialization.patch

 spinlock cleanup

+drivers-block-dac960c-fix-a-use-after-free.patch
+drivers-telephony-ixj-fix-a-use-after-free.patch

 Couple of use-after-free fixes

+dvb-clarify-firmware-upload-messages.patch
+dvb-dibcom-frontend-fixes.patch
+dvb-dibusb-misc-fixes.patch
+dvb-skystar2-remove-duplicate-pci_release_region.patch
+dvb-mt352-pinnacle-300i-comments.patch
+dvb-support-activy-budget-card.patch
+dvb-skystar2-update-email-address.patch
+dvb-ves1x93-invert_pwm-fix.patch
+dvb-dibusb-readme-update.patch
+dvb-dibusb-support-hauppauge-wintv-nova-t-usb2.patch
+dvb-nxt2002-qam64-256-support.patch
+dvb-get_dvb_firmware-new-unshield-version.patch
+dvb-dib3000-corrected-device-naming.patch
+dvb-dibusb-debug-changes.patch
+dvb-dibusb-increased-the-number-of-urbs-for-usb11-devices.patch
+dvb-ttusb_dec-use-alternative-interface-to-save-bandwidth.patch
+dvb-l64781-email-address-fix.patch
+dvb-skystar2-fix-mac-address-reading.patch
+dvb-support-kworld-adstech-instant-dvb-t-usb20.patch
+dvb-cleanups-make-stuff-static.patch
+dvb-refactor-sw-pid-filter-to-drop-redundant-code.patch
+dvb-nxt2002-fix-max-frequency.patch
+dvb-ttusb-budget-s-usb_unlink_urb-usb_kill_urb.patch
+dvb-av7110-fix-oops-when-av7110_ir_init-failed.patch
+dvb-saa7146-static-initialization.patch
+dvb-av7110-error-handling-during-attach.patch
+dvb-corrected-links-to-firmware-files.patch
+dvb-support-pchdtv-hd2000.patch
+dvb-dibusb-support-nova-t-usb-ir.patch
+dvb-oren-or51211-or51132_qam-and-or51132_vsb-firmware-download-info.patch
+dvb-ttusb_dec-ir-support.patch
+dvb-dibusb-pll-fix.patch
+dvb-tda10021-fix-continuity-errors.patch
+dvb-saa7146-remove-duplicate-setgpio.patch
+dvb-fix-cams-on-typhoon-dvb-s.patch
+dvb-frontends-kfree-cleanup.patch
+dvb-clear-up-confusion-between-ids-and-adapters.patch
+dvb-dibusb-remove-useless-ifdef.patch
+dvb-support-for-technotrend-pci-dvb-t.patch
+dvb-dibusb-hanftek-umt-010-fixes.patch
+dvb-vfree-checking-cleanups.patch
+dvb-convert-from-pci_module_init-to-pci_register_driver.patch
+dvb-dibusb-support-dtt200u-yakumo-typhoon-hama-usb20-device.patch
+dvb-sparse-warnings-on-one-bit-bitfields.patch
+dvb-support-nova-s-rev-22.patch
+dvb-ttusb_dec-cleanup.patch
+dvb-gcc-295-compile-fixes.patch
+dvb-mt352-cleanups.patch

 DVB system updates

+ext3-fix-journal_unmap_buffer-race.patch
+ext3-dynamic-allocating-block-reservation-info.patch
+ext3-reservation-info-cleanup-remove-rsv_seqlock.patch
+ext3-reservation-info-cleanup-remove-rsv_seqlock-fix.patch
+ext3-move-goal-logical-block-into-block-allocation-info.patch

 Reduce the size of ext3 inodes

+pcmcia-select-crc32-in-kconfig-for-pcmcia.patch

 pcmcia linkage fix

+svcrpc-auth_domain-documentation.patch
+nfsd4-fix-share-conflict-tests.patch
+nfsd4-remove-unneeded-stateowner-arguments.patch
+nfsd4-fix-use-after-put-in-cb_recall.patch
+nfsd4-allow-read-on-open-for-write.patch
+nfsd4-factor-out-common-open_truncate-code.patch
+nfsd4-fix-failure-to-truncate-on-some-opens.patch
+nfsd4_remove_unused_acl_function.patch
+nfsd4-dont-set-write_owner-in-either-allow-or-deny-bits.patch
+nfsd4-acl-dont-set-named-attrs.patch
+nfsd4-acl-error-fix.patch
+nfsd4-rename-release_delegation.patch
+nfsd4-remove-trailing-whitespace-from-nfs4procc.patch
+nfsd4-fix-open-returns-for-other-claim-types.patch
+nfsd4-fix-indentation-in-nfsd4_open.patch

 nfsd updates

+rock-lindent.patch
+rock-manual-tidies.patch
+rock-remove-CHECK_SP.patch
+rock-remove-CONTINUE_DECLS.patch
+rock-remove-CHECK_CE.patch
+rock-remove-SETUP_ROCK_RIDGE.patch
+rock-remove-MAYBE_CONTINUE.patch
+rock-comment-tidies.patch
+rock-lindent-rock-h.patch
+isofs-remove-debug-stuff.patch
+rock-handle-corrupted-directories.patch
+rock-rename-union-members.patch
+rock-handle-directory-overflows.patch

 rotoroot and fix the isofs rock-ridge handling.

+perfctr-x86-fix-and-cleanups.patch
+perfctr-ppc32-fix-and-cleanups.patch
+perfctr-64-bit-values-in-register-descriptors.patch
+perfctr-64-bit-values-in-register-descriptors-fix.patch

 perfctr updates

-x86_64-entry64.patch

 Is in one of the above x86_64 patches

-revert-allow-oem-written-modules-to-make-calls-to-ia64-oem-sal-functions.patch

 Drop this - the modules are now in the kernel.

+wbsd-update.patch

 mmc driver update

+md-a-couple-of-tidyups-relating-to-the-bitmap-file.patch
+md-call-bitmap_daemon_work-regularly.patch
+md-print-correct-pid-for-newly-created-bitmap-writeback-daemon.patch
+md-minor-code-rearrangement-in-bitmap_init_from_disk.patch
+md-make-sure-md-bitmap-is-cleared-on-a-clean-start.patch
+md-improve-debug-printing-of-bitmap-superblock.patch
+md-check-return-value-of-write_page-rather-than-ignore-it.patch
+md-enable-the-bitmap-write-back-daemon-and-wait-for-it.patch
+md-dont-skip-bitmap-pages-due-to-lack-of-bit-that-we-just-cleared.patch
+md-fix-bug-when-raid1-attempts-a-partial-reconstruct.patch
+md-allow-md-intent-bitmap-to-be-stored-near-the-superblock.patch
+md-allow-md-to-update-multiple-superblocks-in-parallel.patch

 md updates for the new bitmap-based intent logging code.

+fuse-mount-options-fix-fix.patch

 fuse fixlet

-cryptoapi-prepare-for-processing-multiple-buffers-at.patch
-cryptoapi-update-padlock-to-process-multiple-blocks-at.patch

 These are in the bk-cryptodev patch

+drivers-scsi-pas16c-make-code-static.patch

 namespace cleanup

+x86-geode-support-fixes.patch

 Tidy up the new x86 Geode CPU support

+drivers-scsi-initioc-cleanups.patch
+dont-do-pointless-null-checks-and-casts-before-kfree.patch
+drivers-char-isicomc-section-fixes.patch
+sound-oss-cleanups.patch

 Little fixes

+mm-mmapnommuc-several-unexports.patch
+unexport-hugetlb_total_pages.patch
+unexport-clear_page_dirty_for_io.patch
+mm-filemapc-make-sync_page_range_nolock-static.patch
+mm-filemapc-make-generic_file_direct_io-static.patch

 Various dodgy-looking changes to the kernel namespace.  These will stay in
  -mm for a while.



number of patches in -mm: 823
number of changesets in external trees: 620
number of patches in -mm only: 794
total patches: 1414



All 823 patches:



linus.patch

pcmcia-properly-bail-out-on-mtd-related-ioctl-invocation.patch
  pcmcia: properly bail out on MTD-related ioctl invocation

pcmcia-dont-lock-up-in-rsrc_nonstatic-pcmcia_validate_mem.patch
  pcmcia: don't lock up in rsrc_nonstatic pcmcia_validate_mem

pcmcia-dont-send-eject-request-events-to-userspace.patch
  pcmcia: don't send eject request events to userspace

ppc64-preliminary-changes-to-of-fixup-functions.patch
  ppc64: preliminary changes to OF fixup functions

ppc64-make-of-node-fixup-code-usable-at-runtime.patch
  ppc64: make OF node fixup code usable at runtime

ppc64-introduce-pseries_reconfig.patch
  ppc64: introduce pSeries_reconfig.[ch]

ppc64-promc-use-pseries-reconfig-notifier.patch
  ppc64: prom.c: use pSeries reconfig notifier

ppc64-fix-aio-panic-caused-by-is_hugepage_only_range.patch
  ppc64: fix AIO panic on PPC64 caused by is_hugepage_only_range()

handle-multiple-video-cards-on-the-same-bus.patch
  handle multiple video cards on the same bus

tty-overrun-time-fix.patch
  tty overrun time fix

ia64-msi-warning-fixes.patch
  ia64 msi warning fixes

ia64-config_apci_numa-fix.patch
  ia64 CONFIG_APCI_NUMA fix

bk-acpi.patch

acpi-ec-warning-fix.patch
  acpi ec.c warning fix

acpi-toshiba-failure-handling.patch
  acpi: Toshiba failure handling

acpi-video-pointer-size-fix.patch
  acpi video pointer size fix

acpi-create_polling_proc-fix.patch
  acpi: create_polling_proc() fix

bk-agpgart.patch

agp-make-some-code-static.patch
  AGP: make some code static

agp-fix-for-xen-vmm.patch
  AGP fix for Xen VMM

bk-alsa.patch

include-linux-soundcardh-endianness-fix.patch
  include/linux/soundcard.h: endianness fix

bk-arm.patch

arm-atomic_sub_and_test.patch
  arm atomic_sub_and_test()

bk-audit.patch

bk-cifs.patch

bk-cpufreq.patch

bk-cryptodev.patch

bk-driver-core.patch

export-platform_add_devices.patch
  export platform_add_devices

bk-drm.patch

3dfx-drm-depends-on-pci.patch
  3dfx DRM depends on PCI

bk-drm-via.patch

bk-i2c.patch

bk-ia64.patch

bk-ieee1394.patch

bk-input.patch

alps-printk-tidy.patch
  alps-printk-tidy

bk-jfs.patch

bk-kbuild.patch

uml-make-deb-pkg-build-target-build-a-debian-style-user-mode-linux-package.patch
  uml: make deb-pkg build target build a Debian-style user-mode-linux package

uml-restore-proper-descriptions-in-make-deb-pkg-target.patch
  UML - Restore proper descriptions in make deb-pkg target

doc-describe-kbuild-pitfall.patch
  doc: describe Kbuild pitfall

complete-cpufreq-kconfig-cleanup.patch
  complete cpufreq Kconfig cleanup

bk-libata.patch

bk-net.patch

bk-netdev.patch

bk-nfs.patch

nfs4-empty-array-fix.patch
  nfs4 empty array fix

bk-ntfs.patch

bk-pci.patch

debug-for-pci-io-mem-allocation.patch
  DEBUG for PCI IO & MEM allocation

pci-pci-transparent-bridge-handling-improvements-pci-core.patch
  PCI-PCI transparent bridge handling improvements (pci core)

pci-pci-transparent-bridge-handling-improvements-yenta_socket.patch
  PCI-PCI transparent bridge handling improvements (yenta_socket)

acpi-bridge-hotadd-acpi-based-root-bridge-hot-add.patch
  acpi bridge hotadd: ACPI based root bridge hot-add

acpi-bridge-hotadd-fix-pci_enable_device-for-p2p-bridges.patch
  acpi bridge hotadd: Fix pci_enable_device() for p2p bridges

acpi-bridge-hotadd-make-pcibios_fixup_bus-hot-plug-safe.patch
  acpi bridge hotadd: Make pcibios_fixup_bus() hot-plug safe

acpi-bridge-hotadd-prevent-duplicate-bus-numbers-when-scanning-pci-bridge.patch
  acpi bridge hotadd: Prevent duplicate bus numbers when scanning PCI bridge

acpi-bridge-hotadd-take-the-pci-lock-when-modifying-pci-bus-or-device-lists.patch
  acpi bridge hotadd: Take the PCI lock when modifying pci bus or device lists

acpi-bridge-hotadd-link-newly-created-pci-child-bus-to-its-parent-on-creation.patch
  acpi bridge hotadd: Link newly created pci child bus to its parent on creation

acpi-bridge-hotadd-make-the-pci-remove-routines-safe-for-failed-hot-plug.patch
  acpi bridge hotadd: Make the PCI remove routines safe for failed hot-plug

acpi-bridge-hotadd-remove-hot-plugged-devices-that-could-not-be-allocated-resources.patch
  acpi bridge hotadd: Remove hot-plugged devices that could not be allocated resources

acpi-bridge-hotadd-read-bridge-resources-when-fixing-up-the-bus.patch
  acpi bridge hotadd: Read bridge resources when fixing up the bus

acpi-bridge-hotadd-allow-acpi-add-and-start-operations-to-be-done-independently.patch
  acpi bridge hotadd: Allow ACPI .add and .start operations to be done independently

acpi-bridge-hotadd-export-the-interface-to-get-pci-id-for-an-acpi-handle.patch
  acpi bridge hotadd: Export the interface to get PCI id for an ACPI handle

bk-scsi.patch

megaraid_sas-announcing-new-module-for.patch
  megaraid_sas: Announcing new module for LSI Logic's SAS based MegaRAID controllers

open-iscsi-scsi.patch
  open-iscsi-scsi

open-iscsi-headers.patch
  open-iscsi-headers

open-iscsi-kconfig.patch
  open-iscsi-kconfig

open-iscsi-makefile.patch
  open-iscsi-makefile

open-iscsi-netlink.patch
  open-iscsi-netlink

open-iscsi-doc.patch
  open-iscsi-doc

bk-scsi-rc-fixes.patch

add-scsi-changer-driver.patch
  add scsi changer driver

scsi-ch-build-fix.patch
  scsi ch.c build fix

bk-serial.patch

bk-usb.patch

usb-resume-fixes.patch
  usb resume fixes

usb-suspend-updates-interface-suspend.patch
  usb suspend updates (interface suspend)

hcd-suspend-uses-pm_message_t.patch
  hcd suspend uses pm_message_t

zd1201-makefile-fix.patch
  zd1201 makefile fix

zd1201-build-fix.patch
  zd1201 build fix

usb-support-for-new-ipod-mini-and-possibly-others.patch
  usb: support for new ipod mini (and possibly others)

usb-wacom-driver-update.patch
  usb: wacom driver update

bk-watchdog.patch

bk-xfs.patch

mm.patch
  add -mmN to EXTRAVERSION

fix-help-for-acpi_container.patch
  Fix help for ACPI_CONTAINER

swapspace-layout-improvements.patch
  swapspace-layout-improvements
  /proc/swaps negative Used

bdi-provide-backing-device-capability-information.patch
  BDI: Provide backing device capability information [try #3]

cpusets-big-numa-cpu-and-memory-placement-backing_dev-fix.patch
  cpusets-big-numa-cpu-and-memory-placement-backing_dev-fix

add-a-clear_pages-function-to-clear-pages-of-higher.patch
  add a clear_pages function to clear pages of higher order

slab-kmalloc-cleanups.patch
  slab.[ch]: kmalloc() cleanups

slab-64bit-fix.patch
  slab: 64-bit fix

vmscan-move-code-to-isolate-lru-pages-into-separate-function.patch
  vmscan: move code to isolate LRU pages into separate function

mm-counter-operations-through-macros.patch
  mm counter operations through macros

mm-counter-operations-through-macros-tidy.patch
  mm-counter-operations-through-macros-tidt

vmscan-notice-slab-shrinking.patch
  vmscan: notice slab shrinking

slab-shrinkers-use-vfs_cache_pressure.patch
  slab shrinkers: use vfs_cache_pressure

madvise-do-not-split-the-maps.patch
  madvise: do not split the maps

madvise-merge-the-maps.patch
  madvise: merge the maps

include-cleanup-in-pgalloch.patch
  include cleanup in pgalloc.h

fix-mmap-of-dev-kmem.patch
  Fix mmap of /dev/kmem

unused-size-assignment-in-filemap_nopage.patch
  unused 'size' assignment in filemap_nopage

freepgt-free_pgtables-use-vma-list.patch
  freepgt: free_pgtables use vma list

freepgt-remove-mm_vm_sizemm.patch
  freepgt: remove MM_VM_SIZE(mm)

freepgt-hugetlb_free_pgd_range.patch
  freepgt: hugetlb_free_pgd_range

freepgt-remove-arch-pgd_addr_end.patch
  freepgt: remove arch pgd_addr_end

freepgt-mpnt-to-vma-cleanup.patch
  freepgt: mpnt to vma cleanup

freepgt-hugetlb-area-is-clean.patch
  freepgt: hugetlb area is clean

eni155p-error-handling-fix.patch
  ENI155P error handling fix

remove-last_rx-update-from-loopback-device.patch
  remove last_rx update from loopback device

a-new-10gb-ethernet-driver-by-chelsio-communications.patch
  A new 10GB Ethernet Driver by Chelsio Communications

a-new-10gb-ethernet-driver-by-chelsio-communications-update.patch
  A new 10GB Ethernet Driver by Chelsio Communications (update)

pcnet32-bug-79c975-fiber-fix.patch
  pcnet32 79C975 fiber fix

dm9000-network-driver.patch
  DM9000 network driver

null-pointer-bug-in-netpollc.patch
  NULL pointer bug in netpoll.c

restore-ports-module-parameter-for-ip_nat_ftp-and-ip_nat_irc.patch
  Restore ports module parameter for ip_nat_ftp and ip_nat_irc

e1000-flush-work-queues-on-remove.patch
  e1000: flush work queues on remove

ipt-leak-fix.patch
  memory leak in net/sched/ipt.c?

selinux-make-code-static-and-remove-unused-code.patch
  SELinux: make code static and remove unused code

selinux-allow-mounting-of-filesystems-with-invalid-root-inode-context.patch
  SELinux: allow mounting of filesystems with invalid root inode context

selinux-audit-unrecognized-netlink-messages.patch
  SELinux: audit unrecognized netlink messages

selinux-add-name_connect-permission-check.patch
  SELinux: add name_connect permission check

ppc32-fix-mv64x60-internal-sram-size.patch
  ppc32: Fix mv64x60 internal SRAM size

ppc32-move-83xx-85xx-device-and-system-description-files.patch
  ppc32: Move 83xx & 85xx device and system description files

ppc32-fix-config_serial_text_debug-support-on-83xx.patch
  ppc32: Fix CONFIG_SERIAL_TEXT_DEBUG support on 83xx

ppc32-typo-fix-in-load-store-string-emulation.patch
  ppc32: typo fix in load/store string emulation

ppc32-report-chipset-version-in-common-proc-cpuinfo-handling.patch
  ppc32: Report chipset version in common /proc/cpuinfo handling

ppc32-dmasound-compilation-fix.patch
  ppc32: dmasound compilation fix

ppc32-fix-sandpoint-soft-reboot.patch
  ppc32: Fix Sandpoint Soft Reboot

ppc32-64-map-prefetchable-pci-without-guarded-bit.patch
  ppc32/64: Map prefetchable PCI without guarded bit

ppc64-pci_dnc-use-pseries-reconfig-notifier.patch
  ppc64: pci_dn.c: use pSeries reconfig notifier

ppc64-pseries_iommuc-use-pseries-reconfig-notifier.patch
  ppc64: pSeries_iommu.c: use pSeries reconfig notifier

ppc64-fix-gcc4-compile-error-in-pacah.patch
  ppc64: fix gcc4 compile error in paca.h

ppc64-fix-compile-error-in-promc.patch
  ppc64: fix compile error in prom.c

ppc64-fix-linkage-error-on-g5.patch
  ppc64: fix linkage error on G5

ppc64-fix-semtimedop-compat-syscall.patch
  ppc64: fix semtimedop compat syscall

ppc64-fix-pseries-hcall-stubs.patch
  ppc64: fix pseries hcall stubs

ppc64-make-numa=off-command-line-argument-work-again.patch
  ppc64: Make numa=off command line argument work again

ppc64-fix-ethernet-phy-reset-on-imac-g5.patch
  ppc64: Fix ethernet PHY reset on iMac G5

mips-linkage-fix.patch
  mips linkage fix

x86-reduce-cacheline-bouncing-in-cpu_idle_wait.patch
  x86: reduce cacheline bouncing in cpu_idle_wait

x86-cmos-time-update-optimisation.patch
  x86: CMOS time update optimisation

x86-cmos-time-update-optimisation-tidy.patch
  x86-cmos-time-update-optimisation-tidy

x86-cmos-time-update-optimisation-locking-fix.patch
  x86-cmos-time-update-optimisation locking fix

x86-cmos-time-update-optimisation-locking-fix-check.patch
  x86-cmos-time-update-optimisation-locking-fix-check

x86-via-workaround.patch
  x86: via workaround

via-irq-fixup-fix-warning-fix.patch
  via-irq-fixup-fix-warning-fix

apm-fix-interrupts-enabled-in-device_power_up.patch
  APM: fix interrupts enabled in device_power_up

rtc_lock-is-irq-safe.patch
  rtc_lock is irq-safe

fix-put_user-for-80386.patch
  fix put_user for 80386

es7000-legacy-mappings-update.patch
  ES7000 Legacy Mappings Update

x86-fix-esp-corruption-cpu-bug-take-2.patch
  x86: fix ESP corruption CPU bug (take 2)

x86-fix-esp-corruption-cpu-bug-take-2-fix.patch
  x86-fix-esp-corruption-cpu-bug-take-2 fix

es7000-dmi-cleanup.patch
  es7000 dmi cleanup

i386-add-kstack=n-option-from-x86_64.patch
  i386: add kstack=N option (from x86_64)

reduce-inlined-x86-memcpy-by-2-bytes.patch
  x86: reduce inlined memcpy by 2 bytes

rename-fpu_verify_area-to-fpu_access_ok.patch
  rename FPU_*verify_area to FPU_*access_ok

x86_64-update-defconfig.patch
  x86_64: Update defconfig

x86_64-separate-amd-cmp-detection-from-hyper-threading.patch
  x86_64: Separate AMD CMP detection from Hyper Threading detection

x86_64-add-new-amd-cpuid-flags-to-cpuinfo.patch
  x86_64: Add new AMD cpuid flags to cpuinfo

x86_64-add-an-64bit-entry-path-for-exec.patch
  x86_64: Add an 64bit entry path for exec

x86_64-busses-array-is-only-indexed-with-a-8bit-value.patch
  x86_64: Busses array is only indexed with a 8bit value, doesn't make sense

x86_64-fix-compilation-with-config_proc_fs=n.patch
  x86_64: Fix compilation with CONFIG_PROC_FS=n

x86_64-move-hpet-selection-into-processor-specific.patch
  x86_64: Move HPET selection into processor specific options

x86_64-remove-never-used-obsolete-file.patch
  x86_64: Remove never used obsolete file

x86_64-fix-indentation-in-vsyscallc-no-functional.patch
  x86_64: Fix indentation in vsyscall.c. No functional changes.

x86_64-nop-out-system-call-instruction-in-vsyscall-page.patch
  x86_64: Nop out system call instruction in vsyscall page when not needed

x86_64-remove-obsolete-comments-in-vsyscallc-and-fix.patch
  x86_64: Remove obsolete comments in vsyscall.c and fix some others.

x86_64-remove-noisy-printk-in-k8-bus-detection-code.patch
  x86_64: Remove noisy printk in K8 bus detection code

x86_64-remove-unused-and-broken-code-in-ioh.patch
  x86_64: Remove unused and broken code in io.h

x86_64-remove-stale-unused-file.patch
  x86_64: Remove stale unused file

x86_64-move-put_user-out-of-line.patch
  x86_64: Move put_user out of line

x86_64-give-out-of-line-get_user-better-calling.patch
  x86_64: Give out of line get_user better calling conventions

x86_64-work-around-tyan-bios-mtrr-initialization-bug.patch
  x86_64: Work around Tyan BIOS MTRR initialization bug.

x86_64-include-pci-express-configuration.patch
  x86_64: Include PCI-Express configuration

x86_64-cleanups-in-new-backtrace-code-in-oprofile.patch
  x86_64: Cleanups in new backtrace code in oprofile

x86_64-fix-special-isa-case-in-iounmap.patch
  x86_64: Fix special ISA case in iounmap()

x86_64-fix-formatting-and-white-space-in-signal-code.patch
  x86_64: Fix formatting and white space in signal code

x86_64-mem=xxx-will-now-limit-kernel-memory-to-xxx.patch
  x86_64: mem=XXX will now limit kernel memory to XXX instead of XXX+1MB

x86_64-resume-pit-for-x86_64.patch
  x86_64: resume PIT for x86_64

x86_64-fix-nmi-rtc-access-race.patch
  x86_64: Fix NMI RTC access race

x86_64-minor-fix-to-tlb-flush-ipi.patch
  x86_64: Minor fix to TLB flush IPI

x86_64-always-reload-cr3-completely-when-a-lazy-mm.patch
  x86_64: Always reload CR3 completely when a lazy MM thread drops a MM.

x86_64-fix-ldt-descriptor.patch
  x86_64: Fix LDT descriptor

x86_64-change-the-y2069-bug-in-the-rtc-timer-code-to-be.patch
  x86_64: Change the y2069 bug in the RTC timer code to be a y2100 bug.

x86_64-only-free-pmds-and-puds-after-other-cpus-have.patch
  x86_64: Only free PMDs and PUDs after other CPUs have been flushed

x86_64-dont-enable-interrupts-in-oopses.patch
  x86_64: Don't enable interrupts in oopses unconditionally

x86_64-fix-smp-fallback-to-up.patch
  x86_64: Fix SMP fallback to UP

x86_64-fix-config_preempt.patch
  x86_64: Fix CONFIG_PREEMPT

x86_64-fix-exception-stack-detection-during-backtraces.patch
  x86_64: Fix exception stack detection during backtraces

x86_64-fix-gcc-34-warning-in-bitopsc.patch
  x86_64: Fix gcc 3.4 warning in bitops.c

x86_64-clean-up-the-iommu-initialisation-a-bit.patch
  x86_64: Clean up the IOMMU initialisation a bit

x86-64-kconfig-typo-trivial.patch
  x86-64: kconfig typo

x86_64-remove-old-decl-trivial.patch
  x86_64: remove old decl (trivial)

x86_64-avoid-panic-lockup.patch
  x86_64: avoid panic lockup

x86_64-hugetlb-fix.patch
  x86_64: hugetlb fix

x86-64-forgot-asmlinkage-on-sys_mmap.patch
  x86-64: forgot asmlinkage on sys_mmap

x86_64-reduce-cacheline-bouncing-in-cpu_idle_wait.patch
  x86_64: reduce cacheline bouncing in cpu_idle_wait

x86_64-reduce-cacheline-bouncing-in-cpu_idle_wait-warning-fix.patch
  x86_64-reduce-cacheline-bouncing-in-cpu_idle_wait-warning-fix

x86-64-kprobes-handle-%rip-relative-addressing-mode.patch
  x86-64 kprobes: handle %RIP-relative addressing mode

kernel-parameters-ia-32-x86-64-cleanups.patch
  kernel-parameters: IA-32/X86-64 cleanups

x86-x86_64-reading-deterministic-cache-parameters-and-exporting-it-in-sysfs.patch
  x86, x86_64: reading deterministic cache parameters and exporting it in /sysfs

x86-x86_64-intel-dual-core-detection.patch
  x86, x86_64: Intel dual-core detection

x86-cacheline-alignment-for-cpu-maps.patch
  x86: cacheline alignment for cpu maps

x86_64-dump-stack-in-early-exception.patch
  x86_64-dump-stack-in-early-exception

alpha-spinlockh-update.patch
  alpha spinlock.h update

ia64-reduce-cacheline-bouncing-in-cpu_idle_wait.patch
  ia64: reduce cacheline bouncing in cpu_idle_wait

ia64-reduce-cacheline-bouncing-in-cpu_idle_wait-fix.patch
  ia64-reduce-cacheline-bouncing-in-cpu_idle_wait fix

swsusp-add-missing-refrigerator-calls.patch
  swsusp: Add missing refrigerator calls

suspend-to-ram-update-videotxt-with-more-systems.patch
  suspend-to-ram: update video.txt with more systems

pm-remove-obsolete-pm_-from-vtc.patch
  pm: remove obsolete pm_* from vt.c

swsusp-small-updates.patch
  swsusp: small updates

swsusp-1-1-kill-swsusp_restore.patch
  swsusp: kill swsusp_restore

m32r-update-mmu-less-support-1.patch
  m32r: Update MMU-less support #1

m32r-update-mmu-less-support-2.patch
  m32r: Update MMU-less support #2

m32r-update-mmu-less-support-3.patch
  m32r: Update MMU-less support #3

m32r-fix-m32102-i-cache-invalidation.patch
  m32r: Fix M32102 I-cache invalidation

m32r_sio-driver-update.patch
  m32r_sio driver update

m68k-update-signal-delivery-handling.patch
  M68k: Update signal delivery handling

m68k-stdma-replace-sleep_on-with-wait_event.patch
  M68k/stdma: Replace sleep_on() with wait_event()

zorro-replace-printk-with-pr_info-in-drivers-zorro-zorroc.patch
  Zorro: replace printk() with pr_info() in drivers/zorro/zorro.c

mac-ncr5380-scsi-fix-bus-error.patch
  Mac NCR5380 SCSI: Fix bus error

m68k-ip-checksum-updates.patch
  M68k: IP checksum updates

sun-3-3x-enable-sun-partition-tables-support-by-default.patch
  Sun-3/3x: Enable Sun partition tables support by default

m68k-add-missing-pieces-of-thread-info-tif_memdie-support.patch
  M68k: Add missing pieces of thread info TIF_MEMDIE support

tpm-depends-on-pci.patch
  TPM depends on PCI

uml-cope-with-uml_net-security-fix-2.patch
  uml: cope with uml_net security fix

uml-fix-compile.patch
  uml: fix compile

uml-cpu_relax-fix.patch
  uml: cpu_relax fix

uml-extend-cmd-line-limits.patch
  uml: extend cmd line limits

uml-disable-more-hardware-kconfig-opt-and-rename-usermode-to-uml.patch
  uml: disable more hardware kconfig opt and rename USERMODE to UML

uml-little-build-fixes.patch
  Uml: little build fixes

uml-factor-out-common-code-in-user-obj-handling.patch
  uml: factor out common code in user-obj handling

uml-kbuild-link-cmd.patch
  uml - kbuild: link cmd

uml-add-kconfig-debug-deps.patch
  uml: add kconfig debug deps

uml-real-fix-for-__gcov_init-symbols.patch
  uml: real fix for __gcov_init symbols

uml-fix-cond-expr-as-lvalues-warning.patch
  Subject: [patch 12/12] uml: fix "cond. expr. as lvalues" warning

s390-swapped-memset-arguments.patch
  s390: swapped memset arguments.

make-sysrq-f-call-oom_kill.patch
  make sysrq-F call oom_kill()

mtrr-size-and-base-debug.patch
  mtrr size-and-base debugging

cant-unmount-bad-inode.patch
  Can't unmount bad inode

iounmap-debugging.patch
  iounmap debugging

detect-soft-lockups.patch
  detect soft lockups

detect-soft-lockups-from-touch_nmi_watchdog.patch
  detect-soft-lockups: call from touch_nmi_watchdog

areca-raid-linux-scsi-driver.patch
  ARECA RAID Linux scsi driver

rt-lsm.patch
  RT-LSM

tty-output-lossage-fix.patch
  tty output lossage fix

cx24110-conexant-frontend-update.patch
  cx24110 Conexant Frontend update

nice-and-rt-prio-rlimits.patch
  nice and rt-prio rlimits

relayfs.patch
  relayfs

relayfs-backing_dev-fix.patch
  relayfs-backing_dev-fix

cfq-iosched-update-to-time-sliced-design.patch
  cfq-iosched: update to time sliced design

cfq-iosched-update-to-time-sliced-design-export-task_nice.patch
  cfq-iosched-update-to-time-sliced-design-export-task_nice

cfq-iosched-update-to-time-sliced-design-fix.patch
  cfq-iosched-update-to-time-sliced-design fix

cfq-iosched-update-to-time-sliced-design-fix-fix.patch
  cfq-iosched-update-to-time-sliced-design-fix-fix

cfq-iosched-update-to-time-sliced-design-use-bio_data_dir.patch
  cfq-iosched-update-to-time-sliced-design: use bio_data_dir()

cfq-ioschedc-fix-soft-hang-with-non-fs-requests.patch
  cfq-iosched.c: fix soft hang with non-fs requests

keys-discard-key-spinlock-and-use-rcu-for-key-payload.patch
  keys: Discard key spinlock and use RCU for key payload

keys-discard-key-spinlock-and-use-rcu-for-key-payload-try-4.patch
  keys: Discard key spinlock and use RCU for key payload - try #4

keys-pass-session-keyring-to-call_usermodehelper.patch
  Keys: Pass session keyring to call_usermodehelper()

keys-pass-session-keyring-to-call_usermodehelper-warning-fix.patch
  keys-pass-session-keyring-to-call_usermodehelper-warning-fix

keys-use-rcu-to-manage-session-keyring-pointer.patch
  Keys: Use RCU to manage session keyring pointer

keys-make-request-key-create-an-authorisation-key.patch
  Keys: Make request-key create an authorisation key

stallion-driver-module-clean-up.patch
  Stallion driver module clean up

use-__init-and-__exit-in-pktcdvd.patch
  Use __init and __exit in pktcdvd

dvd-ram-support-for-pktcdvd.patch
  DVD-RAM support for pktcdvd

break_lock-fix-2.patch
  break_lock fix

cdrom-cdu31a-cleanups.patch
  cdrom/cdu31a: cleanups

cdrom-cdu31a-locking-fixes.patch
  cdrom/cdu31a: locking fixes

cdrom-cdu31a-use-wait_event.patch
  cdrom/cdu31a: use wait_event

revert-gconfig-changes.patch
  revert recent gconfig changes

revert-gconfig-changes-build-fix.patch
  revert-gconfig-changes build fix

enable-gcc-warnings-for-vsprintf-vsnprintf-with-format-attribute.patch
  Enable gcc warnings for vsprintf/vsnprintf with "format" attribute

w6692-eliminate-bad-section-references.patch
  w6692: eliminate bad section references

teles3-eliminate-bad-section-references.patch
  teles3: eliminate bad section references

elsa-eliminate-bad-section-references.patch
  elsa eliminate bad section references

hfc_sx-eliminate-bad-section-references.patch
  hfc_sx: eliminate bad section references

sedlbauer-eliminate-bad-section-references.patch
  sedlbauer: eliminate bad section references

fix-mprotect-with-len=size_t-1-to-return-enomem.patch
  fix mprotect() with len=(size_t)(-1) to return -ENOMEM

checkstack-fix-sort-misbehavior-for-long-function-names.patch
  checkstack: fix sort misbehavior for long function names

fix-irq_affinity-write-from-proc-for-ia64.patch
  Fix irq_affinity write from /proc for ia64

fix-mmap-return-value-to-conform-posix.patch
  fix mmap() return value to conform POSIX

fix-mmap-return-value-to-conform-to-posix.patch
  fix mmap() return value to conform to POSIX

exports-to-enable-clock-driver-modules.patch
  Exports to enable clock driver modules

per-cpu-irq-stat.patch
  Per cpu irq stat

kill-drivers-cdrom-mcdc.patch
  kill drivers/cdrom/mcd.c

drivers-char-isicomc-gcc4-fix.patch
  drivers/char/isicom.c gcc4 fix

infiniband-remove-unsafe-use-of-in_atomic.patch
  InfiniBand: remove unsafe use of in_atomic()

new-console-flag-con_boot.patch
  New console flag: CON_BOOT

new-console-flag-con_boot-comment.patch
  new-console-flag-con_boot-comment

pipe-save-one-pipe-page.patch
  pipe: save one pipe page

kprobes-incorrect-spin_unlock_irqrestore-call-in-register_kprobe.patch
  kprobes: incorrect spin_unlock_irqrestore() call in register_kprobe()

ext2_make_empty-information-leak.patch
  ext2_make_empty information leak fix

missing-set_fs-calls-around-kernel-syscall.patch
  Missing set_fs() calls around kernel syscall

cpusets-mems-generation-deadlock-fix.patch
  cpusets: mems generation deadlock fix

cpusets-alloc-gfp_wait-sleep-fix.patch
  cpusets: alloc GFP_WAIT sleep fix

mtrr-uaccess-range-checking-fix.patch
  mtrr: uaccess range checking fix

cciss-range-checking-fix.patch
  cciss: range chcking fix

fix-posix-timers-expiring-before-their-scheduled-time.patch
  Fix POSIX timers expiring before their scheduled time

fix-oops-when-inserting-ipmi_si-module.patch
  Fix oops when inserting ipmi_si module

binfmt_elf-bss-padding-fix.patch
  binfmt_elf bss padding fix

posix-cpu-timers-and-cputime_t-divisons.patch
  posix-cpu-timers and cputime_t divisons.

timers-prepare-for-del_timer_sync-changes.patch
  timers: prepare for del_timer_sync() changes

timers-rework-del_timer_sync.patch
  timers: rework del_timer_sync()

timers-serialize-timers.patch
  timers: serialize timers

timers-remove-memory-barriers.patch
  timers: remove memory barriers

timers-cleanup-kill-__get_base.patch
  timers: cleanup, kill __get_base()

timers-enable-irqs-in-__mod_timer.patch
  timers: enable irqs in __mod_timer()

timers-enable-irqs-in-__mod_timer-tidy.patch
  timers-enable-irqs-in-__mod_timer-tidy

ext2-3-file-limits-to-avoid-overflowing-i_blocks.patch
  ext2/3 file limits to avoid overflowing i_blocks

load_elf_library-kfree-fix.patch
  load_elf_library kfree fix

futex-queue_me-get_user-ordering-fix.patch
  Futex: make futex_wait() atomic again

io_remap_pfn_range-add-for-all-arch-es.patch
  io_remap_pfn_range: add for all arch-es

io_remap_pfn_range-add-for-all-arch-es-fix.patch
  io_remap_pfn_range-add-for-all-arch-es-fix

io_remap_pfn_range-convert-sparc-callers.patch
  io_remap_pfn_range: convert sparc callers

io_remap_pfn_range-fix-some-callers-for-xen.patch
  io_remap_pfn_range: fix some callers for XEN

io_remap_pfn_range-convert-last-callers.patch
  io_remap_pfn_range: convert last callers

alpha-build-fixes.patch
  alpha build fixes

fix-pcmcia-resume-with-card-inserted.patch
  Fix PCMCIA resume with card inserted

pcmcia-clean-up-suspend.patch
  pcmcia: clean up suspend

small-warning-fix-for-gcc4.patch
  small warning fix for gcc4

enable-sig_ign-on-blocked-signals.patch
  Enable SIG_IGN on blocked signals

alpha-elimitate-two-warnings-from-gcc4.patch
  alpha: elimitate two warnings from gcc4

fat-set-ms_noatime-to-msdos.patch
  FAT: set MS_NOATIME to msdos

fat-fix-msdos-datetime.patch
  FAT: Fix msdos ->[ac]{date,time}

fix-compile-warning-in-drivers-pnp-resourcec-with-config_pci.patch
  Fix compile warning in drivers/pnp/resource.c with !CONFIG_PCI

nlm-fix-f_count-leak.patch
  nlm: fix f_count leak

module-parameter-fixes.patch
  module parameter fixes

fs-hpfs-fix-hpfs-support-under-64-bit-kernel.patch
  fs/hpfs/*: fix HPFS support under 64-bit kernel

arch-hook-for-notifying-changes-in-pte-protections-bits.patch
  arch hook for notifying changes in PTE protections bits

serial-digi-neo-driver.patch
  serial: Digi Neo driver

netmos-parallel-serial-combo-support.patch
  Netmos parallel/serial/combo support

consolidate-asm-ipch.patch
  consolidate asm/ipc.h

bt819-array-indexing-fix.patch
  bt819 array indexing fix

unified-spinlock-initialization.patch
  unified spinlock initialization

drivers-block-dac960c-fix-a-use-after-free.patch
  drivers/block/DAC960.c: fix a use after free

drivers-telephony-ixj-fix-a-use-after-free.patch
  drivers/telephony/ixj: fix a use after free

hfs-free-page-buffers-in-releasepage.patch
  hfs: free page buffers in releasepage

hfs-fix-umask-behaviour.patch
  hfs: fix umask behaviour

hfs-more-bnode-error-checks.patch
  hfs: more bnode error checks

hfs-fix-sign-problem-in-hfs_ext_keycmp.patch
  hfs: fix sign problem in hfs_ext_keycmp

hfs-use-parse-library-for-mount-options.patch
  hfs: use parse library for mount options

hfs-add-nls-support.patch
  hfs: add nls support

hfs-unicode-decompose-support.patch
  hfs: unicode decompose support

inotify-42.patch
  inotify #42

dvb-clarify-firmware-upload-messages.patch
  dvb: clarify firmware upload messages

dvb-dibcom-frontend-fixes.patch
  dvb: dibcom: frontend fixes

dvb-dibusb-misc-fixes.patch
  dvb: dibusb: misc. fixes

dvb-skystar2-remove-duplicate-pci_release_region.patch
  dvb: skystar2: remove duplicate pci_release_region()

dvb-mt352-pinnacle-300i-comments.patch
  dvb: mt352: Pinnacle 300i comments

dvb-support-activy-budget-card.patch
  dvb: support Activy Budget card

dvb-skystar2-update-email-address.patch
  dvb: skystar2: update email address

dvb-ves1x93-invert_pwm-fix.patch
  dvb: ves1x93: invert_pwm fix

dvb-dibusb-readme-update.patch
  dvb: dibusb readme update

dvb-dibusb-support-hauppauge-wintv-nova-t-usb2.patch
  dvb: dibusb: support Hauppauge WinTV NOVA-T USB2

dvb-nxt2002-qam64-256-support.patch
  dvb: nxt2002: QAM64/256 support

dvb-get_dvb_firmware-new-unshield-version.patch
  dvb: get_dvb_firmware: new unshield version

dvb-dib3000-corrected-device-naming.patch
  dvb: dib3000: corrected device naming

dvb-dibusb-debug-changes.patch
  dvb: dibusb: debug changes

dvb-dibusb-increased-the-number-of-urbs-for-usb11-devices.patch
  dvb: dibusb: increased the number of urbs for usb1.1 devices

dvb-ttusb_dec-use-alternative-interface-to-save-bandwidth.patch
  dvb: ttusb_dec: use alternative interface to save bandwidth

dvb-l64781-email-address-fix.patch
  dvb: l64781: email address fix

dvb-skystar2-fix-mac-address-reading.patch
  dvb: skystar2: fix MAC address reading

dvb-support-kworld-adstech-instant-dvb-t-usb20.patch
  dvb: support KWorld/ADSTech Instant DVB-T USB2.0

dvb-cleanups-make-stuff-static.patch
  dvb: cleanups, make stuff static

dvb-refactor-sw-pid-filter-to-drop-redundant-code.patch
  dvb: refactor sw pid filter to drop redundant code

dvb-nxt2002-fix-max-frequency.patch
  dvb: nxt2002: fix max frequency

dvb-ttusb-budget-s-usb_unlink_urb-usb_kill_urb.patch
  dvb: ttusb-budget: s/usb_unlink_urb/usb_kill_urb/

dvb-av7110-fix-oops-when-av7110_ir_init-failed.patch
  dvb: av7110: fix Oops when av7110_ir_init() failed

dvb-saa7146-static-initialization.patch
  dvb: saa7146: static initialization

dvb-av7110-error-handling-during-attach.patch
  dvb: av7110: error handling during attach

dvb-corrected-links-to-firmware-files.patch
  dvb: corrected links to firmware files

dvb-support-pchdtv-hd2000.patch
  dvb: support pcHDTV HD2000

dvb-dibusb-support-nova-t-usb-ir.patch
  dvb: dibusb: support nova-t usb ir

dvb-oren-or51211-or51132_qam-and-or51132_vsb-firmware-download-info.patch
  dvb: OREN or51211, or51132_qam and or51132_vsb firmware download info

dvb-ttusb_dec-ir-support.patch
  dvb: ttusb_dec: IR support

dvb-dibusb-pll-fix.patch
  dvb: dibusb: pll fix

dvb-tda10021-fix-continuity-errors.patch
  dvb: tda10021: fix continuity errors

dvb-saa7146-remove-duplicate-setgpio.patch
  dvb: saa7146: remove duplicate setgpio

dvb-fix-cams-on-typhoon-dvb-s.patch
  dvb: fix CAMs on Typhoon DVB-S

dvb-frontends-kfree-cleanup.patch
  dvb: frontends: kfree() cleanup

dvb-clear-up-confusion-between-ids-and-adapters.patch
  dvb: clear up confusion between ids and adapters

dvb-dibusb-remove-useless-ifdef.patch
  dvb: dibusb: remove useless ifdef

dvb-support-for-technotrend-pci-dvb-t.patch
  dvb: support for Technotrend PCI DVB-T

dvb-dibusb-hanftek-umt-010-fixes.patch
  dvb: dibusb: HanfTek UMT-010 fixes

dvb-vfree-checking-cleanups.patch
  dvb: vfree() checking cleanups

dvb-convert-from-pci_module_init-to-pci_register_driver.patch
  dvb: convert from pci_module_init to pci_register_driver

dvb-dibusb-support-dtt200u-yakumo-typhoon-hama-usb20-device.patch
  dvb: dibusb: support dtt200u (Yakumo/Typhoon/Hama) USB2.0 device

dvb-sparse-warnings-on-one-bit-bitfields.patch
  dvb: sparse warnings on one-bit bitfields

dvb-support-nova-s-rev-22.patch
  dvb: support Nova-S rev 2.2

dvb-ttusb_dec-cleanup.patch
  dvb: ttusb_dec: cleanup

dvb-gcc-295-compile-fixes.patch
  dvb: gcc 2.95 compile fixes

dvb-mt352-cleanups.patch
  dvb: mt352: cleanups

ext3-jbd-race-releasing-in-use-journal_heads.patch
  ext3/jbd race: releasing in-use journal_heads

ext3-writepages-support-for-writeback-mode.patch
  ext3 writepages support for writeback mode

ext3-writeback-nobh-option.patch
  ext3 writeback "nobh" option

ext3-fix-journal_unmap_buffer-race.patch
  ext3: fix journal_unmap_buffer race

ext3-dynamic-allocating-block-reservation-info.patch
  ext3: dynamic allocation of block reservation info

ext3-reservation-info-cleanup-remove-rsv_seqlock.patch
  ext3: reservation info cleanup: remove rsv_seqlock

ext3-reservation-info-cleanup-remove-rsv_seqlock-fix.patch
  ext3-reservation-info-cleanup-remove-rsv_seqlock fix

ext3-move-goal-logical-block-into-block-allocation-info.patch
  ext3: move goal logical block into block allocation info structure

pcmcia-hotplug-event-for-pcmcia-devices.patch
  pcmcia: hotplug event for PCMCIA devices

pcmcia-hotplug-event-for-pcmcia-socket-devices.patch
  pcmcia: hotplug event for PCMCIA socket devices

pcmcia-device-and-driver-matching.patch
  pcmcia: device and driver matching

pcmcia-check-for-invalid-crc32-hashes-in-id_tables.patch
  pcmcia: check for invalid crc32 hashes in id_tables

pcmcia-match-for-fake-cis.patch
  pcmcia: match for fake CIS

pcmcia-export-cis-in-sysfs.patch
  pcmcia: export CIS in sysfs

pcmcia-cis-overrid-via-sysfs.patch
  pcmcia: CIS overrid via sysfs

pcmcia-match-anonymous-cards.patch
  pcmcia: match "anonymous" cards

pcmcia-allow-function-id-based-match.patch
  pcmcia: allow function-ID based match

pcmcia-file2alias.patch
  pcmcia: file2alias

pcmcia-request-cis-via-firmware-interface.patch
  pcmcia: request CIS via firmware interface

pcmcia-cleanups.patch
  pcmcia: cleanups

pcmcia-rescan-bus-always-upon-echoing-into-setup_done.patch
  pcmcia: rescan bus always upon echoing into setup_done

pcmcia-id_table-for-serial_cs.patch
  pcmcia: id_table for serial_cs

pcmcia-id_table-for-3c574_cs.patch
  pcmcia: id_table for 3c574_cs

pcmcia-id_table-for-3c589_cs.patch
  pcmcia: id_table for 3c589_cs

pcmcia-id_table-for-aha152x.patch
  pcmcia: id_table for aha152x

pcmcia-id_table-for-airo_cs.patch
  pcmcia: id_table for airo_cs

pcmcia-id_table-for-axnet_cs.patch
  pcmcia: id_table for axnet_cs

pcmcia-id_table-for-fdomain_stub.patch
  pcmcia: id_table for fdomain_stub

pcmcia-id_table-for-fmvj18x_cs.patch
  pcmcia: id_table for fmvj18x_cs

pcmcia-id_table-for-ibmtr_cs.patch
  pcmcia: id_table for ibmtr_cs

pcmcia-id_table-for-netwave_cs.patch
  pcmcia: id_table for netwave_cs

pcmcia-id_table-for-nmclan_cs.patch
  pcmcia: id_table for nmclan_cs

pcmcia-id_table-for-teles_cs.patch
  pcmcia: id_table for teles_cs

pcmcia-id_table-for-ray_cs.patch
  pcmcia: id_table for ray_cs

pcmcia-id_table-for-wavelan_cs.patch
  pcmcia: id_table for wavelan_cs

pcmcia-id_table-for-sym53c500_csc.patch
  pcmcia: id_table for sym53c500_cs.c

pcmcia-id_table-for-qlogic_stubc.patch
  pcmcia: id_table for qlogic_stub.c

pcmcia-id_table-for-smc91c92_csc.patch
  pcmcia: id_table for smc91c92_cs.c

pcmcia-id_table-for-orinoco_cs.patch
  pcmcia: id_table for orinoco_cs

pcmcia-id_table-for-xirc2ps_csc.patch
  pcmcia: id_table for xirc2ps_cs.c

pcmcia-id_table-for-ide_csc.patch
  pcmcia: id_table for ide_cs.c

pcmcia-id_table-for-parport_csc.patch
  pcmcia: id_table for parport_cs.c

pcmcia-id_table-for-pcnet_csc.patch
  pcmcia: id_table for pcnet_cs.c

pcmcia-id_table-for-pcmciamtdc.patch
  pcmcia: id_table for pcmciamtd.c

pcmcia-id_table-for-vxpocketc.patch
  pcmcia: id_table for vxpocket.c

pcmcia-id_table-for-atmel_csc.patch
  pcmcia: id_table for atmel_cs.c

pcmcia-id_table-for-avma1_csc.patch
  pcmcia: id_table for avma1_cs.c

pcmcia-id_table-for-avm_csc.patch
  pcmcia: id_table for avm_cs.c

pcmcia-id_table-for-bluecard_csc.patch
  pcmcia: id_table for bluecard_cs.c

pcmcia-id_table-for-bt3c_csc.patch
  pcmcia: id_table for bt3c_cs.c

pcmcia-id_table-for-btuart_csc.patch
  pcmcia: id_table for btuart_cs.c

pcmcia-id_table-for-com20020_csc.patch
  pcmcia: id_table for com20020_cs.c

pcmcia-id_table-for-dtl1_csc.patch
  pcmcia: id_table for dtl1_cs.c

pcmcia-id_table-for-elsa_csc.patch
  pcmcia: id_table for elsa_cs.c

pcmcia-id_table-for-ixj_pcmciac.patch
  pcmcia: id_table for ixj_pcmcia.c

pcmcia-id_table-for-nsp_csc.patch
  pcmcia: id_table for nsp_cs.c

pcmcia-id_table-for-sedlbauer_csc.patch
  pcmcia: id_table for sedlbauer_cs.c

pcmcia-id_table-for-wl3501_csc.patch
  pcmcia: id_table for wl3501_cs.c

pcmcia-id_table-for-pdaudiocfc.patch
  pcmcia: id_table for pdaudiocf.c

pcmcia-id_table-for-synclink_csc.patch
  pcmcia: id_table for synclink_cs.c

pcmcia-add-some-documentation.patch
  pcmcia: add some Documentation

pcmcia-update-resource-database-adjust-routines-to-use-unsigned-long-values.patch
  pcmcia: update resource database adjust routines to use unsigned long values

pcmcia-mark-parent-bridge-windows-as-resources-available-for-pcmcia-devices.patch
  pcmcia: mark parent bridge windows as resources available for PCMCIA devices

pcmcia-add-a-config-option-for-the-pcmica-ioctl.patch
  pcmcia: add a config option for the PCMICA ioctl

pcmcia-move-pcmcia-ioctl-to-a-separate-file.patch
  pcmcia: move PCMCIA ioctl to a separate file

pcmcia-clean-up-cs-ds-callback.patch
  pcmcia: clean up cs ds callback

pcmcia-clean-up-cs-ds-callback-fix.patch
  pcmcia-clean-up-cs-ds-callback-fix

pcmcia-make-pcmcia-status-a-bitfield.patch
  pcmcia: make PCMCIA status a bitfield

pcmcia-merge-struct-pcmcia_bus_socket-into-struct-pcmcia_socket.patch
  pcmcia: merge struct pcmcia_bus_socket into struct pcmcia_socket

pcmcia-remove-unneeded-includes-in-dsc.patch
  pcmcia: remove unneeded includes in ds.c

pcmcia-rename-some-functions.patch
  pcmcia: rename some functions

pcmcia-move-pcmcia-resource-handling-out-of-csc.patch
  pcmcia: move pcmcia resource handling out of cs.c

pcmcia-csc-cleanup.patch
  pcmcia: cs.c cleanup

pcmcia-dsc-cleanup.patch
  pcmcia: ds.c cleanup

pcmcia-release_class.patch
  pcmcia: release_class

pcmcia-use-request_region-in-i82365.patch
  pcmcia: use request_region in i82365

pcmcia-synclink_cs-irq_info2_info-is-gone.patch
  pcmcia: synclink_cs IRQ_INFO2_INFO is gone

pcmcia-mod_devicetableh-fix-for-different-sizes-in-kernel-and-userspace.patch
  pcmcia: mod_devicetable.h fix for different sizes in kernel- and userspace

pcmcia-select-crc32-in-kconfig-for-pcmcia.patch
  pcmcia: select crc32 in Kconfig for PCMCIA

svcrpc-auth_domain-documentation.patch
  svcrpc: auth_domain documentation

nfsd4-fix-share-conflict-tests.patch
  nfsd4: fix share conflict tests

nfsd4-remove-unneeded-stateowner-arguments.patch
  nfsd4: remove unneeded stateowner arguments

nfsd4-fix-use-after-put-in-cb_recall.patch
  nfsd4: fix use after put() in cb_recall

nfsd4-allow-read-on-open-for-write.patch
  nfsd4: allow read on open for write

nfsd4-factor-out-common-open_truncate-code.patch
  nfsd4: factor out common open_truncate code

nfsd4-fix-failure-to-truncate-on-some-opens.patch
  nfsd4: fix failure to truncate on some opens

nfsd4_remove_unused_acl_function.patch
  nfsd4_remove_unused_acl_function

nfsd4-dont-set-write_owner-in-either-allow-or-deny-bits.patch
  nfsd4: don't set WRITE_OWNER in either allow or deny bits

nfsd4-acl-dont-set-named-attrs.patch
  nfsd4: acl don't set named attrs

nfsd4-acl-error-fix.patch
  nfsd4: acl error fix

nfsd4-rename-release_delegation.patch
  nfsd4: rename release_delegation

nfsd4-remove-trailing-whitespace-from-nfs4procc.patch
  nfsd4: remove trailing whitespace from nfs4proc.c

nfsd4-fix-open-returns-for-other-claim-types.patch
  nfsd4: fix open returns for other claim types

nfsd4-fix-indentation-in-nfsd4_open.patch
  nfsd4: fix indentation in nfsd4_open

nfsacl-solaris-nfsacl-workaround.patch
  nfsacl: Solaris nfsacl workaround

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
  kgdb: kill off highmem_start_page
  kgdb documentation fix

kgdb-x86-config_debug_info-fix.patch
  kgdb CONFIG_DEBUG_INFO fix

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes
  kgdb-x86_64-fix
  kgdb-x86_64-serial-fix
  kprobes exception notifier fix

kgdb-x86_64-config_debug_info-fix.patch
  kgdb CONFIG_DEBUG_INFO fix

rock-lindent.patch
  rock: lindent it

rock-manual-tidies.patch
  rock: manual tidies

rock-remove-CHECK_SP.patch
  rock: remove CHECK_SP

rock-remove-CONTINUE_DECLS.patch
  rock: remove CONTINUE_DECLS

rock-remove-CHECK_CE.patch
  rock: remove CHECK_CE

rock-remove-SETUP_ROCK_RIDGE.patch
  rock: remove SETUP_ROCK_RIDGE

rock-remove-MAYBE_CONTINUE.patch
  rock: remove MAYBE_CONTINUE

rock-comment-tidies.patch
  rock: comment tidies

rock-lindent-rock-h.patch
  rock: lindent rock.h

isofs-remove-debug-stuff.patch
  isofs: remove debug stuff

rock-handle-corrupted-directories.patch
  rock.c: handle corrupted directories

rock-rename-union-members.patch
  rock: rename union members

rock-handle-directory-overflows.patch
  rock: handle directory overflows

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

list_del-debug.patch
  list_del debug check

page-owner-tracking-leak-detector.patch
  Page owner tracking leak detector

make-page_owner-handle-non-contiguous-page-ranges.patch
  make page_owner handle non-contiguous page ranges

add-gfp_mask-to-page-owner.patch
  add gfp_mask to page owner

unplug-can-sleep.patch
  unplug functions can sleep

firestream-warnings.patch
  firestream warnings

periodically-scan-redzone-entries-and-slab-control-structures.patch
  periodically scan redzone entries and slab control structures

slab-leak-detector.patch
  slab leak detector

slab-leak-detector-warning-fixes.patch
  slab leak detector warning fixes

irqpoll.patch
  irqpoll

figure-out-who-is-inserting-bogus-modules.patch
  Figure out who is inserting bogus modules

figure-out-who-is-inserting-bogus-modules-warning-fix.patch
  Warning fix and be extra careful about array in kernel/module.c

releasing-resources-with-children.patch
  Releasing resources with children

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

perfctr-2710-api-update-1-4-common.patch
  perfctr-2.7.10 API update 1/4: common

perfctr-2710-api-update-2-4-i386.patch
  perfctr-2.7.10 API update 2/4: i386

perfctr-2710-api-update-3-4-x86_64.patch
  perfctr-2.7.10 API update 3/4: x86_64

perfctr-2710-api-update-4-4-ppc32.patch
  perfctr-2.7.10 API update 4/4: ppc32

perfctr-api-update-1-9-physical-indexing-x86.patch
  perfctr API update 1/9: physical indexing, x86

perfctr-api-update-2-9-physical-indexing-ppc32.patch
  perfctr API update 2/9: physical indexing, ppc32

perfctr-api-update-3-9-cpu_control_header-x86.patch
  perfctr API update 3/9: cpu_control_header, x86

perfctr-api-update-4-9-cpu_control_header-ppc32.patch
  perfctr API update 4/9: cpu_control_header, ppc32

perfctr-api-update-5-9-cpu_control_header-common.patch
  perfctr API update 5/9: cpu_control_header, common

perfctr-api-update-6-9-cpu_control-access-common.patch
  perfctr API update 6/9: cpu_control access, common

perfctr-api-update-7-9-cpu_control-access-x86.patch
  perfctr API update 7/9: cpu_control access, x86

perfctr-api-update-8-9-cpu_control-access-ppc32.patch
  perfctr API update 8/9: cpu_control access, ppc32

perfctr-api-update-9-9-domain-based-read-write-syscalls.patch
  perfctr API update 9/9: domain-based read/write syscalls

perfctr-ia32-syscalls-on-x86-64-fix.patch
  perfctr ia32 syscalls on x86-64 fix

perfctr-cleanups-1-3-common.patch
  perfctr cleanups: common

perfctr-cleanups-2-3-ppc32.patch
  perfctr cleanups: ppc32

perfctr-cleanups-3-3-x86.patch
  perfctr cleanups: x86

perfctr-x86-fix-and-cleanups.patch
  perfctr: x86 fix and cleanups

perfctr-ppc32-fix-and-cleanups.patch
  perfctr: ppc32 fix and cleanups

perfctr-64-bit-values-in-register-descriptors.patch
  perfctr: 64-bit values in register descriptors

perfctr-64-bit-values-in-register-descriptors-fix.patch
  perfctr-64-bit-values-in-register-descriptors fix

sched2-fix-schedstats-warning.patch
  sched: fix schedstats warning

sched2-cleanup-wake_idle.patch
  sched: cleanup wake_idle

sched2-improve-load-balancing-pinned-tasks.patch
  sched: improve load balancing pinned tasks

sched2-reduce-active-load-balancing.patch
  sched: reduce active load balancing

sched2-fix-smt-scheduling-problems.patch
  sched: fix SMT scheduling problems

sched2-add-debugging.patch
  sched: add debugging

sched2-less-aggressive-idle-balancing.patch
  sched: less aggressive idle balancing

sched2-balance-timers.patch
  sched: balance timers

sched2-tweak-affine-wakeups.patch
  sched: tweak affine wakeups

sched2-no-aggressive-idle-balancing.patch
  sched: no aggressive idle balancing

sched2-balance-on-fork.patch
  sched: balance on fork

sched2-schedstats-update-for-balance-on-fork.patch
  sched: schedstats update for balance on fork

sched2-sched-tuning.patch
  sched: sched tuning

sched2-sched-tuning-fix.patch
  sched2-sched-tuning-fix

sched2-sched-domain-sysctl.patch
  sched: sched domain sysctl

add-do_proc_doulonglongvec_minmax-to-sysctl-functions.patch
  Add do_proc_doulonglongvec_minmax to sysctl functions
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions-fix
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions fix 2

allow-x86_64-to-reenable-interrupts-on-contention.patch
  Allow x86_64 to reenable interrupts on contention

i386-cpu-hotplug-updated-for-mm.patch
  i386 CPU hotplug updated for -mm
  ppc64: fix hotplug cpu

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

fscache-menuconfig-help-fix-documentation-path.patch
  fscache-menuconfig-help-fix-documentation-pathc

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

x86-config-kernel-start.patch
  kexec: x86: add CONFIG_PYSICAL_START

kexec-reserve-bootmem-fix-for-booting-nondefault-location-kernel.patch
  kexec: reserve Bootmem fix for booting nondefault location kernel

x86_64-config-kernel-start.patch
  kexec: x86_64: add CONFIG_PHYSICAL_START

kexec-kexec-generic.patch
  kexec: add kexec syscalls

kexec-kexec-generic-kexec-use-unsigned-bitfield.patch
  kexec: use unsigned bitfield

x86-machine_shutdown.patch
  kexec: x86: factor out apic shutdown code

x86-kexec.patch
  kexec: x86 kexec core

x86-crashkernel.patch
  crashdump: x86 crashkernel option

x86-crashkernel-fix.patch
  kexec: fix for broken kexec on panic

x86_64-machine_shutdown.patch
  kexec: x86_64: factor out apic shutdown code

x86_64-kexec.patch
  kexec: x86_64 kexec implementation

x86_64-crashkernel.patch
  crashdump: x86_64: crashkernel option

kexec-ppc-support.patch
  kexec: kexec ppc support

kexec-ppc-fix-noret_type.patch
  kexec: ppc: fix NORET_TYPE

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

crashdump-routines-for-copying-dump-pages-fixes.patch
  crashdump-routines-for-copying-dump-pages-fixes

crashdump-elf-format-dump-file-access.patch
  crashdump: elf format dump file access

crashdump-linear-raw-format-dump-file-access.patch
  crashdump: linear raw format dump file access

crashdump-linear-raw-format-dump-file-access-coding-style.patch
  crashdump-linear-raw-format-dump-file-access-coding-style

kdump-export-crash-notes-section-address-through.patch
  Kdump: Export crash notes section address through sysfs

kdump-export-crash-notes-section-address-through-build-fix.patch
  kdump-export-crash-notes-section-address-through build fix

kdump-export-crash-notes-section-address-through-x86_64-fix.patch
  kdump-export-crash-notes-section-address-through x86_64 fix

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

reiser4-rcu-barrier-license-fix.patch
  reiser4-rcu-barrier-license-fix

reiser4-export-inode_lock.patch
  reiser4: export inode_lock to modules

reiser4-export-inode_lock-unexport-__iget.patch
  reiser4-export-inode_lock-unexport-__iget

reiser4-export-pagevec-funcs.patch
  reiser4: export pagevec functions to modules

reiser4-export-radix_tree_preload.patch
  reiser4: export radix_tree_preload() to modules

reiser4-export-find_get_pages.patch

reiser4-radix_tree_lookup_slot.patch
  reiser4: add radix_tree_lookup_slot()

reiser4-perthread-pages.patch
  reiser4: per-thread page pools

reiser4-perthread_pages_alloc-cleanup.patch
  perthread_pages_alloc cleanup

reiser4-include-reiser4.patch
  reiser4: add to build system

reiser4-doc.patch
  reiser4: documentation

reiser4-only.patch
  reiser4: main fs

fs-reiser4-possible-cleanups.patch
  fs/reiser4/: possible cleanups

reiser4-kconfig-help-cleanup.patch
  reiser4 Kconfig help cleanup

reiser4-cleanup-pg_arch_1.patch
  reiser4 cleanup (PG_arch_1)

reiser4-build-fix.patch
  reiser4 build fix

reiser4-update.patch
  reiser4 update

reiser4-only-memory_backed-fix.patch
  reiser4-only-memory_backed-fix

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

au1x00_uart-deadlock-fix.patch
  au1x00_uart deadlock fix

wbsd-update.patch
  wbsd update

remove-lock_section-from-x86_64-spin_lock-asm.patch
  remove LOCK_SECTION from x86_64 spin_lock asm

kfree_skb-dump_stack.patch
  kfree_skb-dump_stack

minimal-ide-disk-updates.patch
  Minimal ide-disk updates

vt-dont-call-unblank-at-irq-time.patch
  vt: don't call unblank at irq time

ppc32-move-powermac-backlight-stuff-to-a-workqueue.patch
  ppc32: move powermac backlight stuff to a workqueue

radeonfb-implement-proper-workarounds-for-pll-accesses.patch
  radeonfb: Implement proper workarounds for PLL accesses

radeonfb-ddc-i2c-fix.patch
  radeonfb: DDC i2c fix

fbdev-nvidia-licensing-clarification.patch
  fbdev: mvidia licensing clarification

fbcon-stop-framebuffer-operations-before-hardware-is-properly-initialized.patch
  fbcon: Stop framebuffer operations before hardware is properly initialized

nvidiafb-maximize-blit-buffer-capacity.patch
  nvidiafb: Maximize blit buffer capacity

pm2fb-x-and-vt-switching-crash-fix.patch
  pm2fb: X and VT switching crash fix

nvidiafb-kconfig-help-text-update-for-config-fb_nvidia.patch
  nvidiafb: Kconfig help text update for config FB_NVIDIA

fbdev-cleanups-in-drivers-video-part-2.patch
  fbdev: Cleanups in drivers/video part 2

fbdev-cleanups-in-drivers-video-part-2-fix.patch
  fbdev-cleanups-in-drivers-video-part-2 fix

excessive-atyfb-debug-messages.patch
  Excessive atyfb debug messages

atyfb-add-boot-module-option-to-override-composite-sync.patch
  atyfb: Add boot/module option to override composite sync

fbdev-kconfig-fix-for-macmodes-and-ppc.patch
  fbdev: Kconfig fix for macmodes and PPC

fbdev-convert-drivers-to-pci_register_driver.patch
  fbdev: Convert drivers to pci_register_driver

sisfb-trivial-cleanups.patch
  sisfb: Trivial cleanups

tridentfb-clean-up-printks.patch
  tridentfb: Clean up printk()'s

s1d13xxxfb-add-support-for-epson-s1d13806-fb.patch
  s1d13xxxfb: Add support for Epson S1D13806 FB

nvidiafb-process-boot-options-earlier.patch
  nvidiafb: Process boot options earlier

fbcon-save-var-rotate-field-in-struct-display.patch
  fbcon: Save var rotate field in struct display

fbcon-call-set_par-per-fb_info-once-during-init.patch
  fbcon: Call set_par per fb_info once during init

fbcon-do-not-set-palette-if-console-is-not-visible.patch
  fbcon: Do not set palette if console is not visible

nvidiafb-delete-i2c-bus-on-driver-unload.patch
  nvidiafb: Delete i2c bus on driver unload

neofb-mmio-fixes.patch
  neofb: mmio fixes

neofb-set-hwaccel-flags-properly.patch
  neofb: Set hwaccel flags properly

remove-redundant-null-checks-before-kfree-in-drivers-video.patch
  remove redundant NULL checks before kfree() in drivers/video/

remove-redundant-null-checks-before-kfree-in-drivers-video-fix.patch
  remove-redundant-null-checks-before-kfree-in-drivers-video fix

md-merge-md_enter_safemode-into-md_check_recovery.patch
  md: merge md_enter_safemode into md_check_recovery

md-improve-locking-on-safemode-and-move-superblock-writes.patch
  md: improve locking on 'safemode' and move superblock writes

md-improve-the-interface-to-sync_request.patch
  md: improve the interface to sync_request

md-optimised-resync-using-bitmap-based-intent-logging.patch
  md: optimised resync using Bitmap based intent logging

md-a-couple-of-tidyups-relating-to-the-bitmap-file.patch
  md: a couple of tidyups relating to the bitmap file.

md-call-bitmap_daemon_work-regularly.patch
  md: call bitmap_daemon_work regularly

md-print-correct-pid-for-newly-created-bitmap-writeback-daemon.patch
  md: print correct pid for newly created bitmap-writeback-daemon.

md-minor-code-rearrangement-in-bitmap_init_from_disk.patch
  md: minor code rearrangement in bitmap_init_from_disk

md-make-sure-md-bitmap-is-cleared-on-a-clean-start.patch
  md: make sure md bitmap is cleared on a clean start.

md-printk-fix.patch
  md printk fix

md-improve-debug-printing-of-bitmap-superblock.patch
  md: improve debug-printing of bitmap superblock.

md-check-return-value-of-write_page-rather-than-ignore-it.patch
  md: check return value of write_page, rather than ignore it

md-enable-the-bitmap-write-back-daemon-and-wait-for-it.patch
  md: enable the bitmap write-back daemon and wait for it.

md-dont-skip-bitmap-pages-due-to-lack-of-bit-that-we-just-cleared.patch
  md: don't skip bitmap pages due to lack of bit that we just cleared.

md-optimised-resync-using-bitmap-based-intent-logging-fix.patch
  md-optimised-resync-using-bitmap-based-intent-logging fix

md-raid1-support-for-bitmap-intent-logging.patch
  md: raid1 support for bitmap intent logging

md-fix-bug-when-raid1-attempts-a-partial-reconstruct.patch
  md: fix bug when raid1 attempts a partial reconstruct.

md-raid1-support-for-bitmap-intent-logging-fix.patch
  md: initialise sync_blocks in raid1 resync

md-optimise-reconstruction-when-re-adding-a-recently-failed-drive.patch
  md: optimise reconstruction when re-adding a recently failed drive.

md-fix-deadlock-due-to-md-thread-processing-delayed-requests.patch
  md: fix deadlock due to md thread processing delayed requests.

md-allow-md-intent-bitmap-to-be-stored-near-the-superblock.patch
  md: allow md intent bitmap to be stored near the superblock.

md-allow-md-to-update-multiple-superblocks-in-parallel.patch
  md: allow md to update multiple superblocks in parallel.

detect-atomic-counter-underflows.patch
  detect atomic counter underflows

post-halloween-doc.patch
  post halloween doc

fuse-maintainers-kconfig-and-makefile-changes.patch
  FUSE - MAINTAINERS, Kconfig and Makefile changes

fuse-core.patch
  FUSE - core

fuse-device-functions.patch
  FUSE - device functions

fuse-read-only-operations.patch
  FUSE - read-only operations

fuse-read-write-operations.patch
  FUSE - read-write operations

fuse-file-operations.patch
  FUSE - file operations

fuse-mount-options.patch
  FUSE - mount options

fuse-mount-options-fix.patch
  fuse: fix busy inodes after unmount

fuse-mount-options-fix-fix.patch
  FUSE: fix locking for background list

fuse-extended-attribute-operations.patch
  FUSE - extended attribute operations

fuse-readpages-operation.patch
  FUSE - readpages operation

fuse-nfs-export.patch
  FUSE - NFS export

fuse-direct-i-o.patch
  FUSE - direct I/O

fuse-transfer-readdir-data-through-device.patch
  fuse: transfer readdir data through device

drivers-isdn-divert-isdn_divertc-make-5-functions-static.patch
  drivers/isdn/divert/isdn_divert.c: make 5 functions static

drivers-isdn-capi-make-some-code-static.patch
  drivers/isdn/capi/: make some code static

drivers-scsi-pas16c-make-code-static.patch
  drivers/scsi/pas16.c: make code static

fix-pm_message_t-in-generic-code.patch
  Fix pm_message_t in generic code

fix-u32-vs-pm_message_t-in-usb.patch
  Fix u32 vs. pm_message_t in USB

more-pm_message_t-fixes.patch
  more pm_message_t fixes

fix-u32-vs-pm_message_t-confusion-in-oss.patch
  Fix u32 vs. pm_message_t confusion in OSS

fix-u32-vs-pm_message_t-confusion-in-pcmcia.patch
  Fix u32 vs. pm_message_t confusion in PCMCIA

fix-u32-vs-pm_message_t-confusion-in-framebuffers.patch
  Fix u32 vs. pm_message_t confusion in framebuffers

fix-u32-vs-pm_message_t-confusion-in-mmc.patch
  Fix u32 vs. pm_message_t confusion in MMC

fix-u32-vs-pm_message_t-confusion-in-serials.patch
  Fix u32 vs. pm_message_t confusion in serials

fix-u32-vs-pm_message_t-in-macintosh.patch
  Fix u32 vs. pm_message_t in macintosh

fix-u32-vs-pm_message_t-confusion-in-agp.patch
  Fix u32 vs. pm_message_t confusion in AGP

cyrix-eliminate-bad-section-references.patch
  cyrix: eliminate bad section references

drivers-media-video-tvaudioc-make-some-variables-static.patch
  drivers/media/video/tvaudio.c: make some variables static

drivers-isdn-sc-possible-cleanups.patch
  drivers/isdn/sc/: possible cleanups

drivers-isdn-pcbit-possible-cleanups.patch
  drivers/isdn/pcbit/: possible cleanups

drivers-isdn-i4l-possible-cleanups.patch
  drivers/isdn/i4l/: possible cleanups

unexport-mca_find_device_by_slot.patch
  unexport mca_find_device_by_slot

drivers-isdn-hardware-avm-misc-cleanups.patch
  drivers/isdn/hardware/avm/: misc cleanups

drivers-isdn-act2000-capic-if-0-an-unused-function.patch
  drivers/isdn/act2000/capi.c: #if 0 an unused function

tpm-fix-gcc-printk-warnings.patch
  tpm: fix gcc printk warnings

x86-64-add-memcpy-memset-prototypes.patch
  x86-64: add memcpy/memset prototypes

au1100fb-convert-to-c99-inits.patch
  au1100fb: convert to C99 inits.

reiserfs-use-null-instead-of-0.patch
  reiserfs: use NULL instead of 0

comments-on-locking-of-task-comm.patch
  comments on locking of task->comm

riottyc-cleanups-and-warning-fix.patch
  riotty.c cleanups and warning fix

fixup-a-comment-still-refering-to-verify_area.patch
  fix up a comment still refering to verify_area

char-ds1620-use-msleep-instead-of-schedule_timeout.patch
  char/ds1620: use msleep() instead of schedule_timeout()

char-tty_io-replace-schedule_timeout-with-msleep_interruptible.patch
  char/tty_io: replace schedule_timeout() with msleep_interruptible()

kernel-timer-fix-msleep_interruptible-comment.patch
  kernel/timer: fix msleep_interruptible() comment

ixj-compile-warning-cleanup.patch
  ixj* - compile warning cleanup

spelling-cleanups-in-shrinker-code.patch
  Spelling cleanups in shrinker code

init-do_mounts_initrdc-fix-sparse-warning.patch
  init/do_mounts_initrd.c: fix sparse warning

arch-i386-kernel-trapsc-fix-sparse-warnings.patch
  arch/i386/kernel/traps.c: fix sparse warnings

arch-i386-kernel-apmc-fix-sparse-warnings.patch
  arch/i386/kernel/apm.c: fix sparse warnings

arch-i386-mm-faultc-fix-sparse-warnings.patch
  arch/i386/mm/fault.c: fix sparse warnings

arch-i386-crypto-aesc-fix-sparse-warnings.patch
  arch/i386/crypto/aes.c: fix sparse warnings

codingstyle-trivial-whitespace-fixups.patch
  CodingStyle: trivial whitespace fixups

small-partitions-msdos-cleanups.patch
  small partitions/msdos cleanups

remove-redundant-null-check-before-before-kfree-in.patch
  remove redundant NULL check before before kfree() in  kernel/sysctl.c

update-ross-biro-bouncing-email-address.patch
  update Ross Biro bouncing email address

get-rid-of-redundant-null-checks-before-kfree-in-arch-i386.patch
  get rid of redundant NULL checks before kfree() in arch/i386/

remove-redundant-null-checks-before-kfree-in-sound-and.patch
  remove redundant NULL checks before kfree() in sound/ and avoid casting pointers about to be kfree()'ed

x86-geode-support-fixes.patch
  x86: geode support fixes

drivers-scsi-initioc-cleanups.patch
  drivers/scsi/initio.c: cleanups

dont-do-pointless-null-checks-and-casts-before-kfree.patch
  selinux: kfree cleanup

drivers-char-isicomc-section-fixes.patch
  drivers/char/isicom.c: section fixes

sound-oss-cleanups.patch
  sound/oss/: cleanups

mm-mmapnommuc-several-unexports.patch
  mm/{mmap,nommu}.c: several unexports

unexport-hugetlb_total_pages.patch
  unexport hugetlb_total_pages

unexport-clear_page_dirty_for_io.patch
  unexport clear_page_dirty_for_io

mm-filemapc-make-sync_page_range_nolock-static.patch
  mm/filemap.c: make sync_page_range_nolock static

mm-filemapc-make-generic_file_direct_io-static.patch
  mm/filemap.c: make generic_file_direct_IO static



