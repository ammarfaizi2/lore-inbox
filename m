Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313083AbSDDBva>; Wed, 3 Apr 2002 20:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313085AbSDDBvW>; Wed, 3 Apr 2002 20:51:22 -0500
Received: from nttsitm05223.ppp.infoweb.ne.jp ([211.133.17.223]:13318 "HELO
	might.dyn.to") by vger.kernel.org with SMTP id <S313083AbSDDBvI>;
	Wed, 3 Apr 2002 20:51:08 -0500
X-Authentication: might was authenticated by nttsitm05223.ppp.infoweb.ne.jp
 at  4 Apr 2002 01:50:44 -0000
X-My-Real-Login-Name: might; localhost
MIME-Version: 1.0
X-Mailer: Denshin 8 Go V32.1.3.1; sp2
Date: Thu, 04 Apr 2002 10:50:30 +0900
From: Hiroyuki Toda <might@might.dyn.to>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] remove AM53C974.c SCSI driver
Message-Id: <20020404015113Z313083-616+5309@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

I send you a patch to remove AM53C974.c SCSI driver.

The dirver is poor and not maintained long time.
There are two drivers handle AM53C974 SCSI controler.
I suggest using tmscsim.c driver instead of it.

The patch is against 2.4.18.


Hiroyuki Toda


diff -ru linux-2.4.18.org/Documentation/Configure.help linux/Documentation/Configure.help
--- linux-2.4.18.org/Documentation/Configure.help	Wed Feb 27 00:15:57 2002
+++ linux/Documentation/Configure.help	Sat Mar 16 15:45:01 2002
@@ -7923,22 +7923,6 @@
 
   If unsure, say N.
 
-AM53/79C974 PCI SCSI support
-CONFIG_SCSI_AM53C974
-  This is support for the AM53/79C974 SCSI host adapters.  Please read
-  <file:drivers/scsi/README.AM53C974> for details.  Also, the
-  SCSI-HOWTO, available from
-  <http://www.linuxdoc.org/docs.html#howto>, is for you.
-
-  Note that there is another driver for AM53C974 based adapters:
-  "Tekram DC390(T) and Am53/79C974 (PCscsi) SCSI support", above.  You
-  can pick either one.
-
-  If you want to compile this driver as a module ( = code which can be
-  inserted in and removed from the running kernel whenever you want),
-  say M here and read <file:Documentation/modules.txt>.  The module
-  will be called AM53C974.o.
-
 AMI MegaRAID support
 CONFIG_SCSI_MEGARAID
   This driver supports the AMI MegaRAID 418, 428, 438, 466, 762, 490
diff -ru linux-2.4.18.org/arch/alpha/defconfig linux/arch/alpha/defconfig
--- linux-2.4.18.org/arch/alpha/defconfig	Tue Nov 27 00:27:27 2001
+++ linux/arch/alpha/defconfig	Sat Mar 16 15:48:06 2002
@@ -315,7 +315,6 @@
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_AM53C974 is not set
 # CONFIG_SCSI_MEGARAID is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_CPQFCTS is not set
diff -ru linux-2.4.18.org/arch/arm/def-configs/rpc linux/arch/arm/def-configs/rpc
--- linux-2.4.18.org/arch/arm/def-configs/rpc	Mon Aug 13 03:13:59 2001
+++ linux/arch/arm/def-configs/rpc	Sat Mar 16 15:45:22 2002
@@ -451,7 +451,6 @@
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_AM53C974 is not set
 # CONFIG_SCSI_MEGARAID is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
diff -ru linux-2.4.18.org/arch/arm/def-configs/shark linux/arch/arm/def-configs/shark
--- linux-2.4.18.org/arch/arm/def-configs/shark	Tue Nov 27 00:27:11 2001
+++ linux/arch/arm/def-configs/shark	Sat Mar 16 15:45:37 2002
@@ -435,7 +435,6 @@
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_AM53C974 is not set
 # CONFIG_SCSI_MEGARAID is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_CPQFCTS is not set
