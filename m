Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269248AbUICJBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269248AbUICJBn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 05:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269349AbUICJBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:01:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:62633 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269248AbUICIuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 04:50:05 -0400
Date: Fri, 3 Sep 2004 01:48:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc1-mm3
Message-Id: <20040903014811.6247d47d.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm3/

- Added the m32r architecture.  Haven't looked at it yet.

- Status update on various large patches in -mm:

  - The packet-writing code is awaiting resolution of the
    abuse-of-elevator-fields problem.

  - perfctr is stalled.  Mikael is planning on doing more work to make it
    more compatible with perfmon, but he is busy for a while.

  - If the sysfs-backing-store patches get any older they'll start to
    stink.  Awaiting review input from AV.  

  - ext3 reservation code is currently being optimised by Stephen Tweedie
    (replace a serious-looking linear search with an rbtree).  I'd expect
    those patches to land in -mm soon.

  - ext3 online resizing still needs a bit of maintenance work done.

  - pcmcia driver model support: dunno.  I guess we're waiting for rmk to
    get onto this.  

  - i386 hotplug CPU support: I'm not sure that we should merge this at
    all - it's a testing-only thing.  

  - key management code: mainly awaiting feedback from other fs developers
    who may need such a capability.  Also we seem to be unsure as to which
    userspace interface will end up being used?  

  - kexec: I guess this could be merged now, if we want kexec now.  I'm
    waiting for the kexec-based-crashdump patches to turn up.

  - cpusets: ready to go, I guess.  Review input from various parties
    seems positive.  Post-2.6.9.

  - reiser4: blah.

- Various random fixes and updates.




Changes since 2.6.9-rc1-mm2:

 linus.patch
 bk-acpi.patch
 bk-agpgart.patch
 bk-cpufreq.patch
 bk-drm.patch
 bk-ia64.patch
 bk-ieee1394.patch
 bk-input.patch
 bk-mmc.patch
 bk-netdev.patch
 bk-pci.patch
 bk-pnp.patch
 bk-power.patch
 bk-serial.patch

 Latest versions of external trees

-remove-function-prototype-inside-function.patch
-make-assign_irq_vector-non-__init.patch
-platform-update-for-es7000.patch
-fix-oops-with-nmi_watchdog=2.patch
-sound-control-build-fix.patch
-i386_exception_notifiers.patch
-kprobes-base.patch
-kprobes-unset-fix.patch
-kprobes-func-args.patch
-kprobes-build-fix.patch
-fix-the-unnecessary-entropy-call-in-the-irq-handler.patch
-update-ppc-maintainers-credits.patch
-ppc64-1-3-rework-ppc64-cpu-map-setup.patch
-ppc64-2-3-set-platform-cpuids-later-in-boot.patch
-ppc64-3-3-allocate-irqstacks-only-for-possible-cpus.patch
-ppc64-add-a-pfn_to_kaddr-function.patch
-dev-zero-vs-hugetlb-mappings.patch
-hugetlbfs-private-mappings.patch
-truncate_inode_pages-latency-fix.patch
-vlan-support-for-3c59x-3c90x.patch
-tiny-shmem-tmpfs-replacement.patch
-x86_64-numa-emulation.patch
-using-get_cycles-for-add_timer_randomness.patch
-waitid-system-call.patch
-waitid-clear-fields.patch
-fix-rusage-semantics.patch
-fix-pid-hash-sizing.patch
-use-hlist-for-pid-hash.patch
-use-hlist-for-pid-hash-cache-friendliness.patch
-amiga-partition-reading-fix.patch
-prevent-memory-leak-in-devpts.patch
-dont-oops-on-stripped-modules.patch
-i386-bootmem-restrictions.patch
-use-page_to_nid.patch
-tdfx-linkage-fix.patch
-propagate-pci_enable_device-errors.patch
-netpoll-fix-unaligned-accesses.patch
-netpoll-revert-queue-stopped-change.patch
-netpoll-kill-config_netpoll_rx.patch
-netpoll-increase-napi-budget.patch
-netpoll-fix-up-trapped-logic.patch
-make-i386-signal-delivery-work-with-mregparm.patch
-fix-a-null-pointer-bug-in-do_generic_file_read.patch
-synclinkmp-transmit-eom-fix.patch
-interrupt-driven-hvc_console-as-vio-device.patch
-remove-ext2_panic-prototype.patch
-export-more-symbols-on-sparc32.patch
-fix-hardcoded-value-in-vsyscalllds.patch
-fix-up-centaur-cpu-feature-enabling.patch
-zr36067-driver-correct-i2c-algo-bit-dependency-in-kconfig.patch
-zr36067-driver-use-msleep-instead-of-schedule_timeout.patch
-zr36067-driver-correct-subfrequency-carrier.patch
-hfs-hfsplus-is-missing-sendfile.patch
-mark-pcxx-as-broken.patch
-fix-devfs-name-for-microcode-driver.patch
-topology-macro-safeness.patch
-befs-load-default-nls-if-none-is-specified-in-mount-options.patch
-fbdev-fix-kernel-panic-from-fbio_cursor-ioctl.patch
-fbdev-fix-copy_to-from_user-in-fbmemcfb_read-write.patch
-v4l-bttv-add-sanity-check-bug-3309.patch
-kernel-forkc-add-missing-unlikely.patch
-stv0299-device-naming-fix.patch
-s390-core-changes.patch
-s390-kernel-stack-options.patch
-s390-zfcp-host-adapater.patch
-isdn-build-fix.patch

 Merged

