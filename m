Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264647AbSLNRt5>; Sat, 14 Dec 2002 12:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265426AbSLNRt4>; Sat, 14 Dec 2002 12:49:56 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:30391 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S264647AbSLNRtF>; Sat, 14 Dec 2002 12:49:05 -0500
Message-ID: <3DFB70DA.60400@quark.didntduck.org>
Date: Sat, 14 Dec 2002 12:56:42 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>, kai@tp1.ruhr-uni-bochum.de
Subject: [PATCH] Remove Rules.make from Makefiles (2/3)
Content-Type: multipart/mixed;
 boundary="------------060405090501060708020104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060405090501060708020104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Makefiles no longer need to include Rules.make, which is currently an 
empty file.  This patch removes it from the drivers tree Makefiles.

--------------060405090501060708020104
Content-Type: text/plain;
 name="rules.make-drivers-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rules.make-drivers-1"

diff -urN linux-2.5.51-bk1/drivers/Makefile linux/drivers/Makefile
--- linux-2.5.51-bk1/drivers/Makefile	Sat Dec 14 12:32:10 2002
+++ linux/drivers/Makefile	Sat Dec 14 12:38:56 2002
@@ -44,5 +44,3 @@
 obj-$(CONFIG_HOTPLUG_PCI)	+= hotplug/
 obj-$(CONFIG_ISDN_BOOL)		+= isdn/
 obj-$(CONFIG_MCA)		+= mca/
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/acorn/block/Makefile linux/drivers/acorn/block/Makefile
--- linux-2.5.51-bk1/drivers/acorn/block/Makefile	Sun Sep 15 22:18:28 2002
+++ linux/drivers/acorn/block/Makefile	Sat Dec 14 12:38:56 2002
@@ -7,5 +7,3 @@
 
 obj-$(CONFIG_BLK_DEV_FD1772)	+= fd1772_mod.o
 obj-$(CONFIG_BLK_DEV_MFM)	+= mfmhd_mod.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/acorn/char/Makefile linux/drivers/acorn/char/Makefile
--- linux-2.5.51-bk1/drivers/acorn/char/Makefile	Sat Dec 14 12:32:06 2002
+++ linux/drivers/acorn/char/Makefile	Sat Dec 14 12:38:56 2002
@@ -8,8 +8,6 @@
 obj-$(CONFIG_L7200_KEYB)	+= defkeymap-l7200.o keyb_l7200.o
 obj-y				+= $(obj-$(MACHINE))
 
-include $(TOPDIR)/Rules.make
-
 $(obj)/defkeymap-acorn.o: $(obj)/defkeymap-acorn.c
 
 # Uncomment if you're changing the keymap and have an appropriate
diff -urN linux-2.5.51-bk1/drivers/acorn/net/Makefile linux/drivers/acorn/net/Makefile
--- linux-2.5.51-bk1/drivers/acorn/net/Makefile	Sun Sep 15 22:18:38 2002
+++ linux/drivers/acorn/net/Makefile	Sat Dec 14 12:38:56 2002
@@ -6,5 +6,3 @@
 obj-$(CONFIG_ARM_ETHERH)	+= etherh.o
 obj-$(CONFIG_ARM_ETHER3)	+= ether3.o
 obj-$(CONFIG_ARM_ETHER1)	+= ether1.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/acorn/scsi/Makefile linux/drivers/acorn/scsi/Makefile
--- linux-2.5.51-bk1/drivers/acorn/scsi/Makefile	Sun Sep 15 22:18:17 2002
+++ linux/drivers/acorn/scsi/Makefile	Sat Dec 14 12:38:56 2002
@@ -13,5 +13,3 @@
 obj-$(CONFIG_SCSI_OAK1)		+= oak.o
 obj-$(CONFIG_SCSI_POWERTECSCSI)	+= powertec.o fas216.o queue.o msgqueue.o
 obj-$(CONFIG_SCSI_EESOXSCSI)	+= eesox.o fas216.o queue.o msgqueue.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/acpi/Makefile linux/drivers/acpi/Makefile
--- linux-2.5.51-bk1/drivers/acpi/Makefile	Sat Dec 14 12:31:59 2002
+++ linux/drivers/acpi/Makefile	Sat Dec 14 12:38:56 2002
@@ -48,5 +48,3 @@
 obj-$(CONFIG_ACPI_NUMA)		+= numa.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
 obj-$(CONFIG_ACPI_BUS)		+= scan.o 
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/acpi/dispatcher/Makefile linux/drivers/acpi/dispatcher/Makefile
--- linux-2.5.51-bk1/drivers/acpi/dispatcher/Makefile	Sat Dec 14 12:32:10 2002
+++ linux/drivers/acpi/dispatcher/Makefile	Sat Dec 14 12:38:56 2002
@@ -7,5 +7,3 @@
 	 dsinit.o
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/acpi/events/Makefile linux/drivers/acpi/events/Makefile
--- linux-2.5.51-bk1/drivers/acpi/events/Makefile	Sat Dec 14 12:32:10 2002
+++ linux/drivers/acpi/events/Makefile	Sat Dec 14 12:38:56 2002
@@ -7,5 +7,3 @@
 	 evgpe.o
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/acpi/executer/Makefile linux/drivers/acpi/executer/Makefile
--- linux-2.5.51-bk1/drivers/acpi/executer/Makefile	Sat Dec 14 12:31:37 2002
+++ linux/drivers/acpi/executer/Makefile	Sat Dec 14 12:38:56 2002
@@ -8,5 +8,3 @@
 	 exdump.o    exmutex.o  exoparg3.o  exresnte.o  exstoren.o
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/acpi/hardware/Makefile linux/drivers/acpi/hardware/Makefile
--- linux-2.5.51-bk1/drivers/acpi/hardware/Makefile	Sat Dec 14 12:31:37 2002
+++ linux/drivers/acpi/hardware/Makefile	Sat Dec 14 12:38:56 2002
@@ -5,5 +5,3 @@
 obj-y := hwacpi.o  hwgpe.o  hwregs.o  hwsleep.o  hwtimer.o
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/acpi/namespace/Makefile linux/drivers/acpi/namespace/Makefile
--- linux-2.5.51-bk1/drivers/acpi/namespace/Makefile	Sat Dec 14 12:32:10 2002
+++ linux/drivers/acpi/namespace/Makefile	Sat Dec 14 12:38:56 2002
@@ -8,5 +8,3 @@
 	 nsparse.o
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/acpi/parser/Makefile linux/drivers/acpi/parser/Makefile
--- linux-2.5.51-bk1/drivers/acpi/parser/Makefile	Sat Dec 14 12:31:37 2002
+++ linux/drivers/acpi/parser/Makefile	Sat Dec 14 12:38:56 2002
@@ -6,5 +6,3 @@
 	 psopcode.o  psscope.o  psutils.o  psxface.o
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/acpi/resources/Makefile linux/drivers/acpi/resources/Makefile
--- linux-2.5.51-bk1/drivers/acpi/resources/Makefile	Sat Dec 14 12:31:37 2002
+++ linux/drivers/acpi/resources/Makefile	Sat Dec 14 12:38:56 2002
@@ -6,5 +6,3 @@
 	 rscalc.o  rsdump.o    rsirq.o  rsmemory.o  rsutils.o
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/acpi/tables/Makefile linux/drivers/acpi/tables/Makefile
--- linux-2.5.51-bk1/drivers/acpi/tables/Makefile	Sat Dec 14 12:31:37 2002
+++ linux/drivers/acpi/tables/Makefile	Sat Dec 14 12:38:56 2002
@@ -6,5 +6,3 @@
 	 tbgetall.o  tbinstal.o  tbutils.o  tbxfroot.o
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/acpi/utilities/Makefile linux/drivers/acpi/utilities/Makefile
--- linux-2.5.51-bk1/drivers/acpi/utilities/Makefile	Sat Dec 14 12:31:37 2002
+++ linux/drivers/acpi/utilities/Makefile	Sat Dec 14 12:38:56 2002
@@ -6,5 +6,3 @@
 	 utcopy.o   utdelete.o  utglobal.o  utmath.o  utobject.o
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/atm/Makefile linux/drivers/atm/Makefile
--- linux-2.5.51-bk1/drivers/atm/Makefile	Sat Dec 14 12:31:48 2002
+++ linux/drivers/atm/Makefile	Sat Dec 14 12:38:56 2002
@@ -51,8 +51,6 @@
   endif
 endif
 
