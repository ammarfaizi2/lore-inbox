Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbUC1Uqi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 15:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUC1Upj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 15:45:39 -0500
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:33729 "HELO
	trinity-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S262073AbUC1Ulv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 15:41:51 -0500
X-qfilter-stat: ok
X-Analyze: Velop Mail Shield v0.0.4
Date: Sun, 28 Mar 2004 17:41:39 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.26-rc1
In-Reply-To: <m2r7vcss6a.fsf@p4.localdomain>
Message-ID: <Pine.LNX.4.58.0403281736000.6087@pervalidus.dyndns.org>
References: <20040328042608.GA17969@logos.cnet> <m2r7vcss6a.fsf@p4.localdomain>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Mar 2004, Peter Osterlund wrote:

> Marcelo Tosatti writes:
>
> > Sridhar Samudrala:
> >   o [SCTP] Avoid the use of hacking CONFIG_IPV6_SCTP__ option
> >
> > Please test!
>
> I get an error when selecting save and exit in "make xconfig":
>
>   ERROR - Attempting to write value for unconfigured variable (CONFIG_IP_SCTP).

Here oldconfig returned:

-CONFIG_IPV6_SCTP__=y
 # CONFIG_IP_SCTP is not set
-# CONFIG_SCTP_HMAC_NONE is not set
-CONFIG_SCTP_HMAC_SHA1=y
-# CONFIG_SCTP_HMAC_MD5 is not set
 # CONFIG_ATM is not set
 # CONFIG_VLAN_8021Q is not set

But I also get the above loading my .config and saving with
xconfig.

I also noticed that xconfig cleaned it a bit, what oldconfig
and menuconfig don't do:

--- .config.old	2004-03-28 17:37:19.000000000 -0300
+++ .config	2004-03-28 17:37:19.000000000 -0300
@@ -99,10 +99,6 @@
 # PCI Hotplug Support
 #
 # CONFIG_HOTPLUG_PCI is not set
-# CONFIG_HOTPLUG_PCI_COMPAQ is not set
-# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
-# CONFIG_HOTPLUG_PCI_IBM is not set
-# CONFIG_HOTPLUG_PCI_ACPI is not set
 CONFIG_SYSVIPC=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_SYSCTL=y
@@ -159,7 +155,6 @@
 # CONFIG_PARPORT_SERIAL is not set
 CONFIG_PARPORT_PC_FIFO=y
 # CONFIG_PARPORT_PC_SUPERIO is not set
-# CONFIG_PARPORT_PC_PCMCIA is not set
 # CONFIG_PARPORT_AMIGA is not set
 # CONFIG_PARPORT_MFC3 is not set
 # CONFIG_PARPORT_ATARI is not set
@@ -173,7 +168,6 @@
 # Plug and Play configuration
 #
 # CONFIG_PNP is not set
-# CONFIG_ISAPNP is not set

 #
 # Block devices
@@ -183,8 +177,6 @@
 # CONFIG_PARIDE is not set
 # CONFIG_BLK_CPQ_DA is not set
 # CONFIG_BLK_CPQ_CISS_DA is not set
-# CONFIG_CISS_SCSI_TAPE is not set
-# CONFIG_CISS_MONITOR_THREAD is not set
 # CONFIG_BLK_DEV_DAC960 is not set
 # CONFIG_BLK_DEV_UMEM is not set
 CONFIG_CDROM_PKTCDVD=m
@@ -192,20 +184,12 @@
 CONFIG_BLK_DEV_LOOP=m
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_RAM is not set
-# CONFIG_BLK_DEV_INITRD is not set
 CONFIG_BLK_STATS=y

 #
 # Multi-device support (RAID and LVM)
 #
 # CONFIG_MD is not set
-# CONFIG_BLK_DEV_MD is not set
-# CONFIG_MD_LINEAR is not set
-# CONFIG_MD_RAID0 is not set
-# CONFIG_MD_RAID1 is not set
-# CONFIG_MD_RAID5 is not set
-# CONFIG_MD_MULTIPATH is not set
-# CONFIG_BLK_DEV_LVM is not set

 #
 # Networking options
