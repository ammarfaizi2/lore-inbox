Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267190AbSLaH3Y>; Tue, 31 Dec 2002 02:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267192AbSLaH3Y>; Tue, 31 Dec 2002 02:29:24 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:31164 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267190AbSLaH3R>; Tue, 31 Dec 2002 02:29:17 -0500
Date: Tue, 31 Dec 2002 08:37:39 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [2.4.21-pre2] sync up defconfig
Message-ID: <20021231073739.GP21097@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let's wake up the 2.4 defconfig a litte.  Patch against 2.4.21-pre2.

diff -urN a/arch/i386/defconfig b/arch/i386/defconfig
--- a/arch/i386/defconfig	2002-11-29 10:39:57 +0100
+++ b/arch/i386/defconfig	2002-12-31 08:34:55 +0100
@@ -2,7 +2,6 @@
 # Automatically generated make config: don't edit
 #
 CONFIG_X86=y
-CONFIG_ISA=y
 # CONFIG_SBUS is not set
 CONFIG_UID16=y
 
@@ -46,10 +45,11 @@
 # CONFIG_RWSEM_GENERIC_SPINLOCK is not set
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_X86_L1_CACHE_SHIFT=5
-CONFIG_X86_TSC=y
+CONFIG_X86_HAS_TSC=y
 CONFIG_X86_GOOD_APIC=y
 CONFIG_X86_PGE=y
 CONFIG_X86_USE_PPRO_CHECKSUM=y
+CONFIG_X86_F00F_WORKS_OK=y
 CONFIG_X86_MCE=y
 # CONFIG_TOSHIBA is not set
 # CONFIG_I8K is not set
@@ -59,10 +59,13 @@
 CONFIG_NOHIGHMEM=y
 # CONFIG_HIGHMEM4G is not set
 # CONFIG_HIGHMEM64G is not set
+# CONFIG_HIGHMEM is not set
 # CONFIG_MATH_EMULATION is not set
 # CONFIG_MTRR is not set
 CONFIG_SMP=y
-# CONFIG_MULTIQUAD is not set
+# CONFIG_X86_NUMA is not set
+# CONFIG_X86_TSC_DISABLE is not set
+CONFIG_X86_TSC=y
 CONFIG_HAVE_DEC_LOCK=y
 
 #
@@ -77,6 +80,7 @@
 CONFIG_PCI_GOANY=y
 CONFIG_PCI_BIOS=y
 CONFIG_PCI_DIRECT=y
+CONFIG_ISA=y
 CONFIG_PCI_NAMES=y
 # CONFIG_EISA is not set
 # CONFIG_MCA is not set
@@ -141,6 +145,7 @@
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_RAM is not set
 # CONFIG_BLK_DEV_INITRD is not set
+# CONFIG_BLK_STATS is not set
 
 #
 # Multi-device support (RAID and LVM)
@@ -222,21 +227,13 @@
 CONFIG_BLK_DEV_IDEDISK=y
 CONFIG_IDEDISK_MULTI_MODE=y
 # CONFIG_IDEDISK_STROKE is not set
-# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
-# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
-# CONFIG_BLK_DEV_IDEDISK_IBM is not set
-# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
-# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
-# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
-# CONFIG_BLK_DEV_IDEDISK_WD is not set
-# CONFIG_BLK_DEV_COMMERIAL is not set
-# CONFIG_BLK_DEV_TIVO is not set
 # CONFIG_BLK_DEV_IDECS is not set
 CONFIG_BLK_DEV_IDECD=y
 # CONFIG_BLK_DEV_IDETAPE is not set
 # CONFIG_BLK_DEV_IDEFLOPPY is not set
 # CONFIG_BLK_DEV_IDESCSI is not set
 # CONFIG_IDE_TASK_IOCTL is not set
+CONFIG_IDE_TASKFILE_IO=y
 
 #
 # IDE chipset support/bugfixes
@@ -244,8 +241,8 @@
 CONFIG_BLK_DEV_CMD640=y
 # CONFIG_BLK_DEV_CMD640_ENHANCED is not set
 # CONFIG_BLK_DEV_ISAPNP is not set
-CONFIG_BLK_DEV_RZ1000=y
 CONFIG_BLK_DEV_IDEPCI=y
+CONFIG_BLK_DEV_GENERIC=y
 CONFIG_IDEPCI_SHARE_IRQ=y
 CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
@@ -254,30 +251,30 @@
 # CONFIG_IDEDMA_ONLYDISK is not set
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_PCI_WIP is not set
-# CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
-# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
 CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
-# CONFIG_AEC62XX_TUNING is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_WDC_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
 # CONFIG_AMD74XX_OVERRIDE is not set
 # CONFIG_BLK_DEV_CMD64X is not set
