Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265476AbUBPJ6l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 04:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265471AbUBPJ6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 04:58:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:40360 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264506AbUBPJ5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 04:57:30 -0500
Date: Mon, 16 Feb 2004 01:58:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.3-rc3-mm1
Message-Id: <20040216015823.2dafabb4.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3-rc3/2.6.3-rc3-mm1/


- New hotplug CPU implementation from Rusty

- Dropped the x86 CPU-type selection patches

- Added support for dynamic allocation of unix98 ptys.


Changes since 2.6.3-rc2-mm1:


 linus.patch
 bk-netdev.patch
 bk-input.patch
 bk-acpi.patch
 bk-ieee1394.patch
 bk-scsi.patch

 External trees

-acpi-cpu_has_cpufreq-fix.patch
-buslogic-old-gcc-fix.patch
-selinux-policy-loading-fixes.patch
-ppc32-boot-platform-fixes.patch
-ppc32-prep-use-todc_time.patch
-ppc32-save-restore-fix.patch
-alpha-extern-inline-fix.patch
-swap-extent-fix.patch

 Merged

+i4l-hisax-deadlock-fix-gcc-35-fix.patch

 gcc-3.5: hisax fix

+ppp-active-passive-filter-fix.patch

 Fix for PPP activ/passiv filter

+r8169-rx-wrap-fix.patch

 r8169 Rx wrap fix

+ppc64-saved-command-line-length-fix.patch

 ppc64: fix saved_command_line/cmd_line lengths

+ppc64-debugger-warning-fixes.patch

 ppc64: fix debugger() warnings

-ppc64-spinlock-sleep-debugging.patch

 Was buggy.

-sysfs-class-10-vc.patch

 This still triggers the tty locking race

+sched-domain-balancing-improvements.patch

 scheduler domain balancing improvements

+sched-smt-numa-fix.patch

 sched: fix SMT + NUMA bug

+laptop-mode-2-tweaks.patch

 Laptop-mode simplifications

+kthread-handle-non-booting-CPUs.patch

 kthread: handle CPUs which fail to come up

-cpuhotplug-01-cpu_active_map.patch
-cpuhotplug-02-drain_local_pages.patch
-cpuhotplug-03-core.patch
-cpuhotplug-03-core-workqueue-fix.patch
-cpuhotplug-03-core-numa-fix.patch
-cpuhotplug-up-fixes.patch
-set_cpus_allowed-fix.patch
-cpuhotplug-04-x86-support.patch
-cpuhotplug-x86-up-fixes.patch
+hotplugcpu-generalise-bogolock.patch
+hotplugcpu-use-bogolock-in-modules.patch
+hotplugcpu-core.patch

 New hotplug CPU implementation

-better-i386-cpu-selection.patch
-cpu-options-default-to-y.patch
-i386-default-to-n.patch

 Dropped

+selinux-mark-avc_init-init.patch

 selinux: mark avc_init with __init

+selinux-error-handling-fix.patch

 SELinux: Fix error handling bug.

-ghash.patch
-tty_io-uml-fix.patch
-uml-update.patch
-uml-fixes-2.6.2-rc3-mm1-A2.patch

 This UML patch is out of date

+binfmt_misc-credentials.patch

 binfmt_misc: improve calaulation of interpreter's credentials 

+add-syscalls_h-8.patch
+add-syscalls_h-9.patch
+add-syscalls_h-10.patch

 More syscalls.h work

+stop_machine-warning-fix.patch

 Fix a warning

-highmem-equals-user-friendliness.patch

 Buggy, dropped.

+oprofile-pentium-m-support.patch

 oprofile: add Pentium Mobile support

+debugging-modules.patch

 Documentation on how to debug modules

+sn-setup-cleanup.patch

 SN: cleanup setup.c

+jfs-01-sane-filename-handling.patch

 JFS: sane file name handling

+jfs-02-sane-filename-handling.patch

 JFS: Don't do filename translation by default

+ext3-journalled-quotas.patch
+ext3-journalled-quotas-warning-fix.patch
+ext3-journalled-quotas-cleanups.patch

 ext3: Journalled quotas

+module-headers-cleanup.patch

 Module headers cleanup

+dynamic-pty-allocation.patch

 dynamic pty allocation

+add-clock_was_set.patch

 add clock_was_set to all architectures

+altix-header-cleanups.patch

 Altix header file cleanups

+epoll_ctl-race-fix.patch

 Fix race in epoll_ctl(EPOLL_CTL_MOD)

