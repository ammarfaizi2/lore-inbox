Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266838AbUIVUQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266838AbUIVUQb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 16:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267400AbUIVUQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 16:16:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:8362 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266838AbUIVUOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 16:14:16 -0400
Date: Wed, 22 Sep 2004 13:12:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc2-mm2
Message-Id: <20040922131210.6c08b94c.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm2/

- Added Bart's bk-ide-dev tree to the -mm external tree lineup.

- Added Peter Williams' Single Priority Array (SPA) O(1) CPU Scheduler, aka
  the "zaphod" cpu scheduler.

  It has a number of tunables and lots of documentation - see the changelog
  entry in zaphod-scheduler.patch for details.

- This kernel doesn't work on ia64 (instant reboot).  But neither does
  2.6.9-rc2, nor current Linus -bk.  Is it just me?

- Added the kexec-based crashdump code.  This is the code which uses kexec
  to jump into a new mini-kernel when the main kernel crashes.  Userspace code
  in that mini-kernel then dumps the main kernel's memory to disk.  These new
  patches provide the bits and pieces which the mini-kernel needs to be able
  to get at the main kernel's memory.

  There seem to be no hints as to how to get all this working - that will
  come.

- Found (and fixed) the bug which was causing those
  ext3-goes-readonly-under-load problems.  It was in the new wait/wakeup code.





Changes since 2.6.9-rc2-mm1:



 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-cpufreq.patch
 bk-driver-core.patch
 bk-ia64.patch
 bk-ide-dev.patch
 bk-ieee1394.patch
 bk-input.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-pci.patch
 bk-pnp.patch
 bk-power.patch
 bk-scsi.patch
 bk-scsi-target.patch
 bk-usb.patch
 bk-watchdog.patch

 Latest versions of external trees

-reduce-ioremap-memory-size-for-adaptec-i2o-controllers.patch
-hvc_console-fix-to-protect-hvc_write-against-ldisc-write.patch
-back-out-siginfo_tsi_rusage-from-waitid-changes.patch
-ioport-cache-2.6.9-rc1-mm5-A0.patch
-ioport-cache-gpf-2.6.9-rc1-mm5-A3.patch
-fix-posix-timers-leak.patch
-pegasus-fixes.patch
-ppc32-fix-arch-ppc-boot-common-ns16550c.patch
-ppc64-force_sigsegv-fixes.patch
-ppc64-powersave_nap-sysctl.patch
-ppc64-replace-mmu_context_queue-with-idr-allocator.patch
-ppc64-iseries-build-fixes.patch
-ppc64-clean-up-asm-mmuh.patch
-ppc64-fix-some-bogus-warnings-cleanup-tlbie-code-path.patch
-ppc64-remove-a-and-aa.patch
-x86-64-add-atomic64_t.patch
-x86-64-make-apic-errors-kern_debug.patch
-x86-64-add-apic=verbosequietdebug.patch
-x86-64-update-defconfig.patch
-x86-64-avoid-deadlock-in-page-fault-handler.patch
-x86-64-avoid-panic-when-apic-id-cannot-be-set.patch
-x86-64-io-apic-suspend-resume.patch
-x86-64-make-machine-check-handler-configurable.patch
-x86-64-remove-warn_on-in-smp_call_function.patch
-x86-64-print-mce-bank-enable-mask-in-hex.patch
-x86-64-add-might_sleeps-to-more-_user-functions.patch
-x86-64-fix-for-mem=-on-numa-systems.patch
-x86-64-sibling-map-fix-for-clustered-mode.patch
-x86-64-synchronize-videos-with-i386.patch
-x86-64-add-read-implies-exec-macro.patch
-x86-64-x86-dont-pass-cr2-on-alignment-faults.patch
-x86-64-turn-tss-into-per-cpu-data.patch
-x86-64-copy-ioperm-bitmaps-more-efficiently-at-context-switch.patch
-fix-for-fsync-ignoring-writing-errors.patch
-serial-cs-and-unusable-port-size-ranges.patch
-m32r-base.patch
-m32r-update-for-profiling.patch
-m32r-update-zone_sizes_init.patch
-m32r-update-to-fix-compile-errors.patch
-m32r-update-uaccessh.patch
-m32r-update-checksum-functions.patch
-m32r-update-cf-pcmcia-drivers.patch
-m32r-update-headers-to-remove-useless-ibcs2-support-code.patch
-atomic_inc_return-for-m32r-re.patch
-m32r-change-from-export_symbol_novers-to-export_symbol.patch
-m32r-modify-sys_ipc-to-remove-useless-ibcs2-support-code.patch
-m32r-add-elf-machine-code.patch
-m32r-upgrade-to-2681-kernel.patch
-m32r-support-a-new-bootloader-m32r-g00ff.patch
-m32r-modify-io-routines-for-m32700ut-cf-access.patch
-m32r-remove-network-drivers.patch
-m32r-modify-drivers-net-smc91xc-for.patch
-m32r-modify-drivers-net-nec-for-m32r.patch
-m32r-slim-arch-m32r-kconfig.patch
-m32r-upgrade-include-asm-m32r-atomich.patch
-m32r-fix-to-build-smp-kernel.patch
-check-checksums-for-bnep.patch
-device-driver-for-the-sgi-system-clock-mmtimer.patch
-close-race-with-preempt-and-modular-pm_idle-callbacks.patch
-fbdev-initialize-i810fb-after-agpgart.patch
-fbdev-fix-userland-compile-breakage.patch
-r8169-miscalculation-of-available-tx-descriptors.patch
-r8169-hint-for-tx-flow-control.patch
-r8169-tso-support.patch
-r8169-mac-identifier-extracted-from-realteks-driver-v22.patch
-add-missing-pci_disable_device-for-e1000.patch
-fake_ino-fixes.patch
-updates-to-rcu-documentation.patch
-fix-sysrq-handling-bug-in-sn_consolec.patch
-uml-update-handle_irq_event.patch
-uml-finish-the-signals-across-a-reboot-fix.patch
-uml-finish-conversion-to-sigjmp_buf-siglongjmp.patch
-uml-fix-a-signal-race.patch
-uml-enable-the-timer-after-the-timer-handler.patch
-uml-convert-the-real-time-clock-to-gettimeofday-from-rdtsc.patch
-uml-cleaning-up.patch
-uml-let-page-faults-always-be-delivered-immediately.patch
-uml-eliminate-signal-order-delivery-dependency.patch
-uml-iomem-fix.patch
-uml-fix-call-to-sys_clone.patch
-uml-copy_user-fixes.patch
-ide-remove-obsolete-config_blk_dev_adma.patch
-fix-driver-name-in-eth1394-as-returned-by-ethtool_gdrvinfo.patch
-mips-fixed-do_signal-in-arch-mips-kernel-signalc.patch
-time-interpolators-logic-fix.patch
-document-arm-pci=firmware-option.patch
-update-ixp4xx-mtd-driver-from-cvs-mtd.patch
-add-mtd-map-driver-for-intel-ixp2000-npu.patch
-remove-i2o_core.patch
-bio_alloc-cleanup.patch
-tune-vmalloc-size.patch
-tune-vmalloc-size-docs.patch
-reduce-_do_execve-stack-usage.patch
-reduce-_do_execve-stack-usage-fix.patch
-fix-write-return-values-for-tmpfs.patch
-fix-write-return-values-for-reiserfs.patch

 Merged

