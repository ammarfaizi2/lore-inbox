Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751511AbWISI2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbWISI2y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 04:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWISI2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 04:28:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36227 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751487AbWISI2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 04:28:52 -0400
Date: Tue, 19 Sep 2006 01:28:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc7-mm1
Message-Id: <20060919012848.4482666d.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc7/2.6.18-rc7-mm1/


- git-input.patch has been dropped due to major mismatches between it
  and the driver tree.

- git-alsa.patch has been dropped due to similar mismatches.

- ia64 doesn't build due to bugs in the PCI tree.

- The kernel doesn't work properly on RH FC3 or pretty much anything
  which uses old udev, due to improvements in the driver tree.

- `make headers_check' is busted due to various bugs in various trees
  and due to collisions between git-magic.patch and git-gfs2.patch
  which I couldn't be bothered fixing.

- CONFIG_BLOCK=n is still busted due to mismatches between the NFS
  and block trees.  Will fix later.

- NFS automounts of subdirectories remain unfixed.

- The large-NR_IRQS-exhausts-per_cpu-memory problem remains unfixed. 
  I won't merge the genirq changes until it is.

- The i386 genirq MSI bugs have been "fixed" by disabling 4k stacks.

- It took maybe ten hours solid work to get this dogpile vaguely
  compiling and limping to a login prompt on x86, x86_64 and powerpc. 
  I guess it's worth briefly testing if you're keen.



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

- When reporting bugs in this kernel via email, please also rewrite the
  email Subject: in some manner to reflect the nature of the bug.  Some
  developers filter by Subject: when looking for messages to read.

- Semi-daily snapshots of the -mm lineup are uploaded to
  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/ and are announced on
  the mm-commits list.



Breakage since 2.6.18-rc6-mm2:


-libata-ignore-cfa-signature-while-sanity-checking-an-atapi-device.patch
-lockdep-double-the-number-of-stack-trace-entries.patch
-we-can-not-allow-anonymous-contributions-to-the-kernel.patch
-alim15x3c-m5229-rev-c8-support-for-dma-cd-writer.patch
-scsi-lockdep-annotation-in-scsi_send_eh_cmnd.patch
-rcu_do_batch-make-qlen-decrement-irq-safe.patch
-x86-reserve-a-boot-loader-id-number-for-xen.patch
-headers_check-improve-include-regexp.patch
-headers_check-clarify-error-message.patch
-headers_check-reduce-user-visible-noise-in-linux-nfs_fsh.patch
-headers_check-remove-asm-timexh-from-user-export.patch
-headers_check-move-inclusion-of-linux-linkageh-in.patch
-headers_check-move-kernel-only-includes-within-asm-i386-elfh.patch
-headers_check-dont-expose-pfn-stuff-to-userspace-in.patch
-headers_check-fix-userspace-build-of-asm-mips-pageh.patch
-cciss-version-update-new-hw.patch
-usbserial-reference-leak.patch
-drivers-base-check-errors.patch
-fix-device_attribute-memory-leak-in-device_del.patch
-git-ieee1394-fixup.patch
-ieee1394-fix-kerneldoc-of-hpsb_alloc_host.patch
-ieee1394-shrink-tlabel-pools-remove-tpool-semaphores.patch
-ieee1394-remove-include-asm-semaphoreh.patch
-ieee1394-sbp2-safer-last_orb-and.patch
-ieee1394-sbp2-discard-return-value-of.patch
-ieee1394-sbp2-optimize-dma-direction-of.patch
-ieee1394-sbp2-safer-initialization-of.patch
-ieee1394-sbp2-more-checks-of-status.patch
-ieee1394-sbp2-convert.patch
-video1394-add-poll-file-operation-support.patch
-ieee1394-safer-definition-of-empty-macros.patch
-ieee1394-sbp2-enable-auto-spin-up-for-all-sbp-2-devices.patch
-config_pm=n-slim-drivers-ieee1394-ohci1394c.patch
-the-scheduled-removal-of-drivers-ieee1394-sbp2cforce_inquiry_hack.patch
-ieee1394-sbp2-handle-sbp2util_node_write_no_wait-failed.patch
-ieee1394-sbp2-safer-agent-reset-in-error-handlers.patch
-ieee1394-sbp2-recheck-node-generation-in-sbp2_update.patch
-ieee1394-sbp2-better-handling-of-transport-errors.patch
-ieee1394-sbp2-update-includes.patch
-ieee1394-sbp2-prevent-rare-deadlock-in-shutdown.patch
-initialize-ieee1394-early-when-built-in.patch
-ieee1394-sbp2-more-help-in-kconfig.patch
-ieee1394-nodemgr-fix-rwsem-recursion.patch
-ieee1394-nodemgr-grab-classsubsysrwsem-in.patch
-ieee1394-sbp2-dont-prefer-mode-sense-10.patch
-ieee1394-ohci1394-fix-endianess-bug-in-debug-message.patch
-ieee1394-ohci1394-more-obvious-endianess-handling.patch
-maintainers-updates-to-ieee-1394-subsystem.patch
-git-libata-all-ata_piix-build-fix.patch
-8139cp-trim-ring_info.patch
-8139cp-remove-gratuitous-indirection.patch
-8139cp-ring_info-removal-for-the-receive-path.patch
-8139cp-sync-the-device-private-data-with-its-r8169-counterpart.patch
-8139cp-removal-of-useless-bug_on-check.patch
-8139cp-pci_get_drvdatapdev-can-not-be-null-in-suspend-handler.patch
-8139cp-use-pci_device-to-shorten-the-pci-device-table.patch
-rtnetlink-fix-netdevice-name-corruption.patch
-fix-gregkh-pci-msi-blacklist-pci-e-chipsets-depending-on-hypertransport-msi-capability.patch
-watchdog-use-enotty-instead-of-enoioctlcmd-in-ioctl.patch
-hostap_cs-added-support-for-proxim-harmony-pci-w-lan.patch
-x86_64-mm-core-2-oprofile-identification.patch
-kernel-bug-fixing-for-kernel-kmodc.patch
-linux-magich-for-magic-numbers.patch
-linux-magich-for-magic-numbers-sparc-fix.patch
-knfsd-have-ext2-reject-file-handles-with-bad-inode-numbers-early.patch
-knfsd-have-ext2-reject-file-handles-with-bad-inode-numbers-early-tidy.patch
-knfsd-make-ext3-reject-filehandles-referring-to-invalid-inode-numbers.patch
-knfsd-make-ext3-reject-filehandles-referring-to-invalid-inode-numbers-tidy.patch
-pr_debug-check-pr_debug-arguments.patch

 Merged into mainline or a subsystem tree.

+add-headers_check-target-to-output-of-make-help.patch
+fix-make-headers_check-on-m68k.patch
+headers_check-clean-up-asm-parisc-pageh-for-user-headers.patch
+ext2-remove-superblock-lock-contention-in-ext2_statfs-2.patch

 Sent to Linus for 2.6.18.

+autofs4-zero-timeout-prevents-shutdown.patch

 Probably for 2.6.18.
 
+fix-longstanding-load-balancing-bug-in-the-scheduler.patch

 sched fix

+update-to-the-kernel-kmap-kunmap-api.patch

 Prepare to overload the kmap() API in probably-wrong ways.

+sound-core-use-seek_set-cur.patch
+opl4-use-seek_set-cur.patch
+gus-use-seek_set-cur.patch
+mixart-use-seek_set-cur.patch

 Sound stuff.

+cifs-use-seek_end-instead-of-hardcoded-value.patch

 CIFS cleanup

+git-cpufreq-sw_any_bug_dmi_table-can-be-used-on-resume.patch

 cpufreq fix

+gregkh-driver-driver-core-add-const-to-class_create.patch
+gregkh-driver-sysfs_symlink_in_root.patch
+gregkh-driver-class_device_interface.patch
+gregkh-driver-config_sysfs_deprecated.patch
+gregkh-driver-sound-device.patch
+gregkh-driver-ppp-device.patch
+gregkh-driver-ppdev-device.patch
+gregkh-driver-mmc-device.patch
+gregkh-driver-pcmcia-device.patch
+gregkh-driver-input-device.patch
+gregkh-driver-firmware-device.patch
+gregkh-driver-fb-device.patch

 Driver tree updates.

-revert-gregkh-driver-class_device_rename-remove.patch
-revert-gregkh-driver-network-class_device-to-device.patch
-revert-gregkh-driver-tty-device.patch
-revert-gregkh-driver-mem-devices.patch

 It became untenable to revert so many things.

-more-driver-core-fixes-for-mm.patch
-yet-further-driver-core-fixes-for-mm.patch
-return-code-checking-for-make_class_name.patch

 Some of these were broken by driver-tree changes.

+gregkh-driver-input-device-a3d-fix.patch
+gregkh-driver-input-device-more-fixes.patch
+gregkh-driver-input-device-even-more-fixes.patch
+gregkh-driver-input-device-even-more-fixes-2.patch
+gregkh-driver-fb-device-fixes.patch
+more-driver-tree-fixes.patch

 Fix driver-tree mess.

+dvb-usb-vs-driver-tree.patch

 More.

-gregkh-i2c-i2c-isa-plan-for-removal.patch

 Dropped due to rejects.

+hdapsc-inversion-of-each-axis.patch

 hdaps fix

+stowaway-keyboard-support-update.patch
+stowaway-vs-driver-tree.patch

 Fix stowaway-keyboard-support.patch

+hdrcheck-permission-fix.patch

 Fix `make headercheck'