-include $(TOPDIR)/Rules.make
-
 # FORE Systems 200E-series firmware magic
 $(obj)/fore200e_pca_fw.c: $(patsubst "%", %, $(CONFIG_ATM_FORE200E_PCA_FW)) \
 			  $(obj)/fore200e_mkfirm
diff -urN linux-2.5.51-bk1/drivers/base/Makefile linux/drivers/base/Makefile
--- linux-2.5.51-bk1/drivers/base/Makefile	Sat Dec 14 12:31:59 2002
+++ linux/drivers/base/Makefile	Sat Dec 14 12:38:56 2002
@@ -12,5 +12,3 @@
 
 export-objs	:= core.o power.o sys.o bus.o driver.o \
 			class.o intf.o platform.o firmware.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/base/fs/Makefile linux/drivers/base/fs/Makefile
--- linux-2.5.51-bk1/drivers/base/fs/Makefile	Sat Dec 14 12:31:59 2002
+++ linux/drivers/base/fs/Makefile	Sat Dec 14 12:38:56 2002
@@ -1,5 +1,3 @@
 obj-y		:= device.o
 
 export-objs	:= device.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/block/Makefile linux/drivers/block/Makefile
--- linux-2.5.51-bk1/drivers/block/Makefile	Sat Dec 14 12:31:42 2002
+++ linux/drivers/block/Makefile	Sat Dec 14 12:38:56 2002
@@ -31,5 +31,3 @@
 
 obj-$(CONFIG_BLK_DEV_UMEM)	+= umem.o
 obj-$(CONFIG_BLK_DEV_NBD)	+= nbd.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/block/paride/Makefile linux/drivers/block/paride/Makefile
--- linux-2.5.51-bk1/drivers/block/paride/Makefile	Sun Sep 15 22:18:26 2002
+++ linux/drivers/block/paride/Makefile	Sat Dec 14 12:38:56 2002
@@ -28,5 +28,3 @@
 obj-$(CONFIG_PARIDE_PF)		+= pf.o
 obj-$(CONFIG_PARIDE_PT)		+= pt.o
 obj-$(CONFIG_PARIDE_PG)		+= pg.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/bluetooth/Makefile linux/drivers/bluetooth/Makefile
--- linux-2.5.51-bk1/drivers/bluetooth/Makefile	Sat Dec 14 12:31:44 2002
+++ linux/drivers/bluetooth/Makefile	Sat Dec 14 12:38:56 2002
@@ -13,5 +13,3 @@
 hci_uart-$(CONFIG_BT_HCIUART_H4)	+= hci_h4.o
 hci_uart-$(CONFIG_BT_HCIUART_BCSP)	+= hci_bcsp.o
 hci_uart-objs				:= $(hci_uart-y)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/cdrom/Makefile linux/drivers/cdrom/Makefile
--- linux-2.5.51-bk1/drivers/cdrom/Makefile	Sun Sep 15 22:18:28 2002
+++ linux/drivers/cdrom/Makefile	Sat Dec 14 12:38:56 2002
@@ -36,7 +36,3 @@
 obj-$(CONFIG_SBPCD)		+= sbpcd.o      cdrom.o
 obj-$(CONFIG_SJCD)		+= sjcd.o
 obj-$(CONFIG_CDU535)		+= sonycd535.o
-
-# Hand off to Rules.make.
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/char/Makefile linux/drivers/char/Makefile
--- linux-2.5.51-bk1/drivers/char/Makefile	Sat Dec 14 12:32:10 2002
+++ linux/drivers/char/Makefile	Sat Dec 14 12:38:56 2002
@@ -87,8 +87,6 @@
 # Files generated that shall be removed upon make clean
 clean-files := consolemap_deftbl.c defkeymap.c qtronixmap.c
 
-include $(TOPDIR)/Rules.make
-
 $(obj)/consolemap_deftbl.c: $(src)/$(FONTMAPFILE)
 	$(call do_cmd,CONMK  $@,$(objtree)/scripts/conmakehash $< > $@)
 
diff -urN linux-2.5.51-bk1/drivers/char/drm/Makefile linux/drivers/char/drm/Makefile
--- linux-2.5.51-bk1/drivers/char/drm/Makefile	Sat Dec 14 12:32:02 2002
+++ linux/drivers/char/drm/Makefile	Sat Dec 14 12:38:56 2002
@@ -19,5 +19,3 @@
 obj-$(CONFIG_DRM_I810)	+= i810.o
 obj-$(CONFIG_DRM_I830)	+= i830.o
 obj-$(CONFIG_DRM_FFB)   += ffb.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/char/ftape/Makefile linux/drivers/char/ftape/Makefile
--- linux-2.5.51-bk1/drivers/char/ftape/Makefile	Sun Sep 15 22:18:51 2002
+++ linux/drivers/char/ftape/Makefile	Sat Dec 14 12:38:56 2002
@@ -26,5 +26,3 @@
 obj-$(CONFIG_FTAPE)		+= lowlevel/
 obj-$(CONFIG_ZFTAPE)		+= zftape/
 obj-$(CONFIG_ZFT_COMPRESSOR)	+= compressor/
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/char/ftape/compressor/Makefile linux/drivers/char/ftape/compressor/Makefile
--- linux-2.5.51-bk1/drivers/char/ftape/compressor/Makefile	Sun Sep 15 22:18:26 2002
+++ linux/drivers/char/ftape/compressor/Makefile	Sat Dec 14 12:38:56 2002
@@ -29,5 +29,3 @@
 zft-compressor-objs := zftape-compress.o lzrw3.o
 
 CFLAGS_lzrw3.o	:= -O6 -funroll-all-loops
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/char/ftape/lowlevel/Makefile linux/drivers/char/ftape/lowlevel/Makefile
--- linux-2.5.51-bk1/drivers/char/ftape/lowlevel/Makefile	Sun Sep 15 22:18:25 2002
+++ linux/drivers/char/ftape/lowlevel/Makefile	Sat Dec 14 12:38:56 2002
@@ -43,6 +43,3 @@
 ifeq ($(CONFIG_FT_PROC_FS),y)
 ftape-objs += ftape-proc.o
 endif
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/drivers/char/ftape/zftape/Makefile linux/drivers/char/ftape/zftape/Makefile
--- linux-2.5.51-bk1/drivers/char/ftape/zftape/Makefile	Sun Sep 15 22:18:46 2002
+++ linux/drivers/char/ftape/zftape/Makefile	Sat Dec 14 12:38:56 2002
@@ -36,6 +36,3 @@
 	       zftape-init.o zftape-buffers.o zftape_syms.o
 
 EXTRA_CFLAGS := -DZFT_OBSOLETE
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/drivers/char/mwave/Makefile linux/drivers/char/mwave/Makefile
--- linux-2.5.51-bk1/drivers/char/mwave/Makefile	Sun Sep 15 22:18:23 2002
+++ linux/drivers/char/mwave/Makefile	Sat Dec 14 12:38:56 2002
@@ -13,5 +13,3 @@
 
 # To compile in lots (~20 KiB) of run-time enablable printk()s for debugging:
 EXTRA_CFLAGS += -DMW_TRACE
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/char/pcmcia/Makefile linux/drivers/char/pcmcia/Makefile
--- linux-2.5.51-bk1/drivers/char/pcmcia/Makefile	Sun Sep 15 22:18:41 2002
+++ linux/drivers/char/pcmcia/Makefile	Sat Dec 14 12:38:56 2002
@@ -5,5 +5,3 @@
 #
 
 obj-$(CONFIG_SYNCLINK_CS) += synclink_cs.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/char/rio/Makefile linux/drivers/char/rio/Makefile
--- linux-2.5.51-bk1/drivers/char/rio/Makefile	Sun Sep 15 22:18:21 2002
+++ linux/drivers/char/rio/Makefile	Sat Dec 14 12:38:56 2002
@@ -10,5 +10,3 @@
 
 rio-objs := rio_linux.o rioinit.o rioboot.o riocmd.o rioctrl.o riointr.o \
             rioparam.o riopcicopy.o rioroute.o riotable.o riotty.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/char/watchdog/Makefile linux/drivers/char/watchdog/Makefile
--- linux-2.5.51-bk1/drivers/char/watchdog/Makefile	Sat Dec 14 12:32:07 2002
+++ linux/drivers/char/watchdog/Makefile	Sat Dec 14 12:38:56 2002
@@ -23,5 +23,3 @@
 obj-$(CONFIG_SH_WDT) += shwdt.o
 obj-$(CONFIG_EUROTECH_WDT) += eurotechwdt.o
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/dio/Makefile linux/drivers/dio/Makefile
--- linux-2.5.51-bk1/drivers/dio/Makefile	Sun Sep 15 22:18:24 2002
+++ linux/drivers/dio/Makefile	Sat Dec 14 12:38:56 2002
@@ -3,5 +3,3 @@
 #
 
 obj-y := dio.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/fc4/Makefile linux/drivers/fc4/Makefile