@@ -277,7 +261,11 @@
 #
 #    SCTP Configuration (EXPERIMENTAL)
 #
-# CONFIG_IP_SCTP is not set
+# CONFIG_SCTP_DBG_MSG is not set
+# CONFIG_SCTP_DBG_OBJCNT is not set
+# CONFIG_SCTP_HMAC_NONE is not set
+# CONFIG_SCTP_HMAC_SHA1 is not set
+CONFIG_SCTP_HMAC_MD5=y
 # CONFIG_ATM is not set
 # CONFIG_VLAN_8021Q is not set

@@ -290,7 +278,6 @@
 #
 # Appletalk devices
 #
-# CONFIG_DEV_APPLETALK is not set
 # CONFIG_DECNET is not set
 # CONFIG_BRIDGE is not set
 # CONFIG_X25 is not set
@@ -316,8 +303,6 @@
 # Telephony Support
 #
 # CONFIG_PHONE is not set
-# CONFIG_PHONE_IXJ is not set
-# CONFIG_PHONE_IXJ_PCMCIA is not set

 #
 # ATA/IDE/MFM/RLL support
@@ -337,7 +322,6 @@
 CONFIG_BLK_DEV_IDEDISK=y
 # CONFIG_IDEDISK_MULTI_MODE is not set
 # CONFIG_IDEDISK_STROKE is not set
-# CONFIG_BLK_DEV_IDECS is not set
 CONFIG_BLK_DEV_IDECD=m
 # CONFIG_BLK_DEV_IDETAPE is not set
 # CONFIG_BLK_DEV_IDEFLOPPY is not set
@@ -348,8 +332,6 @@
 # IDE chipset support/bugfixes
 #
 # CONFIG_BLK_DEV_CMD640 is not set
-# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
-# CONFIG_BLK_DEV_ISAPNP is not set
 CONFIG_BLK_DEV_IDEPCI=y
 # CONFIG_BLK_DEV_GENERIC is not set
 CONFIG_IDEPCI_SHARE_IRQ=y
@@ -363,21 +345,17 @@
 # CONFIG_BLK_DEV_ADMA100 is not set
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
-# CONFIG_WDC_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
-# CONFIG_AMD74XX_OVERRIDE is not set
 # CONFIG_BLK_DEV_CMD64X is not set
 # CONFIG_BLK_DEV_TRIFLEX is not set
 # CONFIG_BLK_DEV_CY82C693 is not set
 # CONFIG_BLK_DEV_CS5530 is not set
 # CONFIG_BLK_DEV_HPT34X is not set
-# CONFIG_HPT34X_AUTODMA is not set
 # CONFIG_BLK_DEV_HPT366 is not set
 # CONFIG_BLK_DEV_PIIX is not set
 # CONFIG_BLK_DEV_NS87415 is not set
 # CONFIG_BLK_DEV_OPTI621 is not set
 # CONFIG_BLK_DEV_PDC202XX_OLD is not set
-# CONFIG_PDC202XX_BURST is not set
 # CONFIG_BLK_DEV_PDC202XX_NEW is not set
 # CONFIG_BLK_DEV_RZ1000 is not set
 # CONFIG_BLK_DEV_SC1200 is not set
@@ -392,10 +370,6 @@
 CONFIG_IDEDMA_IVB=y
 # CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_ATARAID is not set
-# CONFIG_BLK_DEV_ATARAID_PDC is not set
-# CONFIG_BLK_DEV_ATARAID_HPT is not set
-# CONFIG_BLK_DEV_ATARAID_MEDLEY is not set
-# CONFIG_BLK_DEV_ATARAID_SII is not set

 #
 # SCSI support
@@ -496,11 +470,6 @@
 # I2O device support
 #
 # CONFIG_I2O is not set
