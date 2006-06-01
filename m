Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWFAInv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWFAInv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 04:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWFAInv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 04:43:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10425 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932076AbWFAInt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 04:43:49 -0400
Date: Thu, 1 Jun 2006 01:48:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-rc5-mm2
Message-Id: <20060601014806.e86b3cc0.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm2/


- A cfq bug was fixed in mainline, so the git-cfq tree has been restored.

- Various lock-validator and genirq fixes have been added.  Should be
  slightly less oopsy than 2.6.17-rc5-mm1.

- I just realised that I've been accidentally not updating the PCI tree for
  a while.  Will be restored in next -mm.

- Has been booted and has passed various stress-tests on quad x86_64,
  quad ancient-Xeon, quad power4, quad ia64, dual old-PIII and a modern
  pentium-M laptop.  So if it breaks, it's your fault.




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



Changes since 2.6.17-rc5-mm1:


 origin.patch
 git-acpi.patch
 git-agpgart.patch
 git-alsa.patch
 git-audit-master.patch
 git-block.patch
 git-cfq.patch
 git-cifs.patch
 git-cpufreq.patch
 git-dvb.patch
 git-gfs2.patch
 git-ia64.patch
 git-infiniband.patch
 git-intelfb.patch
 git-klibc.patch
 git-hdrcleanup.patch
 git-hdrinstall.patch
 git-libata-all.patch
 git-mips.patch
 git-mtd.patch
 git-netdev-all.patch
 git-net.patch
 git-nfs.patch
 git-powerpc.patch
 git-rbtree.patch
 git-sas.patch
 git-pcmcia.patch
 git-scsi-rc-fixes.patch
 git-scsi-target.patch
 git-supertrak.patch
 git-watchdog.patch
 git-cryptodev.patch

 got trees

-ext3-resize-fix-double-unlock_super.patch
-fbcon-fix-scrollback-with-logo-issue-immediately-after-boot.patch
-spanned_pages-is-not-updated-at-a-case-of-memory-hot-add.patch
-tpm-bios-log-parsing-fixes.patch
-tpm-more-bios-log-parsing-fixes.patch
-tpm-more-bios-log-parsing-fixes-tidy.patch
-ipmi-reserve-i-o-ports-separately.patch
-revert-swsusp-add-check-for-suspension-of-x-controlled-devices.patch
-hrtimer-export-symbols.patch
-scsi-properly-count-the-number-of-pages-in-scsi_req_map_sg.patch
-x86_64-fix-stack-mmap-randomization-for-compat.patch
-x86_64-fix-no-iommu-warning-in-pci-gart-driver.patch
-i386-apic=-command-line-option-should-always-be.patch
-x86_64-fix-last_tsc-calculation-of-pm-timer.patch
-x86_64-handle-empty-node-zero.patch
-x86_64-fix-off-by-one-in-bad_addr-checking-in.patch
-x86_64-dont-do-syscall-exit-tracing-twice.patch
-powerpc-fix-boot-on-emac.patch
-au1100fb-fix-compilation.patch
-maxinefb-fix-compilation-error.patch
-sgiioc4-use-mmio-ops-instead-of-port-io.patch
-md-fix-badness-in-sysfs_notify-caused-by-md_new_event.patch
-firmware_class-s-semaphores-mutexes.patch
-fix-mem-leak-in-sidewinder-driver.patch
-git-mtd-ya-build-fix.patch
-pcmcia-irq-debugging.patch
-ti-pcixx12-cardbus-controller-support.patch
-pcmcia-missing-pcmcia_get_socket-result-check.patch
-imm-no-need-for-unchecked_isa_dma.patch
-git-scsi-target-fixup.patch
-usb-gadget-update-inodec-to-support-full-speed-only.patch
-usb-gadget-update-pxa2xx_udcc-and-arch-dependent-files.patch
-usb-gadget-update-pxa2xx_udcc-driver-to-fully-support.patch
-usb-gadget-clean-udch.patch
-usb-gadget-dont-build-small-version-if-usbgadgetfs.patch
-driver-for-apple-cinema-display.patch
-driver-for-apple-cinema-display-tweaks.patch
-usb-wifi-zd1201-cleanups.patch
-x86_64-mm-acpi-blacklist-xw9300.patch
-fix-x86_64-mm-reliable-stack-trace-support-i386-entrys.patch
-x86_64-mm-reliable-stack-trace-support-non-x86-fix.patch
-x86_64-mm-reliable-stack-trace-support-non-x86-fix-fix.patch

 Merged into mainline or a subsystem tree