-# CONFIG_BLK_DEV_CMD680 is not set
 # CONFIG_BLK_DEV_CY82C693 is not set
 # CONFIG_BLK_DEV_CS5530 is not set
 # CONFIG_BLK_DEV_HPT34X is not set
 # CONFIG_HPT34X_AUTODMA is not set
 # CONFIG_BLK_DEV_HPT366 is not set
 CONFIG_BLK_DEV_PIIX=y
-CONFIG_PIIX_TUNING=y
+# CONFIG_BLK_DEV_NFORCE is not set
 # CONFIG_BLK_DEV_NS87415 is not set
 # CONFIG_BLK_DEV_OPTI621 is not set
-# CONFIG_BLK_DEV_PDC202XX is not set
+# CONFIG_BLK_DEV_PDC202XX_OLD is not set
 # CONFIG_PDC202XX_BURST is not set
+# CONFIG_BLK_DEV_PDC202XX_NEW is not set
 # CONFIG_PDC202XX_FORCE is not set
+CONFIG_BLK_DEV_RZ1000=y
+# CONFIG_BLK_DEV_SC1200 is not set
 # CONFIG_BLK_DEV_SVWKS is not set
+# CONFIG_BLK_DEV_SIIMAGE is not set
 # CONFIG_BLK_DEV_SIS5513 is not set
 # CONFIG_BLK_DEV_SLC90E66 is not set
 # CONFIG_BLK_DEV_TRM290 is not set
@@ -369,6 +366,7 @@
 # CONFIG_SCSI_T128 is not set
 # CONFIG_SCSI_U14_34F is not set
 # CONFIG_SCSI_ULTRASTOR is not set
+# CONFIG_SCSI_NSP32 is not set
 
 #
 # PCMCIA SCSI adapter support
@@ -433,11 +431,11 @@
 # CONFIG_APRICOT is not set
 # CONFIG_CS89x0 is not set
 # CONFIG_TULIP is not set
-# CONFIG_TC35815 is not set
 # CONFIG_DE4X5 is not set
 # CONFIG_DGRS is not set
 # CONFIG_DM9102 is not set
 CONFIG_EEPRO100=y
+# CONFIG_E100 is not set
 # CONFIG_LNE390 is not set
 # CONFIG_FEALNX is not set
 # CONFIG_NATSEMI is not set
@@ -449,11 +447,13 @@
 # CONFIG_8139TOO_PIO is not set
 # CONFIG_8139TOO_TUNE_TWISTER is not set
 # CONFIG_8139TOO_8129 is not set
-# CONFIG_8139_NEW_RX_RESET is not set
+# CONFIG_8139_OLD_RX_RESET is not set
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
 # CONFIG_SUNDANCE is not set
+# CONFIG_SUNDANCE_MMIO is not set
 # CONFIG_TLAN is not set
+# CONFIG_TC35815 is not set
 # CONFIG_VIA_RHINE is not set
 # CONFIG_VIA_RHINE_MMIO is not set
 # CONFIG_WINBOND_840 is not set
@@ -464,10 +464,12 @@
 #
 # CONFIG_ACENIC is not set
 # CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
 # CONFIG_MYRI_SBUS is not set
 # CONFIG_NS83820 is not set
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
 # CONFIG_SK98LIN is not set
 # CONFIG_TIGON3 is not set
 # CONFIG_FDDI is not set
@@ -587,8 +589,10 @@
 # Watchdog Cards
 #
 # CONFIG_WATCHDOG is not set
+# CONFIG_SCx200_GPIO is not set
 # CONFIG_AMD_RNG is not set
 # CONFIG_INTEL_RNG is not set
+# CONFIG_AMD_PM768 is not set
 # CONFIG_NVRAM is not set
 # CONFIG_RTC is not set
 # CONFIG_DTLK is not set
@@ -604,6 +608,7 @@
 CONFIG_AGP_I810=y
 CONFIG_AGP_VIA=y
 CONFIG_AGP_AMD=y
+CONFIG_AGP_AMD_8151=y
 CONFIG_AGP_SIS=y
 CONFIG_AGP_ALI=y
 # CONFIG_AGP_SWORKS is not set
@@ -619,6 +624,7 @@
 CONFIG_DRM_RADEON=y
 CONFIG_DRM_I810=y
 CONFIG_DRM_I810_XFREE_41=y
+CONFIG_DRM_I830=y
 # CONFIG_DRM_MGA is not set
 # CONFIG_DRM_SIS is not set
 
@@ -626,6 +632,7 @@
 # PCMCIA character devices
 #
 # CONFIG_PCMCIA_SERIAL_CS is not set
+# CONFIG_SYNCLINK_CS is not set
 # CONFIG_MWAVE is not set
 
 #
@@ -646,6 +653,8 @@
 # CONFIG_ADFS_FS_RW is not set
 # CONFIG_AFFS_FS is not set
 # CONFIG_HFS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BEFS_DEBUG is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EXT3_FS is not set
 # CONFIG_JBD is not set
@@ -663,6 +672,9 @@
 CONFIG_ISO9660_FS=y
 # CONFIG_JOLIET is not set
 # CONFIG_ZISOFS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_JFS_DEBUG is not set