+x86_64-waitid-syscall-number-fix.patch

 x86_64 waitid() fix

+shmem-stubs-fix.patch

 !CONFIG_SHMEM build fix

+sparc-alsa-fix.patch

 ALSA cross-arch fix

+add_to_swap-suppress-oom-message.patch

 Kill some page allocation failure messages

+distinct-tgid-tid-cpu-usage.patch

 Distinct per-process and per-thread accounting in /proc/pid/stat

-request_region-for-winbond-and-smsc-parport-drivers-fix.patch

 Folded into request_region-for-winbond-and-smsc-parport-drivers.patch

+es7000-more-mp-busses.patch
+es7000-subarch-update.patch

 ES7000 fixes

+fix-target_cpus-for-summit-subarch.patch

 Summit fix

+pkt_act-fix.patch

 net fix

+ipr-build-fix.patch

 ipr.c build fix

+acpi-compile-fix.patch
+acpi-x86_64-build-fix.patch

 ACPI build fixes

+ppc-increase-max-auxv-entries.patch
+pin-the-kernel-stacks-slb-entry.patch
+ppc64-enable-debug_spinlock_sleep.patch
+ppc64-test-for-eeh-error-in-pci-config-read-path.patch
+ppc64-print-backtrace-in-eeh-code.patch
+ppc64-topdown-support.patch
+ppc64-topdown-support-arch-specific-get_unmapped_area.patch
+ppc64-setup-fw_features-before-init_early-calls-on-pseries.patch
+ppc64-make-use-of-batched-iommu-calls-on-pseries-lpars.patch
+ppc64-another-log-buffer-length-fix.patch
+ppc64-dynamically-allocate-emergency-stacks.patch
+ppc64-update-pseries_defconfig.patch
+ppc64-update-iseries_defconfig.patch
+ppc64-quieten-numa-boot-messages.patch
+ppc64-allocate-numa-node-data-node-locally.patch
+ppc64-cleanup-asm-processorh.patch
+ppc64-implement-page_is_ram.patch

 ppc[64] updates

+add-support-for-numa-discovery-on-amd-dual-core-to-x86-64.patch

 x86_64 numa node discovery fix

+fix-boot_cpu_data-on-x86-64.patch

 build fix

+increase-bus-apic-limits-on-x86-64.patch

 Increase MAX_MP_BUSSES

+factor-out-common-asm-hardirqh-code.patch

 hardirq.h code consolidation

+fix-argument-checking-in-sched_setaffinity.patch

 Fixes the argument length checking in sched_setaffinity().

+packet-writing-credits.patch

 Fix up attributions

+acpi-based-i8042-keyboard-aux-controller-enumeration.patch

 Enumerate 8042 controllers with ACPI

+keys-new-error-codes-for-alpha-mips-pa-risc-sparc-sparc64.patch

 Fix the new key management code for some additional architectures

+keys-permission-fix.patch
+support-supplementary-information-for-request-key.patch

 Updates/fixes to key management code

+ptrace-api-preservation.patch

 Make ptrace handling work more like it used to

+nix-rusage_group.patch

 Remove RUSAGE_GROUP

+i386-syscall-tracing-of-bogus-system-calls.patch

 Fix syscall tracing for non-existent syscalls

+fix-proc_symlink-warning-with-config_proc_fs=n.patch

 warning fix

+reiser4-debug-build-fix.patch

 Fix reiser4 for the hardirq.h changes

+update-acpi-floppy-enumeration.patch

 More fiddling with ACPI and floppies

+inconsistent-kallsyms-fix.patch
+kallsyms-correct-type-char-in-proc-kallsyms.patch

 Fixes for the /proc/kallsyms speedup

-consolidate-bit-waiting-code-patterns-cleanup.patch

 Folded into consolidate-bit-waiting-code-patterns.patch

+eliminate-bh-waitqueue-hashtable-fix.patch

 Fix eliminate-bh-waitqueue-hashtable.patch

-completely-out-of-line-spinlocks--generic.patch
-completely-out-of-line-spinlocks--i386.patch
-completely-out-of-line-spinlocks--x86_64.patch

 Dropped - out of date.