+nmclan_cs-dereferencing-skb-after-netif_rx.patch
+s390-irb-memcpy-argument-swap.patch
+s390-cio-non-unique-path-group-ids.patch
+nbd-endian-annotations.patch
+sparsemem-build-fix.patch
+selinux-fix-sb_lock-sb_security_lock-nesting-was.patch

 2.6.17 queue.

+s390-cleanup-bitopsh.patch

 s390 cleanup

+blktrace_apih-endian-annotations.patch

 Add endianness annotations.

+cifs-build-fix.patch
+git-cifs-kconfig-fix.patch

 The CIFS tree was updated.  Fix it.

+git-cpufreq-fixup.patch

 Fix reject in git-cpufreq.patch

+gregkh-driver-firmware_class-s-semaphores-mutexes.patch

 Driver tree update

+input-move-fixp-arithh-to-drivers-input.patch
+input-fix-accuracy-of-fixp-arithh.patch
+input-new-force-feedback-interface.patch
+input-new-force-feedback-interface-fix.patch
+input-adapt-hid-force-feedback-drivers-for-the-new-interface.patch
+input-adapt-uinput-for-the-new-force-feedback-interface.patch
+input-adapt-iforce-driver-for-the-new-force-feedback-interface.patch
+input-force-feedback-driver-for-pid-devices.patch
+input-force-feedback-driver-for-zeroplus-devices.patch
+input-update-documentation-of-force-feedback.patch
+input-drop-the-remains-of-the-old-ff-interface.patch
+input-drop-the-old-pid-driver.patch
+input-use-enospc-instead-of-enomem-in-iforce-when-device-full.patch

 Input layer rework, force-feedback driver enhancements.

+libata-add-missing-data_xfer-for-pata_pdc2027x-and-pdc_adma.patch

 Fix git-libata-all.patch.

+pppoe-missing-result-check-in-__pppoe_xmit.patch

 pppoe fix

+pmf_register_irq_client-gives-sleep-with-locks-held-warning.patch

 Powermac driver fix

+pci-dont-move-ioapics-below-pci-bridge.patch

 io-apic handling fix

+scsi-properly-count-the-number-of-pages-in-scsi_req_map_sg-fix.patch

 Fix akpm screwup.

+gregkh-usb-usb-new-cp2101-device.patch
+gregkh-usb-gadgetfs-fix-aio-interface-bugs.patch
+gregkh-usb-gadgetfs-fix-memory-leaks.patch
+gregkh-usb-usbtest-report-errors-in-iso-tests.patch
+gregkh-usb-usb-io_edgeport-cleanup-to-unicode-handling.patch
+gregkh-usb-usb-serial-encapsulate-schedule_work-remove-double-calling.patch
+gregkh-usb-usb-improve-kconfig-comment-for-mct_u232.patch
+gregkh-usb-usb-syntax-cleanup-for-pl2303.patch
+gregkh-usb-usb-storage-get-rid-of-the-timer-during-urb-submission.patch
+gregkh-usb-improved-tt-scheduling-for-ehci.patch
+gregkh-usb-usb-rmmod-pl2303-after-28.patch
+gregkh-usb-ub-atomic-add_disk.patch
+gregkh-usb-ub-random-cleanups.patch
+gregkh-usb-usb-more-pegasus-log-spamming-removed.patch
+gregkh-usb-usb-print-message-when-device-is-rejected-due-to-insufficient-power.patch
+gregkh-usb-usbcore-fix-broken-rndis-config-selection.patch
+gregkh-usb-usbhid-remove-unneeded-blacklist-entries.patch
+gregkh-usb-usb-ftdi_sio-add-support-for-yost-engineering-servocenter3.1.patch
+gregkh-usb-usb-zd1201-cleanups.patch
+gregkh-usb-driver-for-apple-cinema-display.patch
+gregkh-usb-airprime_major_update.patch

 USB tree updates

+usb-add-sierra-wireless-mc5720-id-to-airprimec.patch
+usb-negative-index-in-drivers-usb-host-isp116x-hcdc.patch

 More USB additions

+x86_64-mm-i386-move-vm86-config.patch

 x86_64 tree update

-node-hotplug-fixes-callres-of-register_cpu.patch
-node-hotplug-fixes-callres-of-register_cpu-powerpc-warning-fix.patch
-node-hotplug-register_node-fix.patch

 Folxed into node-hotplug-register-cpu-remove-node-struct.patch