+slab-printk-suppression.patch

 slab: remove extraneous printk

+do_swap_page-retval-fix.patch

 do_swap_page() return value fix

+ide-tape-locking-fix.patch

 ide-tape locking fix

+ide-tape-remove-onstream-support.patch
+ide-tape-warning-fixes.patch

 ide-tape: remove obsolete onstream support

+platinumfb-update.patch

 Update platinumfb driver




All 265 patches:


linus.patch

bk-netdev.patch

bk-input.patch

bk-acpi.patch

bk-ieee1394.patch

bk-scsi.patch

mm.patch
  add -mmN to EXTRAVERSION

i4l.patch
  ISDN udpate

i4l-st5481-old-gcc-fix.patch
  i4l: fix st5481 compile for gcc-2.9x

i4l-sc-adapter-fix.patch
  i4l: rename drivers/isdn/sc:adapter

i4l-fixups.patch
  i4l: more fixes

gcc-35-hysdn.patch
  gcc-3.5: ISDN fixes

i4l-hisax-deadlock-fix.patch
  i4l: hisax deadlock fix

i4l-hisax-deadlock-fix-gcc-35-fix.patch
  gcc-3.5: hisax fix

ppp-active-passive-filter-fix.patch
  Fix for PPP activ/passiv filter

speedo-warning-fix.patch
  eepro100.c warning fix

input-2wheel-mouse-fix.patch
  input: 2-wheel mouse fix

input-2wheel-mouse-fix-fix.patch
  From: Adrian Bunk <bunk@fs.tum.de>
  Subject: [patch] 2.6.2-mm1: fix warning introduced by input-2wheel-mouse-fix

dmapool-needs-pci.patch
  dmapool needs CONFIG_PCI

tulip-warning-fix.patch

r8169-rx-wrap-fix.patch
  r8169 Rx wrap fix

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix
  kgdb buffer overflow fix
  kgdbL warning fix
  kgdb: CONFIG_DEBUG_INFO fix
  x86_64 fixes

kgdb-doc-fix.patch
  correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll

kgdboe-non-ia32-build-fix.patch

kgdb-warning-fixes.patch
  kgdb warning fixes

kgdb-x86_64-support.patch
  kgdb-x86_64-support.patch for 2.6.2-rc1-mm3

get_unmapped_area-fix.patch
  get_unmapped_area() fix

early_printk.patch
  ia32 early printk

early_printk-use-include.patch
  generate ia32 early_printk via inclusion

early_printk-tweaks.patch
  early printk tweaks

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

psmouse-drop-timed-out-bytes.patch
  psmouse: log and discard timed out bytes

ppc64-prom-warnings.patch
  ppc64: Fix prom.c warnings

ppc64-saved-command-line-length-fix.patch
  ppc64: fix saved_command_line/cmd_line lengths

ppc64-debugger-warning-fixes.patch
  ppc64: fix debugger() warnings

ppc64-reloc_hide.patch

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

cfq-4.patch
  CFQ io scheduler
  CFQ fixes

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ramdisk-cleanup.patch

pdflush-diag.patch

zap_page_range-debug.patch
  zap_page_range() debug

slab-print-name.patch
  slab: print slab name in kmem_cache_init()

ptrace-page-permission-fix.patch
  prevent ptrace from altering page permissions

get_user_pages-handle-VM_IO.patch
  fix get_user_pages() against mappings of /dev/mem

support-zillions-of-scsi-disks.patch
  support many SCSI disks

pci_set_power_state-might-sleep.patch

CONFIG_STANDALONE-default-to-n.patch
  Make CONFIG_STANDALONE default to N

extra-buffer-diags.patch

CONFIG_SYSFS.patch
  From: Pat Mochel <mochel@osdl.org>
  Subject: [PATCH] Add CONFIG_SYSFS

CONFIG_SYSFS-boot-from-disk-fix.patch

slab-leak-detector.patch
  slab leak detector

loop-remove-blkdev-special-case.patch

loop-highmem.patch
  remove useless highmem bounce from loop/cryptoloop

loop-bio-handling-fix.patch
  loop: BIO handling fix

loop-init-fix.patch
  loop.c doesn't fail init gracefully

loop-remove-redundant-assignment.patch
  loop: remove redundant initialisation

acpi-pm-timer-3.patch
  ACPI PM timer version 3

acpi-pm-timer-kill-printks.patch

use-TSC-for-delay_pmtmr-2.patch
  Use TSC for delay_pmtmr()

