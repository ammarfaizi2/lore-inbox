Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131830AbRDRAyT>; Tue, 17 Apr 2001 20:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132769AbRDRAyA>; Tue, 17 Apr 2001 20:54:00 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:59154 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S131830AbRDRAxt>;
	Tue, 17 Apr 2001 20:53:49 -0400
Date: Tue, 17 Apr 2001 20:54:49 -0400
Message-Id: <200104180054.f3I0sne02402@snark.thyrsus.com>
From: "Eric S. Raymond" <esr@snark.thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com,
        axel@uni-paderborn.de, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Supplying missing entries for Configure.help, part 2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch supplies sixteen more missing entries for the Configure.help
file.  It changes one more entry that hadn't caught up to a rename of the
relevant symbol.  It should be applied after my previous patch 1
under the same title.  More to come...

--- /home/esr/src/linux/Documentation/Configure.help	2001/04/17 21:18:38	1.2
+++ /home/esr/src/linux/Documentation/Configure.help	2001/04/18 00:49:13
@@ -1596,6 +1596,11 @@
   more details about the Baget see the Linux/MIPS FAQ on 
   http://oss.sgi.com/mips .
 
+Baget AMD LANCE support
+CONFIG_BAGETLANCE
+  Say Y to enable kernel support for Lance ethernet cards on the 
+  MIPS-32-based Baget embedded system.
+
 Support for DECstations
 CONFIG_DECSTATION
   This enables support for DEC's MIPS based workstations.  For details
@@ -2565,6 +2570,14 @@
   the GLX component for XFree86 3.3.6, which can be downloaded from
   http://utah-glx.sourceforge.net/ .
 
+Support for ISA-bus hardware
+CONFIG_ISA
+  Find out whether you have ISA slots on your motherboard.  ISA is the 
+  name of a bus system, i.e. the way the CPU talks to the other stuff 
+  inside your box. Other bus systems are PCI, EISA, Microchannel (MCA) or
+  VESA.  ISA is an older system, now being displaced by PCI; newer boards.
+  don't support it.  If you have ISA, say Y, otherwise N. 
+
 PCI support
 CONFIG_PCI
   Find out whether you have a PCI motherboard. PCI is the name of a
@@ -2946,6 +2959,13 @@
   because some crucial programs on your system might still be in A.OUT
   format.
 
+Kernel support for JAVA binaries
+CONFIG_BINFMT_JAVA
+  If you answer Y here, the kernel's program loader will know how to
+  directly execute Java J-code.  This option is semi-obsolescent; you 
+  should probably use CONFIG_BINFMT_MISC and read Documentation/java.txt
+  for information about how to include Java support.
+
 Kernel support for Linux/Intel ELF binaries
 CONFIG_BINFMT_EM86
   Say Y here if you want to be able to execute Linux/Intel ELF
@@ -9010,6 +9030,15 @@
   documentation in Documentation/networking/arcnet.txt for more
   information about using arc0e and arc0s.
 
+Enable standard ARCNet packet format (RFC 1201)
+CONFIG_ARCNET_1201
+  This allows you to use RFC1201 with your ARCnet card via the virtual
+  arc0 device.  You need to say Y here to communicate with
+  industry-standard RFC1201 implementations, like the arcether.com
+  packet driver or most DOS/Windows ODI drivers. Please read the ARCnet
+  documentation in Documentation/networking/arcnet.txt for more
+  information about using arc0.
+
 ARCnet COM90xx (normal) chipset driver
 CONFIG_ARCNET_COM90xx
   This is the chipset driver for the standard COM90xx cards. If you
@@ -11911,6 +11940,11 @@
   of machines called RISCiX. If you say 'Y' here, Linux will be able to
   read disks partitioned under RISCiX.
 
+ICS partition support
+CONFIG_ACORN_PARTITION_ICS
+  Say Y here if you would like to use hard disks under Linux which
+  were partitioned using the ICS interface on Acorn machines.
+  
 Alpha OSF partition support
 CONFIG_OSF_PARTITION
   Say Y here if you would like to use hard disks under Linux which
@@ -11926,6 +11960,16 @@
   Say Y here if you would like to use hard disks under Linux which
   were partitioned on an x86 PC (not necessarily by DOS).
 
+Amiga partition table support
+CONFIG_AMIGA_PARTITION
+  Say Y here if you would like to use hard disks under Linux which
+  were partitioned under AmigaOS.
+
+Atari partition table support
+CONFIG_ATARI_PARTITION
+  Say Y here if you would like to use hard disks under Linux which
+  were partitioned under the Atari OS.
+
 BSD disklabel (FreeBSD partition tables) support
 CONFIG_BSD_DISKLABEL
   FreeBSD uses its own hard disk partition scheme on your PC. It
@@ -11975,6 +12019,12 @@
   partition table format used by DEC (now Compaq) Ultrix machines.
   Otherwise, say N.
 
+IBM disk label and partition support
+CONFIG_IBM_PARTITION
+  Say Y here if you would like to be able to read the hard disk
+  partition table format used by IBM DASD disks operating under CMS.
+  Otherwise, say N.
+
 ADFS file system support (EXPERIMENTAL)
 CONFIG_ADFS_FS
   The Acorn Disc Filing System is the standard file system of the
