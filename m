Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314061AbSDKOGZ>; Thu, 11 Apr 2002 10:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314063AbSDKOGY>; Thu, 11 Apr 2002 10:06:24 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:16382 "EHLO
	swan.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S314061AbSDKOGW>; Thu, 11 Apr 2002 10:06:22 -0400
Date: Thu, 11 Apr 2002 10:12:19 -0400
To: linux-kernel@vger.kernel.org
Subject: VFS: Unable to mount root fs on 08:06 - 2.4.19-pre6
Message-ID: <20020411101219.A28009@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This machine worked with 2.4.19-pre5.  2.4.19-pre6 has
worked on another machine (entirely different hardware).

Boot message:
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Cannot open root device "806" or 08:06
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 08:06

Lilo has this entry for all kernels:
root=/dev/sda6

2.4.19-pre6-aa1 gives same error.

Did "make oldconfig" from previously working .config.
This is the difference between the two configs.

root@dev4-003:/tmp# diff works doesnt
< CONFIG_NETLINK=y
< CONFIG_RTNETLINK=y
> CONFIG_RAMFS=y


This is the whole (non-booting) config:
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_HIGHMEM64G=y
CONFIG_HIGHMEM=y
CONFIG_X86_PAE=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_DAC960=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_PACKET=y
CONFIG_NETLINK_DEV=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_ARPD=y
CONFIG_SYN_COOKIES=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_ATARAID=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_AIC7XXX_OLD=y
CONFIG_AIC7XXX_OLD_CMDS_PER_DEVICE=8
CONFIG_SCSI_MEGARAID=y
CONFIG_SCSI_IPS=y
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
CONFIG_SCSI_QLOGIC_ISP=y
CONFIG_SCSI_QLOGIC_FC=y
CONFIG_SCSI_SYM53C416=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_NET_ETHERNET=y
CONFIG_LANCE=y
CONFIG_NET_PCI=y
CONFIG_EEPRO100=y
CONFIG_ACENIC=y
CONFIG_SK98LIN=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_NVRAM=y
CONFIG_RTC=y
CONFIG_QUOTA=y
CONFIG_AUTOFS_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=y
CONFIG_ROOT_NFS=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_ISO8859_1=y
CONFIG_VGA_CONSOLE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y

lspci:
00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 21)
00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
00:00.2 Host bridge: ServerWorks: Unknown device 0006
00:00.3 Host bridge: ServerWorks: Unknown device 0006
00:01.0 SCSI storage controller: Adaptec AIC-7880U (rev 02)
00:04.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
00:0c.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC] (rev 7a)
00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04)
01:05.0 PCI Hot-plug controller: Compaq Computer Corporation PCI Hotplug Controller (rev 11)
01:06.0 SCSI storage controller: Adaptec 7899P (rev 01)
01:06.1 SCSI storage controller: Adaptec 7899P (rev 01)
01:08.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
01:09.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
01:0a.0 Ethernet controller: Netgear GA620 (rev 01)
01:0b.0 Ethernet controller: Netgear GA620 (rev 01)
07:07.0 PCI Hot-plug controller: Compaq Computer Corporation PCI Hotplug Controller (rev 11)
07:0e.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 05)
09:04.0 SCSI storage controller: QLogic Corp. QLA2200 (rev 05)
09:05.0 SCSI storage controller: QLogic Corp. QLA2200 (rev 05)

Any suggestions apprecitated.

-- 
Randy Hron

