Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263396AbTJBQ42 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 12:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbTJBQ42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 12:56:28 -0400
Received: from matav-1.matav.hu ([145.236.241.98]:28966 "EHLO
	Woody.fw.matav.hu") by vger.kernel.org with ESMTP id S263398AbTJBQzp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 12:55:45 -0400
Subject: kernel BUG at arch/sparc64/kernel/module.c:207 (2.6.0-test6)
From: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-NnzkSOV2cXd/U0AAbD11"
X-Mailer: Ximian Evolution 1.0.5 
Date: 02 Oct 2003 18:50:49 +0200
Message-Id: <1065113449.7140.18.camel@kusturica>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NnzkSOV2cXd/U0AAbD11
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi!

It is a sun netra T1, headless, kernel 2.6.0-test6.
There is a reproducible bug with module loading.
I have tested it. You get it when you load a module.
Any module. After that cat /proc/modules hangs.

You can find the full dmesg atttached, just like the ksymoops output,
the kernel config and the ver_linux output both from the tcb and the
build environment (the beginning thereof, as it hangs on /proc/modules).

I send this report also to the linux-kernel list, because I got no reply
to my last bug report, and I am afraid that it got lost somewhere on the
way.


How is it looks like:
------------------------------
System time was Thu Oct  2 16:33:12 UTC 2003.
Setting the System Clock using the Hardware Clock as reference...
System Clock set. System local time is now Thu Oct  2 16:33:14 UTC 2003.
Calculating module dependencies... done.
Loading modules...
   iptable_filter
kernel BUG at arch/sparc64/kernel/module.c:207!
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
----------------------------------------------------


--=-NnzkSOV2cXd/U0AAbD11
Content-Disposition: attachment; filename=config-2.6.0-test6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=config-2.6.0-test6; charset=ISO-8859-2

#
# Automatically generated make config: don't edit
#
CONFIG_64BIT=3Dy
CONFIG_MMU=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy
CONFIG_CLEAN_COMPILE=3Dy
CONFIG_STANDALONE=3Dy
CONFIG_BROKEN_ON_SMP=3Dy

#
# General setup
#
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=3Dy
CONFIG_LOG_BUF_SHIFT=3D15
CONFIG_IKCONFIG=3Dy
CONFIG_IKCONFIG_PROC=3Dy
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=3Dy
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_AS=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODULE_FORCE_UNLOAD=3Dy
CONFIG_OBSOLETE_MODPARM=3Dy
CONFIG_MODVERSIONS=3Dy
CONFIG_KMOD=3Dy

#
# General setup
#
CONFIG_BBC_I2C=3Dm
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_TABLE=3Dy
# CONFIG_US3_FREQ is not set
CONFIG_US2E_FREQ=3Dm
CONFIG_CPU_FREQ_PROC_INTF=3Dy
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
CONFIG_SPARC64=3Dy
CONFIG_HOTPLUG=3Dy
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_SBUS=3Dy
CONFIG_SBUSCHAR=3Dy
CONFIG_SUN_AUXIO=3Dy
CONFIG_SUN_IO=3Dy
CONFIG_PCI=3Dy
CONFIG_PCI_DOMAINS=3Dy
CONFIG_RTC=3Dy
CONFIG_PCI_LEGACY_PROC=3Dy
CONFIG_PCI_NAMES=3Dy
CONFIG_SUN_OPENPROMFS=3Dm
CONFIG_SPARC32_COMPAT=3Dy
CONFIG_COMPAT=3Dy
CONFIG_BINFMT_ELF32=3Dy
# CONFIG_BINFMT_AOUT32 is not set
CONFIG_BINFMT_ELF=3Dy
# CONFIG_BINFMT_MISC is not set
# CONFIG_SUNOS_EMUL is not set
# CONFIG_SOLARIS_EMUL is not set

#
# Parallel port support
#
CONFIG_PARPORT=3Dm
# CONFIG_PARPORT_PC is not set
CONFIG_PARPORT_SUNBPP=3Dm
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=3Dy
CONFIG_PRINTER=3Dm
CONFIG_ENVCTRL=3Dm
# CONFIG_DISPLAY7SEG is not set
# CONFIG_WATCHDOG_CP1XXX is not set
# CONFIG_WATCHDOG_RIO is not set

#
# Generic Driver Options
#
# CONFIG_FW_LOADER is not set

#
# Graphics support
#
# CONFIG_FB is not set

#
# Console display driver support
#
# CONFIG_VGA_CONSOLE is not set
# CONFIG_MDA_CONSOLE is not set
# CONFIG_PROM_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=3Dy

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_SUNCORE=3Dy
CONFIG_SERIAL_SUNZILOG=3Dy
CONFIG_SERIAL_SUNZILOG_CONSOLE=3Dy
CONFIG_SERIAL_SUNSU=3Dy
CONFIG_SERIAL_SUNSU_CONSOLE=3Dy
# CONFIG_SERIAL_SUNSAB is not set
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy

#
# Misc Linux/SPARC drivers
#
CONFIG_SUN_OPENPROMIO=3Dm
CONFIG_SUN_MOSTEK_RTC=3Dy
CONFIG_OBP_FLASH=3Dm
# CONFIG_SUN_BPP is not set
# CONFIG_SUN_VIDEOPIX is not set
# CONFIG_SUN_AURORA is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=3Dy
CONFIG_BLK_DEV_LOOP=3Dm
# CONFIG_BLK_DEV_NBD is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=3Dy
CONFIG_BLK_DEV_MD=3Dm
CONFIG_MD_LINEAR=3Dm
CONFIG_MD_RAID0=3Dm
CONFIG_MD_RAID1=3Dm
CONFIG_MD_RAID5=3Dm
CONFIG_MD_MULTIPATH=3Dm
CONFIG_BLK_DEV_DM=3Dy
CONFIG_DM_IOCTL_V4=3Dy
# CONFIG_BLK_DEV_RAM is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=3Dm
CONFIG_BLK_DEV_IDE=3Dm

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
CONFIG_BLK_DEV_IDEDISK=3Dm
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=3Dm
CONFIG_BLK_DEV_IDETAPE=3Dm
CONFIG_BLK_DEV_IDEFLOPPY=3Dm
CONFIG_BLK_DEV_IDESCSI=3Dm
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_IDEPCI=3Dy
# CONFIG_IDEPCI_SHARE_IRQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=3Dy
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=3Dy
# CONFIG_BLK_DEV_AEC62XX is not set
CONFIG_BLK_DEV_ALI15X3=3Dm
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_BLK_DEV_IDEDMA=3Dy
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=3Dy
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=3Dy
CONFIG_SCSI_PROC_FS=3Dy

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dy
CONFIG_CHR_DEV_ST=3Dm
CONFIG_CHR_DEV_OSST=3Dm
CONFIG_BLK_DEV_SR=3Dm
CONFIG_BLK_DEV_SR_VENDOR=3Dy
CONFIG_CHR_DEV_SG=3Dm

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=3Dy
CONFIG_SCSI_REPORT_LUNS=3Dy
CONFIG_SCSI_CONSTANTS=3Dy
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_SYM53C8XX_2=3Dy
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=3D1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=3D16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=3D64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLOGICPTI is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_SUNESP is not set

#
# Fibre Channel support
#
# CONFIG_FC4 is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
CONFIG_IEEE1394=3Dm

#
# Subsystem Options
#
CONFIG_IEEE1394_VERBOSEDEBUG=3Dy
CONFIG_IEEE1394_OUI_DB=3Dy

#
# Device Drivers
#
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=3Dm

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=3Dm
CONFIG_IEEE1394_SBP2=3Dm
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
CONFIG_IEEE1394_ETH1394=3Dm
CONFIG_IEEE1394_DV1394=3Dm
CONFIG_IEEE1394_RAWIO=3Dm
CONFIG_IEEE1394_CMP=3Dm
CONFIG_IEEE1394_AMDTP=3Dm

#
# Networking support
#
CONFIG_NET=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dm
CONFIG_PACKET_MMAP=3Dy
CONFIG_NETLINK_DEV=3Dm
CONFIG_UNIX=3Dy
CONFIG_NET_KEY=3Dm
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=3Dm
CONFIG_NET_IPGRE=3Dm
# CONFIG_NET_IPGRE_BROADCAST is not set
CONFIG_IP_MROUTE=3Dy
CONFIG_IP_PIMSM_V1=3Dy
CONFIG_IP_PIMSM_V2=3Dy
# CONFIG_ARPD is not set
CONFIG_INET_ECN=3Dy
CONFIG_SYN_COOKIES=3Dy
CONFIG_INET_AH=3Dm
CONFIG_INET_ESP=3Dm
CONFIG_INET_IPCOMP=3Dm

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
CONFIG_NETFILTER=3Dy
CONFIG_NETFILTER_DEBUG=3Dy

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=3Dm
# CONFIG_IP_NF_FTP is not set
# CONFIG_IP_NF_IRC is not set
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
CONFIG_IP_NF_QUEUE=3Dm
CONFIG_IP_NF_IPTABLES=3Dm
CONFIG_IP_NF_MATCH_LIMIT=3Dm
CONFIG_IP_NF_MATCH_IPRANGE=3Dm
CONFIG_IP_NF_MATCH_MAC=3Dm
CONFIG_IP_NF_MATCH_PKTTYPE=3Dm
CONFIG_IP_NF_MATCH_MARK=3Dm
CONFIG_IP_NF_MATCH_MULTIPORT=3Dm
CONFIG_IP_NF_MATCH_TOS=3Dm
CONFIG_IP_NF_MATCH_RECENT=3Dm
CONFIG_IP_NF_MATCH_ECN=3Dm
CONFIG_IP_NF_MATCH_DSCP=3Dm
CONFIG_IP_NF_MATCH_AH_ESP=3Dm
CONFIG_IP_NF_MATCH_LENGTH=3Dm
CONFIG_IP_NF_MATCH_TTL=3Dm
CONFIG_IP_NF_MATCH_TCPMSS=3Dm
CONFIG_IP_NF_MATCH_HELPER=3Dm
CONFIG_IP_NF_MATCH_STATE=3Dm
CONFIG_IP_NF_MATCH_CONNTRACK=3Dm
CONFIG_IP_NF_MATCH_OWNER=3Dm
CONFIG_IP_NF_FILTER=3Dm
CONFIG_IP_NF_TARGET_REJECT=3Dm
CONFIG_IP_NF_NAT=3Dm
CONFIG_IP_NF_NAT_NEEDED=3Dy
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP_NF_TARGET_REDIRECT=3Dm
CONFIG_IP_NF_TARGET_NETMAP=3Dm
CONFIG_IP_NF_TARGET_SAME=3Dm
CONFIG_IP_NF_NAT_LOCAL=3Dy
CONFIG_IP_NF_NAT_SNMP_BASIC=3Dm
CONFIG_IP_NF_MANGLE=3Dm
CONFIG_IP_NF_TARGET_TOS=3Dm
CONFIG_IP_NF_TARGET_ECN=3Dm
CONFIG_IP_NF_TARGET_DSCP=3Dm
CONFIG_IP_NF_TARGET_MARK=3Dm
CONFIG_IP_NF_TARGET_CLASSIFY=3Dm
CONFIG_IP_NF_TARGET_LOG=3Dm
CONFIG_IP_NF_TARGET_ULOG=3Dm
CONFIG_IP_NF_TARGET_TCPMSS=3Dm
CONFIG_IP_NF_ARPTABLES=3Dm
CONFIG_IP_NF_ARPFILTER=3Dm
CONFIG_IP_NF_ARP_MANGLE=3Dm
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
CONFIG_XFRM=3Dy
CONFIG_XFRM_USER=3Dm

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=3Dy
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
CONFIG_NETDEVICES=3Dy

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
CONFIG_NET_ETHERNET=3Dy
# CONFIG_MII is not set
# CONFIG_SUNLANCE is not set
CONFIG_HAPPYMEAL=3Dy
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
CONFIG_SUNGEM=3Dy
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
# CONFIG_NET_PCI is not set

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
# Unix 98 PTY support
#
CONFIG_UNIX98_PTYS=3Dy
CONFIG_UNIX98_PTY_COUNT=3D256

#
# XFree86 DRI support
#
# CONFIG_DRM is not set

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
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=3Dy
CONFIG_SERIO=3Dy
# CONFIG_SERIO_I8042 is not set
CONFIG_SERIO_SERPORT=3Dy
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# I2C support
#
CONFIG_I2C=3Dm
CONFIG_I2C_CHARDEV=3Dm

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=3Dm
CONFIG_I2C_ALGOPCF=3Dm

#
# I2C Hardware Bus support
#
CONFIG_I2C_ALI1535=3Dm
CONFIG_I2C_ALI15X3=3Dm
CONFIG_I2C_AMD756=3Dm
CONFIG_I2C_AMD8111=3Dm
CONFIG_I2C_ELEKTOR=3Dm
CONFIG_I2C_I801=3Dm
# CONFIG_I2C_I810 is not set
CONFIG_I2C_NFORCE2=3Dm
CONFIG_I2C_PHILIPSPAR=3Dm
CONFIG_I2C_PIIX4=3Dm
CONFIG_I2C_PROSAVAGE=3Dm
# CONFIG_I2C_SAVAGE4 is not set
CONFIG_SCx200_ACB=3Dm
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=3Dm
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=3Dm
# CONFIG_I2C_VOODOO3 is not set

#
# I2C Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=3Dm
CONFIG_SENSORS_ADM1021=3Dm
# CONFIG_SENSORS_EEPROM is not set
CONFIG_SENSORS_IT87=3Dm
CONFIG_SENSORS_LM75=3Dm
CONFIG_SENSORS_LM78=3Dm
CONFIG_SENSORS_LM85=3Dm
CONFIG_SENSORS_VIA686A=3Dm
CONFIG_SENSORS_W83781D=3Dm

#
# File systems
#
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=3Dy
CONFIG_EXT3_FS_XATTR=3Dy
CONFIG_EXT3_FS_POSIX_ACL=3Dy
CONFIG_EXT3_FS_SECURITY=3Dy
CONFIG_JBD=3Dy
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=3Dy
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=3Dy
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=3Dm

#
# DOS/FAT/NT Filesystems
#
# CONFIG_FAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=3Dy
CONFIG_DEVPTS_FS_XATTR=3Dy
CONFIG_DEVPTS_FS_SECURITY=3Dy
# CONFIG_TMPFS is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=3Dy

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_EXPORTFS is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=3Dy
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_BSD_DISKLABEL=3Dy
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_NEC98_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=3Dy
# CONFIG_EFI_PARTITION is not set
CONFIG_NLS=3Dy

#
# Native Language Support
#
CONFIG_NLS_DEFAULT=3D"iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
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
# CONFIG_NLS_ISO8859_1 is not set
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
# CONFIG_NLS_UTF8 is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB=3Dm
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=3Dy
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=3Dm
CONFIG_USB_OHCI_HCD=3Dm
CONFIG_USB_UHCI_HCD=3Dm

#
# USB Device Class drivers
#
CONFIG_USB_BLUETOOTH_TTY=3Dm
CONFIG_USB_ACM=3Dm
CONFIG_USB_PRINTER=3Dm
CONFIG_USB_STORAGE=3Dm
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
CONFIG_USB_HID=3Dm
# CONFIG_USB_HIDINPUT is not set
# CONFIG_USB_HIDDEV is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=3Dm
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

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
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_GADGET is not set

#
# Watchdog
#
# CONFIG_SOFT_WATCHDOG is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=3Dy
CONFIG_DEBUG_SLAB=3Dy
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_DEBUG_SPINLOCK=3Dy
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
CONFIG_DEBUG_BUGVERBOSE=3Dy
CONFIG_DEBUG_DCFLUSH=3Dy
CONFIG_DEBUG_INFO=3Dy
# CONFIG_STACK_DEBUG is not set

#
# Security options
#
CONFIG_SECURITY=3Dy
CONFIG_SECURITY_NETWORK=3Dy
CONFIG_SECURITY_CAPABILITIES=3Dy
# CONFIG_SECURITY_ROOTPLUG is not set
CONFIG_SECURITY_SELINUX=3Dy
# CONFIG_SECURITY_SELINUX_BOOTPARAM is not set
CONFIG_SECURITY_SELINUX_DEVELOP=3Dy
# CONFIG_SECURITY_SELINUX_MLS is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=3Dy
CONFIG_CRYPTO_HMAC=3Dy
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=3Dm
CONFIG_CRYPTO_SHA1=3Dm
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
CONFIG_CRYPTO_DES=3Dm
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
CONFIG_CRYPTO_AES=3Dm
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DEFLATE=3Dm
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC32=3Dy
CONFIG_ZLIB_INFLATE=3Dm
CONFIG_ZLIB_DEFLATE=3Dm

--=-NnzkSOV2cXd/U0AAbD11
Content-Disposition: attachment; filename=dmesg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=dmesg; charset=ISO-8859-2

PROMLIB: Sun IEEE Boot Prom 4.0.4 2001/03/22 15:42
Linux version 2.6.0-test6 (root@szoketto) (gcc version 3.3.2 20030908 (Debi=
an prerelease)) #2 Thu Oct 2 06:06:11 UTC 2003
ARCH: SUN4U
Ethernet address: 00:03:ba:0f:be:95
On node 0 totalpages: 64859
  DMA zone: 64859 pages, LIFO batch:8
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: root=3D/dev/sda1 ro -p console=3DttyS0
PID hash table entries: 4096 (order 12: 65536 bytes)
Console: colour dummy device 80x25
Memory: 509760k available (2240k kernel code, 808k data, 128k init) [fffff8=
0000000000,000000002fea6000]
Calibrating delay loop... 999.42 BogoMIPS
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security failed=
.
Failure registering capabilities with the kernel
selinux_register_security:  Registering secondary module capability
Capability LSM initialized
Dentry cache hash table entries: 65536 (order: 6, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 5, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 8192 bytes)
POSIX conformance testing by UNIFIX
kernel/sched.c:761: spin_unlock(arch/sparc64/kernel/init_task.c:00000000006=
75e10) not locked
NET: Registered protocol family 16
PCI: Probing for controllers.
PCI: Found SABRE, main regs at 000001fe00000000, wsync at 000001fe00001c20
SABRE: Shared PCI config space at 000001fe01000000
SABRE: DVMA at c0000000 [20000000]
PCI: 0000:00:01.2: class 5c5c doesn't match header type 01. Ignoring class.
PCI-IRQ: Routing bus[ 2] slot[ 8] map[0] to INO[20]
PCI-IRQ: Routing bus[ 2] slot[ 8] map[0] to INO[20]
PCI-IRQ: Routing bus[ 3] slot[ 0] map[1] to INO[05]
PCI-IRQ: Routing bus[ 3] slot[ 1] map[1] to INO[14]
PCI-IRQ: Routing bus[ 3] slot[ 2] map[1] to INO[04]
PCI-IRQ: Routing bus[ 3] slot[ 3] map[1] to INO[15]
PCI0(PBMA): Bus running at 33MHz
PCI-IRQ: Routing bus[ 1] slot[ 5] map[0] to INO[1c]
PCI-IRQ: Routing bus[ 1] slot[ 5] map[0] to INO[26]
PCI-IRQ: Routing bus[ 1] slot[ c] map[0] to INO[06]
PCI-IRQ: Routing bus[ 1] slot[ c] map[0] to INO[24]
PCI-IRQ: Routing bus[ 1] slot[ d] map[0] to INO[0c]
PCI0(PBMB): Bus running at 33MHz
isa0: [power] [serial] [serial]
ebus0: [flashprom] [eeprom] [idprom] [SUNW,lomh]
SCSI subsystem initialized
ikconfig 0.7 with /proc/config*
Initializing Cryptographic API
pty: 256 Unix98 ptys configured
rtc_init: no PC rtc found
drivers/serial/sunsu.c:1149: spin_is_locked on uninitialized spinlock 00000=
00000757a78.
drivers/serial/sunsu.c:1284: spin_is_locked on uninitialized spinlock 00000=
00000757a78.
drivers/serial/sunsu.c:1149: spin_is_locked on uninitialized spinlock 00000=
00000757be0.
drivers/serial/sunsu.c:1284: spin_is_locked on uninitialized spinlock 00000=
00000757be0.
ttyS0 at MMIO 0x1fe020003f8 (irq =3D 0) is a 16550A
ttyS1 at MMIO 0x1fe020002e8 (irq =3D 0) is a 16550A
Using anticipatory io scheduler
sunhme.c:v2.02 24/Aug/2003 David S. Miller (davem@redhat.com)
eth0-3: Quattro HME (PCI/CheerIO) 10/100baseT Ethernet unknown bridge 8086.=
b154
eth0: Quattro HME slot 0 (PCI/CheerIO) 10/100baseT Ethernet 08:00:20:e9:d4:=
38=20
eth1: Quattro HME slot 1 (PCI/CheerIO) 10/100baseT Ethernet 08:00:20:e9:d4:=
39=20
eth2: Quattro HME slot 2 (PCI/CheerIO) 10/100baseT Ethernet 08:00:20:e9:d4:=
3a=20
eth3: Quattro HME slot 3 (PCI/CheerIO) 10/100baseT Ethernet 08:00:20:e9:d4:=
3b=20
sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
eth4: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:ba:0f:be:96=20
eth4: Found Generic MII PHY
eth5: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:ba:0f:be:95=20
eth5: Found Generic MII PHY
sym0: <896> rev 0x7 at pci 0000:02:08.0 irq 4,7e0
sym0: No NVRAM, ID 7, Fast-40, LVD, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18b
  Vendor: SEAGATE   Model: ST318305LSUN18G   Rev: 0340
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym0:0:0: tagged command queuing enabled, command queue depth 16.
sym0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 31)
sym1: <896> rev 0x7 at pci 0000:02:08.1 irq 4,7e0
sym1: No NVRAM, ID 7, Fast-40, LVD, parity checking
sym1: SCSI BUS has been reset.
scsi1 : sym-2.1.18b
SCSI device sda: 35378533 512-byte hdwr sectors (18114 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
mice: PS/2 mouse device common for all mice
device-mapper: 4.0.0-ioctl (2003-06-04) initialised: dm@uk.sistina.com
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 56Kbytes
TCP: Hash tables configured (established 65536 bind 9362)
NET: Registered protocol family 1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
drivers/serial/sunsu.c:298: spin_lock(drivers/serial/serial_core.c:00000000=
00757a78) already locked by drivers/serial/serial_core.c/1258
drivers/serial/serial_core.c:1260: spin_unlock(drivers/serial/serial_core.c=
:0000000000757a78) not locked
drivers/serial/sunsu.c:298: spin_lock(drivers/serial/serial_core.c:00000000=
00757a78) already locked by drivers/serial/serial_core.c/1258
drivers/serial/serial_core.c:1260: spin_unlock(drivers/serial/serial_core.c=
:0000000000757a78) not locked
drivers/serial/sunsu.c:298: spin_lock(drivers/serial/serial_core.c:00000000=
00757a78) already locked by drivers/serial/serial_core.c/1258
Adding 306264k swap on /dev/sda2.  Priority:-1 extents:1
EXT3 FS on sda1, internal journal
kernel BUG at arch/sparc64/kernel/module.c:207!
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
modprobe(51): Kernel bad sw trap 5 [#1]
TSTATE: 0000000011009606 TPC: 00000000004402f0 TNPC: 00000000004402f4 Y: ff=
ffed7c    Not tainted
TPC: <apply_relocate_add+0x230/0x240>
g0: 0000000000000000 g1: 000000000067ac00 g2: 0000000000000001 g3: 00000000=
000001f9
g4: fffff8002eff70a0 g5: 0000000000000000 g6: fffff80000e28000 g7: 00000000=
00000000
o0: 0000000000000030 o1: 000000000067ac00 o2: 000000000067ac00 o3: 00000000=
00000000
o4: 0000000000000000 o5: 000000000073c2f0 sp: fffff80000e2b331 ret_pc: 0000=
0000004402e8
RPC: <apply_relocate_add+0x228/0x240>
l0: 0000000000000fd8 l1: 00000000020039e8 l2: 00000000000000aa l3: 00000000=
000000aa
l4: 000000000000fff1 l5: 0000000000000000 l6: 000000000000fff2 l7: 80000000=
00000000
i0: 00000001400492c8 i1: 00000000020049d8 i2: 0000000000000025 i3: 00000000=
00000017
i4: 0000000002005500 i5: 0000000002005500 i6: fffff80000e2b3f1 i7: 00000000=
00470e74
I7: <load_module+0x794/0x8a0>
Instruction DUMP: 921020cf  7fff6f2e  90122278 <91d02005> 81cfe008  0100000=
0  01000000  81c3e008  90102000=20
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth5: Link is up at 10 Mbps, half-duplex.
eth5: Pause is disabled

--=-NnzkSOV2cXd/U0AAbD11
Content-Disposition: attachment; filename=ksymoops
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=ksymoops; charset=ISO-8859-2

ksymoops 2.4.9 on sparc64 2.6.0-test6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test6/ (default)
     -m /boot/System.map-2.6.0-test6 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
kernel BUG at arch/sparc64/kernel/module.c:207!
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
modprobe(51): Kernel bad sw trap 5 [#1]
TSTATE: 0000000011009606 TPC: 00000000004402f0 TNPC: 00000000004402f4 Y: ff=
ffed7c    Not tainted
Using defaults from ksymoops -t elf32-sparc -a sparc
g0: 0000000000000000 g1: 000000000067ac00 g2: 0000000000000001 g3: 00000000=
000001f9
g4: fffff8002eff70a0 g5: 0000000000000000 g6: fffff80000e28000 g7: 00000000=
00000000
o0: 0000000000000030 o1: 000000000067ac00 o2: 000000000067ac00 o3: 00000000=
00000000
o4: 0000000000000000 o5: 000000000073c2f0 sp: fffff80000e2b331 ret_pc: 0000=
0000004402e8
l0: 0000000000000fd8 l1: 00000000020039e8 l2: 00000000000000aa l3: 00000000=
000000aa
l4: 000000000000fff1 l5: 0000000000000000 l6: 000000000000fff2 l7: 80000000=
00000000
i0: 00000001400492c8 i1: 00000000020049d8 i2: 0000000000000025 i3: 00000000=
00000017
i4: 0000000002005500 i5: 0000000002005500 i6: fffff80000e2b3f1 i7: 00000000=
00470e74


>>PC;  004402f0 <apply_relocate_add+230/240>   <=3D=3D=3D=3D=3D

>>g1; 0067ac00 <abi_table+100/230>
>>o1; 0067ac00 <abi_table+100/230>
>>o2; 0067ac00 <abi_table+100/230>
>>o5; 0073c2f0 <printk_buf.4+30/400>
>>ret_pc; 004402e8 <apply_relocate_add+228/240>
>>l1; 020039e8 <__crc_pci_unregister_driver+22b6a6/384df7>
>>i1; 020049d8 <__crc_pci_unregister_driver+22c696/384df7>
>>i4; 02005500 <__crc_pci_unregister_driver+22d1be/384df7>
>>i5; 02005500 <__crc_pci_unregister_driver+22d1be/384df7>
>>i7; 00470e74 <load_module+794/8a0>

Instruction DUMP: 921020cf  7fff6f2e  90122278 <91d02005> 81cfe008  0100000=
0  01000000  81c3e008  90102000=20


Code;  004402e4 <apply_relocate_add+224/240>
00000000 <_PC>:
Code;  004402e4 <apply_relocate_add+224/240>
   0:   92 10 20 cf       mov  0xcf, %o1
Code;  004402e8 <apply_relocate_add+228/240>
   4:   7f ff 6f 2e       call  fffdbcbc <_PC+0xfffdbcbc>
Code;  004402ec <apply_relocate_add+22c/240>
   8:   90 12 22 78       or  %o0, 0x278, %o0
Code;  004402f0 <apply_relocate_add+230/240>
   c:   91 d0 20 05       ta  5
Code;  004402f4 <apply_relocate_add+234/240>
  10:   81 cf e0 08       rett  %i7 + 8
Code;  004402f8 <apply_relocate_add+238/240>
  14:   01 00 00 00       nop=20
Code;  004402fc <apply_relocate_add+23c/240>
  18:   01 00 00 00       nop=20
Code;  00440300 <module_finalize+0/20>
  1c:   81 c3 e0 08       retl=20
Code;  00440304 <module_finalize+4/20>
  20:   90 10 20 00       clr  %o0     ! 0 <_PC>


1 warning and 1 error issued.  Results may not be reliable.

--=-NnzkSOV2cXd/U0AAbD11
Content-Disposition: attachment; filename=ver_linux.in_buildbox
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=ver_linux.in_buildbox; charset=ISO-8859-2

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
Linux szoketto 2.6.0-test6 #2 Thu Oct 2 06:06:11 UTC 2003 sparc64 GNU/Linux
=20
Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
e2fsprogs              1.35-WIP
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.12
Net-tools              1.60
Kbd                    76:
Sh-utils               5.0.90

--=-NnzkSOV2cXd/U0AAbD11
Content-Disposition: attachment; filename=ver_linux.in_tcb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=ver_linux.in_tcb; charset=ISO-8859-2

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
Linux szoketto 2.6.0-test6 #2 Thu Oct 2 06:06:11 UTC 2003 sparc64 GNU/Linux
=20
Gnu C                  18:
util-linux             2.11z
mount                  2.11z
e2fsprogs              1.34-WIP
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.9
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0

--=-NnzkSOV2cXd/U0AAbD11--