+allow-cluster-wide-flock-update.patch

 flock() extensions for clustered machines

+read_ldt-neglects-checking-of-clear_user-return.patch

 x86_64 read_ldt() fixlet

+searching-for-parameters-in-make-menuconfig.patch

 Permit lookup of a particular config item in menuconfig

+filemap-read-fix.patch

 Fix the occasional off-by-one in do_generic_mapping_read() again again
 again.

+r8169-dac-support-fix.patch

 Net driver fix

+fat-document-fix-update.patch
+nls-nls_cp932-fix.patch

 Fatfs updates

+v4l-i2c-cleanups.patch
+v4l-i2c-tuner-modules-update.patch
+v4l-bttv-driver-update.patch
+v4l-saa7134-driver-update.patch

 V4L updates

+pcxxc-bulid-fix.patch

 Build fix

+fix-f_version-optimization-for-get_tgid_list.patch

 Fix up a /proc optimisation which broke.

+move-wait-ops-contention-case-completely-out-of-line.patch
+reduce-number-of-parameters-to-__wait_on_bit-and-__wait_on_bit_lock.patch
+document-wake_up_bits-requirement-for-preceding-memory-barriers.patch

 Cleanups/fixups for the new buffer/page waiting functions

+kernel-sysfs-events-layer.patch

 rml's dbus stuff

+root-reservations-for-strict-overcommit.patch

 Reserve memory for root in the overcommit code

+fix-the-barrier-ide-detection-logic.patch

 IDE fix for the barrier code

+disable-colour-conversion-in-the-cpia.patch
+add-smc91x-ethernet-for-lpd7a40x.patch

 Driver fixes

+make-bad_page-print-all-of-page-flags.patch

 Print additional debug info in bad_page()

+centralize-some-nls-helpers.patch

 Code cleanup

+fix-compile-warning-in-ppc64-pmac_featurec.patch
+fix-compile-warnings-in-via-pmuc-for-config_pmac_pbook.patch

 Warning fixes

+remove-unused-sysctls-from-kernel-personalityc.patch

 Cleanup

+stop-put_inode-abuse-in-vxfs.patch

 vxfs fix

+some-missing-statics-in-mm.patch

 Give a few thing static scope.

+remove-ptrinfo.patch
+remove-ptrinfo-fix.patch

 Remove unused function

+fix-compile-warning-in-rivafb-on-ppc.patch

 Warning fix

+m32r-base.patch
+m32r-upgrade-to-2681-kernel.patch
+m32r-support-a-new-bootloader-m32r-g00ff.patch

 m32r architecture merge

+fix-drivers-net-cs89x0c-warning.patch

 Warning fix

+announce-hpet-devices-claimed.patch

 Additional HPET discovery printks

+silence-sn_console-driver-on-non-sgi-boxes.patch

 Kill a boot-time printk

+drivers-char-amiserialc-min-max-removal.patch
+drivers-char-epcac-min-max-removal.patch
+drivers-char-espc-min-max-removal.patch
+drivers-char-isicomc-min-max-removal.patch
+drivers-char-mxserc-min-max-removal.patch
+drivers-char-pcmcia-synclink_csc-min-max-removal.patch
+drivers-char-pcxxc-min-max-removal.patch
+drivers-char-riscom8c-min-max-removal.patch
+drivers-char-rocketc-min-max-removal.patch
+drivers-char-rocket_inth-min-max-removal.patch
+drivers-char-selectionc-min-max-removal.patch
+drivers-char-serial167c-min-max-removal.patch
+drivers-char-specialixc-min-max-removal.patch
+drivers-char-synclinkc-min-max-removal.patch
+drivers-char-synclinkmpc-min-max-removal.patch
+include-linux-isicomh-min-max-removal.patch
+drivers-tc-zsc-min-max-removal.patch
+ds1620-replace-schedule_timeout-with-msleep.patch
+dsp56k-replace-schedule_timeout-with-msleep.patch
+ec3104-replace-schedule_timeout-with-msleep.patch
+isicom-replace-schedule_timeout-with-msleep.patch
+nwflash-replace-schedule_timeout-with-msleep.patch
+pcwd-replace-schedule_timeout-with-msleep.patch
+synclink-replace-jiffies_from_ms-with-msecs_to_jiffies.patch
+add-msleep_interruptible-function-to-kernel-timerc.patch
+cdu31a-replace-schedule_timeout-with-msleep.patch
+mcd-replace-schedule_timeout-with-msleep.patch
+radio-radio-maestro-replace-schedule_timeout-with-msleep.patch
+radio-radio-cadet-replace-schedule_timeout-with-msleep.patch
+radio-radio-aimslab-replace-while-schedule-with-msleep.patch
+radio-miropcm20-rds-replace-schedule_timeout-with-msleep.patch
+radio-radio-maxiradio-replace-schedule_timeout-with-msleep.patch
+saa7146_i2cc-use-msleep.patch
+radio-radio-sf16fmi-replace-schedule_timeout-with-msleep.patch
+radio-radio-sf16fmr2-replace-schedule_timeout-with-msleep.patch
+message-mptscsih-replace-schedule_timeout-with-msleep.patch
+message-i2o_core-replace-schedule_timeout-with-msleep.patch
+mtd-cfi_cmdset_0001-replace-schedule_timeout-with-msleep.patch

 Janitorial things

