Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319682AbSIMPLl>; Fri, 13 Sep 2002 11:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319679AbSIMPLl>; Fri, 13 Sep 2002 11:11:41 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:41733 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S319682AbSIMPLW>; Fri, 13 Sep 2002 11:11:22 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bPRWg+dMrc"
Content-Transfer-Encoding: 7bit
Message-ID: <15746.310.196343.684667@laputa.namesys.com>
Date: Fri, 13 Sep 2002 19:16:06 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net,
       Reiserfs developers mail-list <Reiserfs-Dev@Namesys.COM>
Subject: Re: [reiserfs-dev] Re: UML 2.5.34 
In-Reply-To: <200209131612.LAA02596@ccure.karaya.com>
References: <15745.59564.28543.921212@laputa.namesys.com>
	<200209131612.LAA02596@ccure.karaya.com>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Drdoom-Fodder: crypt satan passwd crash security
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bPRWg+dMrc
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

Jeff Dike writes:
 > Nikita@Namesys.COM said:
 > > pte_addr_t and CLOCK_TICK_RATE were undefined. 
 > 
 > Undefined WHERE?  You could send me a snippet of your build log.

Oops, sorry. See below.

 > 
 > > By the way, I am talking about Linus BK tree, rather than patches you
 > > have posted.
 > 
 > I would not have sent it to Linus if it didn't build.  Like I said, it builds
 > here fine.  I want to know where it breaks, so I can see it for myself, so
 > I can be sure the fix is right.
 > 

make[1]: Entering directory `/home/nikita/projects/2.5/scripts'
make[1]: Leaving directory `/home/nikita/projects/2.5/scripts'
make -C arch/um/sys-i386/util mk_sc
make[1]: Entering directory `/home/nikita/projects/2.5/arch/um/sys-i386/util'
make[1]: `mk_sc' is up to date.
make[1]: Leaving directory `/home/nikita/projects/2.5/arch/um/sys-i386/util'
  Generating include/linux/version.h (unchanged)
  Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=
make[1]: Entering directory `/home/nikita/projects/2.5/init'
  gcc -Wp,-MD,./.main.o.d -D__KERNEL__ -I/home/nikita/projects/2.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2  -fno-strict-aliasing -fno-common -g  -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=\"i386\" -D_LARGEFILE64_SOURCE -I/home/nikita/projects/2.5/arch/um/include -Derrno=kernel_errno -nostdinc -iwithprefix include    -DKBUILD_BASENAME=main   -c -o main.o main.c
In file included from /home/nikita/projects/2.5/include/linux/pagemap.h:7,
                 from /home/nikita/projects/2.5/include/linux/blkdev.h:9,
                 from /home/nikita/projects/2.5/include/linux/blk.h:4,
                 from main.c:25:
/home/nikita/projects/2.5/include/linux/mm.h:164: parse error before `pte_addr_t'
/home/nikita/projects/2.5/include/linux/mm.h:164: warning: no semicolon at end of struct or union
/home/nikita/projects/2.5/include/linux/mm.h:164: warning: no semicolon at end of struct or union
/home/nikita/projects/2.5/include/linux/mm.h:165: warning: type defaults to `int' in declaration of `pte'
/home/nikita/projects/2.5/include/linux/mm.h:165: warning: data definition has no type or storage class
/home/nikita/projects/2.5/include/linux/mm.h:182: parse error before `}'
In file included from /home/nikita/projects/2.5/include/linux/pagemap.h:7,
                 from /home/nikita/projects/2.5/include/linux/blkdev.h:9,
                 from /home/nikita/projects/2.5/include/linux/blk.h:4,
                 from main.c:25:
/home/nikita/projects/2.5/include/linux/mm.h: In function `put_page':
/home/nikita/projects/2.5/include/linux/mm.h:217: dereferencing pointer to incomplete type
/home/nikita/projects/2.5/include/linux/mm.h:217: dereferencing pointer to incomplete type
/home/nikita/projects/2.5/include/linux/mm.h:217: dereferencing pointer to incomplete type
/home/nikita/projects/2.5/include/linux/mm.h:217: dereferencing pointer to incomplete type
/home/nikita/projects/2.5/include/linux/mm.h: In function `page_zone':
/home/nikita/projects/2.5/include/linux/mm.h:282: dereferencing pointer to incomplete type
/home/nikita/projects/2.5/include/linux/mm.h:283: warning: control reaches end of non-void function
/home/nikita/projects/2.5/include/linux/mm.h: In function `set_page_zone':
/home/nikita/projects/2.5/include/linux/mm.h:287: dereferencing pointer to incomplete type
/home/nikita/projects/2.5/include/linux/mm.h:288: dereferencing pointer to incomplete type
/home/nikita/projects/2.5/include/linux/mm.h: In function `page_mapped':
/home/nikita/projects/2.5/include/linux/mm.h:331: dereferencing pointer to incomplete type
/home/nikita/projects/2.5/include/linux/mm.h:332: warning: control reaches end of non-void function
/home/nikita/projects/2.5/include/linux/mm.h: In function `set_page_dirty':
/home/nikita/projects/2.5/include/linux/mm.h:387: dereferencing pointer to incomplete type
/home/nikita/projects/2.5/include/linux/mm.h:390: dereferencing pointer to incomplete type
In file included from /home/nikita/projects/2.5/include/linux/pagemap.h:10,
                 from /home/nikita/projects/2.5/include/linux/blkdev.h:9,
                 from /home/nikita/projects/2.5/include/linux/blk.h:4,
                 from main.c:25:
