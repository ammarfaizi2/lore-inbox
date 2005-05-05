Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbVEEKhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbVEEKhY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 06:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVEEKhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 06:37:24 -0400
Received: from portal.cramer.co.uk ([193.130.83.209]:44811 "EHLO
	S2.cramer.co.uk") by vger.kernel.org with ESMTP id S262030AbVEEKeN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 06:34:13 -0400
Message-ID: <3E116F19B784CD47A7CE7F923A436499014C8E35@s2.cramer.co.uk>
From: James Dingwall <james.dingwall@cramer.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Bug: 2.6.11.8 msdos.c
Date: Thu, 5 May 2005 11:33:09 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C5515D.D4EF2D20"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C5515D.D4EF2D20
Content-Type: text/plain

Using vanilla 2.6.11.8 I get a "Cannot open initial console" on boot,
2.6.11.7 was fine.  I have removed the patches to fs/partitions/msdos.c and
this has fixed my problem.  I've read the discussion on this patch but it
doesn't indicate that this problem may occur so there is no suggested
solution.  I have attached my .config and my partition layout is below, I
can provide any other information that might be useful.  I'm not on the list
so plase Cc, I will follow the thread in the archives too.

James

# fdisk -l /dev/hda

Disk /dev/hda: 30.0 GB, 30020272128 bytes
255 heads, 63 sectors/track, 3649 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hda1   *           1        1797    14434371   83  Linux
/dev/hda2            1798        3649    14876190    5  Extended
/dev/hda5            1798        1860      506016    0  Empty
/dev/hda6            1861        1892      257008+  83  Linux
/dev/hda7            1893        1924      257008+  83  Linux
/dev/hda8            1925        2049     1004031   82  Linux swap / Solaris
/dev/hda9            2050        2112      506016    0  Empty
/dev/hda10           2113        2611     4008186   83  Linux
/dev/hda11           2612        2861     2008093+  83  Linux


------_=_NextPart_000_01C5515D.D4EF2D20
Content-Type: application/octet-stream;
	name="config"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="config"

#=0A=
# Automatically generated make config: don't edit=0A=
# Linux kernel version: 2.6.11.8=0A=
# Wed May  4 11:46:06 2005=0A=
#=0A=
CONFIG_X86=3Dy=0A=
CONFIG_MMU=3Dy=0A=
CONFIG_UID16=3Dy=0A=
CONFIG_GENERIC_ISA_DMA=3Dy=0A=
CONFIG_GENERIC_IOMAP=3Dy=0A=
=0A=
#=0A=
# Code maturity level options=0A=
#=0A=
CONFIG_EXPERIMENTAL=3Dy=0A=
CONFIG_CLEAN_COMPILE=3Dy=0A=
CONFIG_LOCK_KERNEL=3Dy=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
CONFIG_LOCALVERSION=3D""=0A=
CONFIG_SWAP=3Dy=0A=
CONFIG_SYSVIPC=3Dy=0A=
CONFIG_POSIX_MQUEUE=3Dy=0A=
# CONFIG_BSD_PROCESS_ACCT is not set=0A=
CONFIG_SYSCTL=3Dy=0A=
# CONFIG_AUDIT is not set=0A=
CONFIG_LOG_BUF_SHIFT=3D15=0A=
CONFIG_HOTPLUG=3Dy=0A=
CONFIG_KOBJECT_UEVENT=3Dy=0A=
CONFIG_IKCONFIG=3Dy=0A=
CONFIG_IKCONFIG_PROC=3Dy=0A=
# CONFIG_EMBEDDED is not set=0A=
CONFIG_KALLSYMS=3Dy=0A=
# CONFIG_KALLSYMS_EXTRA_PASS is not set=0A=
CONFIG_FUTEX=3Dy=0A=
CONFIG_EPOLL=3Dy=0A=
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set=0A=
CONFIG_SHMEM=3Dy=0A=
CONFIG_CC_ALIGN_FUNCTIONS=3D0=0A=
CONFIG_CC_ALIGN_LABELS=3D0=0A=
CONFIG_CC_ALIGN_LOOPS=3D0=0A=
CONFIG_CC_ALIGN_JUMPS=3D0=0A=
# CONFIG_TINY_SHMEM is not set=0A=
=0A=
#=0A=
# Loadable module support=0A=
#=0A=
CONFIG_MODULES=3Dy=0A=
CONFIG_MODULE_UNLOAD=3Dy=0A=
# CONFIG_MODULE_FORCE_UNLOAD is not set=0A=
CONFIG_OBSOLETE_MODPARM=3Dy=0A=
# CONFIG_MODVERSIONS is not set=0A=
# CONFIG_MODULE_SRCVERSION_ALL is not set=0A=
CONFIG_KMOD=3Dy=0A=
CONFIG_STOP_MACHINE=3Dy=0A=
=0A=
#=0A=
# Processor type and features=0A=
#=0A=
CONFIG_X86_PC=3Dy=0A=
# CONFIG_X86_ELAN is not set=0A=
# CONFIG_X86_VOYAGER is not set=0A=
# CONFIG_X86_NUMAQ is not set=0A=
# CONFIG_X86_SUMMIT is not set=0A=
# CONFIG_X86_BIGSMP is not set=0A=
# CONFIG_X86_VISWS is not set=0A=
# CONFIG_X86_GENERICARCH is not set=0A=
# CONFIG_X86_ES7000 is not set=0A=
# CONFIG_M386 is not set=0A=
# CONFIG_M486 is not set=0A=
# CONFIG_M586 is not set=0A=
# CONFIG_M586TSC is not set=0A=
# CONFIG_M586MMX is not set=0A=
# CONFIG_M686 is not set=0A=
# CONFIG_MPENTIUMII is not set=0A=
CONFIG_MPENTIUMIII=3Dy=0A=
# CONFIG_MPENTIUMM is not set=0A=
# CONFIG_MPENTIUM4 is not set=0A=
# CONFIG_MK6 is not set=0A=
# CONFIG_MK7 is not set=0A=
# CONFIG_MK8 is not set=0A=
# CONFIG_MCRUSOE is not set=0A=
# CONFIG_MEFFICEON is not set=0A=
# CONFIG_MWINCHIPC6 is not set=0A=
# CONFIG_MWINCHIP2 is not set=0A=
# CONFIG_MWINCHIP3D is not set=0A=
# CONFIG_MCYRIXIII is not set=0A=
# CONFIG_MVIAC3_2 is not set=0A=
# CONFIG_X86_GENERIC is not set=0A=
CONFIG_X86_CMPXCHG=3Dy=0A=
CONFIG_X86_XADD=3Dy=0A=
CONFIG_X86_L1_CACHE_SHIFT=3D5=0A=
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy=0A=
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy=0A=
CONFIG_X86_WP_WORKS_OK=3Dy=0A=
CONFIG_X86_INVLPG=3Dy=0A=
CONFIG_X86_BSWAP=3Dy=0A=
CONFIG_X86_POPAD_OK=3Dy=0A=
CONFIG_X86_GOOD_APIC=3Dy=0A=
CONFIG_X86_INTEL_USERCOPY=3Dy=0A=
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy=0A=
CONFIG_HPET_TIMER=3Dy=0A=
CONFIG_HPET_EMULATE_RTC=3Dy=0A=
CONFIG_SMP=3Dy=0A=
CONFIG_NR_CPUS=3D8=0A=
# CONFIG_SCHED_SMT is not set=0A=
CONFIG_PREEMPT=3Dy=0A=
CONFIG_PREEMPT_BKL=3Dy=0A=
CONFIG_X86_LOCAL_APIC=3Dy=0A=
CONFIG_X86_IO_APIC=3Dy=0A=
CONFIG_X86_TSC=3Dy=0A=
CONFIG_X86_MCE=3Dy=0A=
# CONFIG_X86_MCE_NONFATAL is not set=0A=
# CONFIG_X86_MCE_P4THERMAL is not set=0A=
# CONFIG_TOSHIBA is not set=0A=
# CONFIG_I8K is not set=0A=
CONFIG_MICROCODE=3Dy=0A=
CONFIG_X86_MSR=3Dy=0A=
CONFIG_X86_CPUID=3Dy=0A=
=0A=
#=0A=
# Firmware Drivers=0A=
#=0A=
# CONFIG_EDD is not set=0A=
CONFIG_NOHIGHMEM=3Dy=0A=
# CONFIG_HIGHMEM4G is not set=0A=
# CONFIG_HIGHMEM64G is not set=0A=
# CONFIG_MATH_EMULATION is not set=0A=
CONFIG_MTRR=3Dy=0A=
# CONFIG_EFI is not set=0A=
CONFIG_IRQBALANCE=3Dy=0A=
CONFIG_HAVE_DEC_LOCK=3Dy=0A=
# CONFIG_REGPARM is not set=0A=
=0A=
#=0A=
# Power management options (ACPI, APM)=0A=
#=0A=
CONFIG_PM=3Dy=0A=
# CONFIG_PM_DEBUG is not set=0A=
# CONFIG_SOFTWARE_SUSPEND is not set=0A=
=0A=
#=0A=
# ACPI (Advanced Configuration and Power Interface) Support=0A=
#=0A=
CONFIG_ACPI=3Dy=0A=
CONFIG_ACPI_BOOT=3Dy=0A=
CONFIG_ACPI_INTERPRETER=3Dy=0A=
# CONFIG_ACPI_SLEEP is not set=0A=
CONFIG_ACPI_AC=3Dy=0A=
CONFIG_ACPI_BATTERY=3Dy=0A=
CONFIG_ACPI_BUTTON=3Dy=0A=
CONFIG_ACPI_VIDEO=3Dm=0A=
CONFIG_ACPI_FAN=3Dy=0A=
CONFIG_ACPI_PROCESSOR=3Dy=0A=
CONFIG_ACPI_THERMAL=3Dy=0A=
# CONFIG_ACPI_ASUS is not set=0A=
# CONFIG_ACPI_IBM is not set=0A=
# CONFIG_ACPI_TOSHIBA is not set=0A=
CONFIG_ACPI_BLACKLIST_YEAR=3D0=0A=
# CONFIG_ACPI_DEBUG is not set=0A=
CONFIG_ACPI_BUS=3Dy=0A=
CONFIG_ACPI_EC=3Dy=0A=
CONFIG_ACPI_POWER=3Dy=0A=
CONFIG_ACPI_PCI=3Dy=0A=
CONFIG_ACPI_SYSTEM=3Dy=0A=
# CONFIG_X86_PM_TIMER is not set=0A=
# CONFIG_ACPI_CONTAINER is not set=0A=
=0A=
#=0A=
# APM (Advanced Power Management) BIOS Support=0A=
#=0A=
# CONFIG_APM is not set=0A=
=0A=
#=0A=
# CPU Frequency scaling=0A=
#=0A=
# CONFIG_CPU_FREQ is not set=0A=
=0A=
#=0A=
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)=0A=
#=0A=
CONFIG_PCI=3Dy=0A=
# CONFIG_PCI_GOBIOS is not set=0A=
# CONFIG_PCI_GOMMCONFIG is not set=0A=
# CONFIG_PCI_GODIRECT is not set=0A=
CONFIG_PCI_GOANY=3Dy=0A=
CONFIG_PCI_BIOS=3Dy=0A=
CONFIG_PCI_DIRECT=3Dy=0A=
CONFIG_PCI_MMCONFIG=3Dy=0A=
# CONFIG_PCIEPORTBUS is not set=0A=
# CONFIG_PCI_MSI is not set=0A=
CONFIG_PCI_LEGACY_PROC=3Dy=0A=
CONFIG_PCI_NAMES=3Dy=0A=
# CONFIG_ISA is not set=0A=
# CONFIG_MCA is not set=0A=
# CONFIG_SCx200 is not set=0A=
=0A=
#=0A=
# PCCARD (PCMCIA/CardBus) support=0A=
#=0A=
# CONFIG_PCCARD is not set=0A=
=0A=
#=0A=
# PC-card bridges=0A=
#=0A=
=0A=
#=0A=
# PCI Hotplug Support=0A=
#=0A=
# CONFIG_HOTPLUG_PCI is not set=0A=
=0A=
#=0A=
# Executable file formats=0A=
#=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
# CONFIG_BINFMT_AOUT is not set=0A=
CONFIG_BINFMT_MISC=3Dy=0A=
=0A=
#=0A=
# Device Drivers=0A=
#=0A=
=0A=
#=0A=
# Generic Driver Options=0A=
#=0A=
CONFIG_STANDALONE=3Dy=0A=
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy=0A=
# CONFIG_FW_LOADER is not set=0A=
=0A=
#=0A=
# Memory Technology Devices (MTD)=0A=
#=0A=
# CONFIG_MTD is not set=0A=
=0A=
#=0A=
# Parallel port support=0A=
#=0A=
CONFIG_PARPORT=3Dy=0A=
CONFIG_PARPORT_PC=3Dy=0A=
CONFIG_PARPORT_PC_CML1=3Dy=0A=
# CONFIG_PARPORT_SERIAL is not set=0A=
CONFIG_PARPORT_PC_FIFO=3Dy=0A=
# CONFIG_PARPORT_PC_SUPERIO is not set=0A=
# CONFIG_PARPORT_OTHER is not set=0A=
CONFIG_PARPORT_1284=3Dy=0A=
=0A=
#=0A=
# Plug and Play support=0A=
#=0A=
# CONFIG_PNP is not set=0A=
=0A=
#=0A=
# Block devices=0A=
#=0A=
CONFIG_BLK_DEV_FD=3Dy=0A=
# CONFIG_PARIDE is not set=0A=
# CONFIG_BLK_CPQ_DA is not set=0A=
# CONFIG_BLK_CPQ_CISS_DA is not set=0A=
# CONFIG_BLK_DEV_DAC960 is not set=0A=
# CONFIG_BLK_DEV_UMEM is not set=0A=
# CONFIG_BLK_DEV_COW_COMMON is not set=0A=
CONFIG_BLK_DEV_LOOP=3Dy=0A=
CONFIG_BLK_DEV_CRYPTOLOOP=3Dy=0A=
# CONFIG_BLK_DEV_NBD is not set=0A=
# CONFIG_BLK_DEV_SX8 is not set=0A=
CONFIG_BLK_DEV_UB=3Dy=0A=
# CONFIG_BLK_DEV_RAM is not set=0A=
CONFIG_BLK_DEV_RAM_COUNT=3D16=0A=
CONFIG_INITRAMFS_SOURCE=3D""=0A=
# CONFIG_LBD is not set=0A=
CONFIG_CDROM_PKTCDVD=3Dm=0A=
CONFIG_CDROM_PKTCDVD_BUFFERS=3D8=0A=
# CONFIG_CDROM_PKTCDVD_WCACHE is not set=0A=
=0A=
#=0A=
# IO Schedulers=0A=
#=0A=
CONFIG_IOSCHED_NOOP=3Dy=0A=
CONFIG_IOSCHED_AS=3Dy=0A=
CONFIG_IOSCHED_DEADLINE=3Dy=0A=
CONFIG_IOSCHED_CFQ=3Dy=0A=
# CONFIG_ATA_OVER_ETH is not set=0A=
=0A=
#=0A=
# ATA/ATAPI/MFM/RLL support=0A=
#=0A=
CONFIG_IDE=3Dy=0A=
CONFIG_BLK_DEV_IDE=3Dy=0A=
=0A=
#=0A=
# Please see Documentation/ide.txt for help/info on IDE drives=0A=
#=0A=
# CONFIG_BLK_DEV_IDE_SATA is not set=0A=
# CONFIG_BLK_DEV_HD_IDE is not set=0A=
CONFIG_BLK_DEV_IDEDISK=3Dy=0A=
CONFIG_IDEDISK_MULTI_MODE=3Dy=0A=
CONFIG_BLK_DEV_IDECD=3Dy=0A=
# CONFIG_BLK_DEV_IDETAPE is not set=0A=
# CONFIG_BLK_DEV_IDEFLOPPY is not set=0A=
CONFIG_BLK_DEV_IDESCSI=3Dy=0A=
# CONFIG_IDE_TASK_IOCTL is not set=0A=
=0A=
#=0A=
# IDE chipset support/bugfixes=0A=
#=0A=
CONFIG_IDE_GENERIC=3Dy=0A=
CONFIG_BLK_DEV_CMD640=3Dy=0A=
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set=0A=
CONFIG_BLK_DEV_IDEPCI=3Dy=0A=
CONFIG_IDEPCI_SHARE_IRQ=3Dy=0A=
# CONFIG_BLK_DEV_OFFBOARD is not set=0A=
CONFIG_BLK_DEV_GENERIC=3Dy=0A=
# CONFIG_BLK_DEV_OPTI621 is not set=0A=
CONFIG_BLK_DEV_RZ1000=3Dy=0A=
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy=0A=
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set=0A=
CONFIG_IDEDMA_PCI_AUTO=3Dy=0A=
# CONFIG_IDEDMA_ONLYDISK is not set=0A=
# CONFIG_BLK_DEV_AEC62XX is not set=0A=
# CONFIG_BLK_DEV_ALI15X3 is not set=0A=
# CONFIG_BLK_DEV_AMD74XX is not set=0A=
# CONFIG_BLK_DEV_ATIIXP is not set=0A=
# CONFIG_BLK_DEV_CMD64X is not set=0A=
# CONFIG_BLK_DEV_TRIFLEX is not set=0A=
# CONFIG_BLK_DEV_CY82C693 is not set=0A=
# CONFIG_BLK_DEV_CS5520 is not set=0A=
# CONFIG_BLK_DEV_CS5530 is not set=0A=
# CONFIG_BLK_DEV_HPT34X is not set=0A=
# CONFIG_BLK_DEV_HPT366 is not set=0A=
# CONFIG_BLK_DEV_SC1200 is not set=0A=
CONFIG_BLK_DEV_PIIX=3Dy=0A=
# CONFIG_BLK_DEV_NS87415 is not set=0A=
# CONFIG_BLK_DEV_PDC202XX_OLD is not set=0A=
# CONFIG_BLK_DEV_PDC202XX_NEW is not set=0A=
# CONFIG_BLK_DEV_SVWKS is not set=0A=
# CONFIG_BLK_DEV_SIIMAGE is not set=0A=
# CONFIG_BLK_DEV_SIS5513 is not set=0A=
# CONFIG_BLK_DEV_SLC90E66 is not set=0A=
# CONFIG_BLK_DEV_TRM290 is not set=0A=
# CONFIG_BLK_DEV_VIA82CXXX is not set=0A=
# CONFIG_IDE_ARM is not set=0A=
CONFIG_BLK_DEV_IDEDMA=3Dy=0A=
# CONFIG_IDEDMA_IVB is not set=0A=
CONFIG_IDEDMA_AUTO=3Dy=0A=
# CONFIG_BLK_DEV_HD is not set=0A=
=0A=
#=0A=
# SCSI device support=0A=
#=0A=
CONFIG_SCSI=3Dy=0A=
CONFIG_SCSI_PROC_FS=3Dy=0A=
=0A=
#=0A=
# SCSI support type (disk, tape, CD-ROM)=0A=
#=0A=
CONFIG_BLK_DEV_SD=3Dy=0A=
# CONFIG_CHR_DEV_ST is not set=0A=
# CONFIG_CHR_DEV_OSST is not set=0A=
CONFIG_BLK_DEV_SR=3Dy=0A=
# CONFIG_BLK_DEV_SR_VENDOR is not set=0A=
CONFIG_CHR_DEV_SG=3Dy=0A=
=0A=
#=0A=
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs=0A=
#=0A=
# CONFIG_SCSI_MULTI_LUN is not set=0A=
# CONFIG_SCSI_CONSTANTS is not set=0A=
# CONFIG_SCSI_LOGGING is not set=0A=
=0A=
#=0A=
# SCSI Transport Attributes=0A=
#=0A=
# CONFIG_SCSI_SPI_ATTRS is not set=0A=
# CONFIG_SCSI_FC_ATTRS is not set=0A=
# CONFIG_SCSI_ISCSI_ATTRS is not set=0A=
=0A=
#=0A=
# SCSI low-level drivers=0A=
#=0A=
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set=0A=
# CONFIG_SCSI_3W_9XXX is not set=0A=
# CONFIG_SCSI_ACARD is not set=0A=
# CONFIG_SCSI_AACRAID is not set=0A=
# CONFIG_SCSI_AIC7XXX is not set=0A=
# CONFIG_SCSI_AIC7XXX_OLD is not set=0A=
# CONFIG_SCSI_AIC79XX is not set=0A=
# CONFIG_SCSI_DPT_I2O is not set=0A=
# CONFIG_MEGARAID_NEWGEN is not set=0A=
# CONFIG_MEGARAID_LEGACY is not set=0A=
# CONFIG_SCSI_SATA is not set=0A=
# CONFIG_SCSI_BUSLOGIC is not set=0A=
# CONFIG_SCSI_DMX3191D is not set=0A=
# CONFIG_SCSI_EATA is not set=0A=
# CONFIG_SCSI_EATA_PIO is not set=0A=
# CONFIG_SCSI_FUTURE_DOMAIN is not set=0A=
# CONFIG_SCSI_GDTH is not set=0A=
# CONFIG_SCSI_IPS is not set=0A=
# CONFIG_SCSI_INITIO is not set=0A=
# CONFIG_SCSI_INIA100 is not set=0A=
# CONFIG_SCSI_PPA is not set=0A=
# CONFIG_SCSI_IMM is not set=0A=
# CONFIG_SCSI_SYM53C8XX_2 is not set=0A=
# CONFIG_SCSI_IPR is not set=0A=
# CONFIG_SCSI_QLOGIC_ISP is not set=0A=
# CONFIG_SCSI_QLOGIC_FC is not set=0A=
# CONFIG_SCSI_QLOGIC_1280 is not set=0A=
CONFIG_SCSI_QLA2XXX=3Dy=0A=
# CONFIG_SCSI_QLA21XX is not set=0A=
# CONFIG_SCSI_QLA22XX is not set=0A=
# CONFIG_SCSI_QLA2300 is not set=0A=
# CONFIG_SCSI_QLA2322 is not set=0A=
# CONFIG_SCSI_QLA6312 is not set=0A=
# CONFIG_SCSI_DC395x is not set=0A=
# CONFIG_SCSI_DC390T is not set=0A=
# CONFIG_SCSI_NSP32 is not set=0A=
# CONFIG_SCSI_DEBUG is not set=0A=
=0A=
#=0A=
# Multi-device support (RAID and LVM)=0A=
#=0A=
# CONFIG_MD is not set=0A=
=0A=
#=0A=
# Fusion MPT device support=0A=
#=0A=
# CONFIG_FUSION is not set=0A=
=0A=
#=0A=
# IEEE 1394 (FireWire) support=0A=
#=0A=
# CONFIG_IEEE1394 is not set=0A=
=0A=
#=0A=
# I2O device support=0A=
#=0A=
# CONFIG_I2O is not set=0A=
=0A=
#=0A=
# Networking support=0A=
#=0A=
CONFIG_NET=3Dy=0A=
=0A=
#=0A=
# Networking options=0A=
#=0A=
CONFIG_PACKET=3Dy=0A=
# CONFIG_PACKET_MMAP is not set=0A=
# CONFIG_NETLINK_DEV is not set=0A=
CONFIG_UNIX=3Dy=0A=
# CONFIG_NET_KEY is not set=0A=
CONFIG_INET=3Dy=0A=
CONFIG_IP_MULTICAST=3Dy=0A=
# CONFIG_IP_ADVANCED_ROUTER is not set=0A=
# CONFIG_IP_PNP is not set=0A=
# CONFIG_NET_IPIP is not set=0A=
# CONFIG_NET_IPGRE is not set=0A=
# CONFIG_IP_MROUTE is not set=0A=
# CONFIG_ARPD is not set=0A=
CONFIG_SYN_COOKIES=3Dy=0A=
# CONFIG_INET_AH is not set=0A=
# CONFIG_INET_ESP is not set=0A=
# CONFIG_INET_IPCOMP is not set=0A=
# CONFIG_INET_TUNNEL is not set=0A=
CONFIG_IP_TCPDIAG=3Dy=0A=
# CONFIG_IP_TCPDIAG_IPV6 is not set=0A=
# CONFIG_IPV6 is not set=0A=
# CONFIG_NETFILTER is not set=0A=
=0A=
#=0A=
# SCTP Configuration (EXPERIMENTAL)=0A=
#=0A=
# CONFIG_IP_SCTP is not set=0A=
# CONFIG_ATM is not set=0A=
# CONFIG_BRIDGE is not set=0A=
# CONFIG_VLAN_8021Q is not set=0A=
# CONFIG_DECNET is not set=0A=
# CONFIG_LLC2 is not set=0A=
# CONFIG_IPX is not set=0A=
# CONFIG_ATALK is not set=0A=
# CONFIG_X25 is not set=0A=
# CONFIG_LAPB is not set=0A=
# CONFIG_NET_DIVERT is not set=0A=
# CONFIG_ECONET is not set=0A=
# CONFIG_WAN_ROUTER is not set=0A=
=0A=
#=0A=
# QoS and/or fair queueing=0A=
#=0A=
# CONFIG_NET_SCHED is not set=0A=
# CONFIG_NET_CLS_ROUTE is not set=0A=
=0A=
#=0A=
# Network testing=0A=
#=0A=
# CONFIG_NET_PKTGEN is not set=0A=
# CONFIG_NETPOLL is not set=0A=
# CONFIG_NET_POLL_CONTROLLER is not set=0A=
# CONFIG_HAMRADIO is not set=0A=
# CONFIG_IRDA is not set=0A=
# CONFIG_BT is not set=0A=
CONFIG_NETDEVICES=3Dy=0A=
CONFIG_DUMMY=3Dy=0A=
# CONFIG_BONDING is not set=0A=
# CONFIG_EQUALIZER is not set=0A=
# CONFIG_TUN is not set=0A=
=0A=
#=0A=
# ARCnet devices=0A=
#=0A=
# CONFIG_ARCNET is not set=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
CONFIG_NET_ETHERNET=3Dy=0A=
CONFIG_MII=3Dy=0A=
# CONFIG_HAPPYMEAL is not set=0A=
# CONFIG_SUNGEM is not set=0A=
CONFIG_NET_VENDOR_3COM=3Dy=0A=
CONFIG_VORTEX=3Dy=0A=
# CONFIG_TYPHOON is not set=0A=
=0A=
#=0A=
# Tulip family network device support=0A=
#=0A=
# CONFIG_NET_TULIP is not set=0A=
# CONFIG_HP100 is not set=0A=
# CONFIG_NET_PCI is not set=0A=
=0A=
#=0A=
# Ethernet (1000 Mbit)=0A=
#=0A=
# CONFIG_ACENIC is not set=0A=
# CONFIG_DL2K is not set=0A=
# CONFIG_E1000 is not set=0A=
# CONFIG_NS83820 is not set=0A=
# CONFIG_HAMACHI is not set=0A=
# CONFIG_YELLOWFIN is not set=0A=
# CONFIG_R8169 is not set=0A=
# CONFIG_SK98LIN is not set=0A=
# CONFIG_TIGON3 is not set=0A=
=0A=
#=0A=
# Ethernet (10000 Mbit)=0A=
#=0A=
# CONFIG_IXGB is not set=0A=
# CONFIG_S2IO is not set=0A=
=0A=
#=0A=
# Token Ring devices=0A=
#=0A=
# CONFIG_TR is not set=0A=
=0A=
#=0A=
# Wireless LAN (non-hamradio)=0A=
#=0A=
# CONFIG_NET_RADIO is not set=0A=
=0A=
#=0A=
# Wan interfaces=0A=
#=0A=
# CONFIG_WAN is not set=0A=
# CONFIG_FDDI is not set=0A=
# CONFIG_HIPPI is not set=0A=
# CONFIG_PLIP is not set=0A=
# CONFIG_PPP is not set=0A=
# CONFIG_SLIP is not set=0A=
# CONFIG_NET_FC is not set=0A=
# CONFIG_SHAPER is not set=0A=
# CONFIG_NETCONSOLE is not set=0A=
=0A=
#=0A=
# ISDN subsystem=0A=
#=0A=
# CONFIG_ISDN is not set=0A=
=0A=
#=0A=
# Telephony Support=0A=
#=0A=
# CONFIG_PHONE is not set=0A=
=0A=
#=0A=
# Input device support=0A=
#=0A=
CONFIG_INPUT=3Dy=0A=
=0A=
#=0A=
# Userland interfaces=0A=
#=0A=
CONFIG_INPUT_MOUSEDEV=3Dy=0A=
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768=0A=
# CONFIG_INPUT_JOYDEV is not set=0A=
# CONFIG_INPUT_TSDEV is not set=0A=
CONFIG_INPUT_EVDEV=3Dy=0A=
# CONFIG_INPUT_EVBUG is not set=0A=
=0A=
#=0A=
# Input I/O drivers=0A=
#=0A=
CONFIG_GAMEPORT=3Dy=0A=
CONFIG_SOUND_GAMEPORT=3Dy=0A=
CONFIG_GAMEPORT_NS558=3Dy=0A=
# CONFIG_GAMEPORT_L4 is not set=0A=
# CONFIG_GAMEPORT_EMU10K1 is not set=0A=
# CONFIG_GAMEPORT_VORTEX is not set=0A=
# CONFIG_GAMEPORT_FM801 is not set=0A=
# CONFIG_GAMEPORT_CS461X is not set=0A=
CONFIG_SERIO=3Dy=0A=
CONFIG_SERIO_I8042=3Dy=0A=
# CONFIG_SERIO_SERPORT is not set=0A=
# CONFIG_SERIO_CT82C710 is not set=0A=
# CONFIG_SERIO_PARKBD is not set=0A=
# CONFIG_SERIO_PCIPS2 is not set=0A=
CONFIG_SERIO_LIBPS2=3Dy=0A=
# CONFIG_SERIO_RAW is not set=0A=
=0A=
#=0A=
# Input Device Drivers=0A=
#=0A=
CONFIG_INPUT_KEYBOARD=3Dy=0A=
CONFIG_KEYBOARD_ATKBD=3Dy=0A=
# CONFIG_KEYBOARD_SUNKBD is not set=0A=
# CONFIG_KEYBOARD_LKKBD is not set=0A=
# CONFIG_KEYBOARD_XTKBD is not set=0A=
# CONFIG_KEYBOARD_NEWTON is not set=0A=
CONFIG_INPUT_MOUSE=3Dy=0A=
CONFIG_MOUSE_PS2=3Dy=0A=
# CONFIG_MOUSE_SERIAL is not set=0A=
# CONFIG_MOUSE_VSXXXAA is not set=0A=
# CONFIG_INPUT_JOYSTICK is not set=0A=
# CONFIG_INPUT_TOUCHSCREEN is not set=0A=
# CONFIG_INPUT_MISC is not set=0A=
=0A=
#=0A=
# Character devices=0A=
#=0A=
CONFIG_VT=3Dy=0A=
CONFIG_VT_CONSOLE=3Dy=0A=
CONFIG_HW_CONSOLE=3Dy=0A=
# CONFIG_SERIAL_NONSTANDARD is not set=0A=
=0A=
#=0A=
# Serial drivers=0A=
#=0A=
CONFIG_SERIAL_8250=3Dy=0A=
# CONFIG_SERIAL_8250_CONSOLE is not set=0A=
# CONFIG_SERIAL_8250_ACPI is not set=0A=
CONFIG_SERIAL_8250_NR_UARTS=3D4=0A=
# CONFIG_SERIAL_8250_EXTENDED is not set=0A=
=0A=
#=0A=
# Non-8250 serial port support=0A=
#=0A=
CONFIG_SERIAL_CORE=3Dy=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
# CONFIG_LEGACY_PTYS is not set=0A=
CONFIG_PRINTER=3Dy=0A=
# CONFIG_LP_CONSOLE is not set=0A=
# CONFIG_PPDEV is not set=0A=
# CONFIG_TIPAR is not set=0A=
=0A=
#=0A=
# IPMI=0A=
#=0A=
# CONFIG_IPMI_HANDLER is not set=0A=
=0A=
#=0A=
# Watchdog Cards=0A=
#=0A=
# CONFIG_WATCHDOG is not set=0A=
# CONFIG_HW_RANDOM is not set=0A=
# CONFIG_NVRAM is not set=0A=
CONFIG_RTC=3Dy=0A=
# CONFIG_DTLK is not set=0A=
# CONFIG_R3964 is not set=0A=
# CONFIG_APPLICOM is not set=0A=
# CONFIG_SONYPI is not set=0A=
=0A=
#=0A=
# Ftape, the floppy tape device driver=0A=
#=0A=
CONFIG_AGP=3Dy=0A=
# CONFIG_AGP_ALI is not set=0A=
# CONFIG_AGP_ATI is not set=0A=
# CONFIG_AGP_AMD is not set=0A=
# CONFIG_AGP_AMD64 is not set=0A=
CONFIG_AGP_INTEL=3Dy=0A=
# CONFIG_AGP_INTEL_MCH is not set=0A=
CONFIG_AGP_NVIDIA=3Dy=0A=
# CONFIG_AGP_SIS is not set=0A=
# CONFIG_AGP_SWORKS is not set=0A=
# CONFIG_AGP_VIA is not set=0A=
# CONFIG_AGP_EFFICEON is not set=0A=
CONFIG_DRM=3Dy=0A=
# CONFIG_DRM_TDFX is not set=0A=
# CONFIG_DRM_R128 is not set=0A=
# CONFIG_DRM_RADEON is not set=0A=
# CONFIG_DRM_I810 is not set=0A=
# CONFIG_DRM_I830 is not set=0A=
# CONFIG_DRM_I915 is not set=0A=
# CONFIG_DRM_MGA is not set=0A=
# CONFIG_DRM_SIS is not set=0A=
# CONFIG_MWAVE is not set=0A=
# CONFIG_RAW_DRIVER is not set=0A=
# CONFIG_HPET is not set=0A=
# CONFIG_HANGCHECK_TIMER is not set=0A=
=0A=
#=0A=
# I2C support=0A=
#=0A=
CONFIG_I2C=3Dy=0A=
CONFIG_I2C_CHARDEV=3Dy=0A=
=0A=
#=0A=
# I2C Algorithms=0A=
#=0A=
# CONFIG_I2C_ALGOBIT is not set=0A=
# CONFIG_I2C_ALGOPCF is not set=0A=
# CONFIG_I2C_ALGOPCA is not set=0A=
=0A=
#=0A=
# I2C Hardware Bus support=0A=
#=0A=
# CONFIG_I2C_ALI1535 is not set=0A=
# CONFIG_I2C_ALI1563 is not set=0A=
# CONFIG_I2C_ALI15X3 is not set=0A=
# CONFIG_I2C_AMD756 is not set=0A=
# CONFIG_I2C_AMD8111 is not set=0A=
# CONFIG_I2C_I801 is not set=0A=
# CONFIG_I2C_I810 is not set=0A=
# CONFIG_I2C_ISA is not set=0A=
# CONFIG_I2C_NFORCE2 is not set=0A=
# CONFIG_I2C_PARPORT is not set=0A=
# CONFIG_I2C_PARPORT_LIGHT is not set=0A=
CONFIG_I2C_PIIX4=3Dm=0A=
# CONFIG_I2C_PROSAVAGE is not set=0A=
# CONFIG_I2C_SAVAGE4 is not set=0A=
# CONFIG_SCx200_ACB is not set=0A=
# CONFIG_I2C_SIS5595 is not set=0A=
# CONFIG_I2C_SIS630 is not set=0A=
# CONFIG_I2C_SIS96X is not set=0A=
# CONFIG_I2C_STUB is not set=0A=
# CONFIG_I2C_VIA is not set=0A=
# CONFIG_I2C_VIAPRO is not set=0A=
# CONFIG_I2C_VOODOO3 is not set=0A=
# CONFIG_I2C_PCA_ISA is not set=0A=
=0A=
#=0A=
# Hardware Sensors Chip support=0A=
#=0A=
CONFIG_I2C_SENSOR=3Dy=0A=
# CONFIG_SENSORS_ADM1021 is not set=0A=
# CONFIG_SENSORS_ADM1025 is not set=0A=
# CONFIG_SENSORS_ADM1026 is not set=0A=
# CONFIG_SENSORS_ADM1031 is not set=0A=
# CONFIG_SENSORS_ASB100 is not set=0A=
# CONFIG_SENSORS_DS1621 is not set=0A=
# CONFIG_SENSORS_FSCHER is not set=0A=
# CONFIG_SENSORS_GL518SM is not set=0A=
# CONFIG_SENSORS_IT87 is not set=0A=
# CONFIG_SENSORS_LM63 is not set=0A=
# CONFIG_SENSORS_LM75 is not set=0A=
# CONFIG_SENSORS_LM77 is not set=0A=
CONFIG_SENSORS_LM78=3Dy=0A=
# CONFIG_SENSORS_LM80 is not set=0A=
# CONFIG_SENSORS_LM83 is not set=0A=
# CONFIG_SENSORS_LM85 is not set=0A=
# CONFIG_SENSORS_LM87 is not set=0A=
# CONFIG_SENSORS_LM90 is not set=0A=
# CONFIG_SENSORS_MAX1619 is not set=0A=
# CONFIG_SENSORS_PC87360 is not set=0A=
# CONFIG_SENSORS_SMSC47B397 is not set=0A=
# CONFIG_SENSORS_SMSC47M1 is not set=0A=
# CONFIG_SENSORS_VIA686A is not set=0A=
# CONFIG_SENSORS_W83781D is not set=0A=
# CONFIG_SENSORS_W83L785TS is not set=0A=
# CONFIG_SENSORS_W83627HF is not set=0A=
=0A=
#=0A=
# Other I2C Chip support=0A=
#=0A=
# CONFIG_SENSORS_EEPROM is not set=0A=
# CONFIG_SENSORS_PCF8574 is not set=0A=
# CONFIG_SENSORS_PCF8591 is not set=0A=
# CONFIG_SENSORS_RTC8564 is not set=0A=
# CONFIG_I2C_DEBUG_CORE is not set=0A=
# CONFIG_I2C_DEBUG_ALGO is not set=0A=
# CONFIG_I2C_DEBUG_BUS is not set=0A=
# CONFIG_I2C_DEBUG_CHIP is not set=0A=
=0A=
#=0A=
# Dallas's 1-wire bus=0A=
#=0A=
# CONFIG_W1 is not set=0A=
=0A=
#=0A=
# Misc devices=0A=
#=0A=
# CONFIG_IBM_ASM is not set=0A=
=0A=
#=0A=
# Multimedia devices=0A=
#=0A=
# CONFIG_VIDEO_DEV is not set=0A=
=0A=
#=0A=
# Digital Video Broadcasting Devices=0A=
#=0A=
# CONFIG_DVB is not set=0A=
=0A=
#=0A=
# Graphics support=0A=
#=0A=
# CONFIG_FB is not set=0A=
# CONFIG_VIDEO_SELECT is not set=0A=
=0A=
#=0A=
# Console display driver support=0A=
#=0A=
CONFIG_VGA_CONSOLE=3Dy=0A=
CONFIG_DUMMY_CONSOLE=3Dy=0A=
=0A=
#=0A=
# Sound=0A=
#=0A=
CONFIG_SOUND=3Dy=0A=
=0A=
#=0A=
# Advanced Linux Sound Architecture=0A=
#=0A=
CONFIG_SND=3Dy=0A=
CONFIG_SND_TIMER=3Dy=0A=
CONFIG_SND_PCM=3Dy=0A=
CONFIG_SND_RAWMIDI=3Dy=0A=
CONFIG_SND_SEQUENCER=3Dy=0A=
# CONFIG_SND_SEQ_DUMMY is not set=0A=
CONFIG_SND_OSSEMUL=3Dy=0A=
CONFIG_SND_MIXER_OSS=3Dy=0A=
CONFIG_SND_PCM_OSS=3Dy=0A=
CONFIG_SND_SEQUENCER_OSS=3Dy=0A=
CONFIG_SND_RTCTIMER=3Dy=0A=
# CONFIG_SND_VERBOSE_PRINTK is not set=0A=
# CONFIG_SND_DEBUG is not set=0A=
=0A=
#=0A=
# Generic devices=0A=
#=0A=
CONFIG_SND_MPU401_UART=3Dy=0A=
# CONFIG_SND_DUMMY is not set=0A=
# CONFIG_SND_VIRMIDI is not set=0A=
# CONFIG_SND_MTPAV is not set=0A=
# CONFIG_SND_SERIAL_U16550 is not set=0A=
CONFIG_SND_MPU401=3Dy=0A=
=0A=
#=0A=
# PCI devices=0A=
#=0A=
CONFIG_SND_AC97_CODEC=3Dy=0A=
# CONFIG_SND_ALI5451 is not set=0A=
# CONFIG_SND_ATIIXP is not set=0A=
# CONFIG_SND_ATIIXP_MODEM is not set=0A=
# CONFIG_SND_AU8810 is not set=0A=
# CONFIG_SND_AU8820 is not set=0A=
# CONFIG_SND_AU8830 is not set=0A=
# CONFIG_SND_AZT3328 is not set=0A=
# CONFIG_SND_BT87X is not set=0A=
# CONFIG_SND_CS46XX is not set=0A=
# CONFIG_SND_CS4281 is not set=0A=
# CONFIG_SND_EMU10K1 is not set=0A=
# CONFIG_SND_EMU10K1X is not set=0A=
# CONFIG_SND_CA0106 is not set=0A=
# CONFIG_SND_KORG1212 is not set=0A=
# CONFIG_SND_MIXART is not set=0A=
# CONFIG_SND_NM256 is not set=0A=
# CONFIG_SND_RME32 is not set=0A=
# CONFIG_SND_RME96 is not set=0A=
# CONFIG_SND_RME9652 is not set=0A=
# CONFIG_SND_HDSP is not set=0A=
# CONFIG_SND_TRIDENT is not set=0A=
# CONFIG_SND_YMFPCI is not set=0A=
# CONFIG_SND_ALS4000 is not set=0A=
# CONFIG_SND_CMIPCI is not set=0A=
# CONFIG_SND_ENS1370 is not set=0A=
CONFIG_SND_ENS1371=3Dy=0A=
# CONFIG_SND_ES1938 is not set=0A=
# CONFIG_SND_ES1968 is not set=0A=
# CONFIG_SND_MAESTRO3 is not set=0A=
# CONFIG_SND_FM801 is not set=0A=
# CONFIG_SND_ICE1712 is not set=0A=
# CONFIG_SND_ICE1724 is not set=0A=
# CONFIG_SND_INTEL8X0 is not set=0A=
# CONFIG_SND_INTEL8X0M is not set=0A=
# CONFIG_SND_SONICVIBES is not set=0A=
# CONFIG_SND_VIA82XX is not set=0A=
# CONFIG_SND_VIA82XX_MODEM is not set=0A=
# CONFIG_SND_VX222 is not set=0A=
=0A=
#=0A=
# USB devices=0A=
#=0A=
# CONFIG_SND_USB_AUDIO is not set=0A=
# CONFIG_SND_USB_USX2Y is not set=0A=
=0A=
#=0A=
# Open Sound System=0A=
#=0A=
# CONFIG_SOUND_PRIME is not set=0A=
=0A=
#=0A=
# USB support=0A=
#=0A=
CONFIG_USB=3Dy=0A=
# CONFIG_USB_DEBUG is not set=0A=
=0A=
#=0A=
# Miscellaneous USB options=0A=
#=0A=
CONFIG_USB_DEVICEFS=3Dy=0A=
# CONFIG_USB_BANDWIDTH is not set=0A=
# CONFIG_USB_DYNAMIC_MINORS is not set=0A=
# CONFIG_USB_SUSPEND is not set=0A=
# CONFIG_USB_OTG is not set=0A=
CONFIG_USB_ARCH_HAS_HCD=3Dy=0A=
CONFIG_USB_ARCH_HAS_OHCI=3Dy=0A=
=0A=
#=0A=
# USB Host Controller Drivers=0A=
#=0A=
# CONFIG_USB_EHCI_HCD is not set=0A=
# CONFIG_USB_OHCI_HCD is not set=0A=
CONFIG_USB_UHCI_HCD=3Dy=0A=
# CONFIG_USB_SL811_HCD is not set=0A=
=0A=
#=0A=
# USB Device Class drivers=0A=
#=0A=
# CONFIG_USB_AUDIO is not set=0A=
# CONFIG_USB_BLUETOOTH_TTY is not set=0A=
# CONFIG_USB_MIDI is not set=0A=
# CONFIG_USB_ACM is not set=0A=
# CONFIG_USB_PRINTER is not set=0A=
=0A=
#=0A=
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be =
needed; see USB_STORAGE Help for more information=0A=
#=0A=
CONFIG_USB_STORAGE=3Dm=0A=
# CONFIG_USB_STORAGE_DEBUG is not set=0A=
# CONFIG_USB_STORAGE_RW_DETECT is not set=0A=
# CONFIG_USB_STORAGE_DATAFAB is not set=0A=
# CONFIG_USB_STORAGE_FREECOM is not set=0A=
# CONFIG_USB_STORAGE_ISD200 is not set=0A=
# CONFIG_USB_STORAGE_DPCM is not set=0A=
# CONFIG_USB_STORAGE_HP8200e is not set=0A=
# CONFIG_USB_STORAGE_SDDR09 is not set=0A=
# CONFIG_USB_STORAGE_SDDR55 is not set=0A=
# CONFIG_USB_STORAGE_JUMPSHOT is not set=0A=
=0A=
#=0A=
# USB Input Devices=0A=
#=0A=
CONFIG_USB_HID=3Dy=0A=
CONFIG_USB_HIDINPUT=3Dy=0A=
# CONFIG_HID_FF is not set=0A=
CONFIG_USB_HIDDEV=3Dy=0A=
# CONFIG_USB_AIPTEK is not set=0A=
# CONFIG_USB_WACOM is not set=0A=
# CONFIG_USB_KBTAB is not set=0A=
# CONFIG_USB_POWERMATE is not set=0A=
# CONFIG_USB_MTOUCH is not set=0A=
# CONFIG_USB_EGALAX is not set=0A=
# CONFIG_USB_XPAD is not set=0A=
# CONFIG_USB_ATI_REMOTE is not set=0A=
=0A=
#=0A=
# USB Imaging devices=0A=
#=0A=
# CONFIG_USB_MDC800 is not set=0A=
# CONFIG_USB_MICROTEK is not set=0A=
=0A=
#=0A=
# USB Multimedia devices=0A=
#=0A=
# CONFIG_USB_DABUSB is not set=0A=
=0A=
#=0A=
# Video4Linux support is needed for USB Multimedia device support=0A=
#=0A=
=0A=
#=0A=
# USB Network Adapters=0A=
#=0A=
# CONFIG_USB_CATC is not set=0A=
# CONFIG_USB_KAWETH is not set=0A=
# CONFIG_USB_PEGASUS is not set=0A=
# CONFIG_USB_RTL8150 is not set=0A=
# CONFIG_USB_USBNET is not set=0A=
=0A=
#=0A=
# USB port drivers=0A=
#=0A=
# CONFIG_USB_USS720 is not set=0A=
=0A=
#=0A=
# USB Serial Converter support=0A=
#=0A=
# CONFIG_USB_SERIAL is not set=0A=
=0A=
#=0A=
# USB Miscellaneous drivers=0A=
#=0A=
# CONFIG_USB_EMI62 is not set=0A=
# CONFIG_USB_EMI26 is not set=0A=
# CONFIG_USB_AUERSWALD is not set=0A=
# CONFIG_USB_RIO500 is not set=0A=
# CONFIG_USB_LEGOTOWER is not set=0A=
# CONFIG_USB_LCD is not set=0A=
# CONFIG_USB_LED is not set=0A=
# CONFIG_USB_CYTHERM is not set=0A=
# CONFIG_USB_PHIDGETKIT is not set=0A=
# CONFIG_USB_PHIDGETSERVO is not set=0A=
# CONFIG_USB_IDMOUSE is not set=0A=
# CONFIG_USB_TEST is not set=0A=
=0A=
#=0A=
# USB ATM/DSL drivers=0A=
#=0A=
=0A=
#=0A=
# USB Gadget Support=0A=
#=0A=
# CONFIG_USB_GADGET is not set=0A=
=0A=
#=0A=
# MMC/SD Card support=0A=
#=0A=
# CONFIG_MMC is not set=0A=
=0A=
#=0A=
# InfiniBand support=0A=
#=0A=
# CONFIG_INFINIBAND is not set=0A=
=0A=
#=0A=
# File systems=0A=
#=0A=
CONFIG_EXT2_FS=3Dy=0A=
CONFIG_EXT2_FS_XATTR=3Dy=0A=
CONFIG_EXT2_FS_POSIX_ACL=3Dy=0A=
CONFIG_EXT2_FS_SECURITY=3Dy=0A=
CONFIG_EXT3_FS=3Dy=0A=
CONFIG_EXT3_FS_XATTR=3Dy=0A=
CONFIG_EXT3_FS_POSIX_ACL=3Dy=0A=
CONFIG_EXT3_FS_SECURITY=3Dy=0A=
CONFIG_JBD=3Dy=0A=
# CONFIG_JBD_DEBUG is not set=0A=
CONFIG_FS_MBCACHE=3Dy=0A=
# CONFIG_REISERFS_FS is not set=0A=
# CONFIG_JFS_FS is not set=0A=
CONFIG_FS_POSIX_ACL=3Dy=0A=
=0A=
#=0A=
# XFS support=0A=
#=0A=
CONFIG_XFS_FS=3Dy=0A=
CONFIG_XFS_EXPORT=3Dy=0A=
# CONFIG_XFS_RT is not set=0A=
CONFIG_XFS_QUOTA=3Dy=0A=
# CONFIG_XFS_SECURITY is not set=0A=
CONFIG_XFS_POSIX_ACL=3Dy=0A=
# CONFIG_MINIX_FS is not set=0A=
# CONFIG_ROMFS_FS is not set=0A=
CONFIG_QUOTA=3Dy=0A=
# CONFIG_QFMT_V1 is not set=0A=
CONFIG_QFMT_V2=3Dy=0A=
CONFIG_QUOTACTL=3Dy=0A=
CONFIG_DNOTIFY=3Dy=0A=
CONFIG_AUTOFS_FS=3Dy=0A=
CONFIG_AUTOFS4_FS=3Dy=0A=
=0A=
#=0A=
# CD-ROM/DVD Filesystems=0A=
#=0A=
CONFIG_ISO9660_FS=3Dy=0A=
CONFIG_JOLIET=3Dy=0A=
CONFIG_ZISOFS=3Dy=0A=
CONFIG_ZISOFS_FS=3Dy=0A=
CONFIG_UDF_FS=3Dy=0A=
CONFIG_UDF_NLS=3Dy=0A=
=0A=
#=0A=
# DOS/FAT/NT Filesystems=0A=
#=0A=
CONFIG_FAT_FS=3Dy=0A=
CONFIG_MSDOS_FS=3Dy=0A=
CONFIG_VFAT_FS=3Dy=0A=
CONFIG_FAT_DEFAULT_CODEPAGE=3D437=0A=
CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"=0A=
CONFIG_NTFS_FS=3Dy=0A=
# CONFIG_NTFS_DEBUG is not set=0A=
# CONFIG_NTFS_RW is not set=0A=
=0A=
#=0A=
# Pseudo filesystems=0A=
#=0A=
CONFIG_PROC_FS=3Dy=0A=
CONFIG_PROC_KCORE=3Dy=0A=
CONFIG_SYSFS=3Dy=0A=
# CONFIG_DEVFS_FS is not set=0A=
CONFIG_DEVPTS_FS_XATTR=3Dy=0A=
CONFIG_DEVPTS_FS_SECURITY=3Dy=0A=
CONFIG_TMPFS=3Dy=0A=
CONFIG_TMPFS_XATTR=3Dy=0A=
CONFIG_TMPFS_SECURITY=3Dy=0A=
# CONFIG_HUGETLBFS is not set=0A=
# CONFIG_HUGETLB_PAGE is not set=0A=
CONFIG_RAMFS=3Dy=0A=
=0A=
#=0A=
# Miscellaneous filesystems=0A=
#=0A=
# CONFIG_ADFS_FS is not set=0A=
# CONFIG_AFFS_FS is not set=0A=
CONFIG_HFS_FS=3Dm=0A=
# CONFIG_HFSPLUS_FS is not set=0A=
# CONFIG_BEFS_FS is not set=0A=
# CONFIG_BFS_FS is not set=0A=
# CONFIG_EFS_FS is not set=0A=
# CONFIG_CRAMFS is not set=0A=
# CONFIG_VXFS_FS is not set=0A=
# CONFIG_HPFS_FS is not set=0A=
# CONFIG_QNX4FS_FS is not set=0A=
# CONFIG_SYSV_FS is not set=0A=
# CONFIG_UFS_FS is not set=0A=
=0A=
#=0A=
# Network File Systems=0A=
#=0A=
CONFIG_NFS_FS=3Dy=0A=
CONFIG_NFS_V3=3Dy=0A=
# CONFIG_NFS_V4 is not set=0A=
# CONFIG_NFS_DIRECTIO is not set=0A=
CONFIG_NFSD=3Dy=0A=
CONFIG_NFSD_V3=3Dy=0A=
# CONFIG_NFSD_V4 is not set=0A=
# CONFIG_NFSD_TCP is not set=0A=
CONFIG_LOCKD=3Dy=0A=
CONFIG_LOCKD_V4=3Dy=0A=
CONFIG_EXPORTFS=3Dy=0A=
CONFIG_SUNRPC=3Dy=0A=
# CONFIG_RPCSEC_GSS_KRB5 is not set=0A=
# CONFIG_RPCSEC_GSS_SPKM3 is not set=0A=
CONFIG_SMB_FS=3Dy=0A=
# CONFIG_SMB_NLS_DEFAULT is not set=0A=
# CONFIG_CIFS is not set=0A=
# CONFIG_NCP_FS is not set=0A=
# CONFIG_CODA_FS is not set=0A=
# CONFIG_AFS_FS is not set=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
# CONFIG_PARTITION_ADVANCED is not set=0A=
CONFIG_MSDOS_PARTITION=3Dy=0A=
=0A=
#=0A=
# Native Language Support=0A=
#=0A=
CONFIG_NLS=3Dy=0A=
CONFIG_NLS_DEFAULT=3D"iso8859-1"=0A=
CONFIG_NLS_CODEPAGE_437=3Dm=0A=
CONFIG_NLS_CODEPAGE_737=3Dm=0A=
CONFIG_NLS_CODEPAGE_775=3Dm=0A=
CONFIG_NLS_CODEPAGE_850=3Dm=0A=
CONFIG_NLS_CODEPAGE_852=3Dm=0A=
CONFIG_NLS_CODEPAGE_855=3Dm=0A=
CONFIG_NLS_CODEPAGE_857=3Dm=0A=
CONFIG_NLS_CODEPAGE_860=3Dm=0A=
CONFIG_NLS_CODEPAGE_861=3Dm=0A=
CONFIG_NLS_CODEPAGE_862=3Dm=0A=
CONFIG_NLS_CODEPAGE_863=3Dm=0A=
CONFIG_NLS_CODEPAGE_864=3Dm=0A=
CONFIG_NLS_CODEPAGE_865=3Dm=0A=
CONFIG_NLS_CODEPAGE_866=3Dm=0A=
CONFIG_NLS_CODEPAGE_869=3Dm=0A=
CONFIG_NLS_CODEPAGE_936=3Dm=0A=
CONFIG_NLS_CODEPAGE_950=3Dm=0A=
CONFIG_NLS_CODEPAGE_932=3Dm=0A=
CONFIG_NLS_CODEPAGE_949=3Dm=0A=
CONFIG_NLS_CODEPAGE_874=3Dm=0A=
CONFIG_NLS_ISO8859_8=3Dm=0A=
CONFIG_NLS_CODEPAGE_1250=3Dm=0A=
CONFIG_NLS_CODEPAGE_1251=3Dm=0A=
CONFIG_NLS_ASCII=3Dm=0A=
CONFIG_NLS_ISO8859_1=3Dm=0A=
CONFIG_NLS_ISO8859_2=3Dm=0A=
CONFIG_NLS_ISO8859_3=3Dm=0A=
CONFIG_NLS_ISO8859_4=3Dm=0A=
CONFIG_NLS_ISO8859_5=3Dm=0A=
CONFIG_NLS_ISO8859_6=3Dm=0A=
CONFIG_NLS_ISO8859_7=3Dm=0A=
CONFIG_NLS_ISO8859_9=3Dm=0A=
CONFIG_NLS_ISO8859_13=3Dm=0A=
CONFIG_NLS_ISO8859_14=3Dm=0A=
CONFIG_NLS_ISO8859_15=3Dm=0A=
CONFIG_NLS_KOI8_R=3Dm=0A=
CONFIG_NLS_KOI8_U=3Dm=0A=
CONFIG_NLS_UTF8=3Dm=0A=
=0A=
#=0A=
# Profiling support=0A=
#=0A=
# CONFIG_PROFILING is not set=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
# CONFIG_DEBUG_KERNEL is not set=0A=
CONFIG_DEBUG_PREEMPT=3Dy=0A=
CONFIG_DEBUG_BUGVERBOSE=3Dy=0A=
# CONFIG_FRAME_POINTER is not set=0A=
CONFIG_EARLY_PRINTK=3Dy=0A=
# CONFIG_4KSTACKS is not set=0A=
CONFIG_X86_FIND_SMP_CONFIG=3Dy=0A=
CONFIG_X86_MPPARSE=3Dy=0A=
=0A=
#=0A=
# Security options=0A=
#=0A=
CONFIG_KEYS=3Dy=0A=
# CONFIG_KEYS_DEBUG_PROC_KEYS is not set=0A=
# CONFIG_SECURITY is not set=0A=
=0A=
#=0A=
# Cryptographic options=0A=
#=0A=
CONFIG_CRYPTO=3Dy=0A=
CONFIG_CRYPTO_HMAC=3Dy=0A=
CONFIG_CRYPTO_NULL=3Dy=0A=
CONFIG_CRYPTO_MD4=3Dy=0A=
CONFIG_CRYPTO_MD5=3Dy=0A=
CONFIG_CRYPTO_SHA1=3Dy=0A=
CONFIG_CRYPTO_SHA256=3Dy=0A=
CONFIG_CRYPTO_SHA512=3Dy=0A=
CONFIG_CRYPTO_WP512=3Dy=0A=
CONFIG_CRYPTO_DES=3Dy=0A=
CONFIG_CRYPTO_BLOWFISH=3Dy=0A=
CONFIG_CRYPTO_TWOFISH=3Dy=0A=
CONFIG_CRYPTO_SERPENT=3Dy=0A=
CONFIG_CRYPTO_AES_586=3Dy=0A=
CONFIG_CRYPTO_CAST5=3Dy=0A=
CONFIG_CRYPTO_CAST6=3Dy=0A=
CONFIG_CRYPTO_TEA=3Dy=0A=
CONFIG_CRYPTO_ARC4=3Dy=0A=
CONFIG_CRYPTO_KHAZAD=3Dy=0A=
CONFIG_CRYPTO_ANUBIS=3Dy=0A=
CONFIG_CRYPTO_DEFLATE=3Dy=0A=
# CONFIG_CRYPTO_MICHAEL_MIC is not set=0A=
CONFIG_CRYPTO_CRC32C=3Dy=0A=
CONFIG_CRYPTO_TEST=3Dy=0A=
=0A=
#=0A=
# Hardware crypto devices=0A=
#=0A=
# CONFIG_CRYPTO_DEV_PADLOCK is not set=0A=
=0A=
#=0A=
# Library routines=0A=
#=0A=
CONFIG_CRC_CCITT=3Dy=0A=
CONFIG_CRC32=3Dy=0A=
CONFIG_LIBCRC32C=3Dy=0A=
CONFIG_ZLIB_INFLATE=3Dy=0A=
CONFIG_ZLIB_DEFLATE=3Dy=0A=
CONFIG_GENERIC_HARDIRQS=3Dy=0A=
CONFIG_GENERIC_IRQ_PROBE=3Dy=0A=
CONFIG_X86_SMP=3Dy=0A=
CONFIG_X86_HT=3Dy=0A=
CONFIG_X86_BIOS_REBOOT=3Dy=0A=
CONFIG_X86_TRAMPOLINE=3Dy=0A=
CONFIG_PC=3Dy=0A=

------_=_NextPart_000_01C5515D.D4EF2D20--
