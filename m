Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbUCDG1R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 01:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbUCDG0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 01:26:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:3233 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261478AbUCDG0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 01:26:25 -0500
Date: Wed, 3 Mar 2004 22:32:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.4-rc2
Message-ID: <Pine.LNX.4.58.0403032229450.5202@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's mainly ARM, XFS, PCI hotplug and firewire updates. And some parport
cleanups and fixes from Al.

And a fairly small merge from Andrew (s390 and random stuff).

		Linus


Summary of changes from v2.6.4-rc1 to v2.6.4-rc2
============================================

<jpk:sgi.com>:
  o [XFS] Merge missing mount stripe-unit/width-alignment check

Adrian Bunk:
  o move rme96xx to Documentation/sound/oss/

Alexander Viro:
  o oops on HPFS filesystem file rename
  o parport: move exports to where they are defined
  o parport: use module_init()
  o parport: sysctl registration
  o parport: option parsing cleanup
  o parport: fix probe leaks
  o parport: slave port cleanups
  o parport: fix parport_unregister_port
  o parport: clean up parport_announce_port and friends
  o parport: keep track of parport_pc ports
  o parport: keep track of parport_sunbpp ports
  o parport: get rid of parport_enumerate
  o parport: list cleanups

Andrew Morton:
  o fix x86_64 build for sys_device_register rename
  o [ATM]: Gcc-3.5 fix for net/atm/lec.c
  o fix umount dataloss problem
  o ppc64: fix a bug in iSeries MMU hash management
  o ppc64: iSeries virtual disk update
  o Add missing numa EXPORT_SYMBOLs
  o ppc64: Update G5 defconfig, remove DISCONTIGMEM
  o s390: core s390 update
  o s390: common i/o layer
  o s390: sclp console
  o s390: tape class for s390 tapes
  o s390: xpram driver
  o Doc/00-index additions
  o sysrq-o atomicity fix
  o fix small highmem bio bounce bvec handling glitch
  o move scatterwalk functions to own file
  o fix in-place de/encryption bug with highmem
  o dm-crypt cleanups
  o dm-crypt end_io bv_offset fix
  o revert the /proc thread visibility fix
  o zr36067 driver update
  o C99 initializers for drivers/usb/serial/keyspan.h
  o C99 initiailzers for drivers/isdn/hisax/hisax_fcpcipnp.c
  o raid1: fix oops in bio_put()
  o linux/README update
  o DCSSBLK depends on CONFIG_S390
  o NFS SUNRPC fix
  o Fix tty drivers which dont set tty_driver->devfs_name
  o Fix VT mode change vs. fbcon
  o sys_alarm() return value fix
  o Fix network hashtable sizing
  o buslogic initsection fix
  o remove a few remaining "make dep" references
  o clarify CONFIG_SWAP Kconfig help
  o Make powernow-k8 cpufreq control work again
  o x86-64 fixes for 2.6.4rc1
  o watchdog updates
  o convert pdflush to kthread
  o firmware loader: pin firmware module
  o firmware loader: delay firmware hotplug event
  o swsusp: fix error handling in "not enough swap space"
  o m68k interrupt handling fix
  o scripts/modpost warning
  o oprofile: fix P4 HT msr sharing

Bart De Schuymer:
  o [BR_NETFILTER]: Fix vlan-encapsulated fragmented IP traffic

Bartlomiej Zolnierkiewicz:
  o update for pdc202xx_old driver

