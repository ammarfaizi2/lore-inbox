Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265182AbUELTEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265182AbUELTEG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 15:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265184AbUELTEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 15:04:06 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:48819 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S265182AbUELS4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:56:43 -0400
From: mporter@kernel.crashing.org
Message-Id: <200405121856.LAA13791@liberty.homelinux.org>
Subject: [PATCH 6/8] PPC32: Update 4xx defconfigs
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Date: Wed, 12 May 2004 11:56:06 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update all current 4xx defconfigs for new OCP.
Please apply.

diff -Nru a/arch/ppc/configs/ash_defconfig b/arch/ppc/configs/ash_defconfig
--- a/arch/ppc/configs/ash_defconfig	Wed May 12 09:24:59 2004
+++ b/arch/ppc/configs/ash_defconfig	Wed May 12 09:24:59 2004
@@ -4,11 +4,17 @@
 CONFIG_MMU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_HAVE_DEC_LOCK=y
+CONFIG_PPC=y
+CONFIG_PPC32=y
+CONFIG_GENERIC_NVRAM=y
 
 #
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
+CONFIG_CLEAN_COMPILE=y
+CONFIG_STANDALONE=y
+CONFIG_BROKEN_ON_SMP=y
 
 #
 # General setup
@@ -18,9 +24,16 @@
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_HOTPLUG is not set
+# CONFIG_IKCONFIG is not set
 CONFIG_EMBEDDED=y
+# CONFIG_KALLSYMS is not set
 CONFIG_FUTEX=y
 # CONFIG_EPOLL is not set
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 
 #
 # Loadable module support
@@ -33,66 +46,61 @@
 CONFIG_KMOD=y
 
 #
-# Platform support
+# Processor
 #
-CONFIG_PPC=y
-CONFIG_PPC32=y
 # CONFIG_6xx is not set
 CONFIG_40x=y
+# CONFIG_44x is not set
 # CONFIG_POWER3 is not set
+# CONFIG_POWER4 is not set
 # CONFIG_8xx is not set
+# CONFIG_MATH_EMULATION is not set
+# CONFIG_CPU_FREQ is not set
 CONFIG_4xx=y
 
 #
 # IBM 4xx options
 #
 CONFIG_ASH=y
-# CONFIG_BEECH is not set
-# CONFIG_CEDAR is not set
 # CONFIG_CPCI405 is not set
 # CONFIG_EP405 is not set
+# CONFIG_EVB405EP is not set
 # CONFIG_OAK is not set
-# CONFIG_REDWOOD_4 is not set
 # CONFIG_REDWOOD_5 is not set
 # CONFIG_REDWOOD_6 is not set
 # CONFIG_SYCAMORE is not set
-# CONFIG_TIVO is not set
 # CONFIG_WALNUT is not set
 CONFIG_NP405H=y
 CONFIG_IBM405_ERR77=y
 CONFIG_IBM405_ERR51=y
 CONFIG_IBM_OCP=y
+CONFIG_PPC_OCP=y
 CONFIG_IBM_OPENBIOS=y
-# CONFIG_405_DMA is not set
 # CONFIG_PM is not set
 CONFIG_UART0_TTYS0=y
 # CONFIG_UART0_TTYS1 is not set
 CONFIG_NOT_COHERENT_CACHE=y
-# CONFIG_SMP is not set
-# CONFIG_PREEMPT is not set
-# CONFIG_MATH_EMULATION is not set
-# CONFIG_CPU_FREQ is not set
 
 #
-# General setup
+# Platform options
 #
-# CONFIG_HIGHMEM is not set
-CONFIG_PCI=y
-CONFIG_PCI_DOMAINS=y
 # CONFIG_PC_KEYBOARD is not set
-CONFIG_KCORE_ELF=y
-CONFIG_BINFMT_ELF=y
+# CONFIG_SMP is not set
+# CONFIG_PREEMPT is not set
+# CONFIG_HIGHMEM is not set
 CONFIG_KERNEL_ELF=y
+CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-CONFIG_PCI_LEGACY_PROC=y
-# CONFIG_PCI_NAMES is not set
-# CONFIG_HOTPLUG is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="ip=on"
 
 #
-# Parallel port support
+# Bus options
 #
-# CONFIG_PARPORT is not set
-# CONFIG_CMDLINE_BOOL is not set
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_LEGACY_PROC=y
+# CONFIG_PCI_NAMES is not set
 
 #
 # Advanced setup
@@ -109,14 +117,26 @@
 CONFIG_BOOT_LOAD=0x00400000
 
 #
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+
+#
 # Memory Technology Devices (MTD)
 #
 # CONFIG_MTD is not set
 
 #
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
 # Plug and Play support
 #
-# CONFIG_PNP is not set
 
 #
 # Block devices
@@ -127,32 +147,36 @@
 # CONFIG_BLK_DEV_DAC960 is not set
 # CONFIG_BLK_DEV_UMEM is not set
 CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_CARMEL is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
+# CONFIG_LBD is not set
 
 #
-# Multi-device support (RAID and LVM)
+# ATA/ATAPI/MFM/RLL support
 #
-# CONFIG_MD is not set
+# CONFIG_IDE is not set
 
 #
-# ATA/IDE/MFM/RLL support
+# SCSI device support
 #
-# CONFIG_IDE is not set
+# CONFIG_SCSI is not set
 
 #
-# SCSI support
+# Multi-device support (RAID and LVM)
 #
-# CONFIG_SCSI is not set
+# CONFIG_MD is not set
 
 #
 # Fusion MPT device support
 #
+# CONFIG_FUSION is not set
 
 #
-# IEEE 1394 (FireWire) support (EXPERIMENTAL)
+# IEEE 1394 (FireWire) support
 #
 # CONFIG_IEEE1394 is not set
 
@@ -162,6 +186,10 @@
 # CONFIG_I2O is not set
 
 #
+# Macintosh device drivers
+#
+
+#
 # Networking support
 #
 CONFIG_NET=y
@@ -171,38 +199,37 @@
 #
 # CONFIG_PACKET is not set
 # CONFIG_NETLINK_DEV is not set
-# CONFIG_NETFILTER is not set
 CONFIG_UNIX=y
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 # CONFIG_IP_ADVANCED_ROUTER is not set
 CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
+# CONFIG_IP_PNP_DHCP is not set
 CONFIG_IP_PNP_BOOTP=y
-CONFIG_IP_PNP_RARP=y
+# CONFIG_IP_PNP_RARP is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
 # CONFIG_IP_MROUTE is not set
 # CONFIG_ARPD is not set
-# CONFIG_INET_ECN is not set
 CONFIG_SYN_COOKIES=y
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_IPV6 is not set
-# CONFIG_XFRM_USER is not set
+# CONFIG_DECNET is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_NETFILTER is not set
 
 #
 # SCTP Configuration (EXPERIMENTAL)
 #
-CONFIG_IPV6_SCTP__=y
 # CONFIG_IP_SCTP is not set
 # CONFIG_ATM is not set
 # CONFIG_VLAN_8021Q is not set
-# CONFIG_LLC is not set
-# CONFIG_DECNET is not set
-# CONFIG_BRIDGE is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
 # CONFIG_NET_DIVERT is not set
@@ -230,7 +257,6 @@
 # CONFIG_BONDING is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
-# CONFIG_ETHERTAP is not set
 
 #
 # Ethernet (10 or 100Mbit)
@@ -247,6 +273,7 @@
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
 # CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
 # CONFIG_SK98LIN is not set
 # CONFIG_TIGON3 is not set
 
@@ -254,6 +281,12 @@
 # Ethernet (10000 Mbit)
 #
 # CONFIG_IXGB is not set
+CONFIG_IBM_EMAC=y
+# CONFIG_IBM_EMAC_ERRMSG is not set
+CONFIG_IBM_EMAC_RXB=64
+CONFIG_IBM_EMAC_TXB=8
+CONFIG_IBM_EMAC_FGAP=8
+CONFIG_IBM_EMAC_SKBRES=0
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
 # CONFIG_PPP is not set
@@ -265,10 +298,12 @@
 # CONFIG_NET_RADIO is not set
 
 #
-# Token Ring devices (depends on LLC=y)
+# Token Ring devices
 #
+# CONFIG_TR is not set
 # CONFIG_RCPCI is not set
 # CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
 
 #
 # Wan interfaces
@@ -286,47 +321,71 @@
 # CONFIG_IRDA is not set
 
 #
-# ISDN subsystem
+# Bluetooth support
 #
-# CONFIG_ISDN_BOOL is not set
+# CONFIG_BT is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
 
 #
-# Graphics support
+# ISDN subsystem
 #
-# CONFIG_FB is not set
+# CONFIG_ISDN is not set
 
 #
-# Old CD-ROM drivers (not SCSI, not IDE)
+# Telephony Support
 #
-# CONFIG_CD_NO_IDESCSI is not set
+# CONFIG_PHONE is not set
 
 #
 # Input device support
 #
-# CONFIG_INPUT is not set
+CONFIG_INPUT=y
 
 #
 # Userland interfaces
 #
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_PSAUX=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
 
 #
 # Input I/O drivers
 #
 # CONFIG_GAMEPORT is not set
 CONFIG_SOUND_GAMEPORT=y
-# CONFIG_SERIO is not set
+CONFIG_SERIO=y
+CONFIG_SERIO_I8042=y
+CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_PCIPS2 is not set
 
 #
 # Input Device Drivers
 #