scale-nr_requests.patch
  scale nr_requests with TCQ depth

truncate_inode_pages-check.patch

local_bh_enable-warning-fix.patch

sched-find_busiest_node-resolution-fix.patch
  sched: improved resolution in find_busiest_node

sched-domains.patch
  sched: scheduler domain support

sched-clock-fixes.patch
  fix sched_clock()

sched-build-fix.patch
  sched: fix for NR_CPUS > BITS_PER_LONG

sched-sibling-map-to-cpumask.patch
  sched: cpu_sibling_map to cpu_mask

p4-clockmod-sibling-map-fix.patch
  p4-clockmod sibling_map fix

p4-clockmod-more-than-two-siblings.patch
  p4-clockmod: handle more than two siblings

sched-domains-i386-ht.patch
  sched: implement domains for i386 HT

sched-find_busiest_group-fix.patch
  sched: Fix CONFIG_SMT oops on UP

sched-domain-tweak.patch
  i386-sched-domain code consolidation

sched-no-drop-balance.patch
  sched: handle inter-CPU jiffies skew

sched-arch_init_sched_domains-fix.patch
  Change arch_init_sched_domains to use cpu_online_map

sched-many-cpus-build-fix.patch
  Fix build with NR_CPUS > BITS_PER_LONG

sched-find_busiest_group-clarification.patch
  sched: clarify find_busiest_group

sched-find_busiest_group-arith-fix.patch
  sched: find_busiest_group arithmetic fix

sched-remove-noisy-printks.patch

sched-directed-migration.patch
  sched_balance_exec(): don't fiddle with the cpus_allowed mask

sched-domain-debugging.patch
  sched_domain debugging

sched-domain-balancing-improvements.patch
  scheduler domain balancing improvements

sched-smt-numa-fix.patch
  sched: fix SMT + NUMA bug

ppc64-cpu_vm_mask-fix.patch
  ppc64: cpu_vm_mask fix

ide-siimage-seagate.patch

ide-ali-UDMA6-support.patch
  IDE: Add support of UDMA6 on ALi rev > 0xc4

fa311-mac-address-fix.patch
  wrong mac address with netgear FA311 ethernet card

laptop-mode-2.patch
  laptop-mode for 2.6, version 6
  Documentation/laptop-mode.txt
  laptop-mode documentation updates
  Laptop mode documentation addition

laptop-mode-2-tweaks.patch

pid_max-fix.patch
  Bug when setting pid_max > 32k

use-soft-float.patch
  Use -msoft-float

DRM-cvs-update.patch
  DRM cvs update

drm-include-fix.patch

kthread-primitive.patch
  kthread primitive
  Fix race in kthread_stop
  kthread: block all signals
  kthread use-after-free fix

use-kthread-primitives.patch
  Use kthread primitives

module-removal-use-kthread.patch
  Module removal to use kthread
  kthread oops fixes

kthread-affinity-fix.patch
  Affinity of kthread fix

call_usermodehelper-affinity-fix.patch
  Affinity of call_usermode_helper fix

kthread-handle-non-booting-CPUs.patch
  kthread: handle CPUs which fail to come up

remove-kstat-cpu-notifiers.patch
  Remove kstat cpu notifiers

workqueue-cleanup-2.patch
  Minor workqueue.c cleanup

remove-more-cpu-notifiers.patch
  Remove More Unneccessary CPU Notifiers

use-CPU_UP_PREPARE-properly.patch
  Use CPU_UP_PREPARE properly

hotplugcpu-generalise-bogolock.patch
  Atomic Hotplug CPU: Generalize Bogolock

hotplugcpu-use-bogolock-in-modules.patch
  Atomic Hotplug CPU: Use Bogolock in module.c

hotplugcpu-core.patch
  Atomic Hotplug CPU: Hotplug CPU Core

limit-hash-table-sizes.patch
  Limit hash table size

slab-poison-hex-dumping.patch
  slab: hexdump for check_poison

pentium-m-support.patch
  add Pentium M and Pentium-4 M options

old-gcc-supports-k6.patch
  gcc 2.95 supports -march=k6 (no need for check_gcc)

amd-elan-is-a-different-subarch.patch
  AMD Elan is a different subarch

selinux-01-context-mount-support.patch
  SELinux: context mount support - LSM/FS

selinux-02-nfs-context-mounts.patch
  SELinux: context mount support - NFS

selinux-03-context-mounts-selinux.patch
  SELinux: context mount support - SELinux changes.

