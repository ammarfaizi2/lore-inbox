Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbUKIPwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbUKIPwD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 10:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbUKIPwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 10:52:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:29618 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261561AbUKIPtR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 10:49:17 -0500
Date: Tue, 9 Nov 2004 07:49:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc1-mm4
Message-Id: <20041109074909.3f287966.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm4/

- The 4-level-pagetable code is hopefully finalised.

- Various architecture updates.

- Added the new FRV architecture.

- v4l updates, fbdev updates.

- A process matter: I'm now tracking any regressions since 2.6.9, with the
  intention that we not release 2.6.10 until they're all fixed.  (Where
  "tracking" means shoving them into a folder called "bugs").  So if anyone is
  aware of any post-2.6.9 regressions, please make sure that I have a copy of
  the email.  

  I'm less interested in bugs which existed prior to 2.6.9, as they're
  presumably minor and as long as we don't actually introduce regressions then
  we'll make decent progress across kernel releases.



Changes since 2.6.10-rc1-mm3:


 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-cifs.patch
 bk-cpufreq.patch
 bk-driver-core.patch
 bk-drm.patch
 bk-ia64.patch
 bk-ide-dev.patch
 bk-input.patch
 bk-dtor-input.patch
 bk-jfs.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-pci.patch
 bk-scsi.patch
 bk-watchdog.patch

 latest versions of external BK trees.

-fix-hpet-time_interpolator-registration.patch
-icom-makefile-fix.patch
-unexport-lock_page.patch
-bootmem-use-node_data.patch
-prio_tree-fix-prio_tree_expand-corner-c.patch
-prio_tree-add-documentation-prio_treetxt.patch
-fix-find_next_best_node.patch
-more-hardirqh-consolidation.patch
-ppc32-cpm2-bug.patch
-ppc32-add-support-for-sandpoint-x2.patch
-fix-pmac_zilog-as-console.patch
-ppc64-iseries-iommu-cleanups.patch
-ppc64-vio-iommu-table-property-parsing-wrong.patch
-ppc64-add-option-for-oprofile-to-backtrace-through-spinlocks.patch
-ppc64-iommu-fixes-round-3.patch
-ppc64-iseries_pcic-use-for_each_pci_dev.patch
-ppc64-pmac_pcic-replace-pci_find_device-with-pci_get_device.patch
-ppc64-pseries_pcic-use-for_each_pci_dev.patch
-ppc64-pseries_iommuc-use-for_each_pci_dev.patch
-ppc64-u3_iommuc-use-for_each_pci_dev.patch
-up-local-apic-bootstrap-cleanup.patch
-x86-x86_64-only-handle-system-nmis-on-the-bsp.patch
-ptrace-pokeusr-add-comment-about-the-dr7-check.patch
-x86_64-add-p4-clockmod.patch
-m32r-fix-arch-m32r-lib-memsets.patch
-m32r-fix-for-use-of-mappi-pcc.patch
-uml-fix-ptrace-hang-on-269-host-due-to-host-changes.patch
-uml-some-comments-about-forcing-bin-bash.patch
-uml-add-startup-check-for-mmapprot_exec-from-tmp.patch
-uml-fix-syscall-auditing.patch
-uml-fix-symbol-conflict-in-linking.patch
-uml-cleanup-header-names.patch
-uml-remove-useless-inclusion.patch
-uml-no-duplicate-current_thread-definition.patch
-uml-mconsole_proc-simplify-and-partial-fix.patch
-uml-catch-eintr-in-generic_console_write.patch
-uml-remove-sigprof-from-change_signals.patch
-umluse-kallsyms-when-dumping-stack.patch
-uml-revert-compile-only-changes-for-other-ones.patch
-uml-fix-sysemu-test-at-startup.patch
-uml-more-careful-test-startup.patch
-uml-use-ptrace_sysemu-also-for-tt-mode.patch
-uml-lots-of-little-fixes-by-jeff-dike.patch
-uml-clear-errno-in-catch_eintr.patch
-uml-readd-linux-makefile-target-fixes-to-the-old-version.patch
-uml-add-missing-newline-in-help-string.patch
-uml-update-atomich-so-uml-builds-cleanly.patch
-uml-handle-signal-api.patch
-uml-sysenter-is-syscall.patch
-uml-generic-singlestep-syscall.patch
-uml-generic-singlestepping.patch
-uml-clear-singlestep.patch
-uml-dont-check-nr_syscalls.patch
-uml-set-dtrace-correctly.patch
-v4l-mxb-driver-and-i2c-helper-cleanup.patch
-v4l-keep-tvaudio-driver-away-from-saa7146.patch
-meye-module-related-fixes.patch
-meye-replace-homebrew-queue-with-kfifo.patch
-meye-picture-depth-is-in-bits-not-in-bytes.patch
-meye-do-lock-properly-when-waiting-for-buffers.patch
-meye-implement-non-blocking-access-using-poll.patch
-meye-cleanup-init-exit-paths.patch
-meye-the-driver-is-no-longer-experimental-and-depends-on-pci.patch
-meye-module-parameters-documentation-fixes.patch
-meye-add-v4l2-support.patch
-meye-whitespace-and-coding-style-cleanups.patch
-meye-bump-up-the-version-number.patch
-meye-cache-the-camera-settings-in-the-driver.patch
-sonypi-documentation-fixes.patch
-pcmcia-network-drivers-cleanup.patch
-videodev2h-patchlet.patch
-fbcon-do-not-touch-hardware-if-vc_mode-=-kd_text.patch
-fbdev-fix-access-to-rom-in-aty128fb.patch
-fbdev-fix-io-access-in-rivafb.patch
-fbcon-add-box-drawing-glyphs-to-6x11-font.patch
-fbdev-fix-source-copy-bug-in-neofb.patch
-fbcon-fbdev-remove-fbcon-specific-fields-from-struct-fb_info.patch
-fbdev-atyfb_basec-requires-atyfb_cursor.patch
-fix-atyfb-cursor-problems.patch
-fbdev-set-correct-mclk-xclk-values-for-aty-in-ibook.patch
-fbdev-check-for-intialized-flag-before-registration-in-matroxfb.patch
-fbcon-do-not-touch-hardware-if-vc_mode-=-kd_text-fix.patch
-remove-two-leftover-asm-linux_logoh-files.patch
-fbdev-intelfb-code-cleanup.patch
-fbcon-another-fix-for-fbcon-generic-blanking-code.patch
-dont-ignore-try_stop_module-return.patch
-proc-kcore-enable-disable.patch
-via8231-support-for-parallel-port-driver.patch
-via8231-support-for-parallel-port-driver-warning-fix.patch
-fix-altsysrq-deadlock.patch
-sysrq-n-changes-rt-tasks-to-normal.patch
-fix-bug-in-i2o_iop_systab_set-where-address-is-used-instead.patch
-lock-initializer-unifying-batch-2-pci.patch
-remove-unused-lookup_mnt-export.patch
-kprobes-minor-i386-changes-required-for-porting-kprobes-to-x86_64.patch
-kprobes-kprobes-ported-to-x86_64.patch
-kprobes-minor-changes-for-sparc64.patch
-maintainer-vfs-email.patch
-fix-ext3_dx_readdir.patch
-remove-dead-kernel_map_pages-export.patch
-reove-dead-exports-from-randomc.patch
-unexport-do_settimeofday.patch
-minor-fix-of-rcu-documentation.patch
-documentation-remove-drivers-char-readmecomputone.patch
-documentation-remove-drivers-char-readmecyclomy.patch
-documentation-remove-drivers-char-readmeecpa.patch
-documentation-remove-drivers-char-readmescc.patch
-tipar-documentation-tipartxt-cleanup.patch
-ramdisk-correction-to-documentation-kernel-parameterstxt.patch
-fix-building-of-samba-userland.patch
-use-add_hotplug_env_var-in-firmware-loader.patch
-add-__kernel__-to-linux-crc-ccitth.patch

 Merged