-
-#
-# Macintosh device drivers
-#
+CONFIG_INPUT_KEYBOARD=y
+CONFIG_KEYBOARD_ATKBD=y
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_LKKBD is not set
+# CONFIG_KEYBOARD_XTKBD is not set
+# CONFIG_KEYBOARD_NEWTON is not set
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_PS2=y
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_VSXXXAA is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
 
 #
 # Character devices
 #
+# CONFIG_VT is not set
 # CONFIG_SERIAL_NONSTANDARD is not set
 
 #
@@ -334,6 +393,7 @@
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=4
 # CONFIG_SERIAL_8250_EXTENDED is not set
 
 #
@@ -342,100 +402,145 @@
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
-CONFIG_UNIX98_PTY_COUNT=256
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+# CONFIG_QIC02_TAPE is not set
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+CONFIG_WATCHDOG=y
+# CONFIG_WATCHDOG_NOWAYOUT is not set
+
+#
+# Watchdog Device Drivers
+#
+# CONFIG_SOFT_WATCHDOG is not set
+
+#
+# PCI-based Watchdog Cards
+#
+# CONFIG_PCIPCWATCHDOG is not set
+# CONFIG_WDTPCI is not set
+# CONFIG_NVRAM is not set
+CONFIG_GEN_RTC=y
+# CONFIG_GEN_RTC_X is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_FTAPE is not set
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+# CONFIG_RAW_DRIVER is not set
 
 #
 # I2C support
 #
 CONFIG_I2C=y
+# CONFIG_I2C_CHARDEV is not set
+
+#
+# I2C Algorithms
+#
 # CONFIG_I2C_ALGOBIT is not set
 # CONFIG_I2C_ALGOPCF is not set
-CONFIG_I2C_IBM_OCP_ALGO=y
-CONFIG_I2C_IBM_OCP_ADAP=y
-# CONFIG_I2C_CHARDEV is not set
 
 #
-# I2C Hardware Sensors Mainboard support
+# I2C Hardware Bus support
 #
+# CONFIG_I2C_ALI1535 is not set
 # CONFIG_I2C_ALI15X3 is not set
 # CONFIG_I2C_AMD756 is not set
 # CONFIG_I2C_AMD8111 is not set
 # CONFIG_I2C_I801 is not set
+# CONFIG_I2C_I810 is not set
+# CONFIG_I2C_IBM_IIC is not set
+# CONFIG_I2C_ISA is not set
+# CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_PIIX4 is not set
+# CONFIG_I2C_PROSAVAGE is not set
+# CONFIG_I2C_SAVAGE4 is not set
+# CONFIG_SCx200_ACB is not set
+# CONFIG_I2C_SIS5595 is not set
+# CONFIG_I2C_SIS630 is not set
 # CONFIG_I2C_SIS96X is not set
+# CONFIG_I2C_VIA is not set
 # CONFIG_I2C_VIAPRO is not set
+# CONFIG_I2C_VOODOO3 is not set
 
 #
-# I2C Hardware Sensors Chip support
+# Hardware Sensors Chip support
 #
+# CONFIG_I2C_SENSOR is not set
 # CONFIG_SENSORS_ADM1021 is not set
+# CONFIG_SENSORS_ASB100 is not set
+# CONFIG_SENSORS_DS1621 is not set
+# CONFIG_SENSORS_FSCHER is not set
+# CONFIG_SENSORS_GL518SM is not set
 # CONFIG_SENSORS_IT87 is not set
 # CONFIG_SENSORS_LM75 is not set
+# CONFIG_SENSORS_LM78 is not set
+# CONFIG_SENSORS_LM80 is not set
+# CONFIG_SENSORS_LM83 is not set
 # CONFIG_SENSORS_LM85 is not set
+# CONFIG_SENSORS_LM90 is not set
 # CONFIG_SENSORS_VIA686A is not set
 # CONFIG_SENSORS_W83781D is not set
-# CONFIG_I2C_SENSOR is not set
+# CONFIG_SENSORS_W83L785TS is not set
+# CONFIG_SENSORS_W83627HF is not set
 
 #
-# Mice
+# Other I2C Chip support
 #
-# CONFIG_BUSMOUSE is not set
-# CONFIG_QIC02_TAPE is not set
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
 
 #
-# IPMI
+# Misc devices
 #
-# CONFIG_IPMI_HANDLER is not set
 
 #
-# Watchdog Cards
+# Multimedia devices
 #
-CONFIG_WATCHDOG=y
-# CONFIG_WATCHDOG_NOWAYOUT is not set
-# CONFIG_SOFT_WATCHDOG is not set
-# CONFIG_WDT is not set
-# CONFIG_WDTPCI is not set
-# CONFIG_PCWATCHDOG is not set
-# CONFIG_ACQUIRE_WDT is not set
-# CONFIG_ADVANTECH_WDT is not set
-# CONFIG_EUROTECH_WDT is not set
-# CONFIG_IB700_WDT is not set
-# CONFIG_MIXCOMWD is not set
-# CONFIG_SCx200_WDT is not set
-# CONFIG_60XX_WDT is not set
-# CONFIG_W83877F_WDT is not set
-# CONFIG_MACHZ_WDT is not set
-# CONFIG_SC520_WDT is not set
-# CONFIG_AMD7XX_TCO is not set
-# CONFIG_ALIM7101_WDT is not set
-# CONFIG_SC1200_WDT is not set
-# CONFIG_WAFER_WDT is not set
-# CONFIG_CPU5_WDT is not set
-# CONFIG_NVRAM is not set
-CONFIG_GEN_RTC=y
-# CONFIG_GEN_RTC_X is not set
-# CONFIG_DTLK is not set
-# CONFIG_R3964 is not set
-# CONFIG_APPLICOM is not set
+# CONFIG_VIDEO_DEV is not set
 
 #
-# Ftape, the floppy tape device driver
+# Digital Video Broadcasting Devices
 #
-# CONFIG_FTAPE is not set
-# CONFIG_AGP is not set
-# CONFIG_DRM is not set
-# CONFIG_RAW_DRIVER is not set
-# CONFIG_HANGCHECK_TIMER is not set
+# CONFIG_DVB is not set
 
 #
-# Multimedia devices
+# Graphics support
 #
-# CONFIG_VIDEO_DEV is not set
+# CONFIG_FB is not set
 
 #
-# Digital Video Broadcasting Devices
+# Sound
 #
-# CONFIG_DVB is not set
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+# CONFIG_USB is not set
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
 
 #
 # File systems
@@ -469,10 +574,11 @@
 # Pseudo filesystems
 #
 CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
 # CONFIG_DEVFS_FS is not set
-CONFIG_DEVPTS_FS=y
 # CONFIG_DEVPTS_FS_XATTR is not set
 CONFIG_TMPFS=y
+# CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 
 #
@@ -481,6 +587,7 @@
 # CONFIG_ADFS_FS is not set
 # CONFIG_AFFS_FS is not set
 # CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
@@ -497,12 +604,13 @@
 CONFIG_NFS_FS=y
 # CONFIG_NFS_V3 is not set
 # CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 # CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
-# CONFIG_SUNRPC_GSS is not set
+# CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
@@ -528,26 +636,15 @@
 # CONFIG_EFI_PARTITION is not set
 
 #
-# Sound
+# Native Language Support
 #
-# CONFIG_SOUND is not set
+# CONFIG_NLS is not set
 
 #
 # IBM 40x options
 #
 
 #
-# USB support
-#
-# CONFIG_USB is not set
-# CONFIG_USB_GADGET is not set
-
-#
-# Bluetooth support
-#
-# CONFIG_BT is not set
-
-#
 # Library routines
 #
 CONFIG_CRC32=y
@@ -556,7 +653,6 @@
 # Kernel hacking
 #
 # CONFIG_DEBUG_KERNEL is not set
-# CONFIG_KALLSYMS is not set
 # CONFIG_SERIAL_TEXT_DEBUG is not set
 CONFIG_OCP=y
 
diff -Nru a/arch/ppc/configs/cpci405_defconfig b/arch/ppc/configs/cpci405_defconfig
--- a/arch/ppc/configs/cpci405_defconfig	Wed May 12 09:24:59 2004
+++ b/arch/ppc/configs/cpci405_defconfig	Wed May 12 09:24:59 2004
@@ -6,6 +6,7 @@
 CONFIG_HAVE_DEC_LOCK=y
 CONFIG_PPC=y
 CONFIG_PPC32=y
+CONFIG_GENERIC_NVRAM=y
 
 #
 # Code maturity level options
@@ -23,6 +24,7 @@
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_HOTPLUG is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_EMBEDDED=y
 # CONFIG_KALLSYMS is not set
@@ -31,6 +33,7 @@
 CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 
 #
 # Loadable module support
@@ -59,22 +62,19 @@
 # IBM 4xx options
 #
 # CONFIG_ASH is not set
-# CONFIG_BEECH is not set
-# CONFIG_CEDAR is not set
 CONFIG_CPCI405=y
 # CONFIG_EP405 is not set
+# CONFIG_EVB405EP is not set
 # CONFIG_OAK is not set
-# CONFIG_REDWOOD_4 is not set
 # CONFIG_REDWOOD_5 is not set
 # CONFIG_REDWOOD_6 is not set
 # CONFIG_SYCAMORE is not set
-# CONFIG_TIVO is not set
 # CONFIG_WALNUT is not set
 CONFIG_IBM405_ERR77=y
 CONFIG_IBM405_ERR51=y
 CONFIG_IBM_OCP=y
