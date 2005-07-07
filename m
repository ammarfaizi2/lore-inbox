Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVGGLB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVGGLB0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 07:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVGGLBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 07:01:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63967 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261176AbVGGLBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 07:01:20 -0400
Date: Thu, 7 Jul 2005 04:00:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc2-mm1
Message-Id: <20050707040037.04366e4e.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc2/2.6.13-rc2-mm1/

(kernel.org seems to be stuck again - there's a copy at
http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.13-rc2-mm1.gz)


- Various stuff.

- I seem to have quite a bit of material here which is appropriate to
  2.6.13:

  - All the ppc64 patches

  - Most of the PM/swsusp patches

  - UML

  - Not sure about smsc-ircc2-*?

  - infiniband update (the VM changes are awkward, but are localised)

  - rapidio is still on hold pending rework of rapidio-support-net-driver.patch

  - all the VFS/namespace patches are on hold pending review

  - all the DVB patches

  - all the pcmcia patches

  - all the nfs4 patches

  - all the v4l patches

  - other random patches

- Anything which you think needs to go into 2.6.13, please let me know.

- And I need to do another round of sending patches to subsystem
  maintainers.  Each time I do this only about one third of it sticks.  Please
  try harder.




Changes since 2.6.13-rc1-mm1:


-fat-fix-slab-cache-leak-section-fix.patch
-i2c-new-max6875-driver-may-corrupt-eeproms.patch
-input-section-fix.patch
-gregkh-pci-pci-assign-unassigned-resources-fix.patch
-remove-newline-from-pci-modalias-variable.patch
-mptspi-build-fix.patch
-ppc32-add-the-freescale-mpc86xads-board-support.patch
-ppc32-stop-misusing-ntps-time_offset-value.patch
-openfirmware-generate-device-table-for-userspace.patch
-openfirmware-add-sysfs-nodes-for-open-firmware-devices.patch
-openfirmware-implement-hotplug-for-macio-devices.patch
-alpha-smp-fix.patch
-pcie-acpi-tg3-ethernet-not-coming-back-properly-after-s3-suspendon-dellm70.patch
-fix-few-remaining-u32-vs-pm_message_t-problems.patch
-input-stop-reporting-input-ctrl-xfers-as-hiddev-events-v2.patch
-fix-namespace-problem-and-sparc64-build.patch

 Merged

+uml-kill-some-useless-vmalloc-tlb-flushing.patch

 UML fix

+iounmap-debugging.patch

 Drop a stack trace when someone iounmaps a bad address

+i2o-config-osm-build-fix.patch

 build fix

+acpi-re-enable-c2-c3-cpu-states-for-systems-without.patch

 ACPI fix

+gregkh-driver-securityfs.patch
+gregkh-driver-speakup-docs.patch
+gregkh-driver-speakup-core.patch

 driver-core updates

+gregkh-i2c-i2c-via686a-cleanups.patch
+gregkh-i2c-i2c-tps6501x-cleanups.patch
+gregkh-i2c-i2c-string-strip.patch
+gregkh-i2c-i2c-max6875-may-do-bad-things.patch
+gregkh-i2c-i2c-max6875-documentation.patch
+gregkh-i2c-i2c-max6875-Kconfig.patch
+gregkh-i2c-i2c-m41t00-kfree-fix.patch
+gregkh-i2c-i2c-idr-core.patch
+gregkh-i2c-i2c-drop-bogus-eeprom-comment.patch
+gregkh-i2c-i2c-docs-01.patch
+gregkh-i2c-i2c-docs-02.patch
+gregkh-i2c-i2c-dev-doc-update.patch
+gregkh-i2c-i2c-atxp1-build-fix.patch
+gregkh-i2c-w1-bigendian-crc-fix.patch

 i2c updates

+input-usb-ignore-logitech-vendor-usages.patch
+input-usb-hid-simulation-usages.patch
+input-i8042-no-cmd-negate.patch
+input-synaptics-dynabook.patch
+input-input-check-keycodesize.patch
+input-joydev-msecs.patch
+input-alps-suspend-typo.patch
+input-alps-fix-tap-logic.patch
+input-hid-badpad-trust-sight.patch
+input-hid-more-consumer-usages.patch
+input-hiddev-no-ctrl-in-read.patch
+input-atkbd-allow-0x7f-scancode.patch
+input-psmouse-wheel-mice-have-middle-button.patch
+input-hid-variable-max-buffer-size.patch
+input-hid-remove-mcc-blacklist.patch

 Vojtech's input driver tree

+i8042-x86ia64-printk-fixes.patch

 Fix a coupe of printks

-gregkh-pci-pci-fix-routing-in-parent-bridge.patch
-gregkh-pci-pci-collect-host-bridge-resources-01.patch
-gregkh-pci-pci-collect-host-bridge-resources-02.patch
-gregkh-pci-pci-handle-subtractive-decode.patch
-gregkh-pci-pci-assign-unassigned-resources.patch

 changes in pci tree

 revert-gregkh-pci-pci-assign-unassigned-resources.patch

 hm, why is this still needed?

-revert-gregkh-pci-pci-collect-host-bridge-resources-02.patch

 no longer needed

+git-sparc64.patch

 davem's sparc tree

+gregkh-usb-usb-sn9c10x-update.patch
+gregkh-usb-usb-gadget-ether-fix-01.patch
+gregkh-usb-usb-gadget-ether-fix-02.patch
+gregkh-usb-usb-ohci-udc-tweaks.patch
+gregkh-usb-usb-ohci-omap-pm-updates.patch
+gregkh-usb-usb-ohci-merge-fix.patch
+gregkh-usb-usb-cdc-descriptor-add.patch

 USB tree updates

+print-order-information-when-oom-killing.patch
+print-order-information-when-oom-killing-fix.patch

 Extra debug output during oom-killing

+remove-completly-bogus-comment-inside-__alloc_pages-try_to_free_pages-handling.patch

 Fix a comment

+madvise-does-not-always-return-ebadf-on-non-file.patch

 Fix madvise() error return value

+quieten-oom-killer-noise.patch

 Make the oom-killer less noisy

+orinoco-sparse-fixes.patch

 sparse annotation and fixes

+ipw2200-build-fix.patch

 Fix compile in Jeff's stuff.

+build-tags-problem-with-o=.patch
+kbuild-build-a-single-module-using-make-dir-moduleko.patch

 kbuild features

+ppc64-vdso32-fix-link-errors-after-recent-toolchain-changes.patch
+ppc64-use-c99-initialisers-in-cputable-code.patch
+ppc64-fix-runlatch-code-to-work-on-pseries-machines.patch
+ppc64-turn-runlatch-on-in-exception-entry.patch
+move-ioprio-syscalls-into-syscallsh.patch
+ppc64-sys_ppc32c-cleanups.patch
+ppc64-add-ioprio-syscalls.patch
+ppc64-remove-duplicate-syscall-reservation.patch
+hvc_console-rearrange-code.patch
+hvc_console-match-vio-and-console-devices-using-vterm-numbers.patch
+hvc_console-dont-always-kick-the-poll-thread-in-interrupt.patch
+hvc_console-magic_sysrq-should-only-be-on-console-channel.patch
+hvc_console-unregister-the-console-in-the-exit-routine.patch
+hvc_console-add-missing-include.patch
+hvc_console-remove-num_vterms-and-some-dead-code.patch
+hvc_console-statically-initialize-the-vtermnos-array.patch
+hvc_console-add-some-sanity-checks.patch
+hvc_console-separate-hvc_console-and-vio-code.patch
+hvc_console-separate-hvc_console-and-vio-code-2.patch
+hvc_console-register-ops-when-setting-up-hvc_console.patch
+hvc_console-separate-the-nul-character-filtering-from-get_hvc_chars.patch
+hvc_console-use-hvc_get_chars-in-hvsi-code.patch
+ppc64-make-idle_loop-a-ppc_md-function.patch
+ppc64-move-iseries_idle-into-iseries_setupc.patch
+ppc64-move-pseries-idle-functions-into-pseries_setupc.patch
+ppc64-fixup-platforms-for-new-ppc_mdidle.patch
+ppc64-remove-obsolete-idle_setup.patch
+ppc64-iseries-idle-fixups.patch
+ppc64-pseries-idle-fixups.patch
+ppc64-idle-fixups.patch
+ppc64-fix-compile-warning.patch
+ppc64-be-consistent-about-printing-which-idle-loop-were-using.patch
+ppc64-silence-perfmon-exception-warnings.patch

 ppc64 updates

+frv-add-defconfig.patch

 Give FRV a defconfig

+clean-up-numa-defines-in-mmzoneh.patch
+fix-up-non-numa-breakage-in-mmzoneh.patch

 Fix up some fallout from NUMA changes

+x86-64-ptrace-ia32-bp-fix.patch

 x86_64 ptrace fix

-suspend-fix-isa-dma-controller-hangs.patch
+isa-dma-suspend-for-i386.patch
+isa-dma-suspend-for-x86_64.patch

 New versions, but still not the right ones.