--- linux-2.5.51-bk1/drivers/fc4/Makefile	Sun Sep 15 22:18:28 2002
+++ linux/drivers/fc4/Makefile	Sat Dec 14 12:38:56 2002
@@ -9,5 +9,3 @@
 obj-$(CONFIG_FC4) += fc4.o
 obj-$(CONFIG_FC4_SOC) += soc.o
 obj-$(CONFIG_FC4_SOCAL) += socal.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/hotplug/Makefile linux/drivers/hotplug/Makefile
--- linux-2.5.51-bk1/drivers/hotplug/Makefile	Sat Dec 14 12:32:11 2002
+++ linux/drivers/hotplug/Makefile	Sat Dec 14 12:38:56 2002
@@ -45,6 +45,3 @@
 ifeq ($(CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM),y)
 	cpqphp-objs += cpqphp_nvram.o
 endif
-
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/i2c/Makefile linux/drivers/i2c/Makefile
--- linux-2.5.51-bk1/drivers/i2c/Makefile	Sat Dec 14 12:31:38 2002
+++ linux/drivers/i2c/Makefile	Sat Dec 14 12:38:56 2002
@@ -21,6 +21,3 @@
 
 # This is needed for automatic patch generation: sensors code starts here
 # This is needed for automatic patch generation: sensors code ends here
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/drivers/ide/Makefile linux/drivers/ide/Makefile
--- linux-2.5.51-bk1/drivers/ide/Makefile	Sat Dec 14 12:32:07 2002
+++ linux/drivers/ide/Makefile	Sat Dec 14 12:38:56 2002
@@ -30,5 +30,3 @@
 endif
 
 obj-$(CONFIG_BLK_DEV_IDE)		+= legacy/ ppc/ arm/
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/ide/arm/Makefile linux/drivers/ide/arm/Makefile
--- linux-2.5.51-bk1/drivers/ide/arm/Makefile	Sat Dec 14 12:31:38 2002
+++ linux/drivers/ide/arm/Makefile	Sat Dec 14 12:38:56 2002
@@ -3,5 +3,3 @@
 obj-$(CONFIG_BLK_DEV_IDE_RAPIDE)	+= rapide.o
 
 EXTRA_CFLAGS	:= -Idrivers/ide
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/ide/legacy/Makefile linux/drivers/ide/legacy/Makefile
--- linux-2.5.51-bk1/drivers/ide/legacy/Makefile	Sat Dec 14 12:31:38 2002
+++ linux/drivers/ide/legacy/Makefile	Sat Dec 14 12:38:56 2002
@@ -18,5 +18,3 @@
 obj-$(CONFIG_BLK_DEV_HD)		+= hd.o
 
 EXTRA_CFLAGS	:= -Idrivers/ide
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/ide/pci/Makefile linux/drivers/ide/pci/Makefile
--- linux-2.5.51-bk1/drivers/ide/pci/Makefile	Sat Dec 14 12:32:07 2002
+++ linux/drivers/ide/pci/Makefile	Sat Dec 14 12:38:56 2002
@@ -34,5 +34,3 @@
 obj-$(CONFIG_BLK_DEV_GENERIC)          += generic.o
 
 EXTRA_CFLAGS	:= -Idrivers/ide
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/ide/ppc/Makefile linux/drivers/ide/ppc/Makefile
--- linux-2.5.51-bk1/drivers/ide/ppc/Makefile	Sat Dec 14 12:31:38 2002
+++ linux/drivers/ide/ppc/Makefile	Sat Dec 14 12:38:56 2002
@@ -4,5 +4,3 @@
 obj-$(CONFIG_BLK_DEV_IDE_SWARM)		+= swarm.o
 
 EXTRA_CFLAGS	:= -Idrivers/ide
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/ieee1394/Makefile linux/drivers/ieee1394/Makefile
--- linux-2.5.51-bk1/drivers/ieee1394/Makefile	Sat Dec 14 12:31:33 2002
+++ linux/drivers/ieee1394/Makefile	Sat Dec 14 12:38:56 2002
@@ -17,5 +17,3 @@
 obj-$(CONFIG_IEEE1394_ETH1394) += eth1394.o
 obj-$(CONFIG_IEEE1394_AMDTP) += amdtp.o
 obj-$(CONFIG_IEEE1394_CMP) += cmp.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/input/Makefile linux/drivers/input/Makefile
--- linux-2.5.51-bk1/drivers/input/Makefile	Sun Sep 15 22:18:55 2002
+++ linux/drivers/input/Makefile	Sat Dec 14 12:38:56 2002
@@ -21,7 +21,3 @@
 obj-$(CONFIG_INPUT_JOYSTICK)	+= joystick/
 obj-$(CONFIG_INPUT_TOUCHSCREEN)	+= touchscreen/
 obj-$(CONFIG_INPUT_MISC)	+= misc/
-
-# The global Rules.make.
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/input/gameport/Makefile linux/drivers/input/gameport/Makefile
--- linux-2.5.51-bk1/drivers/input/gameport/Makefile	Sun Sep 15 22:18:16 2002
+++ linux/drivers/input/gameport/Makefile	Sat Dec 14 12:38:56 2002
@@ -15,7 +15,3 @@
 obj-$(CONFIG_GAMEPORT_L4)	+= lightning.o
 obj-$(CONFIG_GAMEPORT_NS558)	+= ns558.o
 obj-$(CONFIG_GAMEPORT_VORTEX)	+= vortex.o
-
-# The global Rules.make.
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/input/joystick/Makefile linux/drivers/input/joystick/Makefile
--- linux-2.5.51-bk1/drivers/input/joystick/Makefile	Sun Sep 15 22:18:43 2002
+++ linux/drivers/input/joystick/Makefile	Sat Dec 14 12:38:56 2002
@@ -28,7 +28,3 @@
 obj-$(CONFIG_JOYSTICK_WARRIOR)		+= warrior.o
 
 obj-$(CONFIG_JOYSTICK_IFORCE)		+= iforce/
-
-# The global Rules.make.
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/input/joystick/iforce/Makefile linux/drivers/input/joystick/iforce/Makefile
--- linux-2.5.51-bk1/drivers/input/joystick/iforce/Makefile	Sat Dec 14 12:31:38 2002
+++ linux/drivers/input/joystick/iforce/Makefile	Sat Dec 14 12:38:56 2002
@@ -18,7 +18,3 @@
 endif
 
 EXTRA_CFLAGS = -Werror-implicit-function-declaration
-
-# The global Rules.make.
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/input/keyboard/Makefile linux/drivers/input/keyboard/Makefile
--- linux-2.5.51-bk1/drivers/input/keyboard/Makefile	Sun Sep 15 22:18:27 2002
+++ linux/drivers/input/keyboard/Makefile	Sat Dec 14 12:38:56 2002
@@ -10,7 +10,3 @@
 obj-$(CONFIG_KEYBOARD_XTKBD)		+= xtkbd.o
 obj-$(CONFIG_KEYBOARD_AMIGA)		+= amikbd.o
 obj-$(CONFIG_KEYBOARD_NEWTON)		+= newtonkbd.o
-
-# The global Rules.make.
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/input/mouse/Makefile linux/drivers/input/mouse/Makefile
--- linux-2.5.51-bk1/drivers/input/mouse/Makefile	Sat Dec 14 12:32:01 2002
+++ linux/drivers/input/mouse/Makefile	Sat Dec 14 12:38:56 2002
@@ -12,7 +12,3 @@
 obj-$(CONFIG_MOUSE_PC110PAD)	+= pc110pad.o
 obj-$(CONFIG_MOUSE_PS2)		+= psmouse.o
 obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
-
-# The global Rules.make.
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/input/serio/Makefile linux/drivers/input/serio/Makefile
--- linux-2.5.51-bk1/drivers/input/serio/Makefile	Sun Sep 15 22:18:18 2002
+++ linux/drivers/input/serio/Makefile	Sat Dec 14 12:38:56 2002
@@ -17,7 +17,3 @@
 obj-$(CONFIG_SERIO_SA1111)	+= sa1111ps2.o
 obj-$(CONFIG_SERIO_AMBAKMI)	+= ambakmi.o
 obj-$(CONFIG_SERIO_Q40KBD)	+= q40kbd.o
