Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbTL2JeD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 04:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTL2JeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 04:34:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:729 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263130AbTL2JcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 04:32:22 -0500
Date: Mon, 29 Dec 2003 01:32:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-mm2
Message-Id: <20031229013223.75c531ed.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0/2.6.0-mm2/


. Added the adaptec SCSI driver update from Justin.  There's some
  disagreement over whether the changes in this patch are appropriate, but we
  may as well get some external testing underway.

. Included an update from the ieee1394 team.  Anyone who was having
  firewire problems, please retest.

. A couple of patches here should fix the CDROM-related problems which
  some people saw in 2.6.0-mm1.




Changes since 2.6.0-mm1:


+2.6.0-netdrvr-exp3.patch
+2.6.0-netdrvr-exp3-fix.patch
+Space_c-warning-fix.patch
+via-rhine-netpoll-support.patch

 Experimental net driver tree, plus fixups.

-kgdb-over-ethernet.patch
-kgdb-over-ethernet-fixes.patch
-kgdb-CONFIG_NET_POLL_CONTROLLER.patch
-kgdb-handle-stopped-NICs.patch
-eepro100-poll-controller.patch
-tlan-poll_controller.patch
-tulip-poll_controller.patch
-tg3-poll_controller.patch
-8139too-poll_controller.patch
-kgdb-eth-smp-fix.patch
-kgdb-eth-reattach.patch
-kgdb-skb_reserve-fix.patch

 Old version of kgdb-over-ethernet, dropped.

+kgdboe-netpoll.patch
+kgdboe-non-ia32-build-fix.patch

 New version of kgdboe.  This uses the netpoll infrastructure in the
 experimental net driver tree.

+input-mousedev-remove-jitter.patch
+input-mousedev-ps2-emulation-fix.patch

 PS/2 mouse fixes.

+cpu_sibling_map-fix.patch

 ia32 HT CPU enumeration fix/cleanup.

-aic7xxx-parallel-build-fix.patch

 Dropped.  Hopefully Justin's adaptec driver update fixes this
 (unconfirmed).

+aic7xxx-aic79xx-update.patch

 Big adaptec driver update.

-tulip-NAPI-support.patch
-tulip-napi-disable.patch
-3c527-smp-update.patch
-3c527-race-fix.patch
-forcedeth.patch
-forcedeth-update-2.patch
-forcedeth-update-3.patch
-3c574_cs-deadlock-fix.patch
-e100-oops-fix.patch

 Merged into the experimental net driver tree.

+loop-init-fix.patch

 Fix bugs on loop initialisation error path.

-aic7xxx-sleep-in-spinlock-fix.patch

 Fixed in the big adaptec patch.

-context-switch-accounting-fix.patch

 Fixed in the CPU scheduler update.

-access-vfs_permission-fix.patch

 Dropped.  Was not complete and we're bot sure we want to head this way.

-x86_64-sysrq-t-fix.patch

 In the x86_64 update

+ppc-netboot-build-fixes.patch
+ppc-ksyms-build-fix.patch
+ppc-export-consistent_sync_page.patch
+ppc-mkprep-solaris-fix.patch
+ppc-use-EXPORT_SYMBOL_NOVERS.patch
+ppc-CONFIG_PPC_STD_MMU-fix.patch
+ppc-IBM-MPC-header-cleanups.patch

 Various ppc32 fixes.

-inode-i_sb-checks.patch

 Dropped: filesystems shouldn't pass inodes with a null i_sb into the VFS.

+atapi-mo-support-update.patch
+atapi-mo-support-timeout-fix.patch

 ATAPI CDROM fixups.

+selinux-signal-state-inheritance-control.patch

 SELinux fix

+non-terminating-inflate-fix-fix.patch

 Warning fix

+remove-CardServices-from-ide-cs.patch
+remove-CardServices-from-drivers-net-wireless.patch
+remove-CardServices-from-drivers-serial.patch
+remove-CardServices-from-drivers-serial-fix.patch
+remove-CardServices-final.patch

 Complete the removal of the usage of the CardServices API from drivers. 
 It's a bit late for this, but apparantly the varargs usage in the API cannot
 work correctly on x86_64 (at least).

-sysfs-mem-device-support.patch
-sysfs-misc-device-support.patch
-sysfs-vc-device-support.patch
+sysfs-add-simple-class-device-support.patch
+sysfs-remove-tty-class-device-logic.patch
+sysfs-add-mem-device-support.patch
+sysfs-add-misc-class.patch
+#sysfs-add-vc-class.patch
+sysfs-add-video-class.patch

 More sysfs class device support.  sysfs-add-vc-class.patch is dropped
 because it causes incomprehensible oopses in the TTY layer.  Worrisome.


+mtd-build-fix.patch

 Compile fix.

+pnp-bios-fix.patch

 Fix oops when reading /proc/bus/pnp/devices or /proc/bus/pnp/escd

+ali-ircc-update.patch

 ALI ircc vendor update

+remove-iso9660-size-check.patch

 Remove iso9660 check for sbsector < 660Mb