+coda-fix-ifdefs-for-config_coda_fs_old_api.patch
+coda-add-sendfile-wrapper.patch

 coda updates

+sort-the-credits-file-properly-and-add-myself.patch

 alphasort ./CREDITS

+fs-compatc-rwsem-instead-of-bkl-around-ioctl32_hash_table.patch

 bkl removal

+small-wait_on_page_writeback_range-optimization.patch

 Optimise filemap_fdatawait() a bit

+vm-pageout-throttling.patch

  Fix ooms during heavy swapout with oversized request queues (ie: CFQ)

+3w-xxxxc-queue-depth.patch

 3ware driver queue length fixes

+fix-race-in-sysfs_read_file-and-sysfs_write_file.patch

 sysfs race fixes

+update-parport-maintainers-entry.patch

 MAINTAINERS update

+make-hugetlb-expansion-allocation-nowarn.patch

 Suppress a page allocation failure diagnostic

+md-add-interface-for-userspace-monitoring-of-events.patch
+md-correct-working_disk-counts-for-raid5-and-raid6.patch

 md update

+knfsd-calls-to-break_lease-in-nfsd-should-be-o_nonblocking.patch
+knfsd-return-eacces-instead-of-estale-for-certain-filehandle-lookup-failures.patch
+knfsd-fix-incorrect-indentation-in-fh_verify.patch
+nfsd4-support-acl_support-attribute.patch
+knfsd-trivial-cleanup-of-nfs4statec.patch
+nfsd4-could-leak-a-stateid-in-an-error-path.patch
+nfsd4-postpone-release-of-stateowner-on-close.patch
+nfsd4-store-current-tgid-instead-of-lockowner-hash-in-fl_pid.patch
+knfsd-remove-redundant-initialization-in-nfsd4_lockt.patch

 NFS server updates

+remove-in-kernel-init_module-cleanup_module-stubs.patch

 Remove dead code

+airo-build-fix.patch

 Fix airo compilation




number of patches in -mm: 363
number of changesets in external trees: 341
number of patches in -mm only: 350
total patches: 691




linus.patch

x86_64-waitid-syscall-number-fix.patch
  x86_64 waitid syscall number fix

shmem-stubs-fix.patch
  Fix shmem.c stubs

sparc-alsa-fix.patch
  sparc ALSA fix

add_to_swap-suppress-oom-message.patch
  add_to_swap(): suppress oom message

distinct-tgid-tid-cpu-usage.patch
  distinct tgid/tid CPU usage

request_region-for-winbond-and-smsc-parport-drivers.patch
  request_region for winbond and smsc parport drivers
  request_region-for-winbond-and-smsc-parport-drivers fix

es7000-more-mp-busses.patch
  ES7000: increase MAX_MP_BUSSES

es7000-subarch-update.patch
  ES7000 subarch update

fix-target_cpus-for-summit-subarch.patch
  fix target_cpus() for summit subarch

pkt_act-fix.patch
  pkt_act-fix

ipr-build-fix.patch
  ipr.c build fix

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

bk-agpgart.patch

bk-cpufreq.patch

bk-drm.patch

bk-ia64.patch

bk-ieee1394.patch

bk-input.patch

bk-mmc.patch

bk-netdev.patch

bk-pci.patch

bk-pnp.patch

bk-power.patch

bk-serial.patch

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

pegasus-fixes.patch
  pegasus.c fixes

acpi-compile-fix.patch
  acpi-compile-fix

acpi-x86_64-build-fix.patch
  acpi x86_64 build fix

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

ppc-increase-max-auxv-entries.patch
  ppc[64]: increase max auxv entries

pin-the-kernel-stacks-slb-entry.patch
  ppc64: pin the kernel stack's SLB entry

ppc64-enable-debug_spinlock_sleep.patch
  ppc64: enable DEBUG_SPINLOCK_SLEEP

ppc64-test-for-eeh-error-in-pci-config-read-path.patch
  ppc64: test for EEH error in PCI Config-Read path

ppc64-print-backtrace-in-eeh-code.patch
  ppc64: print backtrace in EEH code

ppc64-topdown-support.patch
  ppc64: topdown support

ppc64-topdown-support-arch-specific-get_unmapped_area.patch
  ppc64 topdown support: arch-specific get_unmapped_area()

