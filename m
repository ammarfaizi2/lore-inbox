Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751673AbWIMHsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbWIMHsj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 03:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbWIMHsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 03:48:39 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:42930 "EHLO xsmtp1.ethz.ch")
	by vger.kernel.org with ESMTP id S1751673AbWIMHsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 03:48:35 -0400
Message-ID: <4507B77F.1040907@student.ethz.ch>
Date: Wed, 13 Sep 2006 09:47:11 +0200
From: Benjamin Schindler <bschindler@student.ethz.ch>
User-Agent: Thunderbird 1.5.0.5 (X11/20060821)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Soft Lockup detected on cpu#0
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3554E4E98D95CA2D44DEDA90"
X-OriginalArrivalTime: 13 Sep 2006 07:48:33.0173 (UTC) FILETIME=[03014450:01C6D709]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3554E4E98D95CA2D44DEDA90
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi

My Laptop (Thinkpad T42) locks up frequently since some time. The lockup
happens during bootup, during suspend-to-ram and sometime also while
doing daly work.
Sometimes, this lockup happens during bootup, so I had the chance to
capture:

BUG: Soft lockup detected on CPU#0

Pid: 1, comm: swapper
EIP: 0060:[<c0193de2>] CPU: 0
EIP is at log_do_checkpoint+0xa0/0x134
 EFLAGS: 00000202    Not tainted    (2.6.16/suspend2/r1 #4)
EAX: 00000001 EBX: ded1c5e8 ECX: 00000001 EDX:c14fe0000
ESI: 00000001 EDI: c15bf6c0 EBP: dfc933c0 DS: 007b ES: 007b
CD0: 8005003b CR2: fffe8000 CR3: 003fa000 CR4 000006d0
 [<c0195dad>] journal_flush+0x43/0x167
 [<c018d16e>] ext3_mark_recovery_complete+0x23/0x5d
 [<c018ca9b>] ext3_fill_super+0x840/0x938
 [<c01593b3>] get_sb_bdev+0xcf/0x119
 [<c018d646>] ext3_get_sb+0x1a/0x20
 [<c018c25b>] ext3_fill_super+0x0/0x938
 [<c015955c>] do_kern_mount+0x3c/0x9e
 [<c0169f71>] do_new_mount+0x67/0xa4
 [<c016a48d>] do_mount+0x153/0x16b
 [<c01e450f>] strncpy_from_user+0x2e/0x4c
 [<c016a2ef>] copy_mount_options+0x49/0x94
 [<c016a744>] sys_mount+0x74/0xa8
 [<c03d6801>] do_mount_root+0x1a/0x7f
 [<c03d68a4>] mount_block_root+0x1a/0x7f
 [<c01601f5>] sys_mknod+0x13/0x17
 [<c03d6a45>] mount_root+0x4e/0x52
 [<c0100274>] init+0x0/0x114
 [<c03d6b29>] prepare_namespace+0xe0/0x108
 [<c01002d3>] init+0x5f/0x114
 [<c01012b1>] kernel_thread_helper+0x5/0xb

I have been running this kernel for quite some time and never had any
issues with it. I really suspect hardware-failure, but I haven't been
able to convince the support yet :-(
I have tried to disable soft-lockup-detection - but I still suffered
from hang-ups.
Do you have any idea what's going wrong here?

(Please CC-me since I'm not subscribed to this list)

Here is my kernel-config:

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.16-suspend2-r1
# Tue Aug 29 12:53:06 2006
#
CONFIG_X86_32=3Dy
CONFIG_SEMAPHORE_SLEEPERS=3Dy
CONFIG_X86=3Dy
CONFIG_MMU=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_GENERIC_IOMAP=3Dy
CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
CONFIG_DMI=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy
CONFIG_BROKEN_ON_SMP=3Dy
CONFIG_INIT_ENV_ARG_LIMIT=3D32

#
# General setup
#
CONFIG_LOCALVERSION=3D""
CONFIG_LOCALVERSION_AUTO=3Dy
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_POSIX_MQUEUE=3Dy
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=3Dy
CONFIG_AUDIT=3Dy
CONFIG_AUDITSYSCALL=3Dy
CONFIG_IKCONFIG=3Dy
CONFIG_IKCONFIG_PROC=3Dy
CONFIG_INITRAMFS_SOURCE=3D""
CONFIG_UID16=3Dy
CONFIG_VM86=3Dy
CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=3Dy
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=3Dy
CONFIG_PRINTK=3Dy
CONFIG_BUG=3Dy
CONFIG_ELF_CORE=3Dy
CONFIG_BASE_FULL=3Dy
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_SHMEM=3Dy
CONFIG_CC_ALIGN_FUNCTIONS=3D0
CONFIG_CC_ALIGN_LABELS=3D0
CONFIG_CC_ALIGN_LOOPS=3D0
CONFIG_CC_ALIGN_JUMPS=3D0
CONFIG_SLAB=3Dy
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=3D0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=3Dy
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=3Dy

#
# Block layer
#
CONFIG_LBD=3Dy

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_AS=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
CONFIG_IOSCHED_CFQ=3Dy
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=3Dy
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED=3D"cfq"

#
# Processor type and features
#
CONFIG_X86_PC=3Dy
# CONFIG_X86_ELAN is not set
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
CONFIG_MPENTIUMM=3Dy
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D6
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
CONFIG_X86_CMPXCHG64=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_INTEL_USERCOPY=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_X86_TSC=3Dy
# CONFIG_HPET_TIMER is not set
# CONFIG_SMP is not set
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=3Dy
# CONFIG_PREEMPT is not set
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_MCE=3Dy
CONFIG_X86_MCE_NONFATAL=3Dy
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=3Dm
CONFIG_X86_CPUID=3Dm

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
CONFIG_DCDBAS=3Dm
CONFIG_NOHIGHMEM=3Dy
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_VMSPLIT_3G=3Dy
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=3D0xC0000000
CONFIG_ARCH_FLATMEM_ENABLE=3Dy
CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
CONFIG_ARCH_SELECT_MEMORY_MODEL=3Dy
CONFIG_SELECT_MEMORY_MODEL=3Dy
CONFIG_FLATMEM_MANUAL=3Dy
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=3Dy
CONFIG_FLAT_NODE_MEM_MAP=3Dy
CONFIG_SPARSEMEM_STATIC=3Dy
CONFIG_SPLIT_PTLOCK_CPUS=3D4
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=3Dy
# CONFIG_EFI is not set
# CONFIG_REGPARM is not set
CONFIG_SECCOMP=3Dy
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=3Dy
# CONFIG_HZ_1000 is not set
CONFIG_HZ=3D250
# CONFIG_KEXEC is not set
CONFIG_PHYSICAL_START=3D0x100000
CONFIG_DOUBLEFAULT=3Dy

#
# Power management options (ACPI, APM)
#
CONFIG_PM=3Dy
CONFIG_PM_LEGACY=3Dy
# CONFIG_PM_DEBUG is not set
CONFIG_SOFTWARE_SUSPEND=3Dy
CONFIG_PM_STD_PARTITION=3D"/dev/hda2"
# CONFIG_SWSUSP_ENCRYPT is not set
CONFIG_SUSPEND2_CRYPTO=3Dy
CONFIG_SUSPEND2=3Dy

#
# Image Storage (you need at least one writer)
#
# CONFIG_SUSPEND2_FILEWRITER is not set
CONFIG_SUSPEND2_SWAPWRITER=3Dy

#
# General Options
#
CONFIG_SUSPEND2_DEFAULT_RESUME2=3D"/dev/hda2"
# CONFIG_SUSPEND2_KEEP_IMAGE is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=3Dy
CONFIG_ACPI_SLEEP=3Dy
CONFIG_ACPI_SLEEP_PROC_FS=3Dy
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_AC=3Dy
CONFIG_ACPI_BATTERY=3Dy
CONFIG_ACPI_BUTTON=3Dy
CONFIG_ACPI_VIDEO=3Dy
CONFIG_ACPI_HOTKEY=3Dy
CONFIG_ACPI_FAN=3Dy
CONFIG_ACPI_PROCESSOR=3Dy
CONFIG_ACPI_THERMAL=3Dy
# CONFIG_ACPI_ASUS is not set
CONFIG_ACPI_IBM=3Dm
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=3D0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_SYSTEM=3Dy
CONFIG_X86_PM_TIMER=3Dy
# CONFIG_ACPI_CONTAINER is not set

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=3Dy
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=3Dy
CONFIG_APM_CPU_IDLE=3Dy
CONFIG_APM_DISPLAY_BLANK=3Dy
# CONFIG_APM_RTC_IS_GMT is not set
CONFIG_APM_ALLOW_INTS=3Dy
CONFIG_APM_REAL_MODE_POWER_OFF=3Dy

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_TABLE=3Dy
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=3Dy
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=3Dy
CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dy
CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dy

#
# CPUFreq processor drivers
#
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=3Dy
CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=3Dy
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=3Dy
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_SMI is not set
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_CPUFREQ_NFORCE2 is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
# CONFIG_X86_SPEEDSTEP_LIB is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=3Dy
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_MMCONFIG=3Dy
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_LEGACY_PROC=3Dy
# CONFIG_PCI_DEBUG is not set
CONFIG_ISA_DMA_API=3Dy
CONFIG_ISA=3Dy
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=3Dy
CONFIG_BINFMT_AOUT=3Dy
CONFIG_BINFMT_MISC=3Dy

#
# Networking
#
CONFIG_NET=3Dy

#
# Networking options
#
# CONFIG_NETDEBUG is not set
CONFIG_PACKET=3Dy
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=3Dy
CONFIG_XFRM=3Dy
CONFIG_XFRM_USER=3Dm
# CONFIG_NET_KEY is not set
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=3Dy
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=3Dy
CONFIG_INET_DIAG=3Dy
CONFIG_INET_TCP_DIAG=3Dy
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=3Dy

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=3Dy
CONFIG_NETFILTER_DEBUG=3Dy

#
# Core Netfilter Configuration
#
# CONFIG_NETFILTER_NETLINK is not set
# CONFIG_NETFILTER_XTABLES is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=3Dm
CONFIG_IP_NF_CT_ACCT=3Dy
# CONFIG_IP_NF_CONNTRACK_MARK is not set
# CONFIG_IP_NF_CONNTRACK_EVENTS is not set
# CONFIG_IP_NF_CT_PROTO_SCTP is not set
CONFIG_IP_NF_FTP=3Dm
CONFIG_IP_NF_IRC=3Dm
# CONFIG_IP_NF_NETBIOS_NS is not set
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_PPTP is not set
CONFIG_IP_NF_QUEUE=3Dm

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set

#
# TIPC Configuration (EXPERIMENTAL)
#
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
CONFIG_IRDA=3Dm

#
# IrDA protocols
#
CONFIG_IRLAN=3Dm
CONFIG_IRCOMM=3Dm
CONFIG_IRDA_ULTRA=3Dy

#
# IrDA options
#
# CONFIG_IRDA_CACHE_LAST_LSAP is not set
# CONFIG_IRDA_FAST_RR is not set
# CONFIG_IRDA_DEBUG is not set

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=3Dm

#
# Dongle support
#
# CONFIG_DONGLE is not set

#
# Old SIR device drivers
#
CONFIG_IRPORT_SIR=3Dm

#
# Old Serial dongle support
#
# CONFIG_DONGLE_OLD is not set

#
# FIR device drivers
#
# CONFIG_USB_IRDA is not set
# CONFIG_SIGMATEL_FIR is not set
CONFIG_NSC_FIR=3Dm
# CONFIG_WINBOND_FIR is not set
# CONFIG_TOSHIBA_FIR is not set
# CONFIG_SMC_IRCC_FIR is not set
# CONFIG_ALI_FIR is not set
# CONFIG_VLSI_FIR is not set
# CONFIG_VIA_FIR is not set
CONFIG_BT=3Dm
CONFIG_BT_L2CAP=3Dm
CONFIG_BT_SCO=3Dm
CONFIG_BT_RFCOMM=3Dm
CONFIG_BT_RFCOMM_TTY=3Dy
CONFIG_BT_BNEP=3Dm
CONFIG_BT_BNEP_MC_FILTER=3Dy
CONFIG_BT_BNEP_PROTO_FILTER=3Dy
CONFIG_BT_HIDP=3Dm

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=3Dm
CONFIG_BT_HCIUSB_SCO=3Dy
CONFIG_BT_HCIUART=3Dm
CONFIG_BT_HCIUART_H4=3Dy
CONFIG_BT_HCIUART_BCSP=3Dy
CONFIG_BT_HCIBCM203X=3Dm
# CONFIG_BT_HCIBPA10X is not set
CONFIG_BT_HCIBFUSB=3Dm
CONFIG_BT_HCIVHCI=3Dm
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
CONFIG_FW_LOADER=3Dm
# CONFIG_DEBUG_DRIVER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=3Dm
CONFIG_PARPORT_PC=3Dm
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_1284=3Dy

#
# Plug and Play support
#
CONFIG_PNP=3Dy
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=3Dy

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=3Dy
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_COUNT=3D16
CONFIG_BLK_DEV_RAM_SIZE=3D4096
CONFIG_BLK_DEV_INITRD=3Dy
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=3Dy
CONFIG_BLK_DEV_IDE=3Dy

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
CONFIG_BLK_DEV_IDECD=3Dy
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=3Dy
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=3Dy
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=3Dy
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=3Dy
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=3Dy
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=3Dy
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=3Dy
CONFIG_SCSI_PROC_FS=3Dy

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dy
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=3Dy
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_SATA=3Dy
# CONFIG_SCSI_SATA_AHCI is not set
# CONFIG_SCSI_SATA_SVW is not set
CONFIG_SCSI_ATA_PIIX=3Dy
# CONFIG_SCSI_SATA_MV is not set
# CONFIG_SCSI_SATA_NV is not set
# CONFIG_SCSI_PDC_ADMA is not set
# CONFIG_SCSI_SATA_QSTOR is not set
# CONFIG_SCSI_SATA_PROMISE is not set
CONFIG_SCSI_SATA_SX4=3Dm
# CONFIG_SCSI_SATA_SIL is not set
# CONFIG_SCSI_SATA_SIL24 is not set
# CONFIG_SCSI_SATA_SIS is not set
# CONFIG_SCSI_SATA_ULI is not set
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_SATA_VITESSE is not set
CONFIG_SCSI_SATA_INTEL_COMBINED=3Dy
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
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
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=3Dy

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
# CONFIG_IEEE1394_OUI_DB is not set
# CONFIG_IEEE1394_EXTRA_CONFIG_ROMS is not set
# CONFIG_IEEE1394_EXPORT_FULL_API is not set

#
# Device Drivers
#
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=3Dy

#
# Protocol Drivers
#
# CONFIG_IEEE1394_VIDEO1394 is not set
# CONFIG_IEEE1394_SBP2 is not set
# CONFIG_IEEE1394_ETH1394 is not set
# CONFIG_IEEE1394_DV1394 is not set
CONFIG_IEEE1394_RAWIO=3Dy

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=3Dy
CONFIG_DUMMY=3Dm
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=3Dm
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#
# CONFIG_PHYLIB is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=3Dy
CONFIG_MII=3Dy
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=3Dy
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=3Dm
# CONFIG_E1000_NAPI is not set
# CONFIG_E1000_DISABLE_PACKET_SPLIT is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
CONFIG_S2IO=3Dm
# CONFIG_S2IO_NAPI is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=3Dy

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set
# CONFIG_ARLAN is not set
# CONFIG_WAVELAN is not set

#
# Wireless 802.11b ISA/PCI cards support
#
# CONFIG_AIRO is not set
# CONFIG_HERMES is not set
# CONFIG_ATMEL is not set

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
# CONFIG_PRISM54 is not set
# CONFIG_HOSTAP is not set
CONFIG_NET_WIRELESS=3Dy

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=3Dy

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
CONFIG_INPUT_JOYDEV=3Dm
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=3Dy
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dy
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=3Dy
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=3Dy
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=3D4
CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=3Dy
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=3Dy
# CONFIG_LEGACY_PTYS is not set
# CONFIG_PRINTER is not set
CONFIG_PPDEV=3Dm
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=3Dm
CONFIG_RTC=3Dm
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=3Dy
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=3Dy
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_CS5535_GPIO is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
CONFIG_TCG_TPM=3Dm
CONFIG_TCG_NSC=3Dm
CONFIG_TCG_ATMEL=3Dm
# CONFIG_TCG_INFINEON is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
CONFIG_I2C=3Dy
# CONFIG_I2C_CHARDEV is not set

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=3Dy
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_ELEKTOR is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_RTC_X1205_I2C is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
CONFIG_HWMON=3Dy
# CONFIG_HWMON_VID is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_FSCPOS is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia Capabilities Port drivers
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=3Dy
CONFIG_FB_CFB_FILLRECT=3Dy
CONFIG_FB_CFB_COPYAREA=3Dy
CONFIG_FB_CFB_IMAGEBLIT=3Dy
# CONFIG_FB_MACMODES is not set
CONFIG_FB_MODE_HELPERS=3Dy
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=3Dy
CONFIG_FB_VESA_STD=3Dy
# CONFIG_FB_VESA_TNG is not set
CONFIG_VIDEO_SELECT=3Dy
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_CYBLA is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=3Dy
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=3Dy
CONFIG_FONT_8x16=3Dy

#
# Logo configuration
#
# CONFIG_LOGO is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
CONFIG_BACKLIGHT_DEVICE=3Dy
CONFIG_LCD_CLASS_DEVICE=3Dm
CONFIG_LCD_DEVICE=3Dy
CONFIG_FB_SPLASH=3Dy

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
CONFIG_SPEAKUP_DEFAULT=3D"none"

#
# Sound
#
CONFIG_SOUND=3Dy

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=3Dy
CONFIG_SND_TIMER=3Dy
CONFIG_SND_PCM=3Dy
CONFIG_SND_SEQUENCER=3Dy
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dy
CONFIG_SND_PCM_OSS=3Dy
CONFIG_SND_SEQUENCER_OSS=3Dy
# CONFIG_SND_RTCTIMER is not set
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=3Dy
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_AC97_CODEC=3Dm
CONFIG_SND_AC97_BUS=3Dm
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
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_DT019X is not set
# CONFIG_SND_ES968 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set
# CONFIG_SND_WAVEFRONT is not set

#
# PCI devices
#
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=3Dm
CONFIG_SND_INTEL8X0M=3Dm
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# Open Sound System
#
CONFIG_SOUND_PRIME=3Dm
# CONFIG_OBSOLETE_OSS_DRIVER is not set
# CONFIG_SOUND_FUSION is not set
CONFIG_SOUND_ICH=3Dm
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB_ARCH_HAS_OHCI=3Dy
CONFIG_USB=3Dm
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=3Dy
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_SUSPEND=3Dy
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=3Dm
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=3Dm
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_OBSOLETE_OSS_USB_DRIVER is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=3Dm

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=3Dm
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Input Devices
#
CONFIG_USB_HID=3Dm
CONFIG_USB_HIDINPUT=3Dy
# CONFIG_USB_HIDINPUT_POWERBOOK is not set
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_ITMTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_YEALINK is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_ATI_REMOTE2 is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_USBNET=3Dm
CONFIG_USB_NET_AX8817X=3Dm
CONFIG_USB_NET_CDCETHER=3Dm
# CONFIG_USB_NET_GL620A is not set
CONFIG_USB_NET_NET1080=3Dm
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_ZD1201 is not set
CONFIG_USB_MON=3Dy

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#
# CONFIG_EDAC is not set

#
# File systems
#
CONFIG_EXT2_FS=3Dy
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=3Dy
CONFIG_EXT3_FS_XATTR=3Dy
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=3Dy
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=3Dy
CONFIG_REISERFS_FS=3Dm
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=3Dy
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=3Dy
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=3Dy
CONFIG_FUSE_FS=3Dm

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dy
CONFIG_JOLIET=3Dy
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=3Dy
CONFIG_UDF_NLS=3Dy

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=3Dy
CONFIG_MSDOS_FS=3Dy
CONFIG_VFAT_FS=3Dy
CONFIG_FAT_DEFAULT_CODEPAGE=3D437
CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
CONFIG_NTFS_FS=3Dm
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
CONFIG_SYSFS=3Dy
CONFIG_TMPFS=3Dy
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=3Dy
# CONFIG_RELAYFS_FS is not set
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=3Dy
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=3Dy
# CONFIG_NFSD_V3 is not set
CONFIG_NFSD_TCP=3Dy
CONFIG_LOCKD=3Dy
CONFIG_EXPORTFS=3Dy
CONFIG_NFS_COMMON=3Dy
CONFIG_SUNRPC=3Dy
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=3Dm
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=3Dy

#
# Native Language Support
#
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"utf8"
CONFIG_NLS_CODEPAGE_437=3Dy
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
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
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=3Dy
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=3Dy

#
# Instrumentation Support
#
CONFIG_PROFILING=3Dy
CONFIG_OPROFILE=3Dm
# CONFIG_KPROBES is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_DEBUG_KERNEL=3Dy
CONFIG_LOG_BUF_SHIFT=3D14
CONFIG_DETECT_SOFTLOCKUP=3Dy
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_MUTEXES=3Dy
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=3Dy
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_FORCED_INLINING=3Dy
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_EARLY_PRINTK=3Dy
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set

#
# Page alloc debug is incompatible with Software Suspend on i386
#
# CONFIG_DEBUG_RODATA is not set
# CONFIG_4KSTACKS is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=3Dy
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES is not set
CONFIG_CRYPTO_AES_586=3Dy
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_ARC4=3Dy
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_DEFLATE is not set
CONFIG_CRYPTO_LZF=3Dy
CONFIG_CRYPTO_MICHAEL_MIC=3Dy
CONFIG_CRYPTO_CRC32C=3Dy
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
CONFIG_CRC_CCITT=3Dm
# CONFIG_CRC16 is not set
CONFIG_CRC32=3Dy
CONFIG_LIBCRC32C=3Dy
CONFIG_DYN_PAGEFLAGS=3Dy
CONFIG_GENERIC_HARDIRQS=3Dy
CONFIG_GENERIC_IRQ_PROBE=3Dy
CONFIG_X86_BIOS_REBOOT=3Dy
CONFIG_KTIME_SCALAR=3Dy



--------------enig3554E4E98D95CA2D44DEDA90
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFB7d/IExHgErho7kRAqrlAJ0S8iJ2G9lk67sYsNvTs5RZ3TmvLACfXWdE
KYLDf0tsRin3pFCW7dJvD1U=
=fE/4
-----END PGP SIGNATURE-----

--------------enig3554E4E98D95CA2D44DEDA90--