-# CONFIG_I2O_PCI is not set
-# CONFIG_I2O_BLOCK is not set
-# CONFIG_I2O_LAN is not set
-# CONFIG_I2O_SCSI is not set
-# CONFIG_I2O_PROC is not set

 #
 # Network device support
@@ -521,10 +490,7 @@
 # Ethernet (10 or 100Mbit)
 #
 CONFIG_NET_ETHERNET=y
-# CONFIG_SUNLANCE is not set
 # CONFIG_HAPPYMEAL is not set
-# CONFIG_SUNBMAC is not set
-# CONFIG_SUNQE is not set
 # CONFIG_SUNGEM is not set
 CONFIG_NET_VENDOR_3COM=y
 # CONFIG_EL1 is not set
@@ -533,8 +499,6 @@
 # CONFIG_EL16 is not set
 # CONFIG_EL3 is not set
 # CONFIG_3C515 is not set
-# CONFIG_ELMC is not set
-# CONFIG_ELMC_II is not set
 CONFIG_VORTEX=m
 # CONFIG_TYPHOON is not set
 # CONFIG_LANCE is not set
@@ -557,15 +521,11 @@
 # CONFIG_DGRS is not set
 # CONFIG_DM9102 is not set
 # CONFIG_EEPRO100 is not set
-# CONFIG_EEPRO100_PIO is not set
 # CONFIG_E100 is not set
-# CONFIG_LNE390 is not set
 # CONFIG_FEALNX is not set
 # CONFIG_NATSEMI is not set
 # CONFIG_NE2K_PCI is not set
 # CONFIG_FORCEDETH is not set
-# CONFIG_NE3210 is not set
-# CONFIG_ES3210 is not set
 CONFIG_8139CP=m
 CONFIG_8139TOO=m
 # CONFIG_8139TOO_PIO is not set
@@ -575,10 +535,8 @@
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
 # CONFIG_SUNDANCE is not set
-# CONFIG_SUNDANCE_MMIO is not set
 # CONFIG_TLAN is not set
 # CONFIG_VIA_RHINE is not set
-# CONFIG_VIA_RHINE_MMIO is not set
 # CONFIG_WINBOND_840 is not set
 # CONFIG_NET_POCKET is not set

@@ -588,7 +546,6 @@
 # CONFIG_ACENIC is not set
 # CONFIG_DL2K is not set
 # CONFIG_E1000 is not set
-# CONFIG_MYRI_SBUS is not set
 # CONFIG_NS83820 is not set
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
@@ -698,7 +655,8 @@
 # CONFIG_I2C_PHILIPSPAR is not set
 # CONFIG_I2C_ELV is not set
 # CONFIG_I2C_VELLEMAN is not set
-# CONFIG_SCx200_I2C is not set
+CONFIG_SCx200_I2C_SCL=12
+CONFIG_SCx200_I2C_SDA=13
 # CONFIG_SCx200_ACB is not set
 # CONFIG_I2C_ALGOPCF is not set
 CONFIG_I2C_MAINBOARD=y
@@ -785,7 +743,6 @@
 # CONFIG_INPUT_CS461X is not set
 # CONFIG_INPUT_EMU10K1 is not set
 # CONFIG_INPUT_SERIO is not set
-# CONFIG_INPUT_SERPORT is not set

 #
 # Joysticks
@@ -800,28 +757,17 @@
 # CONFIG_INPUT_TMDC is not set
 # CONFIG_INPUT_SIDEWINDER is not set
 # CONFIG_INPUT_IFORCE_USB is not set
-# CONFIG_INPUT_IFORCE_232 is not set
-# CONFIG_INPUT_WARRIOR is not set
-# CONFIG_INPUT_MAGELLAN is not set
-# CONFIG_INPUT_SPACEORB is not set
-# CONFIG_INPUT_SPACEBALL is not set
-# CONFIG_INPUT_STINGER is not set
 # CONFIG_INPUT_DB9 is not set
 # CONFIG_INPUT_GAMECON is not set
 # CONFIG_INPUT_TURBOGRAFX is not set
 # CONFIG_QIC02_TAPE is not set
 # CONFIG_IPMI_HANDLER is not set
