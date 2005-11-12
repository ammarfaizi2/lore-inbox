Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbVKLUmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbVKLUmf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 15:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbVKLUmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 15:42:35 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:26160 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964792AbVKLUmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 15:42:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=uZ/IOp7MfNuygfrKSlB5F9fPgZnXZteGpS4Fyt+a608zx3xvO5nyqyHzd9+91weFpad//iZNsSCMmMrFht9U/1/A1K2EQZuelBotJICeZH5Vddz38LgEW6pdNVGZPntFhjrVwuI75c60LhnhyoJ6Zxyx48qNNEwqHkIXptQB5ZA=
Date: Sat, 12 Nov 2005 23:56:10 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH] Remove include/linux/mtd/compatmac.h
Message-ID: <20051112205610.GA20860@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>

File is effectively empty.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Index: linux-kj/drivers/mtd/chips/cfi_cmdset_0001.c
===================================================================
--- linux-kj.orig/drivers/mtd/chips/cfi_cmdset_0001.c	2005-11-12 15:37:20.000000000 +0300
+++ linux-kj/drivers/mtd/chips/cfi_cmdset_0001.c	2005-11-12 15:41:52.000000000 +0300
@@ -33,7 +33,6 @@
 #include <linux/mtd/xip.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/compatmac.h>
 #include <linux/mtd/cfi.h>
 
 /* #define CMDSET0001_DISABLE_ERASE_SUSPEND_ON_WRITE */
Index: linux-kj/drivers/mtd/chips/cfi_cmdset_0002.c
===================================================================
--- linux-kj.orig/drivers/mtd/chips/cfi_cmdset_0002.c	2005-11-12 15:37:20.000000000 +0300
+++ linux-kj/drivers/mtd/chips/cfi_cmdset_0002.c	2005-11-12 15:41:52.000000000 +0300
@@ -34,7 +34,6 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-#include <linux/mtd/compatmac.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/cfi.h>
Index: linux-kj/drivers/mtd/chips/cfi_cmdset_0020.c
===================================================================
--- linux-kj.orig/drivers/mtd/chips/cfi_cmdset_0020.c	2005-11-12 15:37:20.000000000 +0300
+++ linux-kj/drivers/mtd/chips/cfi_cmdset_0020.c	2005-11-12 15:41:52.000000000 +0300
@@ -35,8 +35,6 @@
 #include <linux/mtd/map.h>
 #include <linux/mtd/cfi.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/compatmac.h>
-
 
 static int cfi_staa_read(struct mtd_info *, loff_t, size_t, size_t *, u_char *);
 static int cfi_staa_write_buffers(struct mtd_info *, loff_t, size_t, size_t *, const u_char *);
Index: linux-kj/drivers/mtd/chips/cfi_util.c
===================================================================
--- linux-kj.orig/drivers/mtd/chips/cfi_util.c	2005-11-12 15:37:20.000000000 +0300
+++ linux-kj/drivers/mtd/chips/cfi_util.c	2005-11-12 15:41:52.000000000 +0300
@@ -26,7 +26,6 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/cfi.h>
-#include <linux/mtd/compatmac.h>
 
 struct cfi_extquery *
 __xipram cfi_read_pri(struct map_info *map, __u16 adr, __u16 size, const char* name)
Index: linux-kj/drivers/mtd/chips/chipreg.c
===================================================================
--- linux-kj.orig/drivers/mtd/chips/chipreg.c	2005-11-12 15:37:20.000000000 +0300
+++ linux-kj/drivers/mtd/chips/chipreg.c	2005-11-12 15:41:52.000000000 +0300
@@ -13,7 +13,6 @@
 #include <linux/slab.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/compatmac.h>
 
 static DEFINE_SPINLOCK(chip_drvs_lock);
 static LIST_HEAD(chip_drvs_list);
