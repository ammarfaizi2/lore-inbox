Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289793AbSBNFyZ>; Thu, 14 Feb 2002 00:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289850AbSBNFyH>; Thu, 14 Feb 2002 00:54:07 -0500
Received: from defiant.secureone.com.au ([203.55.158.195]:10407 "EHLO
	defiant.secureone.com.au") by vger.kernel.org with ESMTP
	id <S289793AbSBNFxy>; Thu, 14 Feb 2002 00:53:54 -0500
Posted-Date: Thu, 14 Feb 2002 15:54:20 +1000
X-URL: SecureONE SecureSentry - http://www.secureone.com.au/
Message-ID: <048401c1b51c$829f6340$0f01000a@brisbane.hatfields.com.au>
Reply-To: "Andrew Hatfield" <lkml@secureone.com.au>
From: "Andrew Hatfield" <lkml@secureone.com.au>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: compilation problems with 2.4.18-pre9-mjc2
Date: Thu, 14 Feb 2002 15:57:39 +1000
Organization: SecureONE
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

apologies for the verboseness of this, not sure how much to include

here is (i believe) the relevant config entries
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

# CONFIG_QUOTA is not set
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=y
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
CONFIG_CRAMFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_MINIX_FS=y
# CONFIG_VXFS_FS is not set
CONFIG_NTFS_FS=y
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
CONFIG_ROMFS_FS=y
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
CONFIG_UDF_FS=y
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_ROOT_NFS=y
CONFIG_NFSD=y
# CONFIG_NFSD_V3 is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
CONFIG_ZISOFS_FS=y
CONFIG_ZLIB_FS_INFLATE=y
Below is the error about for make bzImage

make all_targets
make[3]: Entering directory `/usr/src/linux/fs/partitions'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-tri
graphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpre
ferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=check  -DEXPORT_SYMT
AB -c check.c
In file included from /usr/src/linux/include/sys/uio.h:24,
                 from /usr/src/linux/include/sys/socket.h:27,
                 from /usr/src/linux/include/net/route.h:25,
                 from /usr/src/linux/include/net/ip.h:32,
                 from /usr/src/linux/include/net/checksum.h:31,
                 from /usr/src/linux/include/linux/raid/md.h:34,
                 from check.c:21:
/usr/src/linux/include/sys/types.h:34: redefinition of `u_char'
/usr/src/linux/include/linux/types.h:83: `u_char' previously declared here
/usr/src/linux/include/sys/types.h:35: redefinition of `u_short'
/usr/src/linux/include/linux/types.h:84: `u_short' previously declared here
/usr/src/linux/include/sys/types.h:36: redefinition of `u_int'
/usr/src/linux/include/linux/types.h:85: `u_int' previously declared here
/usr/src/linux/include/sys/types.h:37: redefinition of `u_long'
/usr/src/linux/include/linux/types.h:86: `u_long' previously declared here
/usr/src/linux/include/sys/types.h:39: redefinition of `u_quad_t'
/usr/src/linux/include/linux/coda.h:109: `u_quad_t' previously declared here
/usr/src/linux/include/sys/types.h:40: conflicting types for `fsid_t'
/usr/src/linux/include/asm/statfs.h:8: previous declaration of `fsid_t'
/usr/src/linux/include/sys/types.h:45: redefinition of `loff_t'
/usr/src/linux/include/linux/types.h:45: `loff_t' previously declared here
/usr/src/linux/include/sys/types.h:49: redefinition of `ino_t'
/usr/src/linux/include/linux/types.h:15: `ino_t' previously declared here
/usr/src/linux/include/sys/types.h:61: conflicting types for `dev_t'
/usr/src/linux/include/linux/types.h:14: previous declaration of `dev_t'
/usr/src/linux/include/sys/types.h:66: redefinition of `gid_t'
/usr/src/linux/include/linux/types.h:26: `gid_t' previously declared here
/usr/src/linux/include/sys/types.h:71: conflicting types for `mode_t'
/usr/src/linux/include/linux/types.h:16: previous declaration of `mode_t'
/usr/src/linux/include/sys/types.h:76: conflicting types for `nlink_t'
/usr/src/linux/include/linux/types.h:17: previous declaration of `nlink_t'
/usr/src/linux/include/sys/types.h:81: redefinition of `uid_t'
/usr/src/linux/include/linux/types.h:25: `uid_t' previously declared here
/usr/src/linux/include/sys/types.h:87: redefinition of `off_t'
/usr/src/linux/include/linux/types.h:18: `off_t' previously declared here
/usr/src/linux/include/sys/types.h:99: redefinition of `pid_t'
/usr/src/linux/include/linux/types.h:19: `pid_t' previously declared here
/usr/src/linux/include/sys/types.h:109: redefinition of `ssize_t'
/usr/src/linux/include/linux/types.h:59: `ssize_t' previously declared here
/usr/src/linux/include/sys/types.h:115: redefinition of `daddr_t'
/usr/src/linux/include/linux/types.h:20: `daddr_t' previously declared here
/usr/src/linux/include/sys/types.h:116: redefinition of `caddr_t'
/usr/src/linux/include/linux/types.h:79: `caddr_t' previously declared here
/usr/src/linux/include/sys/types.h:122: redefinition of `key_t'
/usr/src/linux/include/linux/types.h:21: `key_t' previously declared here
In file included from /usr/src/linux/include/sys/types.h:132,
                 from /usr/src/linux/include/sys/uio.h:24,
                 from /usr/src/linux/include/sys/socket.h:27,
                 from /usr/src/linux/include/net/route.h:25,
                 from /usr/src/linux/include/net/ip.h:32,
                 from /usr/src/linux/include/net/checksum.h:31,
                 from /usr/src/linux/include/linux/raid/md.h:34,
                 from check.c:21:
/usr/src/linux/include/time.h:70: redefinition of `time_t'
/usr/src/linux/include/linux/types.h:69: `time_t' previously declared here
In file included from /usr/src/linux/include/sys/uio.h:24,
                 from /usr/src/linux/include/sys/socket.h:27,
                 from /usr/src/linux/include/net/route.h:25,
                 from /usr/src/linux/include/net/ip.h:32,
                 from /usr/src/linux/include/net/checksum.h:31,
                 from /usr/src/linux/include/linux/raid/md.h:34,
                 from check.c:21:
/usr/src/linux/include/sys/types.h:150: redefinition of `ulong'
/usr/src/linux/include/linux/types.h:92: `ulong' previously declared here
/usr/src/linux/include/sys/types.h:151: redefinition of `ushort'
/usr/src/linux/include/linux/types.h:90: `ushort' previously declared here
/usr/src/linux/include/sys/types.h:152: redefinition of `uint'
/usr/src/linux/include/linux/types.h:91: `uint' previously declared here
/usr/src/linux/include/sys/types.h:190: redefinition of `int8_t'
/usr/src/linux/include/linux/types.h:98: `int8_t' previously declared here
/usr/src/linux/include/sys/types.h:191: redefinition of `int16_t'
/usr/src/linux/include/linux/types.h:100: `int16_t' previously declared here
/usr/src/linux/include/sys/types.h:192: redefinition of `int32_t'
/usr/src/linux/include/linux/types.h:102: `int32_t' previously declared here
/usr/src/linux/include/sys/types.h:193: redefinition of `int64_t'
/usr/src/linux/include/linux/types.h:113: `int64_t' previously declared here
/usr/src/linux/include/sys/types.h:196: redefinition of `u_int8_t'
/usr/src/linux/include/linux/types.h:97: `u_int8_t' previously declared here
/usr/src/linux/include/sys/types.h:197: redefinition of `u_int16_t'
/usr/src/linux/include/linux/types.h:99: `u_int16_t' previously declared
here
/usr/src/linux/include/sys/types.h:198: redefinition of `u_int32_t'
/usr/src/linux/include/linux/types.h:101: `u_int32_t' previously declared
here
/usr/src/linux/include/sys/types.h:199: redefinition of `u_int64_t'
/usr/src/linux/include/linux/types.h:112: `u_int64_t' previously declared
here
In file included from /usr/src/linux/include/sys/types.h:215,
                 from /usr/src/linux/include/sys/uio.h:24,
                 from /usr/src/linux/include/sys/socket.h:27,
                 from /usr/src/linux/include/net/route.h:25,
                 from /usr/src/linux/include/net/ip.h:32,
                 from /usr/src/linux/include/net/checksum.h:31,
                 from /usr/src/linux/include/linux/raid/md.h:34,
                 from check.c:21:
/usr/src/linux/include/sys/select.h:38: conflicting types for `sigset_t'
/usr/src/linux/include/asm/signal.h:21: previous declaration of `sigset_t'
In file included from /usr/src/linux/include/sys/select.h:44,
                 from /usr/src/linux/include/sys/types.h:215,
                 from /usr/src/linux/include/sys/uio.h:24,
                 from /usr/src/linux/include/sys/socket.h:27,
                 from /usr/src/linux/include/net/route.h:25,
                 from /usr/src/linux/include/net/ip.h:32,
                 from /usr/src/linux/include/net/checksum.h:31,
                 from /usr/src/linux/include/linux/raid/md.h:34,
                 from check.c:21:
/usr/src/linux/include/time.h:107: redefinition of `struct timespec'
In file included from /usr/src/linux/include/sys/select.h:46,
                 from /usr/src/linux/include/sys/types.h:215,
                 from /usr/src/linux/include/sys/uio.h:24,
                 from /usr/src/linux/include/sys/socket.h:27,
                 from /usr/src/linux/include/net/route.h:25,
                 from /usr/src/linux/include/net/ip.h:32,
                 from /usr/src/linux/include/net/checksum.h:31,
                 from /usr/src/linux/include/linux/raid/md.h:34,
                 from check.c:21:
/usr/src/linux/include/bits/time.h:68: redefinition of `struct timeval'
In file included from /usr/src/linux/include/sys/types.h:215,
                 from /usr/src/linux/include/sys/uio.h:24,
                 from /usr/src/linux/include/sys/socket.h:27,
                 from /usr/src/linux/include/net/route.h:25,
                 from /usr/src/linux/include/net/ip.h:32,
                 from /usr/src/linux/include/net/checksum.h:31,
                 from /usr/src/linux/include/linux/raid/md.h:34,
                 from check.c:21:
/usr/src/linux/include/sys/select.h:49: redefinition of `suseconds_t'
/usr/src/linux/include/linux/types.h:22: `suseconds_t' previously declared
here
/usr/src/linux/include/sys/select.h:74: conflicting types for `fd_set'
/usr/src/linux/include/linux/types.h:13: previous declaration of `fd_set'
In file included from /usr/src/linux/include/sys/uio.h:29,
                 from /usr/src/linux/include/sys/socket.h:27,
                 from /usr/src/linux/include/net/route.h:25,
                 from /usr/src/linux/include/net/ip.h:32,
                 from /usr/src/linux/include/net/checksum.h:31,
                 from /usr/src/linux/include/linux/raid/md.h:34,
                 from check.c:21:
/usr/src/linux/include/bits/uio.h:43: redefinition of `struct iovec'
In file included from /usr/src/linux/include/sys/socket.h:35,
                 from /usr/src/linux/include/net/route.h:25,
                 from /usr/src/linux/include/net/ip.h:32,
                 from /usr/src/linux/include/net/checksum.h:31,
                 from /usr/src/linux/include/linux/raid/md.h:34,
                 from check.c:21:
/usr/src/linux/include/bits/socket.h:43: parse error before `1'
In file included from /usr/src/linux/include/bits/socket.h:142,
                 from /usr/src/linux/include/sys/socket.h:35,
                 from /usr/src/linux/include/net/route.h:25,
                 from /usr/src/linux/include/net/ip.h:32,
                 from /usr/src/linux/include/net/checksum.h:31,
                 from /usr/src/linux/include/linux/raid/md.h:34,
                 from check.c:21:
/usr/src/linux/include/bits/sockaddr.h:29: redefinition of `sa_family_t'
/usr/src/linux/include/linux/socket.h:11: `sa_family_t' previously declared
here
In file included from /usr/src/linux/include/sys/socket.h:35,
                 from /usr/src/linux/include/net/route.h:25,
                 from /usr/src/linux/include/net/ip.h:32,
                 from /usr/src/linux/include/net/checksum.h:31,
                 from /usr/src/linux/include/linux/raid/md.h:34,
                 from check.c:21:
/usr/src/linux/include/bits/socket.h:146: redefinition of `struct sockaddr'
/usr/src/linux/include/bits/socket.h:173: parse error before `1'
/usr/src/linux/include/bits/socket.h:188: parse error before `0x20'
/usr/src/linux/include/bits/socket.h:216: redefinition of `struct msghdr'
/usr/src/linux/include/bits/socket.h:231: redefinition of `struct cmsghdr'
/usr/src/linux/include/bits/socket.h:258: conflicting types for
`__cmsg_nxthdr'
/usr/src/linux/include/linux/socket.h:104: previous declaration of
`__cmsg_nxthdr'
/usr/src/linux/include/bits/socket.h:265: redefinition of `__cmsg_nxthdr'
/usr/src/linux/include/bits/socket.h:258: `__cmsg_nxthdr' previously defined
here
/usr/src/linux/include/bits/socket.h:286: parse error before `0x01'
/usr/src/linux/include/bits/socket.h:298: redefinition of `struct ucred'
In file included from /usr/src/linux/include/sys/socket.h:35,
                 from /usr/src/linux/include/net/route.h:25,
                 from /usr/src/linux/include/net/ip.h:32,
                 from /usr/src/linux/include/net/checksum.h:31,
                 from /usr/src/linux/include/linux/raid/md.h:34,
                 from check.c:21:
/usr/src/linux/include/bits/socket.h:310: redefinition of `struct linger'
In file included from /usr/src/linux/include/netinet/in.h:23,
                 from /usr/src/linux/include/net/route.h:27,
                 from /usr/src/linux/include/net/ip.h:32,
                 from /usr/src/linux/include/net/checksum.h:31,
                 from /usr/src/linux/include/linux/raid/md.h:34,
                 from check.c:21:
/usr/src/linux/include/stdint.h:49: redefinition of `uint8_t'
/usr/src/linux/include/linux/types.h:106: `uint8_t' previously declared here
/usr/src/linux/include/stdint.h:50: redefinition of `uint16_t'
/usr/src/linux/include/linux/types.h:107: `uint16_t' previously declared
here
/usr/src/linux/include/stdint.h:52: redefinition of `uint32_t'
/usr/src/linux/include/linux/types.h:108: `uint32_t' previously declared
here
/usr/src/linux/include/stdint.h:59: redefinition of `uint64_t'
/usr/src/linux/include/linux/types.h:111: `uint64_t' previously declared
here
In file included from /usr/src/linux/include/net/route.h:27,
                 from /usr/src/linux/include/net/ip.h:32,
                 from /usr/src/linux/include/net/checksum.h:31,
                 from /usr/src/linux/include/linux/raid/md.h:34,
                 from check.c:21:
/usr/src/linux/include/netinet/in.h:259: parse error before `('
/usr/src/linux/include/netinet/in.h:259: parse error before `__u32'
/usr/src/linux/include/netinet/in.h:260: parse error before `('
/usr/src/linux/include/netinet/in.h:260: parse error before `__u16'
/usr/src/linux/include/netinet/in.h:262: parse error before `('
/usr/src/linux/include/netinet/in.h:262: parse error before `__u32'
/usr/src/linux/include/netinet/in.h:264: parse error before `('
/usr/src/linux/include/netinet/in.h:264: parse error before `__u16'
In file included from /usr/src/linux/include/net/sock.h:39,
                 from /usr/src/linux/include/net/ip.h:39,
                 from /usr/src/linux/include/net/checksum.h:31,
                 from /usr/src/linux/include/linux/raid/md.h:34,
                 from check.c:21:
/usr/src/linux/include/linux/in.h:25: conflicting types for `IPPROTO_IP'
/usr/src/linux/include/netinet/in.h:32: previous declaration of `IPPROTO_IP'
/usr/src/linux/include/linux/in.h:26: conflicting types for `IPPROTO_ICMP'
/usr/src/linux/include/netinet/in.h:36: previous declaration of
`IPPROTO_ICMP'
/usr/src/linux/include/linux/in.h:27: conflicting types for `IPPROTO_IGMP'
/usr/src/linux/include/netinet/in.h:38: previous declaration of
`IPPROTO_IGMP'
/usr/src/linux/include/linux/in.h:28: conflicting types for `IPPROTO_IPIP'
/usr/src/linux/include/netinet/in.h:40: previous declaration of
`IPPROTO_IPIP'
/usr/src/linux/include/linux/in.h:29: conflicting types for `IPPROTO_TCP'
/usr/src/linux/include/netinet/in.h:42: previous declaration of
`IPPROTO_TCP'
/usr/src/linux/include/linux/in.h:30: conflicting types for `IPPROTO_EGP'
/usr/src/linux/include/netinet/in.h:44: previous declaration of
`IPPROTO_EGP'
/usr/src/linux/include/linux/in.h:31: conflicting types for `IPPROTO_PUP'
/usr/src/linux/include/netinet/in.h:46: previous declaration of
`IPPROTO_PUP'
/usr/src/linux/include/linux/in.h:32: conflicting types for `IPPROTO_UDP'
/usr/src/linux/include/netinet/in.h:48: previous declaration of
`IPPROTO_UDP'
/usr/src/linux/include/linux/in.h:33: conflicting types for `IPPROTO_IDP'
/usr/src/linux/include/netinet/in.h:50: previous declaration of
`IPPROTO_IDP'
/usr/src/linux/include/linux/in.h:34: conflicting types for `IPPROTO_RSVP'
/usr/src/linux/include/netinet/in.h:60: previous declaration of
`IPPROTO_RSVP'
/usr/src/linux/include/linux/in.h:35: conflicting types for `IPPROTO_GRE'
/usr/src/linux/include/netinet/in.h:62: previous declaration of
`IPPROTO_GRE'
/usr/src/linux/include/linux/in.h:37: conflicting types for `IPPROTO_IPV6'
/usr/src/linux/include/netinet/in.h:54: previous declaration of
`IPPROTO_IPV6'
/usr/src/linux/include/linux/in.h:39: conflicting types for `IPPROTO_PIM'
/usr/src/linux/include/netinet/in.h:78: previous declaration of
`IPPROTO_PIM'
/usr/src/linux/include/linux/in.h:41: conflicting types for `IPPROTO_ESP'
/usr/src/linux/include/netinet/in.h:64: previous declaration of
`IPPROTO_ESP'
/usr/src/linux/include/linux/in.h:42: conflicting types for `IPPROTO_AH'
/usr/src/linux/include/netinet/in.h:66: previous declaration of `IPPROTO_AH'
/usr/src/linux/include/linux/in.h:43: conflicting types for `IPPROTO_COMP'
/usr/src/linux/include/netinet/in.h:80: previous declaration of
`IPPROTO_COMP'
/usr/src/linux/include/linux/in.h:45: conflicting types for `IPPROTO_RAW'
/usr/src/linux/include/netinet/in.h:82: previous declaration of
`IPPROTO_RAW'
/usr/src/linux/include/linux/in.h:47: conflicting types for `IPPROTO_MAX'
/usr/src/linux/include/netinet/in.h:85: previous declaration of
`IPPROTO_MAX'
/usr/src/linux/include/linux/in.h:51: redefinition of `struct in_addr'
/usr/src/linux/include/linux/in.h:92: redefinition of `struct ip_mreq'
/usr/src/linux/include/linux/in.h:98: redefinition of `struct ip_mreqn'
/usr/src/linux/include/linux/in.h:105: redefinition of `struct in_pktinfo'
/usr/src/linux/include/linux/in.h:113: redefinition of `struct sockaddr_in'
In file included from /usr/src/linux/include/net/protocol.h:28,
                 from /usr/src/linux/include/net/sock.h:55,
                 from /usr/src/linux/include/net/ip.h:39,
                 from /usr/src/linux/include/net/checksum.h:31,
                 from /usr/src/linux/include/linux/raid/md.h:34,
                 from check.c:21:
/usr/src/linux/include/linux/in6.h:31: redefinition of `struct in6_addr'
/usr/src/linux/include/linux/in6.h:43: redefinition of `struct sockaddr_in6'
/usr/src/linux/include/linux/in6.h:51: redefinition of `struct ipv6_mreq'
In file included from /usr/src/linux/include/net/sock.h:55,
                 from /usr/src/linux/include/net/ip.h:39,
                 from /usr/src/linux/include/net/checksum.h:31,
                 from /usr/src/linux/include/linux/raid/md.h:34,
                 from check.c:21:
/usr/src/linux/include/net/protocol.h:89: `SOCK_PACKET' undeclared here (not
in a function)
/usr/src/linux/include/net/protocol.h:89: size of array `inetsw' has
non-integer type
In file included from /usr/src/linux/include/net/checksum.h:31,
                 from /usr/src/linux/include/linux/raid/md.h:34,
                 from check.c:21:
/usr/src/linux/include/net/ip.h:109: warning: `struct rtable' declared
inside parameter list
/usr/src/linux/include/net/ip.h:109: warning: its scope is only this
definition or declaration, which is probably not what you want.
/usr/src/linux/include/net/ip.h: In function `ip_dont_fragment':
/usr/src/linux/include/net/ip.h:186: `RTAX_MTU' undeclared (first use in
this function)
/usr/src/linux/include/net/ip.h:186: (Each undeclared identifier is reported
only once
/usr/src/linux/include/net/ip.h:186: for each function it appears in.)
/usr/src/linux/include/net/ip.h:187: warning: control reaches end of
non-void function
/usr/src/linux/include/net/ip.h: At top level:
/usr/src/linux/include/net/ip.h:244: warning: `struct rtable' declared
inside parameter list
make[3]: *** [check.o] Error 1
make[3]: Leaving directory `/usr/src/linux/fs/partitions'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/fs/partitions'
make[1]: *** [_subdir_partitions] Error 2
make[1]: Leaving directory `/usr/src/linux/fs'
make: *** [_dir_fs] Error 2
[root@mrpointy linux]#

  --

  Andrew Hatfield
  SecureONE - http://www.secureone.com.au/
  President - South East Brisbane Linux Users Group  http://www.seblug.org/

  Kernel work available at http://development.secureone.com.au/kernel/


