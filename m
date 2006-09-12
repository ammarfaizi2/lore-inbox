Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbWILHGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWILHGX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 03:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWILHGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 03:06:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64418 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751379AbWILHGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 03:06:22 -0400
Date: Tue, 12 Sep 2006 00:06:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc6-mm2
Message-Id: <20060912000618.a2e2afc0.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm2/

- autofs4 mounting remains busted.

- CONFIG_BLOCK=n doesn't (quite) work.  Will fix later.

- CONFIG_MSI=y is probably broken - try disabling it before reporting
  interrupt-related oopses.  Then please report it whether or not that fixed
  it.

- Could I point out the fifth bullet-point in the "Boilerplate" section,
  below?

- git-cryptodev.patch is dropped due to my continuing inability to pull a
  clean git diff (there is hope, but more work is needed)

  - Ditto git-sas.patch

  - And git-audit-master.patch (I think).

  Things will improve around the 2.6.19-rc1 timeframe.

- 1,915 patches breaks the previous record by ~200.

- This kernel includes the patch to sort the PCI devices breadth-first. 
  This might cause strange things to happen (particular devices get assigned
  to different /dev nodes, for example).  If this is suspected, please try
  reverting gregkh-pci-pci-sort-device-lists-breadth-first.patch then send a
  report.



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




Changes since 2.6.18-rc6-mm1:


 origin.patch
 git-acpi.patch
 git-alsa.patch
 git-agpgart.patch
 git-block.patch
 git-cifs.patch
 git-cpufreq.patch
 git-drm.patch
 git-dvb.patch
 git-geode.patch
 git-gfs2.patch
 git-ia64.patch
 git-ieee1394.patch
 git-infiniband.patch
 git-input.patch
 git-intelfb.patch
 git-kbuild.patch
 git-libata-all.patch
 git-lxdialog.patch
 git-mtd.patch
 git-netdev-all.patch
 git-net.patch
 git-nfs.patch
 git-ocfs2.patch
 git-parisc.patch
 git-pcmcia.patch
 git-powerpc.patch
 git-r8169.patch
 git-s390.patch
 git-scsi-misc.patch
 git-scsi-rc-fixes.patch
 git-scsi-target.patch
 git-watchdog.patch
 git-xfs.patch

 git trees

-use-the-correct-restart-option-for-futex_lock_pi.patch
-optical-proc-ide-media.patch
-sh-fix-fpn_start-typo.patch
-sis5513-add-sis-south-bridge-id-0x966.patch
-ext3_getblk-should-handle-hole-correctly.patch
-invalidate_complete_page-race-fix.patch
-nfs-large-non-page-aligned-direct-i-o-clobbers-memory.patch
-input-i8042-get-rid-of-polling-timer.patch
-asus-mv-device-ids.patch
-gregkh-usb-usb-hid-core.c-fix-duplicate-usb_device_id_gtco_404.patch
-gregkh-usb-usb-support-for-usb20svga-wh-usb20svga-dg.patch
-gregkh-usb-usb-new-device-id-for-ftdi_sio-usb-serial-driver.patch
-gregkh-usb-usb-usbtouchscreen-fix-itm-data-reading.patch
-gregkh-usb-usb-must_check-fixes.patch
-x86_64-mm-module-locks-raw-spinlock.patch

 Merged into mainline or a subsystem tree.

