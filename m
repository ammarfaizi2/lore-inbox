Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264136AbTDJUEa (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 16:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264138AbTDJUE3 (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 16:04:29 -0400
Received: from APastourelles-105-1-2-31.abo.wanadoo.fr ([80.13.121.31]:37760
	"EHLO wodar.local.gxaafoot.homelinux.org") by vger.kernel.org
	with ESMTP id S264136AbTDJUDX 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 16:03:23 -0400
Date: Thu, 10 Apr 2003 22:18:16 +0200
From: Mario TRENTINI <mario.trentini@polytechnique.org>
To: linux-kernel@vger.kernel.org
Subject: Possible bug in ip_conntrack on ip change
Message-ID: <20030410201816.GA10975@wodar.local.gxaafoot.homelinux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Dear list,

I've recently reboot my linux router due to fool ip_conntrack table
(/proc/net/ip_conntrack). The box is hook up to the internet with
dynamically assign ip and run a 2.4.20 kernel.
Upon investigation after the reboot, it appears that the table contains
stale entries of connections made with previous ip addresses that slowly
fill it up.

More precisely you can find the state of my router after 6 days of
uptime. Attached are the ip_conntrack table and the list of ip
addresses that have been assigned to me.

You can see there that out of about 1000 entries, only 50 are relevant,
the other entries figuring connections made with my previous ip
addresses, some of them 6 days old.

I can only guess that once the ip of ppp0 has changed, the kernel does
not touch those connections although they are still present.

The problem is triggered by the use of mldonkey, a peer to peer client
that uses up to 900 simultaneous tcp connections. The problem does not
show up on another router of mine that never has more than 50
connections at the same time.

Precision on connection : adsl speed touch usb with userland driver.

kernel version 2.4.20, kernel configuration attached
ip_conntrack compiled into the kernel

PS : the bug has possibly been encountered by others as seen on the
netfilter mailing list but I think that increasing ip_conntrack_max is
definitely *not* the right fix :-)


please CC me any reply for I'm not subscribed to the list.



--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=assigned_ip_addresses

Apr  3 11:21:41  217.128.180.137
Apr  4 11:27:53  80.15.71.89
Apr  4 17:53:01  80.15.71.53
Apr  5 17:53:17  217.128.180.86
Apr  6 17:53:31  80.13.121.160
Apr  7 17:54:22  81.49.26.188
Apr  8 17:55:17  81.49.26.28
Apr  9 17:53:44  217.128.180.154
Apr 10 17:59:26  80.13.121.82

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-2.4.20-acpi"
Content-Transfer-Encoding: quoted-printable

#
# Automatically generated make config: don't edit
#
CONFIG_X86=3Dy
# CONFIG_SBUS is not set
CONFIG_UID16=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODVERSIONS=3Dy
CONFIG_KMOD=3Dy

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMIII=3Dy
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D5
CONFIG_X86_HAS_TSC=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_PGE=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_X86_F00F_WORKS_OK=3Dy
CONFIG_X86_MCE=3Dy
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=3Dm
CONFIG_X86_MSR=3Dm
CONFIG_X86_CPUID=3Dm
CONFIG_NOHIGHMEM=3Dy
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_HIGHMEM is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=3Dy
# CONFIG_SMP is not set
CONFIG_X86_UP_APIC=3Dy
CONFIG_X86_UP_IOAPIC=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=3Dy

#
# General setup
#
CONFIG_NET=3Dy
CONFIG_PCI=3Dy
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
# CONFIG_ISA is not set
# CONFIG_PCI_NAMES is not set
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_HOTPLUG_PCI is not set
CONFIG_SYSVIPC=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_KCORE_ELF=3Dy
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=3Dy
# CONFIG_BINFMT_MISC is not set
CONFIG_PM=3Dy
CONFIG_ACPI=3Dy
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUSMGR=3Dm
CONFIG_ACPI_SYS=3Dm
CONFIG_ACPI_CPU=3Dm
# CONFIG_ACPI_BUTTON is not set
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_EC is not set
# CONFIG_ACPI_CMBATT is not set
# CONFIG_ACPI_THERMAL is not set
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
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=3Dm
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=3Dm
CONFIG_BLK_DEV_RAM_SIZE=3D4096
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_BLK_STATS is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=3Dy
CONFIG_PACKET_MMAP=3Dy
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=3Dy
CONFIG_UNIX=3Dy
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_IP_ADVANCED_ROUTER=3Dy
# CONFIG_IP_MULTIPLE_TABLES is not set
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_TOS is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
# CONFIG_IP_ROUTE_LARGE_TABLES is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
CONFIG_IP_MROUTE=3Dy
# CONFIG_IP_PIMSM_V1 is not set
CONFIG_IP_PIMSM_V2=3Dy
# CONFIG_ARPD is not set
CONFIG_INET_ECN=3Dy
CONFIG_SYN_COOKIES=3Dy

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=3Dy
CONFIG_IP_NF_FTP=3Dm
CONFIG_IP_NF_IRC=3Dm
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=3Dy
CONFIG_IP_NF_MATCH_LIMIT=3Dm
CONFIG_IP_NF_MATCH_MAC=3Dm
# CONFIG_IP_NF_MATCH_PKTTYPE is not set
CONFIG_IP_NF_MATCH_MARK=3Dm
CONFIG_IP_NF_MATCH_MULTIPORT=3Dm
CONFIG_IP_NF_MATCH_TOS=3Dm
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_DSCP is not set
CONFIG_IP_NF_MATCH_AH_ESP=3Dm
CONFIG_IP_NF_MATCH_LENGTH=3Dm
CONFIG_IP_NF_MATCH_TTL=3Dm
CONFIG_IP_NF_MATCH_TCPMSS=3Dm
# CONFIG_IP_NF_MATCH_HELPER is not set
CONFIG_IP_NF_MATCH_STATE=3Dm
# CONFIG_IP_NF_MATCH_CONNTRACK is not set
# CONFIG_IP_NF_MATCH_UNCLEAN is not set
# CONFIG_IP_NF_MATCH_OWNER is not set
CONFIG_IP_NF_FILTER=3Dm
CONFIG_IP_NF_TARGET_REJECT=3Dm
# CONFIG_IP_NF_TARGET_MIRROR is not set
CONFIG_IP_NF_NAT=3Dy
CONFIG_IP_NF_NAT_NEEDED=3Dy
CONFIG_IP_NF_TARGET_MASQUERADE=3Dy
CONFIG_IP_NF_TARGET_REDIRECT=3Dy
# CONFIG_IP_NF_NAT_LOCAL is not set
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=3Dm
CONFIG_IP_NF_NAT_FTP=3Dm
CONFIG_IP_NF_MANGLE=3Dm
CONFIG_IP_NF_TARGET_TOS=3Dm
# CONFIG_IP_NF_TARGET_ECN is not set
# CONFIG_IP_NF_TARGET_DSCP is not set
CONFIG_IP_NF_TARGET_MARK=3Dm
CONFIG_IP_NF_TARGET_LOG=3Dm
CONFIG_IP_NF_TARGET_ULOG=3Dm
CONFIG_IP_NF_TARGET_TCPMSS=3Dm
CONFIG_IP_NF_ARPTABLES=3Dm
CONFIG_IP_NF_ARPFILTER=3Dm
CONFIG_IPV6=3Dm

#
#   IPv6: Netfilter Configuration
#
# CONFIG_IP6_NF_QUEUE is not set
# CONFIG_IP6_NF_IPTABLES is not set
# CONFIG_KHTTPD is not set
CONFIG_ATM=3Dy
CONFIG_ATM_CLIP=3Dy
# CONFIG_ATM_CLIP_NO_ICMP is not set
# CONFIG_ATM_LANE is not set
# CONFIG_ATM_BR2684 is not set
# CONFIG_VLAN_8021Q is not set

#
# =20
#
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
CONFIG_NET_SCHED=3Dy
CONFIG_NET_SCH_CBQ=3Dm
# CONFIG_NET_SCH_HTB is not set
CONFIG_NET_SCH_CSZ=3Dm
# CONFIG_NET_SCH_ATM is not set
CONFIG_NET_SCH_PRIO=3Dm
CONFIG_NET_SCH_RED=3Dm
CONFIG_NET_SCH_SFQ=3Dm
CONFIG_NET_SCH_TEQL=3Dm
CONFIG_NET_SCH_TBF=3Dm
CONFIG_NET_SCH_GRED=3Dm
CONFIG_NET_SCH_DSMARK=3Dm
CONFIG_NET_SCH_INGRESS=3Dm
CONFIG_NET_QOS=3Dy
# CONFIG_NET_ESTIMATOR is not set
CONFIG_NET_CLS=3Dy
CONFIG_NET_CLS_TCINDEX=3Dm
CONFIG_NET_CLS_ROUTE4=3Dm
CONFIG_NET_CLS_ROUTE=3Dy
CONFIG_NET_CLS_FW=3Dm
CONFIG_NET_CLS_U32=3Dm
CONFIG_NET_CLS_RSVP=3Dm
CONFIG_NET_CLS_RSVP6=3Dm
CONFIG_NET_CLS_POLICE=3Dy

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
CONFIG_IDE=3Dy

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=3Dy

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=3Dm
CONFIG_BLK_DEV_IDETAPE=3Dm
CONFIG_BLK_DEV_IDEFLOPPY=3Dm
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=3Dy
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=3Dy
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
CONFIG_BLK_DEV_ADMA=3Dy
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CMD680 is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=3Dy
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=3Dy
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=3Dy
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

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
CONFIG_NETDEVICES=3Dy

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=3Dm
CONFIG_BONDING=3Dm
# CONFIG_EQUALIZER is not set
CONFIG_TUN=3Dm
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=3Dy
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=3Dy
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
CONFIG_VORTEX=3Dm
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=3Dy
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
CONFIG_EEPRO100=3Dm
# CONFIG_E100 is not set
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
CONFIG_NE2K_PCI=3Dm
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=3Dm
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
CONFIG_VIA_RHINE=3Dm
CONFIG_VIA_RHINE_MMIO=3Dy
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
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=3Dm
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPP_FILTER=3Dy
CONFIG_PPP_ASYNC=3Dm
CONFIG_PPP_SYNC_TTY=3Dm
CONFIG_PPP_DEFLATE=3Dm
CONFIG_PPP_BSDCOMP=3Dm
CONFIG_PPPOE=3Dm
CONFIG_PPPOATM=3Dm
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=3Dy
# CONFIG_STRIP is not set
# CONFIG_WAVELAN is not set
# CONFIG_ARLAN is not set
# CONFIG_AIRONET4500 is not set
# CONFIG_AIRONET4500_NONCS is not set
# CONFIG_AIRONET4500_PROC is not set
# CONFIG_AIRO is not set
CONFIG_HERMES=3Dm
CONFIG_PLX_HERMES=3Dm
CONFIG_PCI_HERMES=3Dm
CONFIG_NET_WIRELESS=3Dy

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
CONFIG_SHAPER=3Dm

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# ATM drivers
#
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E_MAYBE is not set

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
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_SERIAL=3Dy
CONFIG_SERIAL_CONSOLE=3Dy
# CONFIG_SERIAL_EXTENDED is not set
CONFIG_SERIAL_NONSTANDARD=3Dy
# CONFIG_COMPUTONE is not set
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_DIGIEPCA is not set
# CONFIG_DIGI is not set
# CONFIG_ESPSERIAL is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_ISI is not set
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
CONFIG_N_HDLC=3Dm
# CONFIG_RISCOM8 is not set
# CONFIG_SPECIALIX is not set
# CONFIG_SX is not set
# CONFIG_RIO is not set
# CONFIG_STALDRV is not set
CONFIG_UNIX98_PTYS=3Dy
CONFIG_UNIX98_PTY_COUNT=3D256

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

#
# Input core support is needed for gameports
#

#
# Input core support is needed for joysticks
#
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_AMD_RNG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_AMD_PM768 is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=3Dm
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
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
CONFIG_AUTOFS4_FS=3Dy
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=3Dy
CONFIG_JBD=3Dy
# CONFIG_JBD_DEBUG is not set
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=3Dy
CONFIG_RAMFS=3Dy
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
CONFIG_PROC_FS=3Dy
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=3Dy
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=3Dy
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
CONFIG_NFS_FS=3Dy
CONFIG_NFS_V3=3Dy
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=3Dy
CONFIG_NFSD_V3=3Dy
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=3Dy
CONFIG_LOCKD=3Dy
CONFIG_LOCKD_V4=3Dy
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
CONFIG_MSDOS_PARTITION=3Dy
# CONFIG_SMB_NLS is not set
# CONFIG_NLS is not set

#
# Console drivers
#
# CONFIG_VGA_CONSOLE is not set
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
CONFIG_USB=3Dy
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=3Dy
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_LONG_TIMEOUT is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_UHCI=3Dm
CONFIG_USB_UHCI_ALT=3Dm
# CONFIG_USB_OHCI is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_MIDI is not set

#
#   SCSI support is needed for USB Storage
#
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# USB Human Interface Devices (HID)
#
# CONFIG_USB_HID is not set

#
#     Input core support is needed for USB HID input layer or HIDBP support
#
# CONFIG_USB_HIDINPUT is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set

#
# USB Imaging devices
#
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#

#
#   Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set

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
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set

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
CONFIG_ZLIB_INFLATE=3Dm
CONFIG_ZLIB_DEFLATE=3Dm

--xHFwDpU9dbj6ez1V
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="ip_conntrack.gz"
Content-Transfer-Encoding: base64

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

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=iptables_nat
Content-Transfer-Encoding: quoted-printable

output of iptables -t nat -L

Chain PREROUTING (policy ACCEPT)
target     prot opt source               destination        =20
REDIRECT   tcp  --  anywhere             anywhere           tcp dpt:www red=
ir ports 3128=20
DNAT       udp  -- !192.168.0.0/16       anywhere           udp dpt:5970 to=
:192.168.18.18=20
DNAT       tcp  -- !192.168.0.0/16       anywhere           tcp dpt:5970 to=
:192.168.18.18=20
DNAT       udp  -- !192.168.0.0/16       anywhere           udp dpt:1214 to=
:192.168.18.18=20
DNAT       tcp  -- !192.168.0.0/16       anywhere           tcp dpt:1214 to=
:192.168.18.18=20
DNAT       udp  -- !192.168.0.0/16       anywhere           udp dpt:3128 to=
:192.168.18.18=20
DNAT       tcp  -- !192.168.0.0/16       anywhere           tcp dpt:3128 to=
:192.168.18.18=20
DNAT       udp  -- !192.168.0.0/16       anywhere           udp dpt:1104 to=
:192.168.18.18=20
DNAT       tcp  -- !192.168.0.0/16       anywhere           tcp dpt:1104 to=
:192.168.18.18:21=20
DNAT       tcp  -- !192.168.0.0/16       anywhere           tcp dpts:31456:=
31458 to:192.168.18.224=20

Chain POSTROUTING (policy ACCEPT)
target     prot opt source               destination        =20
MASQUERADE  all  --  192.168.0.0/16       anywhere          =20

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination        =20

--xHFwDpU9dbj6ez1V--

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+ldGILx9EVClgz6MRAgvQAKCBsN+YCstwnsp4ul62Bf1iVfCjpACfd7ba
f3ia7x3M/bM0TGghHYN/a8M=
=TvDE
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
