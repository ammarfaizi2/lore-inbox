Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbTJVIiG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 04:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263347AbTJVIiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 04:38:05 -0400
Received: from pluvier.ens-lyon.fr ([140.77.167.5]:41612 "EHLO
	mailhost.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S263309AbTJVIhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 04:37:53 -0400
Date: Wed, 22 Oct 2003 10:37:42 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
To: jdike@addtoit.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: uml-patch-2.6.0-test8
Message-ID: <20031022083742.GR8782@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+xNpyl7Qekk2NvDX"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Jeff,

Your last UML patch for 2.6.0-test8 looks fine for me,
except when enabling loadable module support (CONFIG_MODULES).
.config is attached.

  CC      arch/um/sys-i386/module.o
arch/um/sys-i386/module.c: In function apply_relocate':
arch/um/sys-i386/module.c:79: R_386_32' undeclared (first use in this function)
arch/um/sys-i386/module.c:79: (Each undeclared identifier is reported only once
arch/um/sys-i386/module.c:79: for each function it appears in.)
arch/um/sys-i386/module.c:83: R_386_PC32' undeclared (first use in this function)
arch/um/sys-i386/module.c:81: warning: unreachable code at beginning of switch statement
make[1]: *** [arch/um/sys-i386/module.o] Error 1
make: *** [arch/um/sys-i386] Error 2

Regards,
--
Brice Goglin
================================================
Ph.D Student
Laboratoire de l'Informatique et du Parallélisme
CNRS-INRIA-ENS Lyon
France

--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=".config"

#
# Automatically generated make config: don't edit
#
CONFIG_USERMODE=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y

#
# UML-specific options
#
CONFIG_MODE_TT=y
CONFIG_MODE_SKAS=y
CONFIG_NET=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_HOSTFS=y
# CONFIG_MCONSOLE is not set
# CONFIG_HOST_2G_2G is not set
# CONFIG_UML_SMP is not set
# CONFIG_SMP is not set
CONFIG_NEST_LEVEL=0
CONFIG_KERNEL_HALF_GIGS=1
CONFIG_HIGHMEM=y
CONFIG_PROC_MM=y
CONFIG_KERNEL_STACK_ORDER=2

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set
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

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODULE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_KMOD is not set

#
# Generic Driver Options
#

#
# Character Devices
#
CONFIG_STDIO_CONSOLE=y
CONFIG_SSL=y
CONFIG_FD_CHAN=y
CONFIG_NULL_CHAN=y
CONFIG_PORT_CHAN=y
CONFIG_PTY_CHAN=y
CONFIG_TTY_CHAN=y
CONFIG_XTERM_CHAN=y
CONFIG_CON_ZERO_CHAN="fd:0,fd:1"
CONFIG_CON_CHAN="xterm"
CONFIG_SSL_CHAN="pty"
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
# CONFIG_WATCHDOG is not set
# CONFIG_UML_SOUND is not set
# CONFIG_SOUND is not set
# CONFIG_HOSTAUDIO is not set

#
# Block Devices
#
CONFIG_BLK_DEV_UBD=y
# CONFIG_BLK_DEV_UBD_SYNC is not set
CONFIG_BLK_DEV_COW_COMMON=y
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_MMAPPER is not set
CONFIG_NETDEVICES=y

#
# UML Network Devices
#
# CONFIG_UML_NET is not set

#
# Networking support
#

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
# CONFIG_IP_MULTIPLE_TABLES is not set
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_TOS is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
# CONFIG_IP_NF_IRC is not set
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=y
# CONFIG_IP_NF_MATCH_LIMIT is not set
# CONFIG_IP_NF_MATCH_IPRANGE is not set
# CONFIG_IP_NF_MATCH_MAC is not set
# CONFIG_IP_NF_MATCH_PKTTYPE is not set
# CONFIG_IP_NF_MATCH_MARK is not set
CONFIG_IP_NF_MATCH_MULTIPORT=y
# CONFIG_IP_NF_MATCH_TOS is not set
# CONFIG_IP_NF_MATCH_RECENT is not set
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_DSCP is not set
# CONFIG_IP_NF_MATCH_AH_ESP is not set
# CONFIG_IP_NF_MATCH_LENGTH is not set
# CONFIG_IP_NF_MATCH_TTL is not set
# CONFIG_IP_NF_MATCH_TCPMSS is not set
# CONFIG_IP_NF_MATCH_HELPER is not set
CONFIG_IP_NF_MATCH_STATE=y
# CONFIG_IP_NF_MATCH_CONNTRACK is not set
# CONFIG_IP_NF_MATCH_OWNER is not set
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
# CONFIG_IP_NF_TARGET_REDIRECT is not set
# CONFIG_IP_NF_TARGET_NETMAP is not set
# CONFIG_IP_NF_TARGET_SAME is not set
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_FTP=y
# CONFIG_IP_NF_MANGLE is not set
CONFIG_IP_NF_TARGET_LOG=y
# CONFIG_IP_NF_TARGET_ULOG is not set
# CONFIG_IP_NF_TARGET_TCPMSS is not set
# CONFIG_IP_NF_ARPTABLES is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_DUMMY=y
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#

#
# Ethernet (10000 Mbit)
#
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#

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
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_XATTR is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_FAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_DEVPTS_FS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
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

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC32 is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_DEBUG_INFO=y
CONFIG_FRAME_POINTER=y
# CONFIG_PT_PROXY is not set
# CONFIG_GPROF is not set
# CONFIG_GCOV is not set

--+xNpyl7Qekk2NvDX--
