Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752719AbWKBHyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbWKBHyP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 02:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752716AbWKBHyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 02:54:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20888 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752704AbWKBHyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 02:54:14 -0500
Date: Wed, 1 Nov 2006 23:54:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc4-mm2
Message-Id: <20061101235407.a92f94a5.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc4/2.6.19-rc4-mm2/


- This is a bit of a rush job.  Mainly to test the updates to the driver
  tree, which do appear to have improved things.

- There's a huge update here to the hrtimers and dynticks code which I was
  supposed to test to see if it fixes the Vaio-goes-deadly-slow problem, but I
  forgot to.  But it does boot with hrtimers disabled...

  <quickly tests it>

  Nope, doesn't work.

- Lots of fbdev updates.  We haven't heard from Tony in several months, so I
  went on a linux-fbdev-devel fishing expedition.

- `make headers_check' is known-broken on i386 (Rusty's fault, as always)



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



Changes since 2.6.19-rc4-mm1:

 origin.patch
 git-acpi.patch
 git-alsa.patch
 git-cifs.patch
 git-cpufreq.patch
 git-drm.patch
 git-dvb.patch
 git-gfs2.patch
 git-ia64.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-jfs.patch
 git-libata-all.patch
 git-mips.patch
 git-mmc.patch
 git-mtd.patch
 git-netdev-all.patch
 git-net.patch
 git-ioat.patch
 git-ocfs2.patch
 git-pcmcia.patch
 git-powerpc.patch
 git-r8169.patch
 git-pciseg.patch
 git-s390.patch
 git-scsi-misc.patch
 git-scsi-target.patch
 git-sas.patch
 git-qla3xxx.patch
 git-watchdog.patch
 git-wireless.patch
 git-cryptodev.patch
 git-gccbug.patch

 git trees

-find_bd_holder-fix.patch
-uml-ubd-driver-allow-using-up-to-16-ubd-devices.patch
-uml-ubd-driver-document-some-struct-fields.patch
-uml-ubd-driver-var-renames.patch
-uml-ubd-driver-give-better-names-to-some-functions.patch
-uml-ubd-driver-change-ubd_lock-to-be-a-mutex.patch
-uml-ubd-driver-ubd_io_lock-usage-fixup.patch
-uml-ubd-driver-reformat-ubd_config.patch
-uml-ubd-driver-convert-do_ubd-to-a-boolean-variable.patch
-uml-ubd-driver-use-bitfields-where-possible.patch
-uml-ubd-driver-do-not-store-error-codes-as-fd.patch
-uml-ubd-driver-various-little-changes.patch
-uml-add-_text-definition-to-linker-scripts.patch
-uml-add-initcalls.patch
-taskstats-fix-sub-threads-accounting.patch
-ecryptfs-clean-up-crypto-initialization.patch
-ecryptfs-hash-code-to-new-crypto-api.patch
-ecryptfs-cipher-code-to-new-crypto-api.patch
-ecryptfs-consolidate-lower-dentry_opens.patch
-ecryptfs-remove-ecryptfs_umount_begin.patch
-ecryptfs-fix-handling-of-lower-d_count.patch
-md-check-bio-address-after-mapping-through-partitions.patch
-ia64-cpu-hotplug-fix-conflict-between-cpu-hot-add-and-ipi.patch
-ohci1394-shortcut-irq-printing.patch
-sata_nv-adma-ncq-support-for-nforce4-v7.patch
-ata_piix-clean-up-port-flags.patch
-libata-unexport-ata_dev_revalidate.patch
-libata-convert-post_reset-to-flags-in-ata_dev_read_id.patch
-libata-implement-presence-detection-via-polling-identify.patch
-ata_piix-apply-device-detection-via-polling-identify.patch
-ata_piix-strip-now-unneded-map-related-stuff.patch
-libata-revamp-blacklist-support-to-allow-multiple-kinds.patch
-sata_sis-fix-flags-handling-for-the-secondary-port.patch
-ata-generic-platform_device-libata-driver-take-2.patch
-ehea-kzalloc-gfp_atomic-fix.patch
-net-s2io-return-on-null-dev_alloc_skb.patch
-n2-fix-confusing-error-code.patch
-tokenring-fix-module_init-error-handling.patch
-add-weida-microdrive-into-ide-csc.patch
-pci-error-recovery-symbios-scsi-device-driver.patch
-scsi-iscsi-build-failure.patch
-x86_64-irq-reset-more-to-default-when-clear-irq_vector-for-destroy_irq.patch

 Merged into mainline or a subsystem tree

+ecryptfs-cipher-code-to-new-crypto-api-fix.patch
+cleanup-read_pages.patch
+cifs-readpages-fixes.patch
+fuse-readpages-cleanup.patch
+gfs2-readpages-fixes.patch
+edac_mc-fix-error-handling.patch
+nfs4-fix-for-recursive-locking-problem.patch
+ipmi_si_intfc-sets-bad-class_mask-with-pci_device_class.patch
+init_reap_node-initialization-fix.patch
+printk-timed-ratelimit.patch
+schedule-removal-of-futex_fd.patch
+acpi_noirq-section-fix.patch
+swsusp-debugging.patch
+swsusp-debugging-doc.patch
+spi-section-fix.patch
+reiserfs-reset-errval-after-initializing-bitmap-cache.patch
+usb-hub-build-fix.patch
+remove-hotplug-cpu-crap-from-cpufreq.patch
+uml-fix-i-o-hang.patch
+uml-include-tidying.patch
+revert-iscsi-build-failure-use-depends-instead-of.patch

 2.6.19 queue

-lkdtm-module_param-fixes.patch
+lkdtm-cleanup-headers-and-module_param-module_parm_desc.patch

 Updated

+acpi-clear-gpe-before-disabling-it.patch

 ACPi fix

+hdspm-printk-warning-fix.patch

 ALSA fix

+gregkh-driver-w1-ioremap-balanced-with-iounmap.patch
+gregkh-driver-driver-core-add-notification-of-bus-events.patch
+gregkh-driver-driver-link-sysfs-timing.patch
+gregkh-driver-cleanup-virtual_device_parent.patch
+gregkh-driver-config_sysfs_deprecated.patch
+gregkh-driver-udev-compatible-hack.patch
+gregkh-driver-config_sysfs_deprecated-bus.patch
+gregkh-driver-config_sysfs_deprecated-device.patch
+gregkh-driver-config_sysfs_deprecated-PHYSDEV.patch
+gregkh-driver-config_sysfs_deprecated-class.patch
+gregkh-driver-vt-device.patch
+gregkh-driver-vc-device.patch
+gregkh-driver-misc-devices.patch
+gregkh-driver-tty-device.patch
+gregkh-driver-raw-device.patch
+gregkh-driver-i2c-dev-device.patch
+gregkh-driver-msr-device.patch
+gregkh-driver-cpuid-device.patch
+gregkh-driver-ppp-device.patch
+gregkh-driver-ppdev-device.patch
+gregkh-driver-mmc-device.patch
+gregkh-driver-firmware-device.patch
+gregkh-driver-fb-device.patch
+gregkh-driver-mem-devices.patch
+gregkh-driver-sound-device.patch
+gregkh-driver-network-device.patch
+gregkh-driver-put_device-might_sleep.patch
+gregkh-driver-sysfs-crash-debugging.patch
+gregkh-driver-kobject-warn.patch
+gregkh-driver-warn-when-statically-allocated-kobjects-are-used.patch
+gregkh-driver-uio.patch
+gregkh-driver-nozomi.patch

 Bring back the driver tree

+nozomi-warning-fixes.patch
+nozomi-irq-flags-fixes.patch
+call-platform_notify_remove-later.patch
+update-uio_interrupt.patch

 Fixes thereto

+dvb-dibx000_common-fix.patch

 DVB fix

+ps-2-driver-update-for-fujitsu-4-wire-touchscreen-on-hitachi-tablets.patch
+lifebook-learn-about-tabs.patch

 Input driver fixes

+via-pata-controller-xfer-fixes-fix.patch

 Fix via-pata-controller-xfer-fixes.patch

-nfs-fix-nfs_readpages-error-path.patch

 Dropped, unneeded

+auth_gss-unregister-gss_domain-when-unloading-module-fix.patch

 NFS fix

+pci-device-ensure-sysdata-initialised-v2.patch

 Fix for git-pciseg.patch

-x86_64-mm-i386-reloc-abssym.patch
-x86_64-mm-i386-reloc-cleanup-align.patch

 I suspect I droped these by accident - the x86_64 tree is a bit of a mess.

+x86_64-mm-paravirt-cpu-detect.patch
+x86_64-mm-clear-irq-vector.patch
+x86_64-mm-io-apic-reuse.patch

 x86_64 tree additions

-x86_64-irq-reuse-vector-for-__assign_irq_vector.patch

 Not sure where this went - the x86_64 tree is a bit of a mess.

-prep-for-paravirt-cpu_detect-extraction.patch

 I might have dropped this by accident too.

+paravirtualization-header-and-stubs-for.patch
+paravirtualization-patch-inline-replacements-for.patch
+paravirtualization-patch-inline-replacements-for-fix.patch
+paravirtualization-more-generic-paravirtualization.patch
+paravirtualization-allow-selected-bug-checks-to-be.patch
+paravirtualization-allow-disabling-legacy-power.patch
+paravirtualization-add-apic-accessors-to-paravirt-ops.patch
+paravirtualization-add-apic-accessors-to-paravirt-ops-tidy.patch
+paravirtualization-add-mmu-virtualization-to.patch

 hypervisor stuff

-make-x86_64-udelay-round-up-instead-of-down.patch
-i386-x86_64-comment-magic-constants-in-delayh.patch

 Dropped.

+mm-arch-do_page_fault-vs-in_atomic.patch
+mm-pagefault_disableenable.patch
+mm-kummap_atomic-vs-in_atomic.patch

 MM updates

+swsusp-freeze-filesystems-during-suspend-rev-2.patch
+swsusp-freeze-filesystems-during-suspend-rev-2-comments.patch
+swsusp-use-platform-mode-by-default.patch

 swsusp updates

+drivers-add-lcd-support-update-5.patch
+drivers-add-lcd-support-update6.patch

 LCD driver updates

+taskstats-cleanup-do_exit-path.patch
+taskstats-cleanup-signal-stats-allocation.patch
+taskstats-factor-out-reply-assembling.patch
+taskstats-use-nla_reserve-for-reply-assembling.patch

 taskstats cleanups and tweaks

+aio-use-prepare_to_wait.patch
+exar-quad-port-serial.patch
+exar-quad-port-serial-fix.patch
+fs-trivial-vsnprintf-conversion.patch
+hpfs-bring-hpfs_error-into-shape.patch
+drivers-cdrom-trivial-vsnprintf-conversion.patch
+vfs-extra-check-inside-dentry_unhash.patch
+correct-misc_register-return-code-handling-in-several-drivers.patch
+more-list-debugging-context.patch

 Misc

+log2-implement-a-general-integer-log2-facility-in-the-kernel-ppc-fix.patch

 build fix

+tty-switch-to-ktermios-nozomi-fix.patch

 Bring this back

+drivers-isdn-trivial-vsnprintf-conversion.patch

 ISDN cleanup

+patch-for-nvidia-divide-by-zero-error-for-7600.patch
+radeonfb-support-24bpp-32bpp-minus-alpha.patch
+pmagb-b-fb-fix-a-default-clock.patch
+video-get-the-default-mode-from-the-right-database.patch
+s3c2410fb-add-support-for-stn-displays.patch
+fbcmapc-mark-structs-const-or.patch
+various-fbdev-files-mark-structs.patch
+constify-and-annotate-__read_mostly.patch
+annotate-some-variables-in-vesafb.patch
+constify-vga16fbc.patch
+au1100fb-fix-to-remove-flickering.patch
+mbxfb-fix-hscoeff3-register-address.patch
+mbxfb-add-more-registers-bits.patch
+mbxfb-add-more-registers-to-debugfs.patch
+mbxfb-add-yuv-video-overlay-support.patch
+mbxfb-document-the-new-ioctl.patch
+atyfb-remove-fixme.patch
+atyfb-fix-compiler-warnings.patch
+atyfb-fix-sparse-warnings.patch
+atyfb-fix-blanking-level.patch
+atyfb-remove-pointless-aty_init.patch
+atyfb-fix-__init-and-__devinit.patch
+atyfb-remove-aty_cmap_regs.patch
+atyfb-improve-atyfb_atari_probe.patch
+atyfb-improve-power-management.patch

 fbdev updates
+highres-timer-core-fix-status-check.patch
+highres-timer-core-fix-commandline-setup.patch
+clockevents-smp-on-up-features.patch
+highres-depend-on-clockevents.patch
+i386-apic-cleanup.patch
+pm-timer-allow-early-access.patch
+i386-lapic-timer-calibration.patch
+clockevents-add-broadcast-support.patch
+acpi-include-apic-h.patch
+acpi-keep-track-of-timer-broadcast.patch
+i386-apic-timer-use-clockevents-broadcast.patch
+acpi-verify-lapic-timer.patch
+acpi-verify-lapic-timer-exports.patch

 Attempt to make the hrtimer code work on my laptop (I forgot to test it).

+kevent_user_wait-retval-fix.patch

 kevent fixlet.



All 1113 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc4/2.6.19-rc4-mm2/patch-list