-# CONFIG_IPMI_PANIC_EVENT is not set
-# CONFIG_IPMI_DEVICE_INTERFACE is not set
-# CONFIG_IPMI_KCS is not set
-# CONFIG_IPMI_WATCHDOG is not set

 #
 # Watchdog Cards
 #
 # CONFIG_WATCHDOG is not set
 # CONFIG_SCx200 is not set
-# CONFIG_SCx200_GPIO is not set
 # CONFIG_AMD_RNG is not set
 # CONFIG_INTEL_RNG is not set
 # CONFIG_HW_RANDOM is not set
@@ -864,7 +810,6 @@
 # CONFIG_DRM_R128 is not set
 CONFIG_DRM_RADEON=m
 # CONFIG_DRM_I810 is not set
-# CONFIG_DRM_I810_XFREE_41 is not set
 # CONFIG_DRM_I830 is not set
 CONFIG_DRM_MGA=m
 # CONFIG_DRM_SIS is not set
@@ -895,11 +840,7 @@
 # CONFIG_TUNER_3036 is not set
 # CONFIG_VIDEO_STRADIS is not set
 # CONFIG_VIDEO_ZORAN is not set
-# CONFIG_VIDEO_ZORAN_BUZ is not set
-# CONFIG_VIDEO_ZORAN_DC10 is not set
-# CONFIG_VIDEO_ZORAN_LML33 is not set
 # CONFIG_VIDEO_ZR36120 is not set
-# CONFIG_VIDEO_MEYE is not set

 #
 # Radio Adapters
@@ -912,8 +853,6 @@
 # CONFIG_RADIO_GEMTEK_PCI is not set
 # CONFIG_RADIO_MAXIRADIO is not set
 # CONFIG_RADIO_MAESTRO is not set
-# CONFIG_RADIO_MIROPCM20 is not set
-# CONFIG_RADIO_MIROPCM20_RDS is not set
 # CONFIG_RADIO_SF16FMI is not set
 # CONFIG_RADIO_SF16FMR2 is not set
 # CONFIG_RADIO_TERRATEC is not set
@@ -925,30 +864,22 @@
 # File systems
 #
 # CONFIG_QUOTA is not set
-# CONFIG_QFMT_V2 is not set
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 # CONFIG_REISERFS_FS is not set
-# CONFIG_REISERFS_CHECK is not set
-# CONFIG_REISERFS_PROC_INFO is not set
 # CONFIG_ADFS_FS is not set
-# CONFIG_ADFS_FS_RW is not set
 # CONFIG_AFFS_FS is not set
 # CONFIG_HFS_FS is not set
 # CONFIG_HFSPLUS_FS is not set
 # CONFIG_BEFS_FS is not set
-# CONFIG_BEFS_DEBUG is not set
 # CONFIG_BFS_FS is not set
 CONFIG_EXT3_FS=y
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
 CONFIG_FAT_FS=y
 # CONFIG_MSDOS_FS is not set
-# CONFIG_UMSDOS_FS is not set
 CONFIG_VFAT_FS=m
 # CONFIG_EFS_FS is not set
-# CONFIG_JFFS_FS is not set
-# CONFIG_JFFS2_FS is not set
 # CONFIG_CRAMFS is not set
 CONFIG_TMPFS=y
 CONFIG_RAMFS=y
@@ -956,8 +887,6 @@
 CONFIG_JOLIET=y
 CONFIG_ZISOFS=y
 # CONFIG_JFS_FS is not set
-# CONFIG_JFS_DEBUG is not set
-# CONFIG_JFS_STATISTICS is not set
 CONFIG_MINIX_FS=m
 # CONFIG_VXFS_FS is not set
 CONFIG_NTFS_FS=m