-revert-libata-ignore-cfa-signature-while-sanity-checking-an-atapi-device.patch
-redo-libata-ignore-cfa-signature-while-sanity-checking-an-atapi-device.patch

 Unneeded.

+git-magic.patch
+git-magic-fixup.patch
+git-magic-fixup-2.patch

 Consolidate magic numbers.

-tulip-update-tulip-version.patch

 Unneeded

-tulip-update-winbond840c-version.patch

 Merged, I think.

+ip100a-fix-tx-pause-bug-reset_tx-intr_handler.patch
+ip100a-change-phy-address-search-from-phy=1-to-phy=0.patch
+ip100a-correct-initial-and-close-hardware-step.patch
+ip100a-solve-host-error-problem-in-low-performance.patch

 Net driver updates

+net-ipv6-bh_lock_sock_nested-on-tcp_v6_rcv.patch

 lockdep fix

+revert-allow-file-systems-to-manually-d_move-inside-of-rename.patch

 Revert a patch which is also in the OCFS2 tree.

+git-parisc-powerpc-fix.patch

 Fix broken changes to core IRQ code which are (logically) in the parisc tree.

+8250-uart-backup-timer.patch

 Serial fix.

+gregkh-pci-msi-rename-pci_cap_id_ht_irqconf-into-pci_cap_id_ht.patch
+gregkh-pci-pci_bridge-device.patch

 PCI tree updates