+ext3-journal-data-fsync-fix.patch

 Fix fsync() with ext3's data=journal mode

+softirqs-fix-latency-of-softirq-processing.patch

 softorq latency fix

+mmtimer-cleanups.patch
+mmtimer-cleanups-2.patch

 Clean up new mmtimer driver

+idr-missed-unlock.patch

 idr locking fix

+add-missing-linux-syscallsh-includes.patch
+add-missing-linux-syscallsh-includes-fix.patch

 syscalls.h cleanups

+bttv-bugfix.patch

 bttv fix

+fbdev-fix-userland-compile-breakage.patch
+fbcon-fix-fbcons-setup-routine.patch
+fbdev-initialize-i810fb-after-agpgart.patch
+fbdev-arrange-driver-order-in-makefile.patch

 framebuffer updates

+i8042-acpi-enumeration-update.patch

 8042 ACPI enumeration, version 42.

+e1000-dma_mapping-build-fix.patch

 e1000 build fix for the bk-netdev tree.

+ppc32-85xx-spurious-interrupt-bug.patch
+macintosh-macserial-replaceschedule_timeout-with-msleep_interruptible.patch
+macintosh-therm_windtunnel-replace-schedule_timeout-with-msleep_interruptible.patch
+ppc64-user-tasks-must-have-a-valid-threadregs.patch
+ppc64-iseries-allow-ibmvscsic-to-initialise.patch

 ppc/ppc64 updates