+tridentfb-non-flatpanel-fix.patch

 fix for tridentfb.c usage on CRTs.

+raid1-resync-qlogic-crash-workaround.patch

 avoid raid1 crash during resync with qlogic controllers

+pci-clear-IORESOURCE_UNSET.patch

 fix pci_update_resource() / IORESOURCE_UNSET on PPC

+log_buf_len_setup-irq-fix.patch

 log_buf_len_setup() irq fix

+shrink_slab-seeks-fix.patch

 shrink_slab acounts for seeks incorrectly

+ieee1394-update.patch

 IEEE-1394 update for 2.6

+kbuild-doc-typo-fix.patch

 fix a little tpyo.

+CONFIG_GAMEPORT-documentation.patch

 CONFIG_GAMEPORT documentation

+reiserfs-silent-mode-fix.patch

 Fix reiserfs handling of `silent' option.

+reiserfs-commit_max_age-mount-option.patch

 reiserfs commit_max_age mount option

+reiserfs_rename-ctime-update.patch

 reiserfs_rename ctime update

+CONFIG_EPOLL-file_struct-members.patch

 CONFIG_EPOLL=n space reduction

+epoll-oneshot-support.patch

 One-shot support for epoll

+documentation-ref-fixes.patch

 Fix 2.6.0's broken documentation references

+non-ia32-make-rpm-fix.patch

 fix non-ia32 `make rpm'

+sched-clock-2.6.0-A1.patch
+sched_clock-2.6.0-A1-deadlock-fix.patch
+sched-statfix-2.6.0-A3.patch
+sched-can-migrate-2.6.0-A2.patch
+sched-cleanup-2.6.0-A2.patch
+sched-style-2.6.0-A5.patch

 CPU scheduler updates and cleanups from Con, Nick, Ingo, Rusty.

+x86_64-01.patch
+x86_64-02.patch
+x86_64-03.patch
+x86_64-04.patch
+x86_64-05.patch
+x86_64-06.patch
+x86_64-07.patch
+x86_64-08.patch
+x86_64-09.patch

 x86_64 update

+lockmeter-does-not-require-CONFIG_X86_TSC.patch

 lockmeter config cleanup

-4g4g-athlon-prefetch-handling-fix.patch
-4g4g-wp-test-fix.patch
-4g4g-KERNEL_DS-usercopy-fix.patch
-4g4g-vm86-fix.patch
-4g4g-athlon-triplefault-fix.patch
-4g4g-sep-fix.patch
-4g4g-sysenter-test-fix.patch

 Folded into 4g-2.6.0-test2-mm2-A5.patch

+4g4g-locked-userspace-copy.patch

 Fix obscure uaccess/mprotect race in the 4g/4g split patch.






All 415 patches


mm.patch
  add -mmN to EXTRAVERSION

2.6.0-netdrvr-exp3.patch

2.6.0-netdrvr-exp3-fix.patch

Space_c-warning-fix.patch

via-rhine-netpoll-support.patch
  via-rhine netpoll support

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix

kgdb-buff-too-big.patch
  kgdb buffer overflow fix

kgdb-warning-fix.patch
  kgdbL warning fix

kgdb-build-fix.patch

kgdb-spinlock-fix.patch

kgdb-fix-debug-info.patch
  kgdb: CONFIG_DEBUG_INFO fix

kgdb-cpumask_t.patch

kgdb-x86_64-fixes.patch
  x86_64 fixes

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll

kgdboe-non-ia32-build-fix.patch

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

RD1-cdrom_ioctl-B6.patch

RD2-ioctl-B6.patch

RD2-ioctl-B6-fix.patch
  RD2-ioctl-B6 fixes

RD3-cdrom_open-B6.patch

RD4-open-B6.patch

RD5-cdrom_release-B6.patch

RD6-release-B6.patch

RD7-presto_journal_close-B6.patch

RD8-f_mapping-B6.patch

RD9-f_mapping2-B6.patch

RD10-i_sem-B6.patch

RD11-f_mapping3-B6.patch

RD12-generic_osync_inode-B6.patch

RD13-bd_acquire-B6.patch

RD14-generic_write_checks-B6.patch

RD15-I_BDEV-B6.patch

cramfs-use-pagecache.patch
  cramfs: use pagecache better

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

unshare_files.patch
  unshare_files

use-unshare_files.patch
  use new unshare_files helper

add-steal_locks.patch
  add steal_locks helper

use-steal_locks.patch
  use new steal_locks helper

env-signedness-fixes.patch
  fix unsigned issue with env_end - env_start

suid-leak-fix.patch
  fix suid leak in /proc

proc-tty-driver-permission-fix.patch
  make /proc/tty/driver/ S_IRUSR | S_IXUSR for root only

serio-01-renaming.patch
  serio: rename serio_[un]register_slave_port to __serio_[un]register_port

serio-02-race-fix.patch
  serio: possible race between port removal and kseriod

serio-03-blacklist.patch
  Add black list to handler<->device matching

serio-04-synaptics-cleanup.patch
  Synaptics: code cleanup

serio-05-reconnect-facility.patch
  serio: reconnect facility

