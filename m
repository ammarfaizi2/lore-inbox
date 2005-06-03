Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVFCR1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVFCR1W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 13:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVFCR1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 13:27:22 -0400
Received: from hcc022150.bai.ne.jp ([210.171.22.150]:25547 "HELO
	tigger.internet.email.ne.jp") by vger.kernel.org with SMTP
	id S261408AbVFCRYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 13:24:20 -0400
Date: Sat, 04 Jun 2005 02:24:13 +0900 (JST)
Message-Id: <20050604.022413.71092380.takata@linux-m32r.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.12-rc5] m32r: Update defconfig files
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates defconfig files for 2.6.12-rc5 m32r kernel.
Please apply.

Thanks,

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 defconfig                       |   52 +++++++++++++++++++++++----------------
 m32700ut/defconfig.m32700ut.smp |   53 ++++++++++++++++++++++++----------------
 m32700ut/defconfig.m32700ut.up  |   52 +++++++++++++++++++++++----------------
 mappi/defconfig.nommu           |   46 ++++++++++++++++++----------------
 mappi/defconfig.smp             |   49 ++++++++++++++++++++----------------
 mappi/defconfig.up              |   48 +++++++++++++++++++-----------------
 mappi2/defconfig.vdec2          |   46 ++++++++++++++++++----------------
 mm/extable.c                    |    5 ---
 oaks32r/defconfig.nommu         |   50 ++++++++++++++++++-------------------
 opsput/defconfig.opsput         |   45 ++++++++++++++++++---------------
 10 files changed, 248 insertions(+), 198 deletions(-)


diff -ruNp a/arch/m32r/defconfig b/arch/m32r/defconfig
--- a/arch/m32r/defconfig	2005-03-07 14:10:21.000000000 +0900
+++ b/arch/m32r/defconfig	2005-06-03 16:20:11.000000000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.11-rc4
-# Wed Feb 16 21:10:44 2005
+# Linux kernel version: 2.6.12-rc5
+# Fri Jun  3 16:20:11 2005
 #
 CONFIG_M32R=y
 # CONFIG_UID16 is not set
@@ -16,6 +16,7 @@ CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_LOCK_KERNEL=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
 
 #
 # General setup
@@ -28,13 +29,15 @@ CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
-CONFIG_LOG_BUF_SHIFT=14
 CONFIG_HOTPLUG=y
 CONFIG_KOBJECT_UEVENT=y
 CONFIG_IKCONFIG=y
 # CONFIG_IKCONFIG_PROC is not set
 CONFIG_EMBEDDED=y
 # CONFIG_KALLSYMS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
@@ -44,6 +47,7 @@ CONFIG_CC_ALIGN_LABELS=0
 CONFIG_CC_ALIGN_LOOPS=0
 CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
 
 #
 # Loadable module support
@@ -65,6 +69,7 @@ CONFIG_PLAT_M32700UT=y
 # CONFIG_PLAT_OPSPUT is not set
 # CONFIG_PLAT_OAKS32R is not set
 # CONFIG_PLAT_MAPPI2 is not set
+# CONFIG_PLAT_MAPPI3 is not set
 CONFIG_CHIP_M32700=y
 # CONFIG_CHIP_M32102 is not set
 # CONFIG_CHIP_VDEC2 is not set
@@ -268,7 +273,6 @@ CONFIG_NET=y
 #
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
-# CONFIG_NETLINK_DEV is not set
 CONFIG_UNIX=y
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
@@ -393,18 +397,6 @@ CONFIG_INPUT=y
 # CONFIG_INPUT_EVBUG is not set
 
 #
-# Input I/O drivers
-#
-# CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
-CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
-CONFIG_SERIO_SERPORT=y
-# CONFIG_SERIO_CT82C710 is not set
-# CONFIG_SERIO_LIBPS2 is not set
-# CONFIG_SERIO_RAW is not set
-
-#
 # Input Device Drivers
 #
 # CONFIG_INPUT_KEYBOARD is not set
@@ -414,6 +406,17 @@ CONFIG_SERIO_SERPORT=y
 # CONFIG_INPUT_MISC is not set
 
 #
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+# CONFIG_SERIO_I8042 is not set
+CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_LIBPS2 is not set
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+
+#
 # Character devices
 #
 CONFIG_VT=y
@@ -465,6 +468,10 @@ CONFIG_DS1302=y
 # CONFIG_RAW_DRIVER is not set
 
 #
+# TPM devices
+#
+
+#
 # I2C support
 #
 # CONFIG_I2C is not set
