Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965059AbWJJHJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbWJJHJs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 03:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbWJJHJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 03:09:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46808 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752000AbWJJHJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 03:09:37 -0400
Date: Tue, 10 Oct 2006 00:09:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc1-mm1
Message-Id: <20061010000928.9d2d519a.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/


- Added the ext4 filesystem.  Quick usage instructions:

  - Grab updated e2fsprogs from
    ftp://ftp.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs-interim/

  - It's still mke2fs -j /dev/hda1

  - mount /dev/hda1 /wherever -t ext4dev

  - To enable extents,

	mount /dev/hda1 /wherever -t ext4dev -o extents

  - The filesystem is compatible with the ext3 driver until you add a file
    which has extents (ie: `mount -o extents', then create a file).

  - When comparing performance with other filesystems, remember that
    ext3/4 by default offers higher data integrity guarantees than most.  So
    when comparing with a metadata-only journalling filesystem, use `mount -o
    data=writeback'.  (Although this doesn't seem to make much difference with
    ext3).

    And you might as well use `mount -o nobh' too.

    Making the journal larger than the mke2fs default often helps
    performance with metadata-intensive workloads.

- Added the high-resolution timers and dynamic-ticks code.  Please be sure
  to cc tglx@linutronix.de>, mingo@elte.hu and johnstul@us.ibm.com if it blows
  up.



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


Changes since 2.6.18-mm3:


 origin.patch
 git-acpi.patch
 git-cifs.patch
 git-dvb.patch
 git-geode.patch
 git-ia64.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-libata-all.patch
 git-mtd.patch
 git-netdev-all.patch
 git-ocfs2.patch
 git-pcmcia.patch
 git-selinux.patch
 git-pciseg.patch
 git-s390.patch
 git-sh.patch
 git-scsi-target.patch
 git-qla3xxx.patch
 git-watchdog.patch
 git-gccbug.patch

 git trees.

-pidh-cleanup.patch
-vfs-make-filldir_t-and-struct-kstat-deal-in-64-bit-inode-numbers.patch
-revert-insert-ioapics-and-local-apic-into-resource-map.patch
-acpi-cast-removal.patch
-dereference-after-free-in-snd_hwdep_release.patch
-kauditd_thread-warning-fix.patch
-hdrcheck-permission-fix.patch
-docs-small-kbuild-cleanup.patch
-kthread-update-arch-mips-kernel-apmc.patch
-mmc-driver-for-ti-flashmedia-card-reader-source.patch
-mmc-driver-for-ti-flashmedia-card-reader-kconfig-makefile.patch
-forcedeth-hardirq-lockdep-warning.patch
-hp100-fix-conditional-compilation-mess.patch
-zatm-always-clear-pcr-in-alloc_shaper.patch
-atm-ambassador-fix-return-code-bug.patch
-tipc-fix-printk-warning.patch
-git-powerpc-wrapper-dont-require-execute-permissions.patch
-powerpc-xmon-fix.patch
-pcie_portdrv_restore_config-undefined-without-config_pm.patch
-pci-optionally-sort-device-lists-breadth-first.patch
-scsi-convertion-to-struct-scsi_cmnd-in-ips-driver.patch
-scsi-scsi_cmnd-convertion-in-arm-subtree.patch
-gregkh-usb-usb-storage-unusual_devs.h-entry-for-sony-ericsson-p990i.patch
-usb-serial-mos7840-fix-cast.patch
-x86_64-mm-defconfig-update.patch
-x86_64-mm-i386-defconfig-update.patch
-x86_64-mm-calgary-init.patch
-x86_64-mm-calgary-off-by-one.patch
-x86_64-mm-calgary-jon-contact.patch
-x86_64-mm-calgary-hex-bus.patch
-x86_64-mm-pci-bios-fix.patch
-x86_64-mm-kernel-stack-termination.patch
-fix-x86_64-mm-kernel-stack-termination.patch
-mm-micro-optimise-zone_watermark_ok.patch
-slab-clean-up-leak-tracking-ifdefs-a-little-bit.patch
-kmemdup-introduce-vs-slab-clean-up-leak-tracking-ifdefs-a-little-bit.patch
-slab-reduce-numa-text-size.patch
-slab-reduce-numa-text-size-tidy.patch
-create-kallsyms_lookup_size_offset.patch
-low-performance-of-lib-sortc.patch
-char-kill-unneeded-memsets.patch
-char-serial167-remove-useless-tty-check.patch
-kernel-doc-for-kernel-dmac.patch
-kernel-doc-for-kernel-resourcec.patch
-fs-eventpoll-error-handling-micro-cleanup.patch
-ipmi-fix-uninitd-data-bug.patch
-drivers-char-ip2-kill-unused-code-label.patch
-schedule-ftape-removal.patch
-isdn-warning-fixes.patch
-restore-parport_pc-probing-on-powermac.patch
-add-pekka-to-credits.patch
-ipmi-allow-user-to-override-the-kernel-ipmi-daemon-enable.patch
-ipmi-allow-user-to-override-the-kernel-ipmi-daemon-enable-tidy.patch
-ia64-note-requirement-for-8250_pnp-now-that-8250_acpi-is-gone.patch
-maintainers-removes-duplicated-entry.patch
-pktcdvd-replace-pktcdvd-strings-with-macro-driver_name.patch
-pktcdvd-rename-a-variable-for-better-readability.patch
-remove-unnecessary-check-in-fs-reiserfs-inodec.patch
-add-unifdef-to-gitignore.patch
-fix-spurious-error-on-tags-target-when-missing-defconfig.patch
-pata_hpt366-fix-typo.patch
-hisax-niccy-cleanup.patch
-knfsd-nfsd-lockdep-annotation-fix.patch
-knfsd-call-lockd_down-when-closing-a-socket-via-a-write-to-nfsd-portlist.patch
-knfsd-protect-update-to-sn_nrthreads-with-lock_kernel.patch
-knfsd-fixed-handling-of-lockd-fail-when-adding-nfsd-socket.patch
-knfsd-replace-two-page-lists-in-struct-svc_rqst-with-one.patch
-knfsd-replace-two-page-lists-in-struct-svc_rqst-with-one-fix.patch
-knfsd-avoid-excess-stack-usage-in-svc_tcp_recvfrom.patch
-knfsd-prepare-knfsd-for-support-of-rsize-wsize-of-up-to-1mb-over-tcp.patch
-knfsd-allow-max-size-of-nfsd-payload-to-be-configured.patch
-knfsd-make-nfsd-readahead-params-cache-smp-friendly.patch
-knfsd-knfsd-cache-ipmap-per-tcp-socket.patch
-knfsd-hide-use-of-lockds-h_monitored-flag.patch
-knfsd-consolidate-common-code-for-statd-lockd-notification.patch
-knfsd-when-looking-up-a-lockd-host-pass-hostname-length.patch
-knfsd-lockd-introduce-nsm_handle.patch
-knfsd-lockd-introduce-nsm_handle-fix.patch
-knfsd-misc-minor-fixes-indentation-changes.patch
-knfsd-lockd-make-nlm_host_rebooted-use-the-nsm_handle.patch
-knfsd-lockd-make-the-nsm-upcalls-use-the-nsm_handle.patch
-knfsd-lockd-make-the-hash-chains-use-a-hlist_node.patch
-knfsd-lockd-change-list-of-blocked-list-to-list_node.patch
-knfsd-change-nlm_file-to-use-a-hlist.patch
-knfsd-lockd-make-nlm_traverse_-more-flexible.patch
-knfsd-lockd-add-nlm_destroy_host.patch
-knfsd-simplify-nlmsvc_invalidate_all.patch
-knfsd-lockd-optionally-use-hostnames-for-identifying-peers.patch
-knfsd-make-nlmclnt_next_cookie-smp-safe.patch
-knfsd-match-granted_res-replies-using-cookies.patch
-knfsd-export-nsm_local_state-to-user-space-via-sysctl.patch
-knfsd-lockd-fix-use-of-h_nextrebind.patch
-knfsd-register-all-rpc-programs-with-portmapper-by-default.patch
-knfsd-lockd-introduce-nsm_handle-sem2mutex.patch
-knfsd-svcrpc-gss-factor-out-some-common-wrapping-code.patch
-knfsd-svcrpc-gss-fix-failure-on-svc_denied-in-integrity-case.patch
-knfsd-svcrpc-use-consistent-variable-name-for-the-reply-state.patch
-knfsd-nfsd4-refactor-exp_pseudoroot.patch
-knfsd-nfsd4-clean-up-exp_pseudoroot.patch
-knfsd-nfsd4-acls-relax-the-nfsv4-posix-mapping.patch
-knfsd-nfsd4-acls-fix-inheritance.patch
-knfsd-nfsd4-acls-simplify-nfs4_acl_nfsv4_to_posix-interface.patch
-knfsd-nfsd4-acls-fix-handling-of-zero-length-acls.patch
-knfsd-lockd-fix-refount-on-nsm.patch
-knfsd-fix-auto-sizing-of-nfsd-request-reply-buffers.patch
-knfsd-close-a-race-opportunity-in-d_splice_alias.patch
-knfsd-nfsd-store-export-path-in-export.patch
-knfsd-nfsd4-fslocations-data-structures.patch
-knfsd-nfsd4-fslocations-data-structures-nfsd4-fix-fs-locations-bounds-checking.patch
-knfsd-nfsd4-fslocations-data-structures-nfsd4-fslocs-fix-compile-in-non-config_nfsd_v4-case.patch
-knfsd-nfsd4-xdr-encoding-for-fs_locations.patch
-knfsd-nfsd4-actually-use-all-the-pieces-to-implement-referrals.patch
-sched-force-sbin-init-off-isolated-cpus.patch
-sched-remove-unnecessary-sched-group-allocations.patch
-sched-dont-print-migration-cost-when-only-1-cpu.patch
-sched-introduce-child-field-in-sched_domain.patch
-sched-cleanup-sched_group-cpu_power-setup.patch
-sched-fixing-wrong-comment-for-find_idlest_cpu.patch
-scheduler-numa-aware-placement-of-sched_group_allnodes.patch
-ecryptfs-fs-makefile-and-fs-kconfig.patch
-ecryptfs-fs-makefile-and-fs-kconfig-kconfig-help-update.patch
-ecryptfs-documentation.patch
-ecryptfs-makefile.patch
-ecryptfs-main-module-functions.patch
-ecryptfs-header-declarations.patch
-ecryptfs-superblock-operations.patch
-ecryptfs-dentry-operations.patch
-ecryptfs-file-operations.patch
-ecryptfs-file-operations-readdir-fix-for-seeking-in-directory-streams.patch
-ecryptfs-inode-operations.patch
-ecryptfs-mmap-operations.patch
-ecryptfs-mmap-operations-fix.patch
-ecryptfs-keystore.patch
-ecryptfs-crypto-functions.patch
-ecryptfs-crypto-functions-mutex-fixes.patch
-fs-ecryptfs-possible-cleanups.patch
-ecryptfs-debug-functions.patch
-ecryptfs-alpha-build-fix.patch
-ecryptfs-convert-assert-to-bug_on.patch
-ecryptfs-remove-pointless-bug_ons.patch
-ecryptfs-remove-unnecessary-null-checks.patch
-ecryptfs-rewrite-ecryptfs_fsync.patch
-ecryptfs-overhaul-file-locking.patch
-ecryptfs-remove-lock-propagation.patch
-ecryptfs-dont-muck-with-the-existing-nameidata-structures.patch
-ecryptfs-asm-scatterlisth-linux-scatterlisth.patch
-ecryptfs-support-for-larger-maximum-key-size.patch
-ecryptfs-add-codes-for-additional-ciphers.patch
-ecryptfs-unencrypted-key-size-based-on-encrypted-key-size.patch
-ecryptfs-packet-and-key-management-update-for-variable-key-size.patch
-ecryptfs-add-ecryptfs_-prefix-to-mount-options-key-size-parameter.patch
-ecryptfs-set-the-key-size-from-the-default-for-the-mount.patch
-ecryptfs-check-for-weak-keys.patch
-ecryptfs-add-define-values-for-cipher-codes-from-rfc2440-openpgp.patch
-ecryptfs-convert-bits-to-bytes.patch
-ecryptfs-more-elegant-aes-key-size-manipulation.patch
-ecryptfs-more-intelligent-use-of-tfm-objects.patch
-ecryptfs-remove-debugging-cruft.patch
-ecryptfs-get_sb_dev-fix.patch
-ecryptfs-validate-minimum-header-extent-size.patch
-ecryptfs-validate-body-size.patch
-ecryptfs-validate-packet-length-prior-to-parsing-add-comments.patch
-ecryptfs-use-the-passed-in-max-value-as-the-upper-bound.patch
-ecryptfs-change-the-maximum-size-check-when-writing-header.patch
-ecryptfs-print-the-actual-option-that-is-problematic.patch
-ecryptfs-add-a-maintainers-entry.patch
-ecryptfs-partial-signed-integer-to-size_t-conversion-updated-ii.patch
-ecryptfs-graceful-handling-of-mount-error.patch
-inode-diet-move-i_pipe-into-a-union-ecryptfs.patch
-inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default-ecryptfs.patch
-streamline-generic_file_-interfaces-and-filemap-ecryptfs.patch
-ecryptfs-fix-printk-format-warnings.patch
-ecryptfs-associate-vfsmount-with-dentry-rather-than-superblock.patch
-ecryptfs-mntput-lower-mount-on-umount_begin.patch
-vfs-make-filldir_t-and-struct-kstat-deal-in-64-bit-inode-numbers-ecryptfs.patch
-make-kmem_cache_destroy-return-void-ecryptfs.patch
-ecryptfs-inode-numbering-fixes.patch
-ecryptfs-versioning-fixes.patch
-ecryptfs-versioning-fixes-tidy.patch
-ecryptfs-grab-lock-on-lower_page-in-ecryptfs_sync_page.patch
-ecryptfs-enable-plaintext-passthrough.patch
-non-libata-driver-for-jmicron-devices.patch
-ide-claim-extra-dma-ports-regardless-of-channel.patch
-ide-always-release-dma-engine.patch
-ide-error-handling-fixes.patch
-make-number-of-ide-interfaces-configurable.patch
-ide_dma_speed-fixes.patch
-enable-cdrom-dma-access-with-pdc20265_old.patch
-ide-fix-revision-comparison-in-ide_in_drive_list.patch
-ide-backport-piix-fixes-from-libata-into-the-legacy-driver.patch
-move-ide-to-unmaintained-drop-reference-to-old-git-tree.patch
-ide-core-must_check-fixes.patch
-drivers-ide-cleanups.patch
-ide-remove-dma_base2-field-from-ide_hwif_t.patch
-ide-reprogram-disk-pio-timings-on-resume.patch
-pcmcia-add-few-ids-into-ide-cs.patch
-config_pm=n-slim-drivers-ide-pci-sc1200c.patch
-ide-fix-crash-on-repeated-reset.patch
-ide-fix-crash-on-repeated-reset-tidy.patch
-allow-ide_generic_all-to-be-used-modular-and-built-in.patch
-ide-more-pci_find-cleanup.patch
-ide-cs-compactflash-driver-rm-irq-warning.patch
-au1100fb-add-option-to-enable-disable-the-cursor.patch
-intelfb-documentation-update.patch
-rivafb-use-constants-instead-of-magic-values.patch
-vfb-document-option-to-enable-the-driver.patch
-fbdev-add-generic-ddc-read-functionality.patch
-nvidiafb-use-generic-ddc-reading.patch
-rivafb-use-generic-ddc-reading.patch
-i810fb-use-generic-ddc-reading.patch
-savagefb-use-generic-ddc-reading.patch
-savagefb-use-generic-ddc-reading-fix.patch
-radeonfb-use-generic-ddc-reading.patch
-fbcon-use-persistent-allocation-for-cursor-blinking.patch
-fbcon-remove-cursor-timer-if-unused.patch
-vt-honor-the-return-value-of-device_create_file.patch
-fbdev-honor-the-return-value-of-device_create_file.patch
-fbcon-honor-the-return-value-of-device_create_file.patch
-atyfb-honor-the-return-value-of-pci_register_driver.patch
-matroxfb-honor-the-return-value-of-pci_register_driver.patch
-nvidiafb-honor-the-return-value-of-pci_enable_device.patch
-i810fb-honor-the-return-value-of-pci_enable_device.patch
-drivers-video-sis-init301h-removal-of-old.patch
-drivers-video-sis-initextlfbc-removal-of.patch
-drivers-video-sis-inith-removal-of-old-code.patch
-drivers-video-sis-osdefh-removal-of-old-code.patch
-drivers-video-sis-sis_accelc-removal-of-old.patch
-drivers-video-sis-sis_accelh-removal-of-old.patch
-drivers-video-sis-sis_mainc-removal-of-old.patch
-drivers-video-sis-sis_mainc-removal-of-old-2.patch
-drivers-video-sis-vgatypesh-removal-of-old.patch
-drivers-video-sis-sis_mainh-removal-of-old.patch
-atyfb-possible-cleanups.patch
-mbxfb-fix-a-chip-bug-resulting-in-wrong-pixclock.patch
-mbxfb-fix-framebuffer-size-smaller-than-requested.patch
-fbcon-make-3-functions-static.patch
-vt-proper-prototypes-for-some-console-functions.patch
-sstfb-clean-ups.patch
-documentation-fixes-in-intel810txt.patch
-radeonfb-supend-resume-support-for-acer-aspire-2010.patch
-fbdev-correct-buffer-size-limit-in-fbmem_read_proc.patch
-dm-support-ioctls-on-mapped-devices.patch
-dm-linear-support-ioctls.patch
-dm-mpath-support-ioctls.patch
-dm-export-blkdev_driver_ioctl.patch
-dm-support-ioctls-on-mapped-devices-fix-with-fake-file.patch
-dm-fix-alloc_dev-error-path.patch
-dm-snapshot-fix-invalidation-enomem.patch
-dm-snapshot-allow-zero-chunk_size.patch
-dm-snapshot-fix-metadata-error-handling.patch
-dm-snapshot-make-read-and-write-exception-functions-void.patch
-dm-snapshot-fix-metadata-writing-when-suspending.patch
-dm-snapshot-tidy-snapshot_map.patch
-dm-snapshot-tidy-pending_complete.patch
-dm-snapshot-add-workqueue.patch
-dm-snapshot-tidy-pe-ref-counting.patch
-dm-snapshot-fix-freeing-pending-exception.patch
-dm-mirror-remove-trailing-space-from-table.patch
-dm-mpath-tidy-ctr.patch
-dm-mpath-use-kzalloc.patch
-dm-add-uevent-change-event-on-resume.patch
-dm-add-debug-macro.patch
-dm-table-add-target-preresume.patch
-dm-crypt-add-key-msg.patch
-dm-crypt-restructure-for-workqueue-change.patch
-dm-crypt-restructure-write-processing.patch
-dm-crypt-move-io-to-workqueue.patch
-dm-crypt-use-private-biosets.patch
-dm-use-private-biosets.patch
-dm-extract-device-limit-setting.patch
-dm-table-add-target-flush.patch
-md-the-scheduled-removal-of-the-start_array-ioctl-for-md.patch
-md-fix-a-comment-that-is-wrong-in-raid5h.patch
-md-factor-out-part-of-raid10d-into-a-separate-function.patch
-md-replace-magic-numbers-in-sb_dirty-with-well-defined-bit-flags.patch
-md-remove-the-working_disks-and-failed_disks-from-raid5-state-data.patch
-md-remove-working_disks-from-raid10-state.patch
-md-new-sysfs-interface-for-setting-bits-in-the-write-intent-bitmap.patch
-md-remove-unnecessary-variable-x-in-stripe_to_pdidx.patch
-md-factor-out-part-of-raid1d-into-a-separate-function.patch
-md-remove-working_disks-from-raid1-state-data.patch
-md-improve-locking-around-error-handling.patch
-md-define-backing_dev_infocongested_fn-for-raid0-and-linear.patch
-md-define-congested_fn-for-raid1-raid10-and-multipath.patch
-md-add-a-congested_fn-function-for-raid5-6.patch
-md-make-messages-about-resync-recovery-etc-more-specific.patch
-md-fix-duplicity-of-levels-in-mdtxt.patch
-md-remove-max_md_devs-which-is-an-arbitrary-limit.patch
-md-remove-experimental-classification-from-raid5-reshape.patch
-md-use-ffz-instead-of-find_first_set-to-convert-multiplier-to-shift.patch
-md-allow-set_bitmap_file-to-work-on-64bit-kernel-with-32bit-userspace.patch
-md-add-error-reporting-to-superblock-write-failure.patch
-genirq-convert-the-x86_64-architecture-to-irq-chips.patch
-genirq-convert-the-i386-architecture-to-irq-chips.patch
-genirq-irq-convert-the-move_irq-flag-from-a-32bit-word-to-a-single-bit.patch
-genirq-irq-add-moved_masked_irq.patch
-genirq-x86_64-irq-reenable-migrating-irqs-to-other-cpus.patch
-genirq-msi-simplify-msi-enable-and-disable.patch
-genirq-msi-make-the-msi-boolean-tests-return-either-0-or-1.patch
-genirq-msi-implement-helper-functions-read_msi_msg-and-write_msi_msg.patch
-genirq-msi-refactor-the-msi_ops.patch
-genirq-msi-simplify-the-msi-irq-limit-policy.patch
-genirq-irq-add-a-dynamic-irq-creation-api.patch
-genirq-ia64-irq-dynamic-irq-support.patch
-genirq-i386-irq-dynamic-irq-support.patch
-genirq-x86_64-irq-dynamic-irq-support.patch
-genirq-msi-make-the-msi-code-irq-based-and-not-vector-based.patch
-genirq-x86_64-irq-move-msi-message-composition-into-io_apicc.patch
-genirq-i386-irq-move-msi-message-composition-into-io_apicc.patch
-genirq-msi-only-build-msi-apicc-on-ia64.patch
-genirq-msi-only-build-msi-apicc-on-ia64-fix.patch
-genirq-x86_64-irq-remove-the-msi-assumption-that-irq-==-vector.patch
-genirq-i386-irq-remove-the-msi-assumption-that-irq-==-vector.patch
-genirq-irq-remove-msi-hacks.patch
-genirq-irq-generalize-the-check-for-hardirq_bits.patch
-genirq-x86_64-irq-make-the-external-irq-handlers-report-their-vector-not-the-irq-number.patch
-genirq-x86_64-irq-make-vector_irq-per-cpu.patch
-genirq-x86_64-irq-make-vector_irq-per-cpu-fix.patch
-genirq-x86_64-irq-make-vector_irq-per-cpu-warning-fix.patch
-genirq-x86_64-irq-kill-gsi_irq_sharing.patch
-genirq-x86_64-irq-kill-irq-compression.patch
-add-hypertransport-capability-defines.patch
-add-hypertransport-capability-defines-fix.patch
-initial-generic-hypertransport-interrupt-support.patch
-initial-generic-hypertransport-interrupt-support-Kconfig-fix.patch
-msi-simplify-msi-sanity-checks-by-adding-with-generic-irq-code.patch
-msi-only-use-a-single-irq_chip-for-msi-interrupts.patch
-msi-refactor-and-move-the-msi-irq_chip-into-the-arch-code.patch
-msi-move-the-ia64-code-into-arch-ia64.patch
-htirq-tidy-up-the-htirq-code.patch
-genirq-clean-up-irq-flow-type-naming.patch
-srcu-3-rcu-variant-permitting-read-side-blocking.patch
-srcu-3-rcu-variant-permitting-read-side-blocking-fix.patch
-srcu-3-rcu-variant-permitting-read-side-blocking-srcu-add-lock-annotations.patch
-srcu-3-rcu-variant-permitting-read-side-blocking-comments.patch
-srcu-3-add-srcu-operations-to-rcutorture.patch
-srcu-3-add-srcu-operations-to-rcutorture-fix.patch
-add-srcu-based-notifier-chains.patch
-add-srcu-based-notifier-chains-cleanup.patch
-srcu-report-out-of-memory-errors.patch
-srcu-report-out-of-memory-errors-fixlet.patch
-cpufreq-make-the-transition_notifier-chain-use-srcu.patch
-rcu-add-module_author-to-rcutorture-module.patch
-rcu-fix-incorrect-description-of-default-for-rcutorture.patch
-rcu-mention-rcu_bh-in-description-of-rcutortures.patch
-rcu-avoid-kthread_stop-on-invalid-pointer-if-rcutorture.patch
-rcu-fix-sign-bug-making-rcu_random-always-return-the-same.patch
-rcu-add-fake-writers-to-rcutorture.patch
-rcu-add-fake-writers-to-rcutorture-tidy.patch
-rcu-refactor-srcu_torture_deferred_free-to-work-for.patch
-rcu-add-rcu_sync-torture-type-to-rcutorture.patch
-rcu-add-rcu_bh_sync-torture-type-to-rcutorture.patch
-rcu-add-sched-torture-type-to-rcutorture.patch
-rcu-simplify-improve-batch-tuning.patch
-rcu-credits-and-maintainers.patch
-the-scheduled-removal-of-some-oss-drivers.patch
-the-scheduled-removal-of-some-oss-drivers-fix.patch
-the-scheduled-removal-of-some-oss-drivers-fix-fix.patch
-kill-sound-oss-_symsc.patch
-kill-include-linux-configh.patch
-pci_module_init-convertion-in-ata_genericc.patch
-pci_module_init-convertion-in-ata_genericc-fix.patch
-pci_module_init-convertion-in-amso1100-driver.patch
-pci_module_init-convertion-for-k8_edacc.patch
-pci_module_init-convertion-in-the-legacy-megaraid-driver.patch
-pci_module_init-convertion-in-olympicc.patch
-pci_module_init-conversion-for-pata_pdc2027x.patch
-pci_module_init-convertion-in-tmscsimc.patch
-pr_debug-aio-use-size_t-length-modifier-in-pr_debug-format-arguments.patch
-pr_debug-configfs-use-size_t-length-modifier-in-pr_debug-format-argument.patch
-pr_debug-sysfs-use-size_t-length-modifier-in-pr_debug-format-arguments.patch
-pr_debug-umem-repair-nonexistant-bh-pr_debug-reference.patch
-pr_debug-tipar-repair-nonexistant-pr_debug-argument-use.patch
-pr_debug-dell_rbu-fix-pr_debug-argument-warnings.patch
-pr_debug-ifb-replace-missing-comma-to-separate-pr_debug-arguments.patch
-pr_debug-trident-use-size_t-length-modifier-in-pr_debug-format-arguments.patch
-pr_debug-check-pr_debug-arguments-arm-fix.patch
-isdn-debug-build-fix.patch
-isdn-more-pr_debug-fixes.patch
-pr_debug-check-pr_debug-arguments.patch
-squash-tcp-warnings.patch

 Merged into mainline or a subsystem tree.

+null-dereference-in-fs-jbd-journalc.patch
+irq-fix-avr32-breakage.patch
+mm-use-symbolic-names-instead-of-indices-for-zone-initialisation.patch
+mm-remove-memmap_zone_idx.patch
+fix-menuconfig-build-failure-due-to-missing-stdboolh.patch
+user-struct-irq_chip-instead-of-struct-hw_interrupt_type.patch
+disable-detect_softlockup-for-s390.patch

 2.6.19 queue.

+revert-pci-quirk-for-ibm-dock-ii-cardbus-controllers.patch
+revert-nvidiafb-use-generic-ddc-reading.patch

 Will be 2.6.19 queue soon if we don't look like fixing a few things.

+ext4-copy.patch
+ext4-rename.patch
+ext4-enable.patch
+jbd2-copy.patch
+jbd2-rename.patch
+jbd2-rename-slab.patch
+jbd2-enable.patch
+jbd2-cleanup.patch
+ext4-extents.patch
+ext4_fsblk_sector_t.patch
+ext4-extents-48bit.patch
+ext4-unitialized-extent-handling.patch
+extents_comment_fix.patch
+64bit_jbd2_core.patch
+sector_t-jbd2.patch
+ext4_48bit_i_file_acl.patch
+64bit-metadata.patch
+ext4_blk_type_from_sector_t_to_ulonglong.patch
+ext4_blk_type_from_sector_t_to_ulonglong-fix.patch
+ext4_remove_sector_t_bits_check.patch
+jbd2_blks_type_from_sector_t_to_ull.patch
+ext4_allow_larger_descriptor_size.patch
+ext4_move_block_number_hi_bits.patch
+ext4-uninline-ext4_get_group_no_and_offset.patch
+ext4-64-bit-divide-fix.patch
+ext4-64-bit-divide-fix-fix.patch
+ext4-rename-logic_sb_block.patch
+ext4-errors-behaviour-fix.patch
+ext4-whitespace-cleanups.patch

 ext4

+i386-acpi-build-fix.patch

 ACPI fix

+cifs-kconfig-dont-select-connector.patch

 CIFS Kconfig sanity

+gregkh-driver-documentation-feature-removal-schedule-typo.patch
+gregkh-driver-driver-core-don-t-ignore-error-returns-from-probing.patch
+gregkh-driver-driver-core-bus-remove-indentation-level.patch
+gregkh-driver-aoe-eliminate-isbusy-message.patch
+gregkh-driver-aoe-update-copyright-date.patch
+gregkh-driver-aoe-remove-unused-nargs-enum.patch
+gregkh-driver-aoe-zero-copy-write-1-of-2.patch
+gregkh-driver-aoe-jumbo-frame-support-1-of-2.patch
+gregkh-driver-aoe-clean-up-printks-via-macros.patch
+gregkh-driver-aoe-jumbo-frame-support-2-of-2.patch
+gregkh-driver-aoe-improve-retransmission-heuristics.patch
+gregkh-driver-aoe-zero-copy-write-2-of-2.patch
+gregkh-driver-aoe-module-parameter-for-device-timeout.patch
+gregkh-driver-aoe-use-bio-bi_idx.patch
+gregkh-driver-aoe-remove-sysfs-comment.patch
+gregkh-driver-aoe-update-driver-version.patch
+gregkh-driver-aoe-revert-printk-macros.patch
+gregkh-driver-aoe-fix-sysfs-warnings.patch
+gregkh-driver-driver-link-sysfs-timing.patch

 Driver tree updates.

+w1-kconfig-fix.patch
+fs-partitions-check-add-sysfs-error-handling.patch
+char-nozomi-use-tty_wakeup.patch

 Misc fixes agaisnt driver tree.

+drm-fix-error-returns-sysfs-error-handling.patch

 DRM sysfs fix.

+git-dvb-build-fix.patch

 Fix rejects in git-dvb.patch

+gregkh-i2c-w1-ioremap-balanced-with-iounmap.patch

 I2C tree update.

+kill-include-linux-configh-ia64.patch

 ia64 cleanup.

-revert-input-make-input_openclose_device-more-robust.patch

 Dropped.

+pci_module_init-convertion-in-amso1100-driver.patch
+drivers-infiniband-hw-amso1100-c2_rnicc-fix-a-null-dereference.patch

 infiniband things.

+git-input-fixup.patch

 Fix rejects in git-input.patch (which isn't here.  But it compiles.  hrm)

+ata-must-depend-on-block.patch
+pci_module_init-convertion-in-ata_genericc.patch
+pci_module_init-convertion-in-ata_genericc-fix.patch
+pci_module_init-conversion-for-pata_pdc2027x.patch

 sata/pata things.

+mtd-maps-add-parameter-to-amd76xrom-to-override-rom-window-size-if-set-incorrectly-by-bios.patch
+mtd-maps-add-parameter-to-amd76xrom-to-override-rom-window-size-if-set-incorrectly-by-bios-tweak.patch
+mtd-chips-support-for-sst-49lf040b-flash-chip.patch
+mtd-maps-support-for-bios-flash-chips-on-intel-esb2-southbridge.patch
+mtd-maps-support-for-bios-flash-chips-on-intel-esb2-southbridge-tidy.patch
+mtd-maps-support-for-bios-flash-chips-on-intel-esb2-southbridge-fix.patch

 MTD updates.

+libphy-dont-do-that.patch

 netdev build fix (allegedly deadlocks).

-powerpc-cell-spidernet-burst-alignment-patch.patch
-powerpc-cell-spidernet-low-watermark-patch.patch
-powerpc-cell-spidernet-stop-error-printing-patch.patch
-powerpc-cell-spidernet-ethtool-i-version-number-info.patch
-powerpc-cell-spidernet-ethtool-i-version-number.patch
-powerpc-cell-spidernet-refine-locking.patch

 Dropped.

+pci_module_init-convertion-in-olympicc.patch
+ibmveth-irq-fix.patch

 netdev fixes.

+drivers-atm-no-need-to-return-void.patch

 Driver cleanup.

-git-parisc-powerpc-fix.patch

 Dropped.

+git-serial-fixup.patch

 Actually a pcmcia fix.

+ioremap-balanced-with-iounmap-for-drivers-pcmcia.patch
+export-soc_common_drv_pcmcia_remove-to-allow-modular-pcmcia.patch

 pcmcia fixes.

-git-serial-fixup.patch

 Dropped.

-serial-fix-uart_bug_txen-test.patch

 Unneeded, dropped.

+gregkh-pci-acpipnp-dma-resource-setup-fix.patch
+gregkh-pci-pci-fix-pcie_portdrv_restore_config-undefined-without-config_pm-error.patch
+gregkh-pci-pci-stamp-out-pci_find_-usage-in-fakephp.patch
+gregkh-pci-shpchp-fix-command-completion-check.patch
+gregkh-pci-shpchp-remove-unnecessary-cmd_busy-member-from-struct.patch
+gregkh-pci-pci-hotplug-ioremap-balanced-with-iounmap.patch
+gregkh-pci-pci-improve-pci_msi_supported-comments.patch
+gregkh-pci-pci-update-msi-howto.txt-according-to-pci_msi_supported.patch
+gregkh-pci-change-pci-hotplug-subsystem-maintainer-to-kristen.patch
+gregkh-pci-pci-optionally-sort-device-lists-breadth-first.patch
+gregkh-pci-pci-quirks-fix-the-festering-mess-that-claims-to-handle-ide-quirks.patch
-gregkh-pci-altix-rom-shadowing.patch
+gregkh-pci-altix-initial-acpi-support-rom-shadowing.patch

 PCI tree updates.

-revert-gregkh-pci-altix-rom-shadowing.patch
-revert-gregkh-pci-altix-sn-acpi-hotplug-support.patch
-revert-gregkh-pci-altix-add-initial-acpi-io-support.patch

 Dropped.

-revert-pci-assign-ioapic-resource-at-hotplug.patch

 Dropped.

+quirks-switch-quirks-code-offender-to-use-pci_get-api.patch

 PCI fix.

+scsi-scsi_cmnd-convertion-in-sun3-driver.patch
+scsi-scsi_cmnd-conversion-in-qlogicfas408-driver.patch
+scsi-scsi_cmnd-convertion-in-psi240i-driver.patch
+pci_module_init-convertion-in-the-legacy-megaraid-driver.patch
+pci_module_init-convertion-in-tmscsimc.patch
+aic94xx-sata-tag-mask-not-set-correctly.patch
+maintain-module-parameter-name-consistency-with-qla2xxx-qla4xxx.patch
+scsi_libc-use-build_bug_on.patch
+drivers-scsi-dpt_i2oc-remove-dead-code.patch

 SCSI fixes.

+gregkh-usb-usb-fix-use-after-free-in-wacom_sys.c.patch
+gregkh-usb-airprime-new-device-id.patch
+gregkh-usb-usb-support-for-bt-on-air-usb-modem-in-cdc-acm.c.patch
+gregkh-usb-usb-suspend-resume-support-for-kaweth.patch
+gregkh-usb-usb-ohci-pnx4008-build-fixes.patch
+gregkh-usb-ueagle-be-suspend-friendly.patch
+gregkh-usb-ueagle-use-interruptible-sleep.patch
+gregkh-usb-ueagle-comestic-changes.patch
+gregkh-usb-usb-fix-cdc-acm-problems-with-hard-irq.patch
+gregkh-usb-usb-unusual_devs-entry-for-nokia-6131.patch
+gregkh-usb-usbatm-fix-tiny-race.patch
+gregkh-usb-speedtch-extended-reach.patch
+gregkh-usb-cxacru-add-the-zte-zxdsl-852.patch
+gregkh-usb-usb-fix-suspend-support-for-usblp.patch
+gregkh-usb-usb-ftdi-elan-fix-sparse-warnings.patch
+gregkh-usb-usb-ehci-hcd-make-ehci_iso_stream-instances-more-persistent.patch
+gregkh-usb-usb-ehci-hcd-periodic-startup-shutdown-centralization-and-hysteresis.patch
+gregkh-usb-usb-ehci-hcd-group-interrupt-endpoint-code-into-one-place.patch
+gregkh-usb-usb-ehci-hcd-group-ehci_iso_sched-functions-into-one-place.patch
+gregkh-usb-usb-ehci-hcd-group-ehci_iso_sched-and-ehci_itd-code.patch
+gregkh-usb-usb-ehci-hcd-group-ehci_sitd-code-in-one-place.patch
+gregkh-usb-usb-ehci-hcd-refactor-sitd-link-patch-code-for-easier-frame-spanning.patch
+gregkh-usb-usb-ehci-hcd-split-scan_periodic-to-reuse-code-for-spanned-completions.patch
+gregkh-usb-usb-ehci-hcd-unify-interval-granularity-and-limit-depth-of-interrupt-tree.patch
+gregkh-usb-usb-ehci-hcd-add-shadow-budget-code.patch
+gregkh-usb-usb-ehci-hcd-activate-shadow-budget-tracking.patch
+gregkh-usb-usb-ehci-hcd-activate-use-of-shadow-budget-for-scheduling-decisions.patch
+gregkh-usb-usb-ehci-hcd-add-fstn-support.patch
+gregkh-usb-usb-ehci-hcd-add-sitd-frame-spanning-support.patch
+gregkh-usb-ehci-hcd-fix-budget_pool-allocation-for-machines-with-multiple-ehci-controllers.patch
+gregkh-usb-usb-usbaudio-correct-bug-caused-by-harmless-underrun-during-playback-setup.patch

 USB tree updates.

+fix-gregkh-usb-usbatm-fix-tiny-race.patch
+memory-leak-in-drivers-usb-serial-airprimec.patch
+extract-and-implement-are-bit-field-manipulation-routines.patch
+drivers-usb-net-use-build_bug_on.patch
+drivers-usb-misc-ftdi-elanc-remove-dead-code.patch
+drivers-usb-serial-mos7840c-fix-a-check-after-dereference.patch

 USB updates.

-git-watchdog-fixup.patch

 Dropped.

+airo-suspend-fix.patch
+prism54-use-build_bug_on.patch

 Wireless driver fixes.

+x86_64-overlapping-program-headers-in-physical-addr-space-fix.patch
+sleazy-fpu-feature-i386-support.patch
+add-seccomp_disable_tsc-config-option.patch
+i386-fix-recursive-faults-during-oops-when-current.patch
+x86-remove-default_ldt-and-simplify-ldt-setting.patch
+fix-buggy-mtrr-address-checks.patch
+i386-espfix-cleanup.patch
+x86_64-hot-add-memroy-sratc-fix.patch
+x86_64-add-missing-enter_idle-calls.patch
+x86_64-rename-x86_feature_dtes-to-x86_feature_ds.patch
+add-x86_feature_pebs-and-detection.patch
+i386-rename-x86_feature_dtes-to-x86_feature_ds.patch
+i386-add-x86_feature_pebs-and-detection.patch
+remove-pointless-printk-from-i386-oops-output.patch
+compress-stack-unwinder-output.patch
+x86_64-use-build_bug_on-in-fpu-code.patch
+fix-for-arch-x86_64-pci-makefile-cflags.patch
+i386-math-emu-fix-must_checks.patch

 x86 and x86_64 updates.

+touchkit-ps-2-touchscreen-driver-configh.patch
+touchkit-ps-2-touchscreen-driver-regs-fix.patch

 Fix touchkit-ps-2-touchscreen-driver.patch

+direct-io-sync-and-invalidate-file-region-when-falling-back-to-buffered-write.patch
+direct-io-sync-and-invalidate-file-region-when-falling-back-to-buffered-write-fixes.patch

 Make direct-io fallback-to-buffered work more like direct-io normally does.

+mm-kevent-threads-use-mpol_default.patch
+move-rmap-bug_on-outside-debug_vm.patch
+fix-do_mbind-warning-with-config_migration=n.patch
+memory-page-alloc-minor-cleanups.patch

 MM updates

-get-rid-of-zone_table-fix.patch
-get-rid-of-zone_table-fix-2.patch
-get-rid-of-zone_table-fix-4.patch

 Folded into get-rid-of-zone_table.patch

-deal-with-cases-of-zone_dma-meaning-the-first-zone-fix.patch

 Folded into deal-with-cases-of-zone_dma-meaning-the-first-zone.patch

-optional-zone_dma-in-the-vm-tidy.patch

 Folded into optional-zone_dma-in-the-vm.patch

+zoneid-fix-up-calculations-for-zoneid_pgshift.patch

 Fix zone rework patches in -mm.

-swap-token-try-to-grab-swap-token-before-the-vm-selects-pages-for-eviction.patch
-swap-token-new-scheme-to-preempt-token.patch
-swap-token-new-scheme-to-preempt-token-tidy.patch
+grab-swap-token-reordered.patch
+new-scheme-to-preempt-swap-token.patch
+new-scheme-to-preempt-swap-token-tidy.patch
+shared-page-table-for-hugetlb-page-v4.patch
+htlb-forget-rss-with-pt-sharing.patch
+mm-arch_free_page-fix.patch
+mm-locks_freed-fix.patch
+mm-add-arch_alloc_page.patch

 More MM updates.

-fix-tiacx-on-alpha.patch
-tiacx-fix-attribute-packed-warnings.patch
-tiacx-fix-attribute-packed-warnings-fix.patch
-tiacx-pci-build-fix.patch
-tiacx-ia64-fix.patch
-tiacx-build-fix.patch
-tiacx-sparse-cleanups.patch

 Folded into acx1xx-wireless-driver.patch

-swsusp-add-resume_offset-command-line-parameter-rev-2-fix.patch

 Folded into swsusp-add-resume_offset-command-line-parameter-rev-2.patch

-swsusp-add-ioctl-for-swap-files-support-fix.patch

 Folded into swsusp-add-ioctl-for-swap-files-support.patch

+uml-revert-wrong-patch.patch
+uml-correct-removal-of-pte_mkexec.patch
+uml-readd-forgot-prototype.patch
+uml-make-tt-mode-compile-after-setjmp-related-changes.patch
+uml-make-uml_setjmp-always-safe.patch
+uml-fix-processor-selection-to-exclude-unsupported-processors-and-features.patch
+uml-fix-uname-under-setarch-i386.patch
+uml-declare-in-kconfig-our-partial-lockdep-support.patch
+uml-allow-using-again-x86-x86_64-crypto-code.patch
+uml-asm-offsets-duplication-removal.patch
+uml-remove-duplicate-export.patch
+uml-deprecate-config_mode_tt.patch
+uml-allow-finer-tuning-for-host-vmsplit-setting.patch

 UML updates

-edac-new-opteron-athlon64-memory-controller-driver-tidy.patch

 Folded into edac-new-opteron-athlon64-memory-controller-driver.patch

-add-address_space_operationsbatch_write-fix.patch

 Folded into add-address_space_operationsbatch_write.patch

+pci_module_init-convertion-for-k8_edacc.patch
+kbuild-dont-put-temp-files-in-the-source-tree.patch
+grow_buffers-infinite-loop-fix.patch
+ide-generic-jmicron-fix.patch
+fix-rescan_partitions-to-return-errors-properly.patch
+fix-check_partition-routines.patch
+fix-module-taint-flags-listing-in-oops-panic.patch
+ext3-errors-behaviour-fix.patch
+ext2-errors-behaviour-fix.patch
+tpm-fix-error-handling.patch
+sched-likely-profiling.patch
+serial-uartlite-driver.patch
+serial-uartlite-driver-fix.patch
+invalidate_inode_pages2_range-debug.patch
+x86-microcode-handle-sysfs-error.patch
+apm-share-apm-emulator-between-architectures.patch
+32-bit-compatibility-hdio-ioctls.patch
+pktcdvd-reusability-of-procfs-functions.patch
+pktcdvd-make-procfs-interface-optional.patch
+bitmap-parse-input-from-kernel-and-user-buffers-2.patch
+# drivers-add-lcd-support.patch: Pavel says use fbcon
+drivers-add-lcd-support.patch
+drivers-add-lcd-support-update.patch
+ioremap-balanced-with-iounmap-for-drivers-char-rio-rio_linuxc.patch
+ioremap-balanced-with-iounmap-for-drivers-char-moxac.patch
+ioremap-balanced-with-iounmap-for-drivers-char-istallionc.patch
+sound-oss-btaudioc-ioremap-balanced-with-iounmap.patch
+document-the-core-dump-to-a-pipe-patch.patch
+lockdep-annotate-nfs-nfsd-in-kernel-sockets.patch
+lockdep-annotate-nfs-nfsd-in-kernel-sockets-tidy.patch
+honour-mnt_noexec-for-access.patch
+vm-fix-the-gfp_mask-in-invalidate_complete_page2.patch
+posix-cpu-timers-prevent-signal-delivery-starvation.patch
+remove-unnecessary-check-in-fs-fat-inodec.patch
+d-cache-aliasing-issue-in-__block_prepare_write.patch
+use-linux-ioh-instead-of-asm-ioh.patch
+consolidate-check_signature.patch
+fix-typos-in-mm-shmem_aclc.patch
+ht_irq-must-depend-on-pci.patch
+fs-use-build_bug_on.patch
+dac960-use-memmove-for-overlapping-areas.patch
+lockdep-use-build_bug_on.patch
+fix-lockdep-designtxt.patch
+lockdep-fix-printk-recursion-logic.patch
+kernel-doc-fix-function-name-in-usercopyc.patch
+uaccessh-match-kernel-doc-and-function-names.patch
+kernel-doc-drop-various-inline-qualifiers.patch
+include-linux-typesh-in-linux-nbdh.patch
+kernel-doc-make-parameter-description-indentation-uniform.patch
+dell_rbu-printk-warning-fix.patch

 misc.

-generic-bug-handling.patch
-use-generic-bug-for-i386.patch
-use-generic-bug-for-x86-64.patch
-use-generic-bug-for-powerpc.patch
-use-generic-bug-for-powerpc-fix-2.patch
-bug-test-1.patch
+generic-implementatation-of-bug.patch
+generic-implementatation-of-bug-fix.patch
+generic-bug-for-i386.patch
+generic-bug-for-x86-64.patch
+uml-add-generic-bug-support.patch
+use-generic-bug-for-ppc.patch
+bug-test-1.patch

 Updated generic-bug implementation.

+log2-implement-a-general-integer-log2-facility-in-the-kernel.patch
+log2-implement-a-general-integer-log2-facility-in-the-kernel-fix.patch
+log2-alter-roundup_pow_of_two-so-that-it-can-use-a-ilog2-on-a-constant.patch
+log2-alter-get_order-so-that-it-can-make-use-of-ilog2-on-a-constant.patch
+log2-provide-ilog2-fallbacks-for-powerpc.patch

 generic log2() implementation.

+fs-cache-provide-a-filesystem-specific-syncable-page-bit-ext4.patch

 Fix ext4 for fs-cache-provide-a-filesystem-specific-syncable-page-bit.patch

+nfs-use-local-caching-configh.patch

 Clean up nfs-use-local-caching.patch

+fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-log2-fix.patch

 log2() fix.

+char-mxser_new-revert-spin_lock-changes.patch
+char-mxser_new-remove-request-for-testers-line.patch
+char-mxser_new-debug-printk-dependent-on-debug.patch
+char-mxser_new-alter-license-terms.patch
+char-mxser_new-code-upside-down.patch
+char-mxser_new-cmspar-is-defined.patch
+char-remove-unneded-termbits-redefinitions-mxser_new.patch
+char-mxser_new-eliminate-tty-ldisc-deref.patch
+char-mxser_new-testbit-for-bit-testing.patch
+char-mxser_new-correct-fail-paths.patch
+char-mxser_new-dont-check-tty_unregister-retval.patch
+char-mxser_new-compress-isa-finding.patch
+char-mxser_new-register-tty-devices-on-the-fly.patch
+char-mxser_new-compact-structures-round2.patch
+char-mxser_new-reverse-if-else-paths-patch.patch
+char-mxser_new-comments-cleanup.patch

 More updates to the updated mxser driver.

-readahead-sysctl-parameters-fix.patch

 Folded into readahead-sysctl-parameters.patch

-readahead-state-based-method-aging-accounting-apply-type-enum-zone_type-readahead.patch

 Folded into readahead-state-based-method-aging-accounting.patch

-readahead-call-scheme-fix.patch

 Folded into readahead-call-scheme.patch

+reiser4-configh.patch

 reiser4 cleanup

+reiser4-format-subversion-numbers-heir-set-and-file-conversion.patch
+reiser4-cleanups-in-lzo-compression-library.patch

 reiser4 updates.

+ioremap-balanced-with-iounmap-for-drivers-video-virgefb.patch
+ioremap-balanced-with-iounmap-for-drivers-video-vesafb.patch
+ioremap-balanced-with-iounmap-for-drivers-video-tridentfb.patch
+ioremap-balanced-with-iounmap-for-drivers-video-tgafb.patch
+ioremap-balanced-with-iounmap-for-drivers-video-stifb.patch
+ioremap-balanced-with-iounmap-for-drivers-video-retz3fb.patch
+ioremap-balanced-with-iounmap-for-drivers-video-pvr2fb.patch
+ioremap-balanced-with-iounmap-for-drivers-video-platinumfb.patch
+ioremap-balanced-with-iounmap-for-drivers-video-offb.patch
+ioremap-balanced-with-iounmap-for-drivers-video-macfb.patch
+ioremap-balanced-with-iounmap-for-drivers-video-hpfb.patch
+ioremap-balanced-with-iounmap-for-drivers-video-fm2fb.patch
+ioremap-balanced-with-iounmap-for-drivers-video-ffb.patch
+ioremap-balanced-with-iounmap-for-drivers-video-cyberfb.patch
+ioremap-balanced-with-iounmap-for-drivers-video-cirrusfb.patch
+ioremap-balanced-with-iounmap-for-drivers-video-atyfb_base.patch
+ioremap-balanced-with-iounmap-for-drivers-video-atafb.patch
+ioremap-balanced-with-iounmap-for-drivers-video-amifb.patch
+ioremap-balanced-with-iounmap-for-drivers-video-S3triofb.patch

 ioremap() fixes in fbdev drivers.

-statistics-infrastructure-prerequisite-timestamp-fix.patch

 Folded into statistics-infrastructure-prerequisite-timestamp.patch

-statistics-infrastructure-update-9.patch

 Folded into statistics-infrastructure.patch

-statistics-infrastructure-exploitation-zfcp-sched_clock-fix.patch

 Folded into statistics-infrastructure-exploitation-zfcp.patch

+dio-centralize-completion-in-dio_complete.patch
+dio-call-blk_run_address_space-once-per-op.patch
+dio-formalize-bio-counters-as-a-dio-reference-count.patch
+dio-remove-duplicate-bio-wait-code.patch
+dio-only-call-aio_complete-after-returning-eiocbqueued.patch

 drirect-io cleanups and fixes

+fdtable-delete-pointless-code-in-dup_fd.patch
+fdtable-make-fdarray-and-fdsets-equal-in-size.patch
+fdtable-remove-the-free_files-field.patch
+fdtable-implement-new-pagesize-based-fdtable-allocator.patch

 Redo the fdtable code.

+gtod-exponential-update_wall_time.patch
+gtod-persistent-clock-support-core.patch
+gtod-persistent-clock-support-i386.patch
+time-uninline-jiffiesh.patch
+time-fix-msecs_to_jiffies-bug.patch
+time-fix-timeout-overflow.patch
+cleanup-uninline-irq_enter-and-move-it-into-a-function.patch
+dynticks-extend-next_timer_interrupt-to-use-a-reference-jiffie.patch
+hrtimers-namespace-and-enum-cleanup.patch
+hrtimers-clean-up-locking.patch
+hrtimers-state-tracking.patch
+hrtimers-clean-up-callback-tracking.patch
+hrtimers-move-and-add-documentation.patch
+clockevents-core.patch
+clockevents-drivers-for-i386.patch
+high-res-timers-core.patch
+gtod-mark-tsc-unusable-for-highres-timers.patch
+dynticks-core.patch
+dynticks-add-nohz-stats-to-proc-stat.patch
+dynticks-i386-arch-code.patch
+high-res-timers-dynticks-enable-i386-support.patch
+debugging-feature-timer-stats.patch

 hrtimers and dynamic ticks.

+kevent-timer-notifications-fix.patch
+kevent-fix-socket-notifications.patch
+kevent-remove-mmap-interface.patch

 kevent updates




All 766 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/patch-list


