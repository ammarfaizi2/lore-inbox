Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269510AbTGXXQo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 19:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271822AbTGXXQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 19:16:19 -0400
Received: from 69.Red-217-126-207.pooles.rima-tde.net ([217.126.207.69]:34053
	"EHLO server01.nullzone.prv") by vger.kernel.org with ESMTP
	id S271817AbTGXXLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 19:11:52 -0400
Message-Id: <5.2.1.1.2.20030725010023.029c4ba8@192.168.2.130>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Fri, 25 Jul 2003 01:27:13 +0200
To: linux-kernel@vger.kernel.org
From: system_lists@nullzone.org
Subject: NEW crash - DMA disabled - lost interrupt - timeout waiting
  for DMA - ??
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi again,

    i had posted any days ago a mail with some problem of IRQ and DMA on a 
SiI860 chipset IDE controler with 4 HD of 120GB.

I got the problem back (all the Raid5 was down and i have lost all the 
information (i had a backup ... i did one with the important before this 
last crash)... I got the ReiserFS partition irrecuperable).

I think could be posible that it has some relation with other mails i have 
read here with similar problems of DMA timeouts, IRQ lost... etc (For 
example one:

Date:	Thu, 24 Jul 2003 20:36:14 +0300 (EEST)
From:	Meelis Roos <mroos@linux.ee>

).

I will post the information again (Alan, thanks for the other reply, do you 
want I test/do anything? what is the version of the kernel where you have 
fixed some bugs with this chipset as you said in the other email?):

- Kernel: 2.4.21
- IDE controler:

SiI680: IDE controller at PCI slot 00:09.0
PCI: Found IRQ 11 for device 00:09.0
SiI680: chipset revision 2
SiI680: not 100%% native mode: will probe irqs later
SiI680: BASE CLOCK == 100
     ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
     ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio

- ACPI: off
- System up: 4 days (usualy the problems come over 10-20 days up but i 
cannot do a real media about this, i have got problems (after a reset) from 
1 day up and nothing along a month...)

- Down you can see_
    1- log of crash
    2- .conf of kernel compilation
    3- full dmesg