@@ -508,8 +515,14 @@ CONFIG_VIDEO_M32R_AR_M64278=y
 # Graphics support
 #
 CONFIG_FB=y
+# CONFIG_FB_CFB_FILLRECT is not set
+# CONFIG_FB_CFB_COPYAREA is not set
+# CONFIG_FB_CFB_IMAGEBLIT is not set
+# CONFIG_FB_SOFT_CURSOR is not set
+# CONFIG_FB_MACMODES is not set
 # CONFIG_FB_MODE_HELPERS is not set
 # CONFIG_FB_TILEBLITTING is not set
+# CONFIG_FB_S1D13XXX is not set
 # CONFIG_FB_VIRTUAL is not set
 
 #
@@ -543,10 +556,6 @@ CONFIG_LOGO_LINUX_CLUT224=y
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
-#
-
-#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
@@ -719,8 +728,9 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 #
 # Kernel hacking
 #
+# CONFIG_PRINTK_TIME is not set
 # CONFIG_DEBUG_KERNEL is not set
-CONFIG_DEBUG_PREEMPT=y
+CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_FRAME_POINTER is not set
 
diff -ruNp a/arch/m32r/m32700ut/defconfig.m32700ut.smp b/arch/m32r/m32700ut/defconfig.m32700ut.smp
--- a/arch/m32r/m32700ut/defconfig.m32700ut.smp	2005-03-07 14:10:21.000000000 +0900
+++ b/arch/m32r/m32700ut/defconfig.m32700ut.smp	2005-06-03 16:20:58.000000000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.11-rc4
-# Wed Feb 16 21:10:50 2005
+# Linux kernel version: 2.6.12-rc5
+# Fri Jun  3 16:20:58 2005
 #
 CONFIG_M32R=y
 # CONFIG_UID16 is not set
@@ -15,6 +15,7 @@ CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
 CONFIG_LOCK_KERNEL=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
 
 #
 # General setup
@@ -27,13 +28,16 @@ CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
-CONFIG_LOG_BUF_SHIFT=15
 CONFIG_HOTPLUG=y
 CONFIG_KOBJECT_UEVENT=y
 CONFIG_IKCONFIG=y
 # CONFIG_IKCONFIG_PROC is not set
+# CONFIG_CPUSETS is not set
 CONFIG_EMBEDDED=y
 # CONFIG_KALLSYMS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
@@ -43,6 +47,7 @@ CONFIG_CC_ALIGN_LABELS=0
 CONFIG_CC_ALIGN_LOOPS=0
 CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
 
 #
 # Loadable module support
@@ -65,6 +70,7 @@ CONFIG_PLAT_M32700UT=y
 # CONFIG_PLAT_OPSPUT is not set
 # CONFIG_PLAT_OAKS32R is not set
 # CONFIG_PLAT_MAPPI2 is not set
+# CONFIG_PLAT_MAPPI3 is not set
 CONFIG_CHIP_M32700=y
 # CONFIG_CHIP_M32102 is not set
 # CONFIG_CHIP_VDEC2 is not set
@@ -271,7 +277,6 @@ CONFIG_NET=y
 #
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
-# CONFIG_NETLINK_DEV is not set
 CONFIG_UNIX=y
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
@@ -396,18 +401,6 @@ CONFIG_INPUT=y
 # CONFIG_INPUT_EVBUG is not set
 
 #
-# Input I/O drivers
-#
-# CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
-CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
-CONFIG_SERIO_SERPORT=y
-# CONFIG_SERIO_CT82C710 is not set
-# CONFIG_SERIO_LIBPS2 is not set
-# CONFIG_SERIO_RAW is not set
-
-#
 # Input Device Drivers
 #
 # CONFIG_INPUT_KEYBOARD is not set
@@ -417,6 +410,17 @@ CONFIG_SERIO_SERPORT=y
 # CONFIG_INPUT_MISC is not set
 
 #
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+# CONFIG_SERIO_I8042 is not set
+CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_LIBPS2 is not set
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+
+#
 # Character devices
 #
 CONFIG_VT=y
@@ -468,6 +472,10 @@ CONFIG_DS1302=y
 # CONFIG_RAW_DRIVER is not set
 
 #
+# TPM devices
+#
+
+#
 # I2C support
 #
 # CONFIG_I2C is not set
@@ -511,8 +519,14 @@ CONFIG_VIDEO_M32R_AR_M64278=y
 # Graphics support
 #
 CONFIG_FB=y
