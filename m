Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262596AbREWHYc>; Wed, 23 May 2001 03:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262997AbREWHYX>; Wed, 23 May 2001 03:24:23 -0400
Received: from olsinka.site.cas.cz ([147.231.11.16]:5504 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S262596AbREWHYM>;
	Wed, 23 May 2001 03:24:12 -0400
Date: Wed, 23 May 2001 09:23:54 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stephen Thomas <stephen.thomas@insignia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Gameport analog joystick broken in 2.4.4-ac13
Message-ID: <20010523092354.B1046@suse.cz>
In-Reply-To: <3B0ADD9D.5424DE7F@insignia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B0ADD9D.5424DE7F@insignia.com>; from stephen.thomas@insignia.com on Tue, May 22, 2001 at 10:43:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2001 at 10:43:57PM +0100, Stephen Thomas wrote:
> I have an analog joystick plugged into the gameport of a Soundblaster
> AWE64.  In 2.4.4-ac12 this was recognized and worked just fine.  Under
> ac13 the recognition is incomplete - it seems to identify that there
> is a NS558 gameport device present, but not that there is a joystick
> plugged into it (unless I'm completely misunderstanding the log
> messages).
> 
> Anyway, I've attached the .config for the ac12 kernel - the ac13
> kernel is the same except I've enabled ECN.  I've also attached
> the initial log messages for the ac12 and ac13 boots on the machine
> in question.

This is weird - there were no changes in joystick code between the two
as far as I know. Have you tried loading the modules manually?

Vojtech

> 
> Stephen Thomas
> kernel: Linux version 2.4.4-ac12 (root@domain-removed) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #2 Tue May 22 08:28:12 BST 2001 
> kernel: BIOS-provided physical RAM map: 
> kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable) 
> kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved) 
> kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved) 
> kernel:  BIOS-e820: 0000000000100000 - 000000000c000000 (usable) 
> kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved) 
> kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved) 
> kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved) 
> kernel: found SMP MP-table at 000f5a10 
> kernel: hm, page 000f5000 reserved twice. 
> kernel: hm, page 000f6000 reserved twice. 
> kernel: hm, page 000f2000 reserved twice. 
> kernel: hm, page 000f3000 reserved twice. 
> kernel: On node 0 totalpages: 49152 
> kernel: zone(0): 4096 pages. 
> kernel: zone(1): 45056 pages. 
> kernel: zone(2): 0 pages. 
> kernel: Intel MultiProcessor Specification v1.1 
> kernel:     Virtual Wire compatibility mode. 
> kernel: OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000 
> kernel: Processor #0 Pentium(tm) Pro APIC version 17 
> kernel: Processor #255 Pentium(tm) Pro APIC version 17 
> kernel: Processor #255 INVALID. (Max ID: 16). 
> kernel: I/O APIC #2 Version 17 at 0xFEC00000. 
> kernel: Processors: 2 
> kernel: Kernel command line: BOOT_IMAGE=s24acp ro root=306 hdc=scsi 
> kernel: ide_setup: hdc=scsi 
> kernel: Initializing CPU#0 
> kernel: Detected 200.457 MHz processor. 
> kernel: Console: colour VGA+ 132x60 
> kernel: Calibrating delay loop... 399.76 BogoMIPS 
> kernel: Memory: 191196k/196608k available (933k kernel code, 5024k reserved, 256k data, 196k init, 0k highmem) 
> kernel: Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes) 
> kernel: Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes) 
> kernel: Page-cache hash table entries: 65536 (order: 6, 262144 bytes) 
> kernel: Inode-cache hash table entries: 16384 (order: 5, 131072 bytes) 
> kernel: CPU: L1 I cache: 8K, L1 D cache: 8K 
> kernel: CPU: L2 cache: 256K 
> kernel: Intel machine check architecture supported. 
> kernel: Intel machine check reporting enabled on CPU#0. 
> kernel: CPU: Intel Pentium Pro stepping 09 
> kernel: Checking 'hlt' instruction... OK. 
> kernel: POSIX conformance testing by UNIFIX 
> kernel: enabled ExtINT on CPU#0 
> kernel: ESR value before enabling vector: 00000004 
> kernel: ESR value after enabling vector: 00000000 
> kernel: ENABLING IO-APIC IRQs 
> kernel: ...changing IO-APIC physical APIC ID to 2 ... ok. 
> kernel: ..TIMER: vector=49 pin1=2 pin2=0 
> kernel: testing the IO APIC....................... 
> kernel:  
> kernel: .................................... done. 
> kernel: Using local APIC timer interrupts. 
> kernel: calibrating APIC timer ... 
> kernel: ..... CPU clock speed is 200.4615 MHz. 
> kernel: ..... host bus clock speed is 66.8201 MHz. 
> kernel: cpu: 0, clocks: 668201, slice: 334100 
> kernel: CPU0<T0:668192,T1:334080,D:12,S:334100,C:668201> 
> kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au) 
> kernel: mtrr: detected mtrr type: Intel 
> kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb210, last bus=0 
> kernel: PCI: Using configuration type 1 
> kernel: PCI: Probing PCI hardware 
> kernel: PCI->APIC IRQ transform: (B0,I10,P0) -> 18 
> kernel: Limiting direct PCI/PCI transfers. 
> kernel: Activating ISA DMA hang workarounds. 
> kernel: isapnp: Scanning for PnP cards... 
> kernel: isapnp: SB audio device quirk - increasing port range 
> kernel: isapnp: AWE32 quirk - adding two ports 
> kernel: isapnp: Card 'Creative SB AWE64 PnP' 
> kernel: isapnp: 1 Plug & Play card detected total 
> kernel: PnP: PNP BIOS installation structure at 0xc00fbee0 
> kernel: PnP: PNP BIOS version 1.0, entry at f0000:bf08, dseg at f0000 
> kernel: Linux NET4.0 for Linux 2.4 
> kernel: Based upon Swansea University Computer Society NET3.039 
> kernel: Starting kswapd v1.8 
> kernel: pty: 256 Unix98 ptys configured 
> kernel: gameport0: NS558 PnP at 0x200 size 8 speed 710 kHz 
> kernel: input0: Analog 4-axis 4-button joystick at gameport0.0 [TSC timer, 200 MHz clock, 1545 ns res] 
> kernel: Real Time Clock Driver v1.10d 
> ...