+4level-bogus-bug_on.patch
+4level-fix-vmalloc-overflow.patch
+4level-core-tweaks.patch
+4level-fixes-arm.patch
+4level-make-3level-fallback-more-type-safe.patch
+4level-architecture-changes-for-i386-fix.patch

 4-level pagetable fixups

+remove-contention-on-profile_lock.patch

 Speed up profiling on big SMP

+megaraid-22041-driver.patch

 Megaraid driver update

+fix-o_sync-speedup-for-generic_file_write_nolock.patch

 O_SYNC was broken on AIO operations.

+x25-when-receiving-a-call-check-listening-sockets-for-matching-call-user-data.patch
+x25-remove-unused-header-files.patch
+ixgb-fix-ixgb_intr-looping-checks.patch

 Networking updates

+ppc32-add-setup_indirect_pci_nomap-routine.patch
+added-mpc8555-8541-security-block-infrastructure.patch
+ppc32-fix-rheap-warning.patch
+ppc32-updated-reporting-of-cpu-rev-freq-for-e500-cpus.patch
+ppc32-add-performance-counters-to-cpu_spec.patch

 ppc32 updates

+ppc64-iseries-combine-some-mf-code.patch
+ppc64-iseries-remove-trailing-white-space.patch
+ppc64-iseries-remove-some-studly-caps.patch
+ppc64-iseries-more-mf-cleanup.patch
+ppc64-iseries-remove-more-studly-caps-from-mf-code.patch
+ppc64-iseries-last-of-the-cleanups-fo-the-mf-code.patch
+ppc64-fix-g5-low-level-i2c-code.patch
+ppc64-add-hw-cpu-timebase-sync.patch

 ppc64 updates

+remove-unnecessary-inclusions-of-asm-aouth.patch
+fix-page-size-assumption-in-fork.patch
+ext3-compiler-warning-fix.patch
+termio-userspace-access-error-handling.patch
+make-proc-kcore-conditional-on-config_mmu.patch
+ide_arch_obsolete_init-fix.patch
+out-of-line-implementation-of-find_next_bit.patch
+gp-rel-data-support.patch
+vm-routine-fixes.patch

 Random stuff, some of it preparation for the FRV architecture

+frv-fujitsu-fr-v-cpu-arch-maintainer-record.patch
+frv-fujitsu-fr-v-arch-documentation.patch
+frv-fujitsu-fr-v-cpu-arch-implementation-part-1.patch
+frv-fujitsu-fr-v-cpu-arch-implementation-part-2.patch
+frv-fujitsu-fr-v-cpu-arch-implementation-part-3.patch
+frv-fujitsu-fr-v-cpu-arch-implementation-part-4.patch
+frv-fujitsu-fr-v-cpu-arch-implementation-part-5.patch
+frv-fujitsu-fr-v-cpu-arch-implementation-part-6.patch
+frv-fujitsu-fr-v-cpu-arch-implementation-part-7.patch
+frv-fujitsu-fr-v-cpu-arch-implementation-part-8.patch
+frv-fujitsu-fr-v-cpu-arch-implementation-part-9.patch
+frv-fujitsu-fr-v-arch-include-files.patch
+frv-make-calibrate_delay-optional.patch
+frv-better-mmap-support-in-uclinux.patch
+frv-procfs-changes-for-nommu-changes.patch
+frv-change-setup_arg_pages-to-take-stack-pointer.patch
+frv-add-fdpic-elf-binary-format-driver.patch

 FRV architecture.

+x86_64-ia32_aout-build-fix.patch

 x86_64 build fix

+cris-architecture-update-configuration-and-build.patch
+cris-architecture-update-update-simple-drivers.patch
+cris-architecture-update-ethernet-driver.patch
+cris-architecture-update-ide-driver.patch
+cris-architecture-update-add-usb-host-driver.patch
+cris-architecture-update-core-kernel-updates.patch
+cris-architecture-update-console-setup-handling.patch
+cris-architecture-update-move-drivers.patch
+cris-architecture-update-update-makefiles.patch
+cris-architecture-update-update-maintainers.patch

 arch/cris update

+futex_wait-fix.patch

 Fix a rare futex hang.

+schedc-whitespace-mangler.patch
+sched-alter_kthread_prio.patch
+sched-adjust_timeslice_granularity.patch
+sched-add_requeue_task.patch
+requeue_granularity.patch
+sched-remove_interactive_credit.patch

 CPU scheduler tweaking.

