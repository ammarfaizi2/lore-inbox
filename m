Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266830AbUG1JHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266830AbUG1JHg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 05:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266835AbUG1JHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 05:07:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:43208 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266830AbUG1JGP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 05:06:15 -0400
Date: Wed, 28 Jul 2004 02:04:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.8-rc2-mm1
Message-Id: <20040728020444.4dca7e23.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc2/2.6.8-rc2-mm1/

- Added the bk-power tree to the -mm lineup.  This is Pat Mochel's big
  pmdisk/swsusp consolidation.  Please copy mochel@digitalimplant.org on any
  swsusp problems.

- Added Sam's bk-kbuild tree to the -mm lineup

- The bk-ieee1394 tree is uncontactable so the patch here is old.

- The bk-arm, bk-serial and bk-pcmcia trees have had their server turned
  off, so they're not here.

- The bk-usb repository is currently empty for some reason

- Added a big i2o rewrite.  This accidentally reverts lots of post-2.6.6
  fixes and needs work.

- The lingering bug in the IDE barrier code should be fixed

- Re-introduced the signal-race-fixes patch.  This breaks all architectures
  except x86, x86_64, s390 and ia64.

- If people have patches in here which are important for a 2.6.8 release,
  please let me know.

- This kernel is boot-tested and somewhat stress-tested on x86 and x86_64
  and ia64.  But given the amount of new stuff in here and its general state,
  things may be a bit flakey.




Changes since 2.6.8-rc1-mm1:


 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-alsa.patch
 bk-cifs.patch
 bk-dma-declare-coherent-memory.patch
 bk-cpufreq.patch
 bk-drm.patch
 bk-ieee1394.patch
 bk-input.patch
 bk-kbuild.patch
 bk-libata.patch
 bk-mpc52xx.patch
 bk-netdev.patch
 bk-ntfs.patch
 bk-pci.patch
 bk-pnp.patch
 bk-power.patch
 bk-scsi.patch

 External trees

-kbuild-improve-kernel-build-with-separated-output.patch
-w9968cf-build-fix.patch
-ppc32-pmac_zilog-initialize-port-spinlock-on-all-init-paths.patch
-altix-serial-driver-2.patch
-ide_tf_pio_out_fixes.patch
-ide_tf_pio_out_prehandler.patch
-ide_tf_pio_out_error.patch
-ide_task_in_intr.patch
-ide_pre_task_out_intr.patch
-ide_pre_task_mulout_intr.patch
-ide_tf_no_partial.patch
-ide_non_tf_pio.patch
-ide_no_flagged_pio.patch
-i2c-i2c-devci2c_dev_init-cleanup.patch
-fix-warnings-drivers-net-sk98lin-skaddrc.patch
-bio_copy_user-cleanups.patch
-fix-airo-oops-on-removal.patch
-serious-performance-regression-due-to-nx-patch.patch
-fix-oops-in-device_platform_unregister.patch
-fix-3c59xc-uses-of-plain-integer-as-null-pointer.patch
-small-style-fixups-for-the-new-automount-code.patch
-ifndef-guard-percpu_counterh-and-blockgroup_lockh.patch
-floppyc-remove-superfluous-variable-initialization.patch
-unknown-symbol-in-sound-oss-kahluako-needs-unknown-symbol-udelay.patch
-remove-struct_cpy.patch
-autoselect-fatfs.patch
-fix-saa7146-compilation-on-268-rc1.patch
-fix-return-codes-after-i2c_add_driver-in-tea6415c.patch
-remove-outdated-stallion-contact-information.patch
-fix-ia64-early_printk-build-problem.patch
-fix-inode-state-corruption-268-rc1-bk1.patch

 Merged

+fixes-for-rcu_offline_cpu-rcu_move_batch-268-rc2.patch

 CPU hotplug fix

+unix98-pty-indices-leak.patch

 PTY leak fix

+sched-initialize-sched-domain-table.patch

 CPu scheduler fix

+compat_clock_getres-shouldnt-return-efault-if-res-==-null.patch

 posix timers fix

+bio-page-refcounting-fix.patch

 BIO layer page refcounting fix

+longhaul-fix.patch
+bk-netdev-axnet_cs-fix.patch
+bk-netdev-hp-plus-fix.patch
+bk-power-x86_64-fix.patch
+bk-acpi-x86_cpu_to_apicid-fix.patch

 Various fixes for bk trees.

+nmi-trigger-switch-support-for-debuggingupdated.patch
+nmi-trigger-switch-support-for-debuggingupdated-fix.patch

 x86 support for front-panel NMI switches

+make-i386-die-more-resilient-against-recursive-errors.patch

 Handle oops-inside-oops more cleanly on x86

+ppc64-page-align-emergency-stack-2.patch
+ppc64-remove-multiple-irq-optimisation.patch
+ppc64-cpu-hotplug-fix.patch
+ppc64-fix-ras-irq-handlers.patch
+ppc64-whitespace-cleanup-in-promc.patch
+ppc64-hvcs-driver.patch
+ppc64-smt-bugfix.patch

 PPC64 updates

+ppc32-fix-ppc44x-early-uart-setup.patch
+ppc32-export-some-dma-api-symbols.patch
+ppc32-fix-comment-in-arch-ppc-platforms-pmac_pcic.patch

 PPC32 updates

-x86-64-support-for-singlestep-into-32-bit-system-calls.patch

 I don't remember why I dropped this.

+barrier-flushing-fix.patch

 disk barrier fix

+perfctr-x86-init-bug.patch
+perfctr-k8-fix-for-internal-benchmarking-code.patch

 perfctr x86 fixes

+perfctr-inheritance-1-3-driver-updates.patch
+perfctr-inheritance-illegal-sleep-bug.patch
+perfctr-inheritance-2-3-kernel-updates.patch
+perfctr-inheritance-3-3-documentation-updates.patch

 Inherit perfctr settings across fork/exec