+pm-more-u32-vs-pm_message_t-fixes.patch
+pm-fix-u32-vs-pm_message_t-confusion-in-cpufreq.patch
+call-device_shutdown-with-interrupts-enabled.patch
+fix-resume-from-initrd.patch
+swsusp-fix-error-handling.patch
+clean-up-processc.patch

 power management/swsusp updates

+uml-skas0-separate-kernel-address-space-on-stock-hosts.patch
+uml-proper-clone-support-for-skas0.patch
+uml-restore-hppfs-support.patch

 UML updates

+yealink-updates-0701.patch

 More fixes for the yealink USB phone driver

-pselect-ppoll-system-calls-syscall-numbering-fix.patch

 More mangling of the pselect/poll driver

+xip-empty_zero_page-build-fix.patch

 Partially fix bogosity in the execute-in-place driver.  It needs work.

+autofs4-mistake-in-debug-print.patch

 autofs fix

+keys-base-keyring-size-on-key-pointer-not-key-struct.patch

 key management fix

+cond_resched-fix-bogus-might_sleep-warning.patch

 Kill a rare and bogus might_sleep() warning

+alpha-pgprot_noncached.patch

 null pgprot_nocached() so alpha can compile the infiniband stuff

+ib-uverbs-add-mthca-mmap-support-fix.patch
+ib-uverbs-add-mthca-mmap-support-fix-2.patch

 Fix ib-uverbs-add-mthca-mmap-support.patch

+connector-exit-notifier-remove-the-union-declaration.patch
+connector-add-a-fork-connector-remove-the-union-declaration-fork.patch

 connector client cleanups

+dvb-add-pluto2-driver-fix.patch

 Fix dvb-add-pluto2-driver.patch

+dvb-usb-a800-rc-and-timeout-fixes.patch
+dvb-usb-dont-use-hz-for-timeouts.patch
+dvb-ttpci-fix-timeout-handling-to-be-save-with-preempt.patch
+dvb-frontend-add-driver-for-lgdt3302.patch
+dvb-usb-pci-correct-syntax-of-driver-name-fields.patch
+dvb-dst-fix-tuning-problem.patch
+dvb-usb-add-supprt-for-wideview-wt-220u.patch
+dvb-usb-readme-update.patch
+fix-for-documentation-dvb-bt8xxtxt.patch

 DVB updates

+pcmcia-deprecate-ioctl.patch
+pcmcia-move-event-handler.patch
+pcmcia-remove-client_t-usage.patch
+pcmcia-reduce-client_handle_t-usage.patch
+pcmcia-remove-client-services-version.patch
+pcmcia-remove-client-services-version-fix.patch
+pcmcia-remove-references-to-pcmcia-versionh.patch
+pcmcia-update-maintainers-entry.patch
+yenta-no-cardbus-if-irq-fails.patch
+yenta-dont-depend-on-cardbus.patch

 PCMCIA/Cardbus updates and fixes

+nfsd4-reboot-recovery-fix.patch
+nfsd4-fix-syncing-of-recovery-directory.patch
+nfsd4-lookup_one_len-takes-i_sem.patch
+nfsd4-prevent-multiple-unlinks-of-recovery-directories.patch
+nfsd4-fix-release_lockowner.patch
+nfsd4-err_grace-should-bump-seqid-on-open.patch
+nfsd4-err_grace-should-bump-seqid-on-lock.patch
+nfsd4-stop-overusing-reclaim_bad.patch
+nfsd4-comment-indentation.patch
+nfsd4-fix-open_reclaim-seqid.patch
+nfsd4-seqid-comments.patch
+nfsd4-relax-new-lock-seqid-check.patch
+nfsd4-always-update-stateid-on-open.patch
+nfsd4-return-better-error-on-io-incompatible-with-open-mode.patch
+nfsd4-renew-lease-on-seqid-modifying-operations.patch
+nfsd4-clarify-close_lru-handling.patch
+nfsd4-clean-up-nfs4_preprocess_seqid_op.patch
+nfsd4-check-lock-type-against-openmode.patch
+nfsd4-fix-fh_expire_type.patch

 nfs4 server updates

+nfs-fix-client-hang-due-to-race-condition.patch

 Fix a race in the NFS client.

+revert-fix-broken-kmalloc_node-in-rc1-rc2.patch

 Revert temp fix from Linus's tree for numa-aware-slab-allocator-v5.patch

+iteraid-remove-ite_ioc_get_driver_version.patch

 Diddle with iteraid.patch

+sched-consider-migration-thread-with-smp-nice.patch

 CPU scheduler tweak

+v4l-add-dvb-support-for-dvico-fusionhdtv3-gold-q.patch
+v4l-add-terratec-cinergy-1400-dvb-t.patch
+v4l-add-dvb-support-for-dvico-fusionhdtv3-gold-t.patch
+v4l-lgdt3302-read-status-fix.patch

 v4l updates

+files-break-up-files-struct-warning-fix.patch
+files-sparc64-fix-2.patch

 Fix the files_lock RCUification patches

+video-documentation-update.patch

 fbdev documentation

+fuse-device-functions-document-mount-options.patch

 FUSE documentation

+fuse-direct-i-o-cleanup.patch

 fuse-direct-i-o.patch was dirty

+timer-initialization-cleanup-define_timer-pluto-fix.patch

 Fix braino in timer-initialization-cleanup-define_timer.patch



number of patches in -mm: 601
number of changesets in external trees: 9
number of patches in -mm only: 600
total patches: 609



All 601 patches:


linus.patch
  linus.patch

uml-kill-some-useless-vmalloc-tlb-flushing.patch
  uml: kill some useless vmalloc tlb flushing

iounmap-debugging.patch
  iounmap debugging

i2o-config-osm-build-fix.patch
  i2o: config-osm build fix

acpi-20050408-2.6.13-rc1.patch

acpi-ext-build-fix.patch
  acpi-ext build fix

no-acpi-build-fix.patch
  CONFIG_ACPI=n build fix