+CONFIG_PPC_OCP=y
 CONFIG_405GP=y
-# CONFIG_405_DMA is not set
 # CONFIG_PM is not set
 CONFIG_UART0_TTYS0=y
 # CONFIG_UART0_TTYS1 is not set
@@ -90,7 +90,8 @@
 CONFIG_KERNEL_ELF=y
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-# CONFIG_CMDLINE_BOOL is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="ip=on"
 
 #
 # Bus options
@@ -99,12 +100,6 @@
 CONFIG_PCI_DOMAINS=y
 CONFIG_PCI_LEGACY_PROC=y
 # CONFIG_PCI_NAMES is not set
-# CONFIG_HOTPLUG is not set
-
-#
-# Parallel port support
-#
-# CONFIG_PARPORT is not set
 
 #
 # Advanced setup
@@ -121,6 +116,10 @@
 CONFIG_BOOT_LOAD=0x00400000
 
 #
+# Device Drivers
+#
+
+#
 # Generic Driver Options
 #
 
@@ -130,30 +129,31 @@
 # CONFIG_MTD is not set
 
 #
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
 # Plug and Play support
 #
-# CONFIG_PNP is not set
 
 #
 # Block devices
 #
+# CONFIG_BLK_DEV_FD is not set
 # CONFIG_BLK_CPQ_DA is not set
 # CONFIG_BLK_CPQ_CISS_DA is not set
 # CONFIG_BLK_DEV_DAC960 is not set
 # CONFIG_BLK_DEV_UMEM is not set
 # CONFIG_BLK_DEV_LOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_CARMEL is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_LBD is not set
 
 #
-# Multi-device support (RAID and LVM)
-#
-# CONFIG_MD is not set
-
-#
 # ATA/ATAPI/MFM/RLL support
 #
 CONFIG_IDE=y
@@ -174,6 +174,7 @@
 #
 # IDE chipset support/bugfixes
 #
+CONFIG_IDE_GENERIC=y
 # CONFIG_BLK_DEV_IDEPCI is not set
 # CONFIG_BLK_DEV_IDEDMA is not set
 # CONFIG_IDEDMA_AUTO is not set
@@ -185,11 +186,17 @@
 # CONFIG_SCSI is not set
 
 #
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
 # Fusion MPT device support
 #
+# CONFIG_FUSION is not set
 
 #
-# IEEE 1394 (FireWire) support (EXPERIMENTAL)
+# IEEE 1394 (FireWire) support
 #
 # CONFIG_IEEE1394 is not set
 
@@ -199,6 +206,10 @@
 # CONFIG_I2O is not set
 
 #
+# Macintosh device drivers
+#
+
+#
 # Networking support
 #
 CONFIG_NET=y
@@ -214,14 +225,13 @@
 CONFIG_IP_MULTICAST=y
 # CONFIG_IP_ADVANCED_ROUTER is not set
 CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
+# CONFIG_IP_PNP_DHCP is not set
 CONFIG_IP_PNP_BOOTP=y
-CONFIG_IP_PNP_RARP=y
+# CONFIG_IP_PNP_RARP is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
 # CONFIG_IP_MROUTE is not set
 # CONFIG_ARPD is not set
-# CONFIG_INET_ECN is not set
 CONFIG_SYN_COOKIES=y
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
@@ -234,7 +244,6 @@
 #
 # SCTP Configuration (EXPERIMENTAL)
 #
-CONFIG_IPV6_SCTP__=y
 # CONFIG_IP_SCTP is not set
 # CONFIG_ATM is not set
 # CONFIG_VLAN_8021Q is not set
@@ -292,6 +301,12 @@
 # Ethernet (10000 Mbit)
 #
 # CONFIG_IXGB is not set
+CONFIG_IBM_EMAC=y
+# CONFIG_IBM_EMAC_ERRMSG is not set
+CONFIG_IBM_EMAC_RXB=64
+CONFIG_IBM_EMAC_TXB=8
+CONFIG_IBM_EMAC_FGAP=8
+CONFIG_IBM_EMAC_SKBRES=0
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
 # CONFIG_PPP is not set
@@ -308,6 +323,7 @@
 # CONFIG_TR is not set
 # CONFIG_RCPCI is not set
 # CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
 
 #
 # Wan interfaces
@@ -328,16 +344,18 @@
 # Bluetooth support
 #
 # CONFIG_BT is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
 
 #
 # ISDN subsystem
 #
-# CONFIG_ISDN_BOOL is not set
+# CONFIG_ISDN is not set
 
 #
-# Graphics support
+# Telephony Support
 #
-# CONFIG_FB is not set
+# CONFIG_PHONE is not set
 
 #
 # Input device support
@@ -374,10 +392,6 @@
 # CONFIG_INPUT_MISC is not set
 
 #
-# Macintosh device drivers
-#
-
-#
 # Character devices
 #
 # CONFIG_VT is not set
@@ -397,52 +411,8 @@
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_UNIX98_PTYS is not set
-
-#
-# I2C support
-#
-CONFIG_I2C=y
-CONFIG_I2C_CHARDEV=y
-
-#
-# I2C Algorithms
-#
-# CONFIG_I2C_ALGOBIT is not set
-# CONFIG_I2C_ALGOPCF is not set
-
-#
-# I2C Hardware Bus support
-#
-# CONFIG_I2C_ALI1535 is not set
-# CONFIG_I2C_ALI15X3 is not set
-# CONFIG_I2C_AMD756 is not set
-# CONFIG_I2C_AMD8111 is not set
-# CONFIG_I2C_I801 is not set
-CONFIG_I2C_IBM_IIC=y
-# CONFIG_I2C_NFORCE2 is not set
-# CONFIG_I2C_PIIX4 is not set
-# CONFIG_I2C_SIS5595 is not set
-# CONFIG_I2C_SIS630 is not set
-# CONFIG_I2C_SIS96X is not set
-# CONFIG_I2C_VIAPRO is not set
-
-#
-# I2C Hardware Sensors Chip support
-#
-# CONFIG_I2C_SENSOR is not set
-# CONFIG_SENSORS_ADM1021 is not set
-# CONFIG_SENSORS_EEPROM is not set
-# CONFIG_SENSORS_IT87 is not set
-# CONFIG_SENSORS_LM75 is not set
-# CONFIG_SENSORS_LM78 is not set
-# CONFIG_SENSORS_LM85 is not set
-# CONFIG_SENSORS_VIA686A is not set
-# CONFIG_SENSORS_W83781D is not set
-
-#
-# Mice
-#
-# CONFIG_BUSMOUSE is not set
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_QIC02_TAPE is not set
 
 #
@@ -470,6 +440,15 @@
 # CONFIG_RAW_DRIVER is not set
 
 #
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# Misc devices
+#
+
+#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -480,6 +459,26 @@
 # CONFIG_DVB is not set
 
 #
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+# CONFIG_USB is not set
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -525,6 +524,7 @@
 # CONFIG_ADFS_FS is not set
 # CONFIG_AFFS_FS is not set
 # CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
@@ -541,13 +541,14 @@
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
 # CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
-# CONFIG_SUNRPC_GSS is not set
+# CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
@@ -560,11 +561,11 @@
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_MSDOS_PARTITION=y
-CONFIG_NLS=y
 
 #
 # Native Language Support
 #
+CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_NLS_CODEPAGE_437 is not set
 # CONFIG_NLS_CODEPAGE_737 is not set
@@ -605,19 +606,8 @@
 # CONFIG_NLS_UTF8 is not set
 
 #
-# Sound
-#
-# CONFIG_SOUND is not set
-
-#
 # IBM 40x options
 #
-
-#
-# USB support
-#
-# CONFIG_USB is not set
-# CONFIG_USB_GADGET is not set
 
 #
 # Library routines
diff -Nru a/arch/ppc/configs/ebony_defconfig b/arch/ppc/configs/ebony_defconfig
--- a/arch/ppc/configs/ebony_defconfig	Wed May 12 09:24:59 2004
+++ b/arch/ppc/configs/ebony_defconfig	Wed May 12 09:24:59 2004
@@ -285,6 +285,12 @@
 # Ethernet (10000 Mbit)
 #
 # CONFIG_IXGB is not set
+CONFIG_IBM_EMAC=y
+# CONFIG_IBM_EMAC_ERRMSG is not set
+CONFIG_IBM_EMAC_RXB=64
+CONFIG_IBM_EMAC_TXB=8
+CONFIG_IBM_EMAC_FGAP=8
+CONFIG_IBM_EMAC_SKBRES=0
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
 # CONFIG_PPP is not set
diff -Nru a/arch/ppc/configs/ep405_defconfig b/arch/ppc/configs/ep405_defconfig
--- a/arch/ppc/configs/ep405_defconfig	Wed May 12 09:24:59 2004
+++ b/arch/ppc/configs/ep405_defconfig	Wed May 12 09:24:59 2004
@@ -6,6 +6,7 @@
 CONFIG_HAVE_DEC_LOCK=y
 CONFIG_PPC=y
 CONFIG_PPC32=y
+CONFIG_GENERIC_NVRAM=y
 
 #
 # Code maturity level options
@@ -23,14 +24,16 @@
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_HOTPLUG is not set
 # CONFIG_IKCONFIG is not set
-# CONFIG_EMBEDDED is not set
+CONFIG_EMBEDDED=y
 CONFIG_KALLSYMS=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 
 #
 # Loadable module support