-kernelthread-idle-fix.patch
+kernelthread-idle-fix-2.patch

 updated CPU scheduler fix

+sched-consolidate-sched-domains.patch
+sched-consolidate-domains-fix.patch
+sched-consolidate-domains-fix-2.patch

 CPU scheduler code consolidation

+sched-domain-node-span-4.patch
+sched-domain-node-span-4-warning-fix.patch

 CPU scheduler NUMA fixes

+driver-model-and-sysfs-support-for-pcmcia-update.patch

 Additional pcmcia/sysfs integration work

+control-pktcdvd-with-an-auxiliary-character-device.patch
+control-pktcdvd-with-an-auxiliary-character-device-fix.patch

 CDRW/DVDRW packet writing updates

+rename-uml-console-device.patch

 UML build fix

-detect-too-early-schedule-attempts.patch

 Dropped - was a pain.

+per_cpu-per_cpu-cpu_gdt_table-fix.patch

 Fix per_cpu-per_cpu-cpu_gdt_table.patch

+making-i-dhash_entries-cmdline-work-as-it-use-to-fix.patch

 Fix making-i-dhash_entries-cmdline-work-as-it-use-to.patch

-x86-64-singlestep-through-sigreturn-system-call.patch
+x86-64-singlestep-through-sigreturn-system-call-2.patch

 Updated

+oom-show_free_areas.patch

 Print the memory zone state when oom-killings happen

+send_IPI_mask_bitmask-build-fix.patch

 Compile fix

+e1000-build-fix.patch

 e1000 compile fix

+pty_write-latency-fix.patch

 scheduling latency fix

+v850-define-find_first_bit.patch

 v850 build fix

+enable-all-events-for-initramfs.patch

 initramfs initialisation ordering fix

+radeonfb-64-bit-fix.patch

 fix radeonfb on x86_64

+arch-i386-kernel-smpc-gcc341-inlining-fix.patch
+net-sunrpc-xprtc-gcc341-inlining-fix.patch

 gcc-3.4.1 fixes

+fix-menuconfig-partial-inability-to-show-help-texts.patch

 menuconfig fixlet

+was-removal-of-sync-in-panic.patch

 Don't call sync() when panicing

+move-cache_reap-out-of-timer-context.patch
+move-cache_reap-out-of-timer-context-fix.patch

 interrupt latency fixes in slab

+switch-sgc-to-standard-jiffies-converters.patch

 sg.c jiffies cleanup

+sign-fix-in-swapfilec.patch

 signedness fixlet

+a-trivial-patch-for-removing-unnecessary-comment-in-mm-filemapc.patch

 Comment fix

+gettimeofday-nanoseconds-patch-makes-it-possible-for-the-posix-timer.patch

 posix timer resolution improvements

+fix-for-buffer-limit-for-long-in-sysctlc.patch

 sysctl buffer overflow fix

+quiet-down-per-zone-memory-stats.patch

 Less printk's on boot

+create-nodemask_t.patch

 Add nodemask_t abstraction

+ipmi_msghandler-module-load-failure-fix.patch

 impi module loading fix

+fat-kill-nls-default.patch

 Rework FATFS NLS handling

+add-ixdp2x01-board-support-to-cs89x0-driver.patch

 Additional board support for cs89x0.c

+remove-scripts-mkconfigs.patch

 Remove dead file

+267-msi-x-update.patch

 Big MSI driver update

+remove-dead-prototypes.patch

 Remove unused function prototypes

+s390-use-include-asm-generic-dma-mapping-brokenh.patch

 s390 build fix

+fix-readahead-breakage-for-sequential-after-random-reads.patch

 Fix readahead corner case

+cdrom-get_last_written-fix.patch

 cdrom driver fix

+update-mailing-list-for-osst.patch

 MAINTAINERS update

+fix-aic-for-db4.patch

 Teach the aic build process about db4

+m68k-68060-errata-i14.patch
+m68k-ifpsp060.patch
+m68k-sparse-missing-void.patch
+m68k-sparse-if-vs-ifdef.patch
+m68k-sparse-void-return.patch
+m68k-sparse-extern.patch
+m68k-sparse-inline.patch
+dsp56k-sparse-const.patch
+m68k-sparse-floating-point.patch
+dnfb-sparse-struct-init.patch
+amifb-sparse-=.patch
+m68k-hardirqh.patch
+dmasound-paths.patch
+m68k-bitops.patch
+m68k-checksum-include.patch
+m68k-pgalloc-fixup.patch
+m68k-maintainership.patch

 m68k and related updates

+depends-on-pci-multi-tech-synclink-applicom-serial.patch
+pci-warnings-moxa-serial.patch
+pci-warnings-specialix-serial.patch
+depends-on-pci-via686a-i2c.patch
+depends-on-pci-dma-api-ieee1394-core-and-sbp-2.patch
+depends-on-pci-fritzpci-pciv2-pnp-and-hysdn.patch
+pci-warnings-hisax-isdn.patch
+depends-on-pci-guillemot-maxi-radio-fm-2000.patch
+depends-on-pci-technisat-skystar2-pci.patch
+depends-on-pci-dma-api-cisco-aironet-34x-35x-4500-4800.patch
+depends-on-pci-toshiba-and-via-fir.patch
+depends-on-pci-matrox-1-wire.patch
+dallas-1-wire-delayh.patch

 Various !CONFIG_PCI fixes

+linux-mmzoneh-const.patch

 Add consts to mmzone.h (will probably drop this - it can cause tons of
 warnings)

+intel8x0c-to-include-ck804-audio-support.patch

 Additional sound driver device support

+cirrusfb-update-for-amiga-zorro.patch

 cirrusfb update

+get_random_bytes-returns-the-same-on-every-boot.patch

 make get_random_bytes() more random

+page_cache_readahead-unused-variable.patch

 cleanup