acpi-disable-c2-c3-for-_all_-ibm-r40e-laptops-bug-3549.patch
  ] acpi: Disable C2/C3 for _all_ IBM R40e Laptops (Bug #3549)

acpi-videoc-properly-remove-notify-handlers.patch
  acpi: video.c: properly remove notify handlers

acpi-re-enable-c2-c3-cpu-states-for-systems-without.patch
  ACPI: Re-enable C2/C3 CPU states for systems without CST

agp-AGP-01-printk-levels.patch

fix-warning-in-powernow-k8c.patch
  Fix warning in powernow-k8.c

gregkh-driver-securityfs.patch

gregkh-driver-speakup-docs.patch

gregkh-driver-speakup-core.patch

git-drm-initmap.patch
  git-drm-initmap.patch

git-drm-via.patch
  git-drm-via.patch

git-drm-via-fixup.patch
  git-drm-via-fixup

remove-register_ioctl32_conversion-and-unregister_ioctl32_conversion.patch
  remove register_ioctl32_conversion and unregister_ioctl32_conversion

gregkh-i2c-i2c-via686a-cleanups.patch

gregkh-i2c-i2c-tps6501x-cleanups.patch

gregkh-i2c-i2c-string-strip.patch

gregkh-i2c-i2c-max6875-may-do-bad-things.patch

gregkh-i2c-i2c-max6875-documentation.patch

gregkh-i2c-i2c-max6875-Kconfig.patch

gregkh-i2c-i2c-m41t00-kfree-fix.patch

gregkh-i2c-i2c-idr-core.patch

gregkh-i2c-i2c-drop-bogus-eeprom-comment.patch

gregkh-i2c-i2c-docs-01.patch

gregkh-i2c-i2c-docs-02.patch

gregkh-i2c-i2c-dev-doc-update.patch

gregkh-i2c-i2c-atxp1-build-fix.patch

gregkh-i2c-w1-bigendian-crc-fix.patch

git-audit.patch
  git-audit.patch

quiet-ide-cd-warning.patch
  quiet ide-cd warning

input-usb-ignore-logitech-vendor-usages.patch

input-usb-hid-simulation-usages.patch

input-i8042-no-cmd-negate.patch

input-synaptics-dynabook.patch

input-input-check-keycodesize.patch

input-joydev-msecs.patch

input-alps-suspend-typo.patch

input-alps-fix-tap-logic.patch

input-hid-badpad-trust-sight.patch

input-hid-more-consumer-usages.patch

input-hiddev-no-ctrl-in-read.patch

input-atkbd-allow-0x7f-scancode.patch

input-psmouse-wheel-mice-have-middle-button.patch

input-hid-variable-max-buffer-size.patch

input-hid-remove-mcc-blacklist.patch

git-input.patch
  git-input.patch

print-kbd-and-aux-irqs-correctly.patch
  Print KBD and AUX irqs correctly.

i8042-x86ia64-printk-fixes.patch
  i8042-x86ia64.h printk fixes

git-jfs.patch
  git-jfs.patch

git-libata-adma-mwi.patch
  git-libata-adma-mwi.patch

git-libata-chs-support.patch
  git-libata-chs-support.patch

git-libata-passthru.patch
  git-libata-passthru.patch

git-libata-promise-sata-pata.patch
  git-libata-promise-sata-pata.patch

git-mtd.patch
  git-mtd.patch

git-netdev-chelsio.patch
  git-netdev-chelsio.patch

git-netdev-janitor-fixup.patch
  git-netdev-janitor-fixup

git-netdev-smc91x-eeprom.patch
  git-netdev-smc91x-eeprom.patch

git-netdev-we18-ieee80211-wifi.patch
  git-netdev-we18-ieee80211-wifi.patch

fix-recursive-ipw2200-dependencies.patch
  fix recursive IPW2200 dependencies

drivers-net-wireless-ipw2100-use-the-dma_32bit_mask-constant.patch
  drivers/net/wireless/ipw2100: Use the DMA_32BIT_MASK constant

drivers-net-wireless-ipw2200-use-the-dma_32bit_mask-constant.patch
  drivers/net/wireless/ipw2200: Use the DMA_32BIT_MASK constant

ipw2100-assume-recent-kernel.patch
  ipw2100: assume recent kernel

ipw2100-kill-dead-macros.patch
  ipw2100: kill dead macros

ipw2100-small-cleanups.patch
  ipw2100: small cleanups

ipw2100-cleanup-debug-prints.patch
  ipw2100: cleanup debug prints

ipw2100-remove-by-hand-function-entry-exit-debugging.patch
  ipw2100: remove by-hand function entry/exit debugging

ipw2100-remove-commented-out-code.patch
  ipw2100: remove commented-out code

wireless-device-attr-fixes.patch
  wireless-device-attr-fixes

wireless-device-attr-fixes-2.patch
  wireless-device-attr-fixes-2

ipw2100-old-gcc-fix.patch
  ipw2100 old gcc fix

ieee80211_module-build-fixes.patch
  ieee80211_module-build-fixes

ieee80211_tx-build-fix.patch
  ieee80211_tx-build-fix

ieee80211_rx-build-fix.patch
  ieee80211_rx-build-fix

ieee80211_crypt-build-fix.patch
  ieee80211_crypt-build-fix

ieee80211_crypt_ccmp-build-fix.patch
  ieee80211_crypt_ccmp-build-fix

ieee80211_crypt_wep-build-fix.patch
  ieee80211_crypt_wep-build-fix

ieee80211_crypt_tkip-build-fix.patch
  ieee80211_crypt_tkip-build-fix

git-ntfs.patch
  git-ntfs.patch

git-ocfs2.patch
  git-ocfs2.patch

ocfs2-avoid-lookup_hash-usage-in-configfs.patch
  ocfs2: avoid lookup_hash usage in configfs

gregkh-pci-pci-acpi-mcfg-04.patch

pci-pci-transparent-bridge-handling-improvements-yenta_socket.patch
  PCI-PCI transparent bridge handling improvements (yenta_socket)

revert-gregkh-pci-pci-assign-unassigned-resources.patch
  revert-gregkh-pci-pci-assign-unassigned-resources

git-scsi-block.patch
  git-scsi-block.patch

git-scsi-misc.patch
  git-scsi-misc.patch

git-scsi-misc-drivers-scsi-chc-remove-devfs-stuff.patch
  git-scsi-misc: drivers/scsi/ch.c: remove devfs stuff

dpt_i2o-warning-fix.patch
  dpt_i2o warning fix

aic79xx-ahd_linux_dev_reset-cleanup.patch
  aic79xx: ahd_linux_dev_reset() cleanup

git-sparc64.patch
  git-sparc64.patch

gregkh-usb-usb-bMaxPacketSize0-sysfs.patch

gregkh-usb-usb-storage-unusual-ids-01.patch

gregkh-usb-usb-khubd-use-kthread.patch

gregkh-usb-usb-ftdi_sio-device_id-clutter-reduction.patch

gregkh-usb-usb-ftdi_sio-remove-TIOCMBIS.patch

gregkh-usb-usb-ftdi_sio-fix-compiler-warnings.patch

gregkh-usb-usb-atm-01.patch

gregkh-usb-usb-atm-02.patch

gregkh-usb-usb-atm-03.patch

gregkh-usb-usb-sis-makefile-fix.patch

gregkh-usb-usb-usbmon-print-control-packets.patch

gregkh-usb-usb-isp116x-hcd-cleanup.patch

gregkh-usb-usb-kmalloc-flag-cleanup.patch

gregkh-usb-usb-net2280-warning-fix.patch

gregkh-usb-usb-keyspan-remote.patch

gregkh-usb-usb-coverity-desc-bitmap-overrun-fix.patch

gregkh-usb-usb-ld-hid-blacklist.patch

gregkh-usb-usb-sn9c10x-update.patch

gregkh-usb-usb-gadget-ether-fix-01.patch

gregkh-usb-usb-gadget-ether-fix-02.patch

gregkh-usb-usb-ohci-udc-tweaks.patch

gregkh-usb-usb-ohci-omap-pm-updates.patch

gregkh-usb-usb-ohci-merge-fix.patch

gregkh-usb-usb-cdc-descriptor-add.patch

gregkh-usb-usb-export-getput_intf.patch

gregkh-usb-usb-cdc-acm-reference-count-fix.patch

gregkh-usb-usb-ldusb.patch

gregkh-usb-usb-gotemp.patch

bk-watchdog.patch

consolidate-config_watchdog_nowayout-handling.patch
  consolidate CONFIG_WATCHDOG_NOWAYOUT handling

mm.patch
  add -mmN to EXTRAVERSION

sparsemem-extreme.patch
  SPARSEMEM EXTREME

mm-consolidate-get_order.patch
  mm: consolidate get_order

add-sem_is_read-write_locked.patch
  add sem_is_read/write_locked()

swaptoken-tuning.patch
  swaptoken tuning

swaptoken-tuning-fix.patch
  swaptoken-tuning fix

print-order-information-when-oom-killing.patch
  print order information when OOM killing

print-order-information-when-oom-killing-fix.patch
  print-order-information-when-oom-killing-fix

remove-completly-bogus-comment-inside-__alloc_pages-try_to_free_pages-handling.patch
  remove completly bogus comment inside __alloc_pages() try_to_free_pages handling

madvise-does-not-always-return-ebadf-on-non-file.patch
  madvise() does not always return -EBADF on non-file mapped area

quieten-oom-killer-noise.patch
  mm: quieten OOM killer noise

proc-pid-smaps.patch
  add /proc/pid/smaps

ppp_mppe-add-ppp-mppe-encryption-module.patch
  ppp_mppe: add PPP MPPE encryption module

ppp-handle-misaligned-accesses.patch
  ppp: handle misaligned accesses

ipvs-add-and-reorder-bh-locks-after-moving-to-keventd.patch
  ipvs: add and reorder bh locks after moving to keventd

zatm-kfree-fix.patch
  zatm kfree fix

drivers-net-ne3210c-cleanups.patch
  drivers/net/ne3210.c: cleanups

tulip-fix-for-64-bit-mips.patch
  tulip: fix for 64-bit mips

tulip-natsemi-dp83840a-phy-fix.patch
  tulip: NatSemi DP83840A PHY fix

tulip-fixes-for-uli5261.patch
  tulip: fixes for ULi5261

silence-cs89x0.patch
  silence cs89x0

e1000-printk-warning-fix-2.patch
  e1000 printk warning fix 2

net-add-driver-for-the-nic-on-cell-blades.patch
  net: add driver for the NIC on Cell Blades

net-add-driver-for-the-nic-on-cell-blades-kconfig-fix.patch
  net-add-driver-for-the-nic-on-cell-blades-kconfig-fix

orinoco-sparse-fixes.patch
  orinoco: Sparse fixes

ipw2200-build-fix.patch
  ipw2200 build fix

build-tags-problem-with-o=.patch
  kbuild: build TAGS problem with O=

kbuild-build-a-single-module-using-make-dir-moduleko.patch
  kbuild: build a single module using 'make dir/module.ko'

ppc64-add-new-phy-to-sungem.patch
  ppc64: Add new PHY to sungem

ppc64-vdso32-fix-link-errors-after-recent-toolchain-changes.patch
  ppc64: vdso32: fix link errors after recent toolchain changes

ppc64-use-c99-initialisers-in-cputable-code.patch
  ppc64: use c99 initialisers in cputable code

ppc64-fix-runlatch-code-to-work-on-pseries-machines.patch
  ppc64: Fix runlatch code to work on pseries machines

ppc64-turn-runlatch-on-in-exception-entry.patch
  ppc64: Turn runlatch on in exception entry

move-ioprio-syscalls-into-syscallsh.patch
  move ioprio syscalls into syscalls.h

ppc64-sys_ppc32c-cleanups.patch
  ppc64: sys_ppc32.c cleanups

ppc64-add-ioprio-syscalls.patch
  ppc64: add ioprio syscalls

ppc64-remove-duplicate-syscall-reservation.patch
  ppc64: remove duplicate syscall reservation

hvc_console-rearrange-code.patch
  hvc_console: Rearrange code

hvc_console-match-vio-and-console-devices-using-vterm-numbers.patch
  hvc_console: Match vio and console devices using vterm numbers

hvc_console-dont-always-kick-the-poll-thread-in-interrupt.patch
  hvc_console: Dont always kick the poll thread in interrupt

hvc_console-magic_sysrq-should-only-be-on-console-channel.patch
  hvc_console: MAGIC_SYSRQ should only be on console channel

hvc_console-unregister-the-console-in-the-exit-routine.patch
  hvc_console: Unregister the console in the exit routine.

hvc_console-add-missing-include.patch
  hvc_console: Add missing include

hvc_console-remove-num_vterms-and-some-dead-code.patch
  hvc_console: remove num_vterms and some dead code

hvc_console-statically-initialize-the-vtermnos-array.patch
  hvc_console: Statically initialize the vtermnos array

hvc_console-add-some-sanity-checks.patch
  hvc_console: Add some sanity checks

hvc_console-separate-hvc_console-and-vio-code.patch
  hvc_console: Separate hvc_console and vio code

hvc_console-separate-hvc_console-and-vio-code-2.patch
  hvc_console: Separate hvc_console and vio code 2

hvc_console-register-ops-when-setting-up-hvc_console.patch
  hvc_console: Register ops when setting up hvc_console

hvc_console-separate-the-nul-character-filtering-from-get_hvc_chars.patch
  hvc_console: Separate the NUL character filtering from get_hvc_chars

hvc_console-use-hvc_get_chars-in-hvsi-code.patch
  hvc_console: Use hvc_get_chars in hvsi code

ppc64-make-idle_loop-a-ppc_md-function.patch
  ppc64: Make idle_loop a ppc_md function

ppc64-move-iseries_idle-into-iseries_setupc.patch
  ppc64: Move iSeries_idle() into iSeries_setup.c

ppc64-move-pseries-idle-functions-into-pseries_setupc.patch
  ppc64: Move pSeries idle functions into pSeries_setup.c

ppc64-fixup-platforms-for-new-ppc_mdidle.patch
  ppc64: Fixup platforms for new ppc_md.idle

ppc64-remove-obsolete-idle_setup.patch
  ppc64: Remove obsolete idle_setup()

ppc64-iseries-idle-fixups.patch
  ppc64: iSeries idle fixups

ppc64-pseries-idle-fixups.patch
  ppc64: pSeries idle fixups

ppc64-idle-fixups.patch
  ppc64: idle fixups

ppc64-fix-compile-warning.patch
  ppc64: fix compile warning

ppc64-be-consistent-about-printing-which-idle-loop-were-using.patch
  ppc64: Be consistent about printing which idle loop we're using

ppc64-silence-perfmon-exception-warnings.patch
  ppc64: silence perfmon exception warnings

frv-add-defconfig.patch
  FRV: Add defconfig

mtrr-suspend-resume-cleanup.patch
  MTRR suspend/resume cleanup

clean-up-numa-defines-in-mmzoneh.patch
  Clean up numa defines in mmzone.h

fix-up-non-numa-breakage-in-mmzoneh.patch
  Fix up non-NUMA breakage in mmzone.h

x86-x86_64-deferred-handling-of-writes-to-proc-irq-xx-smp_affinitypatch-added-to-mm-tree.patch
  x86/x86_64: deferred handling of writes to /proc/irqxx/smp_affinity

x86-64-ptrace-ia32-bp-fix.patch
  x86-64: ptrace ia32 BP fix

x86_64-div-by-zero-fix.patch
  x86_64-div-by-zero-fix

isa-dma-suspend-for-i386.patch
  ISA DMA suspend for i386

isa-dma-suspend-for-x86_64.patch
  ISA DMA suspend for x86_64

pm-more-u32-vs-pm_message_t-fixes.patch
  pm: more u32 vs. pm_message_t fixes

pm-fix-u32-vs-pm_message_t-confusion-in-cpufreq.patch
  pm: fix u32 vs. pm_message_t confusion in cpufreq

call-device_shutdown-with-interrupts-enabled.patch
  pm: call device_shutdown with interrupts enabled

fix-resume-from-initrd.patch
  pm: Fix resume from initrd

swsusp-fix-error-handling.patch
  swsusp: fix error handling

clean-up-processc.patch
  pm: clean up process.c

add-suspend-resume-for-timer.patch
  add suspend/resume for timer

cris-update-1-17-arch-split.patch
  CRIS update: arch split

cris-update-2-17-configuration-and-build.patch
  CRIS update: configuration and build

cris-update-3-17-console.patch
  CRIS update: console

cris-update-4-17-debug.patch
  CRIS update: debug

cris-update-5-17-drivers.patch
  CRIS update: drivers

cris-update-6-17-i-o-and-dma-allocator.patch
  CRIS update: I/O and DMA allocator

cris-update-7-17-irq.patch
  CRIS update: IRQ

cris-update-8-17-misc-patches.patch
  CRIS update: misc patches

cris-update-9-17-mm.patch
  CRIS update: mm

cris-update-10-17-pci.patch
  CRIS update: pci

cris-update-11-17-profiler.patch
  CRIS update: profiler

cris-update-12-17-serial-port-driver.patch
  CRIS update: serial port driver

cris-update-13-17-smp.patch
  CRIS update: SMP

cris-update-14-17-synchronous-serial-port-driver.patch
  CRIS update: synchronous serial port driver

cris-update-15-17-updates-for-2612.patch
  CRIS update: updates for 2.6.12

cris-update-17-17-new-subarchitecture-v32.patch
  CRIS update: new subarchitecture v32

cris-ide-driver.patch
  CRIS IDE driver

uml-skas0-separate-kernel-address-space-on-stock-hosts.patch
  uml: skas0 - separate kernel address space on stock hosts

uml-proper-clone-support-for-skas0.patch
  uml: Proper clone support for skas0

uml-restore-hppfs-support.patch
  uml: restore hppfs support

uml-remove-winch-sem.patch
  uml: remove winch sem

xtensa-remove-old-syscalls.patch
  xtensa: remove old syscalls

detect-soft-lockups.patch
  detect soft lockups

areca-raid-linux-scsi-driver.patch
  ARECA RAID Linux scsi driver

areca-raid-linux-scsi-driver-fix.patch
  drivers/scsi/arcmsr/arcmsr.c: remove unneeded #include <linux/devfs_fs_kernel.h>

tty-output-lossage-fix.patch
  tty output lossage fix

relayfs.patch
  relayfs

relayfs-cancel-work-on-close-reset.patch
  relayfs: cancel work on close/reset

relayfs-add-private-data-to-channel-struct.patch
  relayfs: add private data to channel struct

relayfs-function-docfix.patch
  relayfs: function docfix

relayfs-add-relayfs-website-to-documentation.patch
  relayfs: add relayfs website to documentation

avoid-lookup_hash-usage-in-relayfs.patch
  avoid lookup_hash usage in relayfs

binfmt_elf-bss-padding-fix.patch
  binfmt_elf bss padding fix

fortuna-random-driver-fix.patch
  statically link halfmd4

scan-all-enabled-ports-on-ata_piix.patch
  scan all enabled ports on ata_piix

page_uptodate-locking-scalability.patch
  page_uptodate locking scalability

page_uptodate-locking-scalability-fix.patch
  page_uptodate-locking-scalability fix

kbtab-tweaks-pen-tool-reporting.patch
  kbtab tweaks, pen tool reporting

add-skip_hangcheck_timer.patch
  Add skip_hangcheck_timer()

e1000-numa-aware-allocation-of-descriptors-v2.patch
  e1000: NUMA aware allocation of descriptors V2

new-driver-for-yealink-usb-p1k-phone.patch
  new driver for yealink usb-p1k phone

yealink-updates.patch
  yealink updates

yealink-updates-0701.patch
  yealink usb-p1k phone (updates 0701)

pselect-ppoll-system-calls.patch
  pselect, ppoll system calls.

pselect-ppoll-system-calls-tidy.patch
  pselect-ppoll-system-calls-tidy

pselect-ppoll-system-calls-fix.patch
  pselect-ppoll-system-calls-fix

pselect-ppoll-system-calls-sigset_t-fix-2.patch
  pselect-ppoll-system-calls-sigset_t-fix-e

pselect-ppoll-system-calls-sigset_t-fix-3.patch
  pselect-ppoll-system-calls-sigset_t-fix-3

pselect-ppoll-system-calls-compat-fix.patch
  pselect-ppoll-system-calls compat fix

yenta-make-topic95-bridges-work-with-16bit-cards.patch
  yenta: make ToPIC95 bridges work with 16bit cards

kallsyms-change-compression-algorithm.patch
  kallsyms: change compression algorithm

stale-posix-lock-handling.patch
  stale POSIX lock handling

acl-kconfig-cleanup.patch
  acl kconfig cleanup

propagate-__nocast-annotations.patch
  propagate __nocast annotations

mostly_read-data-section.patch
  mostly_read data section

dont-write-to-the-in-inode-xattr-space-of-reserved-inodes.patch
  ext4 xattr: Don't write to the in-inode xattr space of reserved inodes

cciss-per-disk-queue.patch
  cciss per disk queue

put_compat_shminfo-warning-fix.patch
  put_compat_shminfo() warning fix

xip-empty_zero_page-build-fix.patch
  xip: empty_zero_page build fix

autofs4-mistake-in-debug-print.patch
  autofs4 - mistake in debug print

keys-base-keyring-size-on-key-pointer-not-key-struct.patch
  Keys: Base keyring size on key pointer not key struct

cond_resched-fix-bogus-might_sleep-warning.patch
  cond_resched(): fix bogus might_sleep() warning

smsc-ircc2-whitespace-fixes.patch
  smsc-ircc2: whitespace fixes

smsc-ircc2-formatting-fixes.patch
  smsc-ircc2: formatting fixes

smsc-ircc2-drop-dim-macro-in-favor-of-array_size.patch
  smsc-ircc2: drop DIM macro in favor of ARRAY_SIZE

smsc-ircc2-remove-typedefs.patch
  smsc-ircc2: remove typedefs

smsc-ircc2-dont-pass-iobase-around.patch
  smsc-ircc2: dont pass iobase around

smsc-ircc2-add-to-sysfs-as-platform-device-new-pm.patch
  smsc-ircc2: add to sysfs as platform device, new PM

smsc-ircc2-pm-cleanup-do-not-close-device-when-suspending.patch
  smsc-ircc2: PM cleanup - do not close device when suspending

smsc-ircc2-pm-cleanup-do-not-close-device-when-suspending-fixes.patch
  smsc-ircc2-pm-cleanup-do-not-close-device-when-suspending-fixes

smsc-ircc2-use-netdev_priv.patch
  smsc-ircc2: use netdev_priv()

smsc-ircc2-dont-use-void-where-specific-type-will-do.patch
  smsc-ircc2: dont use void * where specific type will do

coverity-fbsysfs-fix-null-pointer-check.patch
  coverity: fix fbsysfs null pointer check

coverity-udf-balloc-null-deref-fix.patch
  coverity: udf/balloc.c null deref fix

coverity-usb-host-ehci-dbg-null-check.patch
  coverity: usb/host/ehci-dbg null check

coverity-fs-locks-flp-null-check.patch
  coverity: fs/locks.c flp null check

coverity-sunrpc-xprt-task-null-check.patch
  coverity: sunrpc/xprt task null check

alpha-pgprot_noncached.patch
  alpha(): pgprot_noncached

ib-uverbs-core-api-extensions.patch
  IB uverbs: core API extensions

ib-uverbs-update-kernel-midlayer-for-new-api.patch
  IB uverbs: update kernel midlayer for new API

ib-uverbs-update-mthca-for-new-api.patch
  IB uverbs: update mthca for new API

ib-uverbs-add-user-verbs-abi-header.patch
  IB uverbs: add user verbs ABI header

ib-uverbs-core-implementation.patch
  IB uverbs: core implementation

ib-uverbs-core-implementation-fix.patch
  IB uverbs: core implementation

ib-uverbs-memory-pinning-implementation.patch
  IB uverbs: memory pinning implementation

ib-uverbs-hook-up-kconfig-makefile.patch
  IB uverbs: hook up Kconfig/Makefile

ib-uverbs-add-mthca-abi-header.patch
  IB uverbs: add mthca ABI header

ib-uverbs-add-mthca-user-doorbell-record-support.patch
  IB uverbs: add mthca user doorbell record support

ib-uverbs-add-mthca-user-context-support.patch
  IB uverbs: add mthca user context support

ib-uverbs-add-mthca-mmap-support.patch
  IB uverbs: add mthca mmap support

ib-uverbs-add-mthca-mmap-support-fix.patch
  ib-uverbs-add-mthca-mmap-support fix

ib-uverbs-add-mthca-mmap-support-fix-2.patch
  IB uverbs: add mthca mmap support (fix #2)

ib-uverbs-add-mthca-user-pd-support.patch
  IB uverbs: add mthca user PD support

ib-uverbs-add-mthca-user-mr-support.patch
  IB uverbs: add mthca user MR support

ib-uverbs-add-mthca-user-cq-support.patch
  IB uverbs: add mthca user CQ support

ib-uverbs-add-mthca-user-qp-support.patch
  IB uverbs: add mthca user QP support

ib-uverbs-add-documentation-file.patch
  IB uverbs: add documentation file

rapidio-support-core-base.patch
  RapidIO support: core base

rapidio-support-core-includes.patch
  RapidIO support: core includes

rapidio-support-core-enum.patch
  RapidIO support: core enum

rapidio-support-core-enum-fix.patch
  rapidio: core updates

rapidio-support-ppc32.patch
  RapidIO support: ppc32

rapidio-support-net-driver.patch
  RapidIO support: net driver

fix-soft-lockup-due-to-ntfs-vfs-part-and-explanation.patch
  Fix soft lockup due to NTFS: VFS part and explanation

vfs-bugfix-two-read_inode-calles-without.patch
  bugfix: two read_inode() calles without clear_inode() call between

__wait_on_freeing_inode-fix.patch
  __wait_on_freeing_inode fix

fix-of-dcache-race-leading-to-busy-inodes-on-umount.patch
  Fix of dcache race leading to busy inodes on umount

namespacec-fix-bind-mount-from-foreign-namespace.patch
  namespace.c: fix bind mount from foreign namespace

namespacec-fix-mnt_namespace-clearing.patch
  namespace.c: fix mnt_namespace clearing

namespacec-fix-race-in-mark_mounts_for_expiry.patch
  namespace.c: fix race in mark_mounts_for_expiry()

namespacec-cleanup-in-mark_mounts_for_expiry.patch
  namespace.c: cleanup in mark_mounts_for_expiry()

namespacec-split-mark_mounts_for_expiry.patch
  namespace.c: split mark_mounts_for_expiry()

namespacec-fix-expiring-of-detached-mount.patch
  namespace.c: fix expiring of detached mount

namespacec-fix-mnt_namespace-zeroing-for-expired-mounts.patch
  namespace.c: fix mnt_namespace zeroing for expired mounts

set-mnt_namespace-in-the-correct-place.patch
  set mnt_namespace in the correct place

dcookiesc-use-proper-refcounting-functions.patch
  dcookies.c: use proper refcounting functions

namespace-rename-mnt_fslink-to-mnt_expire.patch
  namespace: rename mnt_fslink to mnt_expire

namespace-rename-_mntput-to-mntput_no_expire.patch
  namespace: rename _mntput to mntput_no_expire

dlm-core-locking.patch
  dlm: core locking

dlm-lockspaces-callbacks-directory.patch
  dlm: lockspaces, callbacks, directory

dlm-communication.patch
  dlm: communication

dlm-recovery.patch
  dlm: recovery

dlm-configuration.patch
  dlm: configuration

dlm-device-interface.patch
  dlm: device interface

dlm-debug-fs.patch
  dlm: debug fs

dlm-build.patch
  dlm: build

connector.patch
  connector

connector-exit-notifier.patch
  connector exit notifier

connector-exit-notifier-fix.patch
  connector-exit-notifier-fix

connector-exit-notifier-remove-the-union-declaration.patch
  connector: Remove the union declaration

connector-add-a-fork-connector.patch
  connector: add a fork connector

connector-add-a-fork-connector-use-after-free-fix.patch
  connector-add-a-fork-connector-use-after-free-fix

connector-add-a-fork-connector-remove-the-union-declaration-fork.patch
  fork connector: Remove the union declaration

inotify-45.patch
  updated inotify.

dvb-cinergyt2-endianness-fix-for-raw-remote-control-keys.patch
  dvb: cinergyT2: endianness fix for raw remote-control keys

dvb-remove-obsolete-skystar2-driver.patch
  dvb: remove obsolete skystar2 driver

dvb-core-fix-race-condition-in-fe_read_status-ioctl.patch
  dvb: core: fix race condition in FE_READ_STATUS ioctl

dvb-core-add-workaround-for-tuning-problem.patch
  dvb: core: add workaround for tuning problem

dvb-core-demux-error-handling-fix.patch
  dvb: core: demux error handling fix

dvb-core-dmxdev-cleanups.patch
  dvb: core: dmxdev cleanups

dvb-frontend-remove-unused-i2c-ids.patch
  dvb: frontend: remove unused I2C ids

dvb-frontend-tda1004x-update.patch
  dvb: frontend: tda1004x update

dvb-frontend-bcm3510-fix-firmware-version-check.patch
  dvb: frontend: bcm3510: fix firmware version check

dvb-add-missing-release_firmware-calls.patch
  dvb: add missing release_firmware() calls

dvb-frontend-tda1004x-support-tda827x-tuners.patch
  dvb: frontend: tda1004x: support tda827x tuners

dvb-frontend-cx22702-support-for-cxusb.patch
  dvb: frontend: cx22702: support for cxusb

dvb-frontend-l64781-improve-tuning.patch
  dvb: frontend: l64781: improve tuning

dvb-dvb-update.patch
  dvb: DVB update

dvb-add-pluto2-driver.patch
  dvb: add Pluto2 driver

dvb-add-pluto2-driver-fix.patch
  dvb-add-pluto2-driver-fix

dvb-saa7146-kj-pci_module_init-cleanup.patch
  dvb: saa7146: kj pci_module_init cleanup

dvb-flexcop-add-big-endian-register-definitions.patch
  dvb: flexcop: add big endian register definitions

dvb-flexcop-woraround-irq-stop-problem.patch
  dvb: flexcop: woraround irq stop problem

dvb-twinhan-dst-frontend-fixes.patch
  dvb: Twinhan DST: frontend fixes

dvb-twinhan-dst-frontend-polarization-fix.patch
  dvb: Twinhan DST: frontend polarization fix

dvb-ttusb-dec-kfree-cleanup.patch
  dvb: ttusb-dec: kfree cleanup

dvb-ttpci-add-support-for-technotrend-hauppauge-dvb-s-se.patch
  dvb: ttpci: add support for Technotrend/Hauppauge DVB-S SE

dvb-ttpci-support-for-new-tt-dvb-t-ci.patch
  dvb: ttpci: support for new TT DVB-T-CI

dvb-ttpci-fix-error-handling-for-firmware-communication.patch
  dvb: ttpci: fix error handling for firmware communication

dvb-ttpci-fix-bug-in-timeout-handling.patch
  dvb: ttpci: fix bug in timeout handling

dvb-ttpci-fix-auduio_continue-ioctl.patch
  dvb: ttpci: fix AUDUIO_CONTINUE ioctl

dvb-ttpci-budget-av--tu1216-fix-for-qam128.patch
  dvb: ttpci: budget-av / tu1216 fix for QAM128

dvb-ttpci-more-error-handling-for-firmware-communication.patch
  dvb: ttpci: more error handling for firmware communication

dvb-ttpci-error-handling-fix.patch
  dvb: ttpci: error handling fix

dvb-ttpci-cleanup-indentation-whitespace.patch
  dvb: ttpci: cleanup indentation + whitespace

dvb-ttpci-make-av7110_fe_lock_fix-retryable.patch
  dvb: ttpci: make av7110_fe_lock_fix() retryable

dvb-ttpci-kj-printk-fix.patch
  dvb: ttpci: kj printk fix

dvb-ttpci-add-support-for-hauppauge-tt-dvb-c-budget.patch
  dvb: ttpci: add support for Hauppauge/TT DVB-C budget

dvb-dvb-usb-support-artect-t1-with-broken-usb-ids.patch
  dvb: dvb-usb: support Artect T1 with broken USB ids

dvb-usb-fix-adstech-instant-tv-dvb-t-usb20-support.patch
  dvb: usb: fix ADSTech Instant TV DVB-T USB2.0 support

dvb-usb-add-isochronous-streaming-method.patch
  dvb: usb: add isochronous streaming method

dvb-frontend-add-fmd1216me-pll.patch
  dvb: frontend: add FMD1216ME PLL

dvb-usb-support-medion-hybrid-usb20-dvb-t-analogue-box.patch
  dvb: usb: support Medion hybrid USB2.0 DVB-T/analogue box

dvb-usb-add-module-parm-to-disable-remote-control-polling.patch
  dvb: usb: add module parm to disable remote control polling

dvb-frontend-add-alps-tded4-pll.patch
  dvb: frontend: add ALPS TDED4 PLL

dvb-usb-digitv-usb-fixes.patch
  dvb: usb: digitv-usb fixes

dvb-usb-dvb_usb_properties-init-fix.patch
  dvb: usb: dvb_usb_properties init fix

dvb-usb-cxusb-dvb-t-fixes.patch
  dvb: usb: cxusb DVB-T fixes

dvb-usb-add-videowalker-dvb-t-usb-ids.patch
  dvb: usb: add VideoWalker DVB-T USB ids

dvb-usb-digitv-memcpy-fix.patch
  dvb: usb: digitv memcpy fix

dvb-usb-doc-update.patch
  dvb: usb doc update

dvb-usb-kconfig-help-text-update.patch
  dvb: usb Kconfig help text update

dvb-usb-add-vp7045-ir-keymap.patch
  dvb: usb: add vp7045 IR keymap

dvb-usb-fix-wideview-usb-ids.patch
  dvb: usb: fix WideView USB ids

dvb-usb-vp7045-ir-map-fix.patch
  dvb: usb: vp7045 IR map fix

dvb-usb-ir-input-fixes.patch
  dvb: usb: IR input fixes

dvb-usb-a800-rc-and-timeout-fixes.patch
  dvb: usb: A800 rc and timeout fixes

dvb-usb-dont-use-hz-for-timeouts.patch
  dvb: usb: dont use HZ for timeouts

dvb-ttpci-fix-timeout-handling-to-be-save-with-preempt.patch
  dvb: ttpci: fix timeout handling to be save with PREEMPT

dvb-frontend-add-driver-for-lgdt3302.patch
  dvb: frontend: add driver for LGDT3302

dvb-usb-pci-correct-syntax-of-driver-name-fields.patch
  dvb: usb/pci: correct syntax of driver name fields

dvb-dst-fix-tuning-problem.patch
  dvb: dst: fix tuning problem

dvb-usb-add-supprt-for-wideview-wt-220u.patch
  dvb: usb: add supprt for WideView WT-220U

dvb-usb-readme-update.patch
  dvb: usb: README update

fix-for-documentation-dvb-bt8xxtxt.patch
  fix for Documentation/dvb/bt8xx.txt?=

jbd-split-checkpoint-lists.patch
  jbd: split checkpoint lists

jbd-split-checkpoint-lists-tweaks.patch
  jbd-split-checkpoint-lists-tweaks

pcmcia-fix-i82365-request_region-double-usage.patch
  pcmcia: fix i82365 request_region double usage

pcmcia-deprecate-ioctl.patch
  pcmcia: deprecate ioctl

pcmcia-move-event-handler.patch
  pcmcia: move event handler

pcmcia-remove-client_t-usage.patch
  pcmcia: remove client_t usage

pcmcia-reduce-client_handle_t-usage.patch
  pcmcia: reduce client_handle_t usage

pcmcia-remove-client-services-version.patch
  pcmcia: remove client services version

pcmcia-remove-client-services-version-fix.patch
  pcmcia: remove client services version (fix)

pcmcia-remove-references-to-pcmcia-versionh.patch
  pcmcia: remove references to pcmcia/version.h

pcmcia-update-maintainers-entry.patch
  pcmcia: update MAINTAINERS entry

yenta-no-cardbus-if-irq-fails.patch
  yenta: no CardBus if IRQ fails

yenta-dont-depend-on-cardbus.patch
  yenta: don't depend on CardBus

nfsd4-reboot-recovery-fix.patch
  nfsd4: reboot recovery fix

nfsd4-fix-syncing-of-recovery-directory.patch
  nfsd4: fix sync'ing of recovery directory

nfsd4-lookup_one_len-takes-i_sem.patch
  nfsd4: lookup_one_len takes i_sem

nfsd4-prevent-multiple-unlinks-of-recovery-directories.patch
  nfsd4: prevent multiple unlinks of recovery directories

nfsd4-fix-release_lockowner.patch
  nfsd4: fix release_lockowner

nfsd4-err_grace-should-bump-seqid-on-open.patch
  nfsd4: ERR_GRACE should bump seqid on open

nfsd4-err_grace-should-bump-seqid-on-lock.patch
  nfsd4: ERR_GRACE should bump seqid on lock

nfsd4-stop-overusing-reclaim_bad.patch
  nfsd4: stop overusing RECLAIM_BAD

nfsd4-comment-indentation.patch
  nfsd4: comment indentation

nfsd4-fix-open_reclaim-seqid.patch
  nfsd4: fix open_reclaim seqid

nfsd4-seqid-comments.patch
  nfsd4: seqid comments

nfsd4-relax-new-lock-seqid-check.patch
  nfsd4: relax new lock seqid check

nfsd4-always-update-stateid-on-open.patch
  nfsd4: always update stateid on open

nfsd4-return-better-error-on-io-incompatible-with-open-mode.patch
  nfsd4: return better error on io incompatible with open mode

nfsd4-renew-lease-on-seqid-modifying-operations.patch
  nfsd4: renew lease on seqid modifying operations

nfsd4-clarify-close_lru-handling.patch
  nfsd4: clarify close_lru handling

nfsd4-clean-up-nfs4_preprocess_seqid_op.patch
  nfsd4: clean up nfs4_preprocess_seqid_op

nfsd4-check-lock-type-against-openmode.patch
  nfsd4: check lock type against openmode.

nfsd4-fix-fh_expire_type.patch
  nfsd4: fix fh_expire_type

nfs-fix-client-oops-when-debugging-is-on.patch
  NFS: fix client oops when debugging is on

ingo-nfs-stuff.patch
  ingo nfs stucc

xdr-input-validation.patch
  xdr input validation

nfs-nfs3-page-null-fill-in-a-short-read-situation.patch
  NFS3: page null fill in a short read situation

nfs-fix-client-hang-due-to-race-condition.patch
  NFS: fix client hang due to race condition

spinlock-consolidation.patch
  spinlock consolidation

spinlock-consolidation-m32r-fix.patch
  spinlock consolidation m32r fix

spinlock-consolidation-up-spinlocks-gcc-29x-fix.patch
  UP spinlocks gcc-2.9x fix

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
  kgdb: move config option for BAD_SYSCALL_EXIT
  kgdb: fix BAD_SYSCALL_EXIT lockup
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
  kgdb-x86_64-support fix
  kgdb CONFIG_DEBUG_INFO fix

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

revert-fix-broken-kmalloc_node-in-rc1-rc2.patch
  revert-fix-broken-kmalloc_node-in-rc1-rc2

numa-aware-slab-allocator-v5.patch
  Numa-aware slab allocator V5

iteraid.patch
  ITE RAID driver

iteraid-remove-ite_ioc_get_driver_version.patch
  iteraid: remove ITE_IOC_GET_DRIVER_VERSION

list_del-debug.patch
  list_del debug check

page-owner-tracking-leak-detector.patch
  Page owner tracking leak detector

page-owner-tracking-leak-detector-tidy.patch
  page-owner-tracking-leak-detector tidy

unplug-can-sleep.patch
  unplug functions can sleep

firestream-warnings.patch
  firestream warnings

releasing-resources-with-children.patch
  Releasing resources with children

nr_blockdev_pages-in_interrupt-warning.patch
  a

nmi-lockup-and-altsysrq-p-dumping-calltraces-on-_all_-cpus.patch
  NMI lockup and AltSysRq-P dumping calltraces on _all_ cpus via NMI IPI

detect-atomic-counter-underflows.patch
  detect atomic counter underflows

perfctr.patch
  perfctr: core
  perfctr: remove bogus perfctr_sample_thread() calls
  perfctr: i386
  perfctr x86 core updates
  perfctr x86 driver updates
  perfctr: x86 driver cleanup
  Prescott fix for perfctr
  perfctr x86 update 2
  perfctr: x86_64
  perfctr x86_64 core updates
  perfctr: PowerPC
  perfctr: ppc32 driver update
  perfctr ppc32 MMCR0 handling fixes
  perfctr ppc32 update
  perfctr ppc32 update
  perfctr: virtualised counters
  virtual perfctr illegal sleep
  Make PERFCTR_VIRTUAL default in Kconfig match recommendation  in help text
  perfctr ifdef cleanup
  perfctr: Kconfig-related updates
  perfctr virtual updates
  perfctr: virtual cleanup
  perfctr ppc32 preliminary interrupt support
  perfctr: reduce stack usage
  perfctr interrupt_support Kconfig fix
  perfctr low-level documentation
  perfctr inheritance: driver updates
  perfctr inheritance: kernel updates
  perfctr inheritance: documentation updates
  perfctr inheritance locking fix
  perfctr API changes: first step
  perfctr virtual update
  perfctr x86-64 ia32 emulation fix
  perfctr sysfs update: core
  Perfctr sysfs update
  perfctr sysfs update: x86
  perfctr sysfs update: x86-64
  perfctr: syscall numbers in x86-64 ia32-emulation
  perfctr x86_64 native syscall numbers fix
  perfctr sysfs update: ppc32
  perfctr-2.7.10 API update 1/4: common
  perfctr-2.7.10 API update 2/4: i386
  perfctr-2.7.10 API update 3/4: x86_64
  perfctr-2.7.10 API update 4/4: ppc32
  perfctr API update 1/9: physical indexing, x86
  perfctr API update 2/9: physical indexing, ppc32
  perfctr API update 3/9: cpu_control_header, x86
  perfctr API update 4/9: cpu_control_header, ppc32
  perfctr API update 5/9: cpu_control_header, common
  perfctr API update 6/9: cpu_control access, common
  perfctr API update 7/9: cpu_control access, x86
  perfctr API update 8/9: cpu_control access, ppc32
  perfctr API update 9/9: domain-based read/write syscalls
  perfctr ia32 syscalls on x86-64 fix
  perfctr cleanups: common
  perfctr cleanups: ppc32
  perfctr cleanups: x86
  perfctr: x86 fix and cleanups
  perfctr: ppc32 fix and cleanups
  perfctr: 64-bit values in register descriptors
  perfctr-64-bit-values-in-register-descriptors fix
  perfctr: mapped state cleanup: x86
  perfctr: mapped state cleanup: ppc32
  perfctr: mapped state cleanup: common
  perfctr: ppc64 arch hooks
  perfctr: common updates for ppc64
  perfctr: ppc64 driver core
  perfctr: x86 ABI update
  perfctr: ppc32 ABI update
  perfctr: ppc64 ABI update
  perfctr: ppc64 wraparound fixes
  perfctr: x86 update with K8 multicore fixes, take 2
  perfctr: seqlocks for mmaped state: common
  perfctr: seqlocks for mmaped state: x86
  perfctr: seqlocks for mmaped state: ppc64
  perfctr: seqlocks for mmaped state: ppc32

perfctr-handle-non-of-ppc32-platforms.patch
  perfctr: handle non-OF ppc32 platforms

perfctr-syscall-numbering-fixups.patch
  perfctr: syscall numbering fixups

sched-run-sched_normal-tasks-with-real-time-tasks-on-smt-siblings.patch
  sched: run SCHED_NORMAL tasks with real time tasks on SMT siblings

max_user_rt_prio-and-max_rt_prio-are-wrong.patch
  MAX_USER_RT_PRIO and MAX_RT_PRIO are wrong

sched-idlest-cpus_allowed-aware.patch
  sched: make idlest_group/cpu cpus_allowed-aware

sched-cleanups.patch
  sched cleanups

sched-task_noninteractive.patch
  sched: TASK_NONINTERACTIVE

sched-add-cacheflush-asm.patch
  sched: add cacheflush() asm

scheduler-cache-hot-autodetect.patch
  scheduler cache-hot-autodetect

sched-implement-nice-support-across-physical-cpus-on-smp.patch
  sched: implement nice support across physical cpus on SMP

sched-change_prio_bias_only_if_queued.patch
  sched: change prio bias only if queued

sched-account_rt_tasks_in_prio_bias.patch
  sched: account rt tasks in prio_bias()

sched-smp-nice-bias-busy-queues-on-idle-rebalance.patch
  sched: smp nice bias busy queues on idle rebalance

sched-correct_smp_nice_bias.patch
  sched: correct smp_nice_bias

sched-fix-smt-scheduler-latency-bug.patch
  sched: fix SMT scheduler latency bug

sched-consider-migration-thread-with-smp-nice.patch
  sched: consider migration thread with smp nice

sched2-sched-domain-sysctl.patch
  sched: sched domain sysctl

add-do_proc_doulonglongvec_minmax-to-sysctl-functions.patch
  Add do_proc_doulonglongvec_minmax to sysctl functions
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions-fix
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions fix 2

v4l-cx88-update.patch
  v4l: cx88 update

v4l-cx88-hue-offset-fix.patch
  v4l: cx88 hue offset fix

v4l-add-dvb-support-for-dvico-fusionhdtv3-gold-q.patch
  v4l: add DVB support for DViCO FusionHDTV3 Gold-Q

v4l-add-terratec-cinergy-1400-dvb-t.patch
  v4l: add TerraTec Cinergy 1400 DVB-T

v4l-add-dvb-support-for-dvico-fusionhdtv3-gold-t.patch
  v4l: add DVB support for DViCO FusionHDTV3 Gold-T

v4l-lgdt3302-read-status-fix.patch
  v4l: LGDT3302 read status fix

disable-atykb-warning.patch
  disable atykb "too many keys pressed" warning

export-file_ra_state_init-again.patch
  Export file_ra_state_init() again

cachefs-filesystem.patch
  CacheFS filesystem

cachefs-documentation.patch
  CacheFS documentation

add-page-becoming-writable-notification.patch
  Add page becoming writable notification

provide-a-filesystem-specific-syncable-page-bit.patch
  Provide a filesystem-specific sync'able page bit

make-afs-use-cachefs.patch
  Make AFS use CacheFS

split-general-cache-manager-from-cachefs.patch
  Split general cache manager from CacheFS

turn-cachefs-into-a-cache-backend.patch
  Turn CacheFS into a cache backend

rework-the-cachefs-documentation-to-reflect-fs-cache-split.patch
  Rework the CacheFS documentation to reflect FS-Cache split

update-afs-client-to-reflect-cachefs-split.patch
  Update AFS client to reflect CacheFS split

make-page-becoming-writable-notification-a-vma-op-only-kafs-fix.patch
  Make page-becoming-writable notification a VMA-op only (kafs fix)

fscache-menuconfig-help-fix-documentation-path.patch
  fscache-menuconfig-help-fix-documentation-pathc

files-fix-rcu-initializers.patch
  files: fix rcu initializers

files-rcuref-apis.patch
  files: rcuref APIs

files-break-up-files-struct.patch
  files: break up files struct

files-break-up-files-struct-warning-fix.patch
  Make max_fds unsigned to avoid sign mismatch in comparison

files-sparc64-fix-2.patch
  files-sparc64-fix 2

files-files-struct-with-rcu.patch
  files: files struct with RCU

files-lock-free-fd-look-up.patch
  files: lock-free fd look-up

files-files-locking-doc.patch
  files: files locking doc

asfs-filesystem-driver.patch
  ASFS filesystem driver

asfs-filesystem-driver-fixes.patch
  asfs-filesystem-driver-fixes

reiser4-sb_sync_inodes.patch
  reiser4: vfs: add super_operations.sync_inodes()

reiser4-sb_sync_inodes-cleanup.patch
  reiser4: sync_sb_inodes cleanup

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

reiser4-export-pagevec-funcs.patch
  reiser4: export pagevec functions to modules

reiser4-export-radix_tree_preload.patch
  reiser4: export radix_tree_preload() to modules

reiser4-export-find_get_pages.patch

reiser4-radix_tree_lookup_slot.patch
  reiser4: add radix_tree_lookup_slot()

reiser4-include-reiser4.patch
  reiser4: add to build system

reiser4-doc.patch
  reiser4: documentation

reiser4-only.patch
  reiser4: main fs

reiser4-xattr-build-fix.patch
  reiser4 xattr build fix

reiser4-swsusp-build-fix.patch
  reiser4-swsusp-build-fix

reiser4-printk-warning-fix.patch
  resier4-printk-warning-fix

reiser4-mm-remove-pg_highmem-fix.patch
  reiser4-mm-remove-pg_highmem-fix

reiser4-kconfig-help-cleanup.patch
  reiser4 Kconfig help cleanup

reiser4-update.patch
  reiser4 update

reiser4-fix-dependencies.patch
  Reiser4: fix dependencies

v9fs-documentation-makefiles-configuration.patch
  v9fs: Documentation, Makefiles, Configuration

v9fs-vfs-file-dentry-and-directory-operations.patch
  v9fs: VFS file, dentry, and directory operations

v9fs-vfs-file-dentry-and-directory-operations-fix-fsf-postal-address-in-source-headers.patch
  v9fs: Fix FSF postal address in source headers

v9fs-vfs-inode-operations.patch
  v9fs: VFS inode operations

v9fs-vfs-inode-operations-fix-fsf-postal-address-in-source-headers.patch
  v9fs: Fix FSF postal address in source headers

v9fs-vfs-superblock-operations-and-glue.patch
  v9fs: VFS superblock operations and glue

v9fs-vfs-superblock-operations-and-glue-fix-fsf-postal-address-in-source-headers.patch
  v9fs: Fix FSF postal address in source headers

v9fs-9p-protocol-implementation.patch
  v9fs: 9P protocol implementation

v9fs-9p-protocol-implementation-fix-fsf-postal-address-in-source-headers.patch
  v9fs: Fix FSF postal address in source headers

v9fs-transport-modules.patch
  v9fs: transport modules

v9fs-transport-modules-fix-fsf-postal-address-in-source-headers.patch
  v9fs: Fix FSF postal address in source headers

v9fs-transport-modules-fix-timeout-segfault-corner-case.patch
  v9fs: fix timeout segfault corner case

v9fs-debug-and-support-routines.patch
  v9fs: debug and support routines

v9fs-debug-and-support-routines-fix.patch
  v9fs-debug-and-support-routines fix

v9fs-debug-and-support-routines-fix-fsf-postal-address-in-source-headers.patch
  v9fs: Fix FSF postal address in source headers

v9fs-change-error-magic-numbers-to-defined-constants.patch
  v9fs: Change error magic numbers to defined constants

v9fs-clean-up-vfs_inode-and-setattr-functions.patch
  v9fs: Clean-up vfs_inode and setattr functions

v9fs-fix-support-for-special-files-devices-named-pipes-etc.patch
  v9fs: Fix support for special files (devices, named pipes, etc.)

possible-dcache-bug-debugging-patch.patch
  Possible dcache BUG: debugging patch

serial-add-support-for-non-standard-xtals-to-16c950-driver.patch
  serial: add support for non-standard XTALs to 16c950 driver

add-support-for-possio-gcc-aka-pcmcia-siemens-mc45.patch
  Add support for Possio GCC AKA PCMCIA Siemens MC45

serial-mri-mri-pcids1-dual-port-serial-card.patch
  serial: MRi MRI-PCIDS1 dual port serial card

serial-add-siig-quartet-support.patch
  serial: add SIIG Quartet support

clean-up-the-old-digi-support-and-rescue-it.patch
  Clean up the old digi support and rescue it

remove-lock_section-from-x86_64-spin_lock-asm.patch
  remove LOCK_SECTION from x86_64 spin_lock asm

m32r-framebuffer-device-support.patch
  m32r: framebuffer device support

video-documentation-update.patch
  video doc: one more system where video works with S3

device-mapper-dm-raid1-limit-bios-to-size-of-mirror-region.patch
  device-mapper: dm-raid1: Limit bios to size of mirror region

device-mapper-dm-raid1-limit-bios-to-size-of-mirror-region-fix.patch
  device-mapper-dm-raid1-limit-bios-to-size-of-mirror-region-fix

md-__rh_alloc-rh_update_states-race-in-dm-raid1c.patch
  dm: fix __rh_alloc()/rh_update_states() race in dm-raid1.c

md-fix-rh_dec-rh_inc-race-in-dm-raid1c.patch
  dm: fix rh_dec()/rh_inc() race in dm-raid1.c

post-halloween-doc.patch
  post halloween doc

fuse-maintainers-kconfig-and-makefile-changes.patch
  FUSE - MAINTAINERS, Kconfig and Makefile changes

fuse-core.patch
  FUSE - core

fuse-device-functions.patch
  FUSE - device functions

fuse-device-functions-document-mount-options.patch
  FUSE: document mount options

fuse-read-only-operations.patch
  FUSE - read-only operations

fuse-read-write-operations.patch
  FUSE - read-write operations

fuse-file-operations.patch
  FUSE - file operations

fuse-mount-options.patch
  FUSE - mount options

fuse-extended-attribute-operations.patch
  FUSE - extended attribute operations

fuse-add-padding.patch
  FUSE: add padding

fuse-readpages-operation.patch
  FUSE - readpages operation

fuse-tighten-check-for-processes-allowed-access.patch
  FUSE: tighten check for processes allowed access

fuse-direct-i-o.patch
  FUSE - direct I/O

fuse-direct-i-o-cleanup.patch
  FUSE: direct I/O cleanup

fuse-transfer-readdir-data-through-device.patch
  fuse: transfer readdir data through device

fuse-add-fsync-operation-for-directories.patch
  FUSE: add fsync operation for directories

fuse-dont-allow-restarting-of-system-calls.patch
  FUSE: don't allow restarting of system calls

timer-initialization-cleanup-define_timer.patch
  timer initialization cleanup: DEFINE_TIMER

timer-initialization-cleanup-define_timer-pluto-fix.patch
  timer-initialization-cleanup-define_timer-pluto-fix

more-spin_lock_unlocked-define_spinlock-conversions.patch
  more SPIN_LOCK_UNLOCKED -> DEFINE_SPINLOCK conversions

clean-up-inline-static-vs-static-inline.patch
  clean up inline static vs static inline

update-credits-entry-and-listings-in-source-files-for-jesper.patch
  Update CREDITS entry and listings in source files for Jesper Juhl

applicom-fix-error-handling.patch
  applicom: fix error handling

drivers-char-lcdc-misc_register-can-fail.patch
  drivers/char/lcd.c: misc_register() can fail

hdpu_cpustate-misc_register-can-fail.patch
  hdpu_cpustate.c: misc_register() can fail

sb16_csp-remove-home-grown-le_to_cpu-macros.patch
  sb16_csp: remove home-grown le??_to_cpu macros

sb16_csp-untypedef.patch
  sb16_csp: untypedef

drivers-net-irda-irportc-cleanups.patch
  drivers/net/irda/irport.c: cleanups

drivers-net-sk98lin-possible-cleanups.patch
  drivers/net/sk98lin/: possible cleanups

drivers-net-arcnet-possible-cleanups.patch
  drivers/net/arcnet/: possible cleanups

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

mm-page_allocc-unexport-nr_swap_pages.patch
  unexport nr_swap_pages

unexport-console_unblank.patch
  unexport console_unblank

mm-swapc-unexport-vm_acct_memory.patch
  mm/swap.c: unexport vm_acct_memory

mm-swapfilec-unexport-total_swap_pages.patch
  mm/swapfile.c: unexport total_swap_pages

mm-swap_statec-unexport-swapper_space.patch
  mm/swap_state.c: unexport swapper_space

unexport-idle_cpu.patch
  unexport idle_cpu

unexport-uts_sem.patch
  unexport uts_sem

__deprecated_for_modules-insert_resource.patch
  From: Adrian Bunk <bunk@stusta.de>
  Subject: [2.6 patch] __deprecated_for_modules insert_resource

__deprecated_for_modules-panic_timeout.patch
  From: Adrian Bunk <bunk@stusta.de>
  Subject: [2.6 patch] __deprecated_for_modules panic_timeout

sound-oss-sequencer_syms-unexport-reprogram_timer.patch
  sound/oss/sequencer_syms: unexport reprogram_timer