+pci-quirks-update.patch

 PCI fixes

-fix-panic-when-reinserting-adaptec-pcmcia-scsi-card.patch

 Dropped

+bodge-scsi-misc-module-reference-count-checks-with-no-module_unload.patch
+scsi-remove-seagateh.patch
+scsi-seagate-scsi_cmnd-conversion.patch
+aha152x-fix.patch

 SCSI stuff.

+revert-gregkh-usb-usbcore-remove-usb_suspend_root_hub.patch

 Revert broken USB patch

+gregkh-usb-usbcore-add-autosuspend-autoresume-infrastructure-2.patch
+microtek-usb-scanner-scsi_cmnd-conversion.patch

 USB stuff

+x86-remaining-pda-patches.patch

 Fix PDA patches in x86_64 tree.

+cleanup-radix_tree_derefreplace_slot-calling-conventions-warning-fixes.patch

 Fix cleanup-radix_tree_derefreplace_slot-calling-conventions.patch

-page-migration-replace-radix_tree_lookup_slot-with-radix_tree_lockup.patch

 Dropped.

+have-power-use-add_active_range-and-free_area_init_nodes-ppc-fix.patch

 Fix have-power-use-add_active_range-and-free_area_init_nodes.patch

+page-invalidation-cleanup.patch
+slab-fix-kmalloc_node-applying-memory-policies-if-nodeid-==-numa_node_id.patch
+slab-fix-kmalloc_node-applying-memory-policies-if-nodeid-==-numa_node_id-fix.patch
+condense-output-of-show_free_areas.patch
+add-numa_build-definition-in-kernelh-to-avoid-ifdef.patch
+disable-gfp_thisnode-in-the-non-numa-case.patch
+gfp_thisnode-for-the-slab-allocator-v2.patch
+gfp_thisnode-for-the-slab-allocator-v2-fix.patch
+add-node-to-zone-for-the-numa-case.patch
+add-node-to-zone-for-the-numa-case-fix.patch
+get-rid-of-zone_table.patch
+get-rid-of-zone_table-fix.patch
+do-not-allocate-pagesets-for-unpopulated-zones.patch
+zone_statistics-use-hot-node-instead-of-cold-zone_pgdat.patch
+deal-with-cases-of-zone_dma-meaning-the-first-zone.patch
+introduce-config_zone_dma.patch
+optional-zone_dma-in-the-vm.patch
+optional-zone_dma-for-i386.patch
+optional-zone_dma-for-x86_64.patch
+optional-zone_dma-for-ia64.patch
+remove-zone_dma-remains-from-parisc.patch
+remove-zone_dma-remains-from-sh-sh64.patch

 MM updates