+# CONFIG_FB_CFB_FILLRECT is not set
+# CONFIG_FB_CFB_COPYAREA is not set
+# CONFIG_FB_CFB_IMAGEBLIT is not set
+# CONFIG_FB_SOFT_CURSOR is not set
+# CONFIG_FB_MACMODES is not set
 # CONFIG_FB_MODE_HELPERS is not set
 # CONFIG_FB_TILEBLITTING is not set
+# CONFIG_FB_S1D13XXX is not set
 # CONFIG_FB_VIRTUAL is not set
 
 #
@@ -546,10 +560,6 @@ CONFIG_LOGO_LINUX_CLUT224=y
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
-#
-
-#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
@@ -722,8 +732,9 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 #
 # Kernel hacking
 #
+# CONFIG_PRINTK_TIME is not set
 # CONFIG_DEBUG_KERNEL is not set
-CONFIG_DEBUG_PREEMPT=y
+CONFIG_LOG_BUF_SHIFT=15
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_FRAME_POINTER is not set
 
diff -ruNp a/arch/m32r/m32700ut/defconfig.m32700ut.up b/arch/m32r/m32700ut/defconfig.m32700ut.up
--- a/arch/m32r/m32700ut/defconfig.m32700ut.up	2005-03-07 14:10:21.000000000 +0900
+++ b/arch/m32r/m32700ut/defconfig.m32700ut.up	2005-06-03 16:21:34.000000000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.11-rc4
-# Wed Feb 16 21:10:54 2005
+# Linux kernel version: 2.6.12-rc5
+# Fri Jun  3 16:21:34 2005
 #
 CONFIG_M32R=y
 # CONFIG_UID16 is not set
@@ -16,6 +16,7 @@ CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_LOCK_KERNEL=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
 
 #
 # General setup
@@ -28,13 +29,15 @@ CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
-CONFIG_LOG_BUF_SHIFT=14
 CONFIG_HOTPLUG=y
 CONFIG_KOBJECT_UEVENT=y
 CONFIG_IKCONFIG=y
 # CONFIG_IKCONFIG_PROC is not set
 CONFIG_EMBEDDED=y
 # CONFIG_KALLSYMS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
@@ -44,6 +47,7 @@ CONFIG_CC_ALIGN_LABELS=0
 CONFIG_CC_ALIGN_LOOPS=0
 CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
 
 #
 # Loadable module support
@@ -65,6 +69,7 @@ CONFIG_PLAT_M32700UT=y
 # CONFIG_PLAT_OPSPUT is not set
 # CONFIG_PLAT_OAKS32R is not set
 # CONFIG_PLAT_MAPPI2 is not set
+# CONFIG_PLAT_MAPPI3 is not set
 CONFIG_CHIP_M32700=y
 # CONFIG_CHIP_M32102 is not set
 # CONFIG_CHIP_VDEC2 is not set
@@ -268,7 +273,6 @@ CONFIG_NET=y
 #
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
-# CONFIG_NETLINK_DEV is not set
 CONFIG_UNIX=y
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
@@ -393,18 +397,6 @@ CONFIG_INPUT=y
 # CONFIG_INPUT_EVBUG is not set
 
 #
-# Input I/O drivers
-#
-# CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
-CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
-CONFIG_SERIO_SERPORT=y
-# CONFIG_SERIO_CT82C710 is not set
-# CONFIG_SERIO_LIBPS2 is not set
-# CONFIG_SERIO_RAW is not set
-
-#
 # Input Device Drivers
 #
 # CONFIG_INPUT_KEYBOARD is not set
@@ -414,6 +406,17 @@ CONFIG_SERIO_SERPORT=y
 # CONFIG_INPUT_MISC is not set
 
 #
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+# CONFIG_SERIO_I8042 is not set
+CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_LIBPS2 is not set
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+
+#
 # Character devices
 #
 CONFIG_VT=y
@@ -465,6 +468,10 @@ CONFIG_DS1302=y
 # CONFIG_RAW_DRIVER is not set
 
 #
+# TPM devices
+#
+
+#
 # I2C support
 #
 # CONFIG_I2C is not set
@@ -508,8 +515,14 @@ CONFIG_VIDEO_M32R_AR_M64278=y
 # Graphics support
 #
 CONFIG_FB=y