serio-06-synaptics-use-reconnect.patch
  Synaptics: use serio_reconnect

synaptics-powerpro-fix.patch
  synaptics powerpro fix

input-unregister-on-fail-fix.patch
  Input: unregister i8042 port when writing to control register fails

serio-pm-fix.patch
  psmouse pm resume fix

atkbd-24-compatibility.patch
  Fixes for keyboard 2.4 compatibility

input-01-atkbd_softrepeat-fix.patch
  input: fix atkbd_softrepeat

input-02-add-psmouse_proto.patch
  Input: add psmouse_proto parameter

input-03-resume-methods.patch
  Input: implement resume methods

input-04-atkbd-reconnect-method.patch
  Input: add atkbd reconnect method

input-05-psmouse-fixes.patch
  Input: psmouse fixes

input-06-serio_unregister_port_delayed.patch
  Input: add serio_[un]register_port_delayed to fix deadlock

input-07-remove-synaptics-config-option.patch
  Input: remove synaptics config option

input-08-synaptics-protocol-discovery.patch
  Input: synaptics protocol discovery

input-mousedev-remove-jitter.patch
  Input: smooth out mouse jitter

input-mousedev-ps2-emulation-fix.patch
  mousedev PS/@ emulation fix

input-use-after-free-checks.patch
  input layer debug checks

cpu_sibling_map-fix.patch
  cpu_sibling_map fix

acpi-20031203.patch

acpi-20031203-fix.patch

cfq-4.patch
  CFQ io scheduler
  CFQ fixes

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ppc64-bar-0-fix.patch
  Allow PCI BARs that start at 0

ppc64-reloc_hide.patch

ppc64-sched_clock-fix.patch
  implement sched_clock properly

ppc64-use-statfs64.patch
  use compat_statfs64 on ppc64

ppc64-compat_clock.patch
  ppc64: use compat clock syscalls

ppc64-numa-sign-extension-fix.patch
  ppc64: fix sign extension bug in NUMA code

ppc64-IRQ_INPROGRESS-fix.patch
  ppc64: revert IRQ_INPROGRESS change

sn2-console-driver-fix.patch
  sn_serial console fix

qla1280-update.patch
  qla1280 update

sym-speed-fix.patch
  sym2 Ultra-160 fix

aic7xxx-aic79xx-update.patch

aic7xxx_old-proc-oops-fix.patch
  aic7x_old /proc oops fix

aic7xxx_old-oops-fix.patch

ramdisk-cleanup.patch

intel8x0-cleanup.patch
  intel8x0 cleanups

pdflush-diag.patch

futex-uninlinings.patch
  futex uninlining

zap_page_range-debug.patch
  zap_page_range() debug

call_usermodehelper-retval-fix-4.patch
  call_usermodehelper retval fix, take 4

asus-L5-fix.patch
  Asus L5 framebuffer fix

jffs-use-daemonize.patch

get_user_pages-handle-VM_IO.patch

ia32-MSI-support.patch
  Updated ia32 MSI Patches
  MSI Update Based on 2.6.0-test9-mm3
  IOAPIC/MSI compile fixes for NR_CPUS > 32

ia32-efi-support.patch
  EFI support for ia32
  efi warning fix
  fix EFI for ppc64, ia64
  efi: warning fixes
  ia32 EFI: Add CONFIG_EFI
  efi: Update Kconfig help
  efi update patch (ia64)

support-zillions-of-scsi-disks.patch
  support many SCSI disks

SGI-IOC4-IDE-chipset-support.patch
  Add support for SGI's IOC4 chipset

pcibios_test_irq-fix.patch
  Fix pcibios test IRQ handler return

i82365-sysfs-ordering-fix.patch
  Fix init_i82365 sysfs ordering oops

pci_set_power_state-might-sleep.patch

ia64-ia32-missing-compat-syscalls.patch
  From: Arun Sharma <arun.sharma@intel.com>
  Subject: Missing compat syscalls in ia64

compat-layer-fixes.patch
  Minor bug fixes to the compat layer

compat-ioctl-for-i2c.patch
  compat_ioctl for i2c

fix-sqrt.patch
  sqrt() fixes

scale-min_free_kbytes.patch
  scale the initial value of min_free_kbytes

cdrom-allocation-try-harder.patch
  Use __GFP_REPEAT for cdrom buffer

sym-2.1.18f.patch

CONFIG_STANDALONE-default-to-n.patch
  Make CONFIG_STANDALONE default to N

extra-buffer-diags.patch

name_to_dev_t-__init.patch
  make name_to_dev_t __init

CONFIG_SYSFS.patch
  From: Pat Mochel <mochel@osdl.org>
  Subject: [PATCH] Add CONFIG_SYSFS

CONFIG_SYSFS-boot-from-disk-fix.patch

slab-leak-detector.patch
  slab leak detector

early-serial-registration-fix.patch
  serial console registration bugfix

ext3-latency-fix.patch
  ext3 scheduling latency fix

loop-fix-hardsect.patch
  loop: fix hard sector size

loop-module-alias.patch
  loop needs MODULE_ALIAS_BLOCK

