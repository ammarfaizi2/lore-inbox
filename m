Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284159AbRLARXR>; Sat, 1 Dec 2001 12:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284163AbRLARW4>; Sat, 1 Dec 2001 12:22:56 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:4507
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S284162AbRLARWf>; Sat, 1 Dec 2001 12:22:35 -0500
Date: Sat, 1 Dec 2001 12:14:53 -0500
Message-Id: <200112011714.fB1HErY09774@snark.thyrsus.com>
From: "Eric S. Raymond" <esr@snark.thyrsus.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Configure.help 2.5.1 update patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This rolls up all pending changes to the 2.5.1-pre5 help file (versiion 2.61).
It is not intended to be applied to 2.4.17.

* Added PCMCIA_AXNET, TULIP_MMIO. SYSCLK_75, SYSCLK_83, SYSCLK_100, 
  CERF_FLASH_8MB, CERF_FLASH_16MB, CERF_FLASH_32MB, CONFIG_SA1100_CERF_8MB, 
  CONFIG_SA1100_CERF_16MB, CONFIG_SA1100_CERF_32MB, CONFIG_SA1100_CERF_64MB.

--- Documentation/Configure.help	Sat Dec  1 11:54:18 2001
+++ Documentation/Configure.help	Sat Dec  1 12:05:11 2001
@@ -2,7 +2,7 @@
 #	Eric S. Raymond <mailto:esr@thyrsus.com>
 #	Steven Cole <mailto:elenstev@mesatop.com>
 #
-# Merged version 2.61: current with 2.4.16/2.5.1-pre1.
+# Merged version 2.65: current with 2.4.17-pre2/2.5.1-pre5.
 #
 # This version of the Linux kernel configuration help texts
 # corresponds to kernel versions 2.4.x and 2.5.x.
@@ -241,7 +241,7 @@
   You will need a new lynxer.elf file to flash your firmware with - send
   email to Martin.Bligh@us.ibm.com
 
-IO-APIC Support on Uniprocessors
+IO-APIC support on uniprocessors
 CONFIG_X86_UP_IOAPIC
   An IO-APIC (I/O Advanced Programmable Interrupt Controller) is an
   SMP-capable replacement for PC-style interrupt controllers. Most
@@ -376,7 +376,7 @@
   Select this if you have a 32-bit processor and more than 4
   gigabytes of physical RAM.
 
-Normal PC floppy disk support
+Normal floppy disk support
 CONFIG_BLK_DEV_FD
   If you want to use the floppy disk drive(s) of your PC under Linux,
   say Y. Information about this driver, especially important for IBM
@@ -972,7 +972,7 @@
 
   SAY N!
 
-AMD Viper support
+AMD Viper (7401/7409/7411) chipset support
 CONFIG_BLK_DEV_AMD74XX
   This driver ensures (U)DMA support for the AMD756/760 Viper
   chipsets.
@@ -983,7 +983,7 @@
 
   If unsure, say N.
 
-AMD Viper ATA-66 Override (WIP)
+AMD Viper ATA-66 Override support (WIP)
 CONFIG_AMD74XX_OVERRIDE
   This option auto-forces the ata66 flag.
   This effect can be also invoked by calling "idex=ata66"
@@ -1595,7 +1595,7 @@
   (low speed) adapter that is used in some portable hard drives. If
   you chose to build PARIDE support into your kernel, you may answer Y
   here to build in the protocol driver, otherwise you should answer M
-  to build it as a loadable module. The module will be called ktti.o.
+  to build it as a loadable module. The module will be called fit2.o.
   You must also have a high-level driver for the type of device that
   you want to support.
 
@@ -1963,13 +1963,13 @@
   Technology and now in turn merged with Fujitsu.  Say Y here to
   support this machine type.
 
-Support for SGI IP22
+Support for SGI-IP22 (Indy/Indigo2)
 CONFIG_SGI_IP22
   This are the SGI Indy, Challenge S and Indigo2, as well as certain
   OEM variants like the Tandem CMN B006S. To compile a Linux kernel
   that runs on these, say Y here.
 
-Support for SGI IP27
+Support for SGI IP27 (Origin200/2000)
 CONFIG_SGI_IP27
   This are the SGI Origin 200, Origin 2000 and Onyx 2 Graphics
   workstations.  To compile a Linux kernel that runs on these, say Y
@@ -2025,13 +2025,26 @@
   DZ11-family serial controllers for VAXstations, including the
   DC7085, M7814, and M7819.
 
-
 TURBOchannel support
 CONFIG_TC
   TurboChannel is a DEC (now Compaq) bus for Alpha and MIPS processors.
   Documentation on writing device drivers for TurboChannel is available at:
   <http://www.cs.arizona.edu/computer.help/policy/DIGITAL_unix/AA-PS3HD-TET1_html/TITLE.html>.
 