+# CONFIG_FB_CFB_FILLRECT is not set
+# CONFIG_FB_CFB_COPYAREA is not set
+# CONFIG_FB_CFB_IMAGEBLIT is not set
+# CONFIG_FB_SOFT_CURSOR is not set
+# CONFIG_FB_MACMODES is not set
 # CONFIG_FB_MODE_HELPERS is not set
 # CONFIG_FB_TILEBLITTING is not set
+# CONFIG_FB_S1D13XXX is not set
 # CONFIG_FB_VIRTUAL is not set
 
 #
@@ -543,10 +556,6 @@ CONFIG_LOGO_LINUX_CLUT224=y
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
-#
-
-#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
@@ -719,8 +728,9 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 #
 # Kernel hacking
 #
+# CONFIG_PRINTK_TIME is not set
 # CONFIG_DEBUG_KERNEL is not set
-CONFIG_DEBUG_PREEMPT=y
+CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_FRAME_POINTER is not set
 
diff -ruNp a/arch/m32r/mappi/defconfig.nommu b/arch/m32r/mappi/defconfig.nommu
--- a/arch/m32r/mappi/defconfig.nommu	2005-03-07 14:10:21.000000000 +0900
+++ b/arch/m32r/mappi/defconfig.nommu	2005-06-03 16:21:46.000000000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.11-rc4
-# Wed Feb 16 21:10:57 2005
+# Linux kernel version: 2.6.12-rc5
+# Fri Jun  3 16:21:46 2005
 #
 CONFIG_M32R=y
 # CONFIG_UID16 is not set
@@ -16,6 +16,7 @@ CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_LOCK_KERNEL=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
 
 #
 # General setup
@@ -26,13 +27,15 @@ CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
-CONFIG_LOG_BUF_SHIFT=14
 CONFIG_HOTPLUG=y
 CONFIG_KOBJECT_UEVENT=y
 CONFIG_IKCONFIG=y
 # CONFIG_IKCONFIG_PROC is not set
 CONFIG_EMBEDDED=y
 # CONFIG_KALLSYMS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
@@ -41,6 +44,7 @@ CONFIG_CC_ALIGN_LABELS=0
 CONFIG_CC_ALIGN_LOOPS=0
 CONFIG_CC_ALIGN_JUMPS=0
 CONFIG_TINY_SHMEM=y
+CONFIG_BASE_SMALL=0
 
 #
 # Loadable module support
@@ -62,6 +66,7 @@ CONFIG_PLAT_MAPPI=y
 # CONFIG_PLAT_OPSPUT is not set
 # CONFIG_PLAT_OAKS32R is not set
 # CONFIG_PLAT_MAPPI2 is not set
+# CONFIG_PLAT_MAPPI3 is not set
 CONFIG_CHIP_M32700=y
 # CONFIG_CHIP_M32102 is not set
 # CONFIG_CHIP_VDEC2 is not set
@@ -202,7 +207,6 @@ CONFIG_NET=y
 #
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
-# CONFIG_NETLINK_DEV is not set
 CONFIG_UNIX=y
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
@@ -325,18 +329,6 @@ CONFIG_INPUT=y
 # CONFIG_INPUT_EVBUG is not set
 
 #
-# Input I/O drivers
-#
-# CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
-CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
-CONFIG_SERIO_SERPORT=y
-# CONFIG_SERIO_CT82C710 is not set
-# CONFIG_SERIO_LIBPS2 is not set
-# CONFIG_SERIO_RAW is not set
-
-#
 # Input Device Drivers
 #
 # CONFIG_INPUT_KEYBOARD is not set
@@ -346,6 +338,17 @@ CONFIG_SERIO_SERPORT=y
 # CONFIG_INPUT_MISC is not set
 
 #
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+# CONFIG_SERIO_I8042 is not set
+CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_LIBPS2 is not set
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+
+#
 # Character devices
 #
 # CONFIG_VT is not set
@@ -394,6 +397,10 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_RAW_DRIVER is not set
 
 #
+# TPM devices
+#
+
+#
 # I2C support
 #
 # CONFIG_I2C is not set
@@ -434,10 +441,6 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
-#
-
-#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
@@ -595,8 +598,9 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 #
 # Kernel hacking
 #
+# CONFIG_PRINTK_TIME is not set
 # CONFIG_DEBUG_KERNEL is not set
-CONFIG_DEBUG_PREEMPT=y
+CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_FRAME_POINTER is not set
 