+frv-fix-fls-to-handle-bit-31-being-set-correctly.patch
+frv-implement-fls64.patch
+frv-optimise-ffs.patch

 FRV updates

+alchemy-delete-unused-pt_regs-argument-from-au1xxx_dbdma_chan_alloc.patch

 MIPS fix

+avr32-dont-leave-dbe-set-when-resetting-cpu.patch
+avr32-make-prot_write-prot_exec-imply-prot_read.patch
+avr32-remove-set_wmb.patch
+avr32-use-parse_early_param.patch
+avr32-fix-exported-headers.patch
+avr32-fix-__const_udelay-overflow-bug.patch
+avr32-mtd-static-memory-controller-driver-try-2.patch
+avr32-mtd-at49bv6416-platform-device-for-atstk1000.patch
+avr32-mtd-unlock-flash-if-necessary.patch

 AVR32 udpates

-i386-print-stack-size-in-oops-messages.patch

 Dropped due to rejects against x86_64 tree

+x86-restore-i8259a-eoi-status-on-resume.patch

 x86 fix

+split-i386-and-x86_64-ptraceh.patch
+split-i386-and-x86_64-ptraceh-fix.patch
+make-uml-use-ptrace-abih.patch

 UML work

+inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default-vs-gfs2.patch

 Fix gfs2 for inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default.patch

-sanitize-3c589_cs.patch

 Dropped.

+blockdevc-check-errors-fix.patch

 Fix blockdevc-check-errors.patch

+serial-fix-up-offenders-peering-at-baud-bits-directly.patch
+remove-the-old-bd_mutex-lockdep-annotation.patch
+new-bd_mutex-lockdep-annotation.patch
+codingstyle-cleanup-for-kernel-sysc.patch
+allow-proc-configgz-to-be-built-as-a-module.patch
+add-config_headers_check-option-to-automatically-run-make-headers_check.patch
+add-config_headers_check-option-to-automatically-run-make-headers_check-nobble.patch
+pci-via82cxxx_audio-use-pci_get_device.patch
+pci-cs46xx-oss-switch-to-pci_get_device.patch
+#pci-mxser-pci-refcounts.patch
+pci-piix-use-refcounted-interface-when-searching-for-a-450nx.patch
+pci-serverworks-switch-to-pci-refcounted-interfaces.patch
+pci-sis5513-switch-to-pci-refcounting.patch
+pci-mtd-switch-to-pci_get_device-and-do-ref-counting.patch
+pci-via-switch-to-pci_get_device-refcounted-pci-api.patch
+mbcs-use-seek_set-cur.patch
+eicon-isdn-removed-unused-definitions-for-os_seek_.patch
+vfs-use-seek_set-cur.patch
+proper-flags-type-of-spin_lock_irqsave.patch

 Misc

+add-missing-page_copy-export-for-ppc-and-powerpc.patch

 Fix nfs-use-local-caching-12.patch

-r-o-bind-mount-clean-up-ocfs2-nlink-handling.patch
+r-o-bind-mount-clean-up-ocfs2-nlink-handling-2.patch

 Updated due to changes in git-ocfs2.patch