Index: linux-kj/drivers/mtd/chips/jedec.c
===================================================================
--- linux-kj.orig/drivers/mtd/chips/jedec.c	2005-11-12 15:37:20.000000000 +0300
+++ linux-kj/drivers/mtd/chips/jedec.c	2005-11-12 15:41:52.000000000 +0300
@@ -21,7 +21,6 @@
 #include <linux/mtd/jedec.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/compatmac.h>
 
 static struct mtd_info *jedec_probe(struct map_info *);
 static int jedec_probe8(struct map_info *map,unsigned long base,
Index: linux-kj/drivers/mtd/chips/map_absent.c
===================================================================
--- linux-kj.orig/drivers/mtd/chips/map_absent.c	2005-11-12 15:37:20.000000000 +0300
+++ linux-kj/drivers/mtd/chips/map_absent.c	2005-11-12 15:41:52.000000000 +0300
@@ -26,7 +26,6 @@
 #include <linux/init.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
-#include <linux/mtd/compatmac.h>
 
 static int map_absent_read (struct mtd_info *, loff_t, size_t, size_t *, u_char *);
 static int map_absent_write (struct mtd_info *, loff_t, size_t, size_t *, const u_char *);
Index: linux-kj/drivers/mtd/chips/map_ram.c
===================================================================
--- linux-kj.orig/drivers/mtd/chips/map_ram.c	2005-11-12 15:37:20.000000000 +0300
+++ linux-kj/drivers/mtd/chips/map_ram.c	2005-11-12 15:41:52.000000000 +0300
@@ -14,8 +14,6 @@
 #include <linux/init.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
-#include <linux/mtd/compatmac.h>
-
 
 static int mapram_read (struct mtd_info *, loff_t, size_t, size_t *, u_char *);
 static int mapram_write (struct mtd_info *, loff_t, size_t, size_t *, const u_char *);
Index: linux-kj/drivers/mtd/chips/map_rom.c
===================================================================
--- linux-kj.orig/drivers/mtd/chips/map_rom.c	2005-11-12 15:37:20.000000000 +0300
+++ linux-kj/drivers/mtd/chips/map_rom.c	2005-11-12 15:41:52.000000000 +0300
@@ -14,7 +14,6 @@
 #include <linux/init.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
-#include <linux/mtd/compatmac.h>
 
 static int maprom_read (struct mtd_info *, loff_t, size_t, size_t *, u_char *);
 static int maprom_write (struct mtd_info *, loff_t, size_t, size_t *, const u_char *);
Index: linux-kj/drivers/mtd/devices/docecc.c
===================================================================
--- linux-kj.orig/drivers/mtd/devices/docecc.c	2005-11-12 15:37:20.000000000 +0300
+++ linux-kj/drivers/mtd/devices/docecc.c	2005-11-12 15:41:52.000000000 +0300
@@ -36,7 +36,6 @@
 #include <linux/init.h>
 #include <linux/types.h>
 
-#include <linux/mtd/compatmac.h> /* for min() in older kernels */
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/doc2000.h>
 
Index: linux-kj/drivers/mtd/devices/docprobe.c
===================================================================
--- linux-kj.orig/drivers/mtd/devices/docprobe.c	2005-11-12 15:37:20.000000000 +0300
+++ linux-kj/drivers/mtd/devices/docprobe.c	2005-11-12 15:41:52.000000000 +0300
@@ -53,7 +53,6 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/doc2000.h>
-#include <linux/mtd/compatmac.h>
 
 /* Where to look for the devices? */
 #ifndef CONFIG_MTD_DOCPROBE_ADDRESS
Index: linux-kj/drivers/mtd/devices/mtdram.c
===================================================================
--- linux-kj.orig/drivers/mtd/devices/mtdram.c	2005-11-12 15:37:20.000000000 +0300
+++ linux-kj/drivers/mtd/devices/mtdram.c	2005-11-12 15:41:52.000000000 +0300
@@ -16,7 +16,6 @@
 #include <linux/ioport.h>
 #include <linux/vmalloc.h>
 #include <linux/init.h>
-#include <linux/mtd/compatmac.h>
 #include <linux/mtd/mtd.h>
 
 static unsigned long total_size = CONFIG_MTDRAM_TOTAL_SIZE;
Index: linux-kj/drivers/mtd/devices/pmc551.c
===================================================================
--- linux-kj.orig/drivers/mtd/devices/pmc551.c	2005-11-12 15:37:20.000000000 +0300
+++ linux-kj/drivers/mtd/devices/pmc551.c	2005-11-12 15:41:52.000000000 +0300
@@ -106,7 +106,6 @@
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/pmc551.h>
-#include <linux/mtd/compatmac.h>
 
 static struct mtd_info *pmc551list;
 
Index: linux-kj/drivers/mtd/inftlmount.c
===================================================================
--- linux-kj.orig/drivers/mtd/inftlmount.c	2005-11-12 15:37:20.000000000 +0300
+++ linux-kj/drivers/mtd/inftlmount.c	2005-11-12 15:41:52.000000000 +0300
@@ -39,7 +39,6 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nftl.h>
 #include <linux/mtd/inftl.h>
-#include <linux/mtd/compatmac.h>
 
 char inftlmountrev[]="$Revision: 1.18 $";
 
Index: linux-kj/drivers/mtd/mtdcore.c
===================================================================
--- linux-kj.orig/drivers/mtd/mtdcore.c	2005-11-12 15:37:20.000000000 +0300
+++ linux-kj/drivers/mtd/mtdcore.c	2005-11-12 15:41:52.000000000 +0300
@@ -18,7 +18,6 @@
 #include <linux/fs.h>
 #include <linux/ioctl.h>
 #include <linux/init.h>
-#include <linux/mtd/compatmac.h>
 #ifdef CONFIG_PROC_FS
 #include <linux/proc_fs.h>
 #endif
Index: linux-kj/drivers/mtd/mtdpart.c
===================================================================
--- linux-kj.orig/drivers/mtd/mtdpart.c	2005-11-12 15:37:20.000000000 +0300
+++ linux-kj/drivers/mtd/mtdpart.c	2005-11-12 15:41:52.000000000 +0300
@@ -20,7 +20,6 @@
 #include <linux/kmod.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
-#include <linux/mtd/compatmac.h>
 
 /* Our partition linked list */
 static LIST_HEAD(mtd_partitions);
Index: linux-kj/drivers/mtd/nand/diskonchip.c
===================================================================
--- linux-kj.orig/drivers/mtd/nand/diskonchip.c	2005-11-12 15:37:20.000000000 +0300
+++ linux-kj/drivers/mtd/nand/diskonchip.c	2005-11-12 15:41:52.000000000 +0300
@@ -30,7 +30,6 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/doc2000.h>
-#include <linux/mtd/compatmac.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/inftl.h>
 
Index: linux-kj/drivers/mtd/nand/nand_base.c
===================================================================
--- linux-kj.orig/drivers/mtd/nand/nand_base.c	2005-11-12 15:37:20.000000000 +0300
+++ linux-kj/drivers/mtd/nand/nand_base.c	2005-11-12 15:41:52.000000000 +0300
@@ -77,7 +77,6 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/nand_ecc.h>
-#include <linux/mtd/compatmac.h>
 #include <linux/interrupt.h>
 #include <linux/bitops.h>
 #include <asm/io.h>
Index: linux-kj/drivers/mtd/nand/nand_bbt.c
===================================================================
--- linux-kj.orig/drivers/mtd/nand/nand_bbt.c	2005-11-12 15:37:20.000000000 +0300
+++ linux-kj/drivers/mtd/nand/nand_bbt.c	2005-11-12 15:41:52.000000000 +0300
@@ -57,7 +57,6 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/nand_ecc.h>
-#include <linux/mtd/compatmac.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 
Index: linux-kj/drivers/mtd/nand/rtc_from4.c
===================================================================
--- linux-kj.orig/drivers/mtd/nand/rtc_from4.c	2005-11-12 15:37:20.000000000 +0300
+++ linux-kj/drivers/mtd/nand/rtc_from4.c	2005-11-12 15:41:52.000000000 +0300
@@ -25,7 +25,6 @@
 #include <linux/slab.h>
 #include <linux/rslib.h>
 #include <linux/module.h>
-#include <linux/mtd/compatmac.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
Index: linux-kj/include/linux/mtd/compatmac.h
===================================================================
--- linux-kj.orig/include/linux/mtd/compatmac.h	2005-11-12 15:37:40.000000000 +0300
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,10 +0,0 @@
-
-#ifndef __LINUX_MTD_COMPATMAC_H__
-#define __LINUX_MTD_COMPATMAC_H__
-
-/* Nothing to see here. We write 2.5-compatible code and this
-   file makes it all OK in older kernels, but it's empty in _current_
-   kernels. Include guard just to make GCC ignore it in future inclusions
-   anyway... */
-
-#endif /* __LINUX_MTD_COMPATMAC_H__ */
Index: linux-kj/include/linux/mtd/map.h
===================================================================
--- linux-kj.orig/include/linux/mtd/map.h	2005-11-12 15:37:40.000000000 +0300
+++ linux-kj/include/linux/mtd/map.h	2005-11-12 15:41:52.000000000 +0300
@@ -10,8 +10,6 @@
 #include <linux/list.h>
 #include <linux/string.h>
 
-#include <linux/mtd/compatmac.h>
-
 #include <asm/unaligned.h>
 #include <asm/system.h>
 #include <asm/io.h>
Index: linux-kj/include/linux/mtd/mtd.h
===================================================================
--- linux-kj.orig/include/linux/mtd/mtd.h	2005-11-12 15:37:40.000000000 +0300
+++ linux-kj/include/linux/mtd/mtd.h	2005-11-12 15:41:52.000000000 +0300
@@ -19,7 +19,6 @@
 #include <linux/uio.h>
 #include <linux/notifier.h>
 
-#include <linux/mtd/compatmac.h>
 #include <mtd/mtd-abi.h>
 
 #define MTD_CHAR_MAJOR 90
Index: linux-kj/drivers/mtd/mtdchar.c
===================================================================
--- linux-kj.orig/drivers/mtd/mtdchar.c	2005-11-12 15:37:20.000000000 +0300
+++ linux-kj/drivers/mtd/mtdchar.c	2005-11-12 15:41:52.000000000 +0300
@@ -15,7 +15,6 @@
 #include <linux/sched.h>
 
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/compatmac.h>
 
 #include <asm/uaccess.h>
 
Index: linux-kj/fs/jffs2/nodelist.h
===================================================================
--- linux-kj.orig/fs/jffs2/nodelist.h	2005-11-12 15:37:12.000000000 +0300
+++ linux-kj/fs/jffs2/nodelist.h	2005-11-12 15:41:52.000000000 +0300
@@ -25,7 +25,6 @@
 #ifdef __ECOS
 #include "os-ecos.h"
 #else
-#include <linux/mtd/compatmac.h> /* For compatibility with older kernels */
 #include "os-linux.h"
 #endif
 
Index: linux-kj/drivers/mtd/onenand/onenand_bbt.c
===================================================================
--- linux-kj.orig/drivers/mtd/onenand/onenand_bbt.c	2005-11-12 15:37:20.000000000 +0300
+++ linux-kj/drivers/mtd/onenand/onenand_bbt.c	2005-11-12 15:41:52.000000000 +0300
@@ -15,7 +15,6 @@
 #include <linux/slab.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/onenand.h>
-#include <linux/mtd/compatmac.h>
 
 /**
  * check_short_pattern - [GENERIC] check if a pattern is in the buffer