@@ -59,25 +62,22 @@
 # IBM 4xx options
 #
 # CONFIG_ASH is not set
-# CONFIG_BEECH is not set
-# CONFIG_CEDAR is not set
 # CONFIG_CPCI405 is not set
 CONFIG_EP405=y
+# CONFIG_EVB405EP is not set
 # CONFIG_OAK is not set
-# CONFIG_REDWOOD_4 is not set
 # CONFIG_REDWOOD_5 is not set
 # CONFIG_REDWOOD_6 is not set
 # CONFIG_SYCAMORE is not set
-# CONFIG_TIVO is not set
 # CONFIG_WALNUT is not set
 # CONFIG_EP405PC is not set
 CONFIG_IBM405_ERR77=y
 CONFIG_IBM405_ERR51=y
 CONFIG_IBM_OCP=y
+CONFIG_PPC_OCP=y
 CONFIG_BIOS_FIXUP=y
 CONFIG_405GP=y
 CONFIG_EMBEDDEDBOOT=y
-# CONFIG_405_DMA is not set
 # CONFIG_PM is not set
 CONFIG_UART0_TTYS0=y
 # CONFIG_UART0_TTYS1 is not set
@@ -93,7 +93,8 @@
 CONFIG_KERNEL_ELF=y
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-# CONFIG_CMDLINE_BOOL is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="ip=on"
 
 #
 # Bus options
@@ -102,12 +103,6 @@
 CONFIG_PCI_DOMAINS=y
 # CONFIG_PCI_LEGACY_PROC is not set
 # CONFIG_PCI_NAMES is not set
-# CONFIG_HOTPLUG is not set
-
-#
-# Parallel port support
-#
-# CONFIG_PARPORT is not set
 
 #
 # Advanced setup
@@ -124,6 +119,10 @@
 CONFIG_BOOT_LOAD=0x00400000
 
 #
+# Device Drivers
+#
+
+#
 # Generic Driver Options
 #
 
@@ -133,13 +132,18 @@
 # CONFIG_MTD is not set
 
 #
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
 # Plug and Play support
 #
-# CONFIG_PNP is not set
 
 #
 # Block devices
 #
+# CONFIG_BLK_DEV_FD is not set
 # CONFIG_BLK_CPQ_DA is not set
 # CONFIG_BLK_CPQ_CISS_DA is not set
 # CONFIG_BLK_DEV_DAC960 is not set
@@ -147,17 +151,13 @@
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_CARMEL is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_LBD is not set
 
 #
-# Multi-device support (RAID and LVM)
-#
-# CONFIG_MD is not set
-
-#
 # ATA/ATAPI/MFM/RLL support
 #
 # CONFIG_IDE is not set
@@ -168,11 +168,17 @@
 # CONFIG_SCSI is not set
 
 #
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
 # Fusion MPT device support
 #
+# CONFIG_FUSION is not set
 
 #
-# IEEE 1394 (FireWire) support (EXPERIMENTAL)
+# IEEE 1394 (FireWire) support
 #
 # CONFIG_IEEE1394 is not set
 
@@ -182,6 +188,10 @@
 # CONFIG_I2O is not set
 
 #
+# Macintosh device drivers
+#
+
+#
 # Networking support
 #
 CONFIG_NET=y
@@ -197,14 +207,13 @@
 CONFIG_IP_MULTICAST=y
 # CONFIG_IP_ADVANCED_ROUTER is not set
 CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
+# CONFIG_IP_PNP_DHCP is not set
 CONFIG_IP_PNP_BOOTP=y
-CONFIG_IP_PNP_RARP=y
+# CONFIG_IP_PNP_RARP is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
 # CONFIG_IP_MROUTE is not set
 # CONFIG_ARPD is not set
-# CONFIG_INET_ECN is not set
 CONFIG_SYN_COOKIES=y
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
@@ -217,7 +226,6 @@
 #
 # SCTP Configuration (EXPERIMENTAL)
 #
-CONFIG_IPV6_SCTP__=y
 # CONFIG_IP_SCTP is not set
 # CONFIG_ATM is not set
 # CONFIG_VLAN_8021Q is not set
@@ -287,6 +295,12 @@
 # Ethernet (10000 Mbit)
 #
 # CONFIG_IXGB is not set
+CONFIG_IBM_EMAC=y
+# CONFIG_IBM_EMAC_ERRMSG is not set
+CONFIG_IBM_EMAC_RXB=64
+CONFIG_IBM_EMAC_TXB=8
+CONFIG_IBM_EMAC_FGAP=8
+CONFIG_IBM_EMAC_SKBRES=0
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
 # CONFIG_PPP is not set
@@ -303,6 +317,7 @@
 # CONFIG_TR is not set
 # CONFIG_RCPCI is not set
 # CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
 
 #
 # Wan interfaces
@@ -323,23 +338,18 @@
 # Bluetooth support
 #
 # CONFIG_BT is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
 
 #
 # ISDN subsystem
 #
-# CONFIG_ISDN_BOOL is not set
-
-#
-# Graphics support
-#
-# CONFIG_FB is not set
+# CONFIG_ISDN is not set
 
 #
-# Console display driver support
+# Telephony Support
 #
-# CONFIG_VGA_CONSOLE is not set
-# CONFIG_MDA_CONSOLE is not set
-CONFIG_DUMMY_CONSOLE=y
+# CONFIG_PHONE is not set
 
 #
 # Input device support
@@ -379,15 +389,9 @@
 # CONFIG_INPUT_MISC is not set
 
 #
-# Macintosh device drivers
-#
-
-#
 # Character devices
 #
-CONFIG_VT=y
-CONFIG_VT_CONSOLE=y
-CONFIG_HW_CONSOLE=y
+# CONFIG_VT is not set
 # CONFIG_SERIAL_NONSTANDARD is not set
 
 #
@@ -403,53 +407,9 @@
 #
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
-# CONFIG_UNIX98_PTYS is not set
-
-#
-# I2C support
-#
-CONFIG_I2C=y
-# CONFIG_I2C_CHARDEV is not set
-
-#
-# I2C Algorithms
-#
-# CONFIG_I2C_ALGOBIT is not set
-# CONFIG_I2C_ALGOPCF is not set
-
-#
-# I2C Hardware Bus support
-#
-# CONFIG_I2C_ALI1535 is not set
-# CONFIG_I2C_ALI15X3 is not set
-# CONFIG_I2C_AMD756 is not set
-# CONFIG_I2C_AMD8111 is not set
-# CONFIG_I2C_I801 is not set
-CONFIG_I2C_IBM_IIC=y
-# CONFIG_I2C_NFORCE2 is not set
-# CONFIG_I2C_PIIX4 is not set
-# CONFIG_I2C_SIS5595 is not set
-# CONFIG_I2C_SIS630 is not set
-# CONFIG_I2C_SIS96X is not set
-# CONFIG_I2C_VIAPRO is not set
-
-#
-# I2C Hardware Sensors Chip support
-#
-# CONFIG_I2C_SENSOR is not set
-# CONFIG_SENSORS_ADM1021 is not set
-# CONFIG_SENSORS_EEPROM is not set
-# CONFIG_SENSORS_IT87 is not set
-# CONFIG_SENSORS_LM75 is not set
-# CONFIG_SENSORS_LM78 is not set
-# CONFIG_SENSORS_LM85 is not set
-# CONFIG_SENSORS_VIA686A is not set
-# CONFIG_SENSORS_W83781D is not set
-
-#
-# Mice
-#
-# CONFIG_BUSMOUSE is not set
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_QIC02_TAPE is not set
 
 #
@@ -477,6 +437,15 @@
 # CONFIG_RAW_DRIVER is not set
 
 #
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# Misc devices
+#
+
+#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -487,6 +456,26 @@
 # CONFIG_DVB is not set
 
 #
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+# CONFIG_USB is not set
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -520,6 +509,7 @@
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 # CONFIG_DEVFS_FS is not set
+# CONFIG_DEVPTS_FS_XATTR is not set
 CONFIG_TMPFS=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
@@ -530,6 +520,7 @@
 # CONFIG_ADFS_FS is not set
 # CONFIG_AFFS_FS is not set
 # CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
@@ -546,12 +537,13 @@
 CONFIG_NFS_FS=y
 # CONFIG_NFS_V3 is not set
 # CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 # CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
-# CONFIG_SUNRPC_GSS is not set
+# CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
@@ -566,19 +558,13 @@
 CONFIG_MSDOS_PARTITION=y
 
 #
-# Sound
+# Native Language Support
 #
-# CONFIG_SOUND is not set
+# CONFIG_NLS is not set
 
 #
 # IBM 40x options
 #
-
-#
-# USB support
-#
-# CONFIG_USB is not set
-# CONFIG_USB_GADGET is not set
 
 #
 # Library routines
diff -Nru a/arch/ppc/configs/ocotea_defconfig b/arch/ppc/configs/ocotea_defconfig
--- a/arch/ppc/configs/ocotea_defconfig	Wed May 12 09:24:59 2004
+++ b/arch/ppc/configs/ocotea_defconfig	Wed May 12 09:24:59 2004
@@ -6,6 +6,7 @@
 CONFIG_HAVE_DEC_LOCK=y
 CONFIG_PPC=y
 CONFIG_PPC32=y
+CONFIG_GENERIC_NVRAM=y
 
 #
 # Code maturity level options