loop-remove-blkdev-special-case.patch

loop-highmem.patch
  remove useless highmem bounce from loop/cryptoloop

loop-bio-handling-fix.patch
  loop: BIO handling fix

loop-init-fix.patch
  loop.c doesn't fail init gracefully

cmpci-set_fs-fix.patch
  cmpci.c: remove pointless set_fs()

dentry-bloat-fix-2.patch
  Fix dcache and icache bloat with deep directories

nls-config-fixes.patch
  NSL config fixes

proc_pid_lookup-vs-exit-race-fix.patch
  Fix proc_pid_lookup vs exit race

gcc-Os-if-embedded.patch
  Add `gcc -Os' config option

vm86-sysenter-fix.patch
  Fix sysenter disabling in vm86 mode

refill_counter-overflow-fix.patch
  vmscan: reset refill_counter after refilling the inactive list

verbose-timesource.patch
  be verbose about the time source

acpi-pm-timer.patch
  ACPI PM Timer

acpi-pm-timer-fixes-2.patch
  ACPI PM timer fixes

timer_pm-verbose-timesource-fix.patch
  Subject: [PATCH] linux-2.6.0-test9-mm3_verbose-timesource-acpi-pm_A0

as-regression-fix.patch
  Fix IO scheduler regression

as-request-poisoning.patch
  AS: request poisoning

as-request-poisoning-fix.patch
  AS: request poisining fix

as-fix-all-known-bugs.patch
  AS fixes

as-new-process-estimation.patch
  AS: new process estimation

as-cooperative-thinktime.patch
  AS: thinktime improvement

scale-nr_requests.patch
  scale nr_requests with TCQ depth

truncate_inode_pages-check.patch

local_bh_enable-warning-fix.patch

cdc-acm-softirq-rx.patch
  cdc-acm: move rx processing to softirq

proc-pid-maps-output-fix.patch
  Restore /proc/pid/maps formatting

sis900-pm-support.patch
  Add PM support to sis900 network driver

8139too-locking-fix.patch
  8139too locking fix

ia32-wp-test-cleanup.patch
  ia32 WP test cleanup

powermate-payload-size-fix.patch
  Griffin Powermate fix

more-than-256-cpus.patch
  Fix for more than 256 CPUs

ZONE_SHIFT-from-NODES_SHIFT.patch
  Use NODES_SHIFT to calculate ZONE_SHIFT

memmove-speedup.patch
  optimize ia32 memmove

pipe-readv-writev.patch
  Fix writev atomicity on pipe/fifo

lockless-semop.patch
  lockless semop

percpu_counter-use-alloc_percpu.patch
  use alloc_percpu in percpu_counters

i450nx-scanning-fix.patch
  i450nx PCI scanning fix

find_busiest_queue-commentary.patch
  find_busiest_queue() commentary fix

SOUND_CMPCI-config-typo-fix.patch
  fix SOUND_CMPCI Configure help entry

eicon-linkage-fix.patch
  eicon/ and hardware/eicon/ drivers using the same symbols

kobject-docco-additions.patch
  Improve documentation for kobjects

radeon-line-length-fix.patch
  radeonfb fix

proc-interrupts-use-seq-file.patch
  seq_file version of /proc/interrupts

proc-interrupts-use-seq_file-2.patch
  Finish /proc/interrupts seq_file patch

ide-tape-update.patch
  ide-tape update

intel-440gx-ids-fix.patch

centrino-1ghz-support.patch
  support centrino 1GHz

pnp-fix-1.patch
  PnP Fixes #1

pnp-fix-2.patch
  PnP Fixes #2

pnp-fix-3.patch
  PnP Fixes #3

document-elevator-equals.patch
  document elevator= parameter

cpio-offset-fix.patch
  missing padding in cpio_mkfile in usr/gen_init_cpio.c

watchdog-retval-fix.patch
  watchdog write() return value fixes

document-lib-parser.patch
  Add lib/parser.c kernel-doc

cpumask-header-reorg.patch
  cpumask.h reorg

cpumask-format-consolidation.patch
  new /proc/irq cpumask format; consolidate cpumask display and input code

init-remove-CLONE_FILES.patch
  Remove CLONE_FILES from init kernel thread creation

alpha-stack-dump.patch

usb-msgsize-fix.patch
  HiSpd Isoc 1024KB submits: -EMSGSIZE

pagefault-accounting-fix.patch
  pagefault accounting fix

pagefault-accounting-fix-fix.patch
  pagefault accounting fix fix

pagefault_accounting-fix-fix-fix-fix.patch
  pagefault accounting again

proc_kill_inodes-oops-fix.patch

proc_bus_pci_lseek-remove-lock_kernel.patch
  remove lock_kernel() from proc_bus_pci_lseek()

pagemap-include-recursion-fix.patch
  remove include recursion from linux/pagemap.h

dm-bounce-buffer-fix.patch
  dm and bounce buffer panic fix

ia64-piix5-fix.patch
  PIIX5 Doesn't work on IA64

ide-dma-disabled-fix.patch
  Can't disable IDE DMA

sysfs_remove_dir-vs-dcache_readdir-race-fix.patch
  sysfs_remove_dir Vs dcache_readdir race fix

ext3-external-journal-bd_claim.patch
  ext3: bd_claim for journal device

page-alloc-failure-dump_stack.patch

x86_64-statfs64-fix-2.patch
  statfs64 fix

x86_64-aout-support.patch
  Add a.out support for x86-64

remove-mm-swap_address.patch
  remove mm->swap_address

sis-assignment-fix.patch
  sis comparison / assignment operator fix

sync_dquots-oops-fix.patch
  Subject: [PATCH] Fix possible oops in vfs_quota_sync()

ext3-quota-deadlock-fix.patch
  Ext3+quota deadlock fix

buslogic-update.patch
  BusLogic Driver update

binfmt_elf-help-update.patch
  BINFMT_ELF=m is not an option

invalidate_mmap_range-non-gpl-export.patch
  mark invalidate_mmap_range() as EXPORT_SYMBOL

md-1-limit_max_sectors.patch
  md: Limit max_sectors on md when merge_bvec_fn defined on underlying device.

md-2-set-ra_pages.patch
  md: set ra_pages for raid0/raid5 devices properly.

alsa-sleep-in-spinlock-fix.patch
  ALSA sleep in spinlock fix

do_gettimeofday-tick_usec-fix.patch
  Erronous use of tick_usec in do_gettimeofday

dm-1-fix-block-device-resizing.patch
  dm: fix block device resizing

dm-2-remove-dynamic-table-resizing.patch
  dm: remove dynamic table resizing

dm-3-v4-ioctl-default.patch
  dm: make v4 of the ioctl interface the default

dm-4-set-io-restriction-defaults.patch
  dm: set io restriction defaults

dm-5-sleep-in-spinlock-fix.patch
  dm: dm_table_event() sleep on spinlock bug

fix-ELF-exec-with-huge-bss.patch
  fix ELF exec with huge bss

direct-io-memleak-fix.patch
  O_DIRECT memory leak fix

jbd-b_committed_data-locking-fix.patch
  JBD: b_committed_data locking fix

dvb-i2c-timeout-fix.patch
  dvb i2c timeout fix

compat_timespec-cleanup.patch
  more correct get_compat_timespec interface

MAINTAINERS-mailing-list-fixes.patch
  MAINTAINERS vger.rutgers.edu

list_empty_careful-docco.patch
  list_empty_careful() documentation.

compound-pages-dirty-page-fix.patch
  Clear dirty bits etc on compound frees

non-fg-console-unimap-fixes.patch
  Allow unimap change on non fg console

sym2-speed-selection-fix.patch
  Speed selection fix for sym53c8xx

jiffies-comment-fix.patch
  fix outdated comment in jiffies.h

slab-reclaim-accounting-fix.patch
  slab reclaim accounting fix

struct_cpy-warning-fix.patch
  struct_cpy compilation warning

more-MODULE_ALIASes.patch
  More MODULE_ALIASes

nr-slab-accounting-fix.patch
  nr_slab accounting fix

moto-ppc32-booting-fix.patch
  Fix booting on a number of Motorola PPC32 machines

ppc-netboot-build-fixes.patch
  ppc: netboot build fixes

ppc-ksyms-build-fix.patch
  PPC32: Fix compilation of ppc_ksyms.c on !CONFIG_PPC_STD_MMU

ppc-export-consistent_sync_page.patch
  PPC32: Export consistent_sync_page.

ppc-mkprep-solaris-fix.patch
  PPC32: Fix the mkprep util to work correctly on Solaris 8

ppc-use-EXPORT_SYMBOL_NOVERS.patch
  PPC32: Change all EXPORT_SYMBOL_NOVERS to EXPORT_SYMBOL in ppc_ksyms.c

ppc-CONFIG_PPC_STD_MMU-fix.patch
  PPC32: Select arch/ppc/kernel/head.S on CONFIG_PPC_STD_MMU.

ppc-IBM-MPC-header-cleanups.patch
  PPC32: Minor cleanups to IBM4xx and MPC82xx headers.

isdn-spinlock-init.patch
  isdn_ppp_ccp.c uses uninitialized spinlock

nbd-userspace-build-fix.patch
  fix userspace compiles with nbd.h

dac960-separate-queues.patch
  DAC960 request queue per disk

xfs-update-01.patch
  XFS update

jfs-nfs-le-fix.patch
  JFS fix for NFS on little-endian systems

modpost-fix.patch
  Get modpost to work properly with vmlinux in a different directory

ia32-jiffy-wrap-fixes.patch
  ia32 jiffy wrapping fixes

mm_core_waiters-synchronisation.patch
  From: Roland McGrath <roland@redhat.com>
  Subject: [PATCH] synchronize use of mm->core_waiters

rename-legacy_bus-to-platform_bus.patch
  Rename legacy_bus to platform_bus

ioctl-userspace-warnings-fix.patch
  Fix ioctl related warnings in userspace

tcrypt-cleanup-1.patch
  tcrypt cleanup (1/2)

tcrypt-cleanup-2.patch
  tcrypt cleanup (2/2)

tcrypt-module-unload-fix.patch
  Allow tcrypt module to be unloaded

w83627hf.patch
  Winbond w83627hf driver

get_user_pages-lockup-fix.patch
  Missing up_read after get_user_pages in arch/i386/lib/usercopy.c?

sn2-maintainers-update.patch
  update sn2 MAINTAINERS file entry

ide-capability-elevation-fix.patch
  IDE capability elevation fix

ide-mmio-fix.patch
  IDE MMIO fix

scc-warning-fix.patch
  SCC warning fix

cycx-warning-fix.patch
  cycx_drv warning fix

via-audio-fixes.patch
  VIA audio fixes

locking-doc-update.patch
  Kernel Locking Documentation update

name_to_dev_t-fix.patch
  name_to_dev_t() fix

atapi-mo-support.patch
  ATAPI MO drive support

mt-ranier-support.patch
  mt rainier support

atapi-mo-support-update.patch
  ATAPI MO support update

atapi-mo-support-timeout-fix.patch
  ATAPI MO support timeout fix

ext3-enospc-accounting-fix.patch
  From: Jan Kara <jack@suse.cz>
  Subject: Re: ext3 truncate bug in 2.6.0?

dvb-01-remove-firmware.patch
  dvb: av7110 firmware removal patch

dvb-02-update-saa7146-capture-core.patch
  dvb: Update saa7146 capture core

dvb-03-bt8xx-driver.patch
  dvb: Add new dvb bt8xx driver

dvb-04-skystar2-update.patch
  dvb: Update Skystar2 DVB driver

dvb-05-core-update.patch
  dvb: Update DVB core

dvb-06-frontend-update.patch
  dvb: Update DVB frontend drivers

dvb-07-av7110-update.patch
  dvb: Update av7110 driver

dvb-08-av7110-firmware-loading.patch
  dvb: Add firmware loading support to av7110 driver

dvb-09-ttusb-dec-update.patch
  dvb: Update TTUSB DEC driver

dvb-10-cleanup.patch
  dvb: Cleanup patch to remove 2.4 crud

dvb-11-firmware_class-update.patch
  dvb: Firmware_class update

dvb-12-documentation.patch
  dvb: Add DVB documentation

selinux-separate-output-dir-fix.patch
  Fix SELinux build for "make O=..."

selinux-ioctl-check-fix.patch
  Reduce SELinux check on KDSKBENT/SENT ioctls

selinux-nameidata-oops-fix.patch
  Remove use of nameidata by selinux_inode_permission

selinux-signal-state-inheritance-control.patch
  Subject: [PATCH] Add signal state inheritance control to SELinux

isdn-compile-fix.patch
  isdn/eicon/eicon_mod.c build fix

ia32-GENERIC_ARCH-NUMA-build-fix.patch
  Fix X86_GENERICARCH & NUMA compile error

summit-ebda-parsing-fix.patch
  Fix Summit EBDA parsing

README-typo-fix.patch
  ./README typo fix

alsa-gus-scheduling-in-interrupt-fix.patch
  alsa gus max schedule-in-irq-fix

o21-sched.patch
  O21 for interactivity 2.6.0

fatfs-log-storm-fix.patch
  fatfs: fix printk storm during I/O errors

gconfig-warning-fix.patch
  make gconfig warning removal

via-tsc-fix.patch
  Fix via686a/KX133 TSC failure

fix-es7000-compile.patch
  Fix es7000 compile

ppp_async-locking-fix.patch
  Make ppp_async callable from hard interrupt

fix-sx-stupidity.patch
  Fix double logical operator drivers/char/sx.c

make-try_to_free_pages-walk-zonelist.patch
  make try_to_free_pages walk zonelist

make-try_to_free_pages-walk-zonelist-fix.patch
  zone scanning fix

pcmcia-maintainers.patch
  dhinds is not 2.6 PCMCIA maintainer

yenta-printk-levels.patch
  fix yenta printk logging levels

pcnet_cs-fixes.patch
  pcnet_cs driver bug fix / update

pcmcia-16bit-interrupt-selection-fix.patch
  fix for 16-bit PCMCIA interrupt selection

pcmcia-stack-reduction.patch
  reduce kernel stack usage in PCMCIA CIS parsing

i82365-pci-cruft-removal.patch
  strip out PCI cruft from i82365 driver

proc-pid-maps-gate_map.patch
  /proc/pid/maps gate map

buffer_error-suppression.patch
  relax check of page/bh state on I/O error

main_c-cleanups.patch
  init/main.c trivial cleanups

fat-01-relax-validity-tests.patch
  FAT: More relax FATFS validity tests (1/10)

fat-02-utf8-tailing-dots-fix.patch
  FAT: Fix the tailing dots on the utf8 path (2/10)

fat-03-readv-writev-support.patch
  FAT: add readv/writev support to FAT (3/10)

fat-04-printk-fix.patch
  FAT: trivial printk format fix (4/10)

fat-05-msdos_fs-h-cleanup.patch
  FAT: include/linux/msdos_fs.h cleanup

fat-06-fix-prev_free.patch
  FAT: Fix ->prev_free of fat (6/10)

fat-07-cluster-count-check.patch
  FAT: Add count of clusters check in fat_fill_super() (7/10)

fat-08-misc-cleanups.patch
  FAT: misc cleanups/fixes

fat-09-fat_striptail_len-retval-fix.patch
  FAT: empty path by fat_striptail_len returns the -ENOENT

fat-10-panic-removal.patch
  FAT: Use just printk() instead of unneeded fat_fs_panic()

non-terminating-inflate-fix.patch
  lib/inflate.c fix

non-terminating-inflate-fix-fix.patch

remove-CardServices-from-pcmcia-net-drivers.patch
  CardServices() removal from pcmcia net drivers

remove-CardServices-from-ide-cs.patch
  From: Arjan van de Ven <arjanv@redhat.com>
  Subject: Re: [PATCH 1/10] CardServices() removal from pcmcia net drivers

remove-CardServices-from-drivers-net-wireless.patch
  remove CardServices() from drivers/net/wireless

remove-CardServices-from-drivers-serial.patch
  Remvoe CardServices() from drivers/serial

remove-CardServices-from-drivers-serial-fix.patch
  serial_cs CardServices removal fix

remove-CardServices-final.patch
  final CardServices() removal patches

const-fixes.patch
  const vs. __attribute__((const)) confusion

s390-const-fixes.patch
  s390 const fixes

execve-memleak-fix.patch
  Fix memleak on execve failure

h8300-bitops-update.patch
  H8/300 bitops.h update

document-speedstep-zero-page-usage.patch
  add SpeedStep zero-page usage documentation

fbdev-printk-level-fix.patch
  change two annoying messages from framebuffer drivers

ppdev-module-alias.patch
  ppdev MODULES_ALIAS

floppy-typo-fixes.patch
  From: Juergen Quade <quade@hsnr.de>
  Subject: [PATCH] Small copy-paste typo in floppy.c

__BVEC_START-fix.patch
  Fix another dm and bio problem

kunmap_atomic-check-resched.patch
  Check for preemption in kunmap_atomic()

free_pgt_generic1.patch
  hugepage pagetable freeing fix

SubmittingDrivers-update.patch
  SubmittingDrivers update

sysfs-oops-fix.patch
  fix sysfs oops

sysfs-add-simple-class-device-support.patch
  sysfs: add "simple" class device support

sysfs-remove-tty-class-device-logic.patch
  sysfs: remove tty class device logic

sysfs-add-mem-device-support.patch
  sysfs: add mem class

sysfs-add-misc-class.patch
  sysfs: add misc class

sysfs-add-video-class.patch
  sysfs: add video class

mtd-build-fix.patch
  Fix static build of drivers/mtd/chips/jedec_probe.c

pnp-bios-fix.patch
  From: Adam Belay <ambx1@neo.rr.com>
  Subject: Re: Fw: [Bugme-new] [Bug 1738] New: Oops when reading /proc/bus/pnp/devices or /proc/bus/pnp/escd (on final kernel!)

ali-ircc-update.patch
  ALI ircc vendor update (add support for newer chipset) to FIR driver

remove-iso9660-size-check.patch
  Remove iso9660 check for sbsector < 660Mb

tridentfb-non-flatpanel-fix.patch
  fix for tridentfb.c usage on CRTs.

raid1-resync-qlogic-crash-workaround.patch
  avoid raid1 crash during resync with qlogic controllers

pci-clear-IORESOURCE_UNSET.patch
  fix pci_update_resource() / IORESOURCE_UNSET on PPC

log_buf_len_setup-irq-fix.patch
  log_buf_len_setup() irq fix

shrink_slab-seeks-fix.patch
  shrink_slab acounts for seeks incorrectly

ieee1394-update.patch
  IEEE-1394 update for 2.6

kbuild-doc-typo-fix.patch
  Typo: 2.6.0 docs about kbuild.

CONFIG_GAMEPORT-documentation.patch
  CONFIG_GAMEPORT documentation

reiserfs-silent-mode-fix.patch
  Fix reiserfs handling of `silent' option.