+remove-faulty-__inits-from-drivers-video-fbmemc-fwd.patch

 __init section fixes

+locking-optimization-for-cache_reap.patch

 slab latency fix

+export-all-functions-in-lib-stringc.patch

 Add missing exports

+hlist_for_each_safe-cleanup.patch

 list.h cleanup

+b44-add-47xx-support.patch

 Add device support to b44.c

+fbmon-edd-blacklist.patch

 blacklisting infrastructure for dodgy monitors

+signal-race-fix.patch
+signal-race-fix-ia64.patch
+signal-race-fix-s390.patch
+signal-race-fix-x86_64.patch

 Fixes for SMP signal race

+process-aggregates.patch
+process-aggregates-warning-fix.patch

 Process aggregating infrastructure

+d_unhash-consolidation.patch

 Code consolidation

+front-buttons-wouldnt-mute-ess-maestro.patch

 maestro driver fixlet

+ipv6-routec-gcc-341-fix-inline.patch

 gcc-3.4.1 fix

+config-file-for-laptop-mode.patch
+add-documentation-about-proc-sys-vm-laptop_mode-to-various-docs.patch
+automatically-disable-laptop-mode-when-battery-almost-runs-out.patch

 laptop_mode documentation updates

+ppc32-snd-powermac-requires-i2c.patch

 dependency fix

+ext2_readdir-retval-fix.patch

 Return the correct thing on error

+ncpfs-setattr-retval-fix.patch

 Check a return value

+allow-x86_64-to-reenable-interrupts-on-contention.patch

 Recuced interrupt latency on x86_64

+recommend-noapic-when-timer-via-ioapic-fails.patch

 Add helpful messages when the ioapic timer is discover to be busted.

+move-pit-code-to-timer_pit.patch
+move-pit-code-to-timer_pit-warning-fix.patch

 x86 timer code cleanup

+i2o-build_99.patch
+i2o-build_99-gcc295-fixes.patch

 i2o driver rewrite

+s390-core-changes.patch
+s390-zfcp-host-adapter.patch
+s390-network-driver-changes.patch

 S/390 updates

+dvb-major-number.patch

 Use the right major in DVB

+selinux-fix-clearing-of-new-personality-bit-on-security-transitions.patch

 SELinux fix

+activate-smbus-device-on-hp-d300l.patch

 SMBus quirk for some HP machines

+apic-output-reduction.patch

 Less printk's at boot.

+lost-error-code-in-rescan_partitions.patch

 Error code handling fix

+trivial-doc-patch-for-partitions.patch

 Comment fixes

+rename-config_pci_use_vector-to-config_pci_msi.patch

 Rename things in the MSI driver

+fix-ide-probe-double-detection.patch

 IDE probing fix

+fix-smm-failures-on-e750x-systems.patch

 SMM fixes for certain chipsets

+fix-bogus-ioctl-return-in-mtrr.patch

 mtrr return value fix

+serial-cs-and-unusable-port-size-ranges.patch

 Fix handling of broken GSM GPRS PCMCIA cards.

+remove-boot98.patch

 Remove PC9800 vestiges

+writepages-drops-bh-on-not-uptodate-page.patch

 Fix rare filesytem corruption.

+critical-x86-64-patches-for-268rc2.patch

 x86_64 critical updates





All 371 patches:


linus.patch

fixes-for-rcu_offline_cpu-rcu_move_batch-268-rc2.patch
  fixes for rcu_offline_cpu, rcu_move_batch

unix98-pty-indices-leak.patch
  Fix UNIX98 pty indices leak

sched-initialize-sched-domain-table.patch
  sched: initialize sched domain table

compat_clock_getres-shouldnt-return-efault-if-res-==-null.patch
  compat_clock_getres shouldn't return -EFAULT if res == NULL

bio-page-refcounting-fix.patch
  BIO page refcounting fix

sysfs-leaves-mount.patch
  sysfs backing store: add sysfs_dirent

sysfs-leaves-dir.patch
  sysfs backing store: add sysfs_dirent

sysfs-leaves-file.patch
  sysfs backing store: sysfs_create() changes

sysfs-leaves-bin.patch
  sysfs backing store: bin attribute changes

sysfs-leaves-symlink.patch
  sysfs backing store: sysfs_create_link changes

sysfs-leaves-misc.patch
  sysfs backing store: attribute groups and misc routines

bk-acpi.patch

bk-agpgart.patch

bk-alsa.patch

bk-cifs.patch

bk-dma-declare-coherent-memory.patch

bk-cpufreq.patch

bk-drm.patch

bk-ieee1394.patch

bk-input.patch

bk-kbuild.patch

bk-libata.patch

bk-mpc52xx.patch

bk-netdev.patch

bk-ntfs.patch

bk-pci.patch

bk-pnp.patch

bk-power.patch

bk-scsi.patch

mm.patch
  add -mmN to EXTRAVERSION

longhaul-fix.patch
  longhaul build fix

bk-netdev-axnet_cs-fix.patch
  bk-netdev-axnet_cs-fix

bk-netdev-hp-plus-fix.patch
  bk-netdev-hp-plus-fix

bk-power-x86_64-fix.patch
  bk-power x86_64 fixes

bk-acpi-x86_cpu_to_apicid-fix.patch
  bk-acpi-x86_cpu_to_apicid-fix

nmi-trigger-switch-support-for-debuggingupdated.patch
  NMI trigger switch support for debugging(updated)

nmi-trigger-switch-support-for-debuggingupdated-fix.patch
  nmi-trigger-switch-support-for-debuggingupdated-fix

make-i386-die-more-resilient-against-recursive-errors.patch
  Make i386 die() more resilient against recursive errors

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

radix_tree_tag_set-atomic.patch
  Make radix_tree_tag_set/clear atomic wrt the tag

radix_tree_tag_set-only-needs-read_lock.patch
  radix_tree_tag_set only needs read_lock()

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