-
-# The global Rules.make.
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/input/touchscreen/Makefile linux/drivers/input/touchscreen/Makefile
--- linux-2.5.51-bk1/drivers/input/touchscreen/Makefile	Sun Sep 15 22:18:52 2002
+++ linux/drivers/input/touchscreen/Makefile	Sat Dec 14 12:38:56 2002
@@ -6,7 +6,3 @@
 
 obj-$(CONFIG_TOUCHSCREEN_BITSY)	+= h3600_ts_input.o
 obj-$(CONFIG_TOUCHSCREEN_GUNZE)	+= gunze.o
-
-# The global Rules.make.
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/macintosh/Makefile linux/drivers/macintosh/Makefile
--- linux-2.5.51-bk1/drivers/macintosh/Makefile	Sat Dec 14 12:32:01 2002
+++ linux/drivers/macintosh/Makefile	Sat Dec 14 12:38:56 2002
@@ -34,8 +34,3 @@
 obj-$(CONFIG_ADB_IOP)		+= adb-iop.o
 obj-$(CONFIG_ADB_PMU68K)	+= via-pmu68k.o
 obj-$(CONFIG_ADB_MACIO)		+= macio-adb.o
-
-# The global Rules.make.
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/drivers/mca/Makefile linux/drivers/mca/Makefile
--- linux-2.5.51-bk1/drivers/mca/Makefile	Sat Dec 14 12:32:11 2002
+++ linux/drivers/mca/Makefile	Sat Dec 14 12:38:56 2002
@@ -6,5 +6,3 @@
 obj-$(CONFIG_MCA_LEGACY)	+= mca-legacy.o
 
 export-objs	:= mca-bus.o mca-legacy.o mca-proc.o mca-driver.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/md/Makefile linux/drivers/md/Makefile
--- linux-2.5.51-bk1/drivers/md/Makefile	Sat Dec 14 12:31:48 2002
+++ linux/drivers/md/Makefile	Sat Dec 14 12:38:56 2002
@@ -18,6 +18,3 @@
 obj-$(CONFIG_MD_MULTIPATH)	+= multipath.o
 obj-$(CONFIG_BLK_DEV_MD)	+= md.o
 obj-$(CONFIG_BLK_DEV_DM)	+= dm-mod.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/drivers/media/Makefile linux/drivers/media/Makefile
--- linux-2.5.51-bk1/drivers/media/Makefile	Sat Dec 14 12:31:48 2002
+++ linux/drivers/media/Makefile	Sat Dec 14 12:38:56 2002
@@ -3,5 +3,3 @@
 #
 
 obj-y        := video/ radio/ dvb/
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/media/dvb/Makefile linux/drivers/media/dvb/Makefile
--- linux-2.5.51-bk1/drivers/media/dvb/Makefile	Sat Dec 14 12:31:48 2002
+++ linux/drivers/media/dvb/Makefile	Sat Dec 14 12:38:56 2002
@@ -3,5 +3,3 @@
 #
 
 obj-y        := dvb-core/ frontends/ av7110/
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/media/dvb/av7110/Makefile linux/drivers/media/dvb/av7110/Makefile
--- linux-2.5.51-bk1/drivers/media/dvb/av7110/Makefile	Sat Dec 14 12:32:07 2002
+++ linux/drivers/media/dvb/av7110/Makefile	Sat Dec 14 12:38:56 2002
@@ -7,6 +7,3 @@
 obj-$(CONFIG_DVB_AV7110) += dvb-ttpci.o
 
 EXTRA_CFLAGS = -Idrivers/media/dvb/dvb-core/
-
-include $(TOPDIR)/Rules.make 
-
diff -urN linux-2.5.51-bk1/drivers/media/dvb/dvb-core/Makefile linux/drivers/media/dvb/dvb-core/Makefile
--- linux-2.5.51-bk1/drivers/media/dvb/dvb-core/Makefile	Sat Dec 14 12:31:48 2002
+++ linux/drivers/media/dvb/dvb-core/Makefile	Sat Dec 14 12:38:56 2002
@@ -8,6 +8,3 @@
 		dvb_frontend.o dvb_i2c.o dvb_net.o dvb_ksyms.o
 
 obj-$(CONFIG_DVB_CORE) += dvb-core.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/drivers/media/dvb/frontends/Makefile linux/drivers/media/dvb/frontends/Makefile
--- linux-2.5.51-bk1/drivers/media/dvb/frontends/Makefile	Sat Dec 14 12:32:07 2002
+++ linux/drivers/media/dvb/frontends/Makefile	Sat Dec 14 12:38:56 2002
@@ -11,6 +11,3 @@
 obj-$(CONFIG_DVB_GRUNDIG_29504_491) += grundig_29504-491.o
 obj-$(CONFIG_DVB_GRUNDIG_29504_401) += grundig_29504-401.o
 obj-$(CONFIG_DVB_VES1820) += ves1820.o
-
-include $(TOPDIR)/Rules.make 
- 
diff -urN linux-2.5.51-bk1/drivers/media/radio/Makefile linux/drivers/media/radio/Makefile
--- linux-2.5.51-bk1/drivers/media/radio/Makefile	Sun Sep 15 22:18:30 2002
+++ linux/drivers/media/radio/Makefile	Sat Dec 14 12:38:56 2002
@@ -24,5 +24,3 @@
 obj-$(CONFIG_RADIO_GEMTEK_PCI) += radio-gemtek-pci.o
 obj-$(CONFIG_RADIO_TRUST) += radio-trust.o
 obj-$(CONFIG_RADIO_MAESTRO) += radio-maestro.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/media/video/Makefile linux/drivers/media/video/Makefile
--- linux-2.5.51-bk1/drivers/media/video/Makefile	Sat Dec 14 12:32:11 2002
+++ linux/drivers/media/video/Makefile	Sat Dec 14 12:38:56 2002
@@ -37,5 +37,3 @@
 obj-$(CONFIG_VIDEO_MEYE) += meye.o
 obj-$(CONFIG_VIDEO_SAA7134) += saa7134/ tuner.o tda9887.o video-buf.o
 obj-$(CONFIG_TUNER_3036) += tuner-3036.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/media/video/saa7134/Makefile linux/drivers/media/video/saa7134/Makefile
--- linux-2.5.51-bk1/drivers/media/video/saa7134/Makefile	Sat Dec 14 12:31:59 2002
+++ linux/drivers/media/video/saa7134/Makefile	Sat Dec 14 12:38:56 2002
@@ -6,6 +6,3 @@
 obj-$(CONFIG_VIDEO_SAA7134) += saa7134.o
 
 EXTRA_CFLAGS = -I$(src)/..
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/drivers/message/Makefile linux/drivers/message/Makefile
--- linux-2.5.51-bk1/drivers/message/Makefile	Sun Sep 15 22:18:52 2002
+++ linux/drivers/message/Makefile	Sat Dec 14 12:38:56 2002
@@ -4,6 +4,3 @@
 
 obj-$(CONFIG_I2O)	+= i2o/
 obj-$(CONFIG_FUSION)	+= fusion/
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/drivers/message/fusion/Makefile linux/drivers/message/fusion/Makefile
--- linux-2.5.51-bk1/drivers/message/fusion/Makefile	Sat Dec 14 12:31:38 2002
+++ linux/drivers/message/fusion/Makefile	Sat Dec 14 12:38:56 2002
@@ -52,5 +52,3 @@
 obj-$(CONFIG_FUSION_ISENSE)	+= isense.o
 obj-$(CONFIG_FUSION_CTL)	+= mptctl.o
 obj-$(CONFIG_FUSION_LAN)	+= mptlan.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/message/i2o/Makefile linux/drivers/message/i2o/Makefile
--- linux-2.5.51-bk1/drivers/message/i2o/Makefile	Sun Sep 15 22:18:21 2002
+++ linux/drivers/message/i2o/Makefile	Sat Dec 14 12:38:56 2002
@@ -13,6 +13,3 @@
 obj-$(CONFIG_I2O_LAN)	+= i2o_lan.o
 obj-$(CONFIG_I2O_SCSI)	+= i2o_scsi.o
 obj-$(CONFIG_I2O_PROC)	+= i2o_proc.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/drivers/misc/Makefile linux/drivers/misc/Makefile