reiserfs-commit_max_age-mount-option.patch
  reiserfs commit_max_age mount option

reiserfs_rename-ctime-update.patch
  reiserfs_rename ctime update

CONFIG_EPOLL-file_struct-members.patch
  CONFIG_EPOLL=n space reduction

epoll-oneshot-support.patch
  One-shot support for epoll

documentation-ref-fixes.patch
  Fix 2.6.0's broken documentation references

non-ia32-make-rpm-fix.patch
  fix non-ia32 `make rpm'

sched-clock-2.6.0-A1.patch
  Relax synchronization of sched_clock()

sched_clock-2.6.0-A1-deadlock-fix.patch
  ia32 sched_clock() deadlock fix

sched-statfix-2.6.0-A3.patch
  scheduler context switch accounting fixes

sched-can-migrate-2.6.0-A2.patch
  can_migrate_task cleanup

sched-cleanup-2.6.0-A2.patch
  CPU scheduler cleanup

sched-style-2.6.0-A5.patch
  sched.c style cleanups

ide-tape-rq-special.patch

ide-siimage-seagate.patch

ide-siimage-stack-fix.patch

ide-siimage-sil3114.patch

ide-cmd640-pci1.patch

ide-pdc_old-pio-fix.patch

ide-pdc_old-udma66-fix.patch

ide-pdc_old-66mhz_clock-fix.patch

nforce2-disconnect-quirk.patch

nforce2-apic.patch

ide-recovery-time.patch

ide-pdc_new-proc.patch

x86_64-01.patch
  From: Andi Kleen <ak@muc.de>
  Subject: [PATCH] Critical x86-64 IOMMU fixes for 2.6.0

x86_64-02.patch
  From: Andi Kleen <ak@muc.de>
  Subject: [PATCH] Fix CPUID compilation on x86-64

x86_64-03.patch
  From: Andi Kleen <ak@muc.de>
  Subject: [PATCH] Fix sysrq-t on x86-64

x86_64-04.patch
  From: Andi Kleen <ak@muc.de>
  Subject: [PATCH] Fix 32bit truncate on x86-64

x86_64-05.patch
  From: Andi Kleen <ak@muc.de>
  Subject: [PATCH] Add more paranoid checking in x86-64 prefetch checker

x86_64-06.patch
  From: Andi Kleen <ak@muc.de>
  Subject: [PATCH] Merge i386 fix for page fault to x86-64

x86_64-07.patch
  From: Andi Kleen <ak@muc.de>
  Subject: [PATCH] Signal fixes for x86-64

x86_64-08.patch
  From: Andi Kleen <ak@muc.de>
  Subject: [PATCH] Don't panic in mpparse on x86-64

x86_64-09.patch
  From: Andi Kleen <ak@muc.de>
  Subject: [PATCH] Fix 32bit siginfo problems on x86-64

list_del-debug.patch
  list_del debug check

print-build-options-on-oops.patch

show_task-free-stack-fix.patch
  show_task() fix and cleanup

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

lockmeter-sparc64-fix.patch

lockmeter-sparc64-fix-fix.patch

lockmeter-preemption-fixes.patch
  lockmeter preemption fixes

lockmeter-ia64-config-fix.patch
  Fix lockmeter on ia64

lockmeter-does-not-require-CONFIG_X86_TSC.patch
  lockmeter does not require CONFIG_X86_TSC

printk-oops-mangle-fix.patch
  disentangle printk's whilst oopsing on SMP

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

4g4g-locked-userspace-copy.patch
  Do a locked user-space copy for 4g/4g

ppc-fixes.patch
  make mm4 compile on ppc

O_DIRECT-race-fixes-rollup.patch
  DIO fixes forward port and AIO-DIO fix
  O_DIRECT race fixes comments
  O_DRIECT race fixes fix fix fix
  DIO locking rework
  O_DIRECT XFS fix

dio-aio-fixes.patch
  direct-io AIO fixes

dio-aio-fixes-fixes.patch
  dio-aio fix fix

readahead-multiple-fixes.patch
  readahead: multipole performance fixes

readahead-simplification.patch
  readahead simplification

aio-sysctl-parms.patch
  aio sysctl parms

aio-01-retry.patch
  AIO: Core retry infrastructure
  Fix aio process hang on EINVAL
  AIO: flush workqueues before destroying ioctx'es
  AIO: hold the context lock across unuse_mm
  task task_lock in use_mm()

4g4g-aio-hang-fix.patch
  Fix AIO and 4G-4G hang

aio-retry-elevated-refcount.patch
  aio: extra ref count during retry

aio-splice-runlist.patch
  Splice AIO runlist for fairer handling of multiple io contexts

aio-02-lockpage_wq.patch
  AIO: Async page wait

aio-03-fs_read.patch
  AIO: Filesystem aio read

aio-04-buffer_wq.patch
  AIO: Async buffer wait
  lock_buffer_wq fix

aio-05-fs_write.patch
  AIO: Filesystem aio write

aio-06-bread_wq.patch
  AIO: Async block read

aio-07-ext2getblk_wq.patch
  AIO: Async get block for ext2

O_SYNC-speedup-2.patch
  speed up O_SYNC writes

O_SYNC-speedup-2-f_mapping-fixes.patch

aio-09-o_sync.patch
  aio O_SYNC
  AIO: fix a BUG
  Unify o_sync changes for aio and regular writes
  aio-O_SYNC-fix bits got lost
  aio: writev nr_segs fix
  More AIO O_SYNC related fixes

aio-09-o_sync-f_mapping-fixes.patch

gang_lookup_next.patch
  Change the page gang lookup API

aio-gang_lookup-fix.patch
  AIO gang lookup fixes

aio-O_SYNC-short-write-fix.patch
  Fix for O_SYNC short writes

aio-12-readahead.patch
  AIO: readahead fixes
  aio O_DIRECT no readahead
  Unified page range readahead for aio and regular reads

aio-12-readahead-f_mapping-fix.patch

aio-readahead-speedup.patch
  Readahead issues and AIO read speedup