> kernel: Linux version 2.4.4-ac13 (root@domain-removed) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Tue May 22 18:51:35 BST 2001 
> kernel: BIOS-provided physical RAM map: 
> kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable) 
> kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved) 
> kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved) 
> kernel:  BIOS-e820: 0000000000100000 - 000000000c000000 (usable) 
> kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved) 
> kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved) 
> kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved) 
> kernel: found SMP MP-table at 000f5a10 
> kernel: hm, page 000f5000 reserved twice. 
> kernel: hm, page 000f6000 reserved twice. 
> kernel: hm, page 000f2000 reserved twice. 
> kernel: hm, page 000f3000 reserved twice. 
> kernel: On node 0 totalpages: 49152 
> kernel: zone(0): 4096 pages. 
> kernel: zone(1): 45056 pages. 
> kernel: zone(2): 0 pages. 
> kernel: Intel MultiProcessor Specification v1.1 
> kernel:     Virtual Wire compatibility mode. 
> kernel: OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000 
> kernel: Processor #0 Pentium(tm) Pro APIC version 17 
> kernel: Processor #255 Pentium(tm) Pro APIC version 17 
> kernel: Processor #255 INVALID. (Max ID: 16). 
> kernel: I/O APIC #2 Version 17 at 0xFEC00000. 
> kernel: Processors: 2 
> kernel: Kernel command line: BOOT_IMAGE=s24ac ro root=306 hdc=scsi 
> kernel: ide_setup: hdc=scsi 
> kernel: Initializing CPU#0 
> kernel: Detected 200.459 MHz processor. 
> kernel: Console: colour VGA+ 132x60 
> kernel: Calibrating delay loop... 399.76 BogoMIPS 
> kernel: Memory: 191196k/196608k available (934k kernel code, 5024k reserved, 256k data, 196k init, 0k highmem) 
> kernel: Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes) 
> kernel: Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes) 
> kernel: Page-cache hash table entries: 65536 (order: 6, 262144 bytes) 
> kernel: Inode-cache hash table entries: 16384 (order: 5, 131072 bytes) 
> kernel: CPU: L1 I cache: 8K, L1 D cache: 8K 
> kernel: CPU: L2 cache: 256K 
> kernel: Intel machine check architecture supported. 
> kernel: Intel machine check reporting enabled on CPU#0. 
> kernel: CPU: Intel Pentium Pro stepping 09 
> kernel: Checking 'hlt' instruction... OK. 
> kernel: POSIX conformance testing by UNIFIX 
> kernel: enabled ExtINT on CPU#0 
> kernel: ESR value before enabling vector: 00000004 
> kernel: ESR value after enabling vector: 00000000 
> kernel: ENABLING IO-APIC IRQs 
> kernel: ...changing IO-APIC physical APIC ID to 2 ... ok. 
> kernel: ..TIMER: vector=49 pin1=2 pin2=0 
> kernel: testing the IO APIC....................... 
> kernel:  
> kernel: .................................... done. 
> kernel: Using local APIC timer interrupts. 
> kernel: calibrating APIC timer ... 
> kernel: ..... CPU clock speed is 200.4470 MHz. 
> kernel: ..... host bus clock speed is 66.8153 MHz. 
> kernel: cpu: 0, clocks: 668153, slice: 334076 
> kernel: CPU0<T0:668144,T1:334064,D:4,S:334076,C:668153> 
> kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au) 
> kernel: mtrr: detected mtrr type: Intel 
> kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb210, last bus=0 
> kernel: PCI: Using configuration type 1 
> kernel: PCI: Probing PCI hardware 
> kernel: PCI->APIC IRQ transform: (B0,I10,P0) -> 18 
> kernel: Limiting direct PCI/PCI transfers. 
> kernel: Activating ISA DMA hang workarounds. 
> kernel: isapnp: Scanning for PnP cards... 
> kernel: isapnp: SB audio device quirk - increasing port range 
> kernel: isapnp: AWE32 quirk - adding two ports 
> kernel: isapnp: Card 'Creative SB AWE64 PnP' 
> kernel: isapnp: 1 Plug & Play card detected total 
> kernel: PnP: PNP BIOS installation structure at 0xc00fbee0 
> kernel: PnP: PNP BIOS version 1.0, entry at f0000:bf08, dseg at f0000 
> kernel: Linux NET4.0 for Linux 2.4 
> kernel: Based upon Swansea University Computer Society NET3.039 
> rc.sysinit: Mounting proc filesystem succeeded 
> sysctl: net.ipv4.ip_forward = 0 
> sysctl: net.ipv4.conf.all.rp_filter = 1 
> sysctl: kernel.sysrq = 1 
> kernel: Starting kswapd v1.8 
> sysctl: error: 'net.ipv4.ip_always_defrag' is an unknown key 
> kernel: pty: 256 Unix98 ptys configured 
> rc.sysinit: Configuring kernel parameters succeeded 
> kernel: gameport0: NS558 PnP at 0x200 size 8 speed 710 kHz 
> date: Tue May 22 22:04:58 BST 2001 
> kernel: Real Time Clock Driver v1.10d 
> ...

