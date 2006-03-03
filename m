Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWCCM6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWCCM6P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 07:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWCCM6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 07:58:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:952 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751330AbWCCM6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 07:58:14 -0500
Date: Fri, 3 Mar 2006 04:56:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc5-mm2
Message-Id: <20060303045651.1f3b55ec.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/


- Should be a bit better than 2.6.16-rc5-mm1, but I still had to fix a ton
  of things to get this to compile and boot.  We're not being careful enough.

- The procfs rework is getting there, but some problems probably still remain.

- There will be a number of new warnings at boot time when initcalls fail. 
  Generally that's OK: it usually indicates that you linked something into
  vmlinux which you're not actually using.  But sometimes it can indicate
  kernel bugs.

- The (much-shrunk) audit git tree is back.



Boilerplate:

- See the `hot-fixes' directory for any important updates to this patchset.

- To fetch an -mm tree using git, use (for example)

  git fetch git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git v2.6.16-rc2-mm1

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



Changes since 2.6.16-rc5-mm1:


 linus.patch
 git-acpi.patch
 git-agpgart.patch
 git-alsa.patch
 git-audit-master.patch
 git-blktrace.patch
 git-cfq.patch
 git-cifs.patch
 git-cpufreq.patch
 git-drm.patch
 git-dvb.patch
 git-ia64.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-input.patch
 git-jfs.patch
 git-kbuild.patch
 git-libata-all.patch
 git-netdev-all.patch
 git-net.patch
 git-nfs.patch
 git-ocfs2.patch
 git-powerpc.patch
 git-sym2.patch
 git-pcmcia.patch
 git-scsi-misc.patch
 git-sas-jg.patch
 git-sparc64.patch
 git-watchdog.patch
 git-xfs.patch
 git-cryptodev.patch
 git-viro-bird-m32r.patch
 git-viro-bird-m68k.patch
 git-viro-bird-xfs.patch
 git-viro-bird-uml.patch
 git-viro-bird-frv.patch
 git-viro-bird-misc.patch
 git-viro-bird-upf.patch
 git-viro-bird-volatile.patch

 git trees

+git-audit-fixes.patch
+git-audit-master-build-fix.patch
+git-infiniband-build-fix.patch
+git-net-vs-remove-module_parm.patch

 Fix things in them.

-move-pci_dev_put-outside-a-spinlock.patch
-x86-microcode-driver-vs-hotplug-cpus.patch
-x86-microcode-driver-vs-hotplug-cpus-fix.patch
-fix-sys_migrate_pages-move-all-pages-when-invoked-from-root.patch
-powerpc-vdso-64bits-gettimeofday-bug.patch
-fuse-fix-bug-in-negative-lookup.patch
-s390-multiple-subchannel-sets-support-fix.patch
-drives-mtd-redbootc-recognise-a-foreign-byte-sex-partition-table.patch
-altix-more-ioc3-cleanups.patch
-pnp-bus-type-fix.patch
-video1394-fix-return-e-typo.patch
-tty-buffering-comment-out-debug-code.patch
-remove_from_swap-fix-locking.patch
-nommu-implement-vmalloc_node.patch
-mips-only-include-iomap-on-systems-with-pci.patch
-add-mm-task_size-and-fix-powerpc-vdso.patch
-let-ipw21200-select-ieee80211.patch
-ipw2200-restrict-wep-fix.patch
-via-velocity-massive-memory-corruption-with-jumbo-frames.patch
-git-net-fixup.patch
-git-pcmcia-bt3c_cs-fix.patch
-add-support-for-possio-gcc-aka-pcmcia-siemens-mc45.patch
-axnet_cs-support-amb8110.patch
-git-scsi-rc-fixes-fixup.patch
-gregkh-usb-usb-unusual_devs-entry-for-lyra-rca-rd1080.patch
-gregkh-usb-usb-lh7a40x-gadget-driver-fixed-a-dead-lock.patch
-gregkh-usb-usb-gadget-rndis-fix-alloc-bug.patch
-gregkh-usb-usb-fix-masking-bug-initialization-of-freescale-ehci-controller.patch
-gregkh-usb-usb-visor.c-id-for-gspda-smartphone.patch
-x86_64-fix-string-fix.patch
-usb-fix-ehci-bios-handshake.patch
-time_interpolator-use-readq_relaxed-instead-of-readq.patch

 Merged

+powerpc-restore-eeh_add_device_late-prototype.patch

 powerpc fix

+serial-core-work-around-sub-driver-bugs.patch

 serial driver bug avoidance

+i386-port-ati-timer-fix-from-x86_64-to-i386-ii.patch
+i386-port-ati-timer-fix-from-x86_64-to-i386-ii-fixes.patch

 ATI timer fix for x86

+cramfs-mounts-provide-corrupted-content-since-2615.patch

 cramfs fix

+i4l-add-new-pci-ids-for-hfc-s-pci.patch
+i4l-fix-refcounting-problem-with-ttyix-devices.patch
+i4l-fix-compatiblity-issue-with-big-endian-systems.patch

 i4l fixes

+x86-fix-potential-jiffies-overflow-in-timer_resume.patch

 timer resume fix

+acpi-remove-__init-__exit-from-asus-add-remove-methods.patch
+serial-remove-8250_acpi-replaced-by-8250_pnp-and-pnpacpi.patch
+acpi-remove-__init-__exit-from-sony-add-remove-methods.patch

 ACPi fixes

+revert-gregkh-driver-fix-up-the-sysfs-pollable-patch.patch
+revert-gregkh-driver-allow-sysfs-attribute-files-to-be-pollable.patch

 Drop a few driver tree patches

+sysfs_h-cleanup.patch

 cleanup

+get_cpu_sysdev-signedness-fix.patch
+topologyc-tweaks.patch
+cpuc-section-fixes.patch

 Various little fixes

+ia64-update-hp-csr-space-discovery-via-acpi.patch

 ia64 fix

+nfs-permit-filesystem-to-override-root-dentry-on-mount.patch
+nfs-apply-mount-root-dentry-override-to-filesystems.patch
+nfs-apply-mount-root-dentry-override-to-filesystems-v9fs-fix.patch
+nfs-abstract-out-namespace-initialisation.patch
+nfs-add-dentry-materialisation-op.patch
+nfs-unify-nfs-superblocks-per-protocol-per-server.patch
+nfs-unify-nfs-superblocks-per-protocol-per-server-fix.patch

 Share nfs superblocks between mounts from the same server.

+powerpc-fix-pud_error-message.patch

 powerpc fixlet

+gregkh-usb-usb-fix-masking-bug-initialization-of-freescale-ehci-controller.patch
+gregkh-usb-usb-kzalloc-conversion-for-rest-of-drivers-usb.patch
+gregkh-usb-usb-kzalloc-conversion-in-drivers-usb-gadget.patch
+gregkh-usb-usb-sn9c10x-driver-updates.patch
+gregkh-usb-usb-et61x51-driver-updates.patch
+gregkh-usb-usb-zc0301-driver-updates-2.patch
+gregkh-usb-cypress_m8-add-support-for-the-nokia-ca42-version-2-cable.patch
+gregkh-usb-usb-pl2303-and-tiocmiwait.patch
+gregkh-usb-usb-support-for-usb-to-serial-cable-from-speed-dragon-multimedia.patch
+gregkh-usb-usb-uhci-increase-port-reset-completion-delay-for-hp-controllers.patch
+gregkh-usb-omninet_debug.patch

 USB tree updates

+gregkh-usb-usbfs2-vs-nfs-apply-mount-root-dentry-override-to-filesystems.patch

 Fix usbfs for the NFS patches

+x86_64-mm-blk-bounce.patch
+x86_64-mm-floppy-dma.patch
+x86_64-mm-iommu-noretry.patch
+x86_64-mm-disable-8254-timer-by-default.patch
+x86_64-mm-basic-reorder-infrastructure.patch
+x86_64-mm-microcode-quiet.patch

 x86_64 tree updates

+x86_64-mm-blk-bounce-ia64-fix.patch

 Fix it.

+hugepage-strict-page-reservation-for-hugepage-inodes-fix.patch
+hugepage-make-allocfree_huge_page-local.patch
+hugepage-fix-hugepage-logic-in-free_pgtables.patch
+hugepage-fix-hugepage-logic-in-free_pgtables-harder.patch

 hugetlbpage fixes

+mm-implement-swap-prefetching-fix.patch

 Fix mm-implement-swap-prefetching.patch

+powerpc-tidy-up-of_register_driver-driver_register-return-values.patch
+macintosh-tidy-up-driver_register-return-values.patch

 powerpc fixes

+remove-entries-in-sys-firmware-acpi-for-processor-also.patch
+remove-unnecessary-lapic-definition-from-acpidefh.patch
+support-physical-cpu-hotplug-for-x86_64.patch
+support-physical-cpu-hotplug-for-x86_64-fix-2.patch
+patch-to-limit-present-cpus-to-fake-cpu-hot-add-testing.patch
+enable-sci_emulate-to-manually-simulate-physical-hotplug-testing.patch

 x86_64 CPU hotplug

-x86_64-clean-up-timer-messages.patch

 Dropped

+add-s2ram-pointer-to-suspend-documentation.patch

 Docs

+strndup_user.patch
+strndup_user-convert-module.patch
+strndup_user-convert-keyctl.patch

 Add and use strndup_user().

-keys-deal-properly-with-strnlen_user.patch

 No longer needed

+reiserfs-handle-trans_id-overflow.patch
+reiserfs-reiserfs_file_write-will-lose-error-code-when-a-0-length-write-occurs-w-o_sync.patch
+reiserfs-use-balance_dirty_pages_ratelimited_nr-in-reiserfs_file_write.patch
+reiserfs-fix-unaligned-bitmap-usage.patch

 reiserfs3 fixes

+inotify-lock-avoidance-with-parent-watch-status-in-dentry-fix-2.patch

 Fix inotify-lock-avoidance-with-parent-watch-status-in-dentry.patch

+reiserfs-cleanups.patch

 reiserfs cleanup

+initcall-failure-reporting.patch

 Print warning when an initcall fails

+hp300-fix-driver_register-return-handling-remove-dio_module_init.patch
+eisa-tidy-up-driver_register-return-value.patch
+amiga-fix-driver_register-return-handling-remove-zorro_module_init.patch

 Fix driver_register() return value handling

+change-buffer_headb_size-to-size_t.patch
+pass-b_size-to-get_block.patch
+pass-b_size-to-get_block-speedup.patch
+pass-b_size-to-get_block-remove-unneeded-assignments.patch
+map-multiple-blocks-for-mpage_readpages.patch
+map-multiple-blocks-for-mpage_readpages-tidy.patch
+remove-get_blocks-support.patch

 Extend the filesystem get_block() callback, use it in mpage_readpages().

+fix-next_timer_interrupt-for-hrtimer.patch

 hrtimer fix

+x86-kprobes-booster-fix.patch

 Fix x86-kprobes-booster.patch

+kprobe-handler-discard-user-space-trap-fix.patch

 Fix kprobe-handler-discard-user-space-trap.patch

+edac-switch-to-kthread_-api.patch
+edac-switch-to-kthread_-api-tidy.patch
+edac-printk-cleanup.patch
+edac-name-cleanup-remove-old-bluesmoke-stuff.patch
+edac-amd76x-pci_dev_get-pci_dev_put-fixes.patch
+edac-e752x-cleanup.patch
+edac-i82860-cleanup.patch
+edac-i82875p-cleanup.patch
+edac-fix-minor-logic-bug-in-e7xxx_remove_one.patch
+edac-cleanup-code-for-clearing-initial-errors.patch
+edac-edac_mc_add_mc-fix-1.patch
+edac-edac_mc_add_mc-fix-2.patch
+edac-fix-usage-of-kobject_init-kobject_put.patch
+edac-kobject-sysfs-fixes.patch
+edac-protect-memory-controller-list.patch
+edac-kconfig-dependency-changes.patch
+edac-kconfig-dependency-changes-fix.patch

 EDAC driver updates

+sched-fix-task-interactivity-calculation.patch

 CPU scheduler fix

-asfs-filesystem-driver.patch
-fs-asfs-make-code-static.patch

 Dropped - I haven't heard from the developer in nearly a year and it doesn't
 seem terribly important.

+lightweight-robust-futexes-arch-defaults-fix.patch

 Fix lightweight-robust-futexes-arch-defaults.patch

-proc-dont-lock-task_structs-indefinitely-cpuset-fix.patch
+proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
+proc-dont-lock-task_structs-indefinitely-mem_read-fix.patch
+proc-dont-lock-task_structs-indefinitely-task_mmu-bug-fix.patch
+proc-use-sane-permission-checks-on-the-proc-pid-fd.patch
+proc-use-sane-permission-checks-on-the-proc-pid-fd-fix.patch
+proc-use-sane-permission-checks-on-the-proc-pid-fd-fix-2.patch

 Various fixes to the /proc rework patches

+pnp-parport-adjust-pnp_register_driver-signature.patch
+pnp-mpu401-adjust-pnp_register_driver-signature.patch
+pnp-cs4236-adjust-pnp_register_driver-signature.patch
+pnp-opl3sa2-adjust-pnp_register_driver-signature.patch
+pnp-ns558-adjust-pnp_register_driver-signature.patch
+pnp-i8042-adjust-pnp_register_driver-signature.patch
+pnp-irda-adjust-pnp_register_driver-signature.patch
+pnp-cs4232-adjust-pnp_register_driver-signature.patch
+pnp-pnp-adjust-pnp_register_driver-signature.patch

 pnp drver updates

+reiser4-vs-nfs-apply-mount-root-dentry-override-to-filesystems.patch

 Update reiser4 for the NFS patches

-fbdev-framebuffer-driver-for-geode-gx-Kconfig-fix.patch
+fbdev-framebuffer-driver-for-geode-gx-kconfig-fix-2.patch

 New version




All 1346 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/patch-list