mustfix-lists.patch
  mustfix lists

ppc64-page-align-emergency-stack-2.patch
  page align emergency stack

ppc64-remove-multiple-irq-optimisation.patch
  ppc64: remove multiple IRQ optimisation

ppc64-cpu-hotplug-fix.patch
  ppc64: cpu hotplug fix

ppc64-fix-ras-irq-handlers.patch
  ppc64: Fix RAS irq handlers

ppc64-whitespace-cleanup-in-promc.patch
  ppc64: whitespace cleanup in prom.c

ppc64-hvcs-driver.patch
  ppc64: HVCS driver

ppc64-smt-bugfix.patch
  ppc64 SMT bugfix

ppc32-fix-ppc44x-early-uart-setup.patch
  ppc32: Fix PPC44x early uart setup

ppc32-export-some-dma-api-symbols.patch
  ppc32: export some DMA API symbols

ppc32-fix-comment-in-arch-ppc-platforms-pmac_pcic.patch
  ppc32: fix comment in arch/ppc/platforms/pmac_pci.c

ppc64-reloc_hide.patch

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

get_user_pages-handle-VM_IO.patch
  fix get_user_pages() against mappings of /dev/mem

fa311-mac-address-fix.patch
  wrong mac address with netgear FA311 ethernet card

pid_max-fix.patch
  Bug when setting pid_max > 32k

jbd-remove-livelock-avoidance.patch
  JBD: remove livelock avoidance code in journal_dirty_data()

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

list_del-debug.patch
  list_del debug check

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch
  lockmeter
  ia64 CONFIG_LOCKMETER fix

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

hugetlb_shm_group-sysctl-gid-0-fix.patch
  hugetlb_shm_group sysctl-gid-0-fix

really-ptrace-single-step-2.patch
  ptrace single-stepping fix

ipr-ppc64-depends.patch
  Make ipr.c require ppc

disk-barrier-core.patch
  disk barriers: core
  disk-barrier-core-tweaks

disk-barrier-ide.patch
  disk barriers: IDE
  disk-barrier-ide-symbol-expoprt
  disk-barrier ide warning fix

barrier-update.patch
  barrier update

barrier-flushing-fix.patch
  barrier flushing fix

disk-barrier-scsi.patch
  disk barriers: scsi

disk-barrier-dm.patch
  disk barriers: devicemapper

disk-barrier-md.patch
  disk barriers: MD

reiserfs-v3-barrier-support.patch
  reiserfs v3 barrier support
  reiserfs-v3-barrier-support-tweak

sync_dirty_buffer-retval.patch
  make sync_dirty_buffer() return something useful

ext3-barrier-support.patch
  ext3 barrier support

jbd-barrier-fallback-on-failure.patch
  jbd: barrier fallback on failure

ide-print-failed-opcode.patch
  ide: print failed opcode on IO errors
  From: Jens Axboe <axboe@suse.de>
  Subject: Re: ide errors in 7-rc1-mm1 and later

add-bh_eopnotsupp-for-testing.patch
  add BH_Eopnotsupp for testing async barrier failures

handle-async-barrier-failures.patch
  Handle async barrier failures

enable-suspend-resuming-of-e1000.patch
  Enable suspend/resuming of e1000

tty_io-hangup-locking.patch
  tty_io.c hangup locking

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

perfctr-x86-init-bug.patch
  perfctr x86 init bug

perfctr-k8-fix-for-internal-benchmarking-code.patch
  perfctr: K8 fix for internal benchmarking code

