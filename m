Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291310AbSAaVIm>; Thu, 31 Jan 2002 16:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291309AbSAaVI3>; Thu, 31 Jan 2002 16:08:29 -0500
Received: from port29.ds1-rdo.adsl.cybercity.dk ([212.242.196.94]:15661 "EHLO
	xyzzy.adsl.dk") by vger.kernel.org with ESMTP id <S291308AbSAaVID>;
	Thu, 31 Jan 2002 16:08:03 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.18-pre7: Problems with ncr53c810 on alpha
X-Home-Page: http://peter.makholm.net/
Xyzzy: Nothing happens!
From: Peter Makholm <peter@makholm.net>
Date: Thu, 31 Jan 2002 22:07:56 +0100
Message-ID: <87pu3q2pqr.fsf@xyzzy.adsl.dk>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.4 (Artificial
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to boot a 2.4.18-pre7 kernel on alpha it gives som errors
with my ncr53c810 scsi-controller. Neither the sym53c810 driver or the
ncr53c810 driver suceedes in initializing the controler.

I'm using a GENERIC kernel on a XLT300 (Alcor).

2.2.19 boots correctly and kernel 2.4.17 also fails. I havn't tried
other kernels.

The relevant part of the boot messages (I hope) is:

SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 9, function 0
sym53c8xx: 53c810a detected 
sym53c810a-0: rev 0x11 on pci bus 0 device 9 function 0 irq 28
sym53c810a-0: ID 7, Fast-10, Parity Checking
CACHE TEST FAILED: DMA error (dstat=0xa0).<3>CACHE INCORRECTLY CONFIGURED.
sym53c810a-0: giving up ...
ncr53c8xx: at PCI bus 0, device 9, function 0
ncr53c8xx: 53c810a detected 
ncr53c810a-0: rev 0x11 on pci bus 0 device 9 function 0 irq 28
ncr53c810a-0: ID 7, Fast-10, Parity Checking
CACHE TEST FAILED: script execution failed.
start=80063414, pc=80063414, end=80063440
CACHE INCORRECTLY CONFIGURED.
ncr53c810a-0: detaching...
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 16Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
ip_conntrack (512 buckets, 4096 max)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
request_module[block-major-8]: Root fs not mounted
VFS: Cannot open root device "" or 08:02
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 08:02

My .config have the following options set:

CONFIG_ALPHA=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_ALPHA_GENERIC=y
CONFIG_ISA=y
CONFIG_EISA=y
CONFIG_PCI=y
CONFIG_ALPHA_BROKEN_IRQ_MASK=y
CONFIG_PCI_NAMES=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_PACKET=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_INET_ECN=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_COMPAT_IPCHAINS=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_NCR53C8XX=y
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=8
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
CONFIG_SCSI_NCR53C8XX_IOMAPPED=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_TULIP=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_TMPFS=y
CONFIG_ISO9660_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_VGA_CONSOLE=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_PCI_CONSOLE=y
CONFIG_ALPHA_LEGACY_START_ADDRESS=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MATHEMU=y
CONFIG_MAGIC_SYSRQ=y


-- 
Når folk spørger mig, om jeg er nørd, bliver jeg altid ilde til mode
og svarer lidt undskyldende: "Nej, jeg bruger RedHat".
                                -- Allan Olesen på dk.edb.system.unix
