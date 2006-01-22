Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWAUTko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWAUTko (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 14:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWAUTko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 14:40:44 -0500
Received: from savages.net ([66.93.39.90]:24748 "EHLO mail.savages.net")
	by vger.kernel.org with ESMTP id S1751198AbWAUTkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 14:40:42 -0500
Message-ID: <43D3467C.7010803@tvlinux.org>
Date: Sun, 22 Jan 2006 00:46:52 -0800
From: Shaun Savage <savages@tvlinux.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1.centos4 (X11/20051007)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_gateway.savages.net-6826-1137872439-0001-2"
To: linux-kernel@vger.kernel.org
CC: Linus Torvalds <torvalds@osdl.org>
Subject: CBD Compressed Block Device, New embedded block device
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_gateway.savages.net-6826-1137872439-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

HI

Here is a patch for 2.6.14.5 of CBD
CBD is a compressed block device that is designed to shrink the file 
system size to 1/3 the original size.  CBD is a block device on a file 
system so, it also allows for in-field upgrade of file system.  If 
necessary is also allows for secure booting, with a GRUB patch.

Reply to email please.

Shaun Savage

--=_gateway.savages.net-6826-1137872439-0001-2
Content-Type: text/x-patch; name="cbd-012106.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cbd-012106.patch"

diff -Nru o-linux-2.6.14.5/cbd.config linux-2.6.14.5/cbd.config
--- o-linux-2.6.14.5/cbd.config	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.14.5/cbd.config	2006-01-21 23:59:02.000000000 -0800
@@ -0,0 +1,1481 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.14.5
+# Sat Jan 21 23:59:02 2006
+#
+CONFIG_X86=y
+CONFIG_SEMAPHORE_SLEEPERS=y
+CONFIG_MMU=y
+CONFIG_UID16=y
+CONFIG_GENERIC_ISA_DMA=y
+CONFIG_GENERIC_IOMAP=y
+CONFIG_ARCH_MAY_HAVE_PC_FDC=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_CLEAN_COMPILE=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_LOCK_KERNEL=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+CONFIG_AUDIT=y
+CONFIG_AUDITSYSCALL=y
+CONFIG_HOTPLUG=y
+CONFIG_KOBJECT_UEVENT=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_EMBEDDED=y
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
+CONFIG_KALLSYMS_EXTRA_PASS=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+CONFIG_OBSOLETE_MODPARM=y
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+
+#
+# Processor type and features
+#
+CONFIG_X86_PC=y
+# CONFIG_X86_ELAN is not set
+# CONFIG_X86_VOYAGER is not set
+# CONFIG_X86_NUMAQ is not set
+# CONFIG_X86_SUMMIT is not set
+# CONFIG_X86_BIGSMP is not set
+# CONFIG_X86_VISWS is not set
+# CONFIG_X86_GENERICARCH is not set
+# CONFIG_X86_ES7000 is not set
+# CONFIG_M386 is not set
+# CONFIG_M486 is not set
+# CONFIG_M586 is not set
+# CONFIG_M586TSC is not set
+# CONFIG_M586MMX is not set
+# CONFIG_M686 is not set
+# CONFIG_MPENTIUMII is not set
+# CONFIG_MPENTIUMIII is not set
+# CONFIG_MPENTIUMM is not set
+# CONFIG_MPENTIUM4 is not set
+# CONFIG_MK6 is not set
+CONFIG_MK7=y
+# CONFIG_MK8 is not set
+# CONFIG_MCRUSOE is not set
+# CONFIG_MEFFICEON is not set
+# CONFIG_MWINCHIPC6 is not set
+# CONFIG_MWINCHIP2 is not set
+# CONFIG_MWINCHIP3D is not set
+# CONFIG_MGEODEGX1 is not set
+# CONFIG_MCYRIXIII is not set
+# CONFIG_MVIAC3_2 is not set
+CONFIG_X86_GENERIC=y
+CONFIG_X86_CMPXCHG=y
+CONFIG_X86_XADD=y
+CONFIG_X86_L1_CACHE_SHIFT=7
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_X86_WP_WORKS_OK=y
+CONFIG_X86_INVLPG=y
+CONFIG_X86_BSWAP=y
+CONFIG_X86_POPAD_OK=y
+CONFIG_X86_GOOD_APIC=y
+CONFIG_X86_INTEL_USERCOPY=y
+CONFIG_X86_USE_PPRO_CHECKSUM=y
+CONFIG_X86_USE_3DNOW=y
+CONFIG_HPET_TIMER=y
+CONFIG_HPET_EMULATE_RTC=y
+# CONFIG_SMP is not set
+# CONFIG_PREEMPT_NONE is not set
+# CONFIG_PREEMPT_VOLUNTARY is not set
+CONFIG_PREEMPT=y
+CONFIG_PREEMPT_BKL=y
+CONFIG_X86_UP_APIC=y
+# CONFIG_X86_UP_IOAPIC is not set
+CONFIG_X86_LOCAL_APIC=y
+CONFIG_X86_TSC=y
+CONFIG_X86_MCE=y
+CONFIG_X86_MCE_NONFATAL=y
+CONFIG_X86_MCE_P4THERMAL=y
+# CONFIG_TOSHIBA is not set
+# CONFIG_I8K is not set
+# CONFIG_X86_REBOOTFIXUPS is not set
+# CONFIG_MICROCODE is not set
+# CONFIG_X86_MSR is not set
+# CONFIG_X86_CPUID is not set
+
+#
+# Firmware Drivers
+#
+# CONFIG_EDD is not set
+# CONFIG_DELL_RBU is not set
+# CONFIG_DCDBAS is not set
+CONFIG_NOHIGHMEM=y
+# CONFIG_HIGHMEM4G is not set
+# CONFIG_HIGHMEM64G is not set
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+# CONFIG_MATH_EMULATION is not set
+CONFIG_MTRR=y
+# CONFIG_REGPARM is not set
+CONFIG_SECCOMP=y
+# CONFIG_HZ_100 is not set
+CONFIG_HZ_250=y
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=250
+CONFIG_PHYSICAL_START=0x100000
+# CONFIG_KEXEC is not set
+
+#
+# Power management options (ACPI, APM)
+#
+# CONFIG_PM is not set
+
+#
+# ACPI (Advanced Configuration and Power Interface) Support
+#
+# CONFIG_ACPI is not set
+
+#
+# CPU Frequency scaling
+#
+# CONFIG_CPU_FREQ is not set
+
+#
+# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
+#
+CONFIG_PCI=y
+# CONFIG_PCI_GOBIOS is not set
+# CONFIG_PCI_GOMMCONFIG is not set
+# CONFIG_PCI_GODIRECT is not set
+CONFIG_PCI_GOANY=y
+CONFIG_PCI_BIOS=y
+CONFIG_PCI_DIRECT=y
+# CONFIG_PCIEPORTBUS is not set
+CONFIG_PCI_LEGACY_PROC=y
+# CONFIG_PCI_DEBUG is not set
+CONFIG_ISA_DMA_API=y
+# CONFIG_ISA is not set
+# CONFIG_MCA is not set
+# CONFIG_SCx200 is not set
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# PCI Hotplug Support
+#
+# CONFIG_HOTPLUG_PCI is not set
+
+#
+# Executable file formats
+#
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_AOUT is not set
+CONFIG_BINFMT_MISC=y
+
+#
+# Networking
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+# CONFIG_IP_PNP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_BIC=y
+
+#
+# IP: Virtual Server Configuration
+#
+# CONFIG_IP_VS is not set
+# CONFIG_IPV6 is not set
+CONFIG_NETFILTER=y
+# CONFIG_NETFILTER_DEBUG is not set
+# CONFIG_NETFILTER_NETLINK is not set
+
+#
+# IP: Netfilter Configuration
+#
+CONFIG_IP_NF_CONNTRACK=y
+# CONFIG_IP_NF_CT_ACCT is not set
+# CONFIG_IP_NF_CONNTRACK_MARK is not set
+# CONFIG_IP_NF_CONNTRACK_EVENTS is not set
+# CONFIG_IP_NF_CT_PROTO_SCTP is not set
+# CONFIG_IP_NF_FTP is not set
+# CONFIG_IP_NF_IRC is not set
+# CONFIG_IP_NF_NETBIOS_NS is not set
+# CONFIG_IP_NF_TFTP is not set
+# CONFIG_IP_NF_AMANDA is not set
+# CONFIG_IP_NF_PPTP is not set
+CONFIG_IP_NF_QUEUE=y
+CONFIG_IP_NF_IPTABLES=y
+CONFIG_IP_NF_MATCH_LIMIT=y
+CONFIG_IP_NF_MATCH_IPRANGE=y
+CONFIG_IP_NF_MATCH_MAC=y
+CONFIG_IP_NF_MATCH_PKTTYPE=y
+CONFIG_IP_NF_MATCH_MARK=y
+CONFIG_IP_NF_MATCH_MULTIPORT=y
+CONFIG_IP_NF_MATCH_TOS=y
+CONFIG_IP_NF_MATCH_RECENT=y
+CONFIG_IP_NF_MATCH_ECN=y
+CONFIG_IP_NF_MATCH_DSCP=y
+CONFIG_IP_NF_MATCH_AH_ESP=y
+CONFIG_IP_NF_MATCH_LENGTH=y
+CONFIG_IP_NF_MATCH_TTL=y
+CONFIG_IP_NF_MATCH_TCPMSS=y
+CONFIG_IP_NF_MATCH_HELPER=y
+CONFIG_IP_NF_MATCH_STATE=y
+CONFIG_IP_NF_MATCH_CONNTRACK=y
+CONFIG_IP_NF_MATCH_OWNER=y
+# CONFIG_IP_NF_MATCH_ADDRTYPE is not set
+# CONFIG_IP_NF_MATCH_REALM is not set
+# CONFIG_IP_NF_MATCH_SCTP is not set
+# CONFIG_IP_NF_MATCH_DCCP is not set
+# CONFIG_IP_NF_MATCH_COMMENT is not set
+# CONFIG_IP_NF_MATCH_HASHLIMIT is not set
+# CONFIG_IP_NF_MATCH_STRING is not set
+CONFIG_IP_NF_FILTER=y
+CONFIG_IP_NF_TARGET_REJECT=y
+CONFIG_IP_NF_TARGET_LOG=y
+CONFIG_IP_NF_TARGET_ULOG=y
+CONFIG_IP_NF_TARGET_TCPMSS=y
+# CONFIG_IP_NF_TARGET_NFQUEUE is not set
+CONFIG_IP_NF_NAT=y
+CONFIG_IP_NF_NAT_NEEDED=y
+CONFIG_IP_NF_TARGET_MASQUERADE=y
+CONFIG_IP_NF_TARGET_REDIRECT=y
+CONFIG_IP_NF_TARGET_NETMAP=y
+CONFIG_IP_NF_TARGET_SAME=y
+# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
+CONFIG_IP_NF_MANGLE=y
+CONFIG_IP_NF_TARGET_TOS=y
+CONFIG_IP_NF_TARGET_ECN=y
+CONFIG_IP_NF_TARGET_DSCP=y
+CONFIG_IP_NF_TARGET_MARK=y
+CONFIG_IP_NF_TARGET_CLASSIFY=y
+# CONFIG_IP_NF_TARGET_TTL is not set
+CONFIG_IP_NF_RAW=m
+CONFIG_IP_NF_TARGET_NOTRACK=m
+CONFIG_IP_NF_ARPTABLES=y
+CONFIG_IP_NF_ARPFILTER=y
+CONFIG_IP_NF_ARP_MANGLE=y
+
+#
+# DCCP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_DCCP is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+CONFIG_IRDA=m
+
+#
+# IrDA protocols
+#
+# CONFIG_IRLAN is not set
+# CONFIG_IRCOMM is not set
+# CONFIG_IRDA_ULTRA is not set
+
+#
+# IrDA options
+#
+# CONFIG_IRDA_CACHE_LAST_LSAP is not set
+# CONFIG_IRDA_FAST_RR is not set
+# CONFIG_IRDA_DEBUG is not set
+
+#
+# Infrared-port device drivers
+#
+
+#
+# SIR device drivers
+#
+# CONFIG_IRTTY_SIR is not set
+
+#
+# Dongle support
+#
+
+#
+# Old SIR device drivers
+#
+# CONFIG_IRPORT_SIR is not set
+
+#
+# Old Serial dongle support
+#
+
+#
+# FIR device drivers
+#
+# CONFIG_USB_IRDA is not set
+# CONFIG_SIGMATEL_FIR is not set
+# CONFIG_NSC_FIR is not set
+# CONFIG_WINBOND_FIR is not set
+# CONFIG_TOSHIBA_FIR is not set
+# CONFIG_SMC_IRCC_FIR is not set
+# CONFIG_ALI_FIR is not set
+# CONFIG_VLSI_FIR is not set
+# CONFIG_VIA_FIR is not set
+CONFIG_BT=m
+# CONFIG_BT_L2CAP is not set
+# CONFIG_BT_SCO is not set
+
+#
+# Bluetooth device drivers
+#
+# CONFIG_BT_HCIUSB is not set
+# CONFIG_BT_HCIUART is not set
+# CONFIG_BT_HCIBCM203X is not set
+# CONFIG_BT_HCIBPA10X is not set
+# CONFIG_BT_HCIBFUSB is not set
+# CONFIG_BT_HCIVHCI is not set
+CONFIG_IEEE80211=m
+# CONFIG_IEEE80211_DEBUG is not set
+CONFIG_IEEE80211_CRYPT_WEP=m
+CONFIG_IEEE80211_CRYPT_CCMP=m
+CONFIG_IEEE80211_CRYPT_TKIP=m
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=m
+# CONFIG_DEBUG_DRIVER is not set
+
+#
+# Connector - unified userspace <-> kernelspace linker
+#
+# CONFIG_CONNECTOR is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+# CONFIG_MTD is not set
+
+#
+# Parallel port support
+#
+CONFIG_PARPORT=y
+CONFIG_PARPORT_PC=y
+# CONFIG_PARPORT_SERIAL is not set
+# CONFIG_PARPORT_PC_FIFO is not set
+# CONFIG_PARPORT_PC_SUPERIO is not set
+# CONFIG_PARPORT_GSC is not set
+# CONFIG_PARPORT_1284 is not set
+
+#
+# Plug and Play support
+#
+
+#
+# Block devices
+#
+CONFIG_BLK_DEV_FD=y
+# CONFIG_PARIDE is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=m
+CONFIG_BLK_DEV_CRYPTOLOOP=m
+# CONFIG_BLK_DEV_NBD is not set
+CONFIG_BLK_DEV_CBD=m
+# CONFIG_BLK_DEV_SX8 is not set
+# CONFIG_BLK_DEV_UB is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=4096
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_LBD=y
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+CONFIG_ATA_OVER_ETH=m
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+CONFIG_IDE=y
+CONFIG_BLK_DEV_IDE=y
+
+#
+# Please see Documentation/ide.txt for help/info on IDE drives
+#
+# CONFIG_BLK_DEV_IDE_SATA is not set
+# CONFIG_BLK_DEV_HD_IDE is not set
+CONFIG_BLK_DEV_IDEDISK=y
+CONFIG_IDEDISK_MULTI_MODE=y
+CONFIG_BLK_DEV_IDECD=y
+# CONFIG_BLK_DEV_IDETAPE is not set
+# CONFIG_BLK_DEV_IDEFLOPPY is not set
+# CONFIG_BLK_DEV_IDESCSI is not set
+# CONFIG_IDE_TASK_IOCTL is not set
+
+#
+# IDE chipset support/bugfixes
+#
+CONFIG_IDE_GENERIC=y
+CONFIG_BLK_DEV_CMD640=y
+# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
+CONFIG_BLK_DEV_IDEPCI=y
+CONFIG_IDEPCI_SHARE_IRQ=y
+# CONFIG_BLK_DEV_OFFBOARD is not set
+CONFIG_BLK_DEV_GENERIC=y
+# CONFIG_BLK_DEV_OPTI621 is not set
+CONFIG_BLK_DEV_RZ1000=y
+CONFIG_BLK_DEV_IDEDMA_PCI=y
+# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
+CONFIG_IDEDMA_PCI_AUTO=y
+# CONFIG_IDEDMA_ONLYDISK is not set
+# CONFIG_BLK_DEV_AEC62XX is not set
+# CONFIG_BLK_DEV_ALI15X3 is not set
+# CONFIG_BLK_DEV_AMD74XX is not set
+# CONFIG_BLK_DEV_ATIIXP is not set
+# CONFIG_BLK_DEV_CMD64X is not set
+# CONFIG_BLK_DEV_TRIFLEX is not set
+# CONFIG_BLK_DEV_CY82C693 is not set
+# CONFIG_BLK_DEV_CS5520 is not set
+# CONFIG_BLK_DEV_CS5530 is not set
+# CONFIG_BLK_DEV_HPT34X is not set
+# CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_SC1200 is not set
+CONFIG_BLK_DEV_PIIX=y
+# CONFIG_BLK_DEV_IT821X is not set
+# CONFIG_BLK_DEV_NS87415 is not set
+# CONFIG_BLK_DEV_PDC202XX_OLD is not set
+# CONFIG_BLK_DEV_PDC202XX_NEW is not set
+# CONFIG_BLK_DEV_SVWKS is not set
+# CONFIG_BLK_DEV_SIIMAGE is not set
+# CONFIG_BLK_DEV_SIS5513 is not set
+# CONFIG_BLK_DEV_SLC90E66 is not set
+# CONFIG_BLK_DEV_TRM290 is not set
+# CONFIG_BLK_DEV_VIA82CXXX is not set
+# CONFIG_IDE_ARM is not set
+CONFIG_BLK_DEV_IDEDMA=y
+# CONFIG_IDEDMA_IVB is not set
+CONFIG_IDEDMA_AUTO=y
+# CONFIG_BLK_DEV_HD is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+CONFIG_SCSI=y
+CONFIG_SCSI_PROC_FS=y
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=y
+# CONFIG_CHR_DEV_ST is not set
+# CONFIG_CHR_DEV_OSST is not set
+CONFIG_BLK_DEV_SR=m
+# CONFIG_BLK_DEV_SR_VENDOR is not set
+CONFIG_CHR_DEV_SG=y
+# CONFIG_CHR_DEV_SCH is not set
+
+#
+# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
+#
+# CONFIG_SCSI_MULTI_LUN is not set
+# CONFIG_SCSI_CONSTANTS is not set
+# CONFIG_SCSI_LOGGING is not set
+
+#
+# SCSI Transport Attributes
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
+# CONFIG_SCSI_SAS_ATTRS is not set
+
+#
+# SCSI low-level drivers
+#
+# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_3W_9XXX is not set
+# CONFIG_SCSI_ACARD is not set
+# CONFIG_SCSI_AACRAID is not set
+# CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC7XXX_OLD is not set
+# CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_MEGARAID_NEWGEN is not set
+# CONFIG_MEGARAID_LEGACY is not set
+# CONFIG_MEGARAID_SAS is not set
+CONFIG_SCSI_SATA=y
+# CONFIG_SCSI_SATA_AHCI is not set
+# CONFIG_SCSI_SATA_SVW is not set
+CONFIG_SCSI_ATA_PIIX=y
+# CONFIG_SCSI_SATA_MV is not set
+# CONFIG_SCSI_SATA_NV is not set
+# CONFIG_SCSI_SATA_PROMISE is not set
+# CONFIG_SCSI_SATA_QSTOR is not set
+CONFIG_SCSI_SATA_SX4=m
+# CONFIG_SCSI_SATA_SIL is not set
+CONFIG_SCSI_SATA_SIS=m
+# CONFIG_SCSI_SATA_ULI is not set
+# CONFIG_SCSI_SATA_VIA is not set
+# CONFIG_SCSI_SATA_VITESSE is not set
+CONFIG_SCSI_SATA_INTEL_COMBINED=y
+# CONFIG_SCSI_BUSLOGIC is not set
+# CONFIG_SCSI_DMX3191D is not set
+# CONFIG_SCSI_EATA is not set
+# CONFIG_SCSI_FUTURE_DOMAIN is not set
+# CONFIG_SCSI_GDTH is not set
+# CONFIG_SCSI_IPS is not set
+# CONFIG_SCSI_INITIO is not set
+# CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_PPA is not set
+# CONFIG_SCSI_IMM is not set
+# CONFIG_SCSI_SYM53C8XX_2 is not set
+CONFIG_SCSI_IPR=m
+# CONFIG_SCSI_IPR_TRACE is not set
+# CONFIG_SCSI_IPR_DUMP is not set
+# CONFIG_SCSI_QLOGIC_FC is not set
+# CONFIG_SCSI_QLOGIC_1280 is not set
+CONFIG_SCSI_QLA2XXX=y
+# CONFIG_SCSI_QLA21XX is not set
+# CONFIG_SCSI_QLA22XX is not set
+# CONFIG_SCSI_QLA2300 is not set
+# CONFIG_SCSI_QLA2322 is not set
+# CONFIG_SCSI_QLA6312 is not set
+# CONFIG_SCSI_QLA24XX is not set
+# CONFIG_SCSI_LPFC is not set
+# CONFIG_SCSI_DC395x is not set
+# CONFIG_SCSI_DC390T is not set
+# CONFIG_SCSI_NSP32 is not set
+# CONFIG_SCSI_DEBUG is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+# CONFIG_FUSION_SPI is not set
+# CONFIG_FUSION_FC is not set
+# CONFIG_FUSION_SAS is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+CONFIG_IEEE1394=y
+
+#
+# Subsystem Options
+#
+# CONFIG_IEEE1394_VERBOSEDEBUG is not set
+# CONFIG_IEEE1394_OUI_DB is not set
+# CONFIG_IEEE1394_EXTRA_CONFIG_ROMS is not set
+# CONFIG_IEEE1394_EXPORT_FULL_API is not set
+
+#
+# Device Drivers
+#
+
+#
+# Texas Instruments PCILynx requires I2C
+#
+CONFIG_IEEE1394_OHCI1394=y
+
+#
+# Protocol Drivers
+#
+# CONFIG_IEEE1394_VIDEO1394 is not set
+# CONFIG_IEEE1394_SBP2 is not set
+# CONFIG_IEEE1394_ETH1394 is not set
+# CONFIG_IEEE1394_DV1394 is not set
+CONFIG_IEEE1394_RAWIO=y
+# CONFIG_IEEE1394_CMP is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+
+#
+# Network device support
+#
+CONFIG_NETDEVICES=y
+CONFIG_DUMMY=m
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+CONFIG_TUN=m
+
+#
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+
+#
+# PHY device support
+#
+# CONFIG_PHYLIB is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+
+#
+# Tulip family network device support
+#
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+CONFIG_NET_PCI=y
+# CONFIG_PCNET32 is not set
+# CONFIG_AMD8111_ETH is not set
+# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_B44 is not set
+# CONFIG_FORCEDETH is not set
+# CONFIG_DGRS is not set
+# CONFIG_EEPRO100 is not set
+CONFIG_E100=m
+# CONFIG_FEALNX is not set
+# CONFIG_NATSEMI is not set
+# CONFIG_NE2K_PCI is not set
+# CONFIG_8139CP is not set
+CONFIG_8139TOO=y
+CONFIG_8139TOO_PIO=y
+# CONFIG_8139TOO_TUNE_TWISTER is not set
+# CONFIG_8139TOO_8129 is not set
+# CONFIG_8139_OLD_RX_RESET is not set
+# CONFIG_SIS900 is not set
+# CONFIG_EPIC100 is not set
+# CONFIG_SUNDANCE is not set
+# CONFIG_TLAN is not set
+# CONFIG_VIA_RHINE is not set
+# CONFIG_NET_POCKET is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+
+#
+# Ethernet (10000 Mbit)
+#
+# CONFIG_CHELSIO_T1 is not set
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+
+#
+# Token Ring devices
+#
+# CONFIG_TR is not set
+
+#
+# Wireless LAN (non-hamradio)
+#
+CONFIG_NET_RADIO=y
+
+#
+# Obsolete Wireless cards support (pre-802.11)
+#
+# CONFIG_STRIP is not set
+
+#
+# Wireless 802.11b ISA/PCI cards support
+#
+CONFIG_IPW2100=m
+CONFIG_IPW2100_MONITOR=y
+CONFIG_IPW_DEBUG=y
+CONFIG_IPW2200=m
+# CONFIG_AIRO is not set
+# CONFIG_HERMES is not set
+# CONFIG_ATMEL is not set
+
+#
+# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
+#
+# CONFIG_PRISM54 is not set
+# CONFIG_HOSTAP is not set
+CONFIG_NET_WIRELESS=y
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PLIP is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_NET_FC is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_PSAUX=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+CONFIG_INPUT_EVDEV=m
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+CONFIG_INPUT_KEYBOARD=y
+CONFIG_KEYBOARD_ATKBD=y
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_LKKBD is not set
+# CONFIG_KEYBOARD_XTKBD is not set
+# CONFIG_KEYBOARD_NEWTON is not set
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_PS2=y
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_VSXXXAA is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+CONFIG_SERIO_I8042=y
+# CONFIG_SERIO_SERPORT is not set
+# CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_PARKBD is not set
+# CONFIG_SERIO_PCIPS2 is not set
+CONFIG_SERIO_LIBPS2=y
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+CONFIG_VT=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+# CONFIG_SERIAL_8250_CONSOLE is not set
+CONFIG_SERIAL_8250_NR_UARTS=4
+# CONFIG_SERIAL_8250_EXTENDED is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=y
+# CONFIG_SERIAL_JSM is not set
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+CONFIG_PRINTER=y
+# CONFIG_LP_CONSOLE is not set
+# CONFIG_PPDEV is not set
+# CONFIG_TIPAR is not set
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+CONFIG_HW_RANDOM=m
+CONFIG_NVRAM=m
+CONFIG_RTC=y
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+# CONFIG_SONYPI is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_FTAPE is not set
+CONFIG_AGP=y
+# CONFIG_AGP_ALI is not set
+# CONFIG_AGP_ATI is not set
+# CONFIG_AGP_AMD is not set
+# CONFIG_AGP_AMD64 is not set
+CONFIG_AGP_INTEL=y
+# CONFIG_AGP_NVIDIA is not set
+# CONFIG_AGP_SIS is not set
+# CONFIG_AGP_SWORKS is not set
+# CONFIG_AGP_VIA is not set
+# CONFIG_AGP_EFFICEON is not set
+CONFIG_DRM=y
+# CONFIG_DRM_TDFX is not set
+# CONFIG_DRM_R128 is not set
+# CONFIG_DRM_RADEON is not set
+CONFIG_DRM_I810=m
+CONFIG_DRM_I830=m
+CONFIG_DRM_I915=m
+CONFIG_DRM_MGA=m
+# CONFIG_DRM_SIS is not set
+# CONFIG_DRM_VIA is not set
+# CONFIG_DRM_SAVAGE is not set
+# CONFIG_MWAVE is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_HANGCHECK_TIMER is not set
+
+#
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Hardware Monitoring support
+#
+CONFIG_HWMON=y
+# CONFIG_HWMON_VID is not set
+# CONFIG_SENSORS_HDAPS is not set
+# CONFIG_HWMON_DEBUG_CHIP is not set
+
+#
+# Misc devices
+#
+# CONFIG_IBM_ASM is not set
+
+#
+# Multimedia Capabilities Port drivers
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+# CONFIG_FB is not set
+# CONFIG_VIDEO_SELECT is not set
+
+#
+# Console display driver support
+#
+CONFIG_VGA_CONSOLE=y
+CONFIG_DUMMY_CONSOLE=y
+
+#
+# Sound
+#
+CONFIG_SOUND=y
+
+#
+# Advanced Linux Sound Architecture
+#
+CONFIG_SND=y
+CONFIG_SND_TIMER=y
+CONFIG_SND_PCM=y
+CONFIG_SND_SEQUENCER=y
+# CONFIG_SND_SEQ_DUMMY is not set
+CONFIG_SND_OSSEMUL=y
+CONFIG_SND_MIXER_OSS=y
+CONFIG_SND_PCM_OSS=y
+CONFIG_SND_SEQUENCER_OSS=y
+# CONFIG_SND_RTCTIMER is not set
+# CONFIG_SND_VERBOSE_PRINTK is not set
+# CONFIG_SND_DEBUG is not set
+
+#
+# Generic devices
+#
+# CONFIG_SND_DUMMY is not set
+# CONFIG_SND_VIRMIDI is not set
+# CONFIG_SND_MTPAV is not set
+# CONFIG_SND_SERIAL_U16550 is not set
+# CONFIG_SND_MPU401 is not set
+CONFIG_SND_AC97_CODEC=y
+CONFIG_SND_AC97_BUS=y
+
+#
+# PCI devices
+#
+# CONFIG_SND_ALI5451 is not set
+# CONFIG_SND_ATIIXP is not set
+# CONFIG_SND_ATIIXP_MODEM is not set
+# CONFIG_SND_AU8810 is not set
+# CONFIG_SND_AU8820 is not set
+# CONFIG_SND_AU8830 is not set
+# CONFIG_SND_AZT3328 is not set
+# CONFIG_SND_BT87X is not set
+# CONFIG_SND_CS46XX is not set
+# CONFIG_SND_CS4281 is not set
+# CONFIG_SND_EMU10K1 is not set
+# CONFIG_SND_EMU10K1X is not set
+# CONFIG_SND_CA0106 is not set
+# CONFIG_SND_KORG1212 is not set
+# CONFIG_SND_MIXART is not set
+# CONFIG_SND_NM256 is not set
+# CONFIG_SND_RME32 is not set
+# CONFIG_SND_RME96 is not set
+# CONFIG_SND_RME9652 is not set
+# CONFIG_SND_HDSP is not set
+# CONFIG_SND_HDSPM is not set
+# CONFIG_SND_TRIDENT is not set
+# CONFIG_SND_YMFPCI is not set
+# CONFIG_SND_AD1889 is not set
+# CONFIG_SND_ALS4000 is not set
+# CONFIG_SND_CMIPCI is not set
+# CONFIG_SND_ENS1370 is not set
+# CONFIG_SND_ENS1371 is not set
+# CONFIG_SND_ES1938 is not set
+# CONFIG_SND_ES1968 is not set
+# CONFIG_SND_MAESTRO3 is not set
+# CONFIG_SND_FM801 is not set
+# CONFIG_SND_ICE1712 is not set
+# CONFIG_SND_ICE1724 is not set
+CONFIG_SND_INTEL8X0=y
+# CONFIG_SND_INTEL8X0M is not set
+# CONFIG_SND_SONICVIBES is not set
+# CONFIG_SND_VIA82XX is not set
+# CONFIG_SND_VIA82XX_MODEM is not set
+# CONFIG_SND_VX222 is not set
+# CONFIG_SND_HDA_INTEL is not set
+
+#
+# USB devices
+#
+# CONFIG_SND_USB_AUDIO is not set
+# CONFIG_SND_USB_USX2Y is not set
+
+#
+# Open Sound System
+#
+# CONFIG_SOUND_PRIME is not set
+
+#
+# USB support
+#
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+
+#
+# Miscellaneous USB options
+#
+CONFIG_USB_DEVICEFS=y
+# CONFIG_USB_BANDWIDTH is not set
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_OTG is not set
+
+#
+# USB Host Controller Drivers
+#
+CONFIG_USB_EHCI_HCD=y
+# CONFIG_USB_EHCI_SPLIT_ISO is not set
+# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_OHCI_HCD is not set
+CONFIG_USB_UHCI_HCD=y
+# CONFIG_USB_SL811_HCD is not set
+
+#
+# USB Device Class drivers
+#
+# CONFIG_OBSOLETE_OSS_USB_DRIVER is not set
+
+#
+# USB Bluetooth TTY can only be used with disabled Bluetooth subsystem
+#
+# CONFIG_USB_ACM is not set
+CONFIG_USB_PRINTER=y
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+CONFIG_USB_STORAGE=y
+# CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_DATAFAB is not set
+# CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_ISD200 is not set
+# CONFIG_USB_STORAGE_DPCM is not set
+# CONFIG_USB_STORAGE_USBAT is not set
+# CONFIG_USB_STORAGE_SDDR09 is not set
+# CONFIG_USB_STORAGE_SDDR55 is not set
+# CONFIG_USB_STORAGE_JUMPSHOT is not set
+# CONFIG_USB_STORAGE_ONETOUCH is not set
+
+#
+# USB Input Devices
+#
+CONFIG_USB_HID=y
+CONFIG_USB_HIDINPUT=y
+# CONFIG_HID_FF is not set
+# CONFIG_USB_HIDDEV is not set
+# CONFIG_USB_AIPTEK is not set
+# CONFIG_USB_WACOM is not set
+# CONFIG_USB_ACECAD is not set
+# CONFIG_USB_KBTAB is not set
+# CONFIG_USB_POWERMATE is not set
+# CONFIG_USB_MTOUCH is not set
+# CONFIG_USB_ITMTOUCH is not set
+CONFIG_USB_EGALAX=m
+# CONFIG_USB_YEALINK is not set
+# CONFIG_USB_XPAD is not set
+# CONFIG_USB_ATI_REMOTE is not set
+# CONFIG_USB_KEYSPAN_REMOTE is not set
+# CONFIG_USB_APPLETOUCH is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+
+#
+# USB Multimedia devices
+#
+# CONFIG_USB_DABUSB is not set
+
+#
+# Video4Linux support is needed for USB Multimedia device support
+#
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET is not set
+# CONFIG_USB_ZD1201 is not set
+CONFIG_USB_MON=y
+
+#
+# USB port drivers
+#
+# CONFIG_USB_USS720 is not set
+
+#
+# USB Serial Converter support
+#
+# CONFIG_USB_SERIAL is not set
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_AUERSWALD is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_LED is not set
+CONFIG_USB_CYTHERM=m
+# CONFIG_USB_PHIDGETKIT is not set
+CONFIG_USB_PHIDGETSERVO=m
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_SISUSBVGA is not set
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TEST is not set
+
+#
+# USB DSL modem support
+#
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
+# SN Devices
+#
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=y
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
+# CONFIG_AUTOFS_FS is not set
+CONFIG_AUTOFS4_FS=y
+# CONFIG_FUSE_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+CONFIG_ISO9660_FS=y
+CONFIG_JOLIET=y
+# CONFIG_ZISOFS is not set
+CONFIG_UDF_FS=y
+CONFIG_UDF_NLS=y
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_HUGETLBFS is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+CONFIG_RELAYFS_FS=m
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Network File Systems
+#
+CONFIG_NFS_FS=y
+# CONFIG_NFS_V3 is not set
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+CONFIG_NFSD=y
+# CONFIG_NFSD_V3 is not set
+CONFIG_NFSD_TCP=y
+CONFIG_LOCKD=y
+CONFIG_EXPORTFS=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+# CONFIG_9P_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+
+#
+# Native Language Support
+#
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+CONFIG_NLS_CODEPAGE_437=y
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+CONFIG_NLS_ISO8859_1=y
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_UTF8 is not set
+
+#
+# Profiling support
+#
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_DEBUG_KERNEL=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_DETECT_SOFTLOCKUP=y
+# CONFIG_SCHEDSTATS is not set
+CONFIG_DEBUG_SLAB=y
+# CONFIG_DEBUG_PREEMPT is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_BUGVERBOSE=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_FS=y
+# CONFIG_FRAME_POINTER is not set
+CONFIG_EARLY_PRINTK=y
+CONFIG_DEBUG_STACKOVERFLOW=y
+# CONFIG_KPROBES is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_DEBUG_PAGEALLOC is not set
+# CONFIG_4KSTACKS is not set
+CONFIG_X86_FIND_SMP_CONFIG=y
+CONFIG_X86_MPPARSE=y
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+CONFIG_CRYPTO=y
+CONFIG_CRYPTO_HMAC=y
+CONFIG_CRYPTO_NULL=m
+# CONFIG_CRYPTO_MD4 is not set
+CONFIG_CRYPTO_MD5=y
+CONFIG_CRYPTO_SHA1=y
+CONFIG_CRYPTO_SHA256=m
+CONFIG_CRYPTO_SHA512=m
+# CONFIG_CRYPTO_WP512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+CONFIG_CRYPTO_DES=m
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+# CONFIG_CRYPTO_SERPENT is not set
+CONFIG_CRYPTO_AES=m
+CONFIG_CRYPTO_AES_586=y
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+# CONFIG_CRYPTO_TEA is not set
+CONFIG_CRYPTO_ARC4=m
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_DEFLATE is not set
+CONFIG_CRYPTO_MICHAEL_MIC=m
+# CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Hardware crypto devices
+#
+# CONFIG_CRYPTO_DEV_PADLOCK is not set
+
+#
+# Library routines
+#
+CONFIG_CRC_CCITT=m
+# CONFIG_CRC16 is not set
+CONFIG_CRC32=y
+CONFIG_LIBCRC32C=m
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y
+CONFIG_X86_BIOS_REBOOT=y
diff -Nru o-linux-2.6.14.5/drivers/block/cbd_int.c linux-2.6.14.5/drivers/block/cbd_int.c
--- o-linux-2.6.14.5/drivers/block/cbd_int.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.14.5/drivers/block/cbd_int.c	2006-01-22 00:22:27.000000000 -0800
@@ -0,0 +1,306 @@
+/*
+ *
+ * cbd_int.c - Compressed Block Device
+ *
+ * Copyright (C) 2005   Shaun Savage <ssavage@mti-interactive.com>
+ *
+ * Redistribution of this file is permitted under the
+ * GNU General Public License (GPL).
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/blkdev.h>
+#include <linux/bio.h>
+#include <linux/pagemap.h>
+#include <linux/list.h>
+#include <linux/init.h>
+#include <linux/genhd.h>
+#include <linux/buffer_head.h>
+#include <linux/spinlock.h>
+#include <linux/hdreg.h>
+#include <linux/zlib.h>
+
+#include <linux/cbd.h>
+
+static void add_part(int i,u_long off,u_long size,u_char type)
+{
+	struct cbd_device *cbd = cbd_device;
+	struct partition *diskpart = cbd->diskpart;
+
+	i--;
+	printk("add_part: %d %x %x\n",i,off,size);	
+#ifndef CBD_PARTITION
+  diskpart[i].start_sect = i+1 << 20;
+  diskpart[i].nr_sects = size>>9;
+  diskpart[i].sys_ind = 0xcb;
+
+  diskpart[i].cyl = 0 ;
+  diskpart[i].head = 0;
+  diskpart[i].sector = 0;
+
+  diskpart[i].end_cyl = 0;
+  diskpart[i].end_head = 0;
+  diskpart[i].end_sector = 0;
+#else
+	diskpart[i].partition = i;
+	diskpart[i].section = off;
+	diskpart[i].size = size;
+	diskpart[i].version = 0
+#endif
+}
+
+
+void newcbd_format(struct cbd_device *cbd, unsigned int sect, uchar * buff)
+{
+    	cbd_part_hdr_t *part = (cbd_part_hdr_t*)buff;
+    	int retval, i, partition;           // blocks = part->n_sections;
+	struct section_info *s_info = cbd->s_info;
+	unsigned int version, start, n, *blockmap;
+    	struct partition_info *pp;
+	struct cbd_part_content *cont,*contents;
+
+
+    	partition = part->cbd_minor;
+    	start = START_OF_SECTION(sect);
+    	version = part->version;
+	s_info[sect].partition = partition;
+	s_info[sect].status = SECT_OK;
+	s_info[sect].section_index = 0;
+    	pp = &cbd->p_info[partition];
+
+/*    
+    if (pp->is_valid)
+        if (((pp->version == version) && (pp->update_count < part->update_count)) || (pp->version < version)) {
+        printk ("newcbd release %px %px\n", pp->section_map, pp->cluster_map);
+        for(i=0;i<pp->sect_count;i++) {
+           SECT_STAT(pp->section_map[i]) = SECT_FF;
+           SECT_ACTIVE(pp->section_map[i]) = 0;
+        }
+        if (pp->section_map)
+            kfree(pp->section_map);
+        if (pp->cluster_map)
+            kfree(pp->cluster_map);
+        pp->version = 0;
+        pp->section_map = NULL;
+        pp->cluster_map = NULL;
+    }
+    if (pp->version)
+        return;
+*/
+	contents = part->content_table;
+    	blockmap = (uint *) ((uint) part + part->offset_section_table);
+
+    	pp->first_section = sect;
+    	pp->version = part->version;
+    	pp->update_count = part->update_count;
+    	pp->sect_count = part->n_sections;
+    	pp->clust_count = part->n_clusters;
+    	pp->c_shift = part->cluster_shift;
+    	pp->cluster_mask = (1U << (pp->c_shift + 10)) - 1;
+    	pp->section_map = (ushort *) kmalloc(pp->sect_count * sizeof(ushort), GFP_KERNEL);
+	if(!pp->section_map)
+		return -ENOMEM;
+    	memcpy(pp->section_map, (char *) part + part->offset_section_table, pp->sect_count * sizeof(ushort));
+    	pp->header=NULL;
+//    	pp->cluster_map = (u_int *) kmalloc(pp->clust_count * sizeof(u_int), GFP_KERNEL);
+//	if(!pp->cluster_map)
+//		return -ENOMEM;
+//    	memcpy(pp->cluster_map, (char *) part + part->offset_section_table, pp->clust_count * sizeof(u_int));
+
+
+    	for (i = 0; i < pp->sect_count; i++) {
+        	ushort section = pp->section_map[i];
+        	SECT_PART(section) = partition;
+        	SECT_STAT(section) = SECT_OK;
+        	SECT_NEXT(section) = pp->section_map[i + 1];
+        	SECT_IDX(section) = i;
+    	}
+
+    	pp->content_count = part->n_content;
+    	for (i = 0; i < part->n_content; i++) {
+        	content_t *pc = &pp->content[i];
+        	cont = &contents[i];
+        	memcpy(pc->name,cont->name,4);
+        	pc->length = cont->length;
+
+        	switch (*(uint *) cont->name) {
+        	case CLST:
+		{
+            		pp->length = cont->length - (pp->clust_count * sizeof(uint));
+            		pp->fs_offset = cont->offset + (pp->clust_count * sizeof(uint));
+            		printk("CLST %x %x %x\n",pp->fs_offset,cont->offset, pp->clust_count);
+            		pp->cluster_map = (uint *) kmalloc(pp->clust_count * sizeof(uint), GFP_KERNEL);
+            		memset(pp->cluster_map, 0, pp->clust_count * sizeof(uint));
+            		n = cbd_read (cbd,start+cont->offset,pp->clust_count*sizeof(u_int),&retval,(u_char *)pp->cluster_map);
+            		break;
+		}
+        	case PHDR: 
+		{
+            		char *partheader;
+//            		n = cbd_block_read (cbd,partheader,start + cont->offset,cont->length);
+	    		partheader[cont->length] = 0;
+            		pp->header = partheader;
+            		printk("HEADER: %s\n",partheader);
+            		//partheader_parse(partheader);
+            		break;
+		}
+        	case DICT:
+        	case MKEY:
+        	case OKEY:
+        	case RKEY:
+        	case NONE:
+        	default:
+            		break;
+        	}
+    	}
+    	pp->is_valid = 1;
+	
+}
+
+static int make_parts (struct cbd_device *cbd)
+{
+	int i, err = 0;
+	struct section_info *s_info;
+	struct partition_info *p_info;
+
+/* assume p_info->sect_count,p_info data is zero */
+	for (i=cbd->nr_sections;i>0;i--) {
+		s_info = &(cbd->s_info[i]);
+		if (s_info->status != SECT_OK)
+			continue;
+		p_info = &cbd->p_info[s_info->partition];
+		p_info->first_section = i;
+		p_info->sect_count++;
+	}
+
+	memset(cbd->diskpart,0,15*sizeof(struct partition));
+
+	for (i=1;i<16;i++) {
+		struct partition_info *pi = &(cbd->p_info[i]);
+		if (!pi->is_valid)
+			continue;
+		add_part(i,pi->first_section,pi->clust_count*32768,0xcb);
+	}
+	return err;
+}
+
+/* move into cbd code file */
+int scan_block(struct cbd_device *cbd)
+{
+        int err =0;
+        size_t retsiz;
+        u_char buf[4096];
+        struct block_device *bd = cbd->blkdev;
+//      struct gendisk *gd = bd->bd_disk;
+//      unsigned bsiz = bd->bd_block_size;
+        struct hd_struct *part = bd->bd_part;
+        sector_t nr_sects = part->nr_sects;
+        u_long i, sect = nr_sects>>7;
+        struct section_info *s_info;
+
+//      printk("NR_SECT %x %x \n",nr_sects, sect);
+
+        for(i=1;i<sect;i++) {
+                loff_t off;
+                s_info = &cbd->s_info[i];
+                off = i << 16;
+                if (!(i%16))
+                        printk(".");
+                if ((s_info->status==SECT_OK)||(s_info->status==SECT_BIOS))
+                        continue;
+                err = cbd_read(cbd,(loff_t)off,(size_t)4096,&retsiz,buf);
+                if (err < 0 ) {
+                        printk("rderr %x\n",err);
+                        break;
+                }
+                if (CBD_MAGIC != *(u_long*)buf)
+                        continue;
+                printk("NEW_PART %x\n",i);
+                // now parse the cbd_partition data
+                newcbd_format(cbd,i,buf);
+        }
+        printk("\n");
+	if(err>=0) {
+		err = make_parts(cbd);
+	}
+        return err;
+}
+
+int cbd_decomp_init(struct cbd_device *cbd)
+{
+        int ret = 0;
+        struct z_stream_s *stream = &cbd->decomp_stream;
+
+        stream->workspace = kmalloc(zlib_inflate_workspacesize(), GFP_KERNEL);
+        if (!stream->workspace ) {
+                ret = -ENOMEM;
+                goto out;
+        }
+        memset(stream->workspace, 0, zlib_inflate_workspacesize());
+        ret = zlib_inflateInit2(stream,-15);
+        if (ret != Z_OK) {
+                ret = -EINVAL;
+                goto out_free;
+        }
+out:
+        return ret;
+out_free:
+        kfree(stream->workspace);
+	goto out;
+}
+
+void cbd_decomp_exit(struct cbd_device *cbd)
+{
+        zlib_inflateEnd(&cbd->decomp_stream);
+        kfree(cbd->decomp_stream.workspace);
+}
+
+int cbd_decompress(void *vcbd, const u8 *src, unsigned int slen,
+                              u8 *dst, unsigned int *dlen)
+{
+
+        int ret = 0;
+        struct cbd_device *cbd = vcbd;
+        struct z_stream_s *stream = &cbd->decomp_stream;
+
+        stream->next_in = (u8 *)src;
+        stream->avail_in = slen;
+        stream->next_out = (u8 *)dst;
+        stream->avail_out = *dlen;
+
+        ret = zlib_inflateReset(stream);
+        if (ret != Z_OK) {
+		printk("inflateReset\n");
+                ret = -EINVAL;
+                goto out;
+        }
+
+        stream->next_in = (u8 *)src;
+        stream->avail_in = slen;
+        stream->next_out = (u8 *)dst;
+        stream->avail_out = *dlen;
+
+        ret = zlib_inflate(stream, Z_SYNC_FLUSH);
+        /*
+         * Work around a bug in zlib, which sometimes wants to taste an extra
+         * byte when being used in the (undocumented) raw deflate mode.
+         * (From USAGI).
+         */
+        if (ret == Z_OK && !stream->avail_in && stream->avail_out) {
+                u8 zerostuff = 0;
+                stream->next_in = &zerostuff;
+                stream->avail_in = 1;
+                ret = zlib_inflate(stream, Z_FINISH);
+        }
+        if (ret != Z_STREAM_END) {
+                ret = -EINVAL;
+                goto out;
+        }
+        ret = 0;
+        *dlen = stream->total_out;
+out:
+        return ret;
+}
+
+
diff -Nru o-linux-2.6.14.5/drivers/block/cbd_main.c linux-2.6.14.5/drivers/block/cbd_main.c
--- o-linux-2.6.14.5/drivers/block/cbd_main.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.14.5/drivers/block/cbd_main.c	2006-01-22 00:25:58.000000000 -0800
@@ -0,0 +1,882 @@
+/*
+ *
+ * cbd.c - Compressed Block Device
+ *
+ * Copyright (C) 2005	Shaun Savage <savages@savages.com>
+ *
+ * Redistribution of this file is permitted under the 
+ * GNU General Public License (GPL).
+ */
+ /** cbd.c
+ ** (C) 2000 rewritten by Shaun Savage
+ **
+ ** igel.c - flash driver
+ **
+ ** (C) IGEL GmbH, 1996, 1997
+ **
+ ** Based on the linux ramdisk driver
+ **
+ ** 24.9.96 charles@igel, tom@igel
+ **/
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/blkdev.h>
+#include <linux/bio.h>
+#include <linux/pagemap.h>
+#include <linux/list.h>
+#include <linux/init.h>
+#include <linux/genhd.h>
+#include <linux/buffer_head.h>
+#include <linux/spinlock.h>
+#include <linux/hdreg.h>
+#include <linux/zlib.h>
+
+#include <linux/cbd.h>
+
+#define VERSION "$Revision: 1.3 $"
+
+
+#define ERROR(fmt, args...) printk(KERN_ERR "cbd: " fmt "\n" , ## args)
+#define INFO(fmt, args...) printk(KERN_INFO "cbd: " fmt "\n" , ## args)
+
+#define CBD_MAJOR 102
+
+/* Static info about the CBD, used in cleanup_module */
+struct cbd_device *cbd_device = NULL;
+extern u_char cbd_MBR[512];
+//extern u_char *cbd_zipbuf = NULL;
+u_char cbd_zipbuf[32768];
+ 
+#define PAGE_READAHEAD 8
+void cache_readahead(struct address_space *mapping, int index)
+{
+	filler_t *filler = (filler_t*)mapping->a_ops->readpage;
+	int i, pagei;
+	unsigned ret = 0;
+	unsigned long end_index;
+	struct page *page;
+	LIST_HEAD(page_pool);
+	struct inode *inode = mapping->host;
+	loff_t isize = i_size_read(inode);
+
+	if (!isize) {
+		INFO("iSize=0 in cache_readahead\n");
+		return;
+	}
+
+	end_index = ((isize - 1) >> PAGE_CACHE_SHIFT);
+
+	read_lock_irq(&mapping->tree_lock);
+	for (i = 0; i < PAGE_READAHEAD; i++) {
+		pagei = index + i;
+		if (pagei > end_index) {
+			INFO("Overrun end of disk in cache readahead\n");
+			break;
+		}
+		page = radix_tree_lookup(&mapping->page_tree, pagei);
+		if (page && (!i))
+			break;
+		if (page)
+			continue;
+		read_unlock_irq(&mapping->tree_lock);
+		page = page_cache_alloc_cold(mapping);
+		read_lock_irq(&mapping->tree_lock);
+		if (!page)
+			break;
+		page->index = pagei;
+		list_add(&page->lru, &page_pool);
+		ret++;
+	}
+	read_unlock_irq(&mapping->tree_lock);
+	if (ret) {
+		read_cache_pages(mapping, &page_pool, filler, NULL);
+	}
+	
+}
+
+static struct page* page_readahead(struct address_space *mapping, int index)
+{
+	//printk("prah\n");
+	filler_t *filler = (filler_t*)mapping->a_ops->readpage;
+	cache_readahead(mapping, index);
+	return read_cache_page(mapping, index, filler, NULL);
+}
+
+int cbd_read(struct cbd_device *dev, loff_t from, size_t len,
+		size_t *retlen, u_char *buf)
+{
+	struct page *page;
+	int index = from >> PAGE_SHIFT;
+	int offset = from & (PAGE_SIZE-1);
+	int cpylen;
+//	loff_t size = 4096;
+
+//	if (from > size)
+//		return -EINVAL;
+//	if (from + len > size)
+//		len = size - from;
+
+	if (retlen)
+		*retlen = 0;
+
+	while (len) {
+		if ((offset + len) > PAGE_SIZE)
+			cpylen = PAGE_SIZE - offset;	// multiple pages
+		else
+			cpylen = len;	// this page
+		len = len - cpylen;
+
+		//      Get page
+		page = page_readahead(dev->blkdev->bd_inode->i_mapping, index);
+		if (!page)
+			return -ENOMEM;
+		if (IS_ERR(page))
+			return PTR_ERR(page);
+
+		memcpy(buf, page_address(page) + offset, cpylen);
+		page_cache_release(page);
+
+		if (retlen)
+			*retlen += cpylen;
+		buf += cpylen;
+		offset = 0;
+		index++;
+	}
+	return 0;
+}
+
+/* write data to the underlying device */
+static int _cbd_write(struct cbd_device *dev, const u_char *buf,
+		loff_t to, size_t len, size_t *retlen)
+{
+	struct page *page;
+	struct address_space *mapping = dev->blkdev->bd_inode->i_mapping;
+	int index = to >> PAGE_SHIFT;	// page index
+	int offset = to & ~PAGE_MASK;	// page offset
+	int cpylen;
+
+	if (retlen)
+		*retlen = 0;
+	while (len) {
+		if ((offset+len) > PAGE_SIZE) 
+			cpylen = PAGE_SIZE - offset;	// multiple pages
+		else
+			cpylen = len;			// this page
+		len = len - cpylen;
+
+		//	Get page
+		page = page_readahead(mapping, index);
+		if (!page)
+			return -ENOMEM;
+		if (IS_ERR(page))
+			return PTR_ERR(page);
+
+		if (memcmp(page_address(page)+offset, buf, cpylen)) {
+			lock_page(page);
+			memcpy(page_address(page) + offset, buf, cpylen);
+			set_page_dirty(page);
+			unlock_page(page);
+		}
+		page_cache_release(page);
+
+		if (retlen)
+			*retlen += cpylen;
+
+		buf += cpylen;
+		offset = 0;
+		index++;
+	}
+	return 0;
+}
+
+static int cbd_write(struct cbd_device *dev, loff_t to, size_t len,
+		size_t *retlen, const u_char *buf)
+{
+	int err;
+
+	if (!len)
+		return 0;
+	//if (to >= mtd->size)
+	//	return -ENOSPC;
+	//if (to + len > mtd->size)
+	//	len = mtd->size - to;
+
+	down(&dev->write_mutex);
+	err = _cbd_write(dev, buf, to, len, retlen);
+	up(&dev->write_mutex);
+	if (err > 0)
+		err = 0;
+	return err;
+}
+
+enum {
+        Lo_unbound,
+        Lo_bound,
+        Lo_rundown,
+};
+
+static int do_cbd_send(struct cbd_device *cbd, struct bio_vec *bvec, int partno, loff_t pos, struct page *page)
+{
+	char * pagebuf;
+	int err, retval;
+	//printk("do_send \n");
+	pagebuf = kmap_atomic(bvec->bv_page, KM_USER0) + bvec->bv_offset;
+	err = cbd_write(cbd,pos,bvec->bv_len,&retval,pagebuf);
+	kunmap_atomic(pagebuf,KM_USER0);
+	return 0;
+}
+
+static int do_cbd_receive(struct cbd_device *cbd,
+              struct bio_vec *bvec, int partno, loff_t pos)
+{
+        int err, retval;
+	char * pagebuf;
+
+	//printk("do_receive >%x %x %x\n",pos,bvec->bv_offset,bvec->bv_len);
+	if (bvec->bv_len>4096)
+		return -EIO;
+	pagebuf = kmap_atomic(bvec->bv_page, KM_USER0) + bvec->bv_offset;
+	
+	if (pos == 0 && partno == 0) {
+		memset(pagebuf,0,bvec->bv_len);
+		memcpy(pagebuf+0x1be,cbd->diskpart,4*sizeof(struct partition));
+		*(u_short*)(pagebuf+510) = 0xaa55;
+	} else {
+		err = cbd_read(cbd,pos,bvec->bv_len,&retval,pagebuf);
+	}
+	kunmap_atomic(pagebuf,KM_USER0);
+	return 0;
+}
+
+static int cbd_send(struct cbd_device *cbd, struct bio *bio, int partno,
+        sector_t sector)
+{
+        struct bio_vec *bvec;
+        struct page *page = NULL;
+        int i, ret = 0;
+	loff_t pos;
+
+	pos = ((loff_t) bio->bi_sector << 9);  //???cbd_offset
+        bio_for_each_segment(bvec, bio, i) {
+                ret = do_cbd_send(cbd, bvec, partno, pos, page);
+                if (ret < 0)
+                        break;
+                pos += bvec->bv_len;
+        }
+        if (page) {
+                kunmap(page);
+                __free_page(page);
+        }
+        return ret;
+}
+
+static int cbd_lokpage(struct cbd_device *cbd, struct bio *bio, int partno,
+        sector_t sector)
+{
+        struct bio_vec *bvec;
+        int i, ret = 0;
+	loff_t pos;
+
+	pos = ((loff_t) bio->bi_sector << 9);  //???cbd_offset
+        bio_for_each_segment(bvec, bio, i) {
+		SetPageReserved(bvec->bv_page);
+                if (ret < 0)
+                        break;
+                pos += bvec->bv_len;
+        }
+        return ret;
+}
+
+static int
+cbd_receive(struct cbd_device *cbd, struct bio *bio, int partno, sector_t sector)
+{
+        struct bio_vec *bvec;
+	int i=0, ret=0;
+	loff_t pos;
+
+	pos = ((loff_t) sector << 9);  //???cbd_offset
+        bio_for_each_segment(bvec, bio, i) {
+                ret = do_cbd_receive(cbd, bvec, partno, pos);
+                if (ret < 0)
+                        break;
+                pos += bvec->bv_len;
+        }
+        return ret;
+}
+
+static u_char srcbuf[32768];
+static int fill_zip(struct cbd_device *cbd,u_int section,struct partition_info *pp )
+{
+	u_int comp_off,sz,sect,start,retval,ret;
+
+	comp_off = pp->cluster_map[section]; //offset into filea
+	sz = pp->cluster_map[section+1] - comp_off;
+	start = (comp_off+pp->fs_offset) >> CBD_SECTION_SHIFT;
+	sect = pp->section_map[start];
+	start = (comp_off+pp->fs_offset) & (CBD_SECTION_SIZE - 1);
+	//sect is section, so sect<<15 is byte offset 
+	//start is offset into that section
+	//printk("toREAD: %x %x %x\n",sect,start,sz);
+	retval=8192;
+	ret = cbd_read(cbd,(sect<<16)+start,sz,&retval,srcbuf);
+	if (ret<0) {
+		printk("decomp rderr %x\n",ret);
+		return ret;
+	}
+	retval=32768;
+	ret=-1;
+	ret = cbd_decompress(cbd,srcbuf,sz,cbd_zipbuf,&retval);
+	if(ret<0) {
+		printk("decomp %x\n",ret);
+		return ret;
+	}
+	return 0;
+}
+
+static int
+cbd_decomp(struct cbd_device *cbd, struct bio *bio, int partno, sector_t sector)
+{
+        struct bio_vec *bvec;
+	int i=0, ret=0;
+	struct partition_info *pp;
+	u_int offset, zipcnt=0, srccnt=0;
+	u_char *zipptr, *srcptr;
+	u_int section;
+	u_int pageptr;
+
+	//printk("DECOMP: %x %x %x %x\n",partno,sector,bio_sectors(bio),bio->bi_size);
+	pp = &cbd->p_info[partno];
+	if (!pp->is_valid)
+		return -EIO;
+
+	section = sector>>6;
+	offset = (sector & 0x03f)<<9;
+	zipptr = cbd_zipbuf+offset;
+	zipcnt = 0;
+        bio_for_each_segment(bvec, bio, i) {
+		char *pageptr, *pagebuf;
+		u_int left;
+		pageptr = pagebuf =kmap_atomic(bvec->bv_page, KM_USER0) + bvec->bv_offset;
+		left = bvec->bv_len;
+again:
+		//printk("EACH: %x %x %x\n",left,zipcnt,offset);
+		if(left > zipcnt) {
+			// data on two different sections
+			if (zipcnt)
+				memcpy(pageptr,zipptr,zipcnt);
+			left -= zipcnt;
+			pageptr += zipcnt;
+			ret = fill_zip(cbd,section++,pp);
+			if (ret<0) {
+				printk("fill_zip failed\n");
+				kunmap_atomic(pagebuf,KM_USER0);
+				return ret;
+			}
+			zipptr = cbd_zipbuf + offset;
+			zipcnt = 32768 - offset;
+			offset = 0;
+			if ( left > zipcnt) {
+				//data starts on end of section to next section
+				goto again;
+			}
+			//printk("2");
+		}
+		//printk("copy %x %x\n",left,zipcnt,offset);
+		memcpy(pageptr,zipptr,left);
+                zipptr += left;
+		zipcnt -= left;
+		kunmap_atomic(pagebuf,KM_USER0);
+        }
+        return ret;
+}
+
+static inline void cbd_handle_bio(struct cbd_device *cbd, struct bio *bio)
+{
+	int ret;
+	int partno;
+	sector_t sector;
+	struct partition_info *pp;
+	loff_t pos;
+
+	partno = (bio->bi_sector >> 20);
+	sector = (0x0fffff & bio->bi_sector);
+	pos = ((loff_t) sector << 9) + cbd->cbd_offset; //???cbd_offset
+	if (partno < 0 || partno >15) {
+		ret = -EINVAL;
+		goto  end;
+	}
+	pp = &cbd->p_info[partno];
+	if (!pp->is_valid && partno != 0) {
+		ret = -EINVAL;
+		goto end;
+	}
+	//printk("BIO: %d %d %x %x %p\n",partno,bio_rw(bio),sector,pos,pp);
+        if (bio_rw(bio) == WRITE)
+		if (partno == 0)
+	        	ret = cbd_send(cbd, bio, partno, sector);
+		else
+			ret = cbd_lokpage(cbd,bio,partno,sector);
+        else
+		if (partno == 0)
+			ret = cbd_receive(cbd, bio, partno, sector);
+		else
+			ret = cbd_decomp(cbd, bio, partno, sector);
+end:
+        bio_endio(bio, bio->bi_size, ret);
+}
+ 
+/*
+ * Grab first pending buffer
+ */
+static struct bio *cbd_get_bio(struct cbd_device *cbd)
+{
+        struct bio *bio;
+
+        if ((bio = cbd->cbd_bio)) {
+                if (bio == cbd->cbd_biotail)
+                        cbd->cbd_biotail = NULL;
+                cbd->cbd_bio = bio->bi_next;
+                bio->bi_next = NULL;
+        }
+
+        return bio;
+}
+
+/*
+ * worker thread that handles reads/writes to file backed loop devices,
+ * to avoid blocking in our make_request_fn. it also does loop decrypting
+ * on reads for block backed loop, as that is too heavy to do from
+ * b_end_io context where irqs may be disabled.
+ */
+static int cbd_thread(void *data)
+{
+        struct cbd_device *cbd = data;
+        struct bio *bio;
+
+        daemonize("cbdd");
+
+        //printk("cbd_thread\n");
+        /*
+         * loop can be used in an encrypted device,
+         * hence, it mustn't be stopped at all
+         * because it could be indirectly used during suspension
+         */
+        current->flags |= PF_NOFREEZE;
+
+        set_user_nice(current, -20);
+
+        cbd->cbd_state = Lo_bound;
+        cbd->cbd_pending = 1;
+
+        /*
+         * up sem, we are running
+         */
+        up(&cbd->cbd_sem);
+
+        for (;;) {
+                int pending;
+
+                /*
+                 * interruptible just to not contribute to load avg
+                 */
+                if (down_interruptible(&cbd->cbd_bh_mutex))
+                        continue;
+
+                spin_lock_irq(&cbd->cbd_lock);
+
+                /*
+                 * could be upped because of tear-down, not pending work
+                 */
+                if (unlikely(!cbd->cbd_pending)) {
+                        spin_unlock_irq(&cbd->cbd_lock);
+                        break;
+                }
+
+                bio = cbd_get_bio(cbd);
+        	//printk("cbd_thread next %p\n",bio);
+                cbd->cbd_pending--;
+                pending = cbd->cbd_pending;
+                spin_unlock_irq(&cbd->cbd_lock);
+
+                BUG_ON(!bio);
+                cbd_handle_bio(cbd, bio);
+
+                /*
+                 * upped both for pending work and tear-down, lo_pending
+                 * will hit zero then
+                 */
+                if (unlikely(!pending))
+                        break;
+        }
+
+        up(&cbd->cbd_sem);
+        return 0;
+}
+ 
+/*
+ * Add bio to back of pending list
+ */
+static void cbd_add_bio(struct cbd_device *cbd, struct bio *bio)
+{
+	//printk("add_bio\n");
+        if (cbd->cbd_biotail) {
+                cbd->cbd_biotail->bi_next = bio;
+                cbd->cbd_biotail = bio;
+        } else
+                cbd->cbd_bio = cbd->cbd_biotail = bio;
+}
+
+static int cbd_make_request(request_queue_t *q, struct bio *old_bio)
+{
+        struct cbd_device *cbd = q->queuedata;
+        int rw = bio_rw(old_bio);
+
+        if (rw == READA)
+                rw = READ;
+
+        //printk("cbd_make_request\n");
+        BUG_ON(!cbd || (rw != READ && rw != WRITE));
+
+        spin_lock_irq(&cbd->cbd_lock);
+        if (cbd->cbd_state != Lo_bound)
+                goto out;
+        //if (unlikely(rw == WRITE && (cbd->cbd_flags & LO_FLAGS_READ_ONLY)))
+        //        goto out;
+        cbd->cbd_pending++;
+	if (0) {
+		old_bio->bi_bdev = cbd->blkdev;
+		return 1;
+	}
+        cbd_add_bio(cbd, old_bio);
+        spin_unlock_irq(&cbd->cbd_lock);
+        up(&cbd->cbd_bh_mutex);
+        return 0;
+
+out:
+        if (cbd->cbd_pending == 0)
+                up(&cbd->cbd_bh_mutex);
+        spin_unlock_irq(&cbd->cbd_lock);
+        bio_io_error(old_bio, old_bio->bi_size);
+        return 0;
+}
+
+/* sync the device - wait until the write queue is empty */
+static void cbd_sync(struct cbd_device *dev)
+{
+	sync_blockdev(dev->blkdev);
+	return;
+}
+
+/* See add_device to fix */
+static void cbd_free_device(struct cbd_device *dev)
+{
+	if (!dev)
+		return;
+
+	if (dev->blkdev) {
+		invalidate_inode_pages(dev->blkdev->bd_inode->i_mapping);
+		close_bdev_excl(dev->blkdev);
+	}
+	if (dev->disk) {
+		del_gendisk(dev->disk);
+		put_disk(dev->disk);
+	}
+	if (dev->cbd_queue) {
+		blk_put_queue(dev->cbd_queue);
+	}
+
+	kfree(dev);
+}
+
+extern int scan_block(struct cbd_device *cbd);
+static int cbd_reval(struct gendisk * gh)
+{
+        struct cbd_device *cbd = gh->private_data;
+	printk("ReValidate\n");
+	return scan_block( cbd );
+}
+
+static int cbd_mchg(struct gendisk * gh)
+{
+//        struct cbd_device *cbd = gh->private_data;
+	printk("Media Change\n");
+	return 0;
+}
+
+static int cbd_release(struct inode * inode, struct file * filp)
+{
+//        struct cbd_device *cbd = inode->i_bdev->bd_disk->private_data;
+	printk("RELEASE\n");
+	return 0;
+}
+ 
+static int cbd_open(struct inode * inode, struct file * filp)
+{
+//        struct cbd_device *cbd = inode->i_bdev->bd_disk->private_data;
+	printk("OPEN\n");
+	return 0;
+}
+
+/*
+ *   IOCTL stuff, maybe new file
+ */
+
+#define _COPYOUT(x) (copy_to_user((void __user *)arg, &(x), sizeof(x)) ? -EFAULT : 0)
+#define _COPYIN(x) (copy_from_user(&(x), (void __user *)arg, sizeof(x)) ? -EFAULT : 0)
+
+static int cbd_ioctl(struct inode * inode, struct file * filp, unsigned cmd, cbd_ioctl_t *arg)
+{
+        struct cbd_device *cbd = inode->i_bdev->bd_disk->private_data;
+ 	int sect, len;
+	int data;
+	int length, ret;
+	char  *ptr;
+	struct section_info *s_info = cbd->s_info;
+
+    	printk("CBDioctl %x %x %p\n", arg->data, arg->length,arg->ptr);
+	if (!inode || !inode->i_rdev)
+        	return -EINVAL;
+    	data = arg->data;
+    	length = arg->length;
+    	ptr = arg->ptr;
+
+    	switch (cmd) {
+        case HDIO_GETGEO:
+                {
+                        struct hd_geometry loc;
+                        loc.heads = 4;
+                        loc.sectors = 32;
+                        loc.cylinders = cbd->nr_sections;
+                        loc.start = 0;
+                        return _COPYOUT(loc);
+                }
+
+    	case CBD_ERASE_SECTION:
+    	case CBD_INVAL_PARTITION:
+    	case CBD_GET_PARTITION_VERSION: 
+     	case CBD_GET_SIZE: 
+    	case CBD_GET_FREE_PART:
+     	case CBD_GET_PART_HEADER:
+//        	if(PART_VALID(data) == 0)
+//           		return -EINVAL;
+//        	len = strlen(p_info[data].header);
+//        	if(length < len)
+//           		return -EINVAL;
+//        	copy_to_user(arg->ptr,(void*)p_info[data].header,len);
+//        	arg->length = len;
+        	return 0;
+ 
+     	case CBD_COMMIT_PARTITION:
+        {
+            unsigned short *map = (unsigned int*) ptr;
+            //printk("inval_part %ld %lx\n",part,arg);
+            if ((data < 0) || (data > 15))
+                return -EINVAL;
+            if (PART_MOUNT(data)) {
+                /* if mounted give error */
+                return -EBUSY;
+            }
+
+            for (sect = 0;
+                 (sect < length);
+                 sect++) {
+		if (SECT_STAT(map[sect]) == SECT_RESV)
+                	SECT_STAT(map[sect]) = SECT_COMMIT;
+		else
+			printk("BAD section %x\n",sect);
+            }
+            PART_VALID(data) = 1;
+
+            /* TODO: inform the manager that this minor is there! */
+#if 0
+	    blkpg_part.start = data<<20;
+	    blkpg_part.length = length*32768;
+	    blkpg_part.pno = data;
+	    blkpg_part.devname = "p%d";
+	    blkpg_part.volname = "cbdp%d";
+	    blkpg_ioctl.op = BLKPG_ADD_PARTITION;
+	    blkpg_ioctl.flags = 0;
+	    blkpg_ioctl.datalen = sizeof(blkpg_part);
+	    blkpg_ioctl.data = &blkpg_part;
+	    cbd->blkdev->ioctl(,BLKPG,);
+#endif
+#if 0	    
+	    scan_block(cbd);	// added partition internal
+	    add_partition(cbd->disk,data,data<<20,length*32768);
+		ret = rescan_partitions(cbd->disk,cbd->blkdev);
+		printk("rescan_part %x\n",ret);
+#endif
+            return 0;
+        }
+    	case CBD_GET_FREE_SECTION:
+       		sect = data>0? data: 1;
+           	//printk("FREE %x\n",sect);
+       		if (sect < 0)
+           		return -EINVAL;
+       		for (; sect < cbd->nr_sections; sect++) {
+           		if ((SECT_STAT(sect)!=SECT_OK) &&
+				(SECT_STAT(sect)!=SECT_BIOS) &&
+				(SECT_STAT(sect)!=SECT_COMMIT) &&
+				(SECT_STAT(sect)!=SECT_RESV)) {
+               			arg->data = sect;
+				SECT_STAT(sect) = SECT_RESV;
+               			return 0;
+			}
+		}
+       		arg->data = -1; /* Sorry, no section available */
+       		return -EINVAL;
+    	default:
+        	return -EINVAL;
+
+    }
+
+
+	return 0;
+}
+
+struct block_device_operations cbd_fops = {
+        .owner =        THIS_MODULE,
+        .open =         cbd_open,
+        .release =      cbd_release,
+        .ioctl =        cbd_ioctl,
+        .media_changed = cbd_mchg,
+        .revalidate_disk = cbd_reval,
+};
+
+/* make the block device disk  
+ *  this is the magic
+ */
+static int add_device(char *devname, int erase_size)
+{
+	struct block_device *bdev;
+	struct cbd_device *cbd;
+	struct gendisk *disk;
+	struct section_info *s_info;
+	int ret=0;
+
+	if (!devname)
+		return -EINVAL;
+
+	cbd = kmalloc(sizeof(struct cbd_device), GFP_KERNEL);
+	if (!cbd)
+		return -ENOMEM;
+	memset(cbd, 0, sizeof(*cbd));
+
+	cbd_device  = cbd;
+
+        if (register_blkdev(CBD_MAJOR, "cbd"))
+                goto out_err1;
+
+        disk = alloc_disk(16);
+        if (!disk)
+                goto out_err2;
+	cbd->disk = disk;
+
+//        devfs_mk_dir("cbd");
+
+        cbd->cbd_queue = blk_alloc_queue(GFP_KERNEL);
+        if (!cbd->cbd_queue)
+                goto out_err3;
+        blk_queue_make_request(cbd->cbd_queue, &cbd_make_request);
+        cbd->cbd_queue->queuedata = cbd;
+
+	init_MUTEX(&cbd->write_mutex);
+	init_MUTEX(&cbd->cbd_ctl_mutex);
+	init_MUTEX_LOCKED(&cbd->cbd_sem);
+	init_MUTEX_LOCKED(&cbd->cbd_bh_mutex);
+        spin_lock_init(&cbd->cbd_lock);
+
+        disk->major = CBD_MAJOR;
+        disk->first_minor = 0;
+        disk->fops = &cbd_fops;
+        sprintf(disk->disk_name, "cbd/p");
+        sprintf(disk->devfs_name, "cbd/p");
+        disk->private_data = cbd;
+        disk->queue = cbd->cbd_queue;
+ 
+	/* Get a handle on the device */
+	bdev = open_bdev_excl(devname, O_RDWR, NULL);
+	if (IS_ERR(bdev)) {
+		ERROR("error: cannot open device %s", devname);
+		goto out_err4;
+	}
+	cbd->blkdev = bdev;
+	bdev->bd_private = (void*)cbd;
+	cbd->nr_sections = bdev->bd_part->nr_sects>>7; //ignore rest
+        set_capacity(disk, cbd->nr_sections<<7); //64k -> 512
+	
+	s_info = (struct section_info*)kmalloc(cbd->nr_sections * sizeof(struct section_info),GFP_KERNEL);
+	if (!s_info)
+		goto out_err5;
+	memset(s_info,0,sizeof(struct section_info)*cbd->nr_sections);
+	cbd->s_info = s_info; 
+	SECT_STAT(0) = SECT_BIOS;
+
+	ret = scan_block( cbd );
+	if (ret<0)  //lookup macro 
+		goto out_err6;
+
+	ret = cbd_decomp_init(cbd);
+	if (ret<0)
+		goto out_err6;
+
+	ret = kernel_thread(cbd_thread, cbd, CLONE_KERNEL);
+	if (ret<0)
+		goto out_err7;
+ 
+	INFO("cbd: Device=%s sections=%d size=%d]",devname,cbd->nr_sections,cbd->nr_sections<<16 );
+        down(&cbd->cbd_sem);
+	add_disk(disk);
+	return 0;
+
+out_err7:
+//cleanup
+	return ret;
+out_err6:
+	kfree(s_info);
+out_err5:
+	close_bdev_excl(bdev);
+out_err4:
+	blk_put_queue(cbd->cbd_queue);
+out_err3:
+	put_disk(disk);
+out_err2:
+        unregister_blkdev(CBD_MAJOR, "cbd");
+out_err1:
+	kfree(cbd);
+	return ret;
+
+
+}
+
+static char cbd_blkdev_str[64];
+module_param_string(cbd_blkdev, cbd_blkdev_str, 64, 0);
+MODULE_PARM_DESC(cbd, "Device to use. \"cbd_blkdev=<dev>\"");
+
+static int __init cbd_init(void)
+{
+	INFO("version " VERSION);
+	printk("cbd_init: Device=%s\n",cbd_blkdev_str);
+	return add_device(cbd_blkdev_str,0);
+}
+
+
+static void __devexit cbd_exit(void)
+{
+	struct cbd_device *dev = cbd_device;
+	cbd_sync(dev);
+	INFO("cbd: removed");
+
+        unregister_blkdev(CBD_MAJOR, "cbd");
+ 
+	cbd_free_device(dev);
+}
+
+
+module_init(cbd_init);
+module_exit(cbd_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Shaun Savage <savages@savages.net>");
+MODULE_DESCRIPTION("Compressed Block Device");
diff -Nru o-linux-2.6.14.5/drivers/block/Kconfig linux-2.6.14.5/drivers/block/Kconfig
--- o-linux-2.6.14.5/drivers/block/Kconfig	2005-12-26 16:26:33.000000000 -0800
+++ linux-2.6.14.5/drivers/block/Kconfig	2006-01-22 00:16:13.000000000 -0800
@@ -342,6 +342,18 @@
 
 	  If unsure, say N.
 
+config BLK_DEV_CBD
+	tristate "Compressed Block Device driver"
+	---help---
+	  Saying Y or M here will enable support for the 
+	  compresed block device for Secure booting embedded system.
+
+config BLK_CBD_DEVICE
+	string "CBD base device /dev/XXXX"
+	depends BLK_DEV_CBD
+	---help---
+	  Base Block Device  
+
 config BLK_DEV_SX8
 	tristate "Promise SATA SX8 support"
 	depends on PCI
diff -Nru o-linux-2.6.14.5/drivers/block/Makefile linux-2.6.14.5/drivers/block/Makefile
--- o-linux-2.6.14.5/drivers/block/Makefile	2005-12-26 16:26:33.000000000 -0800
+++ linux-2.6.14.5/drivers/block/Makefile	2006-01-22 00:02:25.000000000 -0800
@@ -44,4 +44,6 @@
 obj-$(CONFIG_VIODASD)		+= viodasd.o
 obj-$(CONFIG_BLK_DEV_SX8)	+= sx8.o
 obj-$(CONFIG_BLK_DEV_UB)	+= ub.o
+obj-$(CONFIG_BLK_DEV_CBD)	+= cbd.o
+cbd-objs			:= cbd_main.o cbd_int.o
 
diff -Nru o-linux-2.6.14.5/include/linux/cbd.h linux-2.6.14.5/include/linux/cbd.h
--- o-linux-2.6.14.5/include/linux/cbd.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.14.5/include/linux/cbd.h	2006-01-18 11:00:43.000000000 -0800
@@ -0,0 +1,276 @@
+/*
+ *
+ * cbd.h - Compressed Block Device
+ *
+ * Copyright (C) 2005   Shaun Savage <savages@savages.net>
+ *
+ * Redistribution of this file is permitted under the
+ * GNU General Public License (GPL).
+ */
+/*
+ * This header file defines the ioctls
+ * for the CBD DRIVER
+ * we use 'i' as "our letter" (c.f. linux/Documentation/ioctl-number.txt)
+ */
+
+#ifndef _CBD_H_
+#define _CBD_H_
+
+#define CBD_MAJOR 102
+
+typedef struct cbd_ioctl_s {
+    int		data;
+    int		length;
+    void	*ptr;
+} cbd_ioctl_t;
+
+#define CBD_LETTER                     'i'
+#define CBD_ERASE_SECTION           _IOWR(CBD_LETTER, 1, cbd_ioctl_t *)
+#define CBD_INVAL_BUFFERS           _IOWR(CBD_LETTER, 2, cbd_ioctl_t *)
+#define CBD_INVAL_PARTITION         _IOWR(CBD_LETTER, 3, cbd_ioctl_t *)
+#define CBD_GET_FREE_SECTION        _IOWR(CBD_LETTER, 4, cbd_ioctl_t *)
+#define CBD_GET_PARTITION_VERSION   _IOWR(CBD_LETTER, 5, cbd_ioctl_t *)
+#define CBD_COMMIT_PARTITION        _IOWR(CBD_LETTER, 6, cbd_ioctl_t *)
+#define CBD_GET_SIZE                _IOWR(CBD_LETTER, 7, cbd_ioctl_t *)
+#define CBD_LOCK0                   _IOWR(CBD_LETTER, 8, cbd_ioctl_t *)
+#define CBD_GET_PART_HEADER         _IOWR(CBD_LETTER, 9, cbd_ioctl_t *)
+#define CBD_GET_FREE_PART           _IOWR(CBD_LETTER, 10, cbd_ioctl_t *)
+
+/*
+ * Section Header:
+ * 
+ * Each section (except BIOS-sections and unintialized sections)
+ * starts with a section header:
+ */
+
+#define CBD_SECTION_SIZE  0x10000L      /* 64 K */
+#define CBD_DEV_0_NAME    "/dev/cbd/p"
+#define CBD_MAGIC 0x4c454749
+#define CBD_PARTHDR_CRC_START	(2 * sizeof (ulong))
+#define DRIVER_VERSION -1
+#define CBD_MAX_MINORS 15
+
+#ifdef NEED_UTYPE
+typedef unsigned long ulong;
+typedef unsigned int uint;
+typedef unsigned short ushort;
+#endif
+typedef unsigned char uchar; 
+
+/*  content types */
+/*  NONE	nothing */
+#define NONE	0x454E4F4E
+/*  CLST	cluster map */
+#define CLST	0x54534C43
+/*  PHDR	partition text header */
+#define PHDR	0x52444850
+/*  KRNL	kernel */
+#define KRNL	0x4C4E524B
+/*  BOOT	boot  the real stage2 */
+#define BOOT	0x544F4F42
+/*  BMNU	boot menu */
+#define BMNU	0x564E4D42
+/*  BMN2	boot menu 2 */
+#define BMN2	0x324E4D42
+/*  SPLS	splash */
+#define SPLS	0x534C5053
+/*  INRD	initrd */
+#define INRD	0x44544E49
+/*  DICT	dictionary */
+#define DICT	0x54434944
+/*  MKEY	make public key */
+#define MKEY	0x59454B4D
+/*  OKEY	oem public key */
+#define OKEY	0x59454B4F
+/*  RKEY	register public key */
+#define RKEY	0x59454B52
+/*  SIGN        signature */
+#define SIGN	0x4E474953
+/*  STG1        stage1 */
+#define STG1	0x31494453
+/*  STG2        stage2 really stage1_5 */
+#define STG1	0x32494453
+
+typedef struct cbd_part_content {
+	char	name[4];
+	uint	offset;
+	uint	length;
+	uint	crc;
+} cbd_part_content_t; /* struct cbd_part_content */
+
+typedef struct cbd_part_hdr {
+	
+	uint	magic;				/* 0 IGEL */
+	
+	uint	hdr_crc;			/* 4 checksum */
+	
+	char	drvver;				/* 8 driver version */
+	uchar	cluster_shift;			/* 9 cluster size 32k */
+	uchar	n_content;			/* A number of types */
+	uchar	cbd_minor;			/* B minor number */
+
+	ushort	hdr_len;			/* C length */
+	ushort	n_sections;			/* E number of sections */
+
+	ushort	version;			/* 10 partition version */
+	ushort	update_count;			/* 12 sequence */
+	uint	more;				/* 14 more */
+
+	uint	n_clusters;			/* 18 number of cluster */
+
+	uint	offset_section_table;		/* 1C start of section table */
+
+	cbd_part_content_t content_table[0];	/* 20 content table */
+
+} cbd_part_hdr_t; /* struct cbd_part_hdr */
+
+
+/* now comes section table */
+/* then comes contents */
+
+#define align(a,b) (((a + b -1)/b) * b)
+
+/* proc data information */
+/* size:	total  free */
+#define CBD_PROC_SIZE "%d %d"
+/* map:		array of status and partition */
+/* part:	lines of 
+	"part# version update# cluster# section# mounted*/
+#define CBD_PROC_PART "%d %x %x %x %x %d"
+/* info:	??? */
+/* device:	lines of block devices */
+
+#ifdef __KERNEL__
+/*-------------------------------------------
+ * cbd partition struct
+ */
+struct cbd_partition {
+	u_char  partition;
+	u_char  version;
+	u_short section;
+	u_long  size;
+} __attribute__ ((packed));
+
+#define MAJORV 2
+#define MINORV 0
+
+#define MAX_MINORS	CBD_MAX_MINORS
+
+/*
+ * Section Header:
+ */
+
+#define SECT_EMPTY 0		/* nothing or not checked */
+#define SECT_OK 1		/* regular section, CRC check passed  */
+#define SECT_BIOS 2		/* reserved for BIOS */
+#define SECT_FF 3		/* erased section */
+#define SECT_COMMIT 4		/* after a succesfully commited update */
+#define SECT_BAD 5		/* section failed CRC check without being empty */
+#define SECT_RESV 6		/* section Reserved for update */
+
+#define CBD_SECTION_SHIFT 16
+
+struct section_info {
+    u_char partition;		/* 00 shdr.0x8 */
+    u_char status;		/* 01 33 */
+    u_short section_index;	/* 02 shdr.0x9 */
+    u_short next;		/* 04 shdr.0xc */
+    u_short version;		/* 06 shdr.0xa */
+};
+
+#define SECT_PART(n) (s_info[(n)].partition)
+#define SECT_STAT(n) (s_info[(n)].status)
+#define SECT_NEXT(n) (s_info[(n)].next)
+#define SECT_IDX(n)  (s_info[(n)].section_index)
+#define SECT_VERSION(n)  (s_info[(n)].version)
+
+/*
+ * Various definitions belonging to the flash memory layout
+ */
+#define SECTION_SIZE            CBD_SECTION_SIZE
+#define START_OF_SECTION(n)   ((n) << 16)
+//#define START_OF_SECTION(n)     (SECT_REL(n)<<16)
+#define START_PHY_BLOCK(t,o)    START_OF_SECTION((t)[(o)>>CBD_SECTION_SHIFT])
+
+/*
+ * Partition Headers:
+ *
+ * The partition header depends on the type of the partition. 
+ * Each partition header starts with a "cbd_part_base" defining the type
+ * of the partition.
+ */
+typedef struct content_s {
+    char  name[4];
+    long  length;
+} content_t;
+
+struct partition_info {
+    ushort is_valid;
+    ushort first_section;
+    uint version;
+    uint update_count;
+    ushort clust_count;
+    ushort sect_count;
+    uchar  mounted;
+    uchar  content_count;
+    ushort *section_map;
+    char c_shift;
+    uint length;
+    uint fs_offset;
+    uint *cluster_map;		/* descriptor table for clusters */
+    uint cluster_mask;
+    char *header;
+    content_t content[8];
+};
+
+#define PART_FIRST(n) (cbd->p_info[(n)].first_section)
+#define PART_MAP(n)   (cbd->p_info[(n)].section_map)
+#define PART_SCOUNT(n) (cbd->p_info[(n)].sect_count)
+#define PART_CCOUNT(n) (cbd->p_info[(n)].clust_count)
+#define PART_VERSION(n) (cbd->p_info[(n)].version)
+#define PART_VALID(n) (cbd->p_info[(n)].is_valid)
+#define PART_MOUNT(n) (cbd->p_info[(n)].mounted)
+
+/* CBD Device 
+ *
+ */
+typedef struct cbd_device {
+    char *name;
+    ushort type;
+    ushort nr_sections;
+    char *blkname;
+    struct block_device *blkdev;
+    struct semaphore write_mutex;
+    struct semaphore cbd_bh_mutex;
+    struct semaphore cbd_ctl_mutex;
+    struct bio  *cbd_bio;
+    struct bio  *cbd_biotail;
+    int cbd_pending;
+    spinlock_t cbd_lock;
+    struct request_queue *cbd_queue;
+    int blksize;
+    struct gendisk *disk;
+    int (*proc_device_read) (struct cbd_device *cbd, char **ptr);
+    struct section_info *s_info;
+    struct partition_info p_info[CBD_MAX_MINORS];
+    int disk_change_flag;
+    void *private;
+	int cbd_refcnt;
+	loff_t cbd_offset;
+	int cbd_flags;
+	int old_gfp_mask;
+	unsigned cbd_blocksize;
+	int cbd_state;
+	struct semaphore cbd_sem;
+	struct z_stream_s decomp_stream;
+	struct partition diskpart[15];
+} cbd_device_t;
+
+/* */
+extern int cbd_vv;
+extern struct cbd_device *cbd_device;
+extern u_long sections;
+
+extern int cbd_read(struct cbd_device *dev, loff_t from, size_t len, size_t *retlen, u_char *buf);
+#endif // __KERNEL__
+#endif
diff -Nru o-linux-2.6.14.5/lib/Kconfig linux-2.6.14.5/lib/Kconfig
--- o-linux-2.6.14.5/lib/Kconfig	2005-12-26 16:26:33.000000000 -0800
+++ linux-2.6.14.5/lib/Kconfig	2006-01-21 22:33:08.000000000 -0800
@@ -42,10 +42,10 @@
 # compression support is select'ed if needed
 #
 config ZLIB_INFLATE
-	tristate
+	tristate	"Inflate"
 
 config ZLIB_DEFLATE
-	tristate
+	tristate	"Deflate"
 
 #
 # Generic allocator support is selected if needed

--=_gateway.savages.net-6826-1137872439-0001-2--
