Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129730AbRAFOiv>; Sat, 6 Jan 2001 09:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129752AbRAFOik>; Sat, 6 Jan 2001 09:38:40 -0500
Received: from smtp2.mail.yahoo.com ([128.11.68.32]:33032 "HELO
	smtp2.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129730AbRAFOif>; Sat, 6 Jan 2001 09:38:35 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A572B98.387C7D60@yahoo.com>
Date: Sat, 06 Jan 2001 09:28:40 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.0 i486)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/*/00-INDEX files
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patch to Documentation/00-INDEX files - also did networking and
filesystems subdir index files (which might even be ones I originally
started...) - other subdirs can be dealt with by their respective
maintainers or whoever is bored enough.

Paul.

--- 2400/linux/Documentation/00-INDEX.orig	Mon Nov 20 04:19:37 2000
+++ 2400/linux/Documentation/00-INDEX	Sat Jan  6 08:29:42 2001
@@ -1,8 +1,8 @@
+
 This is a brief list of all the files in ./linux/Documentation and what
 they contain. If you add a documentation file, please list it here in 
 alphabetical order as well, or risk being hunted down like a rabid dog. 
-Note that subdirectories have their own index files too. Please try and
-keep the descriptions small enough to fit on one line.
+Please try and keep the descriptions small enough to fit on one line.
 							 Thanks -- Paul G.
 
 00-INDEX
@@ -15,28 +15,40 @@
 	- how the boss likes the C code in the kernel to look.
 Configure.help
 	- text file that is used for help when you run "make config"
-IO-APIC.txt
-	- info on using the enhanced interrupt hardware on SMP boards.
+DMA-mapping.txt
+	- info for PCI drivers using DMA on 64 bit platforms.
+DocBook/
+	- directory with DocBook templates etc. for kernel documentation.
 IO-mapping.txt
 	- how to access I/O mapped memory from within device drivers.
+IRQ-affinity.txt
+	- how to select which CPU(s) handle which interrupt events on SMP.
+LVM-HOWTO
+	- info on setting up logical volume management (virtual disks etc.)
 README.DAC960
 	- info on Mylex DAC960/DAC1100 PCI RAID Controller Driver for Linux
+README.moxa
+	- release notes for Moxa mutiport serial card.
+SubmittingDrivers
+	- procedure to get a new driver source included into the kernel tree.
+SubmittingPatches
+	- procedure to get a source patch included into the kernel tree.
 VGA-softcursor.txt
 	- how to change your VGA cursor from a blinking underscore.
 arm/
 	- directory with info about Linux on the ARM architecture.
-atm.txt
-	- info on Linux ATM support
 binfmt_misc.txt
 	- info on the kernel support for extra binary formats.
+cachetlb.txt
+	- describes the cache/TLB flushing interfaces Linux uses.
+cciss.txt
+	- info, major/minor #'s for Compaq's SMART Array Controllers.
 cdrom/
 	- directory with information on the CD-ROM drivers that Linux has.
 computone.txt
 	- info on Computone Intelliport II/Plus Multiport Serial Driver
 cpqarray.txt
 	- info on using Compaq's SMART2 Intelligent Disk Array Controllers.
-devices.tex
-	- LaTeX source listing of all the nodes in /dev/ with major minor #'s
 devices.txt
 	- plain ASCII listing of all the nodes in /dev/ with major minor #'s
 digiboard.txt
@@ -51,12 +63,20 @@
 	- directory with info on the frame buffer graphics abstraction layer.
 filesystems/
 	- directory with info on the various filesystems that Linux supports.
+floppy.txt
+	- notes and driver options for the floppy disk driver.
 ftape.txt
 	- notes about the floppy tape device driver
 hayes-esp.txt
 	- info on using the Hayes ESP serial driver.
+highuid.txt
+	- notes on the change from 16 bit to 32 bit user/group IDs.
+i2c/
+	- directory with info about the I2C bus/protocol (2 wire, kHz speed)
 i386/
-	- directory with info about Linux on the intel ix86 architecture.
+	- directory with info about Linux on intel 32 bit architecture.
+ia64/
+	- directory with info about Linux on intel 64 bit architecture.
 ide.txt
 	- important info for users of ATA devices (IDE/EIDE disks and CD-ROMS)
 initrd.txt
@@ -77,6 +97,8 @@
 	- info on using joystick devices (and driver) with Linux.
 kbuild/
 	- directory with info about the kernel build process
+kernel-doc-nano-HOWTO.txt
+	- mini HowTo on generation and location of kernel documentation files.
 kernel-docs.txt
 	- listing of various WWW + books that document kernel internals.
 kernel-parameters.txt
@@ -101,10 +123,14 @@
 	- info on boot arguments for the multiple devices driver
 memory.txt
 	- info on typical Linux memory problems.
+mkdev.cciss
+	- script to make /dev entries for SMART controllers (see cciss.txt)
 mkdev.ida
 	- script to make /dev entries for Intelligent Disk Array Controllers.
 modules.txt
 	- short guide on how to make kernel parts into loadable modules
+moxa-smartio
+	- info on installing/using Moxa multiport serial driver.
 mtrr.txt
 	- how to use PPro Memory Type Range Registers to increase performance
 nbd.txt
@@ -119,8 +145,12 @@
 	- how to decode those nasty internal kernel error dump messages.
 paride.txt
 	- information about the parallel port IDE subsystem.
+parisc/
+	- directory with info on using Linux on PA-RISC architecture.
 parport.txt
 	- how to use the parallel-port driver.
+parport-lowlevel.txt
+	- description and usage of the low level parallel port functions.
 pci.txt
 	- info on the PCI subsystem for device driver authors
 pcwd-watchdog.txt
@@ -129,14 +159,14 @@
 	- info on Linux power management support
 powerpc/
 	- directory with info on using Linux with the PowerPC.
-proc_usb_info.txt
-	- info on /proc/bus/usb direcory generated for USB devices
 ramdisk.txt
 	- short guide on how to set up and use the RAM disk.
 riscom8.txt
 	- notes on using the RISCom/8 multi-port serial driver.
 rtc.txt
 	- notes on how to use the Real Time Clock (aka CMOS clock) driver.
+s390/
+	- directory with info on using Linux on the IBM S390.
 scsi-generic.txt
 	- info on the sg driver for generic (non-disk/CD/tape) SCSI devices.
 scsi.txt
@@ -153,6 +183,8 @@
 	- a few more notes on symmetric multi-processing
 sound/
 	- directory with info on sound card support
+sparc/
+	- directory with info on using Linux on Sparc architecture.
 specialix.txt
 	- info on hardware/driver for specialix IO8+ multiport serial card.
 spinlocks.txt
@@ -167,8 +199,12 @@
 	- directory with info on the /proc/sys/* files
 sysrq.txt
 	- info on the magic SysRq key
+telephony/
+	- directory with info on telephony (e.g. voice over IP) support.
 unicode.txt
 	- info on the Unicode character/font mapping used in Linux.
+usb/
+	- directory with info regarding the Universal Serial Bus.
 video4linux/
 	- directory with info regarding video/TV/radio cards and linux.
 vm/
@@ -177,4 +213,6 @@
 	- how to auto-reboot Linux if it has "fallen and can't get up". ;-)
 xterm-linux.xpm
 	- XPM image of penguin logo (see logo.txt) sitting on an xterm.
+zorro.txt
+	- info on writing drivers for Zorro bus devices found on Amigas.
 
--- 2400/linux/Documentation/networking/00-INDEX~	Tue Dec  7 03:51:20 1999
+++ 2400/linux/Documentation/networking/00-INDEX	Sat Jan  6 09:21:49 2001
@@ -4,32 +4,46 @@
 	- information on the 3Com EtherLink Plus (3c505) driver.
 6pack.txt
 	- info on the 6pack protocol, an alternative to KISS for AX.25
+8139too.txt
+	- info on the 8139too driver for RTL-8139 based network cards.
 Configurable
 	- info on some of the configurable network parameters
 DLINK.txt
 	- info on the D-Link DE-600/DE-620 parallel port pocket adapters
 PLIP.txt
 	- PLIP: The Parallel Line Internet Protocol device driver
+README.sb1000
+	- info on General Instrument/NextLevel SURFboard1000 cable modem.
 alias.txt
 	- info on using alias network devices 
 arcnet-hardware.txt
 	- tons of info on ARCnet, hubs, jumper settings for ARCnet cards, etc.
 arcnet.txt
 	- info on the using the ARCnet driver itself.
+atm.txt
+	- info on where to get ATM programs and support for Linux.
 ax25.txt
 	- info on using AX.25 and NET/ROM code for Linux
 baycom.txt
 	- info on the driver for Baycom style amateur radio modems
+bridge.txt
+	- where to get user space programs for ethernet bridging with Linux.
+comx.txt
+	- info on drivers for COMX line of synchronous serial adapters.
 cops.txt
 	- info on the COPS LocalTalk Linux driver
 cs89x0.txt
 	- the Crystal LAN (CS8900/20-based) Ethernet ISA adapter driver
 de4x5.txt
 	- the Digital EtherWORKS DE4?? and DE5?? PCI Ethernet driver
+decnet.txt
+	- info on using the DECnet networking layer in Linux.
 depca.txt
 	- the Digital DEPCA/EtherWORKS DE1?? and DE2?? LANCE Ethernet driver
 dgrs.txt
 	- the Digi International RightSwitch SE-X Ethernet driver
+dmfe.txt
+	- info on the Davicom DM9102(A)/DM9132/DM9801 fast ethernet driver.
 eql.txt
 	- serial IP load balancing
 ethertap.txt
@@ -38,6 +52,8 @@
 	- the Digital EtherWORKS 3 DE203/4/5 Ethernet driver
 filter.txt
 	- Linux Socket Filtering
+fore200e.txt
+	- FORE Systems PCA-200E/SBA-200E ATM NIC driver info.
 framerelay.txt
 	- info on using Frame Relay/Data Link Connection Identifier (DLCI).
 ip-sysctl.txt
@@ -46,6 +62,10 @@
 	- IP dynamic address hack e.g. for auto-dialup links
 ipddp.txt
 	- AppleTalk-IP Decapsulation and AppleTalk-IP Encapsulation
+iphase.txt
+	- Interphase PCI ATM (i)Chip IA Linux driver info.
+irda.txt
+	- where to get IrDA (infrared) utilities and info for Linux.
 lapb-module.txt
 	- programming information of the LAPB module.
 ltpc.txt
@@ -56,22 +76,42 @@
 	- notes on how NCSA telnet (DOS) breaks with MTU discovery enabled.
 net-modules.txt
 	- info and "insmod" parameters for all network driver modules.
+netdevices.txt
+	- info on network device driver functions exported to the kernel.
+olympic.txt
+	- IBM PCI Pit/Pit-Phy/Olympic Token Ring driver info.
 policy-routing.txt
 	- IP policy-based routing
 pt.txt
 	- the Gracilis Packetwin AX.25 device driver
+ray_cs.txt
+	- Raylink Wireless LAN card driver info.
 routing.txt
 	- the new routing mechanism
 shaper.txt
 	- info on the module that can shape/limit transmitted traffic.
+sis900.txt
+	- SiS 900/7016 Fast Ethernet device driver info.
+sk98lin.txt
+	- SysKonnect SK-NET (SK-98xx) Gigabit Ethernet driver info.
+skfp.txt
+	- SysKonnect FDDI (SK-5xxx, Compaq Netelligent) driver info.
 smc9.txt
 	- the driver for SMC's 9000 series of Ethernet cards
+smctr.txt
+	- SMC TokenCard TokenRing Linux driver info.
 soundmodem.txt
 	- Linux driver for sound cards as AX.25 modems
 tcp.txt
 	- short blurb on how TCP output takes place.
+tlan.txt
+	- ThunderLAN (Compaq Netelligent 10/100, Olicom OC-2xxx) driver info.
+tms380tr.txt
+	- SysKonnect Token Ring ISA/PCI adapter driver info.
 tulip.txt
 	- info on using DEC 21040/21041/21140 based PCI Ethernet cards.
+tuntap.txt
+	- TUN/TAP device driver, allowing user space Rx/Tx of packets.
 vortex.txt
 	- info on using 3Com Vortex (3c590, 3c592, 3c595, 3c597) Ethernet cards.
 wan-router.txt
--- 2400/linux/Documentation/filesystems/00-INDEX~	Fri May 26 16:09:47 2000
+++ 2400/linux/Documentation/filesystems/00-INDEX	Sat Jan  6 08:44:38 2001
@@ -1,5 +1,7 @@
 00-INDEX
 	- this file (info on some of the filesystems supported by linux).
+Locking
+	- info on locking rules as they pertain to Linux VFS.
 adfs.txt
 	- info and mount options for the Acorn Advanced Disc Filing System.
 affs.txt
@@ -8,8 +10,12 @@
 	- info for the SCO UnixWare Boot Filesystem (BFS).
 coda.txt
 	- description of the CODA filesystem.
-devfs
+cramfs.txt
+	- info on the cram filesystem for small storage (ROMs etc)
+devfs/
 	- directory containing devfs documentation.
+ext2.txt
+	- info, mount options and specifications for the Ext2 filesystem.
 fat_cvf.txt
 	- info on the Compressed Volume Files extension to the FAT filesystem
 hpfs.txt




__________________________________________________
Do You Yahoo!?
Talk to your friends online with Yahoo! Messenger.
http://im.yahoo.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