@@ -23,14 +24,16 @@
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_HOTPLUG is not set
 # CONFIG_IKCONFIG is not set
-# CONFIG_EMBEDDED is not set
+CONFIG_EMBEDDED=y
 CONFIG_KALLSYMS=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 
 #
 # Loadable module support
@@ -63,9 +66,9 @@
 CONFIG_OCOTEA=y
 CONFIG_440GX=y
 CONFIG_440A=y
-CONFIG_PIN_TLB=y
 CONFIG_BOOKE=y
 CONFIG_IBM_OCP=y
+CONFIG_PPC_OCP=y
 CONFIG_IBM_EMAC4=y
 # CONFIG_PM is not set
 CONFIG_NOT_COHERENT_CACHE=y
@@ -90,12 +93,6 @@
 CONFIG_PCI_DOMAINS=y
 # CONFIG_PCI_LEGACY_PROC is not set
 # CONFIG_PCI_NAMES is not set
-# CONFIG_HOTPLUG is not set
-
-#
-# Parallel port support
-#
-# CONFIG_PARPORT is not set
 
 #
 # Advanced setup
@@ -112,8 +109,13 @@
 CONFIG_BOOT_LOAD=0x01000000
 
 #
+# Device Drivers
+#
+
+#
 # Generic Driver Options
 #
+# CONFIG_DEBUG_DRIVER is not set
 
 #
 # Memory Technology Devices (MTD)
@@ -121,29 +123,29 @@
 # CONFIG_MTD is not set
 
 #
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
 # Plug and Play support
 #
-# CONFIG_PNP is not set
 
 #
 # Block devices
 #
+# CONFIG_BLK_DEV_FD is not set
 # CONFIG_BLK_CPQ_DA is not set
 # CONFIG_BLK_CPQ_CISS_DA is not set
 # CONFIG_BLK_DEV_DAC960 is not set
 # CONFIG_BLK_DEV_UMEM is not set
 # CONFIG_BLK_DEV_LOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_CARMEL is not set
 # CONFIG_BLK_DEV_RAM is not set
-# CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_LBD is not set
 
 #
-# Multi-device support (RAID and LVM)
-#
-# CONFIG_MD is not set
-
-#
 # ATA/ATAPI/MFM/RLL support
 #
 # CONFIG_IDE is not set
@@ -154,11 +156,17 @@
 # CONFIG_SCSI is not set
 
 #
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
 # Fusion MPT device support
 #
+# CONFIG_FUSION is not set
 
 #
-# IEEE 1394 (FireWire) support (EXPERIMENTAL)
+# IEEE 1394 (FireWire) support
 #
 # CONFIG_IEEE1394 is not set
 
@@ -168,6 +176,10 @@
 # CONFIG_I2O is not set
 
 #
+# Macintosh device drivers
+#
+
+#
 # Networking support
 #
 CONFIG_NET=y
@@ -190,7 +202,6 @@
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
 # CONFIG_ARPD is not set
-# CONFIG_INET_ECN is not set
 # CONFIG_SYN_COOKIES is not set
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
@@ -219,7 +230,6 @@
 #
 # SCTP Configuration (EXPERIMENTAL)
 #
-CONFIG_IPV6_SCTP__=y
 # CONFIG_IP_SCTP is not set
 # CONFIG_ATM is not set
 # CONFIG_VLAN_8021Q is not set
@@ -289,6 +299,12 @@
 # Ethernet (10000 Mbit)
 #
 # CONFIG_IXGB is not set
+CONFIG_IBM_EMAC=y
+# CONFIG_IBM_EMAC_ERRMSG is not set
+CONFIG_IBM_EMAC_RXB=128
+CONFIG_IBM_EMAC_TXB=128
+CONFIG_IBM_EMAC_FGAP=8
+CONFIG_IBM_EMAC_SKBRES=0
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
 # CONFIG_PPP is not set
@@ -305,6 +321,7 @@
 # CONFIG_TR is not set
 # CONFIG_RCPCI is not set
 # CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
 
 #
 # Wan interfaces
@@ -325,23 +342,18 @@
 # Bluetooth support
 #
 # CONFIG_BT is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
 
 #
 # ISDN subsystem
 #
-# CONFIG_ISDN_BOOL is not set
-
-#
-# Graphics support
-#
-# CONFIG_FB is not set
+# CONFIG_ISDN is not set
 
 #
-# Console display driver support
+# Telephony Support
 #
-CONFIG_VGA_CONSOLE=y
-# CONFIG_MDA_CONSOLE is not set
-CONFIG_DUMMY_CONSOLE=y
+# CONFIG_PHONE is not set
 
 #
 # Input device support
@@ -381,15 +393,9 @@
 # CONFIG_INPUT_MISC is not set
 
 #
-# Macintosh device drivers
-#
-
-#
 # Character devices
 #
-CONFIG_VT=y
-CONFIG_VT_CONSOLE=y
-CONFIG_HW_CONSOLE=y
+# CONFIG_VT is not set
 # CONFIG_SERIAL_NONSTANDARD is not set
 
 #
@@ -411,30 +417,8 @@
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
-CONFIG_UNIX98_PTY_COUNT=256
-
-#
-# I2C support
-#
-# CONFIG_I2C is not set
-
-#
-# I2C Algorithms
-#
-
-#
-# I2C Hardware Bus support
-#
-
-#
-# I2C Hardware Sensors Chip support
-#
-# CONFIG_I2C_SENSOR is not set
-
-#
-# Mice
-#
-# CONFIG_BUSMOUSE is not set
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_QIC02_TAPE is not set
 
 #
@@ -461,6 +445,15 @@
 # CONFIG_RAW_DRIVER is not set
 
 #
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# Misc devices
+#
+
+#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -471,6 +464,26 @@
 # CONFIG_DVB is not set
 
 #
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+# CONFIG_USB is not set
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
 # File systems
 #
 # CONFIG_EXT2_FS is not set
@@ -503,7 +516,6 @@
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 # CONFIG_DEVFS_FS is not set
-CONFIG_DEVPTS_FS=y
 # CONFIG_DEVPTS_FS_XATTR is not set
 # CONFIG_TMPFS is not set
 # CONFIG_HUGETLB_PAGE is not set
@@ -515,6 +527,7 @@
 # CONFIG_ADFS_FS is not set
 # CONFIG_AFFS_FS is not set
 # CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
@@ -531,12 +544,13 @@
 CONFIG_NFS_FS=y
 # CONFIG_NFS_V3 is not set
 # CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 # CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
-# CONFIG_SUNRPC_GSS is not set
+# CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
@@ -551,15 +565,9 @@
 CONFIG_MSDOS_PARTITION=y
 
 #
-# Sound
+# Native Language Support
 #
-# CONFIG_SOUND is not set
-
-#
-# USB support
-#
-# CONFIG_USB is not set
-# CONFIG_USB_GADGET is not set
+# CONFIG_NLS is not set
 
 #
 # Library routines
diff -Nru a/arch/ppc/configs/redwood5_defconfig b/arch/ppc/configs/redwood5_defconfig
--- a/arch/ppc/configs/redwood5_defconfig	Wed May 12 09:24:59 2004
+++ b/arch/ppc/configs/redwood5_defconfig	Wed May 12 09:24:59 2004
@@ -6,6 +6,7 @@
 CONFIG_HAVE_DEC_LOCK=y
 CONFIG_PPC=y
 CONFIG_PPC32=y
+CONFIG_GENERIC_NVRAM=y
 
 #
 # Code maturity level options
@@ -23,6 +24,7 @@
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_HOTPLUG is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_EMBEDDED=y
 # CONFIG_KALLSYMS is not set
@@ -31,6 +33,7 @@
 CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 
 #
 # Loadable module support
@@ -59,23 +62,19 @@
 # IBM 4xx options
 #
 # CONFIG_ASH is not set
-# CONFIG_BEECH is not set
-# CONFIG_CEDAR is not set
 # CONFIG_CPCI405 is not set
 # CONFIG_EP405 is not set
 # CONFIG_OAK is not set
-# CONFIG_REDWOOD_4 is not set
 CONFIG_REDWOOD_5=y
 # CONFIG_REDWOOD_6 is not set
 # CONFIG_SYCAMORE is not set
-# CONFIG_TIVO is not set
 # CONFIG_WALNUT is not set
 CONFIG_IBM405_ERR77=y
 CONFIG_IBM405_ERR51=y
 CONFIG_IBM_OCP=y
+CONFIG_PPC_OCP=y
 CONFIG_STB03xxx=y
 CONFIG_IBM_OPENBIOS=y
-# CONFIG_405_DMA is not set
 # CONFIG_PM is not set
 CONFIG_UART0_TTYS0=y
 # CONFIG_UART0_TTYS1 is not set
@@ -92,19 +91,14 @@
 CONFIG_KERNEL_ELF=y
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-# CONFIG_CMDLINE_BOOL is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="ip=on"
 
 #
 # Bus options
 #
 # CONFIG_PCI is not set
 # CONFIG_PCI_DOMAINS is not set
-# CONFIG_HOTPLUG is not set
-
-#
-# Parallel port support
-#
-# CONFIG_PARPORT is not set
 
 #
 # Advanced setup
@@ -121,6 +115,10 @@
 CONFIG_BOOT_LOAD=0x00400000
 
 #
+# Device Drivers
+#
+
+#
 # Generic Driver Options
 #
 
@@ -130,13 +128,18 @@
 # CONFIG_MTD is not set
 
 #
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
 # Plug and Play support
 #
