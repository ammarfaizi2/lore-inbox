Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129255AbQLLCqi>; Mon, 11 Dec 2000 21:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129319AbQLLCq3>; Mon, 11 Dec 2000 21:46:29 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43026 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129255AbQLLCqY>; Mon, 11 Dec 2000 21:46:24 -0500
Subject: Linux 2.2.18 release notes
To: linux-kernel@vger.kernel.org
Date: Tue, 12 Dec 2000 02:18:12 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E145f1E-0000a9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Linux 2.2.18 Release Notes
  
   Platforms:Alpha, M68K, PowerPC, S/390, Sparc, X86
   
   Introduction
   Linux 2.2.18 is the latest update to the Linux kernel tree. The out of
   the box tree supports the Alpha, PPC, Sparc and X86 platforms. MIPS
   and ARM are mostly merged but you should obtain the platform specific
   tree.
   
   Compilers
   This code is intended to build with gcc 2.7.2 and egcs 1.1.2. Patches
   for building with gcc 2.95 are merged but less tested than other
   compilers. Caution is recommended when using gcc 2.95 and feedback is
   sought.
   
   Binary Compatibility
   Linux 2.2.18 should on the whole be fully binary compatible with old
   modules. There are no API changes, although 2.4 back compatibility
   API's are also introduced in this release. In general you should not
   assume binary compatibility between kernel object modules in Linux.
   
   Security Notes
   
   Linux 2.2.18 contains additional 2.4test ABI calls for controlling how
   capabilities are handled when using setuid calls.
   
   Architecture Updates
   
   Alpha
          
          + Fixed a problem where csum_partial_copy could cause spurious
            EFAULT returns
          + Fixed a problem with FPU division
            
   ARM
          The ARM tree has been partially synchronized with the ARM
          working tree for 2.2
          
   i386
          The major thrust has been support for processors running in
          excess of 2GHz, support for the CyrixIII processor and also
          basic support for the Pentium IV. Unfortunately Intel chose to
          ignore all precedent in model numbering via cpuid and report a
          family of '15'. This sudden jump broke assumptions in the
          kernel tree without any warning. Intel have failed to provide
          good reasons for their change. We have chosen to continue to
          report the Pentium IV as a '686' class processor. The full
          family data is provided via cpuinfo.
          
          In addition the early Pentium IV chips appear to have some
          problems. You should be using stepping 7 or higher processors
          with the latest shipping microcode update if you wish to run
          Linux on a Pentium IV processor.
          
          + Added a DMI scanner to handle broken Dell laptop APM
          + Added microcode update support from the 2.4test tree
          + Added msr/cpuid driver backport from 2.4test
          + Added support for processors running at over 2GHz
          + Experimental Cyrix III support
          + Fixed slight abuse of gcc inline asm in maths emulator
          + Fixed some minor bugs in the CPU failure reporting
          + Fixed db6 handling when doing ptrace
          + Intel Pentium IV support
          + Support both keyboard and 'fast' A20 gating
          + Updated MTRR support to handle the K6 mobile
            
   M68K
          Merge with the forked off M68K stable kernel tree
          
   PowerPC
          Merge with the PPC maintainers. Fix a problem with the syscall
          table
          
   S/390
          The S/390 tree has been brought back into sync with IBM
          
   Sparc
          
          + Updates for DRM and other ioctl changes
          + Fix dcache and exec problems
            
   Core Updates
   
   Asynchronous I/O
          Report failed fasync setup attempts rather than ignoring them.
          
   Block sizes
          Restore block sizes on devices after a partition scan
          
   Capabilities
          Added PR_GET/SET_KEEPCAPS from 2.4test
          
   Elevator
          Changed elevator algorithm to give better performance
          
   ioremap
          Fix a fencepost error in ioremap
          
   Low level I/O
          Fix a problem when a synchronous write occurred raw to a block
          device that went off the end of the disk.
          
   LRU corruption
          Fix potential LRU list corruption
          
   Memory Leaks
          Fixed memory handling on obscure error paths in the following -
          bttv, buz, qpmouse, ipddp, sdla, softoss, ixj, ax25
          
   Partitions
          Quietened down the partition table messages
          
   RAID
          Fix a raid1/vm deadlock
          
   set_current_state
          Fixed potential SMP race
          
   set_scheduler
          Fix lock inversion
          
   Timekeeping
          Fix locking between timers and rtc as well as CMOS locking
          
   tq_scheduler
          It was possible for tq_scheduler to sometimes run its tasks
          with interrupts disabled.
          
   Virtual Memory
          Fix a problem where the box could get stuck when it ran out of
          pages
          
   vmalloc
          Fix corner case that could cause crashes allocating large
          amount of vmalloc space on large machines
          
   Driver Updates
   
   3c59x
          Add support for the 3c556B
          
   8139too
          Add an improved new driver for the RTL8139 chips as an
          alternative to the dual 8129/8139 driver
          
   AC97 codecs
          Fixed several bugs in the AC97 support. Start MIC input off to
          avoid feedback
          
   Acenic
          Driver updates to fix a potential oops when using dhcp
          
   Acenic
          Fix problems when flushing jumbo ring. Fix setting the MAC
          address
          
   AGP
          The AGP bus drivers from Linux 2.4test are now included
          
   BTTV BT848/BT878 driver
          The bttv driver now supports subwindow clipping
          
   Compaq CISS
          A driver for the SA5300 CISS card has been added
          
   Compaq PCI Fibrechannel
          Added support for the Compaq 64bit/66Mhz fibrechannel adapter
          
   COSA
          Fix a potential crash
          
   CPQArray
          Fixed a case where the cpq array driver could cause a kernel
          oops
          
   Crystal CS4281
          Fixed hangs when playing sound on the cs4281
          
   Crystal 46xx driver
          Added more intelligence to the amplifier power control
          
   DAC960
          This driver has been updated
          
   DRM
          The 3D direct rendering manager is now included in 2.2 kernels
          
   EEPro
          Fix a bug when handling multiple cards
          
   EEPro100
          More PCI identifiers have been added
          
   ESS Maestro
          Added support for the radio interface on some Maestro cards
          
   Floppy driver
          Fix SMP locking problems
          
   Framebuffer console
          Fix a race in scroll back/paste
          
   IBM token ring
          Fix support for cable pulls/pcmcia problems
          
   IDE
          Avoid tuning older VIA chipsets that take offence
          
   IDE
          Added UDMA support for ALI1543 and 1543C devices
          
   IDE CDROM
          Fix a problem with CDROMPLAYTRKIND. Allow root to open the
          CDROM door at all times. Fix a problem with Sanyo changers
          
   IDE DVD
          Fix a bug in the RPC state handling
          
   IDE Floppy
          Fix problems with IDE floppy on the Alpha
          
   IDE multi-lun
          Attempt to intelligently decide of an IDE ATAPI device has LUN
          support
          
   ISDN
          Numerous small fixes
          
   ISI Serial
          Updated to support more cards
          
   Joystick
          Fix an option parsing bug
          
   NBD
          Fix a potential deadlock swapping over nbd
          
   OV511 cameras
          Updated to match the 2.4test tree
          
   PAS audio
          Fix a problem with the revision 'D' mixer support
          
   Pinnacle audio
          This driver now supports the Compaq Alpha platform
          
   PS/2 mouse
          Made reconnect parsing optional
          
   Random number generator
          Add support for the Intel i810 random number generator
          
   RTL8139
          This driver has been updated
          
   SIS 900 ethernet
          Add support for a new PHY
          
   SK fddi
          Support for the SK FDDI PCI adapters has been added
          
   SMC9194 driver
          A buffer handling bug has been fixed
          
   SX audio
          Updated and fixed
          
   SyncLink
          This driver has been updated
          
   Thunderlan
          Fix typos in the thunderlan driver
          
   Toshiba Floppies
          Handle odd interrupt returns seen on some Toshiba floppy drives
          
   Trident audio
          Added suport for onboard trident on Alpha machines
          
   Trident audio
          Fix hangs caused by attempts to initialise the midi on non Ali
          devices
          
   UART401
          Fixed a harmless free memory misuse in the uart401 driver
          
   USB
          A port of the core USB code from Linux 2.4 and most of the USB
          drivers is included.
          
   VIA audio
          Updated support for the VIA audio drivers
          
   WDT Watchdog
          Added support for the PCI card
          
   XSpeed DSL
          Added support for the XSpeed DSL card
          
   Yamaha PCI audio
          Add an initial native mode driver
          
   File System Updates
   
   ADFS
          Updated to resync with the ARM tree
          
   'Cache Locked' Error
          Fix 'cache locked' messages from NFS layer
          
   Ext2 fs
          Fixed some potential races in the file system
          
   Ext2 fs
          Clear suid bit on truncate as per SuSv2
          
   FAT FS
          Fix FAT32 to work on Alpha
          
   NCPfs
          Fix incorrect handling of kernel/user copies in NCP file system
          
   NFS
          Added NFSv3 support and fixed multiple NFS problems
          
   NFS locking
          Implement sun style NFS cache/lockf barriers
          
   NFS over TCP
          Added experimental support for NFS over TCP
          
   NTFS
          Fix translation bug
          
   Procfs
          Fix unlink bugs
          
   Quota
          Fixed some potential races in the quota handling
          
   SMB file system
          Fixes for OS/2 problems and other updates. Work around truncate
          problems with NetApp filers
          
   Swap
          Catch and report mis-sized swap partitions
          
   Windows VFAT naming
          We now use the same rules that windows appears to for
          generating VFAT names.
          
   Miscellaneous Updates
   
   Code Pages
          Fixed problems with Code Page cp932
          
   Compiler
          Automatically chose gcc272 or kgcc if present
          
   Console
          Added 'quiet' option as in 2.4test
          
   Network Updates
   
   Appletalk
          Fix ioctl handler for physical layer ioctls issued via
          appletalk sockets
          
   Arpfilter
          Arpfilter from 2.4test has been merged
          
   Cisco HDLC
          Quietly drop the newer Cisco 0x2000 info frames
          
   Control messsages
          Fix some corner cases in control message handling
          
   Generic Frame Diverter
          Added support for frame diversion when bridging
          
   IPfw
          Fix incorrect allocation flag
          
   IPv4 proc
          Fixed an off by one error
          
   IPv6
          Fixed memory handling bugs
          
   IPv6
          Fixed IPV6_TLV_ROUTERALERT, in6_addr, ip_decrease_ttl and mior
          bits
          
   IPv6 proc
          Fixed an off by one error
          
   Masquerading
          Allow binding to all multicast ports when masquerading
          
   Masquerading
          Update the irc masquerade to handle newer irc clients that
          support the DCC resume feature.
          
   NAT
          Fix obscure forwarding table bug with NAT
          
   Port sysctl
          Check range being set so that root cannot cause a crash by
          accidentally misconfiguring
          
   Standards
          Return correct error code for an uknown socket family
          
   SunRPC
          Fix a problem handling null credentials in kernel
          
   TCP
          Fix a problem with round trip estimation on very long fast
          links
          
   TCP Options
          Tidy up parsing and building. Fix a failure to honour
          sk->allocation.
          
   Transparent Proxy
          Fix a problem with the socket lookup in one case
          
   Unix domain sockets
          Backport 2.4test garbage collector speedups
          
   X.25
          Backport 2.4test fixes
          
   SCSI Updates
   
   Advansys
          Driver updated
          
   Adaptec 1542
          Fix memory scribbles when handling resets
          
   AMI Megaraid
          This driver has been updated
          
   ATP870U
          This driver has been updated and now supports more cards.
          
   Emu10K driver
          Added support for the EMU-APS
          
   GDTH
          This driver has been updated
          
   IBM MCA SCSI
          This driver has been updated
          
   IBM Serveraid
          Updated to version 4.20
          
   Lun Scanning
          Ignore LUNs that are reported as connectable but not currently
          connected.
          
   Lun Scanning
          Added the Digital HSG80 and the Compaq 'logical volume'
          identifiers to the multilun list
          
   Removable Devices
          Added support for opening empty removable devices
          
   SCSI generic
          Fix unload oops
          
   Segate Driver
          Remove broke bios parameter guessing code from the seagate
          driver
          
   Symbios/NCR driver
          This has been updated to the latest official release
          
   Tape driver
          Updated to fix several bugs. Fix filemark status test. Fix
          spacing to beginning
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
