Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUBODdz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 22:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbUBODdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 22:33:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:15839 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263806AbUBODdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 22:33:46 -0500
Date: Sat, 14 Feb 2004 19:33:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.3-rc3
Message-ID: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


More merges, although most of them are architecture updates. IA64,
ppc32/64, SuperH and ARM.

But also some cpufreq, watchdog and ACPI updates.

		Linus

---

Summary of changes from v2.6.3-rc2 to v2.6.3-rc3
============================================

Alex Williamson:
  o ia64: sba_iommu perf tunning and new functionality

Andrew Morton:
  o acpi cpu_has_cpufreq() fix
  o acpi numa build fix
  o Fix buslogic for older gccs
  o selinux: Fix bugs in policy loading code
  o sh: Update defconfig
  o sh: Wrap fb_read/writeX() to __raw_read/writeX()
  o sh: RTC fixes
  o sh: preempt safe lazy fpu handling
  o sh: preempt fixes
  o sh: Fix hp680 board support
  o sh: hd64461 updates
  o sh: Add H8/300 support to sh-sci
  o sh: Misc build fixes
  o sh: hitfb updates (and accel)
  o sh: pvr2fb updates
  o Alpha: fix "extern inline" logic for core IO functions
  o swap extent merging fix
  o Make serial console work for any port
  o Fix fadvise() parameter checking
  o Suppress reiserfs page allocation wanring
  o ppc32: boot and platform fixes
  o ppc32: Fix compilation of IBM Spruce & !CONFIG_SERIAL_TEXT_DEBUG
  o ppc32: use todc time functions for PPC_PREP
  o ppc32: IBM 40x and 4xx fixes
  o ppc32: PPC4xx cleanup
  o ppc32: PPC44x MMU update/fixes
  o ppc32: Update IBM Spruce defconfig

Anton Blanchard:
  o Fix ppc64 build problem
  o add thread_info to oops output
  o various xmon cleanups
  o cleanup debugger hooks

Bartlomiej Zolnierkiewicz:
  o fix build for CONFIG_BLK_DEV_IDEDMA=n

Benjamin Herrenschmidt:
  o Export OF device path for PCI devices
  o ppc32: Add CONFIG_PPC_PMAC64 when building for G5
  o ppc64: Start of PowerMac G5 merge, add all arch and include files
  o ppc64: Add the Kconfig & Makefile changes related to the PowerMac
    G5 merge
  o ppc64: Add some definitions relative to the G5 CPU and POWERMAC
    platform
  o ppc64: Add the head.S changes to boot a PowerMac G5
  o ppc64: Add support for PowerMacs in the OF client interface code
    (prom.c)
  o ppc32: Separate definitions for known vs unknown PowerMac G5 models
  o ppc64: Update the nvram driver to deal with PowerMac G5
  o ppc64: Add the PowerMac PCI support
  o ppc64: Add the G5 (IBM 970) CPU to the cputable
  o ppc64: Add support for PowerMac G5 interrupts
  o ppc64: Add the feature_call function pointer to machdep
  o ppc64: Remove duplicate (& incorrect) definition of
    kern_add_valid()
  o ppc64: Add a missing isync in __hash_page, alloc hash table on
    PowerMac G5
  o ppc64: xmon breakpoints are support on PowerMac G5 too
  o ppc64: Add support for z85c30 SCCs for low level console (PowerMac
    G5)
  o ppc64: Call the PowerMac G5 init routines
  o ppc64: Add CPU NAP mode in idle loop on PowerMac G5
  o ppc64: Add pciconfig_iobase syscall for 32 bits apps only
  o ppc64: Add SMP support for PowerMac G5
  o ppc64: Switch off use of polled mode in i2c driver
  o ppc64: fix build of pmac "mac-io" IDE driver on 64 bits kernel
  o ppc64: fix build of ADB driver
  o ppc64: Fix a refounting issue in macio_asic
  o ppc64: Fix build of via-pmu driver on 64 bits kernel
  o ppc64: Fix break handling in pmac_zilog driver, fixes for 64 bits
    kernel
  o ppc64: Add missing #include, warned on ppc32 and broke build on
    ppc64
  o ppc64: Don't build offb's code that relies on the BootX bootloader
    on ppc64
  o ppc64: Add defconfigs for pSeries and PowerMac G5
  o fix rivafb build on ppc64
  o New radeonfb
  o Fix typo in ppc32 build
  o Fix a link conflict between radeonfb and the radeon DRI
  o ppc64: CONFIG_PPC_PMAC implies CONFIG_ADB_PMU
  o ppc64: export clear_user_page
  o Fix incorrect kfree in radeonfb