+libata-ignore-cfa-signature-while-sanity-checking-an-atapi-device.patch
+lockdep-double-the-number-of-stack-trace-entries.patch
+we-can-not-allow-anonymous-contributions-to-the-kernel.patch
+alim15x3c-m5229-rev-c8-support-for-dma-cd-writer.patch
+scsi-lockdep-annotation-in-scsi_send_eh_cmnd.patch
+rcu_do_batch-make-qlen-decrement-irq-safe.patch
+x86-reserve-a-boot-loader-id-number-for-xen.patch
+headers_check-improve-include-regexp.patch
+headers_check-clarify-error-message.patch
+headers_check-reduce-user-visible-noise-in-linux-nfs_fsh.patch
+headers_check-remove-asm-timexh-from-user-export.patch
+headers_check-move-inclusion-of-linux-linkageh-in.patch
+headers_check-move-kernel-only-includes-within-asm-i386-elfh.patch
+headers_check-dont-expose-pfn-stuff-to-userspace-in.patch
+headers_check-fix-userspace-build-of-asm-mips-pageh.patch
+cciss-version-update-new-hw.patch

 2.6.18 queue (already sent to Linus)

+usbserial-reference-leak.patch

 USB fix (probably for 2.6.18)

+jbd-fix-commit-of-ordered-data-buffers.patch

 JBD fix (for 2.6.19 and 2.6.18.x)

+fix-incorrect-handling-of-pci-express-root-bridge-_hid.patch

 PCI fix

+maintainers-updates-to-ieee-1394-subsystem.patch

 1394 maintainers update

+revert-libata-ignore-cfa-signature-while-sanity-checking-an-atapi-device.patch

 Make git-libata-all.patch apply.

+redo-libata-ignore-cfa-signature-while-sanity-checking-an-atapi-device.patch

 Reapply this fix after git-libata-all.patch.

+git-libata-all-ata_piix-build-fix.patch

 Fix git-libata-all.patch.

+rtnetlink-fix-netdevice-name-corruption.patch

 Fix the net-device-names-go-bad bug.

+gregkh-pci-pci-sort-device-lists-breadth-first.patch

 PCI tree update.

+gregkh-usb-usb-ub-let-cdrecord-to-see-a-device-with-media-absent.patch
+gregkh-usb-usb-core-must_check.patch
+gregkh-usb-usb-misc-must_check.patch
+gregkh-usb-usb-atm-must_check.patch
+gregkh-usb-usb-class-must_check.patch
+gregkh-usb-usb-input-must_check.patch
+gregkh-usb-usb-host-must_check.patch
+gregkh-usb-usb-serial-must_check-fixes.patch

 USB tree updates.

+watchdog-use-enotty-instead-of-enoioctlcmd-in-ioctl.patch

 Watchdog driver fixes.

+hostap_cs-added-support-for-proxim-harmony-pci-w-lan.patch

 Wireless device support.

+x86_64-mm-lockdep-stacktrace-no-recursion.patch
+x86_64-mm-compat-pselect-must-check.patch
+x86_64-mm-compat-uname-must-check.patch
+x86_64-mm-pda-noreturn.patch
+x86_64-mm-fix-idle-notifiers.patch
+x86_64-mm-pci-probe-type1-first.patch
+x86_64-mm-i386-acpi-mcfg-check.patch
+x86_64-mm-acpi-mcfg-check.patch
+x86_64-mm-remove-mcfg-dmi.patch
+x86_64-mm-insert-gart-region-into-resource-map.patch
+x86_64-mm-mcfg-resource.patch
+x86_64-mm-i386-mcfg-resource.patch
+x86_64-mm-i386-pack-descriptor.patch
+x86_64-mm-i386-multiline-oops.patch

 x86_64 tree updates.

+xfs-rename-uio_read.patch

 Rename a function in XFS to avoid a clash.

+numa-add-zone_to_nid-function-update.patch

 Improve numa-add-zone_to_nid-function.patch

+vm-add-per-zone-writeout-counter.patch

 Add new counter to /proc/vmstat: counts number of pages written out via the
 vm scanner.

+own-header-file-for-struct-page.patch
+convert-s390-page-handling-macros-to-functions.patch
+convert-s390-page-handling-macros-to-functions-fix.patch

 MM header file cleanups.

+frv-improve-frvs-use-of-generic-irq-handling.patch
+frv-permit-__do_irq-to-be-dispensed-with.patch

 FRV update.