ppc64-setup-fw_features-before-init_early-calls-on-pseries.patch
  ppc64: Setup fw_features before init_early calls on pSeries

ppc64-make-use-of-batched-iommu-calls-on-pseries-lpars.patch
  ppc64: Make use of batched IOMMU calls on pSeries LPARs

ppc64-another-log-buffer-length-fix.patch
  ppc64 another log buffer length fix

ppc64-dynamically-allocate-emergency-stacks.patch
  ppc64: dynamically allocate emergency stacks

ppc64-update-pseries_defconfig.patch
  ppc64: update pSeries_defconfig

ppc64-update-iseries_defconfig.patch
  ppc64: update iSeries_defconfig

ppc64-quieten-numa-boot-messages.patch
  ppc64: quieten NUMA boot messages

ppc64-allocate-numa-node-data-node-locally.patch
  ppc64: allocate NUMA node data node locally

ppc64-cleanup-asm-processorh.patch
  ppc64: cleanup asm/processor.h

ppc64-implement-page_is_ram.patch
  ppc64: implement page_is_ram

add-support-for-numa-discovery-on-amd-dual-core-to-x86-64.patch
  Add support for NUMA discovery on AMD dual core to x86-64

fix-boot_cpu_data-on-x86-64.patch
  Fix boot_cpu_data on x86-64

increase-bus-apic-limits-on-x86-64.patch
  Increase bus/apic limits on x86-64

ppc64-reloc_hide.patch

factor-out-common-asm-hardirqh-code.patch
  factor out common <asm/hardirq.h> code

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

dev-mem-restriction-patch.patch
  /dev/mem restriction patch

get_user_pages-handle-VM_IO.patch
  fix get_user_pages() against mappings of /dev/mem

pid_max-fix.patch
  Bug when setting pid_max > 32k

jbd-remove-livelock-avoidance.patch
  JBD: remove livelock avoidance code in journal_dirty_data()

journal_add_journal_head-debug.patch
  journal_add_journal_head-debug

list_del-debug.patch
  list_del debug check

lockmeter.patch
  lockmeter
  ia64 CONFIG_LOCKMETER fix

lockmeter-build-fix.patch
  lockmeter-build-fix

lockmeter-for-x86_64.patch
  lockmeter for x86_64

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

ipr-ppc64-depends.patch
  Make ipr.c require ppc

tty_io-hangup-locking.patch
  tty_io.c hangup locking

fix-argument-checking-in-sched_setaffinity.patch
  Fix argument checking in sched_setaffinity

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

nicksched.patch
  nicksched

nicksched-sched_fifo-fix.patch
  nicksched: SCHED_FIFO fix

sched-smtnice-fix.patch
  sched: SMT nice fix

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

journal_clean_checkpoint_list-latency-fix.patch
  journal_clean_checkpoint_list latency fix

filemap_sync-latency-fix.patch
  filemap_sync-latency-fix

pty_write-latency-fix.patch
  pty_write-latency-fix

create-nodemask_t.patch
  Create nodemask_t
  nodemask fix
  nodemask build fix

add-ixdp2x01-board-support-to-cs89x0-driver.patch
  Add IXDP2x01 board support to CS89x0 driver

b44-add-47xx-support.patch
  b44: add 47xx support

allow-x86_64-to-reenable-interrupts-on-contention.patch
  Allow x86_64 to reenable interrupts on contention

fix-smm-failures-on-e750x-systems.patch
  fix SMM failures on E750x systems

serial-cs-and-unusable-port-size-ranges.patch
  serial-cs and unusable port size ranges

scsi-qla2xxx-fix-inline-compile-errors.patch
  qla2xxx gcc-3.5 fixes

add-support-for-it8212-ide-controllers.patch
  Add support for IT8212 IDE controllers

i386-hotplug-cpu.patch
  i386 Hotplug CPU

hotplug-cpu-fix-apic-queued-timer-vector-race.patch
  Hotplug cpu: Fix APIC queued timer vector race

hotplug-cpu-move-cpu_online_map-clear-to-__cpu_disable.patch
  Hotplug cpu: Move cpu_online_map clear to __cpu_disable

new-lost-sync-on-frames-error-in-konicawc.patch
  "Lost sync on frames" error in konicawc module

iteraid.patch
  ITE RAID driver
  iteraid cleanup
  iteraid warning fix
  iteraid: pci_enable_device() for IRQ routing

igxb-speedup.patch
  igxb speedup

serialize-access-to-ide-devices.patch
  serialize access to ide devices

remove-unconditional-pci-acpi-irq-routing.patch
  remove unconditional PCI ACPI IRQ routing

add-pci_fixup_enable-pass.patch
  pci: add pci_fixup_enable pass

propagate-pci_enable_device-errors.patch
  propagate pci_enable_device() errors

acpi-based-i8042-keyboard-aux-controller-enumeration.patch
  ACPI-based i8042 keyboard/aux controller enumeration

