Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280537AbRKGKoo>; Wed, 7 Nov 2001 05:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280524AbRKGKoe>; Wed, 7 Nov 2001 05:44:34 -0500
Received: from bacon.van.m-l.org ([208.223.154.200]:12160 "EHLO
	bacon.van.m-l.org") by vger.kernel.org with ESMTP
	id <S280474AbRKGKoT>; Wed, 7 Nov 2001 05:44:19 -0500
Date: Wed, 7 Nov 2001 05:44:17 -0500 (EST)
From: George Greer <greerga@m-l.org>
X-X-Sender: <greerga@bacon.van.m-l.org>
To: <linux-kernel@vger.kernel.org>
Subject: keve-ntd (linux 2.2.20 and egcs 1.1.2 sillies, not gcc 3)
Message-ID: <Pine.LNX.4.33.0111070537440.3111-100000@bacon.van.m-l.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was wrong.  The kernel _was_ compiled with egcs:

Linux version 2.2.20 (root@bacon.van.m-l.org) (gcc version egcs-2.91.66 
19990314/Linux (egcs-1.1.2 release)) #4 SMP Sun Nov 4 18:46:06 EST 2001

Must've picked up on the 'kgcc' that I forgot was still lying around.  
Wonder how that compiler botched the strcpy?  Anyway, this time I'll append
the .config to the very bottom.

----------- old message ------------

5 (ntd) S 1 1 1 0 -1 64 0 0 0 0 0 2239187 0 0 11 0 0 0 76 0 0 2147483647 
3221225472 3223473832 0 0 0 0 2147483647 65536 0 3223678300 0 0 0 1
0 0 0 0 0 0 0

Name:   ntd
State:  R (running)
Pid:    5
PPid:   1
Uid:    0       0       0       0
Gid:    0       0       0       0
Groups:
SigPnd: 0000000000000000
SigBlk: 00000000ffffffff
SigIgn: 0000000000010000
SigCgt: 0000000000000000
CapInh: 0000000000000000
CapPrm: 00000000ffffffff
CapEff: 00000000fffffeff

Judging by the PID, that was supposed to be 'keventd'.  It must be upset
over losing part of its name, although right now it just seems content with
eating up 60% of my CPU time:

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM COMMAND
    5 root      19   0     0    0     0 RW   62.3  0.0 ntd

Problem is apparently that it was GCC 3.0.  Serves me right for forgetting
that even though 2.2.19 was compiled with egcs 1.1.2, I've upgraded
compilers since then.  Oh well.  Since I am sending this e-mail from the
machine it isn't too bad. Now to dig up a suitable compiler...

--- appended 'egrep "=[ym]" .config' ---

CONFIG_X86=y
CONFIG_EXPERIMENTAL=y
CONFIG_M586TSC=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_TSC=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_1GB=y
CONFIG_SMP=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_QUIRKS=y
CONFIG_PCI_OLD_PROC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_STRIPED=y
CONFIG_MD_MIRRORING=y
CONFIG_MD_RAID5=y
CONFIG_PARIDE_PARPORT=y
CONFIG_PACKET=y
CONFIG_FIREWALL=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_FIREWALL=y
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE=y
CONFIG_IP_ALIAS=y
CONFIG_SYN_COOKIES=y
CONFIG_SKB_LARGE=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_RTL8139=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_WATCHDOG=y
CONFIG_SOFT_WATCHDOG=y
CONFIG_NVRAM=y
CONFIG_RTC=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_NTFS_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_CODA_FS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_SMB_FS=y
CONFIG_NCP_FS=y
CONFIG_NCPFS_PACKET_SIGNING=y
CONFIG_NCPFS_STRONG=y
CONFIG_NCPFS_NFS_NS=y
CONFIG_NCPFS_OS2_NS=y
CONFIG_NCPFS_SMALLDOS=y
CONFIG_NCPFS_MOUNT_SUBDIR=y
CONFIG_NCPFS_NLS=y
CONFIG_NCPFS_EXTRAS=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_VGA_CONSOLE=y
CONFIG_MAGIC_SYSRQ=y