diff -ru linux-2.4.18.org/arch/i386/defconfig linux/arch/i386/defconfig
--- linux-2.4.18.org/arch/i386/defconfig	Wed Feb 27 00:15:58 2002
+++ linux/arch/i386/defconfig	Sat Mar 16 15:47:05 2002
@@ -305,7 +305,6 @@
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_AM53C974 is not set
 # CONFIG_SCSI_MEGARAID is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_CPQFCTS is not set
diff -ru linux-2.4.18.org/arch/ia64/defconfig linux/arch/ia64/defconfig
--- linux-2.4.18.org/arch/ia64/defconfig	Tue Nov 27 00:27:27 2001
+++ linux/arch/ia64/defconfig	Sat Mar 16 15:47:13 2002
@@ -283,7 +283,6 @@
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_AM53C974 is not set
 # CONFIG_SCSI_MEGARAID is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_CPQFCTS is not set
diff -ru linux-2.4.18.org/arch/mips/defconfig linux/arch/mips/defconfig
--- linux-2.4.18.org/arch/mips/defconfig	Mon Sep 10 02:43:02 2001
+++ linux/arch/mips/defconfig	Sat Mar 16 15:47:57 2002
@@ -224,7 +224,6 @@
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_AM53C974 is not set
 # CONFIG_SCSI_MEGARAID is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
diff -ru linux-2.4.18.org/arch/mips/defconfig-atlas linux/arch/mips/defconfig-atlas
--- linux-2.4.18.org/arch/mips/defconfig-atlas	Mon Sep 10 02:43:02 2001
+++ linux/arch/mips/defconfig-atlas	Sat Mar 16 15:47:38 2002
@@ -218,7 +218,6 @@
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_AM53C974 is not set
 # CONFIG_SCSI_MEGARAID is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_CPQFCTS is not set
diff -ru linux-2.4.18.org/arch/mips/defconfig-decstation linux/arch/mips/defconfig-decstation
--- linux-2.4.18.org/arch/mips/defconfig-decstation	Mon Sep 10 02:43:01 2001
+++ linux/arch/mips/defconfig-decstation	Sat Mar 16 15:47:51 2002
@@ -211,7 +211,6 @@
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_AM53C974 is not set
 # CONFIG_SCSI_MEGARAID is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
diff -ru linux-2.4.18.org/arch/mips/defconfig-ip22 linux/arch/mips/defconfig-ip22
--- linux-2.4.18.org/arch/mips/defconfig-ip22	Mon Sep 10 02:43:02 2001
+++ linux/arch/mips/defconfig-ip22	Sat Mar 16 15:47:24 2002
@@ -224,7 +224,6 @@
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_AM53C974 is not set
 # CONFIG_SCSI_MEGARAID is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
diff -ru linux-2.4.18.org/arch/mips/defconfig-malta linux/arch/mips/defconfig-malta
--- linux-2.4.18.org/arch/mips/defconfig-malta	Mon Sep 10 02:43:02 2001
+++ linux/arch/mips/defconfig-malta	Sat Mar 16 15:47:44 2002
@@ -218,7 +218,6 @@
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_AM53C974 is not set
 # CONFIG_SCSI_MEGARAID is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_CPQFCTS is not set
diff -ru linux-2.4.18.org/arch/mips64/defconfig linux/arch/mips64/defconfig
--- linux-2.4.18.org/arch/mips64/defconfig	Mon Sep 10 02:43:02 2001
+++ linux/arch/mips64/defconfig	Sat Mar 16 15:48:37 2002
@@ -189,7 +189,6 @@
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_AM53C974 is not set
 # CONFIG_SCSI_MEGARAID is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_CPQFCTS is not set