diff -ruNp a/arch/m32r/mappi/defconfig.smp b/arch/m32r/mappi/defconfig.smp
--- a/arch/m32r/mappi/defconfig.smp	2005-03-07 14:10:21.000000000 +0900
+++ b/arch/m32r/mappi/defconfig.smp	2005-06-03 16:21:52.000000000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.11-rc4
-# Wed Feb 16 21:11:02 2005
+# Linux kernel version: 2.6.12-rc5
+# Fri Jun  3 16:21:52 2005
 #
 CONFIG_M32R=y
 # CONFIG_UID16 is not set
@@ -17,6 +17,7 @@ CONFIG_EXPERIMENTAL=y
 CONFIG_BROKEN=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_LOCK_KERNEL=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
 
 #
 # General setup
@@ -28,13 +29,16 @@ CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
-CONFIG_LOG_BUF_SHIFT=15
 CONFIG_HOTPLUG=y
 CONFIG_KOBJECT_UEVENT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
+# CONFIG_CPUSETS is not set
 CONFIG_EMBEDDED=y
 # CONFIG_KALLSYMS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
@@ -44,6 +48,7 @@ CONFIG_CC_ALIGN_LABELS=0
 CONFIG_CC_ALIGN_LOOPS=0
 CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
 
 #
 # Loadable module support
@@ -66,6 +71,7 @@ CONFIG_PLAT_MAPPI=y
 # CONFIG_PLAT_OPSPUT is not set
 # CONFIG_PLAT_OAKS32R is not set
 # CONFIG_PLAT_MAPPI2 is not set
+# CONFIG_PLAT_MAPPI3 is not set
 CONFIG_CHIP_M32700=y
 # CONFIG_CHIP_M32102 is not set
 # CONFIG_CHIP_VDEC2 is not set
@@ -139,8 +145,8 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 #
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
-CONFIG_MTD_PARTITIONS=y
 # CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_REDBOOT_PARTS=y
 CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
 # CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
@@ -294,7 +300,6 @@ CONFIG_NET=y
 # Networking options
 #
 # CONFIG_PACKET is not set
-# CONFIG_NETLINK_DEV is not set
 CONFIG_UNIX=y
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
@@ -420,18 +425,6 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # CONFIG_INPUT_EVBUG is not set
 
 #
-# Input I/O drivers
-#
-# CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
-CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
-# CONFIG_SERIO_SERPORT is not set
-# CONFIG_SERIO_CT82C710 is not set
-# CONFIG_SERIO_LIBPS2 is not set
-# CONFIG_SERIO_RAW is not set
-
-#
 # Input Device Drivers
 #
 # CONFIG_INPUT_KEYBOARD is not set
@@ -441,6 +434,17 @@ CONFIG_SERIO=y
 # CONFIG_INPUT_MISC is not set
 
 #
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+# CONFIG_SERIO_I8042 is not set
+# CONFIG_SERIO_SERPORT is not set
+# CONFIG_SERIO_LIBPS2 is not set
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+
+#
 # Character devices
 #
 # CONFIG_VT is not set
@@ -489,6 +493,10 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_RAW_DRIVER is not set
 
 #
+# TPM devices
+#
+
+#
 # I2C support
 #
 # CONFIG_I2C is not set
@@ -529,10 +537,6 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
-#
-
-#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
@@ -708,8 +712,9 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 #
 # Kernel hacking
 #
+# CONFIG_PRINTK_TIME is not set
 # CONFIG_DEBUG_KERNEL is not set
-CONFIG_DEBUG_PREEMPT=y
+CONFIG_LOG_BUF_SHIFT=15
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_FRAME_POINTER is not set
 
diff -ruNp a/arch/m32r/mappi/defconfig.up b/arch/m32r/mappi/defconfig.up
--- a/arch/m32r/mappi/defconfig.up	2005-03-07 14:10:21.000000000 +0900
+++ b/arch/m32r/mappi/defconfig.up	2005-06-03 16:21:59.000000000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.11-rc4
-# Wed Feb 16 21:11:07 2005
+# Linux kernel version: 2.6.12-rc5
+# Fri Jun  3 16:21:59 2005
 #
 CONFIG_M32R=y
 # CONFIG_UID16 is not set
@@ -17,6 +17,7 @@ CONFIG_EXPERIMENTAL=y
 CONFIG_BROKEN=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_LOCK_KERNEL=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
 
 #
 # General setup
@@ -28,13 +29,15 @@ CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
-CONFIG_LOG_BUF_SHIFT=14
 CONFIG_HOTPLUG=y
 CONFIG_KOBJECT_UEVENT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_EMBEDDED=y
 # CONFIG_KALLSYMS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