devfs-do_mount-fix.patch
  devfs do_mount fix

selinux-enforce-node-fix.patch
  selinux: Allow non-root processes to read selinuxfs enforce node

selinux-mark-avc_init-init.patch
  selinux: mark avc_init with __init

selinux-error-handling-fix.patch
  SELinux: Fix error handling bug.

serial-02-fixups.patch
  serial fixups (untested)
  serial-02 fixes
  serial-02 fixes

serial-03-fixups.patch
  more serial driver fixups
  serial-03 fixes
  serial-03 fixes

nfs-31-attr.patch
  NFSv2/v3/v4: New attribute revalidation code

blk_congestion_wait-return-remaining.patch
  return remaining jiffies from blk_congestion_wait()

vmscan-remove-priority.patch
  mm/vmscan.c: remove unused priority argument.

kswapd-throttling-fixes.patch
  kswapd throttling fixes

vm-dont-rotate-active-list.patch
  vmscan: avoid rotation of the active list

vm-lru-info.patch
  vmscan: make better use of referenced info

vm-shrink-zone.patch
  vmscan: several tuneups

vm-shrink-zone-div-by-0-fix.patch

vm-tune-throttle.patch
  vmscan: delay throttling a little

page_add_rmap-warning.patch

add-config-for-mregparm-3-ng.patch
  Add CONFIG for -mregparm=3
  arch/i386/Makefile,scripts/gcc-version.sh,Makefile small fixes

use-funit-at-a-time.patch
  Use -funit-at-a-time on ia32

add-noinline-attribute.patch
  Add noinline attribute

dont-inline-rest_init.patch
  use noinline for rest_init()

gcc-35-bonding.patch
  gcc-3.5: bonding

non-readable-binaries.patch
  Handle non-readable binfmt_misc executables

binfmt_misc-credentials.patch
  binfmt_misc: improve calaulation of interpreter's credentials

doc-remove-modules-conf-references.patch
  Documentation: remove /etc/modules.conf refs

more-MODULE_ALIASes.patch
  add some more MODULE_ALIASes

bonding-alias-revert-and-docco-fix.patch
  bonding alias revert and documentation fix

sleep_on-needs_lock_kernel.patch
  sleep_on(): check for lock_kernel

i830-agp-pm-fix.patch
  Intel i830 AGP fix

x86_64-make-xconfig-fix.patch
  Fix make xconfig on /lib64 systems

usb-sddr09-documentation.patch
  add comments to sddr09.c

pcnet32-locking-fix.patch
  pcmet32 locking fixes

nfs-server-in-root_server_path.patch
  Pull NFS server address out of root_server_path

increase-NGROUPS.patch
  NGROUPS 2.6.2rc2 + fixups
  NGROUPS: remove TASK_SIZE usage
  NGROUPS: generalise condition for freeing sub-pages

increase-NGROUPS-nfsd-cleanup.patch
  NGROUPS: nfsd cleanup

increase-NGROUPS-cleanup-and-fix.patch
  NGROUPS: cleanup and fix

intermezzo-NGROUPS-is-broken.patch

compat-signal-noarch-2004-01-29.patch

compat-signal-ppc64-2004-01-29.patch

compat-signal-ia64-2004-01-29.patch

bd_set_size-i_size-fix.patch
  bd_set_size i_size handling

nfs-d_drop-lowmem.patch
  NFS: handle nfs_fhget() error

initramfs-kinit_command.patch
  initramfs: look for /sbin/init

access-permissions-fix.patch
  fix access() POSIX compliance

snprintf-fixes.patch
  snprintf fixes

devfs-race-fix-cleanup.patch
  devfs: race fixes and cleanup

centaur-crypto-core-support.patch
  First steps toward VIA crypto support

enable-largefile-coredumps.patch
  Enable coredumps > 2GB

adaptive-lazy-readahead.patch
  adaptive lazy readahead

mips-new-serial-drivers.patch
  MIPS: New 2.6 serial drivers

add-syscalls_h.patch
  add syscalls.h

add-syscalls_h-fixes.patch

add-syscalls-update.patch
  syscalls.h update1

add-syscalls_h-3.patch
  more syscalls.h stuff

add-syscalls_h-4.patch
  syscalls.h fixes