Chas Williams:
  o [ATM]: prevent userspace compilation errors with glibc-kernheaders
  o [ATM]: [he] unconditionalize extra pci reads to flush posted writes
  o [ATM]: [clip] delay /proc/net/atm/arp creation

Christoph Hellwig:
  o [XFS] make sure i_size_write is called under i_sem
  o back out fbdev sysfs support

Dave Jones:
  o [CPUFREQ] Silence powernow-k7 when built as a module
  o [CPUFREQ] fix up CPU detection in p4-clockmod <Dominik Brodowski>
  o [CPUFREQ] Geode register fixes
  o [CPUFREQ] Fix an oops unloading p4-clockmod
  o [CPUFREQ] convert powernow-k8 to use frequency tables [1/5] Add a
    struct cpufreq_frequency_table, fill it with content, and use it
    for
  o [CPUFREQ] convert powernow-k8 to use frequency tables [2/5]
  o [CPUFREQ] convert powernow-k8 to use frequency tables [3/5] Keep
    *ppst local to the only function which needs it any longer.
  o [CPUFREQ] convert powernow-k8 to use frequency tables [4/5] Remove
    the *ppst table, and remove an unneccessary forward-declaration
  o [CPUFREQ] convert powernow-k8 to use frequency tables [5/5] Move
    the table verification to an extra function.
  o [CPUFREQ] powernow-k8 printk cleanups from Pavel
  o [CPUFREQ] Pentium-4-M detection fix for speedstep-lib From
    Dominik..
  o [CPUFREQ] Fix deadlock in userspace governor
  o [CPUFREQ] Fix off-by-1000 error in longhaul
  o [CPUFREQ] Remove bogus scaling from longhaul driver freqency tables

Dave Kleikamp:
  o JFS: rename should update mtime on source and target directories
  o JFS: Threads should exit with complete_and_exit

David Mosberger:
  o ia64: Based on patch by Stephane Eranian: Make fpswa version info
    available via /proc/efi/fpswa, rather than printing it at boot
    time.
  o ia64: Fix some more warnings caused by casts used as l-values
  o ia64: Update defconfig
  o ia64: Correct init_task.rbs_bot value (not that it matters)
  o ia64: Drop some unneeded __KERNEL_SYSCALL__ defines (found by Dave
    Jones) and an unnecessary include of <linux/config.h>.
  o ia64: Update toolchain-flags with a check for working .align inside
    a now that there is a fixed GAS.

David S. Miller:
  o [SPARC64]: Fix exception remaining length calcs in VIS copy
    routines
  o Cset exclude:
    davem@nuts.davemloft.net|ChangeSet|20040212080313|45938

Ingo Molnar:
  o open writecount scalability cleanup

Jack Steiner:
  o ia64: Enable cpu_vm_mask maintenance and improve SN2 TLB flushing

James Simmons:
  o framebuffer GPM corruption fix

Jeff Garzik:
  o Bump libata, ata_piix to version 1.0
  o Cset exclude: jgarzik@redhat.com|ChangeSet|20040213172720|60184

Jens Axboe:
  o DVD-R capability flag set incorrectly, /proc formatting fix

Jeroen Vreeken:
  o [AX25]: Fix locking in ax25_rt_free()

Jesse Barnes:
  o ia64: kill misc. warnings

Joe Thornber:
  o dm: block size bug with 64 bit devs

Jun Nakajima:
  o Remove the assumption that the number of the sibling is 2

Keith M. Wesolowski:
  o [SPARC32]: Take parisc atomic_t implementation so they are full
    32-bits
  o [SPARC32]: Stub DMA routines to fix the build
  o [SPARC32]: Mask PIL in local_irq operations

