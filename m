Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbTLQJny (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 04:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTLQJny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 04:43:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:32991 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264229AbTLQJnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 04:43:24 -0500
Date: Wed, 17 Dec 2003 01:43:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-test11-mm1
Message-Id: <20031217014350.028460b2.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test11/2.6.0-test11-mm1/


A fair number of new fixes, none of them very serious.  Most notably,
significant updates to the IDE drivers and to the psmouse, atkbd and
synaptics drivers.




Changes since 2.6.0-test10-mm1:


 linus.patch

 Latest Linus tree

-serio-pm-fix.patch
+synaptics-powerpro-fix.patch
+input-unregister-on-fail-fix.patch
+serio-pm-fix.patch
+input-01-atkbd_softrepeat-fix.patch
+input-02-add-psmouse_proto.patch
+input-03-resume-methods.patch
+input-04-atkbd-reconnect-method.patch
+input-05-psmouse-fixes.patch
+input-06-serio_unregister_port_delayed.patch
+input-07-remove-synaptics-config-option.patch
+input-08-synaptics-protocol-discovery.patch

 psmouse, AT Keyboard and Synaptics fixes

+msi-many-cpus-fix.patch

 MSI fix for NR_CPUS > 32

-fixmap-in-proc-pid-maps.patch
+fixmap-in-proc-pid-maps-ng.patch

 Reworked version of the code which prevents fixmap areas in /proc/pid/maps.
 May not be ready yet.

-nosysfs.patch
+name_to_dev_t-__init.patch
+CONFIG_SYSFS.patch
+CONFIG_SYSFS-boot-from-disk-fix.patch

 Make sysfs a config option.  Needs a bit of testing.

+forcedeth-update-3.patch

 nForce ethernet driver update

-format_cpumask.patch
+cpumask-header-reorg.patch
+cpumask-format-consolidation.patch

 Fiddle with the cpumask code.

-destroy_inode-oops-fix.patch

 Not complete, perhaps not needed.

-tty-proc-oops-fix.patch

 Merged

+jbd-b_committed_data-locking-fix.patch

 Minor ext5 locking tweak

+dvb-i2c-timeout-fix.patch

 Fix i2c bus timeout handling

+compat_timespec-cleanup.patch

 Fix get/put_compat_timespec prototype.

+MAINTAINERS-mailing-list-fixes.patch

 MAINTAINERS fix

+list_empty_careful-docco.patch

 list.h commentary

+compound-pages-dirty-page-fix.patch

 Check and undirty all subpages of a compound page when freeing them.

+3c574_cs-deadlock-fix.patch

 Driver locking fix

+non-fg-console-unimap-fixes.patch

 console ioctl fix

+sym2-speed-selection-fix.patch

 sym2 fixlet.

+jiffies-comment-fix.patch

 Commentary fix

+slab-reclaim-accounting-fix.patch

 Page beancounting fix

+struct_cpy-warning-fix.patch

 Compile warning fix

+more-MODULE_ALIASes.patch

 More MODULE_ALIASes

+x86_64-sysrq-t-fix.patch

 Fix sysrq-t on x86_64

+nr-slab-accounting-fix.patch

 Another page beancounting fix

+moto-ppc32-booting-fix.patch

 Makefile fix for ppc.

+isdn-spinlock-init.patch

 Initialise a spinlock.

+nbd-userspace-build-fix.patch

 Header file fix.

+dac960-separate-queues.patch

 DAC960 speedup.

+cpu_sibling_map-fixes.patch

 Generalise the ia32 cpu_sibling_map code.

+ide-tape-rq-special.patch
+ide-siimage-seagate.patch
+ide-siimage-stack-fix.patch
+ide-siimage-sil3114.patch
+ide-cmd640-pci1.patch
+ide-pdc_old-pio-fix.patch
+ide-pdc_old-udma66-fix.patch
+ide-pdc_old-66mhz_clock-fix.patch
+nforce2-disconnect-quirk.patch
+nforce2-apic.patch
+ide-recovery-time.patch
+ide-pdc_new-proc.patch

 Latest IDE updates from Bart.

+lockmeter-ia64-config-fix.patch

 Add ia64 lockmeter config option.

+4g4g-sep-fix.patch

 Fix the 4g/4g split patch for SEP.



All 300 patches:


linus.patch

mm.patch
  add -mmN to EXTRAVERSION

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

kgdb-over-ethernet.patch
  kgdb-over-ethernet patch

kgdb-over-ethernet-fixes.patch
  kgdb-over-ethernet fixlets

kgdb-CONFIG_NET_POLL_CONTROLLER.patch
  kgdb: replace CONFIG_KGDB with CONFIG_NET_RX_POLL in net drivers

kgdb-handle-stopped-NICs.patch
  kgdb: handle netif_stopped NICs

eepro100-poll-controller.patch

tlan-poll_controller.patch

tulip-poll_controller.patch

tg3-poll_controller.patch
  kgdb: tg3 poll_controller

8139too-poll_controller.patch
  8139too poll controller

kgdb-eth-smp-fix.patch
  kgdb-over-ethernet: fix SMP

kgdb-eth-reattach.patch

kgdb-skb_reserve-fix.patch
  kgdb-over-ethernet: skb_reserve() fix

must-fix.patch

should-fix.patch

must-fix-update-01.patch
  must fix lists update

must-fix-update-2.patch
  must fix list update

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

invalidate_inodes-speedup-fixes-2.patch
  more invalidate_inodes speedup fixes

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

input-use-after-free-checks.patch
  input layer debug checks

acpi_off-fix.patch
  fix acpi=off

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

aic7xxx-parallel-build-fix.patch
  fix parallel builds for aic7xxx

ramdisk-cleanup.patch

intel8x0-cleanup.patch
  intel8x0 cleanups

pdflush-diag.patch

futex-uninlinings.patch
  futex uninlining

zap_page_range-debug.patch
  zap_page_range() debug

call_usermodehelper-retval-fix-3.patch
  Make call_usermodehelper report exit status

asus-L5-fix.patch
  Asus L5 framebuffer fix

jffs-use-daemonize.patch

tulip-NAPI-support.patch
  tulip NAPI support

tulip-napi-disable.patch
  tulip NAPI: disable poll in close

get_user_pages-handle-VM_IO.patch

ia32-MSI-support.patch
  Updated ia32 MSI Patches

ia32-MSI-support-x86_64-fixes.patch

msi-various-fixes.patch
  MSI Update Based on 2.6.0-test9-mm3

msi-many-cpus-fix.patch
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

sparc32-sched_clock.patch

pcibios_test_irq-fix.patch
  Fix pcibios test IRQ handler return

fixmap-in-proc-pid-maps-ng.patch
  report user-readable fixmap area in /proc/PID/maps

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

3c527-smp-update.patch
  SMP support on 3c527 net driver

3c527-race-fix.patch

ext3-latency-fix.patch
  ext3 scheduling latency fix

firmware-kernel_thread-on-demand.patch
  Remove workqueue usage from request_firmware_async()

loop-autoloading-fix.patch
  Fix loop module auto loading

loop-module-alias.patch
  loop needs MODULE_ALIAS_BLOCK

loop-remove-blkdev-special-case.patch

loop-highmem.patch
  remove useless highmem bounce from loop/cryptoloop

loop-highmem-fixes.patch

loop-bio-handling-fix.patch
  loop: BIO handling fix

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

aic7xxx-sleep-in-spinlock-fix.patch

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

forcedeth.patch
  forcedeth: nForce ethernet driver

forcedeth-update-2.patch
  forcedeth update

forcedeth-update-3.patch
  forcedeth update

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

context-switch-accounting-fix.patch
  Fix context switch accounting

access-vfs_permission-fix.patch
  Subject: Re: [PATCH] fix access() / vfs_permission() bug

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

acpi-update.patch
  acpi update

acpi-update-warning-fix.patch

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

mpparse_es7000.patch
  mpparse: fix IRQ breakage from the es7000 merge

x86_64-update.patch
  x86-64 update for 2.6.0test9-mm5

x86_64-statfs64-fix.patch
  Fix statfs64 emulation on x86-64

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

aic7xxx_old-proc-oops-fix.patch
  aic7x_old /proc oops fix

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

3c574_cs-deadlock-fix.patch
  Fix deadlock in 3c574_cs.c

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

x86_64-sysrq-t-fix.patch
  x86_64 sysrq-t fix

nr-slab-accounting-fix.patch
  nr_slab accounting fix

moto-ppc32-booting-fix.patch
  Fix booting on a number of Motorola PPC32 machines

isdn-spinlock-init.patch
  isdn_ppp_ccp.c uses uninitialized spinlock

nbd-userspace-build-fix.patch
  fix userspace compiles with nbd.h

dac960-separate-queues.patch
  DAC960 request queue per disk

cpu_sibling_map-fixes.patch
  ia32 cpu_sibling_map fixes

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

4g4g-athlon-prefetch-handling-fix.patch

4g4g-wp-test-fix.patch
  Fix 4G/4G and WP test lockup

4g4g-KERNEL_DS-usercopy-fix.patch
  4G/4G KERNEL_DS usercopy again

4g4g-vm86-fix.patch
  Fix 4G/4G X11/vm86 oops

4g4g-athlon-triplefault-fix.patch
  Fix 4G/4G athlon triplefault

4g4g-sep-fix.patch
  4g4g SEP fix

ppc-fixes.patch
  make mm4 compile on ppc

aic7xxx_old-oops-fix.patch

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



