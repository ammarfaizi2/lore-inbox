Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbUBHLG6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 06:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbUBHLG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 06:06:57 -0500
Received: from maverick.eskuel.net ([81.56.212.215]:8939 "EHLO
	maverick.eskuel.net") by vger.kernel.org with ESMTP id S263325AbUBHLGB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 06:06:01 -0500
Message-ID: <40261814.1020407@eskuel.net>
Date: Sun, 08 Feb 2004 12:05:56 +0100
From: Mathieu LESNIAK <maverick@eskuel.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Kernel Oops
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060905050106090004090806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060905050106090004090806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi !

I've got this kernel oops with 2.6.3-rc1 when I remove an usb 
peripheral. The result is the same if USB UHCI is compiled statically or 
in module.
Please find in attachment the output of lspci and .config

Best regards,

Mathieu LESNIAK


Feb  8 11:54:35 athlon kernel: Linux version 2.6.3-rc1 (root@athlon) 
(version gcc 3.3.3 20040125 (prerelease) (Debian)) #3 Sun Feb 8 11:11:53 
CET 2004


Feb  8 11:55:39 athlon kernel: usb 2-2: USB disconnect, address 2
Feb  8 11:55:39 athlon kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 0000001e
Feb  8 11:55:39 athlon kernel:  printing eip:
Feb  8 11:55:39 athlon kernel: c030631c
Feb  8 11:55:39 athlon kernel: *pde = 00000000
Feb  8 11:55:39 athlon kernel: Oops: 0000 [#1]
Feb  8 11:55:39 athlon kernel: CPU:    0
Feb  8 11:55:39 athlon kernel: EIP:    0060:[disconnect_scanner+44/105] 
    Tainted: PF
Feb  8 11:55:39 athlon kernel: EFLAGS: 00010282
Feb  8 11:55:39 athlon kernel: EIP is at disconnect_scanner+0x2c/0x69
Feb  8 11:55:39 athlon kernel: eax: c166ac80   ebx: c166ac94   ecx: 
c03062f0   edx: dfd35c00
Feb  8 11:55:39 athlon kernel: esi: 00000000   edi: dfd7cf28   ebp: 
c04a723c   esp: dfddde50
Feb  8 11:55:39 athlon kernel: ds: 007b   es: 007b   ss: 0068
Feb  8 11:55:39 athlon kernel: Process khubd (pid: 5, 
threadinfo=dfddc000 task=dff90080)
Feb  8 11:55:39 athlon kernel: Stack: c166ac80 c04a72b8 c166ac80 
c04a7320 c02dd7db c166ac80 c166ac80 c166acc0
Feb  8 11:55:39 athlon kernel:        c166ac94 c04a7340 c027ce54 
c166ac94 c166acc0 dfd7cf3c dfd7cf00 c0305c9f
Feb  8 11:55:39 athlon kernel:        c166ac94 c166ac80 dfd7cf3c 
c04a724c 00000000 00000000 c0229c78 dfd7cf3c
Feb  8 11:55:39 athlon kernel: Call Trace:
Feb  8 11:55:39 athlon kernel:  [usb_unbind_interface+123/128] 
usb_unbind_interface+0x7b/0x80
Feb  8 11:55:39 athlon kernel:  [device_release_driver+100/112] 
device_release_driver+0x64/0x70
Feb  8 11:55:39 athlon kernel:  [destroy_scanner+79/176] 
destroy_scanner+0x4f/0xb0
Feb  8 11:55:39 athlon kernel:  [kobject_cleanup+152/160] 
kobject_cleanup+0x98/0xa0
Feb  8 11:55:39 athlon kernel:  [usb_unbind_interface+123/128] 
usb_unbind_interface+0x7b/0x80
Feb  8 11:55:39 athlon kernel:  [device_release_driver+100/112] 
device_release_driver+0x64/0x70
Feb  8 11:55:39 athlon kernel:  [bus_remove_device+85/160] 
bus_remove_device+0x55/0xa0
Feb  8 11:55:39 athlon kernel:  [device_del+93/160] device_del+0x5d/0xa0
Feb  8 11:55:39 athlon kernel:  [usb_disable_device+112/176] 
usb_disable_device+0x70/0xb0
Feb  8 11:55:39 athlon kernel:  [usb_disconnect+150/240] 
usb_disconnect+0x96/0xf0
Feb  8 11:55:39 athlon kernel:  [hub_port_connect_change+783/800] 
hub_port_connect_change+0x30f/0x320
Feb  8 11:55:39 athlon kernel:  [hub_port_status+67/176] 
hub_port_status+0x43/0xb0
Feb  8 11:55:39 athlon kernel:  [hub_events+714/832] hub_events+0x2ca/0x340
Feb  8 11:55:39 athlon kernel:  [hub_thread+45/240] hub_thread+0x2d/0xf0
Feb  8 11:55:39 athlon kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
Feb  8 11:55:39 athlon kernel:  [default_wake_function+0/32] 
default_wake_function+0x0/0x20
Feb  8 11:55:39 athlon kernel:  [hub_thread+0/240] hub_thread+0x0/0xf0
Feb  8 11:55:39 athlon kernel:  [kernel_thread_helper+5/12] 
kernel_thread_helper+0x5/0xc
Feb  8 11:55:39 athlon kernel:
Feb  8 11:55:39 athlon kernel: Code: 80 7e 1e 00 75 2a 85 f6 74 1a 8d 46 
3c 8b 5c 24 08 8b 74 24

--------------060905050106090004090806
Content-Type: text/plain;
 name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci"

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System Controller (rev 13)
	Flags: bus master, medium devsel, latency 32
	Memory at e8000000 (32-bit, prefetchable) [size=64M]
	Memory at f7000000 (32-bit, prefetchable) [size=4K]
	I/O ports at d000 [disabled] [size=4]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] AGP Bridge (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	Memory behind bridge: f4000000-f5ffffff
	Prefetchable memory behind bridge: ec000000-f3ffffff

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: ABIT Computer Corp. KG7-Lite Mainboard
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: <available only to root>

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
	Flags: bus master, medium devsel, latency 32
	I/O ports at d400 [size=16]
	Capabilities: <available only to root>

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at d800 [size=32]
	Capabilities: <available only to root>

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at dc00 [size=32]
	Capabilities: <available only to root>

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Flags: medium devsel, IRQ 11
	Capabilities: <available only to root>

00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
	Subsystem: Creative Labs CT4830 SBLive! Value
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at e000 [size=32]
	Capabilities: <available only to root>

00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Flags: bus master, medium devsel, latency 32
	I/O ports at e400 [size=8]
	Capabilities: <available only to root>

00:0b.0 SCSI storage controller: Advanced Micro Devices [AMD] 53c974 [PCscsi] (rev 10)
	Flags: bus master, stepping, medium devsel, latency 32, IRQ 11
	I/O ports at e800 [size=128]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0d.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
	Subsystem: Netgear FA310TX
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at ec00 [size=256]
	Memory at f7001000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=256K]

01:05.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti 4200] (rev a3) (prog-if 00 [VGA])
	Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 5
	Memory at f4000000 (32-bit, non-prefetchable) [size=16M]
	Memory at ec000000 (32-bit, prefetchable) [size=64M]
	Memory at f0000000 (32-bit, prefetchable) [size=512K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>


--------------060905050106090004090806
Content-Type: text/plain;
 name="config-2.6.3-rc1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config-2.6.3-rc1"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_HPET_TIMER=y
# CONFIG_HPET_EMULATE_RTC is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
CONFIG_EDD=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_MATH_EMULATION=y
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_DISK=y
CONFIG_PM_DISK_PARTITION="/dev/hda2"

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_RELAXED_AML=y

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_USE_VECTOR is not set
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_FW_LOADER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_OTHER=y
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=y
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_OFFBOARD=y
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
CONFIG_BLK_DEV_HPT366=y
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_IVB=y
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
# CONFIG_SCSI_REPORT_LUNS is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX_CONFIG=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
CONFIG_SCSI_DC390T=y
# CONFIG_SCSI_DC390T_NOGENSUPP is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
# CONFIG_MD_RAID6 is not set
CONFIG_MD_MULTIPATH=m
# CONFIG_BLK_DEV_DM is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Macintosh device drivers
#

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_ARPD=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
CONFIG_IPV6=m
# CONFIG_IPV6_PRIVACY is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
# CONFIG_IP_NF_CONNTRACK is not set
# CONFIG_IP_NF_QUEUE is not set
# CONFIG_IP_NF_IPTABLES is not set
# CONFIG_IP_NF_ARPTABLES is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set

#
# IPv6: Netfilter Configuration
#
# CONFIG_IP6_NF_QUEUE is not set
# CONFIG_IP6_NF_IPTABLES is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=m
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
# CONFIG_DE2104X is not set
CONFIG_TULIP=y
CONFIG_TULIP_MWI=y
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
# CONFIG_DE4X5 is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_DM9102 is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_MPPE_MPPC=m
CONFIG_PPPOE=m
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_UINPUT=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=m
CONFIG_SERIAL_8250_ACPI=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_MULTIPORT is not set
# CONFIG_SERIAL_8250_RSA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
CONFIG_GEN_RTC=m
CONFIG_GEN_RTC_X=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
CONFIG_AGP_AMD=y
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=y
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HANGCHECK_TIMER=y

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m

#
# I2C Hardware Bus support
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_ELV=m
CONFIG_I2C_I801=m
CONFIG_I2C_I810=m
CONFIG_I2C_ISA=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_PROSAVAGE=m
CONFIG_I2C_SAVAGE4=m
CONFIG_SCx200_ACB=m
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VELLEMAN=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
CONFIG_I2C_VOODOO3=m

#
# I2C Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_EEPROM=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83L785TS=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=y

#
# Video For Linux
#

#
# Video Adapters
#
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_BWQCAM is not set
CONFIG_VIDEO_CQCAM=m
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_CX88 is not set

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_AD1816A is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES968 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_DT019X is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
CONFIG_SND_EMU10K1=y
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_UHCI_HCD=y

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=y
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
CONFIG_USB_SCANNER=y
# CONFIG_USB_MICROTEK is not set
CONFIG_USB_HPUSBSCSI=y

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_STV680 is not set
# CONFIG_USB_W9968CF is not set

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=y
# CONFIG_USB_SERIAL_DEBUG is not set
# CONFIG_USB_SERIAL_CONSOLE is not set
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
CONFIG_USB_SERIAL_VISOR=m
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_TEST is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
# CONFIG_NFSD is not set
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
# CONFIG_EXPORTFS is not set
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp850"
CONFIG_CIFS=m
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-15"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
CONFIG_SECURITY=y
# CONFIG_SECURITY_NETWORK is not set
CONFIG_SECURITY_CAPABILITIES=y
# CONFIG_SECURITY_ROOTPLUG is not set
# CONFIG_SECURITY_SELINUX is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--------------060905050106090004090806--