+# Choice: galileo_clock
+75
+CONFIG_SYSCLK_75
+  Configure the kernel for clock speed of your Galileo board.  
+  The choices are 75MHz, 83.3MHz, and 100MHz.
+
+83.3
+CONFIG_SYSCLK_83
+  Configure the Galileo kernel for a clock speed of 83.3 MHz.
+
+100
+CONFIG_SYSCLK_100
+  Configure the Galileo kernel for a clock speed of 100 MHz.
+
 Z85C30 Serial Support
 CONFIG_ZS
   Documentation on the Zilog 85C350 serial communications controller
@@ -2186,7 +2199,7 @@
   Access).  This option is for configuring high-end multiprocessor
   server machines.  If in doubt, say N.
 
-CPU type
+R41xx
 CONFIG_CPU_VR41XX
   The options selects support for the NEC VR41xx series of processors.
   Only choose this option if you have one of these processors as a
@@ -2198,7 +2211,7 @@
   Saying yes here allows you to select support for various features
   your CPU may or may not have.  Most people should say N here.
 
-ll/sc Instructions available
+ll and sc instructions available
 CONFIG_CPU_HAS_LLSC
   MIPS R4000 series and later provide the Load Linked (ll)
   and Store Conditional (sc) instructions. More information is
@@ -2208,7 +2221,7 @@
   for better performance, N if you don't know.  You must say Y here
   for multiprocessor machines.
 
-lld and scd instructions
+lld and scd instructions available
 CONFIG_CPU_HAS_LLDSCD
   Say Y here if your CPU has the lld and scd instructions, the 64-bit
   equivalents of ll and sc.  Say Y here for better performance, N if
@@ -2341,7 +2354,7 @@
   If you want to compile it as a module, say M here and read
   <file:Documentation/modules.txt>.  If unsure, say `N'.
 
-IRC Send/Chat support
+IRC Send/Chat protocol support
 CONFIG_IP_NF_IRC
   There is a commonly-used extension to IRC called
   Direct Client-to-Client Protocol (DCC).  This enables users to send
@@ -2425,7 +2438,7 @@
   If you want to compile it as a module, say M here and read
   Documentation/modules.txt.  If unsure, say `N'.
 
-length match support
+LENGTH match support
 CONFIG_IP_NF_MATCH_LENGTH
   This option allows you to match the length of a packet against a
   specific value or range of values.
@@ -3314,7 +3327,7 @@
 
   When in doubt, say Y.
 
-PCI Hotplug support
+Generic PCI hotplug support
 CONFIG_HOTPLUG_PCI
   Say Y here if you have a motherboard with a PCI Hotplug controller.
   This allows you to add and remove PCI cards while the machine is
@@ -3328,7 +3341,7 @@
 
   When in doubt, say N.
 
-PCI Compaq Hotplug controller
+Compaq PCI Hotplug driver
 CONFIG_HOTPLUG_PCI_COMPAQ
   Say Y here if you have a motherboard with a Compaq PCI Hotplug
   controller.
@@ -3645,7 +3658,6 @@
   don't understand what this means or are not a kernel hacker, just
   leave it at its default value ELF.
 
-# Choice: kcore
 Select a.out format for /proc/kcore
 CONFIG_KCORE_AOUT
   Not necessary unless you're using a very out-of-date binutils
@@ -3768,7 +3780,7 @@
   The module will be called envctrl.o. If you want to compile it as a
   module, say M here and read <file:Documentation/modules.txt>.
 
-# Choice: x86
+# Choice: x86type
 Processor family
 CONFIG_M386
   This is the processor type of your CPU. This information is used for
@@ -4541,7 +4553,7 @@
   This is the frame buffer device driver for the Hitachi HD64461 LCD
   frame buffer card.
 
-SIS 630/540 display support
+SIS acceleration
 CONFIG_FB_SIS
   This is the frame buffer device driver for the SiS 630 and 640 Super
   Socket 7 UMA cards.  Specs available at <http://www.sis.com.tw/>.
@@ -4764,7 +4776,7 @@
 
   If unsure, say Y.
 
-Parallel+serial PCI card support
+Parallel+serial PCI multi-IO card support
 CONFIG_PARPORT_SERIAL
   This adds support for multi-IO PCI cards that have parallel and
   serial ports.  You should say Y or M here.  If you say M, the module
@@ -6398,6 +6410,13 @@
   the performances of the driver, and the size of your syslog files!
   Keep the debugging level to 0 during normal operations.
 
+PPP over ATM
+CONFIG_PPPOATM
+  Support PPP (Point to Point Protocol) encapsulated in ATM frames.
+  This implementation does not yet comply with section 8 of RFC2364,
+  which can lead to bad results idf the ATM peer loses state and 
+  changes its encapsulation unilaterally.
+
 Fusion MPT device support
 CONFIG_FUSION
   LSI Logic Fusion(TM) Message Passing Technology (MPT) device support
