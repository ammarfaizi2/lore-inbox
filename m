Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264471AbTLVUST (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 15:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264476AbTLVUST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 15:18:19 -0500
Received: from intra.cyclades.com ([64.186.161.6]:55727 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S264471AbTLVUSK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 15:18:10 -0500
Date: Mon, 22 Dec 2003 17:55:28 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.24-pre2
Message-ID: <Pine.LNX.4.58L.0312221753140.1384@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here goes 2.4.24-pre2. It contains MIPS/PPC64/SPARC updates, ACPI
bugfixes, USB update, XFS fixes, amongst others.

Detailed changelog below


Summary of changes from v2.4.24-pre1 to v2.4.24-pre2
============================================

<achirica:telefonica.net>:
  o [wireless airo] Fix PCI registration
  o [wireless airo] Delay MIC activation to prevent Oops

<alexander:all-2.com>:
  o USB storage: patch for unusual_devs.h

<berentsen:sent5.uni-duisburg.de>:
  o USB storage: Minolta Dimage S414 usb patch

<bjorn.helgaas:hp.com>:
  o Fix 2.4 EFI RTC oops
  o 2.4 IA64 DRM interface changes

<boutcher:us.ibm.com>:
  o [PPC64] Set the ASR correctly for ISTAR and PULSAR processors

<dancy:dancysoft.com>:
  o USB: add TIOCMIWAIT support to pl2303 driver

<daniela:cyclades.com>:
  o Add Cyclades PC300 driver

<engebret:au1.ibm.com>:
  o [PPC64] Add some more definitions needed for SMT support
  o [PPC64] Add support for shared processors on partitioned systems
  o [PPC64] Modify spinlocks to be more efficient on shared processors
  o [PPC64] Add a /proc interface to control SMT configuration settings

<fello:libero.it>:
  o USB storage: patch for Fujifilm EX-20

<khali:linux-fr.org>:
  o i2c core cleanups
  o i2c documentation
  o i2c printk fixes
  o Remove sa1100 unused header

<krishnakumar:naturesoft.net>:
  o [netdrvr 8139too] support netif_msg_* interface

<len.brown:intel.com>:
  o [ACPI]  fix xconfig failure (Matt Wilcox) http://bugzilla.kernel.org/show_bug.cgi?id=1568
  o [ACPI] handle sparse APIC-IDs in the face of reduced NR_CPUS
  o [ACPI] add warning to thermal shutdown (Pavel Machek)
  o [ACPI] change hard-coded IO width to programmable width (Shaohua David Li) http://bugzilla.kernel.org/show_bug.cgi?id=1349
  o [ACPI] set APIC ACPI SCI OVR default to level/low http://bugzilla.kernel.org/show_bug.cgi?id=1351
  o [ACPI] revert two fixes in preparation for ACPICA merge
  o [ACPI] update Linux to ACPICA 20031029 (Bob Moore)
  o [ACPI] Update Linux to ACPICA 20031203 (Bob Moore)
  o [ACPI] delete old _TRA code formerly used just by IA64. (Bjorn Helgaas) The current approach is to walk the _CRS in pcibios_scan_root() using acpi_walk_resources().
  o [ACPI] set acpi_disabled=1 on failure for clean /proc http://bugzilla.kernel.org/show_bug.cgi?id=991

<linas:us.ibm.com>:
  o [PPC64] Use the correct functions to access user memory in proc file routines

<luca.risolia:studio.unibo.it>:
  o USB: W996[87]CF driver update

<marcelo:logos.cnet>:
  o Ernie Petrides: Fix __alloc_pages PF_MEMDIE handling
  o page_alloc.c: Fix typo
  o Changed EXTRAVERSION to -pre2

<marr:flex.com>:
  o USB: MCT-U232 Patch for cts

<mbp:samba.org>:
  o USB storage: add unusual storage device entry for Minolta DiMAGE

<mikem:beardog.cca.cpqcorp.net>:
  o cciss update part 1
  o cciss update part 2
  o cciss update part 3: enable prefetch on i386

<moilanen:us.ibm.com>:
  o [PPC64] Cope with unknown PCI host bridges when running under hypervisor

<per.winkvist:uk.com>:
  o USB storage: Make Pentax Optio S4 work

<petkan:nucleusys.com>:
  o USB: pegasus driver update

<stephane.galles:free.fr>:
  o USB storage: patch for Kyocera S5 camera

<t-kochi:bq.jp.nec.com>:
  o duplicate PID fix

<tchen:on-go.com>:
  o USB: fix bug when errors happen in ioedgeport driver
  o USB: fix io_edgeport driver alignment issues

<trini:mvista.com>:
  o Fix rtc leak

<_nessuno_:katamail.com>:
  o USB storage: Medion 6047 Digital Camera

Adrian Bunk:
  o Ask for CONFIG_INDYDOG only on mips
  o fix two pcmcia/cardbus.c compile warnings

Alan Stern:
  o USB storage: unusual_devs.h entry revision
  o USB storage: Another unusual_devs.h update
  o USB storage: Unusual_devs.h addition

Benjamin Herrenschmidt:
  o [PPC64] Clean up arch/ppc64/kernel/head.S a bit; fix bug on iSeries

Chuck Lever:
  o NFS O_DIRECT offset wrap bug

David Dillow:
  o Bug fixes

David Engebretsen:
  o PPC64: Use r13 to point to a per-processor data area rather than current
  o [PPC64] Makefile fixes: use $(CC), -fno-zero-initialized-in-bss
  o [PPC64] Boot wrapper improvements
  o [PPC64] Fix save_flags/restore_flags on iSeries
  o [PPC64] Fix setting/clearing of the RI (recoverable interrupt) bit
  o [PPC64] Rework IRQ code so we can handle systems with large IRQ numbers
  o [PPC64] Add support for SMT (multi-threaded) processors

David Hinds:
  o Re: UPD: "do_IRQ: near stack overflow" when inserting CF disk
  o fix PCMCIA interrupt allocation
  o fix PCMCIA memory resource management bug
  o fix logging levels for yenta socket driver

David S. Miller:
  o [SPARC32]: Fix build after asm/system.h include was added to linux/spinlock.h

Eric Brower:
  o [SPARC64]: SUNW,lombus device has nonstandard ebus child regs too

Eric Sandeen:
  o [XFS] Update xfs_showargs to reflect all current mount options

Greg Kroah-Hartman:
  o USB: add support for Protego devices to ftdi_sio driver
  o USB: add support for another pl2303 device
  o USB: add support for Sony UX50 device to visor driver

Henning Meier-Geinitz:
  o USB: scanner driver: new device ids

Herbert Xu:
  o USB Storage: freecom dvd-rw fx-50 usb-ide patch

Jean Tourrilhes:
  o IrDA kernel log buster

Jeff Garzik:
  o [netdrvr natsemi] backport 2.6 fixes and cleanups
  o [netdrvr starfire] remove duplicate include

Marcel Holtmann:
  o User level driver support for input subsystem
  o [Bluetooth] Update HCI security filter
  o [Bluetooth] Support inquiry results with RSSI
  o [Bluetooth] Remove copy of sockfd_lookup()
  o [Bluetooth] Cosmetic cleanup of the HCI USB driver
  o Fix LED's for input subsystem keyboards
  o Add Bluetooth to the bus types of the input subsystem

Matt Domsch:
  o EDD: move DISK80_SIG_BUFFER to 0x2cc in empty_zero_page
  o zero-page.txt: note 0x228 as in use by unknown

Mirko Lindner:
  o sk98lin-2.4: Kernel Update to Driver Version v6.21
  o sk98lin-2.4: Readme Update to Driver Version v6.21
  o sk98lin-2.4: Configure.help Update to Driver Version
  o sk98lin-2.4: pci.ids Update to Driver Version v6.21

Nathan Scott:
  o [XFS] No need to initialise struct xfs_trans field to null after a zalloc
  o [XFS] Remove some spurious double semi-colons
  o [XFS] Fix async pagebuf I/O tracing at the bottom of pagebuf_get
  o [XFS] Fix a small pagebuf memory leak and keep track of slab pages ourselves
  o [XFS] Fix an XFS release_page case where unwritten extents may cause I/O incorrectly
  o [XFS] Should not add comments right before checkin - add closing comment delimiter
  o [XFS] Cleanup bdevname conditional code in xfs_buf headers
  o [XFS] Remove some unnecessary conditional refcache code
  o [XFS] Remove some unnecessary kernel-version conditional code
  o [XFS] Rework some casts and use of sector_t in some address_space operations
  o [XFS] Remove some kernel-version macros around old I/O path code
  o [XFS] Rework some extended attributes code to make it more easily extended
  o [XFS] Remove the partial support for the Large Block Device patch from XFS
  o [XFS] Remove remaining conditional code for the Large Block Device patch

Neil Brown:
  o Fix RAID1 blocksize check

Olof Johansson:
  o [PPC64] Fix smp_call_function so we don't crash if an IPI is very late
  o [PPC64] Make sure we don't take a segment miss in a critical region
  o [PPC64] Better default port, irq and flag settings for ttyS2/3

Paul Mackerras:
  o [PPC64] Make sure the user stack pointer is 16-byte aligned on signal delivery
  o [PPC64] Fix stack expansion bug
  o [PPC64] Fix compile error in arch/ppc64/kernel/pmc.c
  o [PPC64] Fix and extend 32-bit syscall emulation code
  o [PPC64] Add some hypervisor call functions, rename HSC to HVSC
  o [PPC64] Add virtual I/O infrastructure for pSeries and iSeries
  o [PPC64] Fix a page-crossing bug in HvCall_writeLogBuffer
  o [PPC64] Fixes for the TCE (DMA mapping table) code

Pete Zaitcev:
  o USB: Backport of printer 2.6=>2.4

Ralf Bächle:
  o Undo accidental deletion of MWave config bits
  o Update generic MIPS code
  o Add support for PMC Sierra Yosemite eval board
  o Update code for NEC VR41xx systems
  o Alchemy updates
  o Update defconfigs
  o Update MIPS evaluation board support
  o SGI IP22 updates
  o Sibyte build fixes and defconfig updates
  o NEC DDB updates
  o DEC updates
  o Update MIPS char drivers
  o PMAG-AA fb driver update
  o EV96100 cleanup
  o PI1 parport driver fixes
  o Remove bitrotten MIPS bits in char/misc.c
  o Initialize ioc3_timer before use
  o de4x5 EISA fix
  o Pass LDFLAGS to all linker invocations

Steven Cole:
  o update scripts/ver_linux  for xfsprogs