+# CONFIG_JFS_STATISTICS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
@@ -693,6 +705,7 @@
 # CONFIG_ROOT_NFS is not set
 CONFIG_NFSD=y
 # CONFIG_NFSD_V3 is not set
+# CONFIG_NFSD_TCP is not set
 CONFIG_SUNRPC=y
 CONFIG_LOCKD=y
 # CONFIG_SMB_FS is not set
@@ -706,7 +719,6 @@
 # CONFIG_NCPFS_NLS is not set
 # CONFIG_NCPFS_EXTRAS is not set
 # CONFIG_ZISOFS_FS is not set
-# CONFIG_ZLIB_FS_INFLATE is not set
 
 #
 # Partition Types
@@ -726,6 +738,7 @@
 # Sound
 #
 CONFIG_SOUND=y
+# CONFIG_SOUND_ALI5455 is not set
 # CONFIG_SOUND_BT878 is not set
 # CONFIG_SOUND_CMPCI is not set
 # CONFIG_SOUND_EMU10K1 is not set
@@ -737,6 +750,7 @@
 # CONFIG_SOUND_ESSSOLO1 is not set
 # CONFIG_SOUND_MAESTRO is not set
 # CONFIG_SOUND_MAESTRO3 is not set
+# CONFIG_SOUND_FORTE is not set
 # CONFIG_SOUND_ICH is not set
 # CONFIG_SOUND_RME96XX is not set
 # CONFIG_SOUND_SONICVIBES is not set
@@ -759,7 +773,6 @@
 #
 # CONFIG_USB_DEVICEFS is not set
 # CONFIG_USB_BANDWIDTH is not set
-# CONFIG_USB_LONG_TIMEOUT is not set
 
 #
 # USB Host Controller Drivers
@@ -773,7 +786,7 @@
 #
 # CONFIG_USB_AUDIO is not set
 # CONFIG_USB_EMI26 is not set
-# CONFIG_USB_BLUETOOTH is not set
+# CONFIG_USB_MIDI is not set
 CONFIG_USB_STORAGE=y
 # CONFIG_USB_STORAGE_DEBUG is not set
 # CONFIG_USB_STORAGE_DATAFAB is not set
@@ -782,6 +795,7 @@
 # CONFIG_USB_STORAGE_DPCM is not set
 # CONFIG_USB_STORAGE_HP8200e is not set
 # CONFIG_USB_STORAGE_SDDR09 is not set
+# CONFIG_USB_STORAGE_SDDR55 is not set
 # CONFIG_USB_STORAGE_JUMPSHOT is not set
 # CONFIG_USB_ACM is not set
 # CONFIG_USB_PRINTER is not set
@@ -798,7 +812,9 @@
 # CONFIG_USB_HIDDEV is not set
 # CONFIG_USB_KBD is not set
 # CONFIG_USB_MOUSE is not set
+# CONFIG_USB_AIPTEK is not set
 # CONFIG_USB_WACOM is not set
+# CONFIG_USB_POWERMATE is not set
 
 #
 # USB Imaging devices
@@ -836,39 +852,15 @@
 # USB Serial Converter support
 #
 # CONFIG_USB_SERIAL is not set
-# CONFIG_USB_SERIAL_GENERIC is not set
-# CONFIG_USB_SERIAL_BELKIN is not set
-# CONFIG_USB_SERIAL_WHITEHEAT is not set
-# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
-# CONFIG_USB_SERIAL_EMPEG is not set
-# CONFIG_USB_SERIAL_FTDI_SIO is not set
-# CONFIG_USB_SERIAL_VISOR is not set
-# CONFIG_USB_SERIAL_IPAQ is not set
-# CONFIG_USB_SERIAL_IR is not set
-# CONFIG_USB_SERIAL_EDGEPORT is not set
-# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
-# CONFIG_USB_SERIAL_KEYSPAN is not set
-# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
-# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
-# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
-# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
-# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
-# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
-# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
-# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
-# CONFIG_USB_SERIAL_MCT_U232 is not set
-# CONFIG_USB_SERIAL_KLSI is not set
-# CONFIG_USB_SERIAL_PL2303 is not set
-# CONFIG_USB_SERIAL_CYBERJACK is not set
-# CONFIG_USB_SERIAL_XIRCOM is not set
-# CONFIG_USB_SERIAL_OMNINET is not set
 
 #
 # USB Miscellaneous drivers
 #
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_AUERSWALD is not set
+# CONFIG_USB_TIGL is not set
 # CONFIG_USB_BRLVGER is not set
+# CONFIG_USB_LCD is not set
 
 #
 # Bluetooth support
@@ -879,3 +871,9 @@
 # Kernel hacking
 #
 # CONFIG_DEBUG_KERNEL is not set
+
+#
+# Library routines
+#
+# CONFIG_ZLIB_INFLATE is not set
+# CONFIG_ZLIB_DEFLATE is not set