@@ -6784,7 +6803,7 @@
   intended to replace the previous aic7xxx driver maintained by Doug
   Ledford since Doug is no longer maintaining that driver.
 
-Adaptec I2O RAID controllers
+Adaptec I2O RAID support
 CONFIG_SCSI_DPT_I2O
   This driver supports all of Adaptec's I2O based RAID controllers as 
   well as the DPT SmartRaid V cards.  This is an Adaptec maintained
@@ -7137,7 +7156,7 @@
   Unless you have an NCR manufactured machine, the chances are that
   you do not have this SCSI card, so say N.
 
-HP LASI SCSI support for 53c700
+HP LASI SCSI support for 53c700/710
 CONFIG_SCSI_LASI700
   This is a driver for the lasi baseboard in some parisc machines
   which is based on the 53c700 chip.  Will also support LASI subsystems
@@ -7849,7 +7868,7 @@
   say M here and read <file:Documentation/modules.txt>.  The module
   will be called megaraid.o.
 
-Intel/ICP (former GDT SCSI Disk Array) RAID Controller Support
+Intel/ICP (former GDT SCSI Disk Array) RAID Controller support
 CONFIG_SCSI_GDTH
   Formerly called GDT SCSI Disk Array Controller Support.
  
@@ -8139,7 +8158,7 @@
 #  say M here and read <file:Documentation/modules.txt>.  The module
 #  will be called aic5800.o.
 #
-OHCI-1394 support
+OHCI-1394 (Open Host Controller Interface) support
 CONFIG_IEEE1394_OHCI1394
   Enable this driver if you have an IEEE 1394 controller based on the
   OHCI-1394 specification. The current driver is only tested with OHCI
@@ -8701,6 +8720,19 @@
   a module, say M here and read <file:Documentation/modules.txt>. If
   unsure, say N.
 
+Asix AX88190 PCMCIA support
+CONFIG_PCMCIA_AXNET
+  Say Y here if you intend to attach an Asix AX88190-based PCMCIA
+  (PC-card) Fast Ethernet card to your computer.  These cards are
+  nearly NE2000 compatible but need a separate driver due to a few
+  misfeatures.
+
+  This driver is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called axnet_cs.o.  If you want to compile it as
+  a module, say M here and read <file:Documentation/modules.txt>.  If
+  unsure, say N.
+
 New Media PCMCIA support
 CONFIG_PCMCIA_NMCLAN
   Say Y here if you intend to attach a New Media Ethernet or LiveWire
@@ -8756,7 +8788,7 @@
   The module will be called ibmtr_cs.o.  If you want to compile it as
   a module, say M here and read <file:Documentation/modules.txt>.
 
-Xircom Tulip-like CardBus support
+Xircom Tulip-like CardBus support (old driver)
 CONFIG_PCMCIA_XIRTULIP
   This driver is for the Digital "Tulip" Ethernet CardBus adapters.
   It should work with most DEC 21*4*-based chips/ethercards, as well
@@ -9027,7 +9059,7 @@
   of the Cisco HDLC/PPP driver (syncppp.c).
   The SyncLink WAN driver (in character devices) must also be enabled.
 
-FarSync T-Series support
+FarSync T-Series X.21 (and V.35/V.24) cards
 CONFIG_FARSYNC
   This driver supports the FarSync T-Series X.21 (and V.35/V.24) cards
   from FarSite Communications Ltd.
@@ -9601,7 +9633,7 @@
 
   Say N if unsure.
 
-SBNI Adapters Multiline feature
+SBNI multiple-line feature support
 CONFIG_SBNI_MULTILINE
   Schedule traffic for some parallel lines, via SBNI12 adapters.
   If you have two computers connected with two parallel lines it's
@@ -10915,6 +10947,13 @@
 
   If unsure, say N.
 
+Use PCI shared memory for NIC registers
+CONFIG_TULIP_MMIO
+  Use PCI shared memory for the NIC registers, rather than going through 
+  the Tulip's PIO (programmed I/O ports).  Faster, but could produce 
+  obscure bugs if your mainboard has memory controller timing issues.
+  If in doubt, say N.
+
 Digi Intl. RightSwitch SE-X support
 CONFIG_DGRS
   This is support for the Digi International RightSwitch series of
@@ -11903,7 +11942,7 @@
   <linux-mtd@lists.infradead.org> if you want to help to make it more
   reliable.
 
-Common Flash Interface (CFI) support
+Detect flash chips by Common Flash Interface (CFI) probe
 CONFIG_MTD_CFI
   The Common Flash Interface specification was developed by Intel,
   AMD and other flash manufactures that provides a universal method