--- linux-2.5.51-bk1/drivers/misc/Makefile	Sat Dec 14 12:32:11 2002
+++ linux/drivers/misc/Makefile	Sat Dec 14 12:38:56 2002
@@ -2,4 +2,3 @@
 # Makefile for misc devices that really don't fit anywhere else.
 #
 obj- := misc.o	# Dummy rule to force built-in.o to be made
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/mtd/Makefile linux/drivers/mtd/Makefile
--- linux-2.5.51-bk1/drivers/mtd/Makefile	Sat Dec 14 12:31:42 2002
+++ linux/drivers/mtd/Makefile	Sat Dec 14 12:38:56 2002
@@ -40,5 +40,3 @@
 obj-$(CONFIG_NFTL)		+= nftl.o
 
 nftl-objs	:= nftlcore.o nftlmount.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/mtd/chips/Makefile linux/drivers/mtd/chips/Makefile
--- linux-2.5.51-bk1/drivers/mtd/chips/Makefile	Sun Sep 15 22:18:24 2002
+++ linux/drivers/mtd/chips/Makefile	Sat Dec 14 12:38:56 2002
@@ -25,5 +25,3 @@
 obj-$(CONFIG_MTD_ROM)		+= map_rom.o
 obj-$(CONFIG_MTD_SHARP)		+= sharp.o
 obj-$(CONFIG_MTD_ABSENT)	+= map_absent.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/mtd/devices/Makefile linux/drivers/mtd/devices/Makefile
--- linux-2.5.51-bk1/drivers/mtd/devices/Makefile	Sun Sep 15 22:18:16 2002
+++ linux/drivers/mtd/devices/Makefile	Sat Dec 14 12:38:56 2002
@@ -19,5 +19,3 @@
 obj-$(CONFIG_MTD_MTDRAM)	+= mtdram.o
 obj-$(CONFIG_MTD_LART)		+= lart.o
 obj-$(CONFIG_MTD_BLKMTD)	+= blkmtd.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/mtd/maps/Makefile linux/drivers/mtd/maps/Makefile
--- linux-2.5.51-bk1/drivers/mtd/maps/Makefile	Sat Dec 14 12:31:59 2002
+++ linux/drivers/mtd/maps/Makefile	Sat Dec 14 12:38:56 2002
@@ -37,5 +37,3 @@
 obj-$(CONFIG_MTD_EDB7312)	+= edb7312.o
 obj-$(CONFIG_MTD_IMPA7)		+= impa7.o
 obj-$(CONFIG_MTD_FORTUNET)	+= fortunet.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/mtd/nand/Makefile linux/drivers/mtd/nand/Makefile
--- linux-2.5.51-bk1/drivers/mtd/nand/Makefile	Sun Sep 15 22:18:17 2002
+++ linux/drivers/mtd/nand/Makefile	Sat Dec 14 12:38:56 2002
@@ -10,5 +10,3 @@
 
 obj-$(CONFIG_MTD_NAND)		+= $(nandobjs-y)
 obj-$(CONFIG_MTD_NAND_SPIA)	+= spia.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/net/Makefile linux/drivers/net/Makefile
--- linux-2.5.51-bk1/drivers/net/Makefile	Sat Dec 14 12:32:11 2002
+++ linux/drivers/net/Makefile	Sat Dec 14 12:38:56 2002
@@ -198,6 +198,3 @@
 obj-$(CONFIG_NET_TULIP) += tulip/
 obj-$(CONFIG_HAMRADIO) += hamradio/
 obj-$(CONFIG_IRDA) += irda/
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/drivers/net/appletalk/Makefile linux/drivers/net/appletalk/Makefile
--- linux-2.5.51-bk1/drivers/net/appletalk/Makefile	Sun Sep 15 22:18:18 2002
+++ linux/drivers/net/appletalk/Makefile	Sat Dec 14 12:38:56 2002
@@ -7,6 +7,3 @@
 obj-$(CONFIG_IPDDP) += ipddp.o
 obj-$(CONFIG_COPS) += cops.o
 obj-$(CONFIG_LTPC) += ltpc.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/drivers/net/arcnet/Makefile linux/drivers/net/arcnet/Makefile
--- linux-2.5.51-bk1/drivers/net/arcnet/Makefile	Sun Sep 15 22:18:21 2002
+++ linux/drivers/net/arcnet/Makefile	Sat Dec 14 12:38:56 2002
@@ -13,5 +13,3 @@
 obj-$(CONFIG_ARCNET_COM20020) += com20020.o
 obj-$(CONFIG_ARCNET_COM20020_ISA) += com20020-isa.o
 obj-$(CONFIG_ARCNET_COM20020_PCI) += com20020-pci.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/net/e100/Makefile linux/drivers/net/e100/Makefile
--- linux-2.5.51-bk1/drivers/net/e100/Makefile	Sun Sep 15 22:18:53 2002
+++ linux/drivers/net/e100/Makefile	Sat Dec 14 12:38:56 2002
@@ -6,5 +6,3 @@
 
 e100-objs := e100_main.o e100_config.o e100_proc.o e100_phy.o \
 	     e100_eeprom.o e100_test.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/net/e1000/Makefile linux/drivers/net/e1000/Makefile
--- linux-2.5.51-bk1/drivers/net/e1000/Makefile	Sun Sep 15 22:18:18 2002
+++ linux/drivers/net/e1000/Makefile	Sat Dec 14 12:38:56 2002
@@ -34,5 +34,3 @@
 
 e1000-objs := e1000_main.o e1000_hw.o e1000_ethtool.o e1000_param.o \
 	      e1000_proc.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/net/fc/Makefile linux/drivers/net/fc/Makefile
--- linux-2.5.51-bk1/drivers/net/fc/Makefile	Sun Sep 15 22:18:24 2002
+++ linux/drivers/net/fc/Makefile	Sat Dec 14 12:38:56 2002
@@ -6,5 +6,3 @@
 #
 
 obj-$(CONFIG_IPHASE5526)	+= iph5526.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/net/hamradio/Makefile linux/drivers/net/hamradio/Makefile
--- linux-2.5.51-bk1/drivers/net/hamradio/Makefile	Sat Dec 14 12:32:07 2002
+++ linux/drivers/net/hamradio/Makefile	Sat Dec 14 12:38:56 2002
@@ -22,5 +22,3 @@
 obj-$(CONFIG_BAYCOM_SER_HDX)	+= baycom_ser_hdx.o	hdlcdrv.o
 obj-$(CONFIG_BAYCOM_PAR)	+= baycom_par.o		hdlcdrv.o
 obj-$(CONFIG_BAYCOM_EPP)	+= baycom_epp.o		hdlcdrv.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/net/irda/Makefile linux/drivers/net/irda/Makefile
--- linux-2.5.51-bk1/drivers/net/irda/Makefile	Sat Dec 14 12:32:01 2002
+++ linux/drivers/net/irda/Makefile	Sat Dec 14 12:38:56 2002
@@ -40,5 +40,3 @@
 
 # The SIR helper module
 sir-dev-objs := sir_core.o sir_dev.o sir_dongle.o sir_kthread.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/net/pcmcia/Makefile linux/drivers/net/pcmcia/Makefile
--- linux-2.5.51-bk1/drivers/net/pcmcia/Makefile	Sun Sep 15 22:18:16 2002
+++ linux/drivers/net/pcmcia/Makefile	Sat Dec 14 12:38:56 2002
@@ -21,5 +21,3 @@
 obj-$(CONFIG_AIRONET4500_CS)	+= aironet4500_cs.o
 
 obj-$(CONFIG_PCMCIA_IBMTR)	+= ibmtr_cs.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/net/sk98lin/Makefile linux/drivers/net/sk98lin/Makefile
--- linux-2.5.51-bk1/drivers/net/sk98lin/Makefile	Sat Dec 14 12:31:38 2002
+++ linux/drivers/net/sk98lin/Makefile	Sat Dec 14 12:38:56 2002
@@ -56,6 +56,3 @@
 # SK_DBGCAT_DRV_EVENT           0x08000000      driver events
 
 EXTRA_CFLAGS += -Idrivers/net/sk98lin -DSK_USE_CSUM $(DBGDEF)
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/drivers/net/skfp/Makefile linux/drivers/net/skfp/Makefile
--- linux-2.5.51-bk1/drivers/net/skfp/Makefile	Sat Dec 14 12:31:38 2002
+++ linux/drivers/net/skfp/Makefile	Sat Dec 14 12:38:56 2002
@@ -18,6 +18,3 @@
 #   thus simplify fixes to it), please do not clean it up!
 
 EXTRA_CFLAGS += -Idrivers/net/skfp -DPCI -DMEM_MAPPED_IO -Wno-strict-prototypes 
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/drivers/net/tokenring/Makefile linux/drivers/net/tokenring/Makefile
--- linux-2.5.51-bk1/drivers/net/tokenring/Makefile	Sun Sep 15 22:18:21 2002
+++ linux/drivers/net/tokenring/Makefile	Sat Dec 14 12:38:56 2002
@@ -14,5 +14,3 @@
 obj-$(CONFIG_TMSISA) 	+= tmsisa.o
 obj-$(CONFIG_SMCTR) 	+= smctr.o
 obj-$(CONFIG_3C359)	+= 3c359.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/net/tulip/Makefile linux/drivers/net/tulip/Makefile