@@ -12649,6 +12699,13 @@
   If you use an ADB keyboard (4 pin connector), say Y here.
   If you use a PS/2 keyboard (6 pin connector), say N here.
 
+Include IOP (IIfx/Quadra 9x0) ADB driver
+CONFIG_ADB_IOP
+  The I/O Processor (IOP) is an Apple custom IC designed to provide
+  intelligent support for I/O controllers.  It is described at 
+  http://www.angelfire.com/ca2/dev68k/iopdesc.html; to enable direct
+  support for it, say 'Y' here.
+
 Standard/generic serial support
 CONFIG_SERIAL
   This selects whether you want to include the driver for the standard
@@ -13977,8 +14034,14 @@
   module, say M here and read Documentation/modules.txt. Most people
   will say N.
 
+Advantech SBC Watchdog Timer
+CONFIG_ADVANTECH_WDT
+  If you are configuring a Linux kernel for the Advantech single-board
+  computer, say `Y' here to support its built-in watchdog timer feature.
+  See the help for CONFIG_WATCHDOG for discussion.
+
 Mixcom Watchdog
-CONFIG_MIXCOMWD 
+CONFIG_MIXCOMWD
   This is a driver for the Mixcom hardware watchdog cards. This
   watchdog simply watches your kernel to make sure it doesn't freeze,
   and if it does, it reboots your computer after a certain amount of
@@ -15519,7 +15582,7 @@
   Documentation/isdn/README.eicon for more information.
 
 Eicon driver type standalone
-CONFIG_ISDN_DRV_EICON_STANDALONE
+CONFIG_ISDN_DRV_EICON_DIVAS
   Enable this option if you want the eicon driver as standalone
   version with no interface to the ISDN4Linux isdn module. If you
   say Y here, the eicon module only supports the Diva Server PCI
@@ -15814,6 +15877,12 @@
 
   If you don't want to compile a kernel for a Sun 3x, say N.
 
+Sun3x builtin serial support
+SUN3X_ZS
+  ZS refers to a type of asynchronous serial port built in to the Sun3
+  and Sun3x workstations; if you have a Sun 3, you probably have these.
+  Say 'Y' to support ZS ports directly.
+
 68020 support
 CONFIG_M68020
   If you anticipate running this kernel on a computer with a MC68020
@@ -16059,6 +16128,12 @@
   use a Toshiba CD-ROM drive; otherwise, the option is not needed and
   would impact performance a bit, so say N.
 
+Reset SCSI-devices at boottime
+CONFIG_ATARI_SCSI_RESET_BOOT
+  Reset the devices on your Atari whenever it boots.  This makes the boot 
+  process fractionally longer but may assist recovery from errors that
+  leave the devices with SCSI operations partway completed.
+
 Hades SCSI DMA emulator
 CONFIG_TT_DMA_EMUL
   This option enables code which emulates the TT SCSI DMA chip on the
@@ -16905,7 +16980,7 @@
 
 Support for console on 3215 line mode terminal
 CONFIG_3215_CONSOLE
-  Include support for using an IBM 3215 line-mode terminal as the
+  Include support for using an IBM 3215 line-mode terminal as the Linux
   system console.  Can't be used if 3270 support is compiled in statically.
 
 Support for 3270 line mode terminal
@@ -16914,9 +16989,18 @@
 
 Support for console on 3270 line mode terminal
 CONFIG_3270_CONSOLE
-  Include support for using an IBM 3270 line-mode terminal as the
+  Include support for using an IBM 3270 line-mode terminal as the Linux
   system console.  Excludes using 3215s.
 
+Support for HWC line mode terminal
+CONFIG_HWC
+  Include support for IBM HWC line-mode terminals.
+
+Support for console on HWC line mode terminal
+CONFIG_HWC_CONSOLE
+  Include support for using an IBM HWC line-mode terminal as the Linux
+  system console.
+
 SAB3036 tuner support
 CONFIG_TUNER_3036
   Say Y here to include support for Philips SAB3036 compatible tuners.
@@ -17302,6 +17386,11 @@
   want to compile it as a module, say M here and read
   Documentation/modules.txt.
 
+Ultra (connectionless) protocol
+CONFIG_IRDA_ULTRA
+  Say Y here to support the connectionless Ultra IRDA protocol, also
+  called IrOBEX.
+
 IrDA protocol options
 CONFIG_IRDA_OPTIONS
   Say Y here if you want to configure any of the following IrDA options.
@@ -17730,6 +17819,14 @@
 
   To use this option, you have to check that the "/proc file system
   support" (CONFIG_PROC_FS) is enabled, too.
+
+Directly Connected Compact Flash support
+CONFIG_CF_ENABLER
+  Compact Flash is a small, removable mass storage device introduced
+  in 1994 originally as a PCMCIA device.  If you say `Y' here, you 
+  compile in support for Compact Flash devices directly connected to
+  a SuperH processor.  A Compact Flash FAQ is available at 
+  http://www.compactflash.org/faqs/faq.htm.
 
 #
 # A couple of things I keep forgetting:
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"If I must write the truth, I am disposed to avoid every assembly 
of bishops; for of no synod have I seen a profitable end, but
rather an addition to than a diminution of evils; for the love 
of strife and the thirst for superiority are beyond the power 
of words to express."
	-- Father Gregory Nazianzen, 381 AD