-# CONFIG_PNP is not set
 
 #
 # Block devices
 #
+# CONFIG_BLK_DEV_FD is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
@@ -146,11 +149,6 @@
 # CONFIG_LBD is not set
 
 #
-# Multi-device support (RAID and LVM)
-#
-# CONFIG_MD is not set
-
-#
 # ATA/ATAPI/MFM/RLL support
 #
 CONFIG_IDE=y
@@ -171,6 +169,7 @@
 #
 # IDE chipset support/bugfixes
 #
+CONFIG_IDE_GENERIC=y
 # CONFIG_BLK_DEV_IDEDMA is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_BLK_DEV_HD is not set
@@ -181,14 +180,28 @@
 # CONFIG_SCSI is not set
 
 #
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
 # Fusion MPT device support
 #
 
 #
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_IEEE1394 is not set
+
+#
 # I2O device support
 #
 
 #
+# Macintosh device drivers
+#
+
+#
 # Networking support
 #
 CONFIG_NET=y
@@ -211,7 +224,6 @@
 # CONFIG_NET_IPGRE is not set
 # CONFIG_IP_MROUTE is not set
 # CONFIG_ARPD is not set
-# CONFIG_INET_ECN is not set
 CONFIG_SYN_COOKIES=y
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
@@ -224,7 +236,6 @@
 #
 # SCTP Configuration (EXPERIMENTAL)
 #
-CONFIG_IPV6_SCTP__=y
 # CONFIG_IP_SCTP is not set
 # CONFIG_ATM is not set
 # CONFIG_VLAN_8021Q is not set
@@ -268,6 +279,7 @@
 #
 # Ethernet (10000 Mbit)
 #
+# CONFIG_IBM_EMAC is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
 
@@ -280,6 +292,7 @@
 # Token Ring devices
 #
 # CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
 
 #
 # Wan interfaces
@@ -300,16 +313,18 @@
 # Bluetooth support
 #
 # CONFIG_BT is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
 
 #
 # ISDN subsystem
 #
-# CONFIG_ISDN_BOOL is not set
+# CONFIG_ISDN is not set
 
 #
-# Graphics support
+# Telephony Support
 #
-# CONFIG_FB is not set
+# CONFIG_PHONE is not set
 
 #
 # Input device support
@@ -345,10 +360,6 @@
 # CONFIG_INPUT_MISC is not set
 
 #
-# Macintosh device drivers
-#
-
-#
 # Character devices
 #
 # CONFIG_VT is not set
@@ -368,43 +379,8 @@
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_UNIX98_PTYS is not set
-
-#
-# I2C support
-#
-CONFIG_I2C=y
-# CONFIG_I2C_CHARDEV is not set
-
-#
-# I2C Algorithms
-#
-# CONFIG_I2C_ALGOBIT is not set
-# CONFIG_I2C_ALGOPCF is not set
-
-#
-# I2C Hardware Bus support
-#
-# CONFIG_I2C_AMD756 is not set
-# CONFIG_I2C_AMD8111 is not set
-CONFIG_I2C_IBM_IIC=y
-
-#
-# I2C Hardware Sensors Chip support
-#
-# CONFIG_I2C_SENSOR is not set
-# CONFIG_SENSORS_ADM1021 is not set
-# CONFIG_SENSORS_EEPROM is not set
-# CONFIG_SENSORS_IT87 is not set
-# CONFIG_SENSORS_LM75 is not set
-# CONFIG_SENSORS_LM78 is not set
-# CONFIG_SENSORS_LM85 is not set
-# CONFIG_SENSORS_VIA686A is not set
-# CONFIG_SENSORS_W83781D is not set
-
-#
-# Mice
-#
-# CONFIG_BUSMOUSE is not set
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_QIC02_TAPE is not set
 
 #
@@ -432,6 +408,15 @@
 # CONFIG_RAW_DRIVER is not set
 
 #
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# Misc devices
+#
+
+#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -442,6 +427,25 @@
 # CONFIG_DVB is not set
 
 #
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -485,6 +489,7 @@
 # CONFIG_ADFS_FS is not set
 # CONFIG_AFFS_FS is not set
 # CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
@@ -501,12 +506,13 @@
 CONFIG_NFS_FS=y
 # CONFIG_NFS_V3 is not set
 # CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 # CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
-# CONFIG_SUNRPC_GSS is not set
+# CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
@@ -521,18 +527,13 @@
 CONFIG_MSDOS_PARTITION=y
 
 #
-# Sound
+# Native Language Support
 #
-# CONFIG_SOUND is not set
+# CONFIG_NLS is not set
 
 #
 # IBM 40x options
 #
-
-#
-# USB support
-#
-# CONFIG_USB_GADGET is not set
 
 #
 # Library routines
diff -Nru a/arch/ppc/configs/redwood6_defconfig b/arch/ppc/configs/redwood6_defconfig
--- a/arch/ppc/configs/redwood6_defconfig	Wed May 12 09:24:59 2004
+++ b/arch/ppc/configs/redwood6_defconfig	Wed May 12 09:24:59 2004
@@ -6,6 +6,7 @@
 CONFIG_HAVE_DEC_LOCK=y
 CONFIG_PPC=y
 CONFIG_PPC32=y
+CONFIG_GENERIC_NVRAM=y
 
 #
 # Code maturity level options
@@ -23,6 +24,7 @@
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_HOTPLUG is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_EMBEDDED=y
 # CONFIG_KALLSYMS is not set
@@ -31,6 +33,7 @@
 CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 
 #
 # Loadable module support
@@ -58,23 +61,19 @@
 # IBM 4xx options
 #
 # CONFIG_ASH is not set
-# CONFIG_BEECH is not set
-# CONFIG_CEDAR is not set
 # CONFIG_CPCI405 is not set
 # CONFIG_EP405 is not set
 # CONFIG_OAK is not set
-# CONFIG_REDWOOD_4 is not set
 # CONFIG_REDWOOD_5 is not set
 CONFIG_REDWOOD_6=y
 # CONFIG_SYCAMORE is not set
-# CONFIG_TIVO is not set
 # CONFIG_WALNUT is not set
 CONFIG_IBM405_ERR77=y
 CONFIG_IBM405_ERR51=y
 CONFIG_IBM_OCP=y
+CONFIG_PPC_OCP=y
 CONFIG_STB03xxx=y
 CONFIG_IBM_OPENBIOS=y
-# CONFIG_405_DMA is not set
 # CONFIG_PM is not set
 CONFIG_UART0_TTYS0=y
 # CONFIG_UART0_TTYS1 is not set
@@ -91,19 +90,14 @@
 CONFIG_KERNEL_ELF=y
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-# CONFIG_CMDLINE_BOOL is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="ip=on"
 
 #
 # Bus options
 #
 # CONFIG_PCI is not set
 # CONFIG_PCI_DOMAINS is not set
-# CONFIG_HOTPLUG is not set
-
-#
-# Parallel port support
-#
-# CONFIG_PARPORT is not set
 
 #
 # Advanced setup
@@ -120,6 +114,10 @@
 CONFIG_BOOT_LOAD=0x00400000
 
 #
+# Device Drivers
+#
+
+#
 # Generic Driver Options
 #
 
@@ -129,13 +127,18 @@
 # CONFIG_MTD is not set
 
 #
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
 # Plug and Play support
 #
-# CONFIG_PNP is not set
 
 #
 # Block devices
 #
+# CONFIG_BLK_DEV_FD is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
@@ -145,11 +148,6 @@
 # CONFIG_LBD is not set
 
 #
-# Multi-device support (RAID and LVM)
-#
-# CONFIG_MD is not set
-
-#
 # ATA/ATAPI/MFM/RLL support
 #
 # CONFIG_IDE is not set
@@ -160,14 +158,28 @@
 # CONFIG_SCSI is not set
 
 #
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
 # Fusion MPT device support
 #
 
 #
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_IEEE1394 is not set
+
+#
 # I2O device support
 #
 
 #
+# Macintosh device drivers
+#
+
+#
 # Networking support
 #
 CONFIG_NET=y
@@ -190,7 +202,6 @@
 # CONFIG_NET_IPGRE is not set
 # CONFIG_IP_MROUTE is not set
 # CONFIG_ARPD is not set
-# CONFIG_INET_ECN is not set
 CONFIG_SYN_COOKIES=y
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
@@ -203,7 +214,6 @@
 #
 # SCTP Configuration (EXPERIMENTAL)
 #
-CONFIG_IPV6_SCTP__=y
 # CONFIG_IP_SCTP is not set
 # CONFIG_ATM is not set
 # CONFIG_VLAN_8021Q is not set
@@ -247,6 +257,7 @@
 #
 # Ethernet (10000 Mbit)
 #
+# CONFIG_IBM_EMAC is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
 
@@ -259,6 +270,7 @@
 # Token Ring devices
 #
 # CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
 
 #
 # Wan interfaces
@@ -279,16 +291,18 @@
 # Bluetooth support
 #
 # CONFIG_BT is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
 
 #
 # ISDN subsystem
 #
-# CONFIG_ISDN_BOOL is not set
+# CONFIG_ISDN is not set
 
 #
-# Graphics support
+# Telephony Support
 #
-# CONFIG_FB is not set
+# CONFIG_PHONE is not set
 
 #
 # Input device support
@@ -324,10 +338,6 @@
 # CONFIG_INPUT_MISC is not set
 
 #