--- linux-2.5.51-bk1/drivers/net/tulip/Makefile	Sun Sep 15 22:18:53 2002
+++ linux/drivers/net/tulip/Makefile	Sat Dec 14 12:38:56 2002
@@ -15,5 +15,3 @@
 tulip-objs			:= eeprom.o interrupt.o media.o \
 				   timer.o tulip_core.o		\
 				   21142.o pnic.o pnic2.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/net/wan/Makefile linux/drivers/net/wan/Makefile
--- linux-2.5.51-bk1/drivers/net/wan/Makefile	Sun Sep 15 22:18:30 2002
+++ linux/drivers/net/wan/Makefile	Sat Dec 14 12:38:56 2002
@@ -68,5 +68,3 @@
 endif
 obj-$(CONFIG_N2)		+= n2.o
 obj-$(CONFIG_C101)		+= c101.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/net/wan/lmc/Makefile linux/drivers/net/wan/lmc/Makefile
--- linux-2.5.51-bk1/drivers/net/wan/lmc/Makefile	Sat Dec 14 12:31:36 2002
+++ linux/drivers/net/wan/lmc/Makefile	Sat Dec 14 12:38:56 2002
@@ -15,6 +15,3 @@
 # -DLMC_PACKET_LOG
 
 EXTRA_CFLAGS += -I. $(DBGDEF)
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/drivers/net/wireless/Makefile linux/drivers/net/wireless/Makefile
--- linux-2.5.51-bk1/drivers/net/wireless/Makefile	Sun Sep 15 22:18:29 2002
+++ linux/drivers/net/wireless/Makefile	Sat Dec 14 12:38:56 2002
@@ -18,5 +18,3 @@
 
 obj-$(CONFIG_AIRO)		+= airo.o
 obj-$(CONFIG_AIRO_CS)		+= airo_cs.o airo.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/nubus/Makefile linux/drivers/nubus/Makefile
--- linux-2.5.51-bk1/drivers/nubus/Makefile	Sun Sep 15 22:18:54 2002
+++ linux/drivers/nubus/Makefile	Sat Dec 14 12:38:56 2002
@@ -8,5 +8,3 @@
 
 obj-$(CONFIG_MODULES) += nubus_syms.o 
 obj-$(CONFIG_PROC_FS) += proc.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/parport/Makefile linux/drivers/parport/Makefile
--- linux-2.5.51-bk1/drivers/parport/Makefile	Sun Sep 15 22:18:17 2002
+++ linux/drivers/parport/Makefile	Sat Dec 14 12:38:56 2002
@@ -19,5 +19,3 @@
 obj-$(CONFIG_PARPORT_ATARI)	+= parport_atari.o
 obj-$(CONFIG_PARPORT_SUNBPP)	+= parport_sunbpp.o
 obj-$(CONFIG_PARPORT_GSC)	+= parport_gsc.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/pci/Makefile linux/drivers/pci/Makefile
--- linux-2.5.51-bk1/drivers/pci/Makefile	Sat Dec 14 12:32:04 2002
+++ linux/drivers/pci/Makefile	Sat Dec 14 12:38:56 2002
@@ -39,8 +39,6 @@
 # Files generated that shall be removed upon make clean
 clean-files := devlist.h classlist.h
 
-include $(TOPDIR)/Rules.make
-
 # Dependencies on generated files need to be listed explicitly
 
 $(obj)/names.o: $(obj)/devlist.h $(obj)/classlist.h
diff -urN linux-2.5.51-bk1/drivers/pcmcia/Makefile linux/drivers/pcmcia/Makefile
--- linux-2.5.51-bk1/drivers/pcmcia/Makefile	Sat Dec 14 12:31:36 2002
+++ linux/drivers/pcmcia/Makefile	Sat Dec 14 12:38:56 2002
@@ -47,5 +47,3 @@
 sa1100_cs-objs-$(CONFIG_SA1100_TRIZEPS) 	+= sa1100_trizeps.o
 sa1100_cs-objs-$(CONFIG_SA1100_YOPY)		+= sa1100_yopy.o
 sa1100_cs-objs					:= $(sa1100_cs-objs-y)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/pnp/Makefile linux/drivers/pnp/Makefile
--- linux-2.5.51-bk1/drivers/pnp/Makefile	Sat Dec 14 12:32:11 2002
+++ linux/drivers/pnp/Makefile	Sat Dec 14 12:38:56 2002
@@ -10,5 +10,3 @@
 obj-$(CONFIG_ISAPNP)		+= isapnp/
 
 export-objs	:= core.o driver.o resource.o $(pnp-card-y)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/pnp/isapnp/Makefile linux/drivers/pnp/isapnp/Makefile
--- linux-2.5.51-bk1/drivers/pnp/isapnp/Makefile	Sat Dec 14 12:32:11 2002
+++ linux/drivers/pnp/isapnp/Makefile	Sat Dec 14 12:38:56 2002
@@ -7,5 +7,3 @@
 isapnp-proc-$(CONFIG_PROC_FS) = proc.o
 
 obj-y := core.o $(isapnp-proc-y)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/pnp/pnpbios/Makefile linux/drivers/pnp/pnpbios/Makefile
--- linux-2.5.51-bk1/drivers/pnp/pnpbios/Makefile	Sat Dec 14 12:31:44 2002
+++ linux/drivers/pnp/pnpbios/Makefile	Sat Dec 14 12:38:56 2002
@@ -7,5 +7,3 @@
 pnpbios-proc-$(CONFIG_PROC_FS) = proc.o
 
 obj-y := core.o $(pnpbios-proc-y)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/s390/Makefile linux/drivers/s390/Makefile
--- linux-2.5.51-bk1/drivers/s390/Makefile	Sat Dec 14 12:32:11 2002
+++ linux/drivers/s390/Makefile	Sat Dec 14 12:38:56 2002
@@ -6,6 +6,3 @@
 obj-y += cio/ block/ char/ misc/ net/
 
 drivers-y += drivers/s390/built-in.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/drivers/s390/block/Makefile linux/drivers/s390/block/Makefile
--- linux-2.5.51-bk1/drivers/s390/block/Makefile	Sat Dec 14 12:32:04 2002
+++ linux/drivers/s390/block/Makefile	Sat Dec 14 12:38:56 2002
@@ -15,5 +15,3 @@
 obj-$(CONFIG_DASD_ECKD) += dasd_eckd_mod.o
 obj-$(CONFIG_DASD_FBA)  += dasd_fba_mod.o
 obj-$(CONFIG_BLK_DEV_XPRAM) += xpram.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/s390/char/Makefile linux/drivers/s390/char/Makefile
--- linux-2.5.51-bk1/drivers/s390/char/Makefile	Sat Dec 14 12:32:12 2002
+++ linux/drivers/s390/char/Makefile	Sat Dec 14 12:38:56 2002
@@ -20,5 +20,3 @@
 tape-objs := tape_core.o tape_std.o tape_char.o $(tape-y)
 obj-$(CONFIG_S390_TAPE) += tape.o
 obj-$(CONFIG_S390_TAPE_34XX) += tape_34xx.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/s390/cio/Makefile linux/drivers/s390/cio/Makefile
--- linux-2.5.51-bk1/drivers/s390/cio/Makefile	Sat Dec 14 12:32:12 2002
+++ linux/drivers/s390/cio/Makefile	Sat Dec 14 12:38:56 2002
@@ -15,5 +15,3 @@
 
 obj-$(CONFIG_QDIO) += qdio.o
 export-objs += qdio.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/s390/misc/Makefile linux/drivers/s390/misc/Makefile