disable-atykb-warning.patch
  disable atykb "too many keys pressed" warning

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

268-rc3-jffs2-unable-to-read-filesystems.patch
  jffs2 unable to read filesystems

qlogic-isp2x00-remove-needless-busyloop.patch
  QLogic ISP2x00: remove needless busyloop

cleanup-ptrace-stops-and-remove-notify_parent.patch
  cleanup ptrace stops and remove notify_parent

cleanup-ptrace-stops-and-remove-notify_parent-extra.patch
  cleanup-ptrace-stops-and-remove-notify_parent cleanup

ptrace-api-preservation.patch
  ptrace userspace API preservation

nix-rusage_group.patch
  Remove RUSAGE_GROUP

i386-syscall-tracing-of-bogus-system-calls.patch
  i386 syscall tracing of bogus system calls

fix-proc_symlink-warning-with-config_proc_fs=n.patch
  fix proc_symlink() warning with CONFIG_PROC_FS=n

serial-8250-optionally-skip-autodetection.patch
  Serial 8250 optionally skip autodetection

serial-8250-omap-support.patch
  Serial 8250 OMAP support

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

new-bitmap-list-format-for-cpusets.patch
  new bitmap list format (for cpusets)

cpusets-big-numa-cpu-and-memory-placement.patch
  cpusets - big numa cpu and memory placement

cpusets-config_cpusets-depends-on-smp.patch
  Cpusets: CONFIG_CPUSETS depends on SMP

cpusets-tasks-file-simplify-format-fixes.patch
  Cpusets tasks file: simplify format, fixes

cpusets-simplify-memory-generation.patch
  Cpusets: simplify memory generation

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

reiser4-doc.patch
  reiser4: documentation

reiser4-doc-update.patch
  Update Documentation/Changes for reiser4

reiser4-only.patch
  reiser4: main fs

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

add-acpi-based-floppy-controller-enumeration.patch
  Add ACPI-based floppy controller enumeration.

add-acpi-based-floppy-controller-enumeration-fix.patch
  add-acpi-based-floppy-controller-enumeration fix

update-acpi-floppy-enumeration.patch
  update ACPI floppy enumeration

possible-dcache-bug-debugging-patch.patch
  Possible dcache BUG: debugging patch

kallsyms-data-size-reduction--lookup-speedup.patch
  kallsyms data size reduction / lookup speedup

inconsistent-kallsyms-fix.patch
  Inconsistent kallsyms fix

kallsyms-correct-type-char-in-proc-kallsyms.patch
  kallsyms: correct type char in /proc/kallsyms

cdrom-range-fixes.patch
  cdrom signedness range fixes

vsxxxaac-fixups.patch
  vsxxxaa.c fixups

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

disambiguate-espc-clones.patch
  Disambiguate esp.c clones

move-waitqueue-functions-to-kernel-waitc.patch
  move waitqueue functions to kernel/wait.c

standardize-bit-waiting-data-type.patch
  standardize bit waiting data type

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

document-wake_up_bits-requirement-for-preceding-memory-barriers.patch
  document wake_up_bit()'s requirement for preceding memory barriers

3c59x-pm-fix.patch
  3c59x: enable power management unconditionally

serial-mpsc-driver.patch
  Serial MPSC driver

urandom-initialisation-fix.patch
  urandom initialisation fix

serial-add-support-for-non-standard-xtals-to-16c950-driver.patch
  serial: add support for non-standard XTALs to 16c950 driver

add-support-for-possio-gcc-aka-pcmcia-siemens-mc45.patch
  Add support for Possio GCC AKA PCMCIA Siemens MC45

allow-cluster-wide-flock.patch
  Allow cluster-wide flock

allow-cluster-wide-flock-update.patch
  Allow cluster-wide flock (update)

read_ldt-neglects-to-check-clear_user-return-value.patch
  read_ldt() neglects to check clear_user() return value

read_ldt-neglects-checking-of-clear_user-return.patch
  read_ldt() clear_user() return value checking

make-single-step-into-signal-delivery-stop-in-handler.patch
  make single-step into signal delivery stop in handler

searching-for-parameters-in-make-menuconfig.patch
  searching for parameters in 'make menuconfig'

filemap-read-fix.patch
  filemap read() fix

r8169-dac-support-fix.patch
  r8169: DAC support fix

fat-document-fix-update.patch
  FAT: document fix/update

nls-nls_cp932-fix.patch
  NLS: nls_cp932 fix

v4l-i2c-cleanups.patch
  v4l: i2c cleanups

v4l-i2c-tuner-modules-update.patch
  v4l: i2c tuner modules update

v4l-bttv-driver-update.patch
  v4l: bttv driver update.

v4l-saa7134-driver-update.patch
  v4l: saa7134 driver update