@@ -44,6 +47,7 @@ CONFIG_CC_ALIGN_LABELS=0
 CONFIG_CC_ALIGN_LOOPS=0
 CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
 
 #
 # Loadable module support
@@ -65,6 +69,7 @@ CONFIG_PLAT_MAPPI=y
 # CONFIG_PLAT_OPSPUT is not set
 # CONFIG_PLAT_OAKS32R is not set
 # CONFIG_PLAT_MAPPI2 is not set
+# CONFIG_PLAT_MAPPI3 is not set
 CONFIG_CHIP_M32700=y
 # CONFIG_CHIP_M32102 is not set
 # CONFIG_CHIP_VDEC2 is not set
@@ -135,8 +140,8 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 #
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
-CONFIG_MTD_PARTITIONS=y
 # CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_REDBOOT_PARTS=y
 CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
 # CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
@@ -290,7 +295,6 @@ CONFIG_NET=y
 # Networking options
 #
 # CONFIG_PACKET is not set
-# CONFIG_NETLINK_DEV is not set
 CONFIG_UNIX=y
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
@@ -416,18 +420,6 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # CONFIG_INPUT_EVBUG is not set
 
 #
-# Input I/O drivers
-#
-# CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
-CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
-# CONFIG_SERIO_SERPORT is not set
-# CONFIG_SERIO_CT82C710 is not set
-# CONFIG_SERIO_LIBPS2 is not set
-# CONFIG_SERIO_RAW is not set
-
-#
 # Input Device Drivers
 #
 # CONFIG_INPUT_KEYBOARD is not set
@@ -437,6 +429,17 @@ CONFIG_SERIO=y
 # CONFIG_INPUT_MISC is not set
 
 #
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+# CONFIG_SERIO_I8042 is not set
+# CONFIG_SERIO_SERPORT is not set
+# CONFIG_SERIO_LIBPS2 is not set
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+
+#
 # Character devices
 #
 # CONFIG_VT is not set
@@ -485,6 +488,10 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_RAW_DRIVER is not set
 
 #
+# TPM devices
+#
+
+#
 # I2C support
 #
 # CONFIG_I2C is not set
@@ -525,10 +532,6 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
-#
-
-#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
@@ -704,8 +707,9 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 #
 # Kernel hacking
 #
+# CONFIG_PRINTK_TIME is not set
 # CONFIG_DEBUG_KERNEL is not set
-CONFIG_DEBUG_PREEMPT=y
+CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_FRAME_POINTER is not set
 
diff -ruNp a/arch/m32r/mappi2/defconfig.vdec2 b/arch/m32r/mappi2/defconfig.vdec2
--- a/arch/m32r/mappi2/defconfig.vdec2	2005-03-07 14:10:21.000000000 +0900
+++ b/arch/m32r/mappi2/defconfig.vdec2	2005-06-03 16:22:02.000000000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.11-rc4
-# Wed Feb 16 21:11:10 2005
+# Linux kernel version: 2.6.12-rc5
+# Fri Jun  3 16:22:02 2005
 #
 CONFIG_M32R=y
 # CONFIG_UID16 is not set
@@ -16,6 +16,7 @@ CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_LOCK_KERNEL=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
 
 #
 # General setup
@@ -28,13 +29,15 @@ CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
-CONFIG_LOG_BUF_SHIFT=14
 CONFIG_HOTPLUG=y
 CONFIG_KOBJECT_UEVENT=y
 CONFIG_IKCONFIG=y
 # CONFIG_IKCONFIG_PROC is not set
 CONFIG_EMBEDDED=y
 # CONFIG_KALLSYMS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
@@ -44,6 +47,7 @@ CONFIG_CC_ALIGN_LABELS=0
 CONFIG_CC_ALIGN_LOOPS=0
 CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
 
 #
 # Loadable module support
@@ -65,6 +69,7 @@ CONFIG_KMOD=y
 # CONFIG_PLAT_OPSPUT is not set
 # CONFIG_PLAT_OAKS32R is not set
 CONFIG_PLAT_MAPPI2=y
+# CONFIG_PLAT_MAPPI3 is not set
 # CONFIG_CHIP_M32700 is not set
 # CONFIG_CHIP_M32102 is not set
 CONFIG_CHIP_VDEC2=y
@@ -264,7 +269,6 @@ CONFIG_NET=y
 #
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
-# CONFIG_NETLINK_DEV is not set
 CONFIG_UNIX=y
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
@@ -389,18 +393,6 @@ CONFIG_INPUT=y
 # CONFIG_INPUT_EVBUG is not set
 
 #