@@ -11960,7 +11999,7 @@
   If your flash chips are interleaved in fours - i.e. you have four
   flash chips addressed by each bus cycle, then say 'Y'.
 
-# Choice: mtd_swap_data
+# Choice: mtd_data_swap
 Flash cmd/query data swapping
 CONFIG_MTD_CFI_NOSWAP
   This option defines the way in which the CPU attempts to arrange
@@ -12100,7 +12139,7 @@
   PNC-2000 is the name of Network Camera product from PHOTRON
   Ltd. in Japan. It uses CFI-compliant flash.
 
-Flash chip mapping on RPXlite PPC board
+Flash chip mapping on RPXlite or CLLF PPC board
 CONFIG_MTD_RPXLITE
   The RPXLite PowerPC board has CFI-compliant chips mapped in
   a strange sparse mapping. This 'mapping' driver supports that
@@ -12176,26 +12215,26 @@
   allow a window into the flash.  Both CFI and JEDEC probes are
   called.
 
-Physical start location of flash mapping
+Physical start location of flash chip mapping
 CONFIG_MTD_CSTM_MIPS_IXX_START
   This is the physical memory location that the MTD driver will
   use for the flash chips on your particular target board. 
   Refer to the memory map which should hopefully be in the 
   documentation for your board.
 
-Physical length of flash mapping
+Physical length of flash chip mapping
 CONFIG_MTD_CSTM_MIPS_IXX_LEN
   This is the total length that the MTD driver will use for the 
   flash chips on your particular board.  Refer to the memory
   map which should hopefully be in the documentation for your
   board.
 
-Physical bus width of flash mapping
+Physical bus width of flash mapping in bytes
 CONFIG_MTD_CSTM_MIPS_IXX_BUSWIDTH
   This is the total bus width of the mapping of the flash chips
   on your particular board.
 
-Flash chip mapping on Mixcom piggyback card
+JEDEC Flash device mapped on Mixcom piggyback card
 CONFIG_MTD_MIXMEM
   This supports the paging arrangement for access to flash chips
   on the MixCOM piggyback card, allowing the flash chip drivers
@@ -12204,14 +12243,14 @@
   you probably want to enable this mapping driver. More info is at
   <http://www.itc.hu/>.
 
-Flash chip mapping on Octagon 5066 SBC
+JEDEC Flash device mapped on Octagon 5066 SBC
 CONFIG_MTD_OCTAGON
   This provides a 'mapping' driver which supports the way in which
   the flash chips are connected in the Octagon-5066 Single Board
   Computer. More information on the board is available at
   <http://www.octagonsystems.com/Products/5066/5066.html>.
 
-Flash chip mapping on Tempustech VMAX SBC301
+JEDEC Flash device mapped on Tempustech VMAX SBC301
 CONFIG_MTD_VMAX
   This provides a 'mapping' driver which supports the way in which
   the flash chips are connected in the Tempustech VMAX SBC301 Single
@@ -12382,7 +12421,7 @@
   allocating space from Linux's available memory. Otherwise, leave 
   this set to zero. Most people will want to leave this as zero.
 
-Flash chip mapping on the Flaga Digital Module
+CFI Flash device mapping on the Flaga Digital Module
 CONFIG_MTD_CFI_FLAGADM
   Mapping for the Flaga digital module.  If you don´t have one, ignore
   this setting.
@@ -12402,7 +12441,7 @@
   the system regardless of media presence.  Device nodes created
   with this driver will return -ENODEV upon access.
 
-MTD Emulation using block device
+MTD emulation using block device
 CONFIG_MTD_BLKMTD
   This driver allows a block device to appear as an MTD. It would
   generally be used in the following cases:
@@ -12455,7 +12494,7 @@
   This enables access to the flash chips on the Hitachi SolutionEngine and
   similar boards. Say 'Y' if you are building a kernel for such a board.
 
-Flash chip mapping on TQM8xxL PPC board
+CFI Flash device mapped on TQM8XXL PPC board
 CONFIG_MTD_TQM8XXL
   The TQM8xxL PowerPC board has up to two banks of CFI-compliant
   chips, currently uses AMD one. This 'mapping' driver supports
@@ -12531,7 +12570,7 @@
 
   If you have an APC UPS, say Y; otherwise say N.
 
-USB long timeout
+USB long timeout for slow-responding devices (some MGE Ellipse UPSes)
 CONFIG_USB_LONG_TIMEOUT
   This option makes the standard time out a bit longer.  Basically,
   some devices are just slow to respond, so this makes usb more
@@ -12852,17 +12891,6 @@
   The module will be called ir-usb.o. If you want to compile it as a
   module, say M here and read <file:Documentation/modules.txt>.
 