pcxxc-bulid-fix.patch
  pcxx.c build fix

fix-f_version-optimization-for-get_tgid_list.patch
  fix f_version optimization for get_tgid_list

kernel-sysfs-events-layer.patch
  kernel sysfs events layer

root-reservations-for-strict-overcommit.patch
  Root reservations for strict overcommit

fix-the-barrier-ide-detection-logic.patch
  fix the barrier IDE detection logic

disable-colour-conversion-in-the-cpia.patch
  Disable colour conversion in the CPiA Video Camera driver

add-smc91x-ethernet-for-lpd7a40x.patch
  add SMC91x ethernet for LPD7A40X

make-bad_page-print-all-of-page-flags.patch
  make bad_page() print all of page->flags

centralize-some-nls-helpers.patch
  centralize some nls helpers

fix-compile-warning-in-ppc64-pmac_featurec.patch
  fix compile warning in ppc64 pmac_feature.c

fix-compile-warnings-in-via-pmuc-for-config_pmac_pbook.patch
  fix compile warnings in via-pmu.c for !CONFIG_PMAC_PBOOK

remove-unused-sysctls-from-kernel-personalityc.patch
  remove unused sysctls from kernel/personality.c

stop-put_inode-abuse-in-vxfs.patch
  stop ->put_inode abuse in vxfs

some-missing-statics-in-mm.patch
  some missing statics in mm/

remove-ptrinfo.patch
  remove ptrinfo

remove-ptrinfo-fix.patch
  remove-ptrinfo fix

fix-compile-warning-in-rivafb-on-ppc.patch
  fix compile warning in rivafb on ppc

m32r-base.patch
  m32r architecture

m32r-upgrade-to-2681-kernel.patch
  m32r: upgrade to 2.6.8.1 kernel

m32r-support-a-new-bootloader-m32r-g00ff.patch
  m32r: support a new bootloader "m32r-g00ff"

fix-drivers-net-cs89x0c-warning.patch
  fix drivers/net/cs89x0.c warning.

announce-hpet-devices-claimed.patch
  announce hpet devices claimed

silence-sn_console-driver-on-non-sgi-boxes.patch
  silence sn_console driver on non-SGI boxes

drivers-char-amiserialc-min-max-removal.patch
  drivers/char/amiserial.c MIN/MAX removal

drivers-char-epcac-min-max-removal.patch
  drivers/char/epca.c MIN/MAX removal

drivers-char-espc-min-max-removal.patch
  drivers/char/esp.c MIN/MAX removal

drivers-char-isicomc-min-max-removal.patch
  drivers/char/isicom.c MIN/MAX removal

drivers-char-mxserc-min-max-removal.patch
  drivers/char/mxser.c MIN/MAX removal

drivers-char-pcmcia-synclink_csc-min-max-removal.patch
  drivers/char/pcmcia/synclink_cs.c MIN/MAX 	removal

drivers-char-pcxxc-min-max-removal.patch
  drivers/char/pcxx.c MIN/MAX removal

drivers-char-riscom8c-min-max-removal.patch
  drivers/char/riscom8.c MIN/MAX removal

drivers-char-rocketc-min-max-removal.patch
  drivers/char/rocket.c MIN/MAX removal

drivers-char-rocket_inth-min-max-removal.patch
  drivers/char/rocket_int.h MIN/MAX removal

drivers-char-selectionc-min-max-removal.patch
  drivers/char/selection.c MIN/MAX removal

drivers-char-serial167c-min-max-removal.patch
  drivers/char/serial167.c MIN/MAX removal

drivers-char-specialixc-min-max-removal.patch
  drivers/char/specialix.c MIN/MAX removal

drivers-char-synclinkc-min-max-removal.patch
  drivers/char/synclink.c MIN/MAX removal

drivers-char-synclinkmpc-min-max-removal.patch
  drivers/char/synclinkmp.c MIN/MAX removal

include-linux-isicomh-min-max-removal.patch
  include/linux/isicom.h MIN/MAX removal

drivers-tc-zsc-min-max-removal.patch
  drivers/tc/zs.c MIN/MAX removal

ds1620-replace-schedule_timeout-with-msleep.patch
  ds1620: replace schedule_timeout() with msleep()

dsp56k-replace-schedule_timeout-with-msleep.patch
  dsp56k: replace schedule_timeout() with msleep()

ec3104-replace-schedule_timeout-with-msleep.patch
  ec3104: replace schedule_timeout() with msleep()

isicom-replace-schedule_timeout-with-msleep.patch
  isicom: replace schedule_timeout() with msleep()

nwflash-replace-schedule_timeout-with-msleep.patch
  nwflash: replace schedule_timeout() with msleep()

pcwd-replace-schedule_timeout-with-msleep.patch
  pcwd: replace schedule_timeout() with msleep()