-----
Jul 24 18:25:26 server01 kernel: hdf: dma_timer_expiry: dma status == 0x60
Jul 24 18:25:26 server01 kernel: hdf: timeout waiting for DMA
Jul 24 18:25:26 server01 kernel: hdf: timeout waiting for DMA
Jul 24 18:25:46 server01 kernel: hde: dma_timer_expiry: dma status == 0x21
Jul 24 18:25:56 server01 kernel: hde: timeout waiting for DMA
Jul 24 18:25:56 server01 kernel: hde: timeout waiting for DMA
Jul 24 18:25:56 server01 kernel: blk: queue c02c8f54, I/O limit 4095Mb 
(mask 0xffffffff)
Jul 24 18:25:56 server01 kernel: hdf: status error: status=0x5a { 
DriveReady SeekComplete DataRequest Index }
Jul 24 18:25:56 server01 kernel:
Jul 24 18:25:56 server01 kernel: hdf: drive not ready for command
Jul 24 18:25:56 server01 kernel: hdf: status error: status=0x5a { 
DriveReady SeekComplete DataRequest Index }
Jul 24 18:25:56 server01 kernel:
Jul 24 18:25:56 server01 kernel: hdf: drive not ready for command
Jul 24 18:25:56 server01 kernel: hdf: status error: status=0x5a { 
DriveReady SeekComplete DataRequest Index }
Jul 24 18:25:56 server01 kernel:
Jul 24 18:25:56 server01 kernel: hdf: drive not ready for command
Jul 24 18:25:56 server01 kernel: hdf: status error: status=0x5a { 
DriveReady SeekComplete DataRequest Index }
Jul 24 18:25:56 server01 kernel:
Jul 24 18:25:56 server01 kernel: hdf: DMA disabled
Jul 24 18:25:56 server01 kernel: hdf: drive not ready for command
Jul 24 18:25:56 server01 kernel: ide2: reset: success
Jul 24 18:25:56 server01 kernel: blk: queue c02c8e08, I/O limit 4095Mb 
(mask 0xffffffff)
Jul 24 18:26:16 server01 kernel: hde: dma_timer_expiry: dma status == 0x21
Jul 24 18:26:26 server01 kernel: hde: timeout waiting for DMA
Jul 24 18:26:26 server01 kernel: hde: timeout waiting for DMA
Jul 24 18:26:26 server01 kernel: hdf: status error: status=0x00 { }
Jul 24 18:26:26 server01 kernel:
Jul 24 18:26:26 server01 kernel: hdf: drive not ready for command
Jul 24 18:26:26 server01 kernel: hdf: status error: status=0x5d { 
DriveReady SeekComplete DataRequest CorrectedError Erro
r }
Jul 24 18:26:26 server01 kernel: hdf: status error: error=0x1d { 
DriveStatusError SectorIdNotFound AddrMarkNotFound }, LB
Asect=8796099124245, high=524288, low=6102037, sector=45171720
Jul 24 18:26:26 server01 kernel: hdf: drive not ready for command
Jul 24 18:26:26 server01 kernel: hdf: status error: status=0x5d { 
DriveReady SeekComplete DataRequest CorrectedError Erro
r }
Jul 24 18:26:26 server01 kernel: hdf: status error: error=0x5d { 
DriveStatusError UncorrectableError SectorIdNotFound Add
rMarkNotFound }, LBAsect=8796094922752, high=524288, low=1900544, 
sector=45171720
Jul 24 18:26:26 server01 kernel: end_request: I/O error, dev 21:41 (hdf), 
sector 45171720
Jul 24 18:26:26 server01 kernel: raid5: Disk failure on hdf1, disabling 
device. Operation continuing on 3 devices
Jul 24 18:26:26 server01 kernel: hdf: drive not ready for command
Jul 24 18:26:26 server01 kernel: md: updating md0 RAID superblock on device
Jul 24 18:26:26 server01 kernel: md: (skipping faulty hdf1 )
Jul 24 18:26:26 server01 kernel: md: hdh1 [events: 00000016]<6>(write) 
hdh1's sb offset: 117218176
Jul 24 18:26:26 server01 kernel: md: hdg1 [events: 00000016]<6>(write) 
hdg1's sb offset: 117218176
Jul 24 18:26:26 server01 kernel: md: hde1 [events: 00000016]<6>(write) 
hde1's sb offset: 117218176
Jul 24 18:26:26 server01 kernel: md: recovery thread got woken up ...
Jul 24 18:26:26 server01 kernel: md0: no spare disk to reconstruct array! 
-- continuing in degraded mode
Jul 24 18:26:26 server01 kernel: md: recovery thread finished ...
Jul 24 18:26:27 server01 kernel: hde: status error: status=0xe0 { Busy }
Jul 24 18:26:27 server01 kernel:
Jul 24 18:26:27 server01 kernel: hde: drive not ready for command
Jul 24 18:26:27 server01 kernel: ide2: reset: success
Jul 24 18:26:47 server01 kernel: hde: dma_timer_expiry: dma status == 0x21
Jul 24 18:26:57 server01 kernel: hde: timeout waiting for DMA
Jul 24 18:26:57 server01 kernel: hde: timeout waiting for DMA
Jul 24 18:26:57 server01 kernel: hde: status error: status=0x58 { 
DriveReady SeekComplete DataRequest }
Jul 24 18:26:57 server01 kernel:
Jul 24 18:26:57 server01 kernel: hde: drive not ready for command
Jul 24 18:26:57 server01 kernel: hde: status timeout: status=0xd0 { Busy }
Jul 24 18:26:57 server01 kernel:
Jul 24 18:26:57 server01 kernel: hde: no DRQ after issuing WRITE
Jul 24 18:26:57 server01 kernel: ide2: reset: success
Jul 24 18:27:17 server01 kernel: hde: dma_timer_expiry: dma status == 0x21
Jul 24 18:27:27 server01 kernel: hde: timeout waiting for DMA
Jul 24 18:27:27 server01 kernel: hde: timeout waiting for DMA
Jul 24 18:27:27 server01 kernel: hde: status error: status=0x00 { }
Jul 24 18:27:27 server01 kernel:
Jul 24 18:27:27 server01 kernel: hde: drive not ready for command
Jul 24 18:50:14 server01 kernel: hde: lost interrupt
Jul 24 18:50:24 server01 kernel: hdh: dma_timer_expiry: dma status == 0x61
Jul 24 18:50:24 server01 kernel: hde: lost interrupt
Jul 24 18:50:34 server01 kernel: hdh: timeout waiting for DMA
Jul 24 18:50:34 server01 kernel: hdh: timeout waiting for DMA
Jul 24 18:50:34 server01 kernel: hdh: read_intr: status=0x51 { DriveReady 
SeekComplete Error }
Jul 24 18:50:34 server01 kernel: hdh: read_intr: error=0x04 { 
DriveStatusError }
Jul 24 18:50:34 server01 kernel: hdh: read_intr: status=0x51 { DriveReady 
SeekComplete Error }
Jul 24 18:50:34 server01 kernel: hdh: read_intr: error=0x04 { 
DriveStatusError }
Jul 24 18:50:34 server01 kernel: hdh: read_intr: status=0x51 { DriveReady 
SeekComplete Error }
Jul 24 18:50:34 server01 kernel: hdh: read_intr: error=0x04 { 
DriveStatusError }
Jul 24 18:50:34 server01 kernel: hdh: read_intr: status=0x51 { DriveReady 
SeekComplete Error }
Jul 24 18:50:34 server01 kernel: hdh: read_intr: error=0x04 { 
DriveStatusError }
Jul 24 18:50:34 server01 kernel: hdg: DMA disabled
Jul 24 18:50:35 server01 kernel: ide3: reset: success
Jul 24 18:50:35 server01 kernel: blk: queue c02c93c8, I/O limit 4095Mb 
(mask 0xffffffff)
Jul 24 18:50:45 server01 kernel: hde: lost interrupt
Jul 24 18:50:55 server01 kernel: hdh: dma_timer_expiry: dma status == 0x41
Jul 24 18:50:55 server01 kernel: hde: lost interrupt
Jul 24 18:51:05 server01 kernel: hdh: timeout waiting for DMA
Jul 24 18:51:05 server01 kernel: hdh: timeout waiting for DMA
Jul 24 18:51:05 server01 kernel: hde: lost interrupt
Jul 24 18:51:15 server01 kernel: hde: lost interrupt
Jul 24 18:51:25 server01 kernel: hdh: dma_timer_expiry: dma status == 0x41
Jul 24 18:51:25 server01 kernel: hde: lost interrupt
Jul 24 18:51:35 server01 kernel: hdh: timeout waiting for DMA
Jul 24 18:51:35 server01 kernel: hdh: timeout waiting for DMA
Jul 24 18:51:35 server01 kernel: hdh: status error: status=0x7f { 
DriveReady DeviceFault SeekComplete DataRequest CorrectedError Index Error }
Jul 24 18:51:35 server01 kernel: hdh: status error: error=0x7f { 
DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound 
AddrMarkNotFound }, LBAsect=8831518080895, high=526399, low=8355711, 
sector=168016
Jul 24 18:51:35 server01 kernel: hdh: drive not ready for command
Jul 24 18:51:35 server01 kernel: hde: lost interrupt
Jul 24 18:51:35 server01 kernel: ide3: reset: success
Jul 24 18:51:45 server01 kernel: hde: lost interrupt
Jul 24 18:51:55 server01 kernel: hdh: dma_timer_expiry: dma status == 0x41
Jul 24 18:51:55 server01 kernel: hde: lost interrupt
Jul 24 18:52:05 server01 kernel: hdh: timeout waiting for DMA
Jul 24 18:52:05 server01 kernel: hdh: timeout waiting for DMA
Jul 24 18:52:05 server01 kernel: hdh: status error: status=0x7f { 
DriveReady DeviceFault SeekComplete DataRequest Correct
edError Index Error }
Jul 24 18:52:05 server01 kernel: hdh: status error: error=0x7f { 
DriveStatusError UncorrectableError SectorIdNotFound Tra
ckZeroNotFound AddrMarkNotFound }, LBAsect=8831518080895, high=526399, 
low=8355711, sector=46433352
Jul 24 18:52:05 server01 kernel: hdh: drive not ready for command
Jul 24 18:52:05 server01 kernel: hde: lost interrupt
Jul 24 18:52:06 server01 kernel: ide3: reset: success
Jul 24 18:52:16 server01 kernel: hde: lost interrupt
Jul 24 18:52:56 server01 last message repeated 4 times
Jul 24 18:54:06 server01 last message repeated 7 times
Jul 24 18:55:16 server01 last message repeated 7 times
Jul 24 18:56:26 server01 last message repeated 7 times
Jul 24 18:57:36 server01 last message repeated 7 times
Jul 24 18:58:46 server01 last message repeated 7 times
Jul 24 18:59:56 server01 last message repeated 7 times
Jul 24 19:01:05 server01 last message repeated 6 times
Jul 24 19:02:15 server01 last message repeated 7 times
Jul 24 19:03:25 server01 last message repeated 7 times
Jul 24 19:04:35 server01 last message repeated 7 times
Jul 24 19:05:45 server01 last message repeated 7 times
Jul 24 19:06:55 server01 last message repeated 7 times
Jul 24 19:08:05 server01 last message repeated 7 times
Jul 24 19:09:15 server01 last message repeated 7 times
Jul 24 19:10:25 server01 last message repeated 7 times
Jul 24 19:11:35 server01 last message repeated 7 times
Jul 24 19:12:45 server01 last message repeated 7 times
Jul 24 19:13:55 server01 last message repeated 7 times
Jul 24 19:14:58 server01 last message repeated 6 times
Jul 24 19:16:08 server01 last message repeated 7 times
Jul 24 19:17:18 server01 last message repeated 7 times
Jul 24 19:18:28 server01 last message repeated 7 times
Jul 24 19:19:38 server01 last message repeated 7 times
Jul 24 19:20:48 server01 last message repeated 7 times
Jul 24 19:21:58 server01 last message repeated 7 times
Jul 24 19:23:08 server01 last message repeated 7 times
Jul 24 19:24:09 server01 last message repeated 6 times
Jul 24 19:25:19 server01 last message repeated 7 times