-USB IR Dongle Serial Driver
-CONFIG_USB_SERIAL_IR
-  Say Y here if you want to enable simple serial support for USB IrDA
-  devices.  This is useful if you do not want to use the full IrDA
-  stack.
-  
-  This code is also available as a module ( = code which can be
-  inserted in and removed from the running kernel whenever you want).
-  The module will be called ir-usb.o. If you want to compile it as a
-  module, say M here and read <file:Documentation/modules.txt>.
-
 USB Belkin and Paracom Single Port Serial Driver
 CONFIG_USB_SERIAL_BELKIN
   Say Y here if you want to use a Belkin USB Serial single port
@@ -13112,7 +13140,7 @@
   The module will be called ov511.o. If you want to compile it as a
   module, say M here and read <file:Documentation/modules.txt>.
 
-USB Communication Class Ethernet driver
+USB Communication Class Ethernet device support
 CONFIG_USB_CDCETHER
   This driver supports devices conforming to the Communication Device
   Class Ethernet Control Model.  This is used in some cable modems.
@@ -13181,7 +13209,7 @@
   The module will be called pegasus.o. If you want to compile it as a
   module, say M here and read <file:Documentation/modules.txt>.
 
-USB KLSI KL5USB101-based Ethernet device support '
+USB KLSI KL5USB101-based Ethernet device support
 CONFIG_USB_KAWETH
   Say Y here if you want to use one of the following 10Mbps only
   USB Ethernet adapters based on the KLSI KL5KUSB101B chipset:
@@ -13279,7 +13307,7 @@
   Say Y here in order to have the USB Mass Storage code generate
   verbose debugging messages.
 
-ISD-200 USB/ATA driver
+ISD-200 USB/ATA Bridge support
 CONFIG_USB_STORAGE_ISD200
   Say Y here if you want to use USB Mass Store devices based
   on the In-Systems Design ISD-200 USB/ATA bridge.
@@ -13399,7 +13427,7 @@
   reader, details at <http://www.microtechint.com/zio/index.html>.
   This driver treats the flash card as a removable storage device.
 
-Sandisk SDDR-09 SmartMedia reader support
+SanDisk SDDR-09 (and other SmartMedia) support
 CONFIG_USB_STORAGE_SDDR09
   Say Y here to include additional code to support the Sandisk SDDR-09
   SmartMedia reader in the USB Mass Storage driver.
@@ -13682,7 +13710,7 @@
   and work. SANE 1.0.4 or newer is needed to make use of your scanner.
   This driver can be compiled as a module.
 
-HP 53xx and Minolta Dual Scanner support
+HP53xx and Minolta Dual Scanner support
 CONFIG_USB_HPUSBSCSI
   Say Y here if you want support for the HP 53xx series of scanners
   and the Minolta Scan Dual. This driver is experimental.
@@ -13721,7 +13749,7 @@
 Reiserfs support
 CONFIG_REISERFS_FS
   Stores not just filenames but the files themselves in a balanced
-  tree.  Uses journaling.
+  tree.  Uses journalling.
 
   Balanced trees are more efficient than traditional file system
   architectural foundations.
@@ -13810,13 +13838,13 @@
   be compiled as a module, and so this could be dangerous.  Most
   everyone wants to say Y here.
 
-Ext3 journaling file system support (EXPERIMENTAL)
+Ext3 journalling file system support (EXPERIMENTAL)
 CONFIG_EXT3_FS
-  This is the journaling version of the Second extended file system
+  This is the journalling version of the Second extended file system
   (often called ext3), the de facto standard Linux file system
   (method to organize files on a storage device) for hard disks.
 
-  The journaling code included in this driver means you do not have
+  The journalling code included in this driver means you do not have
   to run e2fsck (file system checker) on your file systems after a
   crash.  The journal keeps track of any changes that were being made
   at the time the system crashed, and can ensure that your file system
@@ -13844,7 +13872,7 @@
 
 Journal Block Device support (JBD for ext3) (EXPERIMENTAL)
 CONFIG_JBD
-  This is a generic journaling layer for block devices.  It is
+  This is a generic journalling layer for block devices.  It is
   currently used by the ext3 file system, but it could also be used to
   add journal support to other file systems or block devices such as
   RAID or LVM.
@@ -14541,7 +14569,7 @@
 
 Journalling Flash File System (JFFS) support
 CONFIG_JFFS_FS