Ben Collins:
  o IEEE1394(r1165): Better pending packet handling, patch from Steve
  o IEEE1394(r1166): Move generic packet initialization to kmem_cache
    ctor
  o IEEE1394(r1167): Cleanup hostnum allocation to prevent race of
    double allocation
  o IEEE1394(r1168): Add on a mempool for packet allocation, in
    addition to the kmem_cache
  o IEEE1394(r1169): Trivial cleanups
  o IEEE1394: Revision sync
  o IEEE1394/SBP2(r1170): Unblock scsi requests specifically in the
    update callback
  o IEEE1394/Video1394(r1171): Fix bug with cdev_add usage from a
    previous change
  o IEEE1394(r1172): Generalize the default config rom entries for new
    hosts
  o IEEE1394/eth1394(r1175): Added MODULE_DEVICE_TABLE()
  o IEEE1394: Revision sync
  o IEEE1394(r1176): Remove mempool and ctor stuff
  o IEEE1394/dv(r1177): Fix dv1394 devfs cleanup
  o IEEE1394/ohci(r1179): Remove ohci->id. It was just the same as
    host->id anyway
  o SPARC/m68k: Remove sun_setup_serial references, which is already
    gone
  o IEEE1394(r1180): Fix pdrv update call to use ud class list. Fixes
    an oops

Benjamin Herrenschmidt:
  o ppc32: Fix crash on load  in DACA sound driver
  o radeonfb: some more PLL problems
  o /proc/cpuinfo fixes for G5

Chip Salzenberg:
  o export locks_remove_posix

Christoph Hellwig:
  o [XFS] use generic XFS stats and sysctl infrastructure in pagebuf
  o [XFS] Remove a superflous i_size_write
  o [XFS] Fix up daemon names
  o [XFS] only lock pagecache pages
  o [XFS] plug race in pagebuf freeing
  o [XFS] kill some dead constants from pagebuf

Dave Kleikamp:
  o JFS: Error path accessed uninitialized variables
  o JFS: Support sharing of journal by multiple volumes

David Brownell:
  o OHCI urb unlink fixes

David Mosberger:
  o ia64: Fix IDE block-layer BUG_ON() reported by Darren Williams
  o ia64: Fix pdflush-triggered stack-overflow due to long
    thread-creation chains

David S. Miller:
  o [TCP]: Restart tw bucket scan when lock is dropped, noticed by Olof
    Johansson
  o [NET]: Propagate dev_mc_{add,delete}() error to SIOC{ADD,DEL}MULTI
  o [AF_UNIX]: Mark unix_*_ops as static
  o [SPARC64]: Add support for CONFIG_DEBUG_STACK_USAGE

Dean Roehrich:
  o [XFS] release i_sem before going into dmapi queues
  o [XFS] DMAPI deadlock prevention when interacting with the IO path

Dely Sy:
  o PCI Hotplug: Patch to get polling mode in SHPC hot-plug driver
    properly working
  o PCI Hotplug: fixes for shpc and pcie hot-plug drivers

Eric Sandeen:
  o [XFS] Remove some dead debug code

François Romieu:
  o [netdrvr r8169] fix TX descriptor overflow

Geert Uytterhoeven:
  o lost Amiga Hydra Ethernet patch

Go Taniguchi:
  o [libata ata_piix] Fix transposed ICH6 PCI id

Greg Kroah-Hartman:
  o PCI Hotplug: remove unneeded ACPI Makefile rules
  o PCI Hotplug: clean up the Makefile a bit more
  o kobject: fix kobject hotplug debug message to show more needed info
  o kobject: clean up kobject_get() convoluted logic
  o Fix USB printer transfers
  o PCI Hotplug: fix stupid directory name of "pci_hotplug_slots" to be
    just "slots"
  o Make IBMASM driver depend on X86 as that is the only valid platform
    for it
  o PCI Hotplug: fix up the permission settings on a few of the sysfs
    files
  o Driver core: add CONFIG_DEBUG_DRIVER to help track down driver core
    bugs easier
  o PCI Hotplug: clean up the Makefile a bit more

Hollis Blanchard:
  o ppc64: make "viodev->unit_address" 32-bit
  o ppc64: export vio_find_node()

Ingo Molnar:
  o Avoid writing the APIC ID register

Ivan Kokshaysky:
  o Alpha: switch semaphores to PPC scheme

James Simmons:
  o New Permedia2 framebuffer driver

Jeff Garzik:
  o [libata] Use scsi_finish_command as completion function, in our
    error handling thread callback.
  o [libata ata_piix] Add yet another Intel ICH6 PCI id

Jens Axboe:
  o fix CDROM_SEND_PACKET 32 -> 64-bit translation