-# Input I/O drivers
-#
-# CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
-CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
-CONFIG_SERIO_SERPORT=y
-# CONFIG_SERIO_CT82C710 is not set
-# CONFIG_SERIO_LIBPS2 is not set
-# CONFIG_SERIO_RAW is not set
-
-#
 # Input Device Drivers
 #
 # CONFIG_INPUT_KEYBOARD is not set
@@ -410,6 +402,17 @@ CONFIG_SERIO_SERPORT=y
 # CONFIG_INPUT_MISC is not set
 
 #
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+# CONFIG_SERIO_I8042 is not set
+CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_LIBPS2 is not set
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+
+#
 # Character devices
 #
 CONFIG_VT=y
@@ -460,6 +463,10 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_RAW_DRIVER is not set
 
 #
+# TPM devices
+#
+
+#
 # I2C support
 #
 # CONFIG_I2C is not set
@@ -521,10 +528,6 @@ CONFIG_DUMMY_CONSOLE=y
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
-#
-
-#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
@@ -697,8 +700,9 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 #
 # Kernel hacking
 #
+# CONFIG_PRINTK_TIME is not set
 # CONFIG_DEBUG_KERNEL is not set
-CONFIG_DEBUG_PREEMPT=y
+CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_FRAME_POINTER is not set
 