-  JFFS is the Journaling Flash File System developed by Axis
+  JFFS is the Journalling Flash File System developed by Axis
   Communications in Sweden, aimed at providing a crash/powerdown-safe
   file system for disk-less embedded devices. Further information is
   available at (<http://developer.axis.com/software/jffs/>).
@@ -14663,7 +14691,7 @@
   Say Y here if you would like to use hard disks under Linux which
   were partitioned on a Macintosh.
 
-Windows' Logical Disk Manager (Dynamic Disk) support (EXPERIMENTAL)
+Windows Logical Disk Manager (Dynamic Disk) support (EXPERIMENTAL)
 CONFIG_LDM_PARTITION
   Say Y here if you would like to use hard disks under Linux which
   were partitioned using Windows 2000's or XP's Logical Disk Manager.
@@ -14683,7 +14711,7 @@
 
   If unsure, say N.
 
-Windows' LDM extra logging
+Windows LDM extra logging
 CONFIG_LDM_DEBUG
   Say Y here if you would like LDM to log verbosely.  This could be
   helpful if the driver doesn't work as expected and you'd like to
@@ -14915,7 +14943,7 @@
   whenever you want), say M here and read
   <file:Documentation/modules.txt>.  The module will be called coda.o.
 
-InterMezzo file system support (experimental, replicating fs)
+InterMezzo file system support (replicating fs)
 CONFIG_INTERMEZZO_FS
   InterMezzo is a networked file system with disconnected operation
   and kernel level write back caching.  It is most often used for
@@ -15495,6 +15523,7 @@
   Enable Ethernet support via the Motorola MPC8xx serial
   commmunications controller.
 
+# Choice: scc_ethernet
 Ethernet on SCC1
 CONFIG_SCC1_ENET
   Use MPC8xx serial communications controller 1 to drive Ethernet
@@ -16271,7 +16300,7 @@
   <file:Documentation/modules.txt>.
   The module will be called i2c-dev.o.
 
-I2C /proc support
+I2C /proc interface (required for hardware sensors)
 CONFIG_I2C_PROC
   This provides support for i2c device entries in the /proc filesystem.
   The entries will be found in /proc/sys/dev/sensors.
@@ -17400,23 +17429,24 @@
   Say Y if you intend to run this kernel on a Toshiba portable.
   Say N otherwise.
 
-Dell Inspiron 8000 support
+Dell laptop support
 CONFIG_I8K
   This adds a driver to safely access the System Management Mode
-  of the CPU on the Dell Inspiron 8000. The System Management Mode
-  is used to read cpu temperature and cooling fan status and to
-  control the fans on the I8K portables.
-
-  This driver has been tested only on the Inspiron 8000 but it may
-  also work with other Dell laptops. You can force loading on other
-  models by passing the parameter `force=1' to the module. Use at
-  your own risk.
+  of the CPU on the Dell Inspiron and Latitude laptops. The System
+  Management Mode is used to read cpu temperature, cooling fan
+  status and Fn-keys status on Dell laptops. It can also be used
+  to switch the fans on and off.
+
+  The driver has been developed and tested on an Inspiron 8000
+  but it should work on any Dell Inspiron or Latitude laptop.
+  You can force loading on unsupported models by passing the
+  parameter `force=1' to the module. Use at your own risk.
+
+  For more information on this driver and for utilities that make
+  use of the module see the I8K Linux Utilities web site at:
+  <http://www.debian.org/~dz/i8k/>.
 
-  For information on utilities to make use of this driver see the
-  I8K Linux utilities web site at:
-  <http://www.debian.org/~dz/i8k/>
-
-  Say Y if you intend to run this kernel on a Dell Inspiron 8000.
+  Say Y if you intend to run this kernel on a Dell laptop.
   Say N otherwise.
 
 /dev/cpu/microcode - Intel IA32 CPU microcode support
@@ -18541,7 +18571,7 @@
   Userspace tools to create new patches and load/unload them can be
   found at <http://opensource.creative.com/dist.html>.
 
-Creative EMU10K1 MIDI
+Creative SBLive! (EMU10K1) MIDI
 CONFIG_MIDI_EMU10K1
   Say Y if you want to be able to use the OSS /dev/sequencer
   interface.  This code is still experimental.
@@ -18794,20 +18824,21 @@
   website at <http://www.realitydiluted.com/projects/nino/index.html>
   will have more information.
 
-Model-500/510
-CONFIG_NINO_16MB
-  Say Y here to build a kernel specifically for Nino 500/501 color
-  Palm PCs from Philips (INCOMPLETE).
+# Choice: nino_model
+CONFIG_NINO_4MB
+  Say Y here to build a kernel specifically for Nino Palm PCs with
+  4MB of memory. These include models 300/301/302/319.
 
 Model-200/210/312/320/325/350/390
 CONFIG_NINO_8MB
   Say Y here to build a kernel specifically for Nino Palm PCs with
   8MB of memory. These include models 200/210/312/320/325/350/390.
 
+Model-500/510
+CONFIG_NINO_16MB
+  Say Y here to build a kernel specifically for Nino 500/501 color
+  Palm PCs from Philips (INCOMPLETE).
 Model-300/301/302/319
-CONFIG_NINO_4MB
-  Say Y here to build a kernel specifically for Nino Palm PCs with
-  4MB of memory. These include models 300/301/302/319.
 
 Low-level debugging
 CONFIG_LL_DEBUG