Karsten Keil:
  o ISDN strpbrk fix

Kenneth W. Chen:
  o ia64: make hugetlbfs page size a boot-time option
  o ia64: move irq_entry()/irq_exit() to ia64_handle_irq()

Linda Xie:
  o PCI Hotplug: fix rpaphp bugs

Linus Torvalds:
  o Update x86 defconfig
  o Fix typo in radeon pll update
  o Linux 2.6.4-rc2

Manfred Weihs:
  o IEEE1394(1164): Added 1394 acknowledge codes

Marc Zyngier:
  o Re: 2.6.4-rc1 + hp100 EISA, not working

Marcel Holtmann:
  o [Bluetooth] Use BT_ERR wherever possible

Max Asbock:
  o Driver for IBM service processor - updated (1/2)
  o Driver for IBM service processor - updated (2/2)

Nathan Scott:
  o [XFS] Use same string for identifying whether security namespace is
    enabled
  o [XFS] Add I/O path tracing code, useful in diagnosing that last
    unwritten extent problem
  o [XFS] Use a naming convention here thats more consistent with
    everything else
  o [XFS] Fix BUG in debug trace code, it was plain wrong for the
    unmapped page case
  o [XFS] Fix the by-handle attr list interface (used by xfsdump) for
    security attrs
  o [XFS] Implement mrlocks on top of rwsems, instead of using our own
    mrlock code
  o [XFS] Fix length of mount argument path strings, off by one
  o [XFS] Remove PBF_SYNC buffer flag, unused for some time now
  o [XFS] Sort out some minor differences between trees

Olof Johansson:
  o ppc64: Add iommu=on for enabling DART on small-mem machines
  o ppc64: Use iommu=force instead of iommu=on for commonality with
    x86_64
  o ppc64: More IOMMU cleanups

Peter Chubb:
  o ia64: greatly speed-up I/O-SAPIC irq_enable()/irq_disable()

Philippe Elie:
  o oprofile needs smp_num_siblings on x86-64

Randy Dunlap:
  o sys_device_[un]register() are not syscalls
  o rename sys_bus_init()

Roger Luethi:
  o Update via-rhine Kconfig entry

Russell King:
  o PCI: Report meaningful error for failed resource allocation
  o PCI: Don't report pci_request_regions() failure twice
  o PCI: Introduce bus->bridge_ctl member
  o [MTD] Fix build errors in Lubbock MTD map driver
  o [ARM] Fix SA1111 OHCI IRQ handler return type
  o [MTD] Fix ARM Firmware Suite MTD partition detection
  o [MTD] Update integrator-flash.c with MTD CVS
  o [ARM] Update ICS IDE driver
  o [ARM] Always return IRQ_HANDLED for USB interrupts
  o Wireless pcmcia netdev patches

Santiago Leon:
  o broken PowerPC Virtual Ethernet

Stephen Hemminger:
  o propogate errors from misc_register to caller
  o hp100 -- isa probe fix

Steve Kinneberg:
  o IEEE1394(r1173): Small change to csr1212 prevent possible kernel
    panics from improper directory parsing
  o IEEE1394(r1174): Fixed a problem parsing directories with null
    entries
  o IEEE1394(r1179): Fix nodemgr_get_max_rom() to work properly on
    little endian machines

Steven Dake:
  o [AF_UNIX]: Add SOCK_SEQPACKET support

Stéphane Eranian:
  o ia64: perfmon update

Timothy Shimmin:
  o [XFS] Add XFS_FS_GOINGDOWN interface to xfs
  o [XFS] Fix log recovery case when have v2 log with size >32K and we
    have a Log Record wrapping around the physical log end. Need to
    reset the pb size back to what we were using and NOT just 32K.
  o [XFS] Version 2 log fixes - remove l_stripemask and add v2 log
    stripe padding to ic_roundoff to cater for pad in reservation
    cursor updates.
  o [XFS] fix up some debug log code for when XFS_LOUD_RECOVERY is
    turned on

Torben Mathiasen:
  o PCI Hotplug: Patch to get cpqphp working with IOAPIC

