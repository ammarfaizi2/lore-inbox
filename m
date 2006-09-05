Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWIES1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWIES1t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 14:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWIES1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 14:27:49 -0400
Received: from 71-215-130-30.ptld.qwest.net ([71.215.130.30]:56775 "EHLO
	vonnegut.anholt.net") by vger.kernel.org with ESMTP id S965215AbWIERnR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 13:43:17 -0400
From: Eric Anholt <eric@anholt.net>
To: linux-kernel@vger.kernel.org
Cc: davej@codemonkey.org.uk, Eric Anholt <eric@anholt.net>
Subject: [PATCH] Whitespace cleanup, remove an unnecessary comment, and remove an unnecessary include.
Reply-To: Eric Anholt <eric@anholt.net>
Date: Tue, 05 Sep 2006 10:37:34 -0700
Message-Id: <11574778924142-git-send-email-eric@anholt.net>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <115747787383-git-send-email-eric@anholt.net>
References: 11551502672606-git-send-email-eric@anholt.net <115747785570-git-send-email-eric@anholt.net> <115747787383-git-send-email-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/drivers/char/agp/intel-agp.c b/drivers/char/agp/intel-agp.c
index c51b365..e643445 100644
--- a/drivers/char/agp/intel-agp.c
+++ b/drivers/char/agp/intel-agp.c
@@ -16,7 +16,6 @@
  * <alanh@tungstengraphics.com>.
  */
 
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/init.h>
@@ -24,7 +23,6 @@ #include <linux/pagemap.h>
 #include <linux/agp_backend.h>
 #include "agp.h"
 
-/* Should be moved to include/linux/pci_ids.h */
 #define PCI_DEVICE_ID_INTEL_82946GZ_HB      0x2970
 #define PCI_DEVICE_ID_INTEL_82946GZ_IG      0x2972
 #define PCI_DEVICE_ID_INTEL_82965G_1_HB     0x2980
@@ -379,7 +377,7 @@ static struct aper_size_info_fixed intel
 	/* The 64M mode still requires a 128k gatt */
 	{64, 16384, 5},
 	{256, 65536, 6},
-        {512, 131072, 7},
+	{512, 131072, 7},
 };
 
 static struct _intel_i830_private {
@@ -404,10 +402,10 @@ static void intel_i830_init_gtt_entries(
 	 * reason) at the top of stolen memory. Then we add 4KB to that
 	 * for the video BIOS popup, which is also stored in there. */
 
-       if (IS_I965)
-               size = 512 + 4;
-       else
-               size = agp_bridge->driver->fetch_size() + 4;
+	if (IS_I965)
+		size = 512 + 4;
+	else
+		size = agp_bridge->driver->fetch_size() + 4;
 
 	if (agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82830_HB ||
 	    agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82845G_HB) {
@@ -766,7 +764,7 @@ static int intel_i915_remove_entries(str
 static int intel_i915_fetch_size(void)
 {
 	struct aper_size_info_fixed *values;
-	u32 temp, offset = 0;
+	u32 temp, offset;
 
 #define I915_256MB_ADDRESS_MASK (1<<27)
 
@@ -1808,34 +1806,34 @@ static int __devinit agp_intel_probe(str
 			bridge->driver = &intel_845_driver;
 		name = "945GM";
 		break;
-       case PCI_DEVICE_ID_INTEL_82946GZ_HB:
-               if (find_i830(PCI_DEVICE_ID_INTEL_82946GZ_IG))
-                       bridge->driver = &intel_i965_driver;
-               else
-                       bridge->driver = &intel_845_driver;
-               name = "946GZ";
-               break;
-       case PCI_DEVICE_ID_INTEL_82965G_1_HB:
-               if (find_i830(PCI_DEVICE_ID_INTEL_82965G_1_IG))
-                       bridge->driver = &intel_i965_driver;
-               else
-                       bridge->driver = &intel_845_driver;
-               name = "965G";
-               break;
-       case PCI_DEVICE_ID_INTEL_82965Q_HB:
-               if (find_i830(PCI_DEVICE_ID_INTEL_82965Q_IG))
-                       bridge->driver = &intel_i965_driver;
-               else
-                       bridge->driver = &intel_845_driver;
-               name = "965Q";
-               break;
-       case PCI_DEVICE_ID_INTEL_82965G_HB:
-               if (find_i830(PCI_DEVICE_ID_INTEL_82965G_IG))
-                       bridge->driver = &intel_i965_driver;
-               else
-                       bridge->driver = &intel_845_driver;
-               name = "965G";
-               break;
+	case PCI_DEVICE_ID_INTEL_82946GZ_HB:
+		if (find_i830(PCI_DEVICE_ID_INTEL_82946GZ_IG))
+			bridge->driver = &intel_i965_driver;
+		else
+			bridge->driver = &intel_845_driver;
+		name = "946GZ";
+		break;
+	case PCI_DEVICE_ID_INTEL_82965G_1_HB:
+		if (find_i830(PCI_DEVICE_ID_INTEL_82965G_1_IG))
+			bridge->driver = &intel_i965_driver;
+		else
+			bridge->driver = &intel_845_driver;
+		name = "965G";
+		break;
+	case PCI_DEVICE_ID_INTEL_82965Q_HB:
+		if (find_i830(PCI_DEVICE_ID_INTEL_82965Q_IG))
+			bridge->driver = &intel_i965_driver;
+		else
+			bridge->driver = &intel_845_driver;
+		name = "965Q";
+		break;
+	case PCI_DEVICE_ID_INTEL_82965G_HB:
+		if (find_i830(PCI_DEVICE_ID_INTEL_82965G_IG))
+			bridge->driver = &intel_i965_driver;
+		else
+			bridge->driver = &intel_845_driver;
+		name = "965G";
+		break;
 
 	case PCI_DEVICE_ID_INTEL_7505_0:
 		bridge->driver = &intel_7505_driver;
@@ -1978,10 +1976,10 @@ #define ID(x)						\
 	ID(PCI_DEVICE_ID_INTEL_82915GM_HB),
 	ID(PCI_DEVICE_ID_INTEL_82945G_HB),
 	ID(PCI_DEVICE_ID_INTEL_82945GM_HB),
-        ID(PCI_DEVICE_ID_INTEL_82946GZ_HB),
-        ID(PCI_DEVICE_ID_INTEL_82965G_1_HB),
-        ID(PCI_DEVICE_ID_INTEL_82965Q_HB),
-        ID(PCI_DEVICE_ID_INTEL_82965G_HB),
+	ID(PCI_DEVICE_ID_INTEL_82946GZ_HB),
+	ID(PCI_DEVICE_ID_INTEL_82965G_1_HB),
+	ID(PCI_DEVICE_ID_INTEL_82965Q_HB),
+	ID(PCI_DEVICE_ID_INTEL_82965G_HB),
 	{ }
 };
 
-- 
1.4.1