add-syscalls_h-6.patch
  syscalls.h (updates # 6)

add-syscalls_h-7.patch
  syscalls update ver. 7

add-syscalls_h-8.patch
  syscalls update #8

add-syscalls_h-9.patch
  syscalls.h update #9 (open/close)

add-syscalls_h-10.patch
  syscalls.h #10

stop_machine-warning-fix.patch

ifdef-cleanups.patch
  #if versus #ifdef cleanup

nfsd-01-schedule-in-spinlock-fix.patch
  kNFSd: Fix possible scheduling_while_atomic in cache.c

nfsd-02-sunrpc-cache-init-fixes.patch
  kNFSd: Allow sunrpc/svc cache init function to modify the "key"

nfsd-03-ip_map_init-kmalloc-check.patch
  kNFSd: ip_map_init does a kmalloc which isn't checked...

nfsd-04-convert-proc-to-seq_file.patch
  kNFSd: convert NFS /proc interfaces to seq_file

nfsd-05-no-procfs-build-fix.patch
  kNFSd:fix build problems in nfs w/o proc_fs on 2.6.0-test5

md-01-START_ARRAY-is-deprecated.patch
  md: Print "deprecated" warning when START_ARRAY is used.

md-02-split-end_request-handlers.patch
  md: Split read and write end_request handlers

md-03-discard-r1_bio-cmd-field.patch
  md: Discard the cmd field from r1_bio structure

md-04-r1_bio-cleanup.patch
  md: Remove some un-needed fields from r1bio_s

md-05-avoid-bio-allocation.patch
  md: Avoid unnecessary bio allocation during raid1 resync

md-06-raid1-limit-bio-sizes.patch
  md: Dynamically limit size of bio requests used for raid1 resync

md-07-allow-partitioning.patch
  md: Allow partitioning of MD devices.

dm-01-export-dm_vcalloc.patch
  dm: Export dm_vcalloc()

dm-02-move-to_bytes-to_sectors.patch
  dm: Move to_bytes() and to_sectors() into dm.h

dm-03-remove-dm_deferred_io.patch
  dm: Get rid of struct dm_deferred_io in dm.c

dm-04-maintain-bio-ordering.patch
  dm: Maintain ordering when deferring bios

dm-05-alloc_dev-error-cleanup.patch
  dm: Tidy up the error path for alloc_dev()

dm-07-dm_table_create-GFP-fix.patch
  dm: Correct GFP flag in dm_table_create()

dm-08-zero-size-target-fix.patch
  dm: Zero size target sanity check

dm-09-dec_pending-locking-cleanup.patch
  dm: Remove redundant spin lock in dec_pending()

dm-10-drop-BIO_SEG_VALID.patch
  dm: drop BIO_SEG_VALID bit

nfs-avoid-i_size_write.patch
  NFS: avoid unlocked i_size_write()

ia32-discontig-pfn_valid-fix.patch
  fix pfn_valid on ia32 discontigmem

ia32-pfn_to_nid-fix.patch
  ia32: pfn_to_nid fix

ia32-numa-pcs-dont-work.patch
  ia32: disallow NUMA on PC subarch

8259-timer-ack-fix.patch
  8259 timer ack fix

mce-printk-level-fixes.patch
  Fix printk level on non fatal MCEs

mce-preempt-fixes.patch
  MCE fixes and cleanups

bitmap_snprintf-bitmap_scnprintf.patch
  Rename bitmap_snprintf() and cpumask_snprintf() to *_scnprintf()

oss-cruft-removal.patch
  OSS: remove #ifdef's for kernel 2.0

stallion-decruftery.patch
  remove kernel 2.2 #ifdef's from {i,}stallion.h

external-kbuild-doc.patch
  kbuild documentation fix

adfs-2.2-cruft.patch
  adfs: remove a kernel 2.2 #ifdef

panic-later-if-too-many-boot-params.patch
  defer panic for too many items in boot parameter line

altix-irq-accounting-speedup.patch
  altix: use the pda to count interrupts

altix-simulator-fix.patch
  altix: skip init_platform_hubinfo() if on the simulator

cpufreq_scale-fix-cleanup.patch
  cpufreq_scale() fixes

alsa-vx_core-locking-fix.patch
  alsa/vx_core locking fix

cross-compilation-fixes.patch
  Minor cross-compile issues

proc-thread-visibility-fix.patch
  /proc thread visibility fixes

console-race-fix.patch
  drivers/char/vt possible race

nfsd-needs-loff_t.patch
  off_t in nfsd_commit needs to be loff_t

show_free_areas-online-cpus.patch
  skip offline CPUs in show_free_areas

nbd-proc-partitions-fix.patch
  fix display of NBD in /proc/partitions

use-THREAD_SIZE.patch
  cleanup patch that prepares for 4Kb stacks

3c59x-enable_wol.patch
  3c59x: bring back the `enable_wol' option

oprofile-nmi_timer_int-fix.patch
  Oprofile: fix nmi_timer_int detection

oprofile-arm-support.patch
  oprofile: ARM infrastructure

oprofile-pentium-m-support.patch
  oprofile: add Pentium Mobile support

increase-max_anon.patch
  remove max_anon limit

release_region-race-fix.patch
  Fix __release_region() race

nfs-mount-oops-fix.patch
  nfs mount oops fix

debugging-modules.patch
  Documentation on how to debug modules

sn-setup-cleanup.patch
  SN: cleanup setup.c

jfs-01-sane-filename-handling.patch
  JFS: sane file name handling

jfs-02-sane-filename-handling.patch
  JFS: Don't do filename translation by default

ext3-journalled-quotas.patch
  ext3: Journalled quotas

ext3-journalled-quotas-warning-fix.patch

ext3-journalled-quotas-cleanups.patch

module-headers-cleanup.patch
  Module headers cleanup

dynamic-pty-allocation.patch
  dynamic pty allocation

add-clock_was_set.patch
  add clock_was_set to all architectures

altix-header-cleanups.patch
  Altix header file cleanups

epoll_ctl-race-fix.patch
  Fix race in epoll_ctl(EPOLL_CTL_MOD)

slab-printk-suppression.patch
  slab: remove extraneous printk

do_swap_page-retval-fix.patch
  do_swap_page() return value fix

ide-tape-locking-fix.patch
  ide-tape locking fix

ide-tape-remove-onstream-support.patch
  ide-tape: remove obsolete onstream support

ide-tape-warning-fixes.patch

platinumfb-update.patch
  Update platinumfb driver

list_del-debug.patch
  list_del debug check

print-build-options-on-oops.patch

show_task-free-stack-fix.patch
  show_task() fix and cleanup

show_task-fix.patch
  show_task() is not SMP safe

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

ia64-lockmeter-fix.patch

lockmeter-2.2-cruft.patch
  lockmeter.h: remove kernel 2.2 #ifdef (i386 + alpha)

4g-2.6.0-test2-mm2-A5.patch
  4G/4G split patch
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g/4g usercopy atomicity fix
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g/4g usercopy atomicity fix
  4G/4G preempt on vstack
  4G/4G: even number of kmap types
  4g4g: fix __get_user in slab
  4g4g: Remove extra .data.idt section definition
  4g/4g linker error (overlapping sections)
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g4g: show_registers() fix
  4g/4g usercopy atomicity fix
  4g4g: debug flags fix
  4g4g: Fix wrong asm-offsets entry
  cyclone time fixmap fix
  4G/4G preempt on vstack
  4G/4G: even number of kmap types
  4g4g: fix __get_user in slab
  4g4g: Remove extra .data.idt section definition
  4g/4g linker error (overlapping sections)
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g4g: show_registers() fix
  4g/4g usercopy atomicity fix
  4g4g: debug flags fix
  4g4g: Fix wrong asm-offsets entry
  cyclone time fixmap fix
  use direct_copy_{to,from}_user for kernel access in mm/usercopy.c
  4G/4G might_sleep warning fix
  4g/4g pagetable accounting fix
  Fix 4G/4G and WP test lockup
  4G/4G KERNEL_DS usercopy again
  Fix 4G/4G X11/vm86 oops
  Fix 4G/4G athlon triplefault
  4g4g SEP fix
  Fix 4G/4G split fix for pre-pentiumII machines
  4g/4g PAE ACPI low mappings fix

zap_low_mappings-fix.patch
  zap_low_mappings() cannot be __init

4g4g-locked-userspace-copy.patch
  Do a locked user-space copy for 4g/4g

ppc-fixes.patch
  make mm4 compile on ppc

O_DIRECT-race-fixes-rollup.patch
  O_DIRECT data exposure fixes

O_DIRECT-ll_rw_block-vs-block_write_full_page-fix.patch
  Fix race between ll_rw_block() and block_write_full_page()

blockdev-direct-io-speedup.patch
  blockdev direct-io speedups

dio-aio-fixes.patch
  direct-io AIO fixes

aio-fallback-bio_count-race-fix-2.patch
  AIO+DIO bio_count race fix

aio-sysctl-parms.patch
  aio sysctl parms