----

CONFIG_X86=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
# CONFIG_KMOD is not set

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_HIGHMEM is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=y

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_ISA is not set
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_HOTPLUG_PCI is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_PM is not set
# CONFIG_ACPI is not set
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
CONFIG_BLK_STATS=y

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
CONFIG_MD_RAID5=y
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
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
#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_ADMA100 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_SVWKS is not set
CONFIG_BLK_DEV_SIIMAGE=y
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set
# CONFIG_BLK_DEV_ATARAID_SII is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
# CONFIG_EEPRO100 is not set
# CONFIG_EEPRO100_PIO is not set
# CONFIG_E100 is not set
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
CONFIG_NE2K_PCI=y
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_SUNDANCE_MMIO is not set
# CONFIG_TLAN is not set
# CONFIG_TC35815 is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
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
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Input core support
#
# CONFIG_INPUT is not set
# CONFIG_INPUT_KEYBDEV is not set
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_QIC02_TAPE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
# CONFIG_IPMI_KCS is not set
# CONFIG_IPMI_WATCHDOG is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_SCx200_GPIO is not set
# CONFIG_AMD_RNG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_AMD_PM768 is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
CONFIG_AGP_VIA=y
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_8151 is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
# CONFIG_ISO9660_FS is not set
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_NFS_FS is not set
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_ZISOFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_SMB_NLS is not set
# CONFIG_NLS is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set