diff -ru linux-2.4.18.org/arch/mips64/defconfig-ip22 linux/arch/mips64/defconfig-ip22
--- linux-2.4.18.org/arch/mips64/defconfig-ip22	Mon Sep 10 02:43:02 2001
+++ linux/arch/mips64/defconfig-ip22	Sat Mar 16 15:48:17 2002
@@ -197,7 +197,6 @@
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_AM53C974 is not set
 # CONFIG_SCSI_MEGARAID is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
diff -ru linux-2.4.18.org/arch/mips64/defconfig-ip27 linux/arch/mips64/defconfig-ip27
--- linux-2.4.18.org/arch/mips64/defconfig-ip27	Mon Sep 10 02:43:02 2001
+++ linux/arch/mips64/defconfig-ip27	Sat Mar 16 16:02:17 2002
@@ -189,7 +189,6 @@
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_AM53C974 is not set
 # CONFIG_SCSI_MEGARAID is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_CPQFCTS is not set
diff -ru linux-2.4.18.org/arch/mips64/defconfig-ip32 linux/arch/mips64/defconfig-ip32
--- linux-2.4.18.org/arch/mips64/defconfig-ip32	Mon Sep 10 02:43:02 2001
+++ linux/arch/mips64/defconfig-ip32	Sat Mar 16 15:48:31 2002
@@ -193,7 +193,6 @@
 # CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_AM53C974 is not set
 # CONFIG_SCSI_MEGARAID is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_CPQFCTS is not set
diff -ru linux-2.4.18.org/arch/ppc/configs/apus_defconfig linux/arch/ppc/configs/apus_defconfig
--- linux-2.4.18.org/arch/ppc/configs/apus_defconfig	Tue Nov 27 00:27:11 2001
+++ linux/arch/ppc/configs/apus_defconfig	Sat Mar 16 15:46:46 2002
@@ -309,7 +309,6 @@
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_AM53C974 is not set
 # CONFIG_SCSI_MEGARAID is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_CPQFCTS is not set
diff -ru linux-2.4.18.org/arch/ppc/configs/common_defconfig linux/arch/ppc/configs/common_defconfig
--- linux-2.4.18.org/arch/ppc/configs/common_defconfig	Wed Feb 27 00:15:58 2002
+++ linux/arch/ppc/configs/common_defconfig	Sat Mar 16 15:46:22 2002
@@ -327,7 +327,6 @@
 # CONFIG_SCSI_DPT_I2O is not set
 CONFIG_SCSI_ADVANSYS=m
 # CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_AM53C974 is not set
 # CONFIG_SCSI_MEGARAID is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_CPQFCTS is not set
diff -ru linux-2.4.18.org/arch/ppc/configs/gemini_defconfig linux/arch/ppc/configs/gemini_defconfig
--- linux-2.4.18.org/arch/ppc/configs/gemini_defconfig	Wed Feb 27 00:15:58 2002
+++ linux/arch/ppc/configs/gemini_defconfig	Sat Mar 16 15:45:49 2002
@@ -205,7 +205,6 @@
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_AM53C974 is not set
 # CONFIG_SCSI_MEGARAID is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_CPQFCTS is not set
diff -ru linux-2.4.18.org/arch/ppc/configs/ibmchrp_defconfig linux/arch/ppc/configs/ibmchrp_defconfig
--- linux-2.4.18.org/arch/ppc/configs/ibmchrp_defconfig	Wed Feb 27 00:15:58 2002
+++ linux/arch/ppc/configs/ibmchrp_defconfig	Sat Mar 16 15:46:14 2002
@@ -236,7 +236,6 @@
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_AM53C974 is not set
 # CONFIG_SCSI_MEGARAID is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_CPQFCTS is not set