diff -ruNp a/arch/m32r/mm/extable.c b/arch/m32r/mm/extable.c
--- a/arch/m32r/mm/extable.c	2004-12-25 06:35:28.000000000 +0900
+++ b/arch/m32r/mm/extable.c	2005-05-30 18:08:19.000000000 +0900
@@ -1,10 +1,8 @@
 /*
- * linux/arch/i386/mm/extable.c
+ * linux/arch/m32r/mm/extable.c
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
-#include <linux/spinlock.h>
 #include <asm/uaccess.h>
 
 int fixup_exception(struct pt_regs *regs)
@@ -19,4 +17,3 @@ int fixup_exception(struct pt_regs *regs
 
 	return 0;
 }
-
diff -ruNp a/arch/m32r/oaks32r/defconfig.nommu b/arch/m32r/oaks32r/defconfig.nommu
--- a/arch/m32r/oaks32r/defconfig.nommu	2005-03-07 14:10:21.000000000 +0900
+++ b/arch/m32r/oaks32r/defconfig.nommu	2005-06-03 16:22:04.000000000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.11-rc4
-# Wed Feb 16 21:11:13 2005
+# Linux kernel version: 2.6.12-rc5
+# Fri Jun  3 16:22:04 2005
 #
 CONFIG_M32R=y
 # CONFIG_UID16 is not set
@@ -16,6 +16,7 @@ CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_LOCK_KERNEL=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
 
 #
 # General setup
@@ -26,12 +27,14 @@ CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
-CONFIG_LOG_BUF_SHIFT=14
 CONFIG_HOTPLUG=y
 CONFIG_KOBJECT_UEVENT=y
 # CONFIG_IKCONFIG is not set
 CONFIG_EMBEDDED=y
 # CONFIG_KALLSYMS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
@@ -40,6 +43,7 @@ CONFIG_CC_ALIGN_LABELS=0
 CONFIG_CC_ALIGN_LOOPS=0
 CONFIG_CC_ALIGN_JUMPS=0
 CONFIG_TINY_SHMEM=y
+CONFIG_BASE_SMALL=0
 
 #
 # Loadable module support
@@ -61,6 +65,7 @@ CONFIG_KMOD=y
 # CONFIG_PLAT_OPSPUT is not set
 CONFIG_PLAT_OAKS32R=y
 # CONFIG_PLAT_MAPPI2 is not set
+# CONFIG_PLAT_MAPPI3 is not set
 # CONFIG_CHIP_M32700 is not set
 CONFIG_CHIP_M32102=y
 # CONFIG_CHIP_VDEC2 is not set
@@ -92,10 +97,6 @@ CONFIG_PREEMPT=y
 # CONFIG_PCCARD is not set
 
 #
-# PC-card bridges
-#
-
-#
 # PCI Hotplug Support
 #
 
@@ -193,7 +194,6 @@ CONFIG_NET=y
 #
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
-# CONFIG_NETLINK_DEV is not set
 CONFIG_UNIX=y
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
@@ -311,18 +311,6 @@ CONFIG_INPUT=y
 # CONFIG_INPUT_EVBUG is not set
 
 #
-# Input I/O drivers
-#
-# CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
-CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
-CONFIG_SERIO_SERPORT=y
-# CONFIG_SERIO_CT82C710 is not set
-# CONFIG_SERIO_LIBPS2 is not set
-# CONFIG_SERIO_RAW is not set
-
-#
 # Input Device Drivers
 #
 # CONFIG_INPUT_KEYBOARD is not set
@@ -332,6 +320,17 @@ CONFIG_SERIO_SERPORT=y
 # CONFIG_INPUT_MISC is not set
 
 #
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+# CONFIG_SERIO_I8042 is not set
+CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_LIBPS2 is not set
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+
+#
 # Character devices
 #
 # CONFIG_VT is not set
@@ -375,6 +374,10 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_RAW_DRIVER is not set
 
 #
+# TPM devices
+#
+
+#
 # I2C support
 #
 # CONFIG_I2C is not set
@@ -415,10 +418,6 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
-#
-
-#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
@@ -574,8 +573,9 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 #
 # Kernel hacking
 #
+# CONFIG_PRINTK_TIME is not set
 # CONFIG_DEBUG_KERNEL is not set
-CONFIG_DEBUG_PREEMPT=y
+CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_FRAME_POINTER is not set
 
diff -ruNp a/arch/m32r/opsput/defconfig.opsput b/arch/m32r/opsput/defconfig.opsput
--- a/arch/m32r/opsput/defconfig.opsput	2005-03-07 14:10:21.000000000 +0900
+++ b/arch/m32r/opsput/defconfig.opsput	2005-06-03 16:22:06.000000000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.11-rc4
-# Wed Feb 16 21:11:41 2005
+# Linux kernel version: 2.6.12-rc5
+# Fri Jun  3 16:22:06 2005
 #
 CONFIG_M32R=y
 # CONFIG_UID16 is not set
@@ -15,6 +15,7 @@ CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
 
 #
 # General setup
@@ -27,13 +28,15 @@ CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
-CONFIG_LOG_BUF_SHIFT=14
 CONFIG_HOTPLUG=y
 CONFIG_KOBJECT_UEVENT=y
 CONFIG_IKCONFIG=y
 # CONFIG_IKCONFIG_PROC is not set
 CONFIG_EMBEDDED=y
 # CONFIG_KALLSYMS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
@@ -43,6 +46,7 @@ CONFIG_CC_ALIGN_LABELS=0
 CONFIG_CC_ALIGN_LOOPS=0
 CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
 
 #
 # Loadable module support
@@ -64,6 +68,7 @@ CONFIG_KMOD=y
 CONFIG_PLAT_OPSPUT=y
 # CONFIG_PLAT_OAKS32R is not set
 # CONFIG_PLAT_MAPPI2 is not set
+# CONFIG_PLAT_MAPPI3 is not set
 # CONFIG_CHIP_M32700 is not set
 # CONFIG_CHIP_M32102 is not set
 # CONFIG_CHIP_VDEC2 is not set
@@ -243,7 +248,6 @@ CONFIG_NET=y
 #
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
-# CONFIG_NETLINK_DEV is not set
 CONFIG_UNIX=y
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
@@ -368,18 +372,6 @@ CONFIG_INPUT=y
 # CONFIG_INPUT_EVBUG is not set
 
 #
-# Input I/O drivers
-#
-# CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
-CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
-CONFIG_SERIO_SERPORT=y
-# CONFIG_SERIO_CT82C710 is not set
-# CONFIG_SERIO_LIBPS2 is not set
-# CONFIG_SERIO_RAW is not set
-
-#
 # Input Device Drivers
 #
 # CONFIG_INPUT_KEYBOARD is not set
@@ -389,6 +381,17 @@ CONFIG_SERIO_SERPORT=y
 # CONFIG_INPUT_MISC is not set
 
 #
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+# CONFIG_SERIO_I8042 is not set
+CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_LIBPS2 is not set
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+
+#
 # Character devices
 #
 # CONFIG_VT is not set
@@ -438,6 +441,10 @@ CONFIG_DS1302=y
 # CONFIG_RAW_DRIVER is not set
 
 #
+# TPM devices
+#
+
+#
 # I2C support
 #
 # CONFIG_I2C is not set
@@ -478,10 +485,6 @@ CONFIG_DS1302=y
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
-#
-
-#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
@@ -654,8 +657,10 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 #
 # Kernel hacking
 #
+# CONFIG_PRINTK_TIME is not set
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_SPINLOCK is not set

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