> #
> # Automatically generated by make menuconfig: don't edit
> #
> CONFIG_X86=y
> CONFIG_ISA=y
> # CONFIG_SBUS is not set
> CONFIG_UID16=y
> 
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=y
> 
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> # CONFIG_MODVERSIONS is not set
> CONFIG_KMOD=y
> 
> #
> # Processor type and features
> #
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> CONFIG_M686=y
> # CONFIG_MPENTIUMIII is not set
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MCYRIXIII is not set
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_XADD=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> # CONFIG_RWSEM_GENERIC_SPINLOCK is not set
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_X86_L1_CACHE_SHIFT=5
> CONFIG_X86_TSC=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_PGE=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> # CONFIG_TOSHIBA is not set
> # CONFIG_MICROCODE is not set
> # CONFIG_X86_MSR is not set
> # CONFIG_X86_CPUID is not set
> CONFIG_NOHIGHMEM=y
> # CONFIG_HIGHMEM4G is not set
> # CONFIG_HIGHMEM64G is not set
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=y
> # CONFIG_SMP is not set
> CONFIG_X86_UP_APIC=y
> CONFIG_X86_UP_IOAPIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> 
> #
> # General setup
> #
> CONFIG_NET=y
> # CONFIG_VISWS is not set
> CONFIG_PCI=y
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_NAMES=y
> # CONFIG_EISA is not set
> # CONFIG_MCA is not set
> # CONFIG_HOTPLUG is not set
> # CONFIG_PCMCIA is not set
> CONFIG_SYSVIPC=y
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_SYSCTL=y
> CONFIG_KCORE_ELF=y
> # CONFIG_KCORE_AOUT is not set
> CONFIG_BINFMT_AOUT=m
> CONFIG_BINFMT_ELF=y
> CONFIG_BINFMT_MISC=m
> # CONFIG_PM is not set
> # CONFIG_ACPI is not set
> # CONFIG_APM is not set
> 
> #
> # Memory Technology Devices (MTD)
> #
> # CONFIG_MTD is not set
> 
> #
> # Parallel port support
> #
> # CONFIG_PARPORT is not set
> 
> #
> # Plug and Play configuration
> #
> CONFIG_PNP=y
> CONFIG_ISAPNP=y
> CONFIG_PNPBIOS=y
> 
> #
> # Block devices
> #
> CONFIG_BLK_DEV_FD=m
> # CONFIG_BLK_DEV_XD is not set
> # CONFIG_PARIDE is not set
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> CONFIG_BLK_DEV_LOOP=m
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_RAM is not set
> # CONFIG_BLK_DEV_INITRD is not set
> 
> #
> # Multi-device support (RAID and LVM)
> #
> # CONFIG_MD is not set
> # CONFIG_BLK_DEV_MD is not set
> # CONFIG_MD_LINEAR is not set
> # CONFIG_MD_RAID0 is not set
> # CONFIG_MD_RAID1 is not set
> # CONFIG_MD_RAID5 is not set
> # CONFIG_BLK_DEV_LVM is not set
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> # CONFIG_PACKET_MMAP is not set
> # CONFIG_NETLINK is not set
> # CONFIG_NETFILTER is not set
> # CONFIG_FILTER is not set
> CONFIG_UNIX=y
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> # CONFIG_IP_ADVANCED_ROUTER is not set
> # CONFIG_IP_PNP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE is not set
> # CONFIG_IP_MROUTE is not set
> # CONFIG_INET_ECN is not set
> CONFIG_SYN_COOKIES=y
> # CONFIG_IPV6 is not set
> # CONFIG_KHTTPD is not set
> # CONFIG_ATM is not set
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
> # CONFIG_DECNET is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_LLC is not set
> # CONFIG_NET_DIVERT is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> # CONFIG_NET_FASTROUTE is not set
> # CONFIG_NET_HW_FLOWCONTROL is not set
> 
> #
> # QoS and/or fair queueing
> #
> # CONFIG_NET_SCHED is not set
> 
> #
> # Telephony Support
> #
> # CONFIG_PHONE is not set
> # CONFIG_PHONE_IXJ is not set
> 
> #
> # ATA/IDE/MFM/RLL support
> #
> CONFIG_IDE=y
> 
> #
> # IDE, ATA and ATAPI Block devices
> #
> CONFIG_BLK_DEV_IDE=y
> # CONFIG_BLK_DEV_HD_IDE is not set
> # CONFIG_BLK_DEV_HD is not set
> CONFIG_BLK_DEV_IDEDISK=y
> # CONFIG_IDEDISK_MULTI_MODE is not set
> # CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
> # CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
> # CONFIG_BLK_DEV_IDEDISK_IBM is not set
> # CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
> # CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
> # CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
> # CONFIG_BLK_DEV_IDEDISK_WD is not set
> # CONFIG_BLK_DEV_COMMERIAL is not set
> # CONFIG_BLK_DEV_TIVO is not set
> # CONFIG_BLK_DEV_IDECS is not set
> CONFIG_BLK_DEV_IDECD=y
> # CONFIG_BLK_DEV_IDETAPE is not set
> # CONFIG_BLK_DEV_IDEFLOPPY is not set
> CONFIG_BLK_DEV_IDESCSI=y
> # CONFIG_BLK_DEV_CMD640 is not set
> # CONFIG_BLK_DEV_CMD640_ENHANCED is not set
> # CONFIG_BLK_DEV_ISAPNP is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_OFFBOARD is not set
> CONFIG_IDEDMA_PCI_AUTO=y
> CONFIG_BLK_DEV_IDEDMA=y
> # CONFIG_IDEDMA_PCI_WIP is not set
> # CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_AEC62XX_TUNING is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> # CONFIG_WDC_ALI15X3 is not set
> # CONFIG_BLK_DEV_AMD7409 is not set
> # CONFIG_AMD7409_OVERRIDE is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5530 is not set
> # CONFIG_BLK_DEV_HPT34X is not set
> # CONFIG_HPT34X_AUTODMA is not set
> # CONFIG_BLK_DEV_HPT366 is not set
> CONFIG_BLK_DEV_PIIX=y
> CONFIG_PIIX_TUNING=y
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_PDC202XX is not set
> # CONFIG_PDC202XX_BURST is not set
> # CONFIG_BLK_DEV_OSB4 is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> # CONFIG_BLK_DEV_VIA82CXXX is not set
> # CONFIG_IDE_CHIPSETS is not set
> CONFIG_IDEDMA_AUTO=y
> # CONFIG_IDEDMA_IVB is not set
> # CONFIG_DMA_NONPCI is not set
> CONFIG_BLK_DEV_IDE_MODES=y
> 
> #
> # SCSI support
> #
> CONFIG_SCSI=y
> # CONFIG_BLK_DEV_SD is not set
> # CONFIG_CHR_DEV_ST is not set
> # CONFIG_CHR_DEV_OSST is not set
> CONFIG_BLK_DEV_SR=y
> # CONFIG_BLK_DEV_SR_VENDOR is not set
> CONFIG_SR_EXTRA_DEVS=2
> CONFIG_CHR_DEV_SG=y
> # CONFIG_SCSI_DEBUG_QUEUES is not set
> # CONFIG_SCSI_MULTI_LUN is not set
> # CONFIG_SCSI_CONSTANTS is not set
> # CONFIG_SCSI_LOGGING is not set
> 
> #
> # SCSI low-level drivers
> #
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_7000FASST is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AHA152X is not set
> # CONFIG_SCSI_AHA1542 is not set
> # CONFIG_SCSI_AHA1740 is not set
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC7XXX_OLD is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_IN2000 is not set
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_MEGARAID is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_CPQFCTS is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_DTC3280 is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_EATA_DMA is not set
> # CONFIG_SCSI_EATA_PIO is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_GENERIC_NCR5380 is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_NCR53C406A is not set
> # CONFIG_SCSI_NCR_D700 is not set
> # CONFIG_SCSI_NCR53C7xx is not set
> # CONFIG_SCSI_NCR53C8XX is not set
> # CONFIG_SCSI_SYM53C8XX is not set
> # CONFIG_SCSI_PAS16 is not set
> # CONFIG_SCSI_PCI2000 is not set
> # CONFIG_SCSI_PCI2220I is not set
> # CONFIG_SCSI_PSI240I is not set
> # CONFIG_SCSI_QLOGIC_FAS is not set
> # CONFIG_SCSI_QLOGIC_ISP is not set
> # CONFIG_SCSI_QLOGIC_FC is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_SEAGATE is not set
> # CONFIG_SCSI_SIM710 is not set
> # CONFIG_SCSI_SYM53C416 is not set
> # CONFIG_SCSI_DC390T is not set
> # CONFIG_SCSI_T128 is not set
> # CONFIG_SCSI_U14_34F is not set
> # CONFIG_SCSI_ULTRASTOR is not set
> # CONFIG_SCSI_DEBUG is not set
> 
> #
> # Fusion MPT device support
> #
> # CONFIG_FUSION is not set
> # CONFIG_FUSION_BOOT is not set
> # CONFIG_FUSION_ISENSE is not set
> # CONFIG_FUSION_CTL is not set
> # CONFIG_FUSION_LAN is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> # CONFIG_IEEE1394 is not set
> 
> #
> # I2O device support
> #
> # CONFIG_I2O is not set
> # CONFIG_I2O_PCI is not set
> # CONFIG_I2O_BLOCK is not set
> # CONFIG_I2O_LAN is not set
> # CONFIG_I2O_SCSI is not set
> # CONFIG_I2O_PROC is not set
> 
> #
> # Network device support
> #
> CONFIG_NETDEVICES=y
> 
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
> CONFIG_DUMMY=y
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_TUN is not set
> # CONFIG_NET_SB1000 is not set
> 
> #
> # Ethernet (10 or 100Mbit)
> #
> # CONFIG_NET_ETHERNET is not set
> 
> #
> # Ethernet (1000 Mbit)
> #
> # CONFIG_ACENIC is not set
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> # CONFIG_SK98LIN is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> CONFIG_PPP=m
> # CONFIG_PPP_MULTILINK is not set
> # CONFIG_PPP_FILTER is not set
> CONFIG_PPP_ASYNC=m
> # CONFIG_PPP_SYNC_TTY is not set
> CONFIG_PPP_DEFLATE=m
> CONFIG_PPP_BSDCOMP=m
> # CONFIG_PPPOE is not set
> # CONFIG_SLIP is not set
> 
> #
> # Wireless LAN (non-hamradio)
> #
> # CONFIG_NET_RADIO is not set
> 
> #
> # Token Ring devices
> #
> # CONFIG_TR is not set
> # CONFIG_NET_FC is not set
> # CONFIG_RCPCI is not set
> # CONFIG_SHAPER is not set
> 
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
> 
> #
> # Amateur Radio support
> #
> # CONFIG_HAMRADIO is not set
> 
> #
> # IrDA (infrared) support
> #
> # CONFIG_IRDA is not set
> 
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN is not set
> 
> #
> # Old CD-ROM drivers (not SCSI, not IDE)
> #
> # CONFIG_CD_NO_IDESCSI is not set
> 
> #
> # Input core support
> #
> CONFIG_INPUT=y
> # CONFIG_INPUT_KEYBDEV is not set
> # CONFIG_INPUT_MOUSEDEV is not set
> CONFIG_INPUT_JOYDEV=y
> CONFIG_INPUT_EVDEV=y
> 
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_SERIAL=m
> # CONFIG_SERIAL_EXTENDED is not set
> # CONFIG_SERIAL_NONSTANDARD is not set
> CONFIG_UNIX98_PTYS=y
> CONFIG_UNIX98_PTY_COUNT=256
> 
> #
> # I2C support
> #
> # CONFIG_I2C is not set
> 
> #
> # Mice
> #
> # CONFIG_BUSMOUSE is not set
> CONFIG_MOUSE=y
> CONFIG_PSMOUSE=y
> # CONFIG_82C710_MOUSE is not set
> # CONFIG_PC110_PAD is not set
> 
> #
> # Joysticks
> #
> CONFIG_JOYSTICK=y
> CONFIG_INPUT_NS558=y
> # CONFIG_INPUT_LIGHTNING is not set
> # CONFIG_INPUT_PCIGAME is not set
> # CONFIG_INPUT_CS461X is not set
> CONFIG_INPUT_ANALOG=y
> # CONFIG_INPUT_A3D is not set
> # CONFIG_INPUT_ADI is not set
> # CONFIG_INPUT_COBRA is not set
> # CONFIG_INPUT_GF2K is not set
> # CONFIG_INPUT_GRIP is not set
> # CONFIG_INPUT_INTERACT is not set
> # CONFIG_INPUT_TMDC is not set
> # CONFIG_INPUT_SIDEWINDER is not set
> # CONFIG_INPUT_SERPORT is not set
> # CONFIG_INPUT_WARRIOR is not set
> # CONFIG_INPUT_MAGELLAN is not set
> # CONFIG_INPUT_SPACEORB is not set
> # CONFIG_INPUT_SPACEBALL is not set
> # CONFIG_INPUT_STINGER is not set
> # CONFIG_INPUT_IFORCE_232 is not set
> # CONFIG_INPUT_IFORCE_USB is not set
> # CONFIG_QIC02_TAPE is not set
> 
> #
> # Watchdog Cards
> #
> # CONFIG_WATCHDOG is not set
> # CONFIG_INTEL_RNG is not set
> # CONFIG_NVRAM is not set
> CONFIG_RTC=y
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> 
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_FTAPE is not set
> # CONFIG_AGP is not set
> # CONFIG_DRM is not set
> 
> #
> # Multimedia devices
> #
> # CONFIG_VIDEO_DEV is not set
> 
> #
> # File systems
> #
> # CONFIG_QUOTA is not set
> # CONFIG_AUTOFS_FS is not set
> CONFIG_AUTOFS4_FS=m
> # CONFIG_REISERFS_FS is not set
> # CONFIG_REISERFS_CHECK is not set
> # CONFIG_ADFS_FS is not set
> # CONFIG_ADFS_FS_RW is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_CMS_FS is not set
> # CONFIG_FAT_FS is not set
> # CONFIG_MSDOS_FS is not set
> # CONFIG_UMSDOS_FS is not set
> # CONFIG_VFAT_FS is not set
> # CONFIG_EFS_FS is not set
> # CONFIG_JFFS_FS is not set
> # CONFIG_JFFS2_FS is not set
> # CONFIG_CRAMFS is not set
> CONFIG_TMPFS=y
> # CONFIG_RAMFS is not set
> CONFIG_ISO9660_FS=m
> CONFIG_JOLIET=y
> # CONFIG_MINIX_FS is not set
> # CONFIG_FREEVXFS_FS is not set
> # CONFIG_NTFS_FS is not set
> # CONFIG_NTFS_RW is not set
> # CONFIG_HPFS_FS is not set
> CONFIG_PROC_FS=y
> # CONFIG_DEVFS_FS is not set
> # CONFIG_DEVFS_MOUNT is not set
> # CONFIG_DEVFS_DEBUG is not set
> CONFIG_DEVPTS_FS=y
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_QNX4FS_RW is not set
> # CONFIG_ROMFS_FS is not set
> CONFIG_EXT2_FS=y
> # CONFIG_SYSV_FS is not set
> # CONFIG_SYSV_FS_WRITE is not set
> CONFIG_UDF_FS=m
> # CONFIG_UDF_RW is not set
> # CONFIG_UFS_FS is not set
> # CONFIG_UFS_FS_WRITE is not set
> 
> #
> # Network File Systems
> #
> # CONFIG_CODA_FS is not set
> CONFIG_NFS_FS=m
> CONFIG_NFS_V3=y
> # CONFIG_ROOT_NFS is not set
> # CONFIG_NFSD is not set
> # CONFIG_NFSD_V3 is not set
> CONFIG_SUNRPC=m
> CONFIG_LOCKD=m
> CONFIG_LOCKD_V4=y
> CONFIG_SMB_FS=m
> # CONFIG_SMB_NLS_DEFAULT is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_NCPFS_PACKET_SIGNING is not set
> # CONFIG_NCPFS_IOCTL_LOCKING is not set
> # CONFIG_NCPFS_STRONG is not set
> # CONFIG_NCPFS_NFS_NS is not set
> # CONFIG_NCPFS_OS2_NS is not set
> # CONFIG_NCPFS_SMALLDOS is not set
> # CONFIG_NCPFS_NLS is not set
> # CONFIG_NCPFS_EXTRAS is not set
> 
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=y
> CONFIG_SMB_NLS=y
> CONFIG_NLS=y
> 
> #
> # Native Language Support
> #
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_NLS_CODEPAGE_437=m
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> CONFIG_NLS_CODEPAGE_850=m
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> CONFIG_NLS_ISO8859_1=m
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> CONFIG_NLS_ISO8859_15=m
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> CONFIG_NLS_UTF8=m
> 
> #
> # Console drivers
> #
> CONFIG_VGA_CONSOLE=y
> CONFIG_VIDEO_SELECT=y
> # CONFIG_MDA_CONSOLE is not set
> 
> #
> # Frame-buffer support
> #
> # CONFIG_FB is not set
> 
> #
> # Sound
> #
> CONFIG_SOUND=y
> # CONFIG_SOUND_CMPCI is not set
> # CONFIG_SOUND_EMU10K1 is not set
> # CONFIG_SOUND_FUSION is not set
> # CONFIG_SOUND_CS4281 is not set
> # CONFIG_SOUND_ES1370 is not set
> # CONFIG_SOUND_ES1371 is not set
> # CONFIG_SOUND_ESSSOLO1 is not set
> # CONFIG_SOUND_MAESTRO is not set
> # CONFIG_SOUND_MAESTRO3 is not set
> # CONFIG_SOUND_ICH is not set
> # CONFIG_SOUND_SONICVIBES is not set
> # CONFIG_SOUND_TRIDENT is not set
> # CONFIG_SOUND_MSNDCLAS is not set
> # CONFIG_SOUND_MSNDPIN is not set
> # CONFIG_SOUND_VIA82CXXX is not set
> CONFIG_SOUND_OSS=y
> CONFIG_SOUND_TRACEINIT=y
> CONFIG_SOUND_DMAP=y
> # CONFIG_SOUND_AD1816 is not set
> # CONFIG_SOUND_SGALAXY is not set
> # CONFIG_SOUND_ADLIB is not set
> # CONFIG_SOUND_ACI_MIXER is not set
> # CONFIG_SOUND_CS4232 is not set
> # CONFIG_SOUND_SSCAPE is not set
> # CONFIG_SOUND_GUS is not set
> CONFIG_SOUND_VMIDI=y
> # CONFIG_SOUND_TRIX is not set
> # CONFIG_SOUND_MSS is not set
> # CONFIG_SOUND_MPU401 is not set
> # CONFIG_SOUND_NM256 is not set
> # CONFIG_SOUND_MAD16 is not set
> # CONFIG_SOUND_PAS is not set
> # CONFIG_PAS_JOYSTICK is not set
> # CONFIG_SOUND_PSS is not set
> CONFIG_SOUND_SB=y
> CONFIG_SOUND_AWE32_SYNTH=y
> # CONFIG_SOUND_WAVEFRONT is not set
> # CONFIG_SOUND_MAUI is not set
> CONFIG_SOUND_YM3812=m
> # CONFIG_SOUND_OPL3SA1 is not set
> # CONFIG_SOUND_OPL3SA2 is not set
> # CONFIG_SOUND_YMFPCI is not set
> # CONFIG_SOUND_YMFPCI_LEGACY is not set
> # CONFIG_SOUND_UART6850 is not set
> # CONFIG_SOUND_AEDSP16 is not set
> # CONFIG_SOUND_TVMIXER is not set
> 
> #
> # USB support
> #
> # CONFIG_USB is not set
> 
> #
> # Kernel hacking
> #
> CONFIG_DEBUG_KERNEL=y
> # CONFIG_DEBUG_SLAB is not set
> # CONFIG_DEBUG_IOVIRT is not set
> CONFIG_MAGIC_SYSRQ=y
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_BUGVERBOSE is not set


-- 
Vojtech Pavlik
SuSE Labs