+v4l-yet-another-video-buf-interface-update.patch
+v4l-add-video-buf-dvbc.patch
+v4l-bttv-update.patch
+v4l-saa7134-update.patch
+v4l-cx88-update.patch
+v4l-saa7146-update.patch
+v4l-tuner-modparam.patch
+v4l-ir-common-modparam.patch
+v4l-v4l1-compat-modparam.patch
+v4l-msp3400-fix.patch
+media-video-bw-qcamc-remove-an-unused-function.patch

 v4l updates

-move-hcdp-pcdp-to-early-uart-console.patch

 Dropped, but I forget why.

+fbdev-fix-io-access-in-rivafb-part-2.patch
+fbdev-fix-mode-handling-in-rivafb-if-with-no-edid.patch
+fbdev-use-soft_cursor-in-i810fb.patch
+fbdev-set-color-depth-to-8-if-in-pseudocolor-in-vesafb.patch
+fbcon-split-set_con2fb_map.patch
+fbdev-introduce-fb_blank_-constants.patch
+fbdev-convert-drivers-to-use-the-new-fb_blank_-constants.patch
+fbdev-fix-broken-fb_blank-implementation.patch

 fbdev updates

+blk_sync_queue-updates.patch

 update an update to the md updates

+ext2-docs-update.patch
+ufs-docs-update.patch

 Documentation

-remove-module_parm-from-allyesconfig-almost.patch

 This was being painful.  Let it go for now and we'll do another MODULA_PARM
 sweep when things have settled down.

+kill-lockd_symsc.patch

 NFS cleanup

+aic-warning-fix.patch

 Kill a warning

+lib-parser-fix-%%-parsing.patch

 Fix bug in string parser.

+make-cdev_get-static-unexport.patch
+unexport-task_nice.patch

 Code cleanups

+dont-divide-by-0-when-trying-to-mount-ext3.patch

 Fix ext3 bug when mounting corrupted filesystems.

+evdev-return-einval-if-read-size-is-not-multiple-of-struct-size.patch

 input layer read() checking

+limit-CONFIG_LEGACY_PTY_COUNT.patch

 Don't permit configuration of more than 256 legacy ttys.



number of patches in -mm: 446
number of changesets in external trees: 497
number of patches in -mm only: 430
total patches: 927



All 446 patches:


linus.patch

4level-core-patch.patch
  4level core patch

4level-bogus-bug_on.patch
  4level: remove bogus BUG_ON()

4level-fix-vmalloc-overflow.patch
  4level: fix vmalloc overflow

4level-core-tweaks.patch
  4level core tweaks

4level-architecture-changes-for-alpha.patch
  4level: Architecture changes for alpha

4level-architecture-changes-for-arm.patch
  4level: Architecture changes for arm

4level-fixes-arm.patch
  4level fixes (ARM)

4level-architecture-changes-for-cris.patch
  4level: Architecture changes for cris

4level-convert-drm-to-4levels.patch
  4level: convert DRM to 4levels.

4level-add-asm-generic-support-for-emulating.patch
  4level: Add asm-generic support for emulating 2/3level tables.

4level-make-3level-fallback-more-type-safe.patch
  4level: make 3level fallback more type safe

4level-ia64-support.patch
  4level: ia64 support

4level-architecture-changes-for-i386.patch
  4level: Architecture changes for i386

4level-architecture-changes-for-i386-fix.patch
  4level build fix

4level-architecture-changes-for-m32r.patch
  4level: Architecture changes for m32r

4level-architecture-changes-for-ppc.patch
  4level: Architecture changes for ppc

4level-architecture-changes-for-ppc64.patch
  4level: Architecture changes for ppc64

4level-architecture-changes-for-s390.patch
  4level: Architecture changes for s390

4level-architecture-changes-for-sh.patch
  4level: Architecture changes for sh

4level-architecture-changes-for-sh64.patch
  4level: Architecture changes for sh64

4level-architecture-changes-for-sparc.patch
  4level: Architecture changes for sparc

4level-architecture-changes-for-sparc64.patch
  4level: Architecture changes for sparc64

4level-architecture-changes-for-x86_64.patch
  4level: Architecture changes for x86_64

compat-syscalls-naming-standardisation.patch
  compat syscalls naming standardisation

compat-syscalls-naming-standardisation-fix.patch
  compat-syscalls-naming-standardisation-fix

make-sysrq-f-call-oom_kill.patch
  make sysrq-F call oom_kill()

remove-contention-on-profile_lock.patch
  remove contention on profile_lock

bk-acpi.patch

acpi-report-errors-in-fanc.patch
  ACPI: report errors in fan.c

bk-agpgart.patch

bk-cifs.patch

bk-cpufreq.patch

bk-driver-core.patch

bk-drm.patch

bk-ia64.patch

fix-duplicate-config-for-ia64_mca_recovery.patch
  Fix duplicate config for IA64_MCA_RECOVERY

bk-ide-dev.patch

bk-input.patch

bk-dtor-input.patch

bk-jfs.patch

bk-netdev.patch

bk-ntfs.patch

bk-pci.patch

bk-scsi.patch

megaraid-22041-driver.patch
  megaraid 2.20.4.1 Driver

bk-watchdog.patch

mm.patch
  add -mmN to EXTRAVERSION

fix-smm-failures-on-e750x-systems.patch
  fix SMM failures on E750x systems

mm-keep-count-of-free-areas.patch
  mm: keep count of free areas

mm-higher-order-watermarks.patch
  mm: higher order watermarks

mm-higher-order-watermarks-fix.patch
  higher order watermarks fix

mm-teach-kswapd-about-higher-order-areas.patch
  mm: teach kswapd about higher order areas

fix-o_sync-speedup-for-generic_file_write_nolock.patch
  Fix O_SYNC speedup for generic_file_write_nolock

make-tree_lock-an-rwlock.patch
  make mapping->tree_lock an rwlock

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update
  must-fix update
  mustfix lists

arcnet-fixes.patch
  arcnet fixes

arcnet-fixes-fix.patch
  arcnet fixes fix

netpoll-fix-null-ifa_list-pointer-dereference.patch
  netpoll: fix null ifa_list pointer dereference

