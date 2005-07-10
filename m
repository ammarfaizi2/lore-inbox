Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbVGJVSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVGJVSY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 17:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVGJTka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:40:30 -0400
Received: from ns.suse.de ([195.135.220.2]:63122 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261520AbVGJTfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:34 -0400
Date: Sun, 10 Jul 2005 19:35:33 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: linux-mtd@lists.infradead.org
Subject: [PATCH 25/82] remove linux/version.h from drivers/mtd
Message-ID: <20050710193533.25.MftboC2946.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.
remove code from obsolete kernels

Signed-off-by: Olaf Hering <olh@suse.de>

drivers/mtd/chips/cfi_cmdset_0020.c |    1 -
drivers/mtd/devices/pmc551.c        |    1 -
drivers/mtd/maps/ebony.c            |    1 -
drivers/mtd/maps/ocotea.c           |    1 -
drivers/mtd/maps/walnut.c           |    1 -
drivers/mtd/nand/au1550nd.c         |   10 ----------
drivers/mtd/nand/autcpu12.c         |    1 -
include/linux/mtd/cfi.h             |    1 -
include/linux/mtd/mtd.h             |    1 -
9 files changed, 18 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/mtd/chips/cfi_cmdset_0020.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/mtd/chips/cfi_cmdset_0020.c
+++ linux-2.6.13-rc2-mm1/drivers/mtd/chips/cfi_cmdset_0020.c
@@ -18,7 +18,6 @@
*	- added a writev function
*/

-#include <linux/version.h>
#include <linux/module.h>
#include <linux/types.h>
#include <linux/kernel.h>
Index: linux-2.6.13-rc2-mm1/drivers/mtd/devices/pmc551.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/mtd/devices/pmc551.c
+++ linux-2.6.13-rc2-mm1/drivers/mtd/devices/pmc551.c
@@ -82,7 +82,6 @@
*       * Comb the init routine.  It's still a bit cludgy on a few things.
*/

-#include <linux/version.h>
#include <linux/config.h>
#include <linux/kernel.h>
#include <linux/module.h>
Index: linux-2.6.13-rc2-mm1/drivers/mtd/maps/ebony.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/mtd/maps/ebony.c
+++ linux-2.6.13-rc2-mm1/drivers/mtd/maps/ebony.c
@@ -21,7 +21,6 @@
#include <linux/mtd/map.h>
#include <linux/mtd/partitions.h>
#include <linux/config.h>
-#include <linux/version.h>
#include <asm/io.h>
#include <asm/ibm44x.h>
#include <platforms/4xx/ebony.h>
Index: linux-2.6.13-rc2-mm1/drivers/mtd/maps/ocotea.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/mtd/maps/ocotea.c
+++ linux-2.6.13-rc2-mm1/drivers/mtd/maps/ocotea.c
@@ -19,7 +19,6 @@
#include <linux/mtd/map.h>
#include <linux/mtd/partitions.h>
#include <linux/config.h>
-#include <linux/version.h>
#include <asm/io.h>
#include <asm/ibm44x.h>
#include <platforms/4xx/ocotea.h>
Index: linux-2.6.13-rc2-mm1/drivers/mtd/maps/walnut.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/mtd/maps/walnut.c
+++ linux-2.6.13-rc2-mm1/drivers/mtd/maps/walnut.c
@@ -21,7 +21,6 @@
#include <linux/mtd/map.h>
#include <linux/mtd/partitions.h>
#include <linux/config.h>
-#include <linux/version.h>
#include <asm/io.h>
#include <asm/ibm4xx.h>
#include <platforms/4xx/walnut.h>
Index: linux-2.6.13-rc2-mm1/drivers/mtd/nand/au1550nd.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/mtd/nand/au1550nd.c
+++ linux-2.6.13-rc2-mm1/drivers/mtd/nand/au1550nd.c
@@ -20,7 +20,6 @@
#include <asm/io.h>

/* fixme: this is ugly */
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2, 6, 0)
#include <asm/mach-au1x00/au1000.h>
#ifdef CONFIG_MIPS_PB1550
#include <asm/mach-pb1x00/pb1550.h>
@@ -28,15 +27,6 @@
#ifdef CONFIG_MIPS_DB1550
#include <asm/mach-db1x00/db1x00.h>
#endif
-#else
-#include <asm/au1000.h>
-#ifdef CONFIG_MIPS_PB1550
-#include <asm/pb1550.h>
-#endif
-#ifdef CONFIG_MIPS_DB1550
-#include <asm/db1x00.h>
-#endif
-#endif

/*
* MTD structure for NAND controller
Index: linux-2.6.13-rc2-mm1/drivers/mtd/nand/autcpu12.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/mtd/nand/autcpu12.c
+++ linux-2.6.13-rc2-mm1/drivers/mtd/nand/autcpu12.c
@@ -27,7 +27,6 @@
*	10-06-2002 TG	128K card support added
*/

-#include <linux/version.h>
#include <linux/slab.h>
#include <linux/init.h>
#include <linux/module.h>
Index: linux-2.6.13-rc2-mm1/include/linux/mtd/cfi.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/include/linux/mtd/cfi.h
+++ linux-2.6.13-rc2-mm1/include/linux/mtd/cfi.h
@@ -8,7 +8,6 @@
#define __MTD_CFI_H__

#include <linux/config.h>
-#include <linux/version.h>
#include <linux/delay.h>
#include <linux/types.h>
#include <linux/interrupt.h>
Index: linux-2.6.13-rc2-mm1/include/linux/mtd/mtd.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/include/linux/mtd/mtd.h
+++ linux-2.6.13-rc2-mm1/include/linux/mtd/mtd.h
@@ -14,7 +14,6 @@
#endif

#include <linux/config.h>
-#include <linux/version.h>
#include <linux/types.h>
#include <linux/module.h>
#include <linux/uio.h>