diff -ru linux-2.4.18.org/arch/ppc/configs/pmac_defconfig linux/arch/ppc/configs/pmac_defconfig
--- linux-2.4.18.org/arch/ppc/configs/pmac_defconfig	Wed Feb 27 00:15:58 2002
+++ linux/arch/ppc/configs/pmac_defconfig	Sat Mar 16 15:46:36 2002
@@ -330,7 +330,6 @@
 # CONFIG_SCSI_DPT_I2O is not set
 CONFIG_SCSI_ADVANSYS=m
 # CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_AM53C974 is not set
 # CONFIG_SCSI_MEGARAID is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_CPQFCTS is not set
diff -ru linux-2.4.18.org/arch/ppc/configs/power3_defconfig linux/arch/ppc/configs/power3_defconfig
--- linux-2.4.18.org/arch/ppc/configs/power3_defconfig	Wed Feb 27 00:15:58 2002
+++ linux/arch/ppc/configs/power3_defconfig	Sat Mar 16 15:46:29 2002
@@ -207,7 +207,6 @@
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_AM53C974 is not set
 # CONFIG_SCSI_MEGARAID is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_CPQFCTS is not set
diff -ru linux-2.4.18.org/arch/ppc/defconfig linux/arch/ppc/defconfig
--- linux-2.4.18.org/arch/ppc/defconfig	Wed Feb 27 00:15:58 2002
+++ linux/arch/ppc/defconfig	Sat Mar 16 15:46:53 2002
@@ -327,7 +327,6 @@
 # CONFIG_SCSI_DPT_I2O is not set
 CONFIG_SCSI_ADVANSYS=m
 # CONFIG_SCSI_IN2000 is not set
-# CONFIG_SCSI_AM53C974 is not set
 # CONFIG_SCSI_MEGARAID is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_CPQFCTS is not set
Only in linux-2.4.18.org/drivers/scsi: AM53C974.c
Only in linux-2.4.18.org/drivers/scsi: AM53C974.h
diff -ru linux-2.4.18.org/drivers/scsi/Config.in linux/drivers/scsi/Config.in
--- linux-2.4.18.org/drivers/scsi/Config.in	Wed Feb 27 00:16:02 2002
+++ linux/drivers/scsi/Config.in	Sat Mar 16 15:50:13 2002
@@ -65,7 +65,6 @@
 dep_tristate 'Adaptec I2O RAID support ' CONFIG_SCSI_DPT_I2O $CONFIG_SCSI
 dep_tristate 'AdvanSys SCSI support' CONFIG_SCSI_ADVANSYS $CONFIG_SCSI
 dep_tristate 'Always IN2000 SCSI support' CONFIG_SCSI_IN2000 $CONFIG_SCSI
-dep_tristate 'AM53/79C974 PCI SCSI support' CONFIG_SCSI_AM53C974 $CONFIG_SCSI $CONFIG_PCI
 dep_tristate 'AMI MegaRAID support' CONFIG_SCSI_MEGARAID $CONFIG_SCSI
 
 dep_tristate 'BusLogic SCSI support' CONFIG_SCSI_BUSLOGIC $CONFIG_SCSI
diff -ru linux-2.4.18.org/drivers/scsi/Makefile linux/drivers/scsi/Makefile
--- linux-2.4.18.org/drivers/scsi/Makefile	Wed Feb 27 00:16:02 2002
+++ linux/drivers/scsi/Makefile	Sat Mar 16 15:49:38 2002
@@ -104,7 +104,6 @@
 obj-$(CONFIG_SCSI_IBMMCA)	+= ibmmca.o
 obj-$(CONFIG_SCSI_EATA)		+= eata.o
 obj-$(CONFIG_SCSI_DC390T)	+= tmscsim.o
-obj-$(CONFIG_SCSI_AM53C974)	+= AM53C974.o
 obj-$(CONFIG_SCSI_MEGARAID)	+= megaraid.o
 obj-$(CONFIG_SCSI_ACARD)	+= atp870u.o
 obj-$(CONFIG_SCSI_SUNESP)	+= esp.o
Only in linux-2.4.18.org/drivers/scsi: README.AM53C974