-thinkpad_ec-new-driver-for-thinkpad-embedded-controller-access.patch
-hdaps-use-thinkpad_ec-instead-of-direct-port-access.patch
-hdaps-unify-and-cache-hdaps-readouts.patch
-hdaps-unify-and-cache-hdaps-readouts-fix.patch
-hdaps-correct-readout-and-remove-nonsensical-attributes.patch
-hdaps-remember-keyboard-and-mouse-activity.patch
-hdaps-limit-hardware-query-rate.patch
-hdaps-delay-calibration-to-first-hardware-query.patch
-hdaps-add-explicit-hardware-configuration-functions.patch
-hdaps-add-explicit-hardware-configuration-functions-fix.patch
-hdaps-add-explicit-hardware-configuration-functions-fix-fix.patch
-hdaps-add-new-sysfs-attributes.patch
-hdaps-power-off-accelerometer-on-suspend-and-unload.patch
-hdaps-stop-polling-timer-when-suspended.patch
-hdaps-simplify-whitelist.patch

 Dropped.

+s390-update-fs3270-to-use-a-struct-pid.patch

 Fix s390 for pid patches in -mm.

+knfsd-replace-two-page-lists-in-struct-svc_rqst-with-one-fix.patch

 Fix knfsd-replace-two-page-lists-in-struct-svc_rqst-with-one.patch

+scheduler-numa-aware-placement-of-sched_group_allnodes.patch

 sched tweak.

+ecryptfs-versioning-fixes.patch
+ecryptfs-versioning-fixes-tidy.patch

 ecryptfs fixes

+namespaces-utsname-implement-clone_newuts-flag-fix.patch

 Fix namespaces-utsname-implement-clone_newuts-flag.patch

+rename-the-provided-execve-functions-to-kernel_execve-headers-fix.patch

 Fix rename-the-provided-execve-functions-to-kernel_execve.patch some more

+ide-fix-crash-on-repeated-reset-tidy.patch

 Clean up ide-fix-crash-on-repeated-reset.patch

+dm-support-ioctls-on-mapped-devices-fix-with-fake-file.patch
+dm-fix-alloc_dev-error-path.patch
+dm-snapshot-fix-invalidation-enomem.patch
+dm-snapshot-allow-zero-chunk_size.patch
+dm-snapshot-fix-metadata-error-handling.patch
+dm-snapshot-make-read-and-write-exception-functions-void.patch
+dm-snapshot-fix-metadata-writing-when-suspending.patch
+dm-snapshot-tidy-snapshot_map.patch
+dm-snapshot-tidy-pending_complete.patch
+dm-snapshot-add-workqueue.patch
+dm-snapshot-tidy-pe-ref-counting.patch
+dm-snapshot-fix-freeing-pending-exception.patch
+dm-mirror-remove-trailing-space-from-table.patch
+dm-mpath-tidy-ctr.patch
+dm-mpath-use-kzalloc.patch
+dm-add-uevent-change-event-on-resume.patch
+dm-add-debug-macro.patch
+dm-table-add-target-preresume.patch
+dm-crypt-add-key-msg.patch
+dm-crypt-restructure-for-workqueue-change.patch
+dm-crypt-restructure-write-processing.patch
+dm-crypt-move-io-to-workqueue.patch
+dm-crypt-use-private-biosets.patch
+dm-use-private-biosets.patch
+dm-extract-device-limit-setting.patch
+dm-table-add-target-flush.patch

 Device mapper updates

+statistics-infrastructure-exploitation-zfcp-sched_clock-fix.patch

 Fix statistics-infrastructure-exploitation-zfcp.patch

+genirq-msi-restore-__do_irq-compat-logic-temporarily.patch

 Kludge around genirq MSI bugs.

+rcu-credits-and-maintainers.patch

 RCU update

-nozomi-pci_module_init-conversion.patch

 Collaterally damaged by driver tree fun.

+pr_debug-check-pr_debug-arguments-arm-fix.patch
+pr_debug-check-pr_debug-arguments.patch

 Fix pr_debug patches in -mm.

+mprotect-patch-for-use-by-slim.patch
+integrity-service-api-and-dummy-provider.patch
+integrity-service-api-and-dummy-provider-compilation-warning-fix.patch
+slim-main-patch.patch
+slim-main-patch-socket_post_create-hook-return-code.patch
+slim-secfs-patch.patch
+slim-make-and-config-stuff.patch
+slim-debug-output.patch
+slim-fix-security-issue-with-the-task_post_setuid-hook.patch
+slim-secfs-inode-i_private-build-fix.patch
+slim-documentation.patch

 New security feature.

-input_register_device-debug.patch

 Dropped due to rejects.



All 1979 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc7/2.6.18-rc7-mm1/patch-list