synclink-replace-jiffies_from_ms-with-msecs_to_jiffies.patch
  synclink: replace jiffies_from_ms() with msecs_to_jiffies()

add-msleep_interruptible-function-to-kernel-timerc.patch
  Add msleep_interruptible() function to kernel/timer.c

coda-fix-ifdefs-for-config_coda_fs_old_api.patch
  coda: fix ifdefs for CONFIG_CODA_FS_OLD_API

coda-add-sendfile-wrapper.patch
  coda: add sendfile wrapper

sort-the-credits-file-properly-and-add-myself.patch
  Sort the CREDITS file properly (and add Jesper)

fs-compatc-rwsem-instead-of-bkl-around-ioctl32_hash_table.patch
  fs/compat.c: rwsem instead of BKL around ioctl32_hash_table

cdu31a-replace-schedule_timeout-with-msleep.patch
  cdu31a: replace schedule_timeout() with msleep()

mcd-replace-schedule_timeout-with-msleep.patch
  mcd: replace schedule_timeout() with msleep()

radio-radio-maestro-replace-schedule_timeout-with-msleep.patch
  radio/radio-maestro: replace schedule_timeout() with msleep()

radio-radio-cadet-replace-schedule_timeout-with-msleep.patch
  radio/radio-cadet: replace schedule_timeout() with msleep()

radio-radio-aimslab-replace-while-schedule-with-msleep.patch
  radio/radio-aimslab: replace while/schedule() with msleep()

radio-miropcm20-rds-replace-schedule_timeout-with-msleep.patch
  radio/miropcm20-rds: replace schedule_timeout() with msleep()

radio-radio-maxiradio-replace-schedule_timeout-with-msleep.patch
  radio/radio-maxiradio: replace schedule_timeout() with msleep()

saa7146_i2cc-use-msleep.patch
  saa7146_i2c.c: use msleep()

radio-radio-sf16fmi-replace-schedule_timeout-with-msleep.patch
  radio/radio-sf16fmi: replace schedule_timeout() with msleep()

radio-radio-sf16fmr2-replace-schedule_timeout-with-msleep.patch
  radio/radio-sf16fmr2: replace schedule_timeout() with msleep()

message-mptscsih-replace-schedule_timeout-with-msleep.patch
  message/mptscsih: replace schedule_timeout() with msleep()

message-i2o_core-replace-schedule_timeout-with-msleep.patch
  message/i2o_core: replace schedule_timeout() with msleep()

mtd-cfi_cmdset_0001-replace-schedule_timeout-with-msleep.patch
  mtd/cfi_cmdset_0001: replace schedule_timeout() with msleep()

small-wait_on_page_writeback_range-optimization.patch
  small wait_on_page_writeback_range() optimization

vm-pageout-throttling.patch
  vm: pageout throttling

3w-xxxxc-queue-depth.patch
  3w-xxxx.c queue depth

fix-race-in-sysfs_read_file-and-sysfs_write_file.patch
  Fix race in sysfs_read_file() and sysfs_write_file()

update-parport-maintainers-entry.patch
  update parport MAINTAINERS entry

make-hugetlb-expansion-allocation-nowarn.patch
  make hugetlb expansion allocation nowarn

md-add-interface-for-userspace-monitoring-of-events.patch
  md: add interface for userspace monitoring of events.

md-correct-working_disk-counts-for-raid5-and-raid6.patch
  md: correct "working_disk" counts for raid5 and raid6

knfsd-calls-to-break_lease-in-nfsd-should-be-o_nonblocking.patch
  knfsd: calls to break_lease in nfsd should be O_NONBLOCKing

knfsd-return-eacces-instead-of-estale-for-certain-filehandle-lookup-failures.patch
  knfsd: return EACCES instead of ESTALE for certain filehandle lookup failures

knfsd-fix-incorrect-indentation-in-fh_verify.patch
  knfsd: fix incorrect indentation in fh_verify

nfsd4-support-acl_support-attribute.patch
  knfsd: nfsd4: Support acl_support attribute

knfsd-trivial-cleanup-of-nfs4statec.patch
  knfsd: trivial cleanup of nfs4state.c

nfsd4-could-leak-a-stateid-in-an-error-path.patch
  knfsd: nfsd4 could leak a stateid in an error path

nfsd4-postpone-release-of-stateowner-on-close.patch
  knfsd: nfsd4: postpone release of stateowner on CLOSE

nfsd4-store-current-tgid-instead-of-lockowner-hash-in-fl_pid.patch
  knfsd: nfsd4: store current->tgid instead of lockowner hash in fl_pid

knfsd-remove-redundant-initialization-in-nfsd4_lockt.patch
  knfsd: remove redundant initialization in nfsd4_lockt

remove-in-kernel-init_module-cleanup_module-stubs.patch
  Remove in-kernel init_module/cleanup_module stubs

airo-build-fix.patch
  airo build fix