@@ -19253,7 +19284,7 @@
   This enables the PCMCIA client driver for the Sedlbauer Speed Star
   and Speed Star II cards.
 
-ST5481 USB ISDN adapter
+ST5481 USB ISDN modem
 CONFIG_HISAX_ST5481
   This enables the driver for ST5481 based USB ISDN adapters,
   e.g. the BeWan Gazel 128 USB
@@ -20375,7 +20406,7 @@
 
   If in doubt, say N.
 
-# Choice: Machine type
+# Choice: ppc4xxtype
 Oak
 CONFIG_OAK
   Select Oak if you have an IBM 403GCX "Oak" Evaluation Board.
@@ -20420,13 +20451,14 @@
 
   If in doubt, say N here.
 
-MPC8xx IDE support
+MPC8xx direct IDE support on PCMCIA port
 CONFIG_BLK_DEV_MPC8xx_IDE
   This option provides support for IDE on Motorola MPC8xx Systems.
   Please see 'Type of MPC8xx IDE interface' for details.
 
   If unsure, say N.
 
+# Choice: mpc8xxtype
 Type of MPC8xx IDE interface
 CONFIG_IDE_8xx_PCCARD
   Select how the IDE devices are connected to the MPC8xx system:
@@ -20501,7 +20533,7 @@
   More information is available at:
   <http://linux-apus.sourceforge.net/>.
 
-AltiVec Kernel Support
+AltiVec kernel support
 CONFIG_ALTIVEC
   This option enables kernel support for the Altivec extensions to the
   PowerPC processor. The kernel currently supports saving and restoring
@@ -21246,7 +21278,7 @@
 Guillemot MAXI Radio FM 2000 Radio Card
 CONFIG_RADIO_MAXIRADIO
   Choose Y here if you have this radio card.  This card may also be
-  found as Gemtek PCI FM.
+  found as GemTek PCI FM.
 
   In order to control your radio card, you will need to use programs
   that are compatible with the Video For Linux API.  Information on
@@ -21277,10 +21309,10 @@
 CONFIG_RADIO_GEMTEK_PORT
   Enter either 0x20c, 0x30c, 0x24c or 0x34c here. The card default is
   0x34c, if you haven't changed the jumper setting on the card. On
-  Sound Vision 16 Gold PnP with FM Radio (ESS1869+FM Gemtek), the I/O
+  Sound Vision 16 Gold PnP with FM Radio (ESS1869+FM GemTek), the I/O
   port is 0x28c.
 
-Gemtek PCI Radio
+GemTek PCI Radio Card support
 CONFIG_RADIO_GEMTEK_PCI
   Choose Y here if you have this PCI FM radio card.
 
@@ -21358,7 +21390,7 @@
   whenever you want). If you want to compile it as a module, say M
   here and read <file:Documentation/modules.txt>.
 
-BT878 Audio DMA
+BT878 audio DMA
 CONFIG_SOUND_BT878
   Audio DMA support for bt878 based grabber boards.  As you might have
   already noticed, bt878 is listed with two functions in /proc/pci.
@@ -21437,7 +21469,7 @@
   as a module (c-qcam.o).
   Read <file:Documentation/video4linux/CQcam.txt> for more information.
 
-Winbond W9966CF Webcam Video For Linux
+W9966 Webcam (FlyCam Supra and others) Video For Linux
 CONFIG_VIDEO_W9966
   Video4linux driver for Winbond's w9966 based Webcams.
   Currently tested with the LifeView FlyCam Supra.
@@ -21445,8 +21477,8 @@
   otherwise say N.
   This driver is also available as a module (w9966.o).
 
-  Check out <file:Documentation/video4linux/w9966.txt> for more
-  information.
+  Check out <file:drivers/media/video4linux/w9966.txt> and
+  <file:drivers/media/video/w9966.c> for more information.
 
 CPiA Video For Linux
 CONFIG_VIDEO_CPIA
@@ -21485,7 +21517,7 @@
   it as a module, say M here and read
   <file:Documentation/modules.txt>.
 
-Sony Vaio Picturebook Motion Eye Video for Linux
+Sony Vaio Picturebook Motion Eye Video For Linux
 CONFIG_VIDEO_MEYE
   This is the video4linux driver for the Motion Eye camera found
   in the Vaio Picturebook laptops. Please read the material in
@@ -21548,7 +21580,7 @@
   attached to another IBM mainframe operation system (OS/390, 
   VM/ESA, VSE/ESA).
 
-ECKD devices
+Support for ECKD hard disks
 CONFIG_DASD_ECKD
   ECKD devices are the most commonly used devices. you should enable
   this option unless you are very sure to have no ECKD device.