--- linux-2.5.51-bk1/drivers/s390/misc/Makefile	Sat Dec 14 12:32:12 2002
+++ linux/drivers/s390/misc/Makefile	Sat Dec 14 12:38:56 2002
@@ -3,5 +3,3 @@
 #
 
 # placeholder for stuff to come...
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/s390/net/Makefile linux/drivers/s390/net/Makefile
--- linux-2.5.51-bk1/drivers/s390/net/Makefile	Sat Dec 14 12:32:12 2002
+++ linux/drivers/s390/net/Makefile	Sat Dec 14 12:38:56 2002
@@ -10,6 +10,3 @@
 obj-$(CONFIG_CTC) += ctc.o fsm.o cu3088.o
 obj-$(CONFIG_IUCV) += netiucv.o
 obj-$(CONFIG_LCS) += lcs.o cu3088.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/drivers/sbus/Makefile linux/drivers/sbus/Makefile
--- linux-2.5.51-bk1/drivers/sbus/Makefile	Sat Dec 14 12:31:38 2002
+++ linux/drivers/sbus/Makefile	Sat Dec 14 12:38:56 2002
@@ -7,5 +7,3 @@
 endif
 
 obj-$(CONFIG_SBUSCHAR) += char/
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/sbus/char/Makefile linux/drivers/sbus/char/Makefile
--- linux-2.5.51-bk1/drivers/sbus/char/Makefile	Sun Sep 15 22:18:50 2002
+++ linux/drivers/sbus/char/Makefile	Sat Dec 14 12:38:56 2002
@@ -25,5 +25,3 @@
 obj-$(CONFIG_TADPOLE_TS102_UCTRL)	+= uctrl.o
 obj-$(CONFIG_SUN_JSFLASH)		+= jsflash.o
 obj-$(CONFIG_BBC_I2C)			+= bbc.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/scsi/Makefile linux/drivers/scsi/Makefile
--- linux-2.5.51-bk1/drivers/scsi/Makefile	Sat Dec 14 12:32:12 2002
+++ linux/drivers/scsi/Makefile	Sat Dec 14 12:38:56 2002
@@ -141,8 +141,6 @@
 clean-files :=	53c8xx_d.h  53c7xx_d.h sim710_d.h  53c700_d.h	\
 		53c8xx_u.h  53c7xx_u.h sim710_u.h 53c700_u.h
 
-include $(TOPDIR)/Rules.make
-
 $(obj)/53c7,8xx.o: $(obj)/53c8xx_d.h $(obj)/53c8xx_u.h
 $(obj)/53c7xx.o:   $(obj)/53c7xx_d.h $(obj)/53c7xx_u.h
 $(obj)/sim710.o:   $(obj)/sim710_d.h
diff -urN linux-2.5.51-bk1/drivers/scsi/aacraid/Makefile linux/drivers/scsi/aacraid/Makefile
--- linux-2.5.51-bk1/drivers/scsi/aacraid/Makefile	Sat Dec 14 12:31:42 2002
+++ linux/drivers/scsi/aacraid/Makefile	Sat Dec 14 12:38:56 2002
@@ -6,5 +6,3 @@
 		   dpcsup.o rx.o sa.o
 
 EXTRA_CFLAGS	:= -Idrivers/scsi
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/scsi/pcmcia/Makefile linux/drivers/scsi/pcmcia/Makefile
--- linux-2.5.51-bk1/drivers/scsi/pcmcia/Makefile	Sun Sep 15 22:18:28 2002
+++ linux/drivers/scsi/pcmcia/Makefile	Sat Dec 14 12:38:56 2002
@@ -22,5 +22,3 @@
 aha152x_cs-objs	:= aha152x_stub.o aha152x.o
 fdomain_cs-objs	:= fdomain_stub.o fdomain.o
 qlogic_cs-objs	:= qlogic_stub.o qlogicfas.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/scsi/sym53c8xx_2/Makefile linux/drivers/scsi/sym53c8xx_2/Makefile
--- linux-2.5.51-bk1/drivers/scsi/sym53c8xx_2/Makefile	Sat Dec 14 12:31:38 2002
+++ linux/drivers/scsi/sym53c8xx_2/Makefile	Sat Dec 14 12:38:56 2002
@@ -2,6 +2,3 @@
 
 sym53c8xx-objs := sym_fw.o sym_glue.o sym_hipd.o sym_malloc.o sym_misc.o sym_nvram.o
 obj-$(CONFIG_SCSI_SYM53C8XX_2) := sym53c8xx.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/drivers/serial/Makefile linux/drivers/serial/Makefile
--- linux-2.5.51-bk1/drivers/serial/Makefile	Sat Dec 14 12:32:12 2002
+++ linux/drivers/serial/Makefile	Sat Dec 14 12:38:56 2002
@@ -29,5 +29,3 @@
 obj-$(CONFIG_SERIAL_68360) += 68360serial.o
 obj-$(CONFIG_SERIAL_COLDFIRE) += mcfserial.o
 obj-$(CONFIG_V850E_NB85E_UART) += nb85e_uart.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/sgi/Makefile linux/drivers/sgi/Makefile
--- linux-2.5.51-bk1/drivers/sgi/Makefile	Sun Sep 15 22:18:25 2002
+++ linux/drivers/sgi/Makefile	Sat Dec 14 12:38:56 2002
@@ -8,5 +8,3 @@
 subdir-m	+= char
 
 obj-y		+= char/
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/sgi/char/Makefile linux/drivers/sgi/char/Makefile
--- linux-2.5.51-bk1/drivers/sgi/char/Makefile	Sun Sep 15 22:18:17 2002
+++ linux/drivers/sgi/char/Makefile	Sat Dec 14 12:38:56 2002
@@ -8,5 +8,3 @@
 obj-$(CONFIG_SGI_SERIAL)	+= sgiserial.o
 obj-$(CONFIG_SGI_DS1286)	+= ds1286.o
 obj-$(CONFIG_SGI_NEWPORT_GFX)	+= graphics.o rrm.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/tc/Makefile linux/drivers/tc/Makefile
--- linux-2.5.51-bk1/drivers/tc/Makefile	Sun Sep 15 22:18:24 2002
+++ linux/drivers/tc/Makefile	Sat Dec 14 12:38:56 2002
@@ -13,8 +13,6 @@
 obj-$(CONFIG_ZS) += zs.o
 obj-$(CONFIG_VT) += lk201.o lk201-map.o lk201-remap.o
 
-include $(TOPDIR)/Rules.make
-
 $(obj)/lk201-map.o: $(obj)/lk201-map.c
 
 # Uncomment if you're changing the keymap and have an appropriate
diff -urN linux-2.5.51-bk1/drivers/telephony/Makefile linux/drivers/telephony/Makefile
--- linux-2.5.51-bk1/drivers/telephony/Makefile	Sun Sep 15 22:18:30 2002
+++ linux/drivers/telephony/Makefile	Sat Dec 14 12:38:56 2002
@@ -7,6 +7,3 @@
 obj-$(CONFIG_PHONE) += phonedev.o
 obj-$(CONFIG_PHONE_IXJ) += ixj.o
 obj-$(CONFIG_PHONE_IXJ_PCMCIA) += ixj_pcmcia.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/drivers/usb/Makefile linux/drivers/usb/Makefile
--- linux-2.5.51-bk1/drivers/usb/Makefile	Sat Dec 14 12:32:03 2002
+++ linux/drivers/usb/Makefile	Sat Dec 14 12:38:56 2002
@@ -58,5 +58,3 @@
 obj-$(CONFIG_USB_TEST)		+= misc/
 obj-$(CONFIG_USB_TIGL)		+= misc/
 obj-$(CONFIG_USB_USS720)	+= misc/
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/usb/class/Makefile linux/drivers/usb/class/Makefile
--- linux-2.5.51-bk1/drivers/usb/class/Makefile	Sun Sep 15 22:18:28 2002
+++ linux/drivers/usb/class/Makefile	Sat Dec 14 12:38:56 2002
@@ -8,6 +8,3 @@
 obj-$(CONFIG_USB_BLUETOOTH_TTY)	+= bluetty.o
 obj-$(CONFIG_USB_MIDI)		+= usb-midi.o
 obj-$(CONFIG_USB_PRINTER)	+= usblp.o
-
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/usb/core/Makefile linux/drivers/usb/core/Makefile
--- linux-2.5.51-bk1/drivers/usb/core/Makefile	Sat Dec 14 12:31:36 2002
+++ linux/drivers/usb/core/Makefile	Sat Dec 14 12:38:56 2002
@@ -16,5 +16,3 @@
 endif
 
 obj-$(CONFIG_USB)	+= usbcore.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/usb/host/Makefile linux/drivers/usb/host/Makefile