+avr32-rename-at32stk100x-atstk100x.patch

 AVR32 update

+nommu-move-the-fallback-arch_vma_name-to-a-sensible-place-fix.patch

 Fix nommu-move-the-fallback-arch_vma_name-to-a-sensible-place.patch

+uml-tty-locking.patch

 TTY locking fix

-lockdep-core-add-enable-disable_irq_irqsave-irqrestore-apis-frv-fix.patch

 Folded into
 lockdep-core-add-enable-disable_irq_irqsave-irqrestore-apis.patch (I think)

+linux-kernel-dump-test-module-fixes.patch

 Fix linux-kernel-dump-test-module.patch

+ext3-more-whitespace-cleanups.patch
+ext3-fix-sparse-warnings.patch
+submittingpatches-add-a-note-about-format=flowed-when-sending-patches.patch
+kmemdup-introduce.patch
+kmemdup-some-users.patch
+linux-magich-for-magic-numbers.patch
+linux-magich-for-magic-numbers-sparc-fix.patch
+cpuset-fix-obscure-attach_task-vs-exiting-race.patch
+create-fs-utimesc.patch
+cciss-support-for-2tb-logical-volumes.patch

 Misc updates.

+add-genetlink-utilities-for-payload-length-calculation.patch
+fix-taskstats-size-calculation-use-the-new-genetlink-utility-functions.patch
+fix-getdelaysc-cpumask-length-and-error-reporting.patch

 taskstats fixes for the Comprehensive System Accounting patches in -mm.

-vt-update-spawnpid-to-be-a-struct-pid_t.patch
-vt-update-spawnpid-to-be-a-struct-pid_t-tidy.patch
+vt-rework-the-console-spawning-variables.patch
+vt-make-vt_pid-a-struct-pid-making-it-pid-wrap-around-safe.patch

 Updated.

+update-mq_notify-to-use-a-struct-pid.patch
+file-add-locking-to-f_getown.patch
+usb-fixup-usb-so-it-uses-struct-pid.patch

 More pid management updates.

+proc-convert-task_sig-to-use-lock_task_sighand.patch
+proc-convert-do_task_stat-to-use-lock_task_sighand.patch
+proc-drop-tasklist-lock-in-task_state.patch
+proc-properly-compute-tgid_offset.patch
+proc-remove-trailing-blank-entry-from-pid_entry-arrays.patch
+proc-remove-the-useless-smp-safe-comments-from-proc.patch
+proc-comment-what-proc_fill_cache-does.patch
+introduce-get_task_pid-to-fix-unsafe-get_pid.patch

 More /porc core updates.

+allow-ide_generic_all-to-be-used-modular-and-built-in.patch

 IDE fix.

+savagefb-use-generic-ddc-reading-fix.patch

 Fix savagefb-use-generic-ddc-reading.patch

+rcu-simplify-improve-batch-tuning.patch

 RCU tuneup.

+pr_debug-aio-use-size_t-length-modifier-in-pr_debug-format-arguments.patch
+pr_debug-configfs-use-size_t-length-modifier-in-pr_debug-format-argument.patch
+pr_debug-sysfs-use-size_t-length-modifier-in-pr_debug-format-arguments.patch
+pr_debug-umem-repair-nonexistant-bh-pr_debug-reference.patch
+pr_debug-tipar-repair-nonexistant-pr_debug-argument-use.patch
+pr_debug-dell_rbu-fix-pr_debug-argument-warnings.patch
+pr_debug-ifb-replace-missing-comma-to-separate-pr_debug-arguments.patch
+pr_debug-trident-use-size_t-length-modifier-in-pr_debug-format-arguments.patch
+pr_debug-check-pr_debug-arguments.patch
+isdn-debug-build-fix.patch
+isdn-more-pr_debug-fixes.patch

 Make pr_debug() check its arguments even if !defined(DEBUG).  Plus fixes
 arising from this.




All 1915 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm2/patch-list