-tty-locking-for-269rc2.patch
-tty-locking-for-269rc2-fixes.patch
+tty-drivers-take-two.patch

 New version of the tty locking rework patch.  (Alan just released an even
 newer one - that'll be for next -mm).

+ext3-rsv-use-before-initialise-fix.patch

 ext3 reservation possible-oops-fix

+ia64-non-numa-build-fix.patch

 Hack around ia64 non-compile problem.

-nicksched.patch
-nicksched-sched_fifo-fix.patch
-sched-smtnice-fix.patch
+zaphod-scheduler.patch
+zaphod-build-fix.patch

 Single Priority Array (SPA) O(1) CPU Scheduler -- ZAPHOD Version

-sched-vfs-fix-scheduling-latencies-in-invalidate_inodes.patch

 Was buggy.

+break-latency-in-invalidate_list.patch

 Fix it.

+lockmeter-lockmeter-fixes-for-preempt-case.patch
+lockmeter2-build-fix.patch
+lockmeter-in_lock_functions-fix.patch
+lockmeter-in_lock_functions-fix-2.patch
+lockmeter-build-fix-42.patch
+lockmeter-lockmeter-fix-for-generic_read_trylock.patch

 Various lockmeter fixes.

-add-support-for-it8212-ide-controllers.patch

 bk-ide-dev broke this.  I passed it all over to Bart.

+cachefs-fixed-typos-that-cause-wrong-pointer-to-be-kunmapped.patch

 cachefs fix

+afs-cachefs-dependency-fix.patch

 AFS build fix

+scsi-qla-not-working-on-latest-mm-sn2.patch
+qla2xxx-less-posting.patch

 qlogic driver fixes

+crashdump-documentation.patch
+crashdump-memory-preserving-reboot-using-kexec.patch
+crashdump-routines-for-copying-dump-pages.patch
+crashdump-kmap-build-fix.patch
+crashdump-register-snapshotting-before-kexec-boot.patch
+crashdump-elf-format-dump-file-access.patch
+crashdump-linear-raw-format-dump-file-access.patch

 kexec-based crashdump.

+cpusets-fix-race-in-cpuset_add_file.patch
+cpusets-remove-more-casts.patch
+cpusets-make-config_cpusets-the-default-in-sn2_defconfig.patch

 cpusets fixes

+reiser4-plugin_set_done-memleak-fix.patch
+reiser4-init-max_atom_flusers.patch
+reiser4-parse-options-reduce-stack-usage.patch
+reiser4-sparce64-warning-fix.patch
+reiser4-x86_64-warning-fix.patch
+reiser4-fix-mount-option-parsing.patch
+reiser4-parse-option-cleanup.patch
+reiser4-comment-fix.patch
+reiser4-fill_super-improve-warning.patch
+reiser4-disable-pseudo.patch
+reiser4-disable-repacker.patch

 reiser4 update

+floppy-acpi-enumeration-update.patch

 Fixes for the find-floppies-using-ACPi patches

+wait_on_bit-must-loop.patch
+jbd-wakeup-fix.patch

 Fix the new wakeup code.

+enable_irq-backtrace.patch

 Add a dump_stack() to the "unbalanced enable interrupt" debug code.

+fbdev-add-iomem-annotations-to-fbmemc.patch
+fbdev-add-iomem-annotations-to-cfbimgbltc.patch
+fbdev-add-iomem-annotations-to-i810fb.patch
+fbdev-add-iomem-annotations-to-vga16fbc.patch

 framebuffer updates

-incorrect-pci-interrupt-assignment-on-es7000-for-pin-zero.patch

 This was causing problems.

+v4l-msp3400-cleanup.patch
+v4l-tuner-update.patch
+v4l-bttv-update.patch
+v4l-dvb-cx88-driver-update.patch
+v4l-dvb-cx88-driver-update-fix.patch

 video-for-linux updates

+DVB-update-saa7146.patch
+DVB-documentation-update.patch
+DVB-skystar2-dvb-bt8xx-update.patch
+DVB-dvb-core-update.patch
+DVB-frontend-conversion.patch
+DVB-frontend-conversion2.patch
+DVB-frontend-conversion3.patch
+DVB-frontend-conversion4.patch
+DVB-add-frontend-1-2.patch
+DVB-add-frontend-2-2.patch
+DVB-new-driver-dibusb.patch
+DVB-misc-driver-updates.patch
+DVB-frontend-updates.patch
+V4L-follow-changes-in-saa7146.patch

 DVB updates

+roundup-pow-two.patch

 Add roundup_power_of_two() helper function

+a-simple-fifo-implementation.patch

 byte ringbuffer driver

+add-hook-for-pci-resource-deallocation.patch

 adds a hook 'pcibios_disable_device()' into pci_disable_device()

+replace-hard-coded-modverdir-in-modpost.patch

 modpost cleanup

+fix-for-default-acl-handling-on-reiserfs.patch

 reiserfs fix

+pmac-dont-add-=iso-8859-1q=22=b0c=22=-suffix-in-sys.patch

 Don't returns dopey non-ASCII characters in sysfs

+list_replace_rcu-in-include-linux-listh.patch

 Add list_replace_rcu()

+via-velocity-kconfig-fix.patch

 Kconfig fix

+mips-fixed-vr41xx-serial.patch
+mips-fixed-initialization-error.patch
+mips-fixed-undeclared-giu_cascade.patch

 mips fixlets

+gen_init_cpio-uses-external-file-list.patch

 initramfs fixes

+ia64-alignment-error-stack-dump.patch

 do a dump_stack() on ia64 access alignment errors

+compat_sys_fcntl64-fix-for-locking-near-end-of-file.patch

 fix compat_sys_fcntl64

+changed-pci_find_device-to-pci_get_device.patch

 Finish pci_find_device() renaming

+wanpipe-sdla-driver-gcc-34-fixes.patch
+specialix-rio-driver-gcc-34-fixes.patch

 gcc-3.4 fixes

+fix-make-o=-for-ppc64-boot.patch

 ppc64 kbuild fix

+3c59x-missing-pci_disable_device.patch

 3c59x pci fix

+remove-mod_inc_use_count-mod_dec_use_count.patch

 MOC_INC_USE_COUNT is dead

+mark-inter_module_-deprecated.patch

 Deprecate the inter_module_get functions.

+dont-include-linux-sysctlh-in-linux-securityh.patch

 Header heirarchy cleanup

+mips-fixed-definition-order-of-_sigchld.patch

 MIPS fix

+reduce-stack-consumption-in-load_elf_binary.patch

 stack reduction

+check-copy_from_user-return-value-in-act2000_isa_download.patch

 Check copy_from_user() reutrn value.

+s390-core-changes.patch
+s390-dasd-driver.patch
+s390-qeth-network-driver.patch

 s390 update

+cleanup-move-call-to-update_process_times.patch
+cleanup-remove-unused-definitions-from-timexh.patch
+cleanup-timeh-timesh-timexh-and-jiffiesh.patch

 time header file cleanups

+fix-dcache-lookup.patch
+remove-d_bucket.patch
+remove-d_bucket-warning-fix.patch
+document-rcu-based-dcache-lookup.patch

 dcache fixes/cleanups

+devices-txt-update.patch

 Update devices.txt

+via82xx-fix.patch

 Fix this driver

+round-log-buffer-size-to-power-of-two.patch

 Make sure the printk buffer always has a power-of-two size.

+add-tainted-bit-for-machine-checks.patch

 Taint the kernel if it failed machine checks

+device-mapper-fix-minor-number-check.patch
+device-mapper-rename-emit-macro.patch
+device-mapper-mirror-log-sync-optional.patch

 DM update

+powernow-k7-fix-latency-calculation.patch

 cpufreq fix

+fix-diskstats_show-accounting-with-preempt.patch

 preempt safety for disk stats.

+update-maintainers-credits.patch

 MAINTAINERS update

+net-airport-replace-schedule_timeout-with-ssleep-msleep.patch

 msleep() conversion

+fix-generic-direct-io-code-for-xfs.patch

 Make the reworked generic direct-io code play nicely with XFS.




number of patches in -mm: 510
number of changesets in external trees: 592
number of patches in -mm only: 492
total patches: 1084





All 510 patches:


linus.patch

ext3-journal-data-fsync-fix.patch
  ext3: journalled data fsync fix

softirqs-fix-latency-of-softirq-processing.patch
  softirqs: fix latency of softirq processing

mmtimer-cleanups.patch
  mmtimer cleanups

mmtimer-cleanups-2.patch
  mmtimer-cleanups-2

idr-missed-unlock.patch
  idr: fix missing spin_unlock()

x86_64-profiling-oops-workaround.patch
  x86_64 profiling oops workaround

add-missing-linux-syscallsh-includes.patch
  add missing linux/syscalls.h includes

add-missing-linux-syscallsh-includes-fix.patch
  add-missing-linux-syscallsh-includes-fix

bttv-bugfix.patch
  bttv bugfix

fbdev-fix-userland-compile-breakage.patch
  fbdev: Fix userland compile breakage

fbcon-fix-fbcons-setup-routine.patch
  fbcon: fix fbcon's setup routine

fbdev-initialize-i810fb-after-agpgart.patch
  fbdev: Initialize i810fb after agpgart

fbdev-arrange-driver-order-in-makefile.patch
  fbdev: Arrange driver order in Makefile

distinct-tgid-tid-cpu-usage.patch
  distinct tgid/tid CPU usage

show-aggregate-per-process-counters-in-proc-pid-stat-2.patch
  show aggregate per-process counters in /proc/PID/stat 2

exec-fix-posix-timers-leak-and-pending-signal-loss.patch
  exec: fix posix-timers leak and pending signal loss

__set_page_dirty_nobuffers-mappings.patch
  __set_page_dirty_nobuffers mappings

sysfs-backing-store-prepare-file_operations.patch
  sysfs backing store - prepare sysfs_file_operations helpers

sysfs-backing-store-prepare-file_operations-fix.patch
  fix oops with firmware loading

sysfs-backing-store-add-sysfs_dirent.patch
  sysfs backing store - add sysfs_direct structure

sysfs-backing-store-use-sysfs_dirent-tree-in-removal.patch
  sysfs backing store: use sysfs_dirent based tree in file removal

sysfs-backing-store-use-sysfs_dirent-tree-in-dir-file_operations.patch
  sysfs backing store: use sysfs_dirent based tree in dir file operations

sysfs-backing-store-stop-pinning-dentries-inodes-for-leaves.patch
  sysfs backing store: stop pinning dentries/inodes for leaf entries

bk-acpi.patch

acpi-compile-fix.patch
  acpi-compile-fix

acpi-x86_64-build-fix.patch
  acpi x86_64 build fix

bk-agpgart.patch

bk-alsa.patch

bk-cpufreq.patch

bk-driver-core.patch

bk-ia64.patch

bk-ide-dev.patch

bk-ieee1394.patch

bk-input.patch

fix-smm-failures-on-e750x-systems.patch
  fix SMM failures on E750x systems

vsxxxaac-fixups.patch
  vsxxxaa.c fixups

allow-i8042-register-location-override-2.patch
  allow i8042 register location override #2

i8042-acpi-enumeration-update.patch
  i8042 ACPI enumeration update

bk-netdev.patch

bk-ntfs.patch

bk-pci.patch

bk-pnp.patch

bk-power.patch

bk-scsi.patch

bk-scsi-target.patch

qlogic-oops-fix.patch
  qlogic oops fix

tmscsim-build-fix.patch
  tmscsim-build-fix

bk-usb.patch

bk-watchdog.patch

mm.patch
  add -mmN to EXTRAVERSION

mm-swsusp-make-sure-we-do-not-return-to-userspace-where-image-is-on-disk.patch
  -mm swsusp: make sure we do not return to userspace where image is on disk

mm-swsusp-copy_page-is-harmfull.patch
  -mm swsusp: copy_page is harmfull

swsusp-fix-highmem.patch
  swsusp: fix highmem

swsusp-do-not-disable-platform-swsusp-because-s4bios-is-available.patch
  swsusp: do not disable platform swsusp because S4bios is available

swsusp-fix-default-powerdown-mode.patch
  swsusp: fix default powerdown mode

mark-old-power-managment-as-deprecated-and-clean-it-up.patch
  Mark old power managment as deprecated and clean it up

use-global-system_state-to-avoid-system-state-confusion.patch
  Use global system_state to avoid system-state confusion

swsusp-error-do-not-oops-after-allocation-failure.patch
  swsusp: do not oops after allocation failure

swsusp-documentation-update.patch
  swsusp: Documentation update

small-cleanups-for-swsusp.patch
  Small cleanups for swsusp

swsusp-kill-crash-when-too-much-memory-is-free.patch
  swsusp: kill crash when too much memory is free

swsusp-progress-in-percent.patch
  swsusp: progress in percent

swsusp-clean-up-reading.patch
  swsusp: clean up reading

swsusp-another-simplification.patch
  swsusp: another simplification

radeon-do-not-blank-screen-during-suspend.patch
  Radeon: do not blank screen during suspend

acpi-proc-simplify-error-handling.patch
  acpi proc: error handling

e1000-dma_mapping-build-fix.patch
  e1000 sparc64 dma_mapping build fix

network-packet-tracer-module-using-kprobes-interface.patch
  Network packet tracer module using kprobes interface.

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

kgdb-ia64-support.patch
  IA64 kgdb support
  ia64 kgdb repair and cleanup
  ia64 kgdb fix

kgdb-ia64-fixes.patch
  kgdb: ia64 fixes

make-tree_lock-an-rwlock.patch
  make mapping->tree_lock an rwlock

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update
  must-fix update
  mustfix lists

ppc32-85xx-spurious-interrupt-bug.patch
  ppc32: 85xx spurious interrupt bug

macintosh-macserial-replaceschedule_timeout-with-msleep_interruptible.patch
  macintosh/macserial: replace schedule_timeout() with msleep_interruptible()

macintosh-therm_windtunnel-replace-schedule_timeout-with-msleep_interruptible.patch
  macintosh/therm_windtunnel: replace schedule_timeout() with msleep_interruptible()

ppc64-user-tasks-must-have-a-valid-threadregs.patch
  ppc64: User tasks must have a valid thread.regs

ppc64-iseries-allow-ibmvscsic-to-initialise.patch
  ppc64 iSeries: allow ibmvscsic to initialise

ppc64-reloc_hide.patch

tty-drivers-take-two.patch
  tty drivers take two

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

dev-mem-restriction-patch.patch
  /dev/mem restriction patch

get_user_pages-handle-VM_IO.patch
  fix get_user_pages() against mappings of /dev/mem

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

ext3_rsv_cleanup.patch
  ext3 block reservation patch set -- ext3 preallocation cleanup

ext3_rsv_base.patch
  ext3 block reservation patch set -- ext3 block reservation
  ext3 reservations: fix performance regression
  ext3 block reservation patch set -- mount and ioctl feature
  ext3 block reservation patch set -- dynamically increase reservation window
  ext3 reservation ifdef cleanup patch
  ext3 reservation max window size check patch
  ext3 reservation file ioctl fix

ext3-reservation-default-on.patch
  ext3 reservation: default to on

ext3-lazy-discard-reservation-window-patch.patch
  ext3 lazy discard reservation window patch
  ext3 discard reservation in last iput fix patch
  Fix lazy reservation discard
  ext3 reservations: bad_inode fix
  ext3 reservation discard race fix

ext3-reservations-spelling-fixes.patch
  ext3 reservations: Spelling fixes

ext3-reservations-renumber-the-ext3-reservations-ioctls.patch
  ext3 reservations: Renumber the ext3 reservations ioctls

ext3-reservations-remove-unneeded-declaration.patch
  ext3 reservations: Remove unneeded declaration.

ext3-reservations-turn-ext3-per-sb-reservations-list-into-an-rbtree.patch
  ext3 reservations: Turn ext3 per-sb reservations list into an rbtree.

ext3-reservations-split-the-reserve_window-struct-into-two.patch
  ext3 reservations: Split the "reserve_window" struct into two

ext3-reservations-smp-protect-the-reservation-during-allocation.patch
  ext3 reservations: SMP-protect the reservation during allocation

ext3-rsv-use-before-initialise-fix.patch
  ext3 reservations: use before initialised fix

ext3-reservations-window-allocation-fix.patch
  ext3 reservations window allocation fix

ext3-reservation-window-size-increase-incorrectly-fix.patch
  ext3 reservation window size increase incorrectly fix

perfctr-core.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core
  CONFIG_PERFCTR=n build fix
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][6/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: misc

perfctr-i386.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][2/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: i386
  perfctr #if/#ifdef cleanup
  perfctr Dothan support
  perfctr x86_tests build fix
  perfctr x86 init bug
  perfctr: K8 fix for internal benchmarking code
  perfctr x86 update

perfctr-prescott-fix.patch
  Prescott fix for perfctr

perfctr-x86_64.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][3/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: x86_64

perfctr-ppc.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][4/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: PowerPC
  perfctr ppc32 update
  perfctr update 4/6: PPC32 cleanups
  perfctr ppc32 buglet fix

perfctr-virtualised-counters.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][5/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: virtualised counters
  perfctr update 6/6: misc minor cleanups
  perfctr update 3/6: __user annotations
  perfctr-cpus_complement-fix
  perfctr cpumask cleanup
  perfctr SMP hang fix

make-perfctr_virtual-default-in-kconfig-match-recommendation.patch
  Make PERFCTR_VIRTUAL default in Kconfig match recommendation  in help text

perfctr-ifdef-cleanup.patch
  perfctr ifdef cleanup

perfctr-update-2-6-kconfig-related-updates.patch
  perfctr update 2/6: Kconfig-related updates

perfctr-update-5-6-reduce-stack-usage.patch
  perfctr update 5/6: reduce stack usage

perfctr-low-level-documentation.patch
  perfctr low-level documentation
  perfctr documentation update

perfctr-inheritance-1-3-driver-updates.patch
  perfctr inheritance 1/3: driver updates
  perfctr inheritance illegal sleep bug

perfctr-inheritance-2-3-kernel-updates.patch
  perfctr inheritance 2/3: kernel updates

perfctr-inheritance-3-3-documentation-updates.patch
  perfctr inheritance 3/3: documentation updates

perfctr-inheritance-locking-fix.patch
  perfctr inheritance locking fix

ext3-online-resize-patch.patch
  ext3: online resizing
  ext3-online-resize-warning-fix

sched-trivial-sched-changes.patch
  sched: trivial sched changes

sched-add-cpu_down_prepare-notifier.patch
  sched: add CPU_DOWN_PREPARE notifier

sched-integrate-cpu-hotplug-and-sched-domains.patch
  sched: integrate cpu hotplug and sched domains

sched-arch_destroy_sched_domains-warning-fix.patch
  sched: arch_destroy_sched_domains warning fix

sched-sched-add-load-balance-flag.patch
  sched: sched add load balance flag

sched-sched-add-load-balance-flag-fix.patch
  sched: ia64 load balancing fix

sched-remove-disjoint-numa-domains-setup.patch
  sched: remove disjoint NUMA domains setup

sched-make-domain-setup-overridable.patch
  sched: make domain setup overridable

sched-make-domain-setup-overridable-rename.patch
  sched-make-domain-setup-overridable: rename IDLE

sched-make-domain-setup-overridable-fix.patch
  sched: make domain setup overridable fix

sched-ia64-add-disjoint-numa-domain-support.patch
  sched: IA64 add disjoint NUMA domain support

sched-fix-domain-debug-for-isolcpus.patch
  sched: fix domain debug for isolcpus

sched-enable-sd_load_balance.patch
  sched: enable SD_LOAD_BALANCE

sched-hotplug-add-a-cpu_down_failed-notifier.patch
  sched: hotplug add a CPU_DOWN_FAILED notifier

sched-use-cpu_down_failed-notifier.patch
  sched: use CPU_DOWN_FAILED notifier

sched-fixes-for-ia64-domain-setup.patch
  sched: fixes for ia64 domain setup

ia64-non-numa-build-fix.patch
  ia64 non numa build fix

sched-print-preempt-count.patch
  sched-print-preempt-count

zaphod-scheduler.patch
  zaphod CPU scheduler

zaphod-build-fix.patch
  zaphod-build-fix

preempt-smp.patch
  improve preemption on SMP

preempt-cleanup.patch
  preempt cleanup

preempt-cleanup-fix.patch
  preempt-cleanup-fix

add-lock_need_resched.patch
  add lock_need_resched()

sched-add-cond_resched_softirq.patch
  sched: add cond_resched_softirq()

sched-fix-latency-in-random-driver.patch
  sched: fix latency in random driver

sched-ext3-fix-scheduling-latencies-in-ext3.patch
  sched: ext3: fix scheduling latencies in ext3

break-latency-in-invalidate_list.patch
  break latency in invalidate_list()

sched-vfs-fix-scheduling-latencies-in-prune_dcache-and-select_parent.patch
  sched: vfs: fix scheduling latencies in prune_dcache() and select_parent()

sched-net-fix-scheduling-latencies-in-netstat.patch
  sched: net: fix scheduling latencies in netstat

sched-net-fix-scheduling-latencies-in-__release_sock.patch
  sched: net: fix scheduling latencies in __release_sock

sched-mm-fix-scheduling-latencies-in-copy_page_range.patch
  sched: mm: fix scheduling latencies in copy_page_range()

sched-mm-fix-scheduling-latencies-in-unmap_vmas.patch
  sched: mm: fix scheduling latencies in unmap_vmas()

sched-mm-fix-scheduling-latencies-in-get_user_pages.patch
  sched: mm: fix scheduling latencies in get_user_pages()

sched-mm-fix-scheduling-latencies-in-filemap_sync.patch
  sched: mm: fix scheduling latencies in filemap_sync()

sched-pty-fix-scheduling-latencies-in-ptyc.patch
  sched: pty: fix scheduling latencies in pty.c

fix-keventd-execution-dependency.patch
  fix keventd execution dependency

sched-fix-scheduling-latencies-in-mttrc.patch
  sched: fix scheduling latencies in mttr.c

sched-fix-scheduling-latencies-in-vgaconc.patch
  sched: fix scheduling latencies in vgacon.c

sched-fix-scheduling-latencies-for-preempt-kernels.patch
  sched: fix scheduling latencies for !PREEMPT kernels

lockmeter-2.patch
  lockmeter: lockmeter for out-of-line-spinlocks
  ia64 CONFIG_LOCKMETER fix
  lockmeter-build-fix
  lockmeter for x86_64

lockmeter-lockmeter-fixes-for-preempt-case.patch
  lockmeter: lockmeter fixes for preempt case

lockmeter2-build-fix.patch
  lockmeter2-build-fix

lockmeter-in_lock_functions-fix.patch
  lockmeter: in_lock_functions() fix

lockmeter-in_lock_functions-fix-2.patch
  lockmeter-in_lock_functions-fix-2

lockmeter-build-fix-42.patch
  lockmeter-build-fix-42

lockmeter-lockmeter-fix-for-generic_read_trylock.patch
  lockmeter: lockmeter fix for generic_read_trylock

ext3_bread-cleanup.patch
  ext3_bread() cleanup

pcmcia-implement-driver-model-support.patch
  pcmcia: implement driver model support

pcmcia-update-network-drivers.patch
  pcmcia: update network drivers

pcmcia-update-wireless-drivers.patch
  pcmcia: update wireless drivers

pcmcia-fix-eject-lockup.patch
  pcmcia: fix eject lockup

pcmcia-add-hotplug-support.patch
  pcmcia: add *hotplug support

linux-2.6.8.1-49-rpc_workqueue.patch
  nfs: RPC: Convert rpciod into a work queue for greater flexibility

linux-2.6.8.1-50-rpc_queue_lock.patch
  nfs: RPC: Remove the rpc_queue_lock global spinlock

dvdrw-support-for-267-bk13.patch
  DVD+RW support for 2.6.7-bk13

packet-writing-credits.patch
  packet-writing: add credits

cdrw-packet-writing-support-for-267-bk13.patch
  CDRW packet writing support
  packet: remove #warning
  packet writing: door unlocking fix
  pkt_lock_door() warning fix
  Fix race in pktcdvd kernel thread handling
  Fix open/close races in pktcdvd
  packet writing: review fixups
  Remove pkt_dev from struct pktcdvd_device
  packet writing: convert to seq_file

dvd-rw-packet-writing-update.patch
  Packet writing support for DVD-RW and DVD+RW discs.
  Get blockdev size right in pktcdvd after switching discs

packet-writing-docco.patch
  packet writing documentation
  Trivial CDRW packet writing doc update

control-pktcdvd-with-an-auxiliary-character-device.patch
  Control pktcdvd with an auxiliary character device
  Subject: Re: 2.6.8-rc2-mm2
  control-pktcdvd-with-an-auxiliary-character-device-fix

simplified-request-size-handling-in-cdrw-packet-writing.patch
  Simplified request size handling in CDRW packet writing

fix-setting-of-maximum-read-speed-in-cdrw-packet-writing.patch
  Fix setting of maximum read speed in CDRW packet writing

packet-writing-reporting-fix.patch
  Packet writing reporting fixes

speed-up-the-cdrw-packet-writing-driver.patch
  Speed up the cdrw packet writing driver

packet-writing-avoid-bio-hackery.patch
  packet writing: avoid BIO hackery

cdrom-buffer-size-fix.patch
  cdrom: buffer sizing fix

cpufreq-driver-for-nforce2-kernel-267.patch
  cpufreq driver for nForce2

allow-modular-ide-pnp.patch
  allow modular ide-pnp

create-nodemask_t.patch
  Create nodemask_t
  nodemask fix
  nodemask build fix

allow-x86_64-to-reenable-interrupts-on-contention.patch
  Allow x86_64 to reenable interrupts on contention

i386-hotplug-cpu.patch
  i386 Hotplug CPU

hotplug-cpu-fix-apic-queued-timer-vector-race.patch
  Hotplug cpu: Fix APIC queued timer vector race

hotplug-cpu-move-cpu_online_map-clear-to-__cpu_disable.patch
  Hotplug cpu: Move cpu_online_map clear to __cpu_disable

igxb-speedup.patch
  igxb speedup

serialize-access-to-ide-devices.patch
  serialize access to ide devices

remove-unconditional-pci-acpi-irq-routing.patch
  remove unconditional PCI ACPI IRQ routing

propagate-pci_enable_device-errors.patch
  propagate pci_enable_device() errors

disable-atykb-warning.patch
  disable atykb "too many keys pressed" warning

reiserfs-rename-struct-key.patch
  reiserfs-rename-struct-key

add-some-key-management-specific-error-codes.patch
  Add some key management specific error codes

keys-new-error-codes-for-alpha-mips-pa-risc-sparc-sparc64.patch
  keys: new error codes for Alpha, MIPS, PA-RISC, Sparc & Sparc64

implement-in-kernel-keys-keyring-management.patch
  implement in-kernel keys & keyring management
  keys build fix
  keys & keyring management update patch
  implement-in-kernel-keys-keyring-management-update-build-fix
  implement-in-kernel-keys-keyring-management-update-build-fix-2
  key management patch cleanup

make-key-management-code-use-new-the-error-codes.patch
  Make key management code use new the error codes

keys-permission-fix.patch
  keys: permission fix

keys-keyring-management-keyfs-patch.patch
  keys & keyring management: keyfs patch

keyfs-build-fix.patch
  keyfs build fix

implement-in-kernel-keys-keyring-management-afs-workaround.patch
  implement-in-kernel-keys-keyring-management afs workaround

support-supplementary-information-for-request-key.patch
  Support supplementary information for request-key

make-key-management-use-syscalls-not-prctls.patch
  Make key management use syscalls not prctls

move-syscall-declarations-from-linux-keyh-2.patch
  Move syscall declarations from linux/key.h #2

make-key-management-use-syscalls-not-prctls-build-fix.patch
  make-key-management-use-syscalls-not-prctls build fix

export-file_ra_state_init-again.patch
  Export file_ra_state_init() again

cachefs-filesystem.patch
  CacheFS filesystem

cachefs-fixed-typos-that-cause-wrong-pointer-to-be-kunmapped.patch
  cachefs: fixed typos that cause wrong pointer to be kunmapped

cachefs-return-the-right-error-upon-invalid-mount.patch
  CacheFS: return the right error upon invalid mount

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

make-afs-use-cachefs.patch
  Make AFS use CacheFS

afs-cachefs-dependency-fix.patch
  afs-cachefs-dependency-fix

ide-probe.patch
  ide probe

268-rc3-jffs2-unable-to-read-filesystems.patch
  jffs2 unable to read filesystems

qlogic-isp2x00-remove-needless-busyloop.patch
  QLogic ISP2x00: remove needless busyloop

scsi-qla-not-working-on-latest-mm-sn2.patch
  SCSI QLA not working on latest *-mm SN2

qla2xxx-less-posting.patch
  qla2xxx: less posting

jffs2-mount-options-discarded.patch
  JFFS2 mount options discarded

assign_irq_vector-section-fix.patch
  assign_irq_vector __init section fix

find_isa_irq_pin-should-not-be-__init.patch
  find_isa_irq_pin should not be __init

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

kexec-machine_shutdownx86_64.patch
  kexec: machine_shutdown.x86_64

kexec-kexecx86_64.patch
  kexec: kexec.x86_64

kexec-machine_shutdowni386.patch
  kexec: machine_shutdown.i386

kexec-kexeci386.patch
  kexec: kexec.i386

kexec-use_mm.patch
  kexec: use_mm

kexec-kexecppc.patch
  kexec: kexec.ppc

kexec-ppc-kexec-kconfig-misplacement.patch
  kexec ppc KEXEC Kconfig misplacement

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

new-bitmap-list-format-for-cpusets.patch
  new bitmap list format (for cpusets)

cpusets-big-numa-cpu-and-memory-placement.patch
  cpusets - big numa cpu and memory placement

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

kallsyms-data-size-reduction--lookup-speedup.patch
  kallsyms data size reduction / lookup speedup

inconsistent-kallsyms-fix.patch
  Inconsistent kallsyms fix

kallsyms-correct-type-char-in-proc-kallsyms.patch
  kallsyms: correct type char in /proc/kallsyms

kallsyms-fix-sparc-gibberish.patch
  kallsyms: fix sparc gibberish

tioccons-security.patch
  TIOCCONS security

fix-process-start-times.patch
  Fix reporting of process start times

fix-comment-in-include-linux-nodemaskh.patch
  Fix comment in include/linux/nodemask.h

x86-build-issue-with-software-suspend-code.patch
  Fix x86 build issue with software suspend code

hpt366c-wrong-timings-used-since-268.patch
  hpt366.c: wrong timings

move-waitqueue-functions-to-kernel-waitc.patch
  move waitqueue functions to kernel/wait.c

standardize-bit-waiting-data-type.patch
  standardize bit waiting data type

provide-a-filesystem-specific-syncable-page-bit-fix-2.patch
  provide-a-filesystem-specific-syncable-page-bit-fix-2

consolidate-bit-waiting-code-patterns.patch
  consolidate bit waiting code patterns
  consolidate-bit-waiting-code-patterns-cleanup
  __wait_on_bit-fix

eliminate-bh-waitqueue-hashtable.patch
  eliminate bh waitqueue hashtable

eliminate-bh-waitqueue-hashtable-fix.patch
  wait_on_bit_lock() must test_and_set_bit(), not test_bit()

eliminate-inode-waitqueue-hashtable.patch
  eliminate inode waitqueue hashtable

move-wait-ops-contention-case-completely-out-of-line.patch
  move wait ops' contention case completely out of line

reduce-number-of-parameters-to-__wait_on_bit-and-__wait_on_bit_lock.patch
  reduce number of parameters to __wait_on_bit() and __wait_on_bit_lock()

wait_on_bit-must-loop.patch
  wait_on_bit() must loop

document-wake_up_bits-requirement-for-preceding-memory-barriers.patch
  document wake_up_bit()'s requirement for preceding memory barriers

jbd-wakeup-fix.patch
  jbd wakeup fix

3c59x-pm-fix.patch
  3c59x: enable power management unconditionally

serial-mpsc-driver.patch
  Serial MPSC driver

serial-add-support-for-non-standard-xtals-to-16c950-driver.patch
  serial: add support for non-standard XTALs to 16c950 driver

add-support-for-possio-gcc-aka-pcmcia-siemens-mc45.patch
  Add support for Possio GCC AKA PCMCIA Siemens MC45

add-smc91x-ethernet-for-lpd7a40x.patch
  add SMC91x ethernet for LPD7A40X

m32r-upgrade-for-mm5-changes.patch
  m32r: upgrade for -mm5 changes

vm-pageout-throttling.patch
  vm: pageout throttling

fix-race-in-sysfs_read_file-and-sysfs_write_file.patch
  Fix race in sysfs_read_file() and sysfs_write_file()

possible-race-in-sysfs_read_file-and-sysfs_write_file-update.patch
  Possible race in sysfs_read_file() and sysfs_write_file()

md-add-interface-for-userspace-monitoring-of-events.patch
  md: add interface for userspace monitoring of events.

unreachable-code-in-ext3_direct_io.patch
  unreachable code in ext3_direct_IO()

fix-for-nforce2-secondary-ide-getting-wrong-irq.patch
  Fix for NForce2 secondary IDE getting wrong IRQ

revert-allow-oem-written-modules-to-make-calls-to-ia64-oem-sal-functions.patch
  revert "allow OEM written modules to make calls to ia64 OEM SAL functions"

misrouted-irq-recovery-take-2.patch
  Misrouted IRQ recovery, take 2

misrouted-irq-recovery-take-2-cleanup.patch
  misrouted-irq-recovery-take-2 cleanup

misrouted-irq-recovery-take-2-fix.patch
  misrouted-irq-recovery-take-2 fix

misrouted-irq-recovery-docs.patch
  misrouted-irq-recovery documentation

enable_irq-backtrace.patch
  enable_irq-backtrace

cfq-iosched-v2.patch
  CFQ iosched v2

cfq-v2-update.patch
  cfq v2 update

cfq-fix-allocated-counts.patch
  cfq: fix allocated counts

cfq-warnings.patch
  cfq warnings

dont-export-blkdev_open-and-def_blk_ops.patch
  don't export blkdev_open and def_blk_ops

remove-dead-code-from-fs-mbcachec.patch
  remove dead code from fs/mbcache.c

remove-posix_acl_masq_nfs_mode.patch
  remove posix_acl_masq_nfs_mode

dont-export-shmem_file_setup.patch
  don't export shmem_file_setup

remove-pm_find-unexport-pm_send.patch
  remove pm_find, unexport pm_send

remove-dead-code-and-exports-from-signalc.patch
  remove dead code and exports from signal.c

unexport-proc_sys_root.patch
  unexport proc_sys_root

unexport-is_subdir-and-shrink_dcache_anon.patch
  unexport is_subdir and shrink_dcache_anon

unexport-devfs_mk_symlink.patch
  unexport devfs_mk_symlink

unexport-do_execve-do_select.patch
  unexport do_execve/do_select

unexport-exit_mm.patch
  unexport exit_mm

unexport-files_lock-and-put_filp.patch
  unexport files_lock and put_filp

unexport-f_delown.patch
  unexport f_delown

unexport-lookup_create.patch
  unexport lookup_create

remove-wake_up_all_sync.patch
  remove wake_up_all_sync

remove-set_fs_root-set_fs_pwd.patch
  remove set_fs_root/set_fs_pwd

md-remove-md_flush_all.patch
  md: remove md_flush_all

md-make-retry_list-non-global-in-raid1-and-multipath.patch
  md: make retry_list non-global in raid1 and multipath

md-rationalise-issue_flush-function-in-md-personalities.patch
  md: rationalise issue_flush function in md personalities

md-rationalise-unplug-functions-in-md.patch
  md: rationalise unplug functions in md

md-make-sure-md-always-uses-rdev_dec_pending-properly.patch
  md: make sure md always uses rdev_dec_pending properly

md-fix-two-little-bugs-in-raid10.patch
  md: fix two little bugs in raid10

md-modify-locking-when-accessing-subdevices-in-md.patch
  md: modify locking when accessing subdevices in md

generic-acl-support-for-permission.patch
  generic acl support for ->permission

generic-acl-support-for-permission-fix.patch
  generic acl support for ->permission fix

generic-acl-support-for-permission-keyfs-fix.patch
  generic-acl-support-for-permission-keyfs-fix

cacheline-align-pagevec-structure.patch
  Adjust align pagevec structure

fbdev-remove-unnecessary-banshee_wait_idle-from-tdfxfb.patch
  fbdev: remove unnecessary banshee_wait_idle from tdfxfb

fbdev-fix-logo-drawing-failure-for-vga16fb.patch
  fbdev: fix logo drawing failure for vga16fb

fbcon-fix-setup-boot-options-of-fbcon.patch
  fbcon: Fix setup boot options of fbcon

fbdev-pass-struct-device-to-class_simple_device_add.patch
  fbdev: Pass struct device to class_simple_device_add

fbdev-add-tile-blitting-support.patch
  fbdev: Add Tile Blitting support

fbdev-fix-scrolling-corruption.patch
  fbdev: fix scrolling corruption

radeonfb-fix-warnings-about-uninitialized-variables.patch
  radeonfb: Fix warnings about uninitialized variables

fbdev-remove-i810fb-explicit-agp-initialization-hack.patch
  fbdev: Remove i810fb explicit agp initialization hack.

fbdev-add-iomem-annotations-to-fbmemc.patch
  fbdev: Add iomem annotations to fbmem.c

fbdev-add-iomem-annotations-to-cfbimgbltc.patch
  fbdev: Add iomem annotations to cfbimgblt.c

fbdev-add-iomem-annotations-to-i810fb.patch
  fbdev: Add iomem annotations to i810fb

fbdev-add-iomem-annotations-to-vga16fbc.patch
  fbdev: Add iomem annotations to vga16fb.c

fix-for-spurious-interrupts-on-e100-resume-2.patch
  Fix for spurious interrupts on e100 resume 2

compile-fix-3c59x-for-eisa-without-pci.patch
  compile fix 3c59x for eisa without pci

atomic_inc_return-for-i386.patch
  atomic_inc_return() for i386

atomic_inc_return-for-x86_64.patch
  atomic_inc_return() for x86_64

atomic_inc_return-for-arm.patch
  atomic_inc_return() for arm

atomic_inc_return-for-arm26.patch
  atomic_inc_return() for arm26

atomic_inc_return-for-sparc64.patch
  atomic_inc_return() for sparc64

online-cpu-with-maxcpus-option-panics.patch
  Online CPU with maxcpus option panics

remove-dead-exports-from-fs-fat.patch
  remove dead exports from fs/fat/

fat-use-hlist_head-for-fat_inode_hashtable-1-6.patch
  FAT: use hlist_head for fat_inode_hashtable

fat-rewrite-the-cache-for-file-allocation-table-lookup.patch
  FAT: rewrite the cache for file allocation table lookup

fat-cache-lock-from-per-sb-to-per-inode-3-6.patch
  FAT: cache lock from per sb to per inode

fat-the-inode-hash-from-per-module-to-per-sb-4-6.patch
  FAT: the inode hash from per module to per sb

fat-fix-the-race-bitween-fat_free-and-fat_get_cluster.patch
  FAT: Fix the race bitween fat_free() and fat_get_cluster()

fat-remove-debug_pr-6-6.patch
  FAT: remove debug_pr()

fix-for-fsync-ignoring-writing-errors-fat-fix.patch
  fix-for-fsync-ignoring-writing-errors-fat-fix

thinkpad-fnfx-key-driver.patch
  thinkpad fn+fx key driver

rewrite-alloc_pidmap.patch
  pidhashing: rewrite alloc_pidmap()

pidhashing-retain-older-vendor-copyright.patch
  From: William Lee Irwin III <wli@holomorphy.com>
  Subject: [pidhashing] [1/3] retain older vendor copyright

pidhashing-lower-pid_max_limit-for-32-bit-machines.patch
  From: William Lee Irwin III <wli@holomorphy.com>
  Subject: [pidhashing] [2/3] lower PID_MAX_LIMIT for 32-bit machines

pidhashing-enforce-pid_max_limit-in-sysctls.patch
  From: William Lee Irwin III <wli@holomorphy.com>
  Subject: [pidhashing] [3/3] enforce PID_MAX_LIMIT in sysctls

allow-multiple-inputs-in-alternative_input.patch
  Allow multiple inputs in alternative_input

autofs4-allow-map-update-recognition.patch
  autofs4: allow map update recognition

fix-of-race-in-writeback_inodes.patch
  Fix of race in writeback_inodes()

rearrange-of-inode_lock-in-writeback_inodes.patch
  Rearrangement of inode_lock in writeback_inodes()

lighten-mmlist_lock.patch
  lighten mmlist_lock

incorrect-pci-interrupt-assignment-on-es7000-for-platform-gsi.patch
  Incorrect PCI interrupt assignment on ES7000 for platform GSI

incorrect-pci-interrupt-assignment-on-es7000-for-platform-gsi-fix.patch
  incorrect-pci-interrupt-assignment-on-es7000-for-platform-gsi fix

fix-task_mmuc-text-size-reporting.patch
  procfs: fix task_mmu.c text size reporting

sparc32-add-atomic_sub_and_test.patch
  sparc32: add atomic_sub_and_test()

make-console_conditional_schedule-__sched-and-use-cond_resched.patch
  make console_conditional_schedule() __sched and use cond_resched()

report-per-process-pagetable-usage.patch
  report per-process pagetable usage

remove-lock_section-from-x86_64-spin_lock-asm.patch
  remove LOCK_SECTION from x86_64 spin_lock asm

v4l-msp3400-cleanup.patch
  v4l: msp3400 cleanup

v4l-tuner-update.patch
  v4l: tuner update

v4l-bttv-update.patch
  v4l: bttv update

v4l-dvb-cx88-driver-update.patch
  v4l/dvb: cx88 driver update

v4l-dvb-cx88-driver-update-fix.patch
  v4l-dvb-cx88-driver-update-fix

DVB-update-saa7146.patch
  DVB: update saa7146

DVB-documentation-update.patch
  DVB: documentation update

DVB-skystar2-dvb-bt8xx-update.patch
  DVB: skystar2 dvb bt8xx update

DVB-dvb-core-update.patch
  DVB: core update

DVB-frontend-conversion.patch
  DVB: frontend conversion

DVB-frontend-conversion2.patch
  DVB: frontend conversion #2

DVB-frontend-conversion3.patch
  DVB: frontend conversion #3

DVB-frontend-conversion4.patch
  DVB: frontend conversion #4

DVB-add-frontend-1-2.patch
  DVB: add frontend

DVB-add-frontend-2-2.patch
  DVB: add frontend #2

DVB-new-driver-dibusb.patch
  DVB: new driver for mobile USB Budget DVB-T devices

DVB-misc-driver-updates.patch
  DVB: misc driver updates

DVB-frontend-updates.patch
  DVB: frontend updates

V4L-follow-changes-in-saa7146.patch
  V4L: follow changes in saa7146

roundup-pow-two.patch
  implement roundup_pow_two()

a-simple-fifo-implementation.patch
  A simple FIFO implementation

add-hook-for-pci-resource-deallocation.patch
  add hook for PCI resource deallocation

replace-hard-coded-modverdir-in-modpost.patch
  Replace hard-coded MODVERDIR in modpost

fix-for-default-acl-handling-on-reiserfs.patch
  Fix for default ACL handling on ReiserFS

pmac-dont-add-=iso-8859-1q=22=b0c=22=-suffix-in-sys.patch
  pmac: don't add suffix in sys for adt746x driver

list_replace_rcu-in-include-linux-listh.patch
  list_replace_rcu() in include/linux/list.h

via-velocity-kconfig-fix.patch
  via-velocity Kconfig fix

mips-fixed-vr41xx-serial.patch
  mips: fixed vr41xx serial

mips-fixed-initialization-error.patch
  mips: fixed initialization error

mips-fixed-undeclared-giu_cascade.patch
  mips: fixed undeclared giu_cascade

gen_init_cpio-uses-external-file-list.patch
  gen_init_cpio uses external file list

ia64-alignment-error-stack-dump.patch
  ia64-alignment-error-stack-dump

compat_sys_fcntl64-fix-for-locking-near-end-of-file.patch
  compat_sys_fcntl64: fix for locking near end of file

changed-pci_find_device-to-pci_get_device.patch
  Changed pci_find_device to pci_get_device

wanpipe-sdla-driver-gcc-34-fixes.patch
  WANPIPE/SDLA driver gcc-3.4 fixes

specialix-rio-driver-gcc-34-fixes.patch
  Specialix RIO driver gcc-3.4 fixes

fix-make-o=-for-ppc64-boot.patch
  fix make O= for ppc64/boot

3c59x-missing-pci_disable_device.patch
  3c59x: missing pci_disable_device

remove-mod_inc_use_count-mod_dec_use_count.patch
  remove MOD_INC_USE_COUNT/MOD_DEC_USE_COUNT

mark-inter_module_-deprecated.patch
  mark inter_module_* deprecated

dont-include-linux-sysctlh-in-linux-securityh.patch
  don't include <linux/sysctl.h> in <linux/security.h>

mips-fixed-definition-order-of-_sigchld.patch
  mips: fixed definition order of _sigchld

reduce-stack-consumption-in-load_elf_binary.patch
  reduce stack consumption in load_elf_binary

check-copy_from_user-return-value-in-act2000_isa_download.patch
  check copy_from_user return value in act2000_isa_download

s390-core-changes.patch
  s390: core changes

s390-dasd-driver.patch
  s390: dasd driver

s390-qeth-network-driver.patch
  s390: qeth network driver

cleanup-move-call-to-update_process_times.patch
  cleanup: move call to update_process_times.

cleanup-remove-unused-definitions-from-timexh.patch
  cleanup: remove unused definitions from timex.h

cleanup-timeh-timesh-timexh-and-jiffiesh.patch
  cleanup: time.h, times.h, timex.h and jiffies.h

fix-dcache-lookup.patch
  Fix dcache lookup

remove-d_bucket.patch
  Remove d_bucket

remove-d_bucket-warning-fix.patch
  remove-d_bucket warning fix

document-rcu-based-dcache-lookup.patch
  Document RCU based dcache lookup

devices-txt-update.patch
  devices.txt update

via82xx-fix.patch
  via82xx fix

round-log-buffer-size-to-power-of-two.patch
  round log buffer size to power of two

add-tainted-bit-for-machine-checks.patch
  Add tainted bit for machine checks

device-mapper-fix-minor-number-check.patch
  device-mapper: fix minor number check

device-mapper-rename-emit-macro.patch
  device-mapper: rename emit macro

device-mapper-mirror-log-sync-optional.patch
  device-mapper: mirror log sync optional

powernow-k7-fix-latency-calculation.patch
  powernow-k7: fix latency calculation

fix-diskstats_show-accounting-with-preempt.patch
  fix diskstats_show() accounting with PREEMPT

update-maintainers-credits.patch
  update MAINTAINERS/CREDITS

net-airport-replace-schedule_timeout-with-ssleep-msleep.patch
  net/airport: replace schedule_timeout() with ssleep()/msleep()

fix-generic-direct-io-code-for-xfs.patch
  Fix generic direct IO code for XFS