e1000-stop-working-after-resume.patch
  E1000 stop working after resume

fix-for-8023ad-shutdown-issue.patch
  Fix for 802.3ad shutdown issue

x25-when-receiving-a-call-check-listening-sockets-for-matching-call-user-data.patch
  X.25: When receiving a call, check listening sockets for matching call user data.

x25-remove-unused-header-files.patch
  X.25: Remove unused header files

ixgb-fix-ixgb_intr-looping-checks.patch
  ixgb: fix ixgb_intr looping checks

ppc32-add-setup_indirect_pci_nomap-routine.patch
  ppc32: add setup_indirect_pci_nomap() routine

added-mpc8555-8541-security-block-infrastructure.patch
  ppc32: dded MPC8555/8541 security block infrastructure

ppc32-fix-rheap-warning.patch
  ppc32: fix rheap warning

ppc32-updated-reporting-of-cpu-rev-freq-for-e500-cpus.patch
  ppc32: updated reporting of CPU rev & freq for e500 CPUs

ppc32-add-performance-counters-to-cpu_spec.patch
  ppc32: add performance counters to cpu_spec

ppc64-iseries-combine-some-mf-code.patch
  ppc64: iSeries combine some MF code

ppc64-iseries-remove-trailing-white-space.patch
  ppc64: iSeries remove trailing white space

ppc64-iseries-remove-some-studly-caps.patch
  ppc64: iSeries remove some Studly Caps

ppc64-iseries-more-mf-cleanup.patch
  ppc64: iSeries more MF cleanup

ppc64-iseries-remove-more-studly-caps-from-mf-code.patch
  ppc64: iSeries remove more Studly Caps from MF code

ppc64-iseries-last-of-the-cleanups-fo-the-mf-code.patch
  ppc64: iSeries last of the cleanups fo the MF code

ppc64-fix-g5-low-level-i2c-code.patch
  ppc64: Fix G5 low level i2c code

ppc64-add-hw-cpu-timebase-sync.patch
  ppc64: Add HW CPU timebase sync

remove-unnecessary-inclusions-of-asm-aouth.patch
  Remove unnecessary inclusions of asm/a.out.h

fix-page-size-assumption-in-fork.patch
  fix page size assumption in fork()

ext3-compiler-warning-fix.patch
  EXT3 compiler warning fix

termio-userspace-access-error-handling.patch
  Termio userspace access error handling

make-proc-kcore-conditional-on-config_mmu.patch
  Make /proc/kcore conditional on CONFIG_MMU

ide_arch_obsolete_init-fix.patch
  IDE_ARCH_OBSOLETE_INIT fix

out-of-line-implementation-of-find_next_bit.patch
  out-of-line implementation of find_next_bit()

gp-rel-data-support.patch
  GP-REL data support

vm-routine-fixes.patch
  VM routine fixes

frv-fujitsu-fr-v-cpu-arch-maintainer-record.patch
  FRV: Fujitsu FR-V CPU arch maintainer record

frv-fujitsu-fr-v-arch-documentation.patch
  FRV: Fujitsu FR-V arch documentation

frv-fujitsu-fr-v-cpu-arch-implementation-part-1.patch
  FRV: Fujitsu FR-V CPU arch implementation part 1

frv-fujitsu-fr-v-cpu-arch-implementation-part-2.patch
  FRV: Fujitsu FR-V CPU arch implementation part 2

frv-fujitsu-fr-v-cpu-arch-implementation-part-3.patch
  FRV: Fujitsu FR-V CPU arch implementation part 3

frv-fujitsu-fr-v-cpu-arch-implementation-part-4.patch
  FRV: Fujitsu FR-V CPU arch implementation part 4

frv-fujitsu-fr-v-cpu-arch-implementation-part-5.patch
  FRV: Fujitsu FR-V CPU arch implementation part 5

frv-fujitsu-fr-v-cpu-arch-implementation-part-6.patch
  FRV: Fujitsu FR-V CPU arch implementation part 6

frv-fujitsu-fr-v-cpu-arch-implementation-part-7.patch
  FRV: Fujitsu FR-V CPU arch implementation part 7

frv-fujitsu-fr-v-cpu-arch-implementation-part-8.patch
  FRV: Fujitsu FR-V CPU arch implementation part 8

frv-fujitsu-fr-v-cpu-arch-implementation-part-9.patch
  FRV: Fujitsu FR-V CPU arch implementation part 9

frv-fujitsu-fr-v-arch-include-files.patch
  FRV: Fujitsu FR-V arch include files

frv-make-calibrate_delay-optional.patch
  FRV: Make calibrate_delay() optional

frv-better-mmap-support-in-uclinux.patch
  FRV: Better mmap support in uClinux

frv-procfs-changes-for-nommu-changes.patch
  FRV: procfs changes for nommu changes

frv-change-setup_arg_pages-to-take-stack-pointer.patch
  FRV: change setup_arg_pages() to take stack pointer

frv-add-fdpic-elf-binary-format-driver.patch
  FRV: Add FDPIC ELF binary format driver

ppc64-reloc_hide.patch

superhyway-bus-support.patch
  SuperHyway bus support

optimize-stack-pointer-access-reduce-register-usage.patch
  x86: optimize stack pointer access (reduce register usage)

x86_64-ia32_aout-build-fix.patch
  x86_64: ia32_aout-build-fix

cris-architecture-update-configuration-and-build.patch
  From: "Mikael Starvik" <mikael.starvik@axis.com>
  Subject: [PATCH 1/10] CRIS architecture update - Configuration and Build

cris-architecture-update-update-simple-drivers.patch
  From: "Mikael Starvik" <mikael.starvik@axis.com>
  Subject: [PATCH 2/10] CRIS architecture update - Update simple drivers

cris-architecture-update-ethernet-driver.patch
  From: "Mikael Starvik" <mikael.starvik@axis.com>
  Subject: [PATCH 3/10] CRIS architecture update - Ethernet driver

cris-architecture-update-ide-driver.patch
  From: "Mikael Starvik" <mikael.starvik@axis.com>
  Subject: [PATCH 4/10] CRIS architecture update - IDE driver