#
# Library routines
#
# CONFIG_ZLIB_INFLATE is not set
# CONFIG_ZLIB_DEFLATE is not set

------------------------------------------------------------------

Linux version 2.4.21 (root@server01) (gcc version 2.95.4) #6 Sat Jul 5 
12:23:04 CEST 2003
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
128MB LOWMEM available.
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=2.4.21 ro root=304
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1002.301 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1998.84 BogoMIPS
Memory: 127380k/131072k available (1077k kernel code, 3308k reserved, 300k 
data, 260k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel Celeron (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1002.2946 MHz.
..... host bus clock speed is 100.2292 MHz.
cpu: 0, clocks: 1002292, slice: 501146
CPU0<T0:1002288,T1:501136,D:6,S:501146,C:1002292>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb020, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI: Disabling Via external APIC routing
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI enabled
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
   http://www.scyld.com/network/ne2k-pci.html
PCI: Found IRQ 10 for device 00:0b.0
eth0: RealTek RTL-8029 found at 0xc400, IRQ 10, 00:4F:49:05:D8:9C.
8139too Fast Ethernet driver 0.9.26
PCI: Found IRQ 12 for device 00:0a.0
eth1: RealTek RTL8139 Fast Ethernet at 0xc8800000, 00:50:fc:22:9e:14, IRQ 12
eth1:  Identified 8139 chip type 'RTL-8139C'
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 96M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 64M @ 0xd8000000
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 1b) IDE UDMA66 controller on pci00:07.1
     ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:pio
SiI680: IDE controller at PCI slot 00:09.0
PCI: Found IRQ 11 for device 00:09.0
SiI680: chipset revision 2
SiI680: not 100% native mode: will probe irqs later
SiI680: BASE CLOCK == 100
     ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
     ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
hda: FUJITSU MPA3026ATU, ATA DISK drive
blk: queue c02c8520, I/O limit 4095Mb (mask 0xffffffff)
hdc: ST380020A, ATA DISK drive
blk: queue c02c8994, I/O limit 4095Mb (mask 0xffffffff)
hde: IC35L120AVV207-0, ATA DISK drive
hdf: ST3120022A, ATA DISK drive
blk: queue c02c8e08, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c02c8f54, I/O limit 4095Mb (mask 0xffffffff)
hdg: ST3120022A, ATA DISK drive
hdh: ST3120022A, ATA DISK drive
blk: queue c02c927c, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c02c93c8, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xc8818080-0xc8818087,0xc881808a on irq 11
ide3 at 0xc88180c0-0xc88180c7,0xc88180ca on irq 11
hda: attached ide-disk driver.
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: 5126964 sectors (2625 MB), CHS=635/128/63, UDMA(33)
hdc: attached ide-disk driver.
hdc: host protected area => 1
hdc: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(66)
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 241254720 sectors (123522 MB) w/1821KiB Cache, CHS=15017/255/63, UDMA(100)
hdf: attached ide-disk driver.
hdf: host protected area => 1
hdf: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=14593/255/63, UDMA(100)
hdg: attached ide-disk driver.
hdg: host protected area => 1
hdg: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=14593/255/63, UDMA(100)
hdh: attached ide-disk driver.
hdh: host protected area => 1
hdh: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=14593/255/63, UDMA(100)
Partition check:
  hda: hda1 hda2 hda3 hda4
  hdc: hdc1
  hde: hde1
  hdf: hdf1
  hdg: hdg1
  hdh: hdh1
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
    8regs     :  1751.200 MB/sec
    32regs    :  1229.600 MB/sec
    pIII_sse  :  2075.600 MB/sec
    pII_mmx   :  2235.600 MB/sec
    p5_mmx    :  2366.800 MB/sec
raid5: using function: pIII_sse (2075.600 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 260k freed
Adding Swap: 124956k swap-space (priority -1)
Adding Swap: 124988k swap-space (priority -2)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,4), internal journal
  [events: 0000001a]
  [events: 00000019]
  [events: 00000015]