Keith Owens:
  o ia64: Avoid deadlock when using printk() for MCA and INIT records
  o ia64: mca.c cleanup - Delete all record printing code, moved to
    salinfo_decode in user space
  o ia64: mca.c cleanup - Mark variables and functions static where
    possible
  o ia64: mca.c cleanup - Delete dead variables and functions
  o ia64: mca.c cleanup - Reorder to remove the need for forward
    declarations and to consolidate related code
  o ia64: mca.c cleanup - Bjorn's printk cleanup
  o ia64: mca.c - pass irq_safe around
  o ia64: mca.c - Fix the "did we recover from MCA test" and move it up
  o ia64: Periodically forward MCA or INIT records to user-level
  o ia64: Delete redundant ia64_mca_check_errors()
  o ia64: Correct ifdef for srat_num_cpus

Kenneth W. Chen:
  o ia64: fix ld.a emulation
  o ia64: remove unused cpucount variable

Len Brown:
  o [ACPI] nforce2 timer lockup from Maciej W. Rozycki
  o [ACPI] NUMA build fix -- NR_MEMBLKS is now NR_NODE_MEMBLKS
  o [ACPI] delete mention of stale config option ACPI_HT_ONLY
  o [ACPI] don't register disabled processors -- it just confuses
    people
  o [ACPI] clarify error message in processor.c
  o [ACPI] interrupt over-ride fix from i386 (Maciej W. Rozycki)

Linus Torvalds:
  o Make <linux/compiler.h> a bit more palatable to user program
    inclusion.
  o Fix bogus mode bit testing by smbfs
  o This reverts the mmap address hint usage for now
  o ppc64: remove autogenerated file, and incorrect header inclusion
  o Fix "bus_for_each_dev()" and "bus_for_each_drv()", which did not
    correctly handle the "restart from this device/driver" case, and
    caused oopses with ieee1394.
  o Fix broken ppc64 kernel debugger call
  o Make G5 defconfig a bit saner. In particular, we want firewire and
    we do _not_ want the broken MACZILOG serial driver.
  o Remove stale "xmon.h" include
  o Linux 2.6.3-rc3

Marcel Holtmann:
  o [Bluetooth] Support for tracking the voice setting
  o [Bluetooth] Fix race for incoming connections
  o [Bluetooth] Fix error handling for not connected socket
  o [Bluetooth] Fix several copy_to_user() and reference counting
    glitches
  o [Bluetooth] Fix non-blocking socket race conditions

Martin Hicks:
  o ia64: Add EXPORT_SYMBOL for SN2 physical_node_map
  o ia64: don't call note_interrupt() for per-CPU irqs

Martin J. Bligh:
  o NUMA build fix drivers/acpi/numa.c is IA64 only for now -- enforce
    it.

Matthew Wilcox:
  o [WATCHDOG] v2.6.2 watchdog-architecture-cleanup

Roman Zippel:
  o fix FB_RADEON_I2C dependency

Russell King:
  o [ARM] Use __attribute_used__ rather than __attribute__((used))
  o [ARM] Allow sub-architectures to provide their own sched_clock()
  o [ARM] Fix couple of compiler warnings
  o [ARM] Add DMA mask for SA11x0 MCP device
  o [ARM] Improve help for CONFIG_ARM_THUMB

Rusty Russell:
  o Shut up about the damn modules already

Sridhar Samudrala:
  o [SCTP] Use __get_free_pages() to allocate ssnmap
  o [SCTP] Fix SCTP_INITMSG set socket option so that a parameter with
    0 value will not change its current value.
  o [SCTP] Fix sctp_getladdrs()/sctp_getpaddrs() API so that the port
    value in the returned addresses is in network byte order. 

Wim Van Sebroeck:
  o [WATCHDOG] v2.6.2 shwdt-cleanup
  o [WATCHDOG] v2.6.2 watchdog-module_*-update
  o [WATCHDOG] v2.6.2 acquirewdt-cleanup
  o [WATCHDOG] v2.6.2 indydog-v0.3_update
  o [WATCHDOG] v2.6.2 i8xx_tco-v0.06_update
  o [WATCHDOG] v2.6.2 watchdog-Kconfig-patch
  o [WATCHDOG] v2.6.2 indydog-Kconfig+Makefile-patch
  o [WATCHDOG] v2.6.2 pcwd_pci-watchdog
  o [WATCHDOG] v2.6.2 arch-[m68k/sparc/sparc64]-Kconfig-patch