cris-architecture-update-add-usb-host-driver.patch
  From: "Mikael Starvik" <mikael.starvik@axis.com>
  Subject: [PATCH 5/10] CRIS architecture update - Add USB host driver

cris-architecture-update-core-kernel-updates.patch
  From: "Mikael Starvik" <mikael.starvik@axis.com>
  Subject: [PATCH 6/10] CRIS architecture update - Core kernel updates.

cris-architecture-update-console-setup-handling.patch
  From: "Mikael Starvik" <mikael.starvik@axis.com>
  Subject: [PATCH 7/10] CRIS architecture update - Console setup handling.

cris-architecture-update-move-drivers.patch
  From: "Mikael Starvik" <mikael.starvik@axis.com>
  Subject: [PATCH 8/10] CRIS architecture update - Move drivers.

cris-architecture-update-update-makefiles.patch
  From: "Mikael Starvik" <mikael.starvik@axis.com>
  Subject: [PATCH 9/10] CRIS architecture update - Update Makefiles.

cris-architecture-update-update-maintainers.patch
  From: "Mikael Starvik" <mikael.starvik@axis.com>
  Subject: [PATCH 10/10] CRIS architecture update - Update MAINTAINERS.

futex_wait-fix.patch
  futex_wait fix

pcmcia-17-device-model-integration.patch
  pcmcia-17: device model integration

pcmcia-module_refcount-oops-fix.patch
  pcmcia: module_refcount oops fix

pcmcia-18a-client_t-and-pcmcia_device-integration.patch
  pcmcia-18a: client_t and pcmcia_device integration

pcmcia-18b-error-on-leftover-devices.patch
  pcmcia-18b: error on leftover devices

pcmcia-19-netdevice-integration.patch
  pcmcia-19: netdevice integration

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

kgdb-is-incompatible-with-kprobes.patch
  kgdb-is-incompatible-with-kprobes

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll
  kgdboe: fix configuration of MAC address

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
  kgdb-x86_64-warning-fixes

kgdb-x86_64-fix.patch
  kgdb-x86_64-fix

kgdb-x86_64-serial-fix.patch
  kgdb-x86_64-serial-fix

kprobes-exception-notifier-fix-kgdb-x86_64.patch
  kprobes exception notifier fix

kgdb-ia64-support.patch
  IA64 kgdb support
  ia64 kgdb repair and cleanup
  ia64 kgdb fix

kgdb-ia64-fixes.patch
  kgdb: ia64 fixes

fix-cpm2-uart-driver-device-number-brain-damage.patch
  Fix CPM2 uart driver device number brain damage

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

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

perfctr-i386.patch
  perfctr: i386

perfctr-prescott-fix.patch
  Prescott fix for perfctr

perfctr-x86_64.patch
  perfctr: x86_64

perfctr-ppc.patch
  perfctr: PowerPC

perfctr-ppc32-mmcr0-handling-fixes.patch
  perfctr ppc32 MMCR0 handling fixes

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

perfctr-x86-64-ia32-emulation-fix.patch
  perfctr x86-64 ia32 emulation fix

perfctr-ppc32-update.patch
  perfctr ppc32 update

sched-more-agressive-wake_idle.patch
  sched: more agressive wake_idle()

sched-can_migrate-exception-for-idle-cpus.patch
  sched: can_migrate exception for idle cpus

sched-newidle-fix.patch
  sched: newidle fix

sched-active_load_balance-fixlet.patch
  sched: active_load_balance() fixlet

sched-reset-cache_hot_time.patch
  sched: reset cache_hot_time

schedc-whitespace-mangler.patch
  sched.c whitespace mangler

sched-alter_kthread_prio.patch
  sched: alter_kthread_prio

sched-adjust_timeslice_granularity.patch
  sched: adjust_timeslice_granularity

sched-add_requeue_task.patch
  sched: add_requeue_task

requeue_granularity.patch
  sched: requeue_granularity

sched-remove_interactive_credit.patch
  sched: remove_interactive_credit

add-do_proc_doulonglongvec_minmax-to-sysctl-functions.patch
  Add do_proc_doulonglongvec_minmax to sysctl functions

add-do_proc_doulonglongvec_minmax-to-sysctl-functions-fix.patch
  add-do_proc_doulonglongvec_minmax-to-sysctl-functions-fix

add-sysctl-interface-to-sched_domain-parameters.patch
  Add sysctl interface to sched_domain parameters

preempt-smp.patch
  improve preemption on SMP

preempt-smp-_raw_read_trylock-bias-fix.patch
  preempt-smp _raw_read_trylock bias fix

preempt-cleanup.patch
  preempt cleanup

preempt-cleanup-fix.patch
  preempt-cleanup-fix

add-lock_need_resched.patch
  add lock_need_resched()

sched-add-cond_resched_softirq.patch
  sched: add cond_resched_softirq()

sched-ext3-fix-scheduling-latencies-in-ext3.patch
  sched: ext3: fix scheduling latencies in ext3

break-latency-in-invalidate_list.patch
  break latency in invalidate_list()

sched-vfs-fix-scheduling-latencies-in-prune_dcache-and-select_parent.patch
  sched: vfs: fix scheduling latencies in prune_dcache() and select_parent()

sched-vfs-fix-scheduling-latencies-in-prune_dcache-and-select_parent-fix.patch
  sched-vfs-fix-scheduling-latencies-in-prune_dcache-and-select_parent fix

sched-net-fix-scheduling-latencies-in-netstat.patch
  sched: net: fix scheduling latencies in netstat

sched-net-fix-scheduling-latencies-in-__release_sock.patch
  sched: net: fix scheduling latencies in __release_sock

sched-mm-fix-scheduling-latencies-in-unmap_vmas.patch
  sched: mm: fix scheduling latencies in unmap_vmas()

sched-mm-fix-scheduling-latencies-in-get_user_pages.patch
  sched: mm: fix scheduling latencies in get_user_pages()

sched-mm-fix-scheduling-latencies-in-filemap_sync.patch
  sched: mm: fix scheduling latencies in filemap_sync()

fix-keventd-execution-dependency.patch
  fix keventd execution dependency

sched-fix-scheduling-latencies-in-mttrc.patch
  sched: fix scheduling latencies in mttr.c