--- linux-2.5.51-bk1/drivers/usb/host/Makefile	Sat Dec 14 12:32:03 2002
+++ linux/drivers/usb/host/Makefile	Sat Dec 14 12:38:56 2002
@@ -8,5 +8,3 @@
 obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
 
 obj-$(CONFIG_USB_SL811HS)	+= hc_sl811.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/usb/image/Makefile linux/drivers/usb/image/Makefile
--- linux-2.5.51-bk1/drivers/usb/image/Makefile	Sun Sep 15 22:18:16 2002
+++ linux/drivers/usb/image/Makefile	Sat Dec 14 12:38:56 2002
@@ -6,5 +6,3 @@
 obj-$(CONFIG_USB_HPUSBSCSI)	+= hpusbscsi.o
 obj-$(CONFIG_USB_MICROTEK)	+= microtek.o
 obj-$(CONFIG_USB_SCANNER)	+= scanner.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/usb/input/Makefile linux/drivers/usb/input/Makefile
--- linux-2.5.51-bk1/drivers/usb/input/Makefile	Sun Sep 15 22:18:37 2002
+++ linux/drivers/usb/input/Makefile	Sat Dec 14 12:38:56 2002
@@ -30,5 +30,3 @@
 obj-$(CONFIG_USB_WACOM)		+= wacom.o
 obj-$(CONFIG_USB_POWERMATE)	+= powermate.o
 obj-$(CONFIG_USB_XPAD)		+= xpad.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/usb/media/Makefile linux/drivers/usb/media/Makefile
--- linux-2.5.51-bk1/drivers/usb/media/Makefile	Sat Dec 14 12:31:42 2002
+++ linux/drivers/usb/media/Makefile	Sat Dec 14 12:38:56 2002
@@ -15,5 +15,3 @@
 obj-$(CONFIG_USB_SE401)		+= se401.o
 obj-$(CONFIG_USB_STV680)	+= stv680.o
 obj-$(CONFIG_USB_VICAM)		+= vicam.o usbvideo.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/usb/misc/Makefile linux/drivers/usb/misc/Makefile
--- linux-2.5.51-bk1/drivers/usb/misc/Makefile	Sat Dec 14 12:31:38 2002
+++ linux/drivers/usb/misc/Makefile	Sat Dec 14 12:38:56 2002
@@ -14,5 +14,3 @@
 obj-$(CONFIG_USB_TEST)		+= usbtest.o
 obj-$(CONFIG_USB_TIGL)		+= tiglusb.o
 obj-$(CONFIG_USB_USS720)	+= uss720.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/usb/net/Makefile linux/drivers/usb/net/Makefile
--- linux-2.5.51-bk1/drivers/usb/net/Makefile	Sun Sep 15 22:18:18 2002
+++ linux/drivers/usb/net/Makefile	Sat Dec 14 12:38:56 2002
@@ -8,6 +8,3 @@
 obj-$(CONFIG_USB_PEGASUS)	+= pegasus.o
 obj-$(CONFIG_USB_RTL8150)	+= rtl8150.o
 obj-$(CONFIG_USB_USBNET)	+= usbnet.o
-
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/usb/serial/Makefile linux/drivers/usb/serial/Makefile
--- linux-2.5.51-bk1/drivers/usb/serial/Makefile	Sat Dec 14 12:32:38 2002
+++ linux/drivers/usb/serial/Makefile	Sat Dec 14 12:39:38 2002
@@ -34,6 +34,3 @@
 export-objs	:= usb-serial.o ezusb.o
 
 usbserial-objs	:= usb-serial.o generic.o bus.o $(usbserial-obj-y)
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/drivers/usb/storage/Makefile linux/drivers/usb/storage/Makefile
--- linux-2.5.51-bk1/drivers/usb/storage/Makefile	Sat Dec 14 12:31:38 2002
+++ linux/drivers/usb/storage/Makefile	Sat Dec 14 12:38:56 2002
@@ -21,5 +21,3 @@
 
 usb-storage-objs :=	scsiglue.o protocol.o transport.o usb.o \
 			initializers.o $(usb-storage-obj-y)
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/video/Makefile linux/drivers/video/Makefile
--- linux-2.5.51-bk1/drivers/video/Makefile	Sat Dec 14 12:32:12 2002
+++ linux/drivers/video/Makefile	Sat Dec 14 12:38:56 2002
@@ -88,8 +88,6 @@
 # Files generated that shall be removed upon make clean
 clean-files := promcon_tbl.c
 
-include $(TOPDIR)/Rules.make
-
 $(obj)/promcon_tbl.c: $(src)/prom.uni
 	$(objtree)/scripts/conmakehash $< | \
 	sed -e '/#include <[^>]*>/p' -e 's/types/init/' \
diff -urN linux-2.5.51-bk1/drivers/video/aty/Makefile linux/drivers/video/aty/Makefile
--- linux-2.5.51-bk1/drivers/video/aty/Makefile	Sun Sep 15 22:18:25 2002
+++ linux/drivers/video/aty/Makefile	Sat Dec 14 12:38:56 2002
@@ -4,6 +4,3 @@
 atyfb-$(CONFIG_FB_ATY_GX)	+= mach64_gx.o
 atyfb-$(CONFIG_FB_ATY_CT)	+= mach64_ct.o mach64_cursor.o
 atyfb-objs			:= $(atyfb-y)
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/drivers/video/console/Makefile linux/drivers/video/console/Makefile
--- linux-2.5.51-bk1/drivers/video/console/Makefile	Sat Dec 14 12:32:12 2002
+++ linux/drivers/video/console/Makefile	Sat Dec 14 12:38:56 2002
@@ -52,8 +52,6 @@
 # Files generated that shall be removed upon make clean
 clean-files := promcon_tbl.c
 
-include $(TOPDIR)/Rules.make
-
 $(obj)/promcon_tbl.c: $(src)/prom.uni
 	$(objtree)/scripts/conmakehash $< | \
 	sed -e '/#include <[^>]*>/p' -e 's/types/init/' \
diff -urN linux-2.5.51-bk1/drivers/video/matrox/Makefile linux/drivers/video/matrox/Makefile
--- linux-2.5.51-bk1/drivers/video/matrox/Makefile	Sat Dec 14 12:31:36 2002
+++ linux/drivers/video/matrox/Makefile	Sat Dec 14 12:38:56 2002
@@ -15,6 +15,3 @@
 obj-$(CONFIG_FB_MATROX)           += matroxfb_base.o matroxfb_accel.o matroxfb_DAC1064.o matroxfb_Ti3026.o matroxfb_misc.o $(my-obj-y)
 obj-$(CONFIG_FB_MATROX_I2C)       += i2c-matroxfb.o
 obj-$(CONFIG_FB_MATROX_MAVEN)     += matroxfb_maven.o matroxfb_crtc2.o
-
-include $(TOPDIR)/Rules.make
-
diff -urN linux-2.5.51-bk1/drivers/video/riva/Makefile linux/drivers/video/riva/Makefile
--- linux-2.5.51-bk1/drivers/video/riva/Makefile	Sat Dec 14 12:32:13 2002
+++ linux/drivers/video/riva/Makefile	Sat Dec 14 12:38:56 2002
@@ -5,5 +5,3 @@
 obj-$(CONFIG_FB_RIVA) += rivafb.o
 
 rivafb-objs := fbdev.o riva_hw.o
-
-include $(TOPDIR)/Rules.make
diff -urN linux-2.5.51-bk1/drivers/video/sis/Makefile linux/drivers/video/sis/Makefile
--- linux-2.5.51-bk1/drivers/video/sis/Makefile	Sat Dec 14 12:32:13 2002
+++ linux/drivers/video/sis/Makefile	Sat Dec 14 12:39:21 2002
@@ -7,7 +7,3 @@
 obj-$(CONFIG_FB_SIS) += sisfb.o
 
 sisfb-objs := sis_main.o sis_accel.o init.o init301.o
-
-include $(TOPDIR)/Rules.make
-
-
diff -urN linux-2.5.51-bk1/drivers/zorro/Makefile linux/drivers/zorro/Makefile
--- linux-2.5.51-bk1/drivers/zorro/Makefile	Sat Dec 14 12:31:44 2002
+++ linux/drivers/zorro/Makefile	Sat Dec 14 12:38:56 2002
@@ -12,8 +12,6 @@
 # Files generated that shall be removed upon make clean
 clean-files := devlist.h
 
-include $(TOPDIR)/Rules.make
-
 # Dependencies on generated files need to be listed explicitly
 
 $(obj)/names.o: $(obj)/devlist.h

--------------060405090501060708020104--