-# Macintosh device drivers
-#
-
-#
 # Character devices
 #
 # CONFIG_VT is not set
@@ -347,30 +357,8 @@
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
-CONFIG_UNIX98_PTY_COUNT=256
-
-#
-# I2C support
-#
-# CONFIG_I2C is not set
-
-#
-# I2C Algorithms
-#
-
-#
-# I2C Hardware Bus support
-#
-
-#
-# I2C Hardware Sensors Chip support
-#
-# CONFIG_I2C_SENSOR is not set
-
-#
-# Mice
-#
-# CONFIG_BUSMOUSE is not set
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_QIC02_TAPE is not set
 
 #
@@ -397,6 +385,15 @@
 # CONFIG_RAW_DRIVER is not set
 
 #
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# Misc devices
+#
+
+#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -407,6 +404,25 @@
 # CONFIG_DVB is not set
 
 #
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -440,7 +456,6 @@
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 # CONFIG_DEVFS_FS is not set
-CONFIG_DEVPTS_FS=y
 # CONFIG_DEVPTS_FS_XATTR is not set
 CONFIG_TMPFS=y
 # CONFIG_HUGETLB_PAGE is not set
@@ -452,6 +467,7 @@
 # CONFIG_ADFS_FS is not set
 # CONFIG_AFFS_FS is not set
 # CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
@@ -468,12 +484,13 @@
 CONFIG_NFS_FS=y
 # CONFIG_NFS_V3 is not set
 # CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 # CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
-# CONFIG_SUNRPC_GSS is not set
+# CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
@@ -488,18 +505,13 @@
 CONFIG_MSDOS_PARTITION=y
 
 #
-# Sound
+# Native Language Support
 #
-# CONFIG_SOUND is not set
+# CONFIG_NLS is not set
 
 #
 # IBM 40x options
 #
-
-#
-# USB support
-#
-# CONFIG_USB_GADGET is not set
 
 #
 # Library routines
diff -Nru a/arch/ppc/configs/sycamore_defconfig b/arch/ppc/configs/sycamore_defconfig
--- a/arch/ppc/configs/sycamore_defconfig	Wed May 12 09:24:59 2004
+++ b/arch/ppc/configs/sycamore_defconfig	Wed May 12 09:24:59 2004
@@ -4,11 +4,17 @@
 CONFIG_MMU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_HAVE_DEC_LOCK=y
+CONFIG_PPC=y
+CONFIG_PPC32=y
+CONFIG_GENERIC_NVRAM=y
 
 #
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
+CONFIG_CLEAN_COMPILE=y
+CONFIG_STANDALONE=y
+CONFIG_BROKEN_ON_SMP=y
 
 #
 # General setup
@@ -18,9 +24,16 @@
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_HOTPLUG is not set
+# CONFIG_IKCONFIG is not set
 CONFIG_EMBEDDED=y
+# CONFIG_KALLSYMS is not set
 CONFIG_FUTEX=y
 # CONFIG_EPOLL is not set
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 
 #
 # Loadable module support
@@ -33,66 +46,60 @@
 CONFIG_KMOD=y
 
 #
-# Platform support
+# Processor
 #
-CONFIG_PPC=y
-CONFIG_PPC32=y
 # CONFIG_6xx is not set
 CONFIG_40x=y
+# CONFIG_44x is not set
 # CONFIG_POWER3 is not set
+# CONFIG_POWER4 is not set
 # CONFIG_8xx is not set
+# CONFIG_MATH_EMULATION is not set
+# CONFIG_CPU_FREQ is not set
 CONFIG_4xx=y
 
 #
 # IBM 4xx options
 #
 # CONFIG_ASH is not set
-# CONFIG_BEECH is not set
-# CONFIG_CEDAR is not set
 # CONFIG_CPCI405 is not set
 # CONFIG_EP405 is not set
+# CONFIG_EVB405EP is not set
 # CONFIG_OAK is not set
-# CONFIG_REDWOOD_4 is not set
 # CONFIG_REDWOOD_5 is not set
 # CONFIG_REDWOOD_6 is not set
 CONFIG_SYCAMORE=y
-# CONFIG_TIVO is not set
 # CONFIG_WALNUT is not set
-CONFIG_IBM405_ERR77=y
-CONFIG_IBM405_ERR51=y
 CONFIG_IBM_OCP=y
+CONFIG_PPC_OCP=y
 CONFIG_BIOS_FIXUP=y
+CONFIG_405GPR=y
 CONFIG_IBM_OPENBIOS=y
-# CONFIG_405_DMA is not set
-CONFIG_PM=y
+# CONFIG_PM is not set
 CONFIG_UART0_TTYS0=y
 # CONFIG_UART0_TTYS1 is not set
 CONFIG_NOT_COHERENT_CACHE=y
-# CONFIG_SMP is not set
-# CONFIG_PREEMPT is not set
-# CONFIG_MATH_EMULATION is not set
-# CONFIG_CPU_FREQ is not set
 
 #
-# General setup
+# Platform options
 #
-# CONFIG_HIGHMEM is not set
-CONFIG_PCI=y
-CONFIG_PCI_DOMAINS=y
 # CONFIG_PC_KEYBOARD is not set
-CONFIG_KCORE_ELF=y
-CONFIG_BINFMT_ELF=y
+# CONFIG_SMP is not set
+# CONFIG_PREEMPT is not set
+# CONFIG_HIGHMEM is not set
 CONFIG_KERNEL_ELF=y
+CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-# CONFIG_PCI_LEGACY_PROC is not set
-# CONFIG_PCI_NAMES is not set
-# CONFIG_HOTPLUG is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="ip=on"
 
 #
-# Parallel port support
+# Bus options
 #
-# CONFIG_PARPORT is not set
-# CONFIG_CMDLINE_BOOL is not set
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+# CONFIG_PCI_LEGACY_PROC is not set
+# CONFIG_PCI_NAMES is not set
 
 #
 # Advanced setup
@@ -109,14 +116,26 @@
 CONFIG_BOOT_LOAD=0x00400000
 
 #
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+
+#
 # Memory Technology Devices (MTD)
 #
 # CONFIG_MTD is not set
 
 #
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
 # Plug and Play support
 #
-# CONFIG_PNP is not set
 
 #
 # Block devices
@@ -127,32 +146,36 @@
 # CONFIG_BLK_DEV_DAC960 is not set
 # CONFIG_BLK_DEV_UMEM is not set
 CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_CARMEL is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
+# CONFIG_LBD is not set
 
 #
-# Multi-device support (RAID and LVM)
+# ATA/ATAPI/MFM/RLL support
 #
-# CONFIG_MD is not set
+# CONFIG_IDE is not set
 
 #
-# ATA/IDE/MFM/RLL support
+# SCSI device support
 #
-# CONFIG_IDE is not set
+# CONFIG_SCSI is not set
 
 #
-# SCSI support
+# Multi-device support (RAID and LVM)
 #
-# CONFIG_SCSI is not set
+# CONFIG_MD is not set
 
 #
 # Fusion MPT device support
 #
+# CONFIG_FUSION is not set
 
 #
-# IEEE 1394 (FireWire) support (EXPERIMENTAL)
+# IEEE 1394 (FireWire) support
 #
 # CONFIG_IEEE1394 is not set
 
@@ -162,6 +185,10 @@
 # CONFIG_I2O is not set
 
 #
+# Macintosh device drivers
+#
+
+#
 # Networking support
 #
 CONFIG_NET=y
@@ -171,7 +198,6 @@
 #
 # CONFIG_PACKET is not set
 # CONFIG_NETLINK_DEV is not set
-# CONFIG_NETFILTER is not set
 CONFIG_UNIX=y
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
@@ -180,29 +206,29 @@
 CONFIG_IP_PNP=y
 # CONFIG_IP_PNP_DHCP is not set
 CONFIG_IP_PNP_BOOTP=y
-CONFIG_IP_PNP_RARP=y
+# CONFIG_IP_PNP_RARP is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
 # CONFIG_IP_MROUTE is not set
 # CONFIG_ARPD is not set
-# CONFIG_INET_ECN is not set
 CONFIG_SYN_COOKIES=y
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_IPV6 is not set
-# CONFIG_XFRM_USER is not set
+# CONFIG_DECNET is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_NETFILTER is not set
 
 #
 # SCTP Configuration (EXPERIMENTAL)
 #
-CONFIG_IPV6_SCTP__=y
 # CONFIG_IP_SCTP is not set
 # CONFIG_ATM is not set
 # CONFIG_VLAN_8021Q is not set
-# CONFIG_LLC is not set
-# CONFIG_DECNET is not set
-# CONFIG_BRIDGE is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
 # CONFIG_NET_DIVERT is not set
@@ -230,7 +256,6 @@
 # CONFIG_BONDING is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
-# CONFIG_ETHERTAP is not set
 
 #
 # Ethernet (10 or 100Mbit)
@@ -259,6 +284,7 @@
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
 # CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
 # CONFIG_SK98LIN is not set
 # CONFIG_TIGON3 is not set
 
@@ -266,6 +292,12 @@
 # Ethernet (10000 Mbit)
 #
 # CONFIG_IXGB is not set
+CONFIG_IBM_EMAC=y
+# CONFIG_IBM_EMAC_ERRMSG is not set
+CONFIG_IBM_EMAC_RXB=64
+CONFIG_IBM_EMAC_TXB=8
+CONFIG_IBM_EMAC_FGAP=8
+CONFIG_IBM_EMAC_SKBRES=0
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
 # CONFIG_PPP is not set