@@ -970,7 +899,6 @@
 # CONFIG_DEVFS_DEBUG is not set
 # CONFIG_DEVPTS_FS is not set
 # CONFIG_QNX4FS_FS is not set
-# CONFIG_QNX4FS_RW is not set
 # CONFIG_ROMFS_FS is not set
 CONFIG_EXT2_FS=m
 # CONFIG_SYSV_FS is not set
@@ -979,10 +907,6 @@
 CONFIG_UFS_FS=m
 # CONFIG_UFS_FS_WRITE is not set
 # CONFIG_XFS_FS is not set
-# CONFIG_XFS_QUOTA is not set
-# CONFIG_XFS_RT is not set
-# CONFIG_XFS_TRACE is not set
-# CONFIG_XFS_DEBUG is not set

 #
 # Network File Systems
@@ -990,24 +914,11 @@
 # CONFIG_CODA_FS is not set
 # CONFIG_INTERMEZZO_FS is not set
 # CONFIG_NFS_FS is not set
-# CONFIG_NFS_V3 is not set
-# CONFIG_NFS_DIRECTIO is not set
-# CONFIG_ROOT_NFS is not set
 # CONFIG_NFSD is not set
-# CONFIG_NFSD_V3 is not set
-# CONFIG_NFSD_TCP is not set
 # CONFIG_SUNRPC is not set
 # CONFIG_LOCKD is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_NCP_FS is not set
-# CONFIG_NCPFS_PACKET_SIGNING is not set
-# CONFIG_NCPFS_IOCTL_LOCKING is not set
-# CONFIG_NCPFS_STRONG is not set
-# CONFIG_NCPFS_NFS_NS is not set
-# CONFIG_NCPFS_OS2_NS is not set
-# CONFIG_NCPFS_SMALLDOS is not set
-# CONFIG_NCPFS_NLS is not set
-# CONFIG_NCPFS_EXTRAS is not set
 CONFIG_ZISOFS_FS=m

 #
@@ -1102,7 +1013,6 @@
 CONFIG_FB_MATROX_G100A=y
 CONFIG_FB_MATROX_G100=y
 # CONFIG_FB_MATROX_I2C is not set
-# CONFIG_FB_MATROX_MAVEN is not set
 CONFIG_FB_MATROX_PROC=m
 # CONFIG_FB_MATROX_MULTIHEAD is not set
 # CONFIG_FB_ATY is not set
@@ -1161,7 +1071,6 @@
 CONFIG_SOUND_CMPCI_SPDIFLOOP=y
 CONFIG_SOUND_CMPCI_SPEAKERS=2
 # CONFIG_SOUND_EMU10K1 is not set
-# CONFIG_MIDI_EMU10K1 is not set
 # CONFIG_SOUND_FUSION is not set
 # CONFIG_SOUND_CS4281 is not set
 # CONFIG_SOUND_ES1370 is not set
@@ -1209,19 +1118,9 @@
 # USB Device Class drivers
 #
 # CONFIG_USB_AUDIO is not set
-# CONFIG_USB_EMI26 is not set
 # CONFIG_USB_BLUETOOTH is not set
 # CONFIG_USB_MIDI is not set
 # CONFIG_USB_STORAGE is not set
-# CONFIG_USB_STORAGE_DEBUG is not set
-# CONFIG_USB_STORAGE_DATAFAB is not set
-# CONFIG_USB_STORAGE_FREECOM is not set
-# CONFIG_USB_STORAGE_ISD200 is not set
-# CONFIG_USB_STORAGE_DPCM is not set
-# CONFIG_USB_STORAGE_HP8200e is not set
-# CONFIG_USB_STORAGE_SDDR09 is not set
-# CONFIG_USB_STORAGE_SDDR55 is not set
-# CONFIG_USB_STORAGE_JUMPSHOT is not set
 # CONFIG_USB_ACM is not set
 CONFIG_USB_PRINTER=m

-- 
http://www.pervalidus.net/contact.html