/home/nikita/projects/2.5/include/linux/highmem.h: In function `kmap':
/home/nikita/projects/2.5/include/linux/highmem.h:23: arithmetic on pointer to an incomplete type
/home/nikita/projects/2.5/include/linux/highmem.h:23: arithmetic on pointer to an incomplete type
/home/nikita/projects/2.5/include/linux/highmem.h: In function `clear_user_highpage':
/home/nikita/projects/2.5/include/linux/highmem.h:36: arithmetic on pointer to an incomplete type
/home/nikita/projects/2.5/include/linux/highmem.h:36: arithmetic on pointer to an incomplete type
/home/nikita/projects/2.5/include/linux/highmem.h: In function `clear_highpage':
/home/nikita/projects/2.5/include/linux/highmem.h:43: arithmetic on pointer to an incomplete type
/home/nikita/projects/2.5/include/linux/highmem.h:43: arithmetic on pointer to an incomplete type
/home/nikita/projects/2.5/include/linux/highmem.h: In function `memclear_highpage_flush':
/home/nikita/projects/2.5/include/linux/highmem.h:58: arithmetic on pointer to an incomplete type
/home/nikita/projects/2.5/include/linux/highmem.h:58: arithmetic on pointer to an incomplete type
/home/nikita/projects/2.5/include/linux/highmem.h: In function `copy_user_highpage':
/home/nikita/projects/2.5/include/linux/highmem.h:69: arithmetic on pointer to an incomplete type
/home/nikita/projects/2.5/include/linux/highmem.h:69: arithmetic on pointer to an incomplete type
/home/nikita/projects/2.5/include/linux/highmem.h:70: arithmetic on pointer to an incomplete type
/home/nikita/projects/2.5/include/linux/highmem.h:70: arithmetic on pointer to an incomplete type
In file included from /home/nikita/projects/2.5/include/linux/blkdev.h:9,
                 from /home/nikita/projects/2.5/include/linux/blk.h:4,
                 from main.c:25:
/home/nikita/projects/2.5/include/linux/pagemap.h: In function `___add_to_page_cache':
/home/nikita/projects/2.5/include/linux/pagemap.h:69: dereferencing pointer to incomplete type
/home/nikita/projects/2.5/include/linux/pagemap.h:70: dereferencing pointer to incomplete type
/home/nikita/projects/2.5/include/linux/pagemap.h:71: dereferencing pointer to incomplete type
/home/nikita/projects/2.5/include/linux/pagemap.h: In function `wait_on_page_locked':
/home/nikita/projects/2.5/include/linux/pagemap.h:95: dereferencing pointer to incomplete type
/home/nikita/projects/2.5/include/linux/pagemap.h:95: dereferencing pointer to incomplete type
/home/nikita/projects/2.5/include/linux/pagemap.h: In function `wait_on_page_writeback':
/home/nikita/projects/2.5/include/linux/pagemap.h:104: dereferencing pointer to incomplete type
/home/nikita/projects/2.5/include/linux/pagemap.h:104: dereferencing pointer to incomplete type
make[1]: *** [main.o] Error 1
make[1]: Leaving directory `/home/nikita/projects/2.5/init'
make: *** [init] Error 2

I am attaching .config

 > 				Jeff
 > 

Nikita.

--bPRWg+dMrc
Content-Type: text/plain
Content-Disposition: inline;
	filename=".config"
Content-Transfer-Encoding: 7bit

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_USERMODE=y
# CONFIG_ISA is not set
# CONFIG_SBUS is not set
# CONFIG_PCI is not set
CONFIG_UID16=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General Setup
#
CONFIG_NET=y
# CONFIG_SYSVIPC is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
CONFIG_HOSTFS=y
CONFIG_MCONSOLE=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_HOST_2G_2G is not set
# CONFIG_UML_SMP is not set
# CONFIG_SMP is not set
CONFIG_NEST_LEVEL=0
CONFIG_KERNEL_HALF_GIGS=1

#
# Loadable module support
#
# CONFIG_MODULES is not set

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
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_UML_WATCHDOG is not set
CONFIG_UML_SOUND=y
CONFIG_SOUND=y
CONFIG_HOSTAUDIO=y
# CONFIG_TTY_LOG is not set

#
# Block Devices
#
CONFIG_BLK_DEV_UBD=y
# CONFIG_BLK_DEV_UBD_SYNC is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_MMAPPER is not set
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
CONFIG_DUMMY=y
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=y
CONFIG_PPP=y
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
# CONFIG_PPP_ASYNC is not set
# CONFIG_PPP_SYNC_TTY is not set
# CONFIG_PPP_DEFLATE is not set
# CONFIG_PPP_BSDCOMP is not set
# CONFIG_PPPOE is not set
CONFIG_SLIP=y
# CONFIG_SLIP_COMPRESSED is not set
# CONFIG_SLIP_SMART is not set
# CONFIG_SLIP_MODE_SLIP6 is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
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
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set

#
#    SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DEV_APPLETALK is not set
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
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISER4_FS=y
CONFIG_REISER4_CHECK=y
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
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
# CONFIG_NTFS_DEBUG is not set
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
# CONFIG_EXPORTFS is not set
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
# SCSI support
#
# CONFIG_SCSI is not set

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
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUGSYM=y
CONFIG_PT_PROXY=y
# CONFIG_GPROF is not set
# CONFIG_GCOV is not set

--bPRWg+dMrc--