sched-fix-scheduling-latencies-in-vgaconc.patch
  sched: fix scheduling latencies in vgacon.c

sched-fix-scheduling-latencies-for-preempt-kernels.patch
  sched: fix scheduling latencies for !PREEMPT kernels

idle-thread-preemption-fix.patch
  idle thread preemption fix

oprofile-smp_processor_id-fixes.patch
  oprofile smp_processor_id() fixes

fix-smp_processor_id-warning-in-numa_node_id.patch
  Fix smp_processor_id() warning in numa_node_id()

remove-the-bkl-by-turning-it-into-a-semaphore.patch
  remove the BKL by turning it into a semaphore

cpu_down-warning-fix.patch
  cpu_down() warning fix

vmtrunc-truncate_count-not-atomic.patch
  vmtrunc: truncate_count not atomic

vmtrunc-restore-unmap_vmas-zap_bytes.patch
  vmtrunc: restore unmap_vmas zap_bytes

vmtrunc-unmap_mapping_range_tree.patch
  vmtrunc: unmap_mapping_range_tree

vmtrunc-unmap_mapping-dropping-i_mmap_lock.patch
  vmtrunc: unmap_mapping dropping i_mmap_lock

vmtrunc-vm_truncate_count-race-caution.patch
  vmtrunc: vm_truncate_count race caution

vmtrunc-bug-if-page_mapped.patch
  vmtrunc: bug if page_mapped

vmtrunc-restart_addr-in-truncate_count.patch
  vmtrunc: restart_addr in truncate_count

v4l-yet-another-video-buf-interface-update.patch
  v4l: yet another video-buf interface update

v4l-add-video-buf-dvbc.patch
  v4l: add video-buf-dvb.c

v4l-bttv-update.patch
  v4l: bttv update

v4l-saa7134-update.patch
  v4l: saa7134 update

v4l-cx88-update.patch
  v4l: cx88 update

v4l-saa7146-update.patch
  v4l: saa7146 update

v4l-tuner-modparam.patch
  v4l: tuner modparam

v4l-ir-common-modparam.patch
  v4l: ir-common modparam

v4l-v4l1-compat-modparam.patch
  v4l: v4l1-compat modparam

v4l-msp3400-fix.patch
  v4l: msp3400 fix

media-video-bw-qcamc-remove-an-unused-function.patch
  media/video/bw-qcam.c: remove an unused function

linux-2.6.8.1-49-rpc_workqueue.patch
  nfs: RPC: Convert rpciod into a work queue for greater flexibility

linux-2.6.8.1-50-rpc_queue_lock.patch
  nfs: RPC: Remove the rpc_queue_lock global spinlock

allow-modular-ide-pnp.patch
  allow modular ide-pnp

allow-x86_64-to-reenable-interrupts-on-contention.patch
  Allow x86_64 to reenable interrupts on contention

i386-cpu-hotplug-updated-for-mm.patch
  i386 CPU hotplug updated for -mm

serialize-access-to-ide-devices.patch
  serialize access to ide devices

disable-atykb-warning.patch
  disable atykb "too many keys pressed" warning

export-file_ra_state_init-again.patch
  Export file_ra_state_init() again

cachefs-filesystem.patch
  CacheFS filesystem

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

crashdump-documentation.patch
  crashdump: documentation

crashdump-memory-preserving-reboot-using-kexec.patch
  crashdump: memory preserving reboot using kexec

crashdump-routines-for-copying-dump-pages.patch
  crashdump: routines for copying dump pages

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

new-bitmap-list-format-for-cpusets.patch
  new bitmap list format (for cpusets)

cpusets-big-numa-cpu-and-memory-placement.patch
  cpusets - big numa cpu and memory placement

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

cpusets-config_cpusets-depends-on-smp.patch
  Cpusets: CONFIG_CPUSETS depends on SMP

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

reiser4-sb_sync_inodes-cleanup.patch
  reiser4-sb_sync_inodes-cleanup

reiser4-allow-drop_inode-implementation.patch
  reiser4: export vfs inode.c symbols

reiser4-allow-drop_inode-implementation-cleanup.patch
  reiser4-allow-drop_inode-implementation-cleanup

reiser4-truncate_inode_pages_range.patch
  reiser4: vfs: add truncate_inode_pages_range()

reiser4-truncate_inode_pages_range-cleanup.patch
  reiser4-truncate_inode_pages_range-cleanup

reiser4-export-remove_from_page_cache.patch
  reiser4: export pagecache add/remove functions to modules

reiser4-export-page_cache_readahead.patch
  reiser4: export page_cache_readahead to modules

reiser4-reget-page-mapping.patch
  reiser4: vfs: re-check page->mapping after calling try_to_release_page()

reiser4-rcu-barrier.patch
  reiser4: add rcu_barrier() synchronization point

reiser4-rcu-barrier-fix.patch
  reiser4-rcu-barrier fix

reiser4-export-inode_lock.patch
  reiser4: export inode_lock to modules

reiser4-export-inode_lock-cleanup.patch
  reiser4-export-inode_lock-cleanup

reiser4-export-pagevec-funcs.patch
  reiser4: export pagevec functions to modules

reiser4-export-pagevec-funcs-cleanup.patch
  reiser4-export-pagevec-funcs-cleanup

reiser4-export-radix_tree_preload.patch
  reiser4: export radix_tree_preload() to modules

reiser4-radix-tree-tag.patch
  reiser4: add new radix tree tag

reiser4-radix_tree_lookup_slot.patch
  reiser4: add radix_tree_lookup_slot()

reiser4-aliased-dir.patch
  reiser4: vfs: handle aliased directories

reiser4-kobject-umount-race.patch
  reiser4: introduce filesystem kobjects

reiser4-kobject-umount-race-cleanup.patch
  reiser4-kobject-umount-race-cleanup

reiser4-perthread-pages.patch
  reiser4: per-thread page pools

reiser4-unstatic-kswapd.patch
  reiser4: make kswapd() unstatic for debug

reiser4-include-reiser4.patch
  reiser4: add to build system

reiser4-4kstacks-fix.patch
  resier4-4kstacks-fix

stop-reiser4-from-turning-itself-on-by-default.patch
  Stop reiser4 from turning itself on by default