+node-hotplug-register-cpu-remove-node-struct-alpha-fix.patch

 Fix it some more.

+lsm-add-task_setioprio-hook.patch

 LSM hook for sys_setioprio().

+i386-dont-try-kprobes-for-v8086-mode.patch

 x86 fix

+alpha-generic-hweight-build-fix.patch

 Alpha build fix

+emu10k1-mark-midi_spinlock-as-used.patch

 OSS driver fix

+add-max6902-rtc-support.patch
+add-max6902-rtc-support-tidy.patch
+rtc-small-documentation-update.patch

 RTC udpates

+make-ext2_debug-work-again.patch

 ext3 fixes

+ecryptfs-file-operations-fix-premature-release-of-file_info-memory.patch

 ecryptfs update

+namespaces-utsname-use-init_utsname-when-appropriate-cifs-update.patch

 Fix namespaces-utsname-use-init_utsname-when-appropriate.patch for recent
 CIFS changes.

+readahead-state-based-method-readahead-state-based-method-stand-alone-size-limit-code.patch
+readahead-context-based-method-apply-stream_shift-size-limits-to-contexta-method.patch
+readahead-context-based-method-fix-remain-counting.patch
+readahead-backward-prefetching-method-add-use-case-comment.patch

 Update readahead patches in -mm.

+reiser4-fix-trivial-tyops-which-were-hard-to-hit.patch

 reiser4 fixes

+dm-table-get_target-fix-last-index.patch

 device mapper fix.

+md-md-kconfig-speeling-feex.patch
+md-fix-kconfig-error.patch
+md-fix-bug-that-stops-raid5-resync-from-happening.patch
+md-allow-re-add-to-work-on-array-without-bitmaps.patch
+md-dont-write-dirty-clean-update-to-spares-leave-them-alone.patch
+md-set-get-state-of-array-via-sysfs.patch
+md-allow-rdev-state-to-be-set-via-sysfs.patch
+md-allow-raid-layout-to-be-read-and-set-via-sysfs.patch
+md-allow-resync_start-to-be-set-and-queried-via-sysfs.patch
+md-allow-the-write_mostly-flag-to-be-set-via-sysfs.patch

 RAID updates.

+statistics-infrastructure-make-printk_clock-a-generic-kernel-wide-nsec-resolution.patch
+statistics-infrastructure-update-2.patch
+statistics-infrastructure-update-3.patch

 Fix the statistics-infrastructure patches.

+genirq-cleanup-remove-irq_descp-fix.patch

 Fix genirq handling of MSI interrupts.

+genirq-add-chip-eoi-fastack-fasteoi.patch

 More genirq work.

+lock-validator-stacktrace-fix-on-x86_64.patch
+lock-validator-irqtrace-entrys-fix.patch
+lock-validator-irqtrace-core-remove-softirqc-warn_on.patch
+lock-validator-prove-mutex-locking-correctness-fix-null-type-name-bug.patch
+lock-validator-disable-nmi-watchdog-if-config_lockdep-i386.patch
+lock-validator-disable-nmi-watchdog-if-config_lockdep-x86_64.patch
+lock-validator-special-locking-net-ipv4-igmpcpatch.patch
+lock-validator-special-locking-net-ipv4-igmpc-2.patch
+lock-validator-special-locking-sb-s_umount-2-fix.patch
+lockdep-annotate-rpc_populate-for.patch
+lock-validator-special-locking-sound-core-seq-seq_devicec.patch
+lock-validator-special-locking-sound-core-seq-seq_devicec-fix.patch
+lock-validator-fix-rt_hash_lock_sz.patch
+lock-validator-introduce-irq__lockdep.patch
+locking-validator-special-rule-8390c-disable_irq.patch
+locking-validator-special-rule-3c59xc-disable_irq.patch
-lock-validator-enable-lock-validator-in-kconfig-x86-only.patch
+lock-validator-enable-lock-validator-in-kconfig-require-trace_irqflags_support.patch
+lock-validator-irqtrace-support-non-x86-architectures.patch
+lock-validator-disable-oprofile-if-lockdep=y.patch
+lock-validator-select-kallsyms_all.patch

 Locking validator work.

-profile-likely-unlikely-macros-tidy.patch
-profile-likely-unlikely-macros-fix.patch
-profile-likely-unlikely-macros-fix-2.patch
-fix-gcc-3x-w-likely-profiling.patch

 Folded into profile-likely-unlikely-macros.patch


All 1265 patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm2/patch-list