@@ -277,10 +309,12 @@
 # CONFIG_NET_RADIO is not set
 
 #
-# Token Ring devices (depends on LLC=y)
+# Token Ring devices
 #
+# CONFIG_TR is not set
 # CONFIG_RCPCI is not set
 # CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
 
 #
 # Wan interfaces
@@ -298,28 +332,38 @@
 # CONFIG_IRDA is not set
 
 #
-# ISDN subsystem
+# Bluetooth support
 #
-# CONFIG_ISDN_BOOL is not set
+# CONFIG_BT is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
 
 #
-# Graphics support
+# ISDN subsystem
 #
-# CONFIG_FB is not set
+# CONFIG_ISDN is not set
 
 #
-# Old CD-ROM drivers (not SCSI, not IDE)
+# Telephony Support
 #
-# CONFIG_CD_NO_IDESCSI is not set
+# CONFIG_PHONE is not set
 
 #
 # Input device support
 #
-# CONFIG_INPUT is not set
+CONFIG_INPUT=y
 
 #
 # Userland interfaces
 #
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_PSAUX=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
 
 #
 # Input I/O drivers
@@ -330,18 +374,29 @@
 CONFIG_SERIO_I8042=y
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_PCIPS2 is not set
 
 #
 # Input Device Drivers
 #
-
-#
-# Macintosh device drivers
-#
+CONFIG_INPUT_KEYBOARD=y
+CONFIG_KEYBOARD_ATKBD=y
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_LKKBD is not set
+# CONFIG_KEYBOARD_XTKBD is not set
+# CONFIG_KEYBOARD_NEWTON is not set
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_PS2=y
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_VSXXXAA is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
 
 #
 # Character devices
 #
+# CONFIG_VT is not set
 # CONFIG_SERIAL_NONSTANDARD is not set
 
 #
@@ -349,6 +404,7 @@
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=4
 # CONFIG_SERIAL_8250_EXTENDED is not set
 
 #
@@ -357,79 +413,132 @@
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
-CONFIG_UNIX98_PTY_COUNT=256
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+# CONFIG_QIC02_TAPE is not set
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+# CONFIG_NVRAM is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_FTAPE is not set
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+# CONFIG_RAW_DRIVER is not set
 
 #
 # I2C support
 #
 CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+
+#
+# I2C Algorithms
+#
 # CONFIG_I2C_ALGOBIT is not set
 # CONFIG_I2C_ALGOPCF is not set
-CONFIG_I2C_IBM_OCP_ALGO=y
-CONFIG_I2C_IBM_OCP_ADAP=y
-CONFIG_I2C_CHARDEV=y
 
 #
-# I2C Hardware Sensors Mainboard support
+# I2C Hardware Bus support
 #
+# CONFIG_I2C_ALI1535 is not set
 # CONFIG_I2C_ALI15X3 is not set
 # CONFIG_I2C_AMD756 is not set
 # CONFIG_I2C_AMD8111 is not set
 # CONFIG_I2C_I801 is not set
+# CONFIG_I2C_I810 is not set
+# CONFIG_I2C_IBM_IIC is not set
+# CONFIG_I2C_ISA is not set
+# CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_PIIX4 is not set
+# CONFIG_I2C_PROSAVAGE is not set
+# CONFIG_I2C_SAVAGE4 is not set
+# CONFIG_SCx200_ACB is not set
+# CONFIG_I2C_SIS5595 is not set
+# CONFIG_I2C_SIS630 is not set
 # CONFIG_I2C_SIS96X is not set
+# CONFIG_I2C_VIA is not set
 # CONFIG_I2C_VIAPRO is not set
+# CONFIG_I2C_VOODOO3 is not set
 
 #
-# I2C Hardware Sensors Chip support
+# Hardware Sensors Chip support
 #
+# CONFIG_I2C_SENSOR is not set
 # CONFIG_SENSORS_ADM1021 is not set
+# CONFIG_SENSORS_ASB100 is not set
+# CONFIG_SENSORS_DS1621 is not set
+# CONFIG_SENSORS_FSCHER is not set
+# CONFIG_SENSORS_GL518SM is not set
 # CONFIG_SENSORS_IT87 is not set
 # CONFIG_SENSORS_LM75 is not set
+# CONFIG_SENSORS_LM78 is not set
+# CONFIG_SENSORS_LM80 is not set
+# CONFIG_SENSORS_LM83 is not set
 # CONFIG_SENSORS_LM85 is not set
+# CONFIG_SENSORS_LM90 is not set
 # CONFIG_SENSORS_VIA686A is not set
 # CONFIG_SENSORS_W83781D is not set
-# CONFIG_I2C_SENSOR is not set
+# CONFIG_SENSORS_W83L785TS is not set
+# CONFIG_SENSORS_W83627HF is not set
 
 #
-# Mice
+# Other I2C Chip support
 #
-# CONFIG_BUSMOUSE is not set
-# CONFIG_QIC02_TAPE is not set
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
 
 #
-# IPMI
+# Misc devices
 #
-# CONFIG_IPMI_HANDLER is not set
 
 #
-# Watchdog Cards
+# Multimedia devices
 #
-# CONFIG_WATCHDOG is not set
-# CONFIG_NVRAM is not set
-# CONFIG_GEN_RTC is not set
-# CONFIG_DTLK is not set
-# CONFIG_R3964 is not set
-# CONFIG_APPLICOM is not set
+# CONFIG_VIDEO_DEV is not set
 
 #
-# Ftape, the floppy tape device driver
+# Digital Video Broadcasting Devices
 #
-# CONFIG_FTAPE is not set
-# CONFIG_AGP is not set
-# CONFIG_DRM is not set
-# CONFIG_RAW_DRIVER is not set
-# CONFIG_HANGCHECK_TIMER is not set
+# CONFIG_DVB is not set
 
 #
-# Multimedia devices
+# Graphics support
 #
-# CONFIG_VIDEO_DEV is not set
+# CONFIG_FB is not set
 
 #
-# Digital Video Broadcasting Devices
+# Sound
 #
-# CONFIG_DVB is not set
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+# CONFIG_USB is not set
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
 
 #
 # File systems
@@ -463,10 +572,11 @@
 # Pseudo filesystems
 #
 CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
 # CONFIG_DEVFS_FS is not set
-CONFIG_DEVPTS_FS=y
 # CONFIG_DEVPTS_FS_XATTR is not set
 CONFIG_TMPFS=y
+# CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 
 #
@@ -475,6 +585,7 @@
 # CONFIG_ADFS_FS is not set
 # CONFIG_AFFS_FS is not set
 # CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
@@ -491,12 +602,13 @@
 CONFIG_NFS_FS=y
 # CONFIG_NFS_V3 is not set
 # CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 # CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
-# CONFIG_SUNRPC_GSS is not set
+# CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
@@ -522,35 +634,23 @@
 # CONFIG_EFI_PARTITION is not set
 
 #
-# Sound
+# Native Language Support
 #
-# CONFIG_SOUND is not set
+# CONFIG_NLS is not set
 
 #
 # IBM 40x options
 #
 
 #
-# USB support
-#
-# CONFIG_USB is not set
-# CONFIG_USB_GADGET is not set
-
-#
-# Bluetooth support
-#
-# CONFIG_BT is not set
-
-#
 # Library routines
 #
-# CONFIG_CRC32 is not set
+CONFIG_CRC32=y
 
 #
 # Kernel hacking
 #
 # CONFIG_DEBUG_KERNEL is not set
-# CONFIG_KALLSYMS is not set
 # CONFIG_SERIAL_TEXT_DEBUG is not set
 CONFIG_OCP=y
 
diff -Nru a/arch/ppc/configs/walnut_defconfig b/arch/ppc/configs/walnut_defconfig
--- a/arch/ppc/configs/walnut_defconfig	Wed May 12 09:24:59 2004
+++ b/arch/ppc/configs/walnut_defconfig	Wed May 12 09:24:59 2004
@@ -64,6 +64,7 @@
 # CONFIG_ASH is not set
 # CONFIG_CPCI405 is not set
 # CONFIG_EP405 is not set
+# CONFIG_EVB405EP is not set
 # CONFIG_OAK is not set
 # CONFIG_REDWOOD_5 is not set
 # CONFIG_REDWOOD_6 is not set
@@ -91,7 +92,8 @@
 CONFIG_KERNEL_ELF=y
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-# CONFIG_CMDLINE_BOOL is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="ip=on"
 
 #
 # Bus options
@@ -204,9 +206,9 @@
 CONFIG_IP_MULTICAST=y
 # CONFIG_IP_ADVANCED_ROUTER is not set
 CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
+# CONFIG_IP_PNP_DHCP is not set
 CONFIG_IP_PNP_BOOTP=y
-CONFIG_IP_PNP_RARP=y
+# CONFIG_IP_PNP_RARP is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
 # CONFIG_IP_MROUTE is not set
@@ -292,6 +294,12 @@
 # Ethernet (10000 Mbit)
 #
 # CONFIG_IXGB is not set
+CONFIG_IBM_EMAC=y
+# CONFIG_IBM_EMAC_ERRMSG is not set
+CONFIG_IBM_EMAC_RXB=64
+CONFIG_IBM_EMAC_TXB=8
+CONFIG_IBM_EMAC_FGAP=8
+CONFIG_IBM_EMAC_SKBRES=0
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
 # CONFIG_PPP is not set