reiser4-doc.patch
  reiser4: documentation

reiser4-doc-update.patch
  Update Documentation/Changes for reiser4

reiser4-only.patch
  reiser4: main fs

reiser4-rename-key_init.patch
  reiser4: rename key_init

reiser4-cond_resched-build-fix.patch
  reiser4: cond_resched() build fix

reiser4-debug-build-fix.patch
  reiser4-debug-build-fix

reiser4-prefetch-warning-fix.patch
  reiser4: prefetch warning fix

reiser4-mode-fix.patch
  reiser4: mode type fix

reiser4-get_context_ok-warning-fixes.patch
  reiser4: get_context_ok() warning fixes

reiser4-remove-debug.patch
  resier4: remove debug stuff

reiser4-spinlock-debugging-build-fix-2.patch
  reiser4-spinlock-debugging-build-fix-2

reiser4-sparc64-build-fix.patch
  reiser4 sparc64 build fix

sys_reiser4-sparc64-build-fix.patch
  sys_reiser4 sparc64 build fix

reiser4-printk-warning-fixes.patch
  reiser4 printk warning fixes

reiser4-generic_acl-fix.patch
  reiser4: generic_acl fix

reiser4-plugin_set_done-memleak-fix.patch
  reiser4 plugin_set_done-memleak-fix.patch

reiser4-init-max_atom_flusers.patch
  reiser4 init-max_atom_flusers.patch

reiser4-parse-options-reduce-stack-usage.patch
  reiser4 parse-options-reduce-stack-usage.patch

reiser4-sparce64-warning-fix.patch
  reiser4 sparc64-warning-fix.patch

reiser4-hardirq-build-fix.patch
  resiser4: hardirq.h build fix

reiser4-x86_64-warning-fix.patch
  reiser4 x86_64-warning-fix.patch

reiser4-fix-mount-option-parsing.patch
  reiser4 fix-mount-option-parsing.patch

reiser4-parse-option-cleanup.patch
  reiser4 parse-option-cleanup.patch

reiser4-comment-fix.patch
  reiser4 comment-fix.patch

reiser4-fill_super-improve-warning.patch
  reiser4 fill_super-improve-warning.patch

reiser4-disable-pseudo.patch
  reiser4 disable-pseudo.patch

reiser4-disable-repacker.patch
  reiser4 disable-repacker.patch

add-acpi-based-floppy-controller-enumeration.patch
  Add ACPI-based floppy controller enumeration.

add-acpi-based-floppy-controller-enumeration-fix.patch
  add-acpi-based-floppy-controller-enumeration fix

update-acpi-floppy-enumeration.patch
  update ACPI floppy enumeration

floppy-acpi-enumeration-update.patch
  floppy ACPI enumeration update

possible-dcache-bug-debugging-patch.patch
  Possible dcache BUG: debugging patch

3c59x-pm-fix.patch
  3c59x: enable power management unconditionally

3c59x-missing-pci_disable_device.patch
  3c59x: missing pci_disable_device

3c59x-use-netdev_priv.patch
  3c59x: use netdev_priv

3c59x-make-use-of-generic_mii_ioctl.patch
  3c59x: Make use of generic_mii_ioctl

3c59x-vortex-select-mii.patch
  3c59x: VORTEX select MII

3c59x-reload-eeprom-values-at-rmmod-for-needy-cards.patch
  3c59x: reload EEPROM values at rmmod for needy cards

3c59x-remove-eeprom_reset-for-3c905b.patch
  3c59x: remove EEPROM_RESET for 3c905B

3c59x-support-more-ethtool_ops.patch
  3c59x: support more ethtool_ops

serial-add-support-for-non-standard-xtals-to-16c950-driver.patch
  serial: add support for non-standard XTALs to 16c950 driver

add-support-for-possio-gcc-aka-pcmcia-siemens-mc45.patch
  Add support for Possio GCC AKA PCMCIA Siemens MC45

serial-8250-receive-lockup-fix.patch
  serial: 8250 receive lockup fix

new-serial-flow-control.patch
  new serial flow control

early-uart-console-support.patch
  early uart console support

mpsc-driver-patch.patch
  serial: MPSC driver

vm-pageout-throttling.patch
  vm: pageout throttling

revert-allow-oem-written-modules-to-make-calls-to-ia64-oem-sal-functions.patch
  revert "allow OEM written modules to make calls to ia64 OEM SAL functions"

md-add-interface-for-userspace-monitoring-of-events.patch
  md: add interface for userspace monitoring of events.

fix-for-spurious-interrupts-on-e100-resume-2.patch
  Fix for spurious interrupts on e100 resume 2

thinkpad-fnfx-key-driver.patch
  thinkpad fn+fx key driver

make-acpi_bus_register_driver-consistent-with-pci_register_driver-again.patch
  make acpi_bus_register_driver() consistent with pci_register_driver()

make-acpi_bus_register_driver-consistent-with-pci_register_driver-again-warning-fix.patch
  make-acpi_bus_register_driver-consistent-with-pci_register_driver-again-warning-fix

enforce-a-gap-between-heap-and-stack.patch
  Enforce a gap between heap and stack

remove-lock_section-from-x86_64-spin_lock-asm.patch
  remove LOCK_SECTION from x86_64 spin_lock asm

kfree_skb-dump_stack.patch
  kfree_skb-dump_stack

for-mm-only-remove-remap_page_range-completely.patch
  vm: for -mm only: remove remap_page_range() completely

cancel_rearming_delayed_work.patch
  cancel_rearming_delayed_work()

make-cancel_rearming_delayed_workqueue-static.patch
  make cancel_rearming_delayed_workqueue static

ipvs-deadlock-fix.patch
  ipvs deadlock fix

minimal-ide-disk-updates.patch
  Minimal ide-disk updates

no-buddy-bitmap-patch-revist-intro-and-includes.patch
  no buddy bitmap patch revist: intro and includes

no-buddy-bitmap-patch-revisit-for-mm-page_allocc.patch
  no buddy bitmap patch revisit: for mm/page_alloc.c

no-buddy-bitmap-patch-revisit-for-mm-page_allocc-fix.patch
  no-buddy-bitmap-patch-revisit-for-mm-page_allocc fix

