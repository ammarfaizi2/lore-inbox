Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265022AbSJWOri>; Wed, 23 Oct 2002 10:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265029AbSJWOri>; Wed, 23 Oct 2002 10:47:38 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:11534 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S265022AbSJWOrc>; Wed, 23 Oct 2002 10:47:32 -0400
Message-Id: <200210231448.g9NEmJp04017@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: EISA AIC7XXX not detected
Date: Wed, 23 Oct 2002 17:40:57 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an oldie Pentium 66 box which was running OS/2
for a very long time. Probably the last OS/2 box in our town :)

I want to convert it into backup web server.

The problem is that it does not see its disks when I boot Linux.
Currently I'm running it in NFS root mode, but 16MB RAM is not
much fun without swap :(

I'd like to stick printks here and there in driver source,
thought you may have some advice.

In particular, is this relevant?
"kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2"
--
vda

syslog:
=======
Oct 20 06:58:55 guard syslogd 1.4.1: restart.
Oct 20 06:58:57 guard su[297]: + console root-root 
Oct 20 06:58:57 guard kernel: klogd 1.4.1, log source = /proc/kmsg started.
Oct 20 06:58:57 guard kernel: Linux version 2.4.19net2 (root@pegasus) (gcc version 3.2) #2 SMP Fri Oct 18 12:42:20 GMT+2 2002
Oct 20 06:58:57 guard kernel: BIOS-provided physical RAM map:
Oct 20 06:58:57 guard kernel:  BIOS-88: 0000000000000000 - 000000000009f000 (usable)
Oct 20 06:58:57 guard kernel:  BIOS-88: 0000000000100000 - 0000000001000000 (usable)
Oct 20 06:58:57 guard kernel: 16MB LOWMEM available.
Oct 20 06:58:57 guard kernel: Advanced speculative caching feature not present
Oct 20 06:58:57 guard kernel: On node 0 totalpages: 4096
Oct 20 06:58:57 guard kernel: zone(0): 4096 pages.
Oct 20 06:58:57 guard kernel: zone(1): 0 pages.
Oct 20 06:58:57 guard kernel: zone(2): 0 pages.
Oct 20 06:58:57 guard kernel: Kernel command line: root=/dev/nfs  nfsroot=172.16.42.75:/.rootfs/.std,hard,intr  ip=:172.16.42.75:::(none):eth1:dhcp  devfs=mount
Oct 20 06:58:57 guard kernel: No local APIC present or hardware disabled
Oct 20 06:58:57 guard kernel: Initializing CPU#0
Oct 20 06:58:57 guard kernel: Detected 66.670 MHz processor.
Oct 20 06:58:57 guard kernel: Console: colour VGA+ 80x30
Oct 20 06:58:57 guard kernel: Calibrating delay loop... 132.71 BogoMIPS
Oct 20 06:58:57 guard kernel: Memory: 12460k/16384k available (1800k kernel code, 3536k reserved, 530k data, 564k init, 0k highmem)
Oct 20 06:58:57 guard kernel: Dentry cache hash table entries: 2048 (order: 2, 16384 bytes)
Oct 20 06:58:57 guard kernel: Inode cache hash table entries: 1024 (order: 1, 8192 bytes)
Oct 20 06:58:57 guard kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Oct 20 06:58:57 guard kernel: Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Oct 20 06:58:57 guard kernel: Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Oct 20 06:58:57 guard kernel: CPU: Before vendor init, caps: 000001bf 00000000 00000000, vendor = 0
Oct 20 06:58:57 guard kernel: Intel Pentium with F0 0F bug - workaround enabled.
Oct 20 06:58:57 guard kernel: CPU: After vendor init, caps: 000001bf 00000000 00000000 00000000
Oct 20 06:58:57 guard kernel: CPU:     After generic, caps: 000001bf 00000000 00000000 00000000
Oct 20 06:58:57 guard kernel: CPU:             Common caps: 000001bf 00000000 00000000 00000000
Oct 20 06:58:57 guard kernel: Checking 'hlt' instruction... OK.
Oct 20 06:58:57 guard kernel: Checking for popad bug... OK.
Oct 20 06:58:57 guard kernel: POSIX conformance testing by UNIFIX
Oct 20 06:58:57 guard kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
Oct 20 06:58:57 guard kernel: mtrr: detected mtrr type: none
Oct 20 06:58:57 guard kernel: CPU: Before vendor init, caps: 000001bf 00000000 00000000, vendor = 0
Oct 20 06:58:57 guard kernel: CPU: After vendor init, caps: 000001bf 00000000 00000000 00000000
Oct 20 06:58:57 guard kernel: CPU:     After generic, caps: 000001bf 00000000 00000000 00000000
Oct 20 06:58:57 guard kernel: CPU:             Common caps: 000001bf 00000000 00000000 00000000
Oct 20 06:58:57 guard kernel: CPU0: Intel Pentium 60/66 stepping 07
Oct 20 06:58:57 guard kernel: per-CPU timeslice cutoff: 161.34 usecs.
Oct 20 06:58:57 guard kernel: SMP motherboard not detected.
Oct 20 06:58:57 guard kernel: Local APIC not detected. Using dummy APIC emulation.
Oct 20 06:58:57 guard kernel: Waiting on wait_init_idle (map = 0x0)
Oct 20 06:58:57 guard kernel: All processors have done init_idle
Oct 20 06:58:57 guard kernel: PCI: PCI BIOS revision 2.10 entry at 0xf192b, last bus=0
Oct 20 06:58:57 guard kernel: PCI: Using configuration type 2
Oct 20 06:58:57 guard kernel: PCI: Probing PCI hardware
Oct 20 06:58:57 guard kernel: Linux NET4.0 for Linux 2.4
Oct 20 06:58:57 guard kernel: Based upon Swansea University Computer Society NET3.039
Oct 20 06:58:57 guard kernel: Initializing RT netlink socket
Oct 20 06:58:57 guard kernel: Starting kswapd
Oct 20 06:58:57 guard kernel: devfs: v1.12a (20020514) Richard Gooch (rgooch@atnf.csiro.au)
Oct 20 06:58:57 guard kernel: devfs: boot_options: 0x1
Oct 20 06:58:57 guard kernel: pty: 256 Unix98 ptys configured
Oct 20 06:58:57 guard kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Oct 20 06:58:57 guard kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Oct 20 06:58:57 guard kernel: Floppy drive(s): fd0 is 1.44M
Oct 20 06:58:57 guard kernel: FDC 0 is a post-1991 82077
Oct 20 06:58:57 guard kernel: eth0: 3c5x9 at 0x6000, BNC port, address  00 20 af 99 f3 00, IRQ 5.
Oct 20 06:58:57 guard kernel: 3c509.c:1.18c 1Mar2002 becker@scyld.com
Oct 20 06:58:57 guard kernel: http://www.scyld.com/network/3c509.html
Oct 20 06:58:57 guard kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Oct 20 06:58:57 guard kernel: dgrs: SW=$Id: dgrs.c,v 1.13 2000/06/06 04:07:00 rick Exp $ FW=Build 550 11/16/96 03:45:15
Oct 20 06:58:57 guard kernel: FW Version=$Version$
Oct 20 06:58:57 guard kernel: pcnet32.c:v1.27a 10.02.2002 tsbogend@alpha.franken.de
Oct 20 06:58:57 guard kernel: ThunderLAN driver v1.15
Oct 20 06:58:57 guard kernel: TLAN: 0 devices installed, PCI: 0  EISA: 0
Oct 20 06:58:57 guard kernel: dmfe: Davicom DM9xxx net driver, version 1.36.4 (2002-01-17)
Oct 20 06:58:57 guard kernel: ns83820.c: National Semiconductor DP83820 10/100/1000 driver.
Oct 20 06:58:57 guard kernel: sk98lin: Network Device Driver v4.06
Oct 20 06:58:57 guard kernel: Copyright (C) 2000-2001 SysKonnect GmbH.
Oct 20 06:58:57 guard kernel: No adapter found
Oct 20 06:58:57 guard kernel: 8139too Fast Ethernet driver 0.9.25
Oct 20 06:58:57 guard kernel: eth1: SMC1211TX EZCard 10/100 (RealTek RTL8139) at 0xc180fc00, 00:10:b5:41:45:c4, IRQ 15
Oct 20 06:58:57 guard kernel: eth1:  Identified 8139 chip type 'RTL-8139B'
Oct 20 06:58:57 guard kernel: eth2: i82596 initialization timed out
Oct 20 06:58:57 guard kernel: SCSI subsystem driver Revision: 1.00
Oct 20 06:58:57 guard kernel: kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
Oct 20 06:58:57 guard kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Oct 20 06:58:57 guard kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Oct 20 06:58:57 guard kernel: IP: routing cache hash table of 512 buckets, 4Kbytes
Oct 20 06:58:57 guard kernel: TCP: Hash tables configured (established 1024 bind 1024)
Oct 20 06:58:57 guard kernel: eth1: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.
Oct 20 06:58:57 guard kernel: Sending DHCP requests ..., OK
Oct 20 06:58:57 guard kernel: IP-Config: Got DHCP answer from 255.255.255.255, my address is 172.16.42.235
Oct 20 06:58:57 guard kernel: IP-Config: Complete:
Oct 20 06:58:57 guard kernel:       device=eth1, addr=172.16.42.235, mask=255.255.255.0, gw=172.16.42.98,
Oct 20 06:58:57 guard kernel:      host=(none), domain=, nis-domain=(none),
Oct 20 06:58:57 guard kernel:      bootserver=255.255.255.255, rootserver=172.16.42.75, rootpath=
Oct 20 06:58:57 guard kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Oct 20 06:58:58 guard kernel: Looking up port of RPC 100003/2 on 172.16.42.75
Oct 20 06:58:58 guard kernel: Looking up port of RPC 100005/1 on 172.16.42.75
Oct 20 06:58:58 guard kernel: VFS: Mounted root (nfs filesystem).
Oct 20 06:58:58 guard kernel: Mounted devfs on /dev
Oct 20 06:58:58 guard kernel: Freeing unused kernel memory: 564k freed

.config
=======
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_M386=y
CONFIG_X86_L1_CACHE_SHIFT=4
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_EISA=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_SERIAL=m
CONFIG_PNP=m
CONFIG_ISAPNP=m
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_XD=m
CONFIG_PARIDE=m
CONFIG_PARIDE_PARPORT=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_MD_MULTIPATH=m
CONFIG_BLK_DEV_LVM=m
CONFIG_PACKET=m
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_STATE=m
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
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IPX=m
CONFIG_IPX_INTERN=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_BLK_DEV_ATARAID=m
CONFIG_BLK_DEV_ATARAID_PDC=m
CONFIG_BLK_DEV_ATARAID_HPT=m
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_AIC7XXX_PROBE_EISA_VL=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_HAPPYMEAL=y
CONFIG_SUNGEM=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL1=y
CONFIG_EL2=y
CONFIG_ELPLUS=y
CONFIG_EL16=y
CONFIG_EL3=y
CONFIG_3C515=y
CONFIG_VORTEX=y
CONFIG_LANCE=y
CONFIG_NET_VENDOR_SMC=y
CONFIG_WD80x3=y
CONFIG_ULTRA=y
CONFIG_SMC9194=y
CONFIG_NET_VENDOR_RACAL=y
CONFIG_NI5010=y
CONFIG_NI52=y
CONFIG_NI65=y
CONFIG_AT1700=y
CONFIG_DEPCA=y
CONFIG_HP100=y
CONFIG_NET_ISA=y
CONFIG_E2100=y
CONFIG_EWRK3=y
CONFIG_EEXPRESS=y
CONFIG_EEXPRESS_PRO=y
CONFIG_HPLAN_PLUS=y
CONFIG_HPLAN=y
CONFIG_LP486E=y
CONFIG_ETH16I=y
CONFIG_NE2000=y
CONFIG_NET_PCI=y
CONFIG_PCNET32=y
CONFIG_ADAPTEC_STARFIRE=y
CONFIG_AC3200=y
CONFIG_APRICOT=y
CONFIG_CS89x0=y
CONFIG_TULIP=y
CONFIG_DE4X5=y
CONFIG_DGRS=y
CONFIG_DM9102=y
CONFIG_EEPRO100=y
CONFIG_FEALNX=y
CONFIG_NATSEMI=y
CONFIG_NATSEMI_CABLE_MAGIC=y
CONFIG_NE2K_PCI=y
CONFIG_8139CP=y
CONFIG_8139TOO=y
CONFIG_SIS900=y
CONFIG_EPIC100=y
CONFIG_SUNDANCE=y
CONFIG_TLAN=y
CONFIG_VIA_RHINE=y
CONFIG_WINBOND_840=y
CONFIG_ACENIC=y
CONFIG_DL2K=y
CONFIG_NS83820=y
CONFIG_HAMACHI=y
CONFIG_YELLOWFIN=y
CONFIG_SK98LIN=y
CONFIG_TIGON3=y
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y
CONFIG_RCPCI=m
CONFIG_SHAPER=m
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
CONFIG_BUSMOUSE=m
CONFIG_ATIXL_BUSMOUSE=m
CONFIG_LOGIBUSMOUSE=m
CONFIG_MS_BUSMOUSE=m
CONFIG_MOUSE=m
CONFIG_PSMOUSE=y
CONFIG_82C710_MOUSE=m
CONFIG_PC110_PAD=m
CONFIG_QIC02_TAPE=m
CONFIG_INTEL_RNG=m
CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_AGP=m
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
CONFIG_AGP_SIS=y
CONFIG_AGP_ALI=y
CONFIG_AGP_SWORKS=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_REISERFS_FS=m
CONFIG_ADFS_FS=m
CONFIG_AFFS_FS=m
CONFIG_HFS_FS=m
CONFIG_BFS_FS=m
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_UMSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_EFS_FS=m
CONFIG_CRAMFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_MINIX_FS=y
CONFIG_VXFS_FS=m
CONFIG_NTFS_FS=m
CONFIG_HPFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_QNX4FS_FS=m
CONFIG_ROMFS_FS=y
CONFIG_EXT2_FS=y
CONFIG_SYSV_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_RW=y
CONFIG_UFS_FS=m
CONFIG_UFS_FS_WRITE=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_ROOT_NFS=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
CONFIG_NCP_FS=m
CONFIG_ZLIB_FS_INFLATE=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_MDA_CONSOLE=m
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_RIVA=m
CONFIG_FB_CLGEN=m
CONFIG_FB_PM2=m
CONFIG_FB_PM2_FIFO_DISCONNECT=y
CONFIG_FB_PM2_PCI=y
CONFIG_FB_CYBER2000=m
CONFIG_FB_VESA=y
CONFIG_FB_HGA=m
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_G450=m
CONFIG_FB_MATROX_MULTIHEAD=y
CONFIG_FB_ATY=m
CONFIG_FB_ATY_GX=y
CONFIG_FB_ATY_CT=y
CONFIG_FB_ATY128=m
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_FB_3DFX=m
CONFIG_FB_VOODOO1=m
CONFIG_FBCON_MFB=m
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_HGA=m
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SOUND=m
CONFIG_SOUND_FUSION=m
CONFIG_SOUND_CS4281=m
CONFIG_SOUND_ES1371=m
CONFIG_SOUND_ESSSOLO1=m
CONFIG_SOUND_MAESTRO=m
CONFIG_SOUND_MAESTRO3=m
CONFIG_SOUND_VIA82CXXX=m
CONFIG_SOUND_OSS=m
CONFIG_SOUND_SGALAXY=m
CONFIG_SOUND_CS4232=m
CONFIG_SOUND_MSS=m
CONFIG_SOUND_SB=m
CONFIG_SOUND_AWE32_SYNTH=m
CONFIG_SOUND_YM3812=m
CONFIG_SOUND_OPL3SA1=m
CONFIG_SOUND_OPL3SA2=m
CONFIG_SOUND_YMFPCI=m
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
