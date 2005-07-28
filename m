Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVG1TDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVG1TDc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 15:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVG1TBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 15:01:51 -0400
Received: from mail.portrix.net ([212.202.157.208]:9373 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261471AbVG1TB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 15:01:29 -0400
Message-ID: <42E92B7B.8080304@ppp0.net>
Date: Thu, 28 Jul 2005 21:01:15 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050602 Thunderbird/1.0.2 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Ungerer <gerg@snapgear.com>
CC: Miles Bader <miles@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: v850, which gcc and binutils version?
References: <42E78474.8070300@ppp0.net>	<buo64uvit4p.fsf@mctpc71.ucom.lsi.nec.co.jp>	<42E896EC.7030503@ppp0.net> <buoek9jgvxh.fsf@mctpc71.ucom.lsi.nec.co.jp> <42E8CE48.5090301@snapgear.com>
In-Reply-To: <42E8CE48.5090301@snapgear.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------070205050709080109010105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070205050709080109010105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Greg Ungerer wrote:
>>If you care to try applying the uClinux patches, they should be available
>>from (fill in "$ver" with "2.6.12-uc0" and "$maj_ver" with "2.6"):
>>
>>    http://www.uclinux.org/pub/uClinux/uClinux-$maj_ver.x/linux-$ver.patch.gz
>>
>>Greg, do you have any status on merging the current uClinux patch set?
> 
> 
> I sent a bunch of the 2.6.12-uc0 changes to Linus earlier this week
> (the critical fixes), but according to his GIT log he didn't merge them.
> I am going to resend tomorrow.

Greg you might consider adding the attached patch to update the defconfig for
m68nommu, especially

+#
+# Console display driver support
+#
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y

which allows the m68knommu defconfig to be buildable without further invention.
Patch is against 2.6.12-uc0

Thanks,

-- 
Jan

--------------070205050709080109010105
Content-Type: text/plain;
 name="defconfig_m68knommu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="defconfig_m68knommu.patch"

--- kernel/arch/m68knommu/defconfig.old	2005-03-02 08:38:13.000000000 +0100
+++ kernel/arch/m68knommu/defconfig	2005-07-28 20:51:51.000000000 +0200
@@ -1,24 +1,48 @@
 #
 # Automatically generated make config: don't edit
+# Linux kernel version: 2.6.12-uc0
+# Thu Jul 28 20:49:44 2005
 #
+CONFIG_M68KNOMMU=y
 # CONFIG_MMU is not set
 # CONFIG_FPU is not set
 CONFIG_UID16=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 
 #
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
+CONFIG_CLEAN_COMPILE=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
 
 #
 # General setup
 #
-# CONFIG_SYSVIPC is not set
+CONFIG_LOCALVERSION=""
+# CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_SYSCTL is not set
-CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_AUDIT is not set
+# CONFIG_HOTPLUG is not set
+CONFIG_KOBJECT_UEVENT=y
+# CONFIG_IKCONFIG is not set
+# CONFIG_EMBEDDED is not set
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+CONFIG_BASE_SMALL=0
 
 #
 # Loadable module support
@@ -34,9 +58,11 @@
 # CONFIG_M68360 is not set
 # CONFIG_M5206 is not set
 # CONFIG_M5206e is not set
+# CONFIG_M523x is not set
 # CONFIG_M5249 is not set
-# CONFIG_M527x is not set
+# CONFIG_M5271 is not set
 CONFIG_M5272=y
+# CONFIG_M5275 is not set
 # CONFIG_M528x is not set
 # CONFIG_M5307 is not set
 # CONFIG_M5407 is not set
@@ -54,6 +80,7 @@
 # CONFIG_CLOCK_50MHz is not set
 # CONFIG_CLOCK_54MHz is not set
 # CONFIG_CLOCK_60MHz is not set
+# CONFIG_CLOCK_64MHz is not set
 CONFIG_CLOCK_66MHz=y
 # CONFIG_CLOCK_70MHz is not set
 # CONFIG_CLOCK_100MHz is not set
@@ -65,9 +92,14 @@
 # Platform
 #
 CONFIG_M5272C3=y
+# CONFIG_COBRA5272 is not set
+# CONFIG_CANCam is not set
+# CONFIG_SCALES is not set
 # CONFIG_NETtel is not set
+# CONFIG_CPU16B is not set
 CONFIG_MOTOROLA=y
 # CONFIG_LARGE_ALLOCS is not set
+CONFIG_4KSTACKS=y
 # CONFIG_RAMAUTO is not set
 # CONFIG_RAM4MB is not set
 # CONFIG_RAM8MB is not set
@@ -79,20 +111,28 @@
 # CONFIG_RAM32BIT is not set
 CONFIG_RAMKERNEL=y
 # CONFIG_ROMKERNEL is not set
-# CONFIG_HIMEMKERNEL is not set
 
 #
 # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
 #
 # CONFIG_PCI is not set
-# CONFIG_HOTPLUG is not set
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# PCI Hotplug Support
+#
 
 #
 # Executable file formats
 #
-CONFIG_KCORE_AOUT=y
 CONFIG_BINFMT_FLAT=y
 # CONFIG_BINFMT_ZFLAT is not set
+# CONFIG_BINFMT_SHARED_FLAT is not set
+# CONFIG_BINFMT_MISC is not set
 
 #
 # Power management options
@@ -100,12 +140,23 @@
 # CONFIG_PM is not set
 
 #
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
+
+#
 # Memory Technology Devices (MTD)
 #
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
-CONFIG_MTD_PARTITIONS=y
 # CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
 # CONFIG_MTD_REDBOOT_PARTS is not set
 # CONFIG_MTD_CMDLINE_PARTS is not set
 
@@ -116,35 +167,48 @@
 CONFIG_MTD_BLOCK=y
 # CONFIG_FTL is not set
 # CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
 
 #
 # RAM/ROM/Flash chip drivers
 #
 # CONFIG_MTD_CFI is not set
 # CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
 CONFIG_MTD_RAM=y
 # CONFIG_MTD_ROM is not set
 # CONFIG_MTD_ABSENT is not set
-# CONFIG_MTD_OBSOLETE_CHIPS is not set
 
 #
 # Mapping drivers for chip access
 #
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
 CONFIG_MTD_UCLINUX=y
 
 #
 # Self-contained MTD device drivers
 #
 # CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
 # CONFIG_MTD_MTDRAM is not set
 # CONFIG_MTD_BLKMTD is not set
+# CONFIG_MTD_BLOCK2MTD is not set
 
 #
 # Disk-On-Chip Device Drivers
 #
-# CONFIG_MTD_DOC1000 is not set
 # CONFIG_MTD_DOC2000 is not set
 # CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
 
 #
 # NAND Flash Device Drivers
@@ -159,21 +223,32 @@
 #
 # Plug and Play support
 #
-# CONFIG_PNP is not set
 
 #
 # Block devices
 #
 # CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
 # CONFIG_BLK_DEV_LOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
 CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 # CONFIG_BLK_DEV_INITRD is not set
-# CONFIG_BLK_DEV_BLKMEM is not set
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+# CONFIG_ATA_OVER_ETH is not set
 
 #
-# ATA/IDE/MFM/RLL support
+# ATA/ATAPI/MFM/RLL support
 #
 # CONFIG_IDE is not set
 
@@ -192,6 +267,10 @@
 #
 
 #
+# IEEE 1394 (FireWire) support
+#
+
+#
 # I2O device support
 #
 
@@ -205,9 +284,6 @@
 #
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
-# CONFIG_NETLINK_DEV is not set
-# CONFIG_NETFILTER is not set
-# CONFIG_FILTER is not set
 CONFIG_UNIX=y
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
@@ -217,45 +293,53 @@
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
 # CONFIG_ARPD is not set
-# CONFIG_INET_ECN is not set
 # CONFIG_SYN_COOKIES is not set
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
-# CONFIG_XFRM_USER is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_IP_TCPDIAG=y
+# CONFIG_IP_TCPDIAG_IPV6 is not set
 # CONFIG_IPV6 is not set
+# CONFIG_NETFILTER is not set
 
 #
 # SCTP Configuration (EXPERIMENTAL)
 #
-CONFIG_IPV6_SCTP__=y
 # CONFIG_IP_SCTP is not set
 # CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
 # CONFIG_VLAN_8021Q is not set
-# CONFIG_LLC is not set
 # CONFIG_DECNET is not set
-# CONFIG_BRIDGE is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
 #
 # CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
 
 #
 # Network testing
 #
 # CONFIG_NET_PKTGEN is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
 CONFIG_NETDEVICES=y
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
-# CONFIG_ETHERTAP is not set
 
 #
 # Ethernet (10 or 100Mbit)
@@ -263,48 +347,45 @@
 CONFIG_NET_ETHERNET=y
 # CONFIG_MII is not set
 CONFIG_FEC=y
+# CONFIG_FEC2 is not set
 
 #
 # Ethernet (1000 Mbit)
 #
-CONFIG_PPP=y
-# CONFIG_PPP_MULTILINK is not set
-# CONFIG_PPP_ASYNC is not set
-# CONFIG_PPP_SYNC_TTY is not set
-# CONFIG_PPP_DEFLATE is not set
-# CONFIG_PPP_BSDCOMP is not set
-# CONFIG_PPPOE is not set
-# CONFIG_SLIP is not set
-
-#
-# Wireless LAN (non-hamradio)
-#
-# CONFIG_NET_RADIO is not set
 
 #
-# Token Ring devices (depends on LLC=y)
+# Ethernet (10000 Mbit)
 #
-# CONFIG_SHAPER is not set
 
 #
-# Wan interfaces
+# Token Ring devices
 #
-# CONFIG_WAN is not set
 
 #
-# Amateur Radio support
+# Wireless LAN (non-hamradio)
 #
-# CONFIG_HAMRADIO is not set
+# CONFIG_NET_RADIO is not set
 
 #
-# IrDA (infrared) support
+# Wan interfaces
 #
-# CONFIG_IRDA is not set
+# CONFIG_WAN is not set
+CONFIG_PPP=y
+# CONFIG_PPP_MULTILINK is not set
+# CONFIG_PPP_FILTER is not set
+# CONFIG_PPP_ASYNC is not set
+# CONFIG_PPP_SYNC_TTY is not set
+# CONFIG_PPP_DEFLATE is not set
+# CONFIG_PPP_BSDCOMP is not set
+# CONFIG_PPPOE is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
 
 #
 # ISDN subsystem
 #
-# CONFIG_ISDN_BOOL is not set
+# CONFIG_ISDN is not set
 
 #
 # Telephony Support
@@ -329,36 +410,39 @@
 # CONFIG_INPUT_EVBUG is not set
 
 #
-# Input I/O drivers
-#
-# CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
-CONFIG_SERIO=y
-CONFIG_SERIO_I8042=y
-CONFIG_SERIO_SERPORT=y
-# CONFIG_SERIO_CT82C710 is not set
-
-#
 # Input Device Drivers
 #
 CONFIG_INPUT_KEYBOARD=y
 CONFIG_KEYBOARD_ATKBD=y
 # CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_XTKBD is not set
 # CONFIG_KEYBOARD_NEWTON is not set
 CONFIG_INPUT_MOUSE=y
 CONFIG_MOUSE_PS2=y
 # CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_VSXXXAA is not set
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TOUCHSCREEN is not set
 # CONFIG_INPUT_MISC is not set
 
 #
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+CONFIG_SERIO_I8042=y
+CONFIG_SERIO_SERPORT=y
+CONFIG_SERIO_LIBPS2=y
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+
+#
 # Character devices
 #
-# CONFIG_VT is not set
+CONFIG_VT=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
 # CONFIG_SERIAL_NONSTANDARD is not set
-# CONFIG_RESETSWITCH is not set
 
 #
 # Serial drivers
@@ -369,51 +453,47 @@
 # Non-8250 serial port support
 #
 CONFIG_SERIAL_COLDFIRE=y
-# CONFIG_UNIX98_PTYS is not set
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
 
 #
-# I2C support
+# IPMI
 #
-# CONFIG_I2C is not set
+# CONFIG_IPMI_HANDLER is not set
 
 #
-# I2C Hardware Sensors Mainboard support
+# Watchdog Cards
 #
+# CONFIG_WATCHDOG is not set
+# CONFIG_RTC is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
 
 #
-# I2C Hardware Sensors Chip support
+# Ftape, the floppy tape device driver
 #
+# CONFIG_DRM is not set
+# CONFIG_RAW_DRIVER is not set
 
 #
-# Mice
+# TPM devices
 #
-# CONFIG_BUSMOUSE is not set
-# CONFIG_QIC02_TAPE is not set
 
 #
-# IPMI
+# I2C support
 #
-# CONFIG_IPMI_HANDLER is not set
+# CONFIG_I2C is not set
 
 #
-# Watchdog Cards
+# Dallas's 1-wire bus
 #
-# CONFIG_WATCHDOG is not set
-# CONFIG_NVRAM is not set
-# CONFIG_RTC is not set
-# CONFIG_GEN_RTC is not set
-# CONFIG_DTLK is not set
-# CONFIG_R3964 is not set
-# CONFIG_APPLICOM is not set
+# CONFIG_W1 is not set
 
 #
-# Ftape, the floppy tape device driver
+# Misc devices
 #
-# CONFIG_FTAPE is not set
-# CONFIG_AGP is not set
-# CONFIG_DRM is not set
-# CONFIG_RAW_DRIVER is not set
-# CONFIG_HANGCHECK_TIMER is not set
 
 #
 # Multimedia devices
@@ -421,6 +501,48 @@
 # CONFIG_VIDEO_DEV is not set
 
 #
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Console display driver support
+#
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -429,10 +551,15 @@
 # CONFIG_JBD is not set
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
+
+#
+# XFS support
+#
 # CONFIG_XFS_FS is not set
 # CONFIG_MINIX_FS is not set
 CONFIG_ROMFS_FS=y
 # CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 
@@ -445,15 +572,19 @@
 #
 # DOS/FAT/NT Filesystems
 #
-# CONFIG_FAT_FS is not set
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
 # CONFIG_NTFS_FS is not set
 
 #
 # Pseudo filesystems
 #
 CONFIG_PROC_FS=y
+CONFIG_SYSFS=y
 # CONFIG_DEVFS_FS is not set
+# CONFIG_DEVPTS_FS_XATTR is not set
 # CONFIG_TMPFS is not set
+# CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 
 #
@@ -462,6 +593,7 @@
 # CONFIG_ADFS_FS is not set
 # CONFIG_AFFS_FS is not set
 # CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
@@ -479,12 +611,10 @@
 #
 # CONFIG_NFS_FS is not set
 # CONFIG_NFSD is not set
-# CONFIG_EXPORTFS is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
-# CONFIG_INTERMEZZO_FS is not set
 # CONFIG_AFS_FS is not set
 
 #
@@ -494,30 +624,19 @@
 CONFIG_MSDOS_PARTITION=y
 
 #
-# Graphics support
-#
-# CONFIG_FB is not set
-
-#
-# Sound
+# Native Language Support
 #
-# CONFIG_SOUND is not set
-
-#
-# USB support
-#
-
-#
-# Bluetooth support
-#
-# CONFIG_BT is not set
+# CONFIG_NLS is not set
 
 #
 # Kernel hacking
 #
+# CONFIG_PRINTK_TIME is not set
+# CONFIG_DEBUG_KERNEL is not set
+CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_FULLDEBUG is not set
-# CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_HIGHPROFILE is not set
+# CONFIG_BOOTPARAM is not set
 # CONFIG_DUMPTOFLASH is not set
 # CONFIG_NO_KERNEL_MSG is not set
 # CONFIG_BDM_DISABLE is not set
@@ -525,6 +644,7 @@
 #
 # Security options
 #
+# CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 
 #
@@ -533,6 +653,12 @@
 # CONFIG_CRYPTO is not set
 
 #
+# Hardware crypto devices
+#
+
+#
 # Library routines
 #
+# CONFIG_CRC_CCITT is not set
 # CONFIG_CRC32 is not set
+# CONFIG_LIBCRC32C is not set

--------------070205050709080109010105--