perfctr-x86_64.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][3/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: x86_64

perfctr-ppc.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][4/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: PowerPC
  perfctr ppc32 update
  perfctr update 4/6: PPC32 cleanups

perfctr-ppc32-buglet-fix.patch
  perfctr ppc32 buglet fix

perfctr-virtualised-counters.patch
  From: Mikael Pettersson <mikpe@csd.uu.se>
  Subject: [PATCH][5/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: virtualised counters
  perfctr update 6/6: misc minor cleanups
  perfctr update 3/6: __user annotations
  perfctr-cpus_complement-fix
  perfctr cpumask cleanup

perfctr-ifdef-cleanup.patch
  perfctr ifdef cleanup

perfctr-update-2-6-kconfig-related-updates.patch
  perfctr update 2/6: Kconfig-related updates

perfctr-update-5-6-reduce-stack-usage.patch
  perfctr update 5/6: reduce stack usage

perfctr-low-level-documentation.patch
  perfctr low-level documentation

perfctr-documentation-update.patch
  perfctr documentation update

perfctr-inheritance-1-3-driver-updates.patch
  perfctr inheritance 1/3: driver updates

perfctr-inheritance-illegal-sleep-bug.patch
  perfctr inheritance illegal sleep bug

perfctr-inheritance-2-3-kernel-updates.patch
  perfctr inheritance 2/3: kernel updates

perfctr-inheritance-3-3-documentation-updates.patch
  perfctr inheritance 3/3: documentation updates

ext3-online-resize-patch.patch
  ext3: online resizing

ext3-online-resize-warning-fix.patch
  ext3-online-resize-warning-fix

sched-clean-init-idle.patch
  sched: cleanup init_idle()

sched-clean-fork.patch
  sched: cleanup, improve sched <=> fork APIs

sched-clean-fork-rename-wake_up_new_process-wake_up_new_task.patch
  sched: rename wake_up_new_process -> wake_up_new_task

kernelthread-idle-fix-2.patch
  kernel thread idle fix

sched-misc-cleanups-2.patch
  sched: misc cleanups #2

sched-unlikely-rt_task.patch
  sched: make rt_task unlikely

sched-misc.patch
  sched: sched misc changes

sched-misc-fix-rt.patch
  sched: fix RT scheduling & interactivity estimator

sched-no-balance-clone.patch
  sched: disable balance on clone

sched-remove-balance-clone.patch
  sched: remove balance on clone

sched-fork-hotplug-cleanuppatch.patch
  sched: fork hotplug hanling cleanup

sched-consolidate-sched-domains.patch
  sched: consolidate sched domains

sched-consolidate-domains-fix.patch
  sched: fix for sched-consolidate-domains

sched-consolidate-domains-fix-2.patch
  another sched consolidate domains fix

sched-domain-node-span-4.patch
  sched: limit cpuspan of node scheduler domains

sched-domain-node-span-4-warning-fix.patch
  sched-domain-node-span-4-warning-fix

memory-backed-inodes-fix.patch
  memory-backed inodes fix

ext3_bread-cleanup.patch
  ext3_bread() cleanup

flexible-mmap-2.6.7-mm3-A8.patch
  i386 virtual memory layout rework

flexible-mmap-bug-fix.patch
  flexible-mmap BUG fix

flexible-mmap-updatepatch-267-mm5.patch
  flexible-mmap update

driver-model-and-sysfs-support-for-pcmcia-1-3.patch
  driver model and sysfs support for PCMCIA (1/3)

driver-model-and-sysfs-support-for-pcmcia-update.patch
  driver model and sysfs support for PCMCIA update

update-drivers-net-pcmcia-2-3.patch
  update drivers/net/pcmcia (2/3)

update-drivers-net-wireless-3-3.patch
  update drivers/net/wireless (3/3)

posix-locking-fix-to-posix_same_owner.patch
  posix locking: Minimal fix to posix_same_owner()

posix-locking-fix-to-locking-code.patch
  posix locking: more locking code fixes

posix-locking-fix-up-nfs4statec.patch
  posix locking: Fix up nfs4state.c

posix-locking-fix-up-lockd.patch
  posix locking: Fix up lockd to make use of the new interface

posix-locking-fl_owner_t-to-pid-mapping.patch
  posix locking: mapping between fl_owner_t and client-side "pid"

dvdrw-support-for-267-bk13.patch
  DVD+RW support for 2.6.7-bk13

cdrw-packet-writing-support-for-267-bk13.patch
  CDRW packet writing support

dvd-rw-packet-writing-update.patch
  Packet writing support for DVD-RW and DVD+RW discs.

fix-race-in-pktcdvd-kernel-thread-handling.patch
  Fix race in pktcdvd kernel thread handling

fix-open-close-races-in-pktcdvd.patch
  Fix open/close races in pktcdvd

packet-writing-review-fixups.patch
  packet writing: review fixups

remove-pkt_dev-from-struct-pktcdvd_device.patch
  Remove pkt_dev from struct pktcdvd_device

packet-writing-docco.patch
  packet writing documentation

convert-packet-writing-to-seq_file.patch
  packet writing: convert to seq_file

control-pktcdvd-with-an-auxiliary-character-device.patch
  Control pktcdvd with an auxiliary character device

control-pktcdvd-with-an-auxiliary-character-device-fix.patch
  control-pktcdvd-with-an-auxiliary-character-device-fix

r8169_napi-help-text-2.patch
  R8169_NAPI help text

no-sysgood-for-ptrace-singlestep.patch
  Don't use SYSGOOD for ptrace singlestep

err2-6-hashbin_remove_this-locking-fix.patch
  err2-6: hashbin_remove_this() locking fix

dm-use-idr.patch
  devicemapper: use an IDR tree for tracking minors

ipc-1-3-add-refcount-to-ipc_rcu_alloc.patch
  ipc: Add refcount to ipc_rcu_alloc

ipc-2-3-remove-sem_revalidate.patch
  ipc: remove sem_revalidate

ipc-3-3-enforce-semvmx-limit-for-undo.patch
  ipc: enforce SEMVMX limit for undo

cleanup-of-ipc-msgc.patch
  cleanup of ipc/msg.c

sk98lin-procfs-fix.patch
  sk98lin procfs fix

cpufreq-driver-for-nforce2-kernel-267.patch
  cpufreq driver for nForce2

allow-modular-ide-pnp.patch
  allow modular ide-pnp

uml-base-patch.patch
  uml: Uml base patch

rename-uml-console-device.patch
  uml: rename console_device

uml-readds-just-for-now-ghashh-for-uml.patch
  uml: Readds (just for now) ghash.h for UML

uml-avoid-that-gcc-breaks-uml-with-unit-at-a-time-compilation-mode.patch
  uml: Avoid that gcc breaks UML with "unit at a time" compilation mode.

uml-fixes-an-host-fd-leak-caused-by-hostfs.patch
  uml: Fixes an host fd leak caused by hostfs.

uml-adds-legacy_pty-config-option.patch
  uml: Adds LEGACY_PTY config option

uml-makes-make-help-arch=um-work.patch
  uml: Makes "make help ARCH=um" work.

uml-fixes-fixdepc-to-support-arch-um-include-uml-configh.patch
  uml: Fixes "fixdep.c" to support arch/um/include/uml-config.h.

uml-kill-useless-warnings.patch
  uml: Kill useless warnings

uml-avoids-compile-failure-when-host-misses-tkill.patch
  uml: Avoids compile failure when host misses tkill().

uml-reduces-code-in-_user-files-by-moving-it-in-_kern-files-if-already-possible.patch
  uml: Reduces code in *_user files, by moving it in _kern files if already possible.

uml-fixes-raw-and-uses-it-in-check_one_sigio-also-fixes-a-silly-panic-eintr-returned-by-call.patch
  uml: Fixes raw() and uses it in check_one_sigio; also fixes a silly panic (EINTR returned by call).

uml-folds-hostaudio_userc-into-hostaudio_kernc.patch
  uml: Folds hostaudio_user.c into hostaudio_kern.c.

uml-use-ptrace_scemu-the-so-called-sysemu-to-reduce-syscall-cost.patch
  uml: Use PTRACE_SCEMU (the so-called SYSEMU) to reduce syscall cost.

uml-adds-the-nosysemu-command-line-parameter-to-disable-sysemu.patch
  uml: Adds the "nosysemu" command line parameter to disable SYSEMU

uml-adds-proc-sysemu-to-toggle-sysemu-usage.patch
  uml: Adds /proc/sysemu to toggle SYSEMU usage.

uml-fix-for-sysemu-patches.patch
  uml: Fix for sysemu patches

uml-handles-correctly-errno-==-eintr-in-lots-of-places.patch
  uml: Handles correctly errno == EINTR in lots of places.

uml-adds-some-exports.patch
  uml: Adds some exports

uml-avoids-a-panic-for-a-legal-situation.patch
  uml: Avoids a panic for a legal situation

uml-removes-dead-code-in-trap_kernc.patch
  uml: Removes dead code in trap_kern.c

uml-make-malloc-call-vmalloc-if-needed-needed-for-hostfs-on-26-host.patch
  uml: Make malloc() call vmalloc if needed. Needed for hostfs on 2.6 host.

uml-little-kmalloc.patch
  uml: little-kmalloc

uml-fix-os_process_pc-and-os_process_parent-for-corner-cases.patch
  uml: Fix os_process_pc and os_process_parent for corner cases.

fix-warnings-in-net-irda.patch
  sparse: fix warnings in net/irda/*

i810_audio-mmio-support.patch
  i810_audio MMIO support

i810_audio-mmio-support-2.patch
  i810_audio MMIO support #2

i810_audio-fix-the-error-path-of-resource-management.patch
  i810_audio: Fix the error path of resource management

fix-drivers-isdn-hisax-avm_pcic-build-warning-when.patch
  Fix drivers/isdn/hisax/avm_pci.c build warning when !CONFIG_ISAPNP

idr-stale-comment.patch
  idr.c: remove stale comment

idr-comments-updates.patch
  idr comments updates

schedule-profiling.patch
  schedule() profiling
  From: Arjan van de Ven <arjanv@redhat.com>
  Subject: Re: schedule profileing

add-a-few-might_sleep-checks.patch
  Add a few might_sleep() checks

add-a-few-might_sleep-checks-fix.patch
  add-a-few-might_sleep-checks fix

release_task-may-sleep.patch
  permit sleeping in release_task()

ia64-ptrace-fix-fix.patch
  Make get_user_pages() work again for ia64 gate area

possible-buglet-in-drivers-input-joystick-tmdcc.patch
  Possible buglet in drivers/input/joystick/tmdc.c

crc16-renaming-in-via-velocity-ethernet-driver.patch
  CRC16 renaming in VIA Velocity ethernet driver

per_cpu-per_cpu-cpu_gdt_table.patch
  percpu: cpu_gdt_table

per_cpu-per_cpu-cpu_gdt_table-fix.patch
  per_cpu-per_cpu-cpu_gdt_table-fix

per_cpu-per_cpu-init_tss.patch
  percpu: init_tss

per_cpu-per_cpu-cpu_tlbstate.patch
  percpu: cpu_tlbstate

gcc35-advansys.c.patch
  gcc-3.5 fixes

gcc35-alps_tdlb7.c.patch
  gcc-3.5 fixes

gcc35-always-inline.patch
  gcc-3.5 fixes

gcc35-arlan.h.patch
  gcc-3.5 fixes

gcc35-auerswald.c.patch
  gcc-3.5 fixes

gcc35-dabusb.c.patch
  gcc-3.5 fixes

gcc35-ds.c.patch
  gcc-3.5 fixes

gcc35-fixmap.h.patch
  gcc-3.5 fixes

gcc35-fore200e.c.patch
  gcc-3.5 fixes

gcc35-index.html.patch
  gcc-3.5 fixes

gcc35-ip6_fib.c.patch
  gcc-3.5 fixes

gcc35-iphase.h.patch
  gcc-3.5 fixes

gcc35-irttp.h.patch
  gcc-3.5 fixes

gcc35-mtrr.h.patch
  gcc-3.5 fixes

gcc35-netrom.h.patch
  gcc-3.5 fixes

gcc35-pppoe.c.patch
  gcc-3.5 fixes

gcc35-sonypi.patch
  gcc-3.5 fixes

gcc35-sp887x.c.patch
  gcc-3.5 fixes

gcc35-tda1004x.c.patch
  gcc-3.5 fixes

gcc35-transport.h.patch
  gcc-3.5 fixes

gcc35-ufs_fs.h.patch
  gcc-3.5 fixes

gcc35-usblp.c.patch
  gcc-3.5 fixes

gcc35-videodev.c.patch
  gcc-3.5 fixes

gcc35-wavefront_fx.c.patch
  gcc-3.5 fixes

gcc35-xfrm6_state.c.patch
  gcc-3.5 fixes

fix-rivafbs-nv_arch_-cleanup-debug-backlight-control-on-ppc.patch
  Fix rivafb's NV_ARCH_, cleanup DEBUG, backlight control on ppc

fix-rivafbs-nv_arch_-cleanup-debug-backlight-control-on-ppc-fix.patch
  fix-rivafbs-nv_arch_-cleanup-debug-backlight-control-on-ppc fix

dev-zero-vs-hugetlb-mappings.patch
  /dev/zero vs hugetlb mappings.

hugetlbfs-vm_pgoff-bugs.patch
  hugetlbfs vm_pgoff bugs

hugetlbfs-private-mappings.patch
  hugetlbfs private mappings

net-kconfig-crc16-fix.patch
  net/Kconfig crc16 warning fix

preset-loops_per_jiffy-for-faster-booting.patch
  preset loops_per_jiffy for faster booting

define-inline-as-__attribute__always_inline-also-for-gcc-=-34.patch
  #define inline as __attribute__((always_inline)) also for gcc >= 3.4

gcc-34-and-broken-inlining.patch
  clean up __always_inline__ usage

handle-undefined-symbols.patch
  Fail if vmlinux contains undefined symbols

split-generic_file_aio_write-into-buffered-and-direct-i-o-parts.patch
  split generic_file_aio_write into buffered and direct I/O parts

unknown-symbol-in-drivers-scsi-pcmcia-fdomain_csko.patch
  fdomain_cs needs ISA

radeonfb-cleanup-and-little-fixes.patch
  radeonfb: cleanup and little fixes

making-i-dhash_entries-cmdline-work-as-it-use-to.patch
  Make i/dhash_entries cmdline work as it use to.

making-i-dhash_entries-cmdline-work-as-it-use-to-fix.patch
  making-i-dhash_entries-cmdline-work-as-it-use-to-fix

fix-double-reset-in-aic7xxx-driver.patch
  Fix double reset in aic7xxx driver

rivafb-i2c-fixes.patch
  Rivafb I2C fixes

jbd-recovery-latency-fix.patch
  jbd recovery latency fix

truncate_inode_pages-latency-fix.patch
  truncate_inode_pages-latency-fix

journal_clean_checkpoint_list-latency-fix.patch
  journal_clean_checkpoint_list latency fix

kjournald-smp-latency-fix.patch
  kjournald-smp-latency-fix

unmap_vmas-smp-latency-fix.patch
  unmap_vmas-smp-latency-fix

__cleanup_transaction-latency-fix.patch
  __cleanup_transaction-latency-fix

prune_dcache-latency-fix.patch
  prune_dcache-latency-fix

filemap_sync-latency-fix.patch
  filemap_sync-latency-fix

slab-latency-fix.patch
  slab-latency-fix

get_user_pages-latency-fix.patch
  get_user_pages-latency-fix

oom-show_free_areas.patch
  oom-killer: call show_free_areas

send_IPI_mask_bitmask-build-fix.patch
  send_IPI_mask_bitmask() build fix

e1000-build-fix.patch
  e1000 build fix

pty_write-latency-fix.patch
  pty_write-latency-fix

v850-define-find_first_bit.patch
  v850: Define find_first_bit

enable-all-events-for-initramfs.patch
  Enable all events for initramfs

radeonfb-64-bit-fix.patch
  radeonfb x86_64 fix

arch-i386-kernel-smpc-gcc341-inlining-fix.patch
  arch/i386/kernel/smp.c gcc341 inlining fix

net-sunrpc-xprtc-gcc341-inlining-fix.patch
  net/sunrpc/xprt.c gcc341 inlining fix

fix-menuconfig-partial-inability-to-show-help-texts.patch
  Fix menuconfig partial inability to show help texts.

was-removal-of-sync-in-panic.patch
  remove sync() from panic

move-cache_reap-out-of-timer-context.patch
  Move cache_reap out of timer context

move-cache_reap-out-of-timer-context-fix.patch
  move-cache_reap-out-of-timer-context-fix

switch-sgc-to-standard-jiffies-converters.patch
  switch sg.c to standard jiffies converters

sign-fix-in-swapfilec.patch
  sign fix in swapfile.c

a-trivial-patch-for-removing-unnecessary-comment-in-mm-filemapc.patch
  Remove dead comment in mm/filemap.c

gettimeofday-nanoseconds-patch-makes-it-possible-for-the-posix-timer.patch
  gettimeofday nanoseconds patch

fix-for-buffer-limit-for-long-in-sysctlc.patch
  fix for buffer limit for long in sysctl.c

quiet-down-per-zone-memory-stats.patch
  quieten down per-zone memory stats

x86-64-singlestep-through-sigreturn-system-call-2.patch
  Fix x86-64 singlestep through sigreturn system call

create-nodemask_t.patch
  Create nodemask_t

ipmi_msghandler-module-load-failure-fix.patch
  ipmi_msghandler module load failure fix

fat-kill-nls-default.patch
  FAT: kill nls default

add-ixdp2x01-board-support-to-cs89x0-driver.patch
  Add IXDP2x01 board support to CS89x0 driver

remove-scripts-mkconfigs.patch
  remove scripts/mkconfigs

267-msi-x-update.patch
  MSI-X Update

remove-dead-prototypes.patch
  remove dead prototypes

s390-use-include-asm-generic-dma-mapping-brokenh.patch
  s390: Use include/asm-generic/dma-mapping-broken.h

fix-readahead-breakage-for-sequential-after-random-reads.patch
  fix readahead breakage for sequential after random reads

cdrom-get_last_written-fix.patch
  Subject: cdrom.c get_last_written fixup

update-mailing-list-for-osst.patch
  MAINTAINERS: update mailing list for osst

fix-aic-for-db4.patch
  fix aic driver build for db4

m68k-68060-errata-i14.patch
  M68k 68060 errata I14

m68k-ifpsp060.patch
  M68k ifpsp060

m68k-sparse-missing-void.patch
  m68k sparse missing void

m68k-sparse-if-vs-ifdef.patch
  m68k sparse #if vs. #ifdef

m68k-sparse-void-return.patch
  m68k sparse void return

m68k-sparse-extern.patch
  m68k sparse extern

m68k-sparse-inline.patch
  m68k sparse inline

dsp56k-sparse-const.patch
  dsp56k sparse const

m68k-sparse-floating-point.patch
  m68k sparse floating point

dnfb-sparse-struct-init.patch
  dnfb sparse struct init

amifb-sparse-=.patch
  amifb sparse &=

m68k-hardirqh.patch
  m68k hardirq.h

dmasound-paths.patch
  dmasound paths

m68k-bitops.patch
  M68k bitops

m68k-checksum-include.patch
  M68k checksum include

m68k-pgalloc-fixup.patch
  M68k pgalloc fixup

m68k-maintainership.patch
  M68k Maintainership

depends-on-pci-multi-tech-synclink-applicom-serial.patch
  depends on PCI: Multi-Tech, SyncLink, Applicom serial

pci-warnings-moxa-serial.patch
  !PCI warnings: Moxa serial

pci-warnings-specialix-serial.patch
  !PCI warnings: Specialix serial

depends-on-pci-via686a-i2c.patch
  depends on PCI: VIA686A i2c

depends-on-pci-dma-api-ieee1394-core-and-sbp-2.patch
  depends on PCI DMA API: IEEE1394 core and SBP-2

depends-on-pci-fritzpci-pciv2-pnp-and-hysdn.patch
  depends on PCI: Fritz!PCI/PCIv2/PnP and HYSDN

pci-warnings-hisax-isdn.patch
  !PCI warnings: Hisax ISDN

depends-on-pci-guillemot-maxi-radio-fm-2000.patch
  depends on PCI: Guillemot MAXI Radio FM 2000

depends-on-pci-technisat-skystar2-pci.patch
  depends on PCI: Technisat Skystar2 PCI

depends-on-pci-dma-api-cisco-aironet-34x-35x-4500-4800.patch
  depends on PCI DMA API: Cisco/Aironet 34X/35X/4500/4800

depends-on-pci-toshiba-and-via-fir.patch
  depends on PCI: Toshiba and VIA FIR

depends-on-pci-matrox-1-wire.patch
  depends on PCI: Matrox 1-wire

dallas-1-wire-delayh.patch
  Dallas 1-wire delay.h

linux-mmzoneh-const.patch
  <linux/mm{,zone}.h> const

intel8x0c-to-include-ck804-audio-support.patch
  intel8x0.c to include CK804 audio support

cirrusfb-update-for-amiga-zorro.patch
  cirrusfb: update for amiga (zorro)

get_random_bytes-returns-the-same-on-every-boot.patch
  get_random_bytes() returns the same on every boot

page_cache_readahead-unused-variable.patch
  page_cache_readahead unused variable

remove-faulty-__inits-from-drivers-video-fbmemc-fwd.patch
  remove faulty __init's from drivers/video/fbmem.c

locking-optimization-for-cache_reap.patch
  slab: locking optimization for cache_reap

export-all-functions-in-lib-stringc.patch
  Export all functions in lib/string.c

hlist_for_each_safe-cleanup.patch
  hlist_for_each_safe cleanup

b44-add-47xx-support.patch
  b44: add 47xx support

fbmon-edd-blacklist.patch
  fbcom: EDD-based blacklisting

signal-race-fix.patch
  signal handling race fix

signal-race-fix-ia64.patch
  signal-race-fix: ia64

signal-race-fix-s390.patch
  signal-race fixes for s390

signal-race-fix-x86_64.patch
  signal-race-fixes: x86-64 support

process-aggregates.patch
  Process Aggregates (PAGG)

process-aggregates-warning-fix.patch
  process-aggregates warning fix

d_unhash-consolidation.patch
  d_unhash consolidation

front-buttons-wouldnt-mute-ess-maestro.patch
  front buttons wouldn't mute ESS Maestro

ipv6-routec-gcc-341-fix-inline.patch
  ipv6/route.c gcc-341 fix inline

config-file-for-laptop-mode.patch
  Config file for laptop mode.

add-documentation-about-proc-sys-vm-laptop_mode-to-various-docs.patch
  Add documentation about /proc/sys/vm/laptop_mode to various docs.

automatically-disable-laptop-mode-when-battery-almost-runs-out.patch
  Automatically disable laptop mode when battery almost runs out.

ppc32-snd-powermac-requires-i2c.patch
  ppc32: snd-powermac requires i2c

ext2_readdir-retval-fix.patch
  ext2_readdir() return value fix

ncpfs-setattr-retval-fix.patch
  ncpfs: setattr return value fix

allow-x86_64-to-reenable-interrupts-on-contention.patch
  Allow x86_64 to reenable interrupts on contention

recommend-noapic-when-timer-via-ioapic-fails.patch
  Recommend 'noapic' when timer via IOAPIC fails

move-pit-code-to-timer_pit.patch
  x86: move PIT code to timer_pit

move-pit-code-to-timer_pit-warning-fix.patch
  move-pit-code-to-timer_pit-warning-fix

i2o-build_99.patch
  i20 rewrite

i2o-build_99-gcc295-fixes.patch
  i2o-build_99-gcc295-fixes

s390-core-changes.patch
  s390: core changes

s390-zfcp-host-adapter.patch
  s390: zfcp host adapter.

s390-network-driver-changes.patch
  s390: network driver changes

dvb-major-number.patch
  From: Alan Cox <alan@redhat.com>
  Subject: DVB major number

selinux-fix-clearing-of-new-personality-bit-on-security-transitions.patch
  selinux: fix clearing of new personality bit on security transitions

activate-smbus-device-on-hp-d300l.patch
  activate SMBus device on hp d300l

apic-output-reduction.patch
  Subject: Re: Fw: [Fwd: Re: [Kernel-janitors] [PATCH] IO-APIC debug message 	reducti]

lost-error-code-in-rescan_partitions.patch
  lost error code in rescan_partitions

trivial-doc-patch-for-partitions.patch
  trivial doc patch for partitions

rename-config_pci_use_vector-to-config_pci_msi.patch
  rename CONFIG_PCI_USE_VECTOR to CONFIG_PCI_MSI

fix-ide-probe-double-detection.patch
  Fix ide probe double detection

fix-smm-failures-on-e750x-systems.patch
  fix SMM failures on E750x systems

fix-bogus-ioctl-return-in-mtrr.patch
  Subject: PATCH: fix bogus ioctl return in mtrr

serial-cs-and-unusable-port-size-ranges.patch
  serial-cs and unusable port size ranges

remove-boot98.patch
  remove boot98

writepages-drops-bh-on-not-uptodate-page.patch
  writepages drops bh on not uptodate page

critical-x86-64-patches-for-268rc2.patch
  Critical x86-64 patches for 2.6.8rc2