no-buddy-bitmap-patch-revist-for-ia64.patch
  no buddy bitmap patch revist: for ia64

no-buddy-bitmap-patch-revist-for-ia64-fix.patch
  no-buddy-bitmap-patch-revist-for-ia64 fix

use-find_trylock_page-in-free_swap_and_cache-instead-of-hand-coding.patch
  use find_trylock_page in free_swap_and_cache instead of hand coding

dio-handle-eof.patch
  direct-IO: handle EOF
  dio-handle-eof fix

o_direct-fix-again.patch
  O_DIRECT fix again

fbdev-fix-io-access-in-rivafb-part-2.patch
  fbdev: Fix IO access in rivafb (part 2)

fbdev-fix-mode-handling-in-rivafb-if-with-no-edid.patch
  fbdev: Fix mode handling in rivafb if with no EDID

fbdev-use-soft_cursor-in-i810fb.patch
  fbdev: Use soft_cursor in i810fb

fbdev-set-color-depth-to-8-if-in-pseudocolor-in-vesafb.patch
  fbdev: Set color depth to 8 if in pseudocolor in vesafb.

fbcon-split-set_con2fb_map.patch
  fbcon: Split set_con2fb_map()

fbdev-introduce-fb_blank_-constants.patch
  fbdev: Introduce FB_BLANK_* constants

fbdev-convert-drivers-to-use-the-new-fb_blank_-constants.patch
  fbdev: Convert drivers to use the new FB_BLANK_* constants

fbdev-fix-broken-fb_blank-implementation.patch
  fbdev: Fix broken fb_blank() implementation.

md-fix-problem-with-md-linear-for-devices-larger-than-2-terabytes.patch
  md: fix problem with md/linear for devices larger than 2 terabytes

md-fix-raid6-problem.patch
  md: fix raid6 problem

md-delete-unplug-timer-before-shutting-down-md-array.patch
  md: delete unplug timer before shutting down md array

md-delete-unplug-timer-before-shutting-down-md-array-cleanup.patch
  md-delete-unplug-timer-before-shutting-down-md-array-cleanup

blk_sync_queue-updates.patch
  blk_sync_queue() updates

md-faulty-personality.patch
  md: "Faulty" personality

figure-out-who-is-inserting-bogus-modules.patch
  Figure out who is inserting bogus modules

use-mmiowb-in-qla1280c.patch
  use mmiowb in qla1280.c

yenta_socketc-fix-missing-pci_disable_dev.patch
  yenta_socket.c: Fix missing pci_disable_dev

yenta-dont-enable-read-prefetch-on-older-o2-bridges.patch
  yenta: don't enable read prefetch on older o2 bridges.

cputime-introduce-cputime.patch
  cputime: introduce cputime

cputime-introduce-cputime-fix.patch
  cputime-introduce-cputime fix

cputime-fix-do_setitimer.patch
  cputime: fix do_setitimer.

cputime-missing-pieces.patch
  cputime: missing pieces.

detect-atomic-counter-underflows.patch
  detect atomic counter underflows

lock-initializer-unifying-batch-2-alpha.patch
  Lock initializer unifying: ALPHA

lock-initializer-unifying-batch-2-ia64.patch
  Lock initializer unifying: IA64

lock-initializer-unifying-batch-2-m32r.patch
  Lock initializer unifying: M32R

lock-initializer-unifying-batch-2-mips.patch
  Lock initializer unifying: MIPS

lock-initializer-unifying-batch-2-misc-drivers.patch
  Lock initializer unifying: Misc drivers

lock-initializer-unifying-batch-2-block-devices.patch
  Lock initializer unifying: Block devices

lock-initializer-unifying-batch-2-bluetooth.patch
  Lock initializer unifying: Bluetooth

lock-initializer-unifying-batch-2-drm.patch
  Lock initializer unifying: DRM

lock-initializer-unifying-batch-2-character-devices.patch
  Lock initializer unifying: character devices

lock-initializer-unifying-batch-2-rio.patch
  Lock initializer unifying: RIO

lock-initializer-unifying-batch-2-firewire.patch
  Lock initializer unifying: Firewire

lock-initializer-unifying-batch-2-isdn.patch
  Lock initializer unifying: ISDN

lock-initializer-unifying-batch-2-raid.patch
  Lock initializer unifying: Raid

lock-initializer-unifying-batch-2-media-drivers.patch
  Lock initializer unifying: media drivers

lock-initializer-unifying-batch-2-scsi.patch
  Lock initializer unifying: SCSI

lock-initializer-unifying-batch-2-drivers-serial.patch
  Lock initializer unifying: drivers/serial

lock-initializer-unifying-batch-2-filesystems.patch
  Lock initializer unifying: Filesystems

lock-initializer-unifying-batch-2-video.patch
  Lock initializer unifying: Video

lock-initializer-unifying-batch-2-networking.patch
  Lock initializer unifying: Networking

lock-initializer-unifying-batch-2-sound.patch
  Lock initializer unifying: sound

remove-duplicate-safe_for_readread_buffer-entry-in-scsi_ioctlc.patch
  Remove duplicate safe_for_read(READ_BUFFER) entry in scsi_ioctl.c

ext2-docs-update.patch
  ext2 docs update

ufs-docs-update.patch
  ufs docs update

convert-module_parm-to-module_param-family.patch
  convert MODULE_PARM() to module_param() family

more-module_parm-conversions.patch
  more MODULE_PARM conversions

kill-lockd_symsc.patch
  kill lockd_syms.c

aic-warning-fix.patch
  aic warning fix

lib-parser-fix-%%-parsing.patch
  lib/parser: fix %% parsing

make-cdev_get-static-unexport.patch
  make cdev_get static, unexport

unexport-task_nice.patch
  unexport task_nice

dont-divide-by-0-when-trying-to-mount-ext3.patch
  don't divide by 0 when trying to mount ext3

evdev-return-einval-if-read-size-is-not-multiple-of-struct-size.patch
  evdev: return EINVAL if read size is not multiple of struct size

limit-CONFIG_LEGACY_PTY_COUNT.patch
  limit CONFIG_LEGACY_PTY_COUNT



