Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267856AbTBRP0m>; Tue, 18 Feb 2003 10:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267859AbTBRP0m>; Tue, 18 Feb 2003 10:26:42 -0500
Received: from franka.aracnet.com ([216.99.193.44]:24538 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267856AbTBRP0e>; Tue, 18 Feb 2003 10:26:34 -0500
Date: Tue, 18 Feb 2003 07:36:18 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 372] New: uml doesn't not compile
Message-ID: <2400000.1045582578@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=372

           Summary: uml doesn't not compile
    Kernel Version: 2.5.62
            Status: NEW
          Severity: normal
             Owner: jdike@karaya.com
         Submitter: tamaguci@katamail.com


Distribution: Debian Linux Sid 
Software Environment: latest update (gcc (GCC) 3.2.3 20030210 (Debian prerelease)) 
Problem Description: 
kernel doesn't compile, it gives these errors: 
  gcc -Wp,-MD,arch/um/kernel/.init_task.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -U__i386__ 
-Ui386 -g -D__arch_um__ -DSUBARCH=\"i386\" -D_LARGEFILE64_SOURCE 
-Iarch/um/include -Derrno=kernel_errno 
-I/compilazione/kernel/linux-2.5.61/arch/um/kernel/tt/include 
-I/compilazione/kernel/linux-2.5.61/arch/um/kernel/skas/include -nostdinc -iwithprefix 
include    -DKBUILD_BASENAME=init_task -DKBUILD_MODNAME=init_task -c -o 
arch/um/kernel/init_task.o arch/um/kernel/init_task.c 
arch/um/kernel/init_task.c:27: `init_sighand' undeclared here (not in a function) 
arch/um/kernel/init_task.c:27: initializer element is not constant 
arch/um/kernel/init_task.c:27: (near initialization for `init_task.sighand') 
arch/um/kernel/init_task.c:27: initializer element is not constant 
arch/um/kernel/init_task.c:27: (near initialization for `init_task.pending.signal.sig') 
arch/um/kernel/init_task.c:27: initializer element is not constant 
arch/um/kernel/init_task.c:27: (near initialization for `init_task.pending.signal') 
arch/um/kernel/init_task.c:27: initializer element is not constant 
arch/um/kernel/init_task.c:27: (near initialization for `init_task.pending') 
arch/um/kernel/init_task.c:27: initializer element is not constant 
arch/um/kernel/init_task.c:27: (near initialization for `init_task.blocked.sig') 
arch/um/kernel/init_task.c:27: initializer element is not constant 
arch/um/kernel/init_task.c:27: (near initialization for `init_task.blocked') 
arch/um/kernel/init_task.c:27: initializer element is not constant 
arch/um/kernel/init_task.c:27: (near initialization for `init_task.alloc_lock') 
arch/um/kernel/init_task.c:27: initializer element is not constant 
arch/um/kernel/init_task.c:27: (near initialization for `init_task.switch_lock') 
make[1]: *** [arch/um/kernel/init_task.o] Error 1 
make: *** [arch/um/kernel] Error 2 
 
 
Steps to reproduce: 
make mrproper&& cp config .config && make oldconfig ARCH=um && make dep 
ARCH=um && make linux ARCH=mu 
 
 
# 
# Automatically generated make config: don't edit 
# 
CONFIG_USERMODE=y 
CONFIG_MMU=y 
CONFIG_SWAP=y 
CONFIG_UID16=y 
CONFIG_RWSEM_GENERIC_SPINLOCK=y 
 
# 
# UML-specific options 
# 
CONFIG_MODE_TT=y 
CONFIG_MODE_SKAS=y 
CONFIG_NET=y 
CONFIG_BINFMT_AOUT=y 
CONFIG_BINFMT_ELF=y 
CONFIG_BINFMT_MISC=y 
CONFIG_HOSTFS=y 
CONFIG_MCONSOLE=y 
CONFIG_MAGIC_SYSRQ=y 
# CONFIG_HOST_2G_2G is not set 
# CONFIG_UML_SMP is not set 
# CONFIG_SMP is not set 
CONFIG_NEST_LEVEL=0 
CONFIG_KERNEL_HALF_GIGS=1 
# CONFIG_HIGHMEM is not set 
CONFIG_KERNEL_STACK_ORDER=2 
 
# 
# Code maturity level options 
# 
CONFIG_EXPERIMENTAL=y 
 
# 
# General setup 
# 
CONFIG_SYSVIPC=y 
CONFIG_BSD_PROCESS_ACCT=y 
CONFIG_SYSCTL=y 
CONFIG_LOG_BUF_SHIFT=14 
 
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
CONFIG_UML_SOUND=y 
CONFIG_SOUND=y 
CONFIG_HOSTAUDIO=y 
 
# 
# Block Devices 
# 
CONFIG_BLK_DEV_UBD=y 
CONFIG_BLK_DEV_UBD_SYNC=y 
CONFIG_BLK_DEV_LOOP=y 
CONFIG_BLK_DEV_NBD=y 
CONFIG_BLK_DEV_RAM=y 
CONFIG_BLK_DEV_RAM_SIZE=4096 
CONFIG_BLK_DEV_INITRD=y 
CONFIG_MMAPPER=y 
CONFIG_NETDEVICES=y 
 
# 
# Network Devices 
# 
CONFIG_UML_NET=y 
CONFIG_UML_NET_ETHERTAP=y 
CONFIG_UML_NET_TUNTAP=y 
CONFIG_UML_NET_SLIP=y 
CONFIG_UML_NET_DAEMON=y 
CONFIG_UML_NET_MCAST=y 
# CONFIG_UML_NET_PCAP is not set 
# CONFIG_UML_NET_SLIRP is not set 
CONFIG_DUMMY=y 
# CONFIG_BONDING is not set 
# CONFIG_EQUALIZER is not set 
CONFIG_TUN=y 
# CONFIG_ETHERTAP is not set 
CONFIG_PPP=m 
# CONFIG_PPP_MULTILINK is not set 
CONFIG_PPP_ASYNC=m 
CONFIG_PPP_SYNC_TTY=m 
CONFIG_PPP_DEFLATE=m 
CONFIG_PPP_BSDCOMP=m 
CONFIG_PPPOE=m 
CONFIG_SLIP=y 
# CONFIG_SLIP_COMPRESSED is not set 
# CONFIG_SLIP_SMART is not set 
# CONFIG_SLIP_MODE_SLIP6 is not set 
 
# 
# Networking support 
# 
 
# 
# Networking options 
# 
CONFIG_PACKET=y 
CONFIG_PACKET_MMAP=y 
# CONFIG_NETLINK_DEV is not set 
CONFIG_NETFILTER=y 
# CONFIG_NETFILTER_DEBUG is not set 
# CONFIG_FILTER is not set 
CONFIG_UNIX=y 
# CONFIG_NET_KEY is not set 
CONFIG_INET=y 
# CONFIG_IP_MULTICAST is not set 
# CONFIG_IP_ADVANCED_ROUTER is not set 
# CONFIG_IP_PNP is not set 
# CONFIG_NET_IPIP is not set 
# CONFIG_NET_IPGRE is not set 
# CONFIG_ARPD is not set 
# CONFIG_INET_ECN is not set 
# CONFIG_SYN_COOKIES is not set 
# CONFIG_INET_AH is not set 
# CONFIG_INET_ESP is not set 
# CONFIG_XFRM_USER is not set 
 
# 
# IP: Netfilter Configuration 
# 
CONFIG_IP_NF_CONNTRACK=m 
CONFIG_IP_NF_FTP=m 
CONFIG_IP_NF_IRC=m 
CONFIG_IP_NF_QUEUE=m 
CONFIG_IP_NF_IPTABLES=m 
CONFIG_IP_NF_MATCH_LIMIT=m 
CONFIG_IP_NF_MATCH_MAC=m 
CONFIG_IP_NF_MATCH_PKTTYPE=m 
CONFIG_IP_NF_MATCH_MARK=m 
CONFIG_IP_NF_MATCH_MULTIPORT=m 
CONFIG_IP_NF_MATCH_TOS=m 
CONFIG_IP_NF_MATCH_ECN=m 
CONFIG_IP_NF_MATCH_DSCP=m 
CONFIG_IP_NF_MATCH_AH_ESP=m 
CONFIG_IP_NF_MATCH_LENGTH=m 
CONFIG_IP_NF_MATCH_TTL=m 
CONFIG_IP_NF_MATCH_TCPMSS=m 
CONFIG_IP_NF_MATCH_HELPER=m 
CONFIG_IP_NF_MATCH_STATE=m 
CONFIG_IP_NF_MATCH_CONNTRACK=m 
CONFIG_IP_NF_MATCH_UNCLEAN=m 
CONFIG_IP_NF_MATCH_OWNER=m 
CONFIG_IP_NF_FILTER=m 
CONFIG_IP_NF_TARGET_REJECT=m 
CONFIG_IP_NF_TARGET_MIRROR=m 
CONFIG_IP_NF_NAT=m 
CONFIG_IP_NF_NAT_NEEDED=y 
CONFIG_IP_NF_TARGET_MASQUERADE=m 
CONFIG_IP_NF_TARGET_REDIRECT=m 
CONFIG_IP_NF_NAT_LOCAL=y 
CONFIG_IP_NF_NAT_SNMP_BASIC=m 
CONFIG_IP_NF_NAT_IRC=m 
CONFIG_IP_NF_NAT_FTP=m 
CONFIG_IP_NF_MANGLE=m 
CONFIG_IP_NF_TARGET_TOS=m 
CONFIG_IP_NF_TARGET_ECN=m 
CONFIG_IP_NF_TARGET_DSCP=m 
CONFIG_IP_NF_TARGET_MARK=m 
CONFIG_IP_NF_TARGET_LOG=m 
CONFIG_IP_NF_TARGET_ULOG=m 
CONFIG_IP_NF_TARGET_TCPMSS=m 
CONFIG_IP_NF_ARPTABLES=m 
CONFIG_IP_NF_ARPFILTER=m 
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set 
# CONFIG_IP_NF_COMPAT_IPFWADM is not set 
CONFIG_IPV6=m 
 
# 
# IPv6: Netfilter Configuration 
# 
CONFIG_IP6_NF_QUEUE=m 
CONFIG_IP6_NF_IPTABLES=m 
CONFIG_IP6_NF_MATCH_LIMIT=m 
CONFIG_IP6_NF_MATCH_MAC=m 
CONFIG_IP6_NF_MATCH_MULTIPORT=m 
CONFIG_IP6_NF_MATCH_OWNER=m 
CONFIG_IP6_NF_MATCH_MARK=m 
CONFIG_IP6_NF_MATCH_LENGTH=m 
CONFIG_IP6_NF_MATCH_EUI64=m 
CONFIG_IP6_NF_FILTER=m 
CONFIG_IP6_NF_TARGET_LOG=m 
CONFIG_IP6_NF_MANGLE=m 
CONFIG_IP6_NF_TARGET_MARK=m 
 
# 
# SCTP Configuration (EXPERIMENTAL) 
# 
CONFIG_IPV6_SCTP__=m 
# CONFIG_IP_SCTP is not set 
# CONFIG_ATM is not set 
# CONFIG_VLAN_8021Q is not set 
# CONFIG_LLC is not set 
# CONFIG_DECNET is not set 
# CONFIG_BRIDGE is not set 
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
 
# 
# Ethernet (10 or 100Mbit) 
# 
CONFIG_NET_ETHERNET=y 
CONFIG_MII=y 
 
# 
# Ethernet (1000 Mbit) 
# 
 
# 
# Wireless LAN (non-hamradio) 
# 
# CONFIG_NET_RADIO is not set 
 
# 
# Token Ring devices (depends on LLC=y) 
# 
# CONFIG_SHAPER is not set 
 
# 
# Wan interfaces 
# 
# CONFIG_WAN is not set 
 
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
# CONFIG_AFFS_FS is not set 
# CONFIG_HFS_FS is not set 
# CONFIG_BEFS_FS is not set 
# CONFIG_BFS_FS is not set 
CONFIG_EXT3_FS=y 
# CONFIG_EXT3_FS_XATTR is not set 
CONFIG_JBD=y 
# CONFIG_JBD_DEBUG is not set 
CONFIG_FAT_FS=m 
CONFIG_MSDOS_FS=m 
CONFIG_VFAT_FS=m 
# CONFIG_EFS_FS is not set 
# CONFIG_CRAMFS is not set 
# CONFIG_TMPFS is not set 
CONFIG_RAMFS=y 
CONFIG_ISO9660_FS=m 
CONFIG_JOLIET=y 
CONFIG_ZISOFS=y 
# CONFIG_JFS_FS is not set 
# CONFIG_MINIX_FS is not set 
# CONFIG_VXFS_FS is not set 
# CONFIG_NTFS_FS is not set 
# CONFIG_HPFS_FS is not set 
CONFIG_PROC_FS=y 
CONFIG_DEVFS_FS=y 
CONFIG_DEVFS_MOUNT=y 
# CONFIG_DEVFS_DEBUG is not set 
CONFIG_DEVPTS_FS=y 
# CONFIG_QNX4FS_FS is not set 
# CONFIG_ROMFS_FS is not set 
CONFIG_EXT2_FS=y 
# CONFIG_EXT2_FS_XATTR is not set 
# CONFIG_SYSV_FS is not set 
# CONFIG_UDF_FS is not set 
# CONFIG_UFS_FS is not set 
# CONFIG_XFS_FS is not set 
 
# 
# Network File Systems 
# 
CONFIG_CODA_FS=m 
CONFIG_INTERMEZZO_FS=m 
CONFIG_NFS_FS=m 
CONFIG_NFS_V3=y 
# CONFIG_NFS_V4 is not set 
CONFIG_NFSD=m 
CONFIG_NFSD_V3=y 
# CONFIG_NFSD_V4 is not set 
# CONFIG_NFSD_TCP is not set 
CONFIG_SUNRPC=m 
CONFIG_SUNRPC_GSS=m 
CONFIG_LOCKD=m 
CONFIG_LOCKD_V4=y 
CONFIG_EXPORTFS=m 
CONFIG_CIFS=m 
CONFIG_SMB_FS=m 
# CONFIG_SMB_NLS_DEFAULT is not set 
CONFIG_NCP_FS=m 
# CONFIG_NCPFS_PACKET_SIGNING is not set 
# CONFIG_NCPFS_IOCTL_LOCKING is not set 
# CONFIG_NCPFS_STRONG is not set 
# CONFIG_NCPFS_NFS_NS is not set 
# CONFIG_NCPFS_OS2_NS is not set 
# CONFIG_NCPFS_SMALLDOS is not set 
# CONFIG_NCPFS_NLS is not set 
# CONFIG_NCPFS_EXTRAS is not set 
CONFIG_AFS_FS=m 
CONFIG_RXRPC=m 
CONFIG_ZISOFS_FS=m 
 
# 
# Partition Types 
# 
# CONFIG_PARTITION_ADVANCED is not set 
CONFIG_MSDOS_PARTITION=y 
CONFIG_SMB_NLS=y 
CONFIG_NLS=y 
 
# 
# Native Language Support 
# 
CONFIG_NLS_DEFAULT="iso8859-1" 
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
CONFIG_ZLIB_INFLATE=m 
CONFIG_ZLIB_DEFLATE=m 
 
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
# CONFIG_DEBUGSYM is not set