@@ -21557,7 +21589,7 @@
 CONFIG_DASD_CKD
   CKD devices are currently unsupported.
 
-FBA devices
+Support for FBA hard disks
 CONFIG_DASD_FBA
   FBA devices are currently unsupported.
 
@@ -21920,6 +21952,38 @@
   <http://www.visuaide.com/pagevictor.en.html> for information on
   this system.
 
+# Choice: cerf_ram
+Cerf on-board RAM size
+CONFIG_SA1100_CERF_8MB
+   Declare the size of the CerfBoard's on-board RAM.
+   Alternatives are 8, 16, 32, and 64MB.
+
+16MB
+CONFIG_SA1100_CERF_16MB
+   Declare that the CerfBoard has 16MB RAM.
+
+32MB
+CONFIG_SA1100_CERF_32MB
+   Declare that the CerfBoard has 32MB RAM.
+
+64MB
+CONFIG_SA1100_CERF_64MB
+   Declare that the CerfBoard has 64MB RAM.
+
+# Choice: cerf_flash
+Cerf flash memory size
+CONFIG_SA1100_CERF_FLASH_8MB
+  Tell the Cerf kernel the size of on-board memory.  The choices
+  are 8MB, 16MB, or 32MB.
+
+16MB
+CONFIG_SA1100_CERF_FLASH_16MB
+  Configure the Cerf kernel to expect 16MB of flash memory.
+
+32MB
+CONFIG_SA1100_CERF_FLASH_32MB
+  Configure the Cerf kernel to expect 32MB of flash memory.
+
 Support ARM610 processor
 CONFIG_CPU_ARM610
   The ARM610 is the successor to the ARM3 processor
@@ -22418,7 +22482,7 @@
   <file:Documentation/modules.txt>.  The module will be called
   nsc-ircc.o.
 
-National Semiconductor DP83820 series driver
+National Semiconductor DP83820 support
 CONFIG_NS83820
   This is a driver for the National Semiconductor DP83820 series
   of gigabit ethernet MACs.  Cards using this chipset include
@@ -22442,7 +22506,7 @@
   here and read <file:Documentation/modules.txt>.  The module will be
   called smc-ircc.o.
 
-ALi M5123 FIR Controller Driver
+ALi M5123 FIR controller driver
 CONFIG_ALI_FIR
   Say Y here if you want to build support for the ALi M5123 FIR
   Controller.  The ALi M5123 FIR Controller is embedded in ALi M1543C,
@@ -22453,7 +22517,7 @@
   <file:Documentation/modules.txt>.  The module will be called
   ali-ircc.o.
 
-VLSI 82C147 PCI-IrDA Controller Driver
+VLSI 82C147 PCI-IrDA SIR/MIR/FIR Controller driver
 CONFIG_VLSI_FIR
   Say Y here if you want to build support for the VLSI 82C147
   PCI-IrDA Controller. This controller is used by the HP OmniBook 800
@@ -22664,6 +22728,7 @@
 CONFIG_ETRAX_FLASH_BUSWIDTH
   Width in bytes of the Flash bus (1, 2 or 4). Is usually 2.
 
+# Choice: crisleds
 LED configuration on PA
 CONFIG_ETRAX_PA_LEDS
   The Etrax network driver is responsible for flashing LED's when
@@ -23148,6 +23213,7 @@
 CONFIG_ETRAX_I2C_EEPROM_8KB
   Use a 8kB EEPROM.
 
+# Choice: etrax_eeprom
 Etrax100 I2C EEPROM (NVRAM) size/probe
 CONFIG_ETRAX_I2C_EEPROM_PROBE
   Specifies size or auto probe of the EEPROM size.
@@ -23195,7 +23261,7 @@
 CONFIG_ETRAX_IDE_CSPE1_16_RESET
   Configures the pin used to reset the IDE bus.
 
-Etrax 100 ATA/IDE support
+Delay for drives to regain consciousness
 CONFIG_ETRAX_IDE_DELAY
   Sets the time to wait for disks to regain consciousness after reset.
 
@@ -23203,6 +23269,7 @@
 CONFIG_ETRAX_IDE_G27_RESET
   Configures the pin used to reset the IDE bus.
 
+# Choice: ide_reset
 IDE reset on PB Bit 7
 CONFIG_ETRAX_IDE_PB7_RESET
   Configures the pin used to reset the IDE bus.
@@ -23554,7 +23621,7 @@
   allocation as well as poisoning memory on free to catch use of freed
   memory.
 
-Memory mapped I/O debug support
+Memory mapped I/O debugging
 CONFIG_DEBUG_IOVIRT
   Say Y here to get warned whenever an attempt is made to do I/O on
   obviously invalid addresses such as those generated when ioremap()
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The end move in politics is always to pick up a gun.
	-- R. Buckminster Fuller
