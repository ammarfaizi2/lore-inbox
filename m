Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268936AbTBZUvN>; Wed, 26 Feb 2003 15:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268941AbTBZUvN>; Wed, 26 Feb 2003 15:51:13 -0500
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:48401 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S268936AbTBZUuz>; Wed, 26 Feb 2003 15:50:55 -0500
Date: Wed, 26 Feb 2003 14:55:16 -0600
From: Art Haas <ahaas@airmail.net>
To: mtd@infradead.org, linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for drivers/mtd/chips
Message-ID: <20030226205516.GC8966@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here are a set of patches for converting files in drivers/mtd/chips to
use C99 initializers. The patches are against the current BK.

Art Haas

===== drivers/mtd/chips/amd_flash.c 1.4 vs edited =====
--- 1.4/drivers/mtd/chips/amd_flash.c	Tue Feb  5 09:26:32 2002
+++ edited/drivers/mtd/chips/amd_flash.c	Wed Feb 26 13:19:57 2003
@@ -120,10 +120,10 @@
 
 
 static struct mtd_chip_driver amd_flash_chipdrv = {
-	probe: amd_flash_probe,
-	destroy: amd_flash_destroy,
-	name: "amd_flash",
-	module: THIS_MODULE
+	.probe		= amd_flash_probe,
+	.destroy	= amd_flash_destroy,
+	.name		= "amd_flash",
+	.module		= THIS_MODULE
 };
 
 
@@ -424,194 +424,194 @@
 	 */
 	const struct amd_flash_info table[] = {
 	{
-		mfr_id: MANUFACTURER_AMD,
-		dev_id: AM29LV160DT,
-		name: "AMD AM29LV160DT",
-		size: 0x00200000,
-		numeraseregions: 4,
-		regions: {
-			{ offset: 0x000000, erasesize: 0x10000, numblocks: 31 },
-			{ offset: 0x1F0000, erasesize: 0x08000, numblocks:  1 },
-			{ offset: 0x1F8000, erasesize: 0x02000, numblocks:  2 },
-			{ offset: 0x1FC000, erasesize: 0x04000, numblocks:  1 }
-		}
-	}, {
-		mfr_id: MANUFACTURER_AMD,
-		dev_id: AM29LV160DB,
-		name: "AMD AM29LV160DB",
-		size: 0x00200000,
-		numeraseregions: 4,
-		regions: {
-			{ offset: 0x000000, erasesize: 0x04000, numblocks:  1 },
-			{ offset: 0x004000, erasesize: 0x02000, numblocks:  2 },
-			{ offset: 0x008000, erasesize: 0x08000, numblocks:  1 },
-			{ offset: 0x010000, erasesize: 0x10000, numblocks: 31 }
-		}
-	}, {
-		mfr_id: MANUFACTURER_TOSHIBA,
-		dev_id: TC58FVT160,
-		name: "Toshiba TC58FVT160",
-		size: 0x00200000,
-		numeraseregions: 4,
-		regions: {
-			{ offset: 0x000000, erasesize: 0x10000, numblocks: 31 },
-			{ offset: 0x1F0000, erasesize: 0x08000, numblocks:  1 },
-			{ offset: 0x1F8000, erasesize: 0x02000, numblocks:  2 },
-			{ offset: 0x1FC000, erasesize: 0x04000, numblocks:  1 }
-		}
-	}, {
-		mfr_id: MANUFACTURER_FUJITSU,
-		dev_id: MBM29LV160TE,
-		name: "Fujitsu MBM29LV160TE",
-		size: 0x00200000,
-		numeraseregions: 4,
-		regions: {
-			{ offset: 0x000000, erasesize: 0x10000, numblocks: 31 },
-			{ offset: 0x1F0000, erasesize: 0x08000, numblocks:  1 },
-			{ offset: 0x1F8000, erasesize: 0x02000, numblocks:  2 },
-			{ offset: 0x1FC000, erasesize: 0x04000, numblocks:  1 }
-		}
-	}, {
-		mfr_id: MANUFACTURER_TOSHIBA,
-		dev_id: TC58FVB160,
-		name: "Toshiba TC58FVB160",
-		size: 0x00200000,
-		numeraseregions: 4,
-		regions: {
-			{ offset: 0x000000, erasesize: 0x04000, numblocks:  1 },
-			{ offset: 0x004000, erasesize: 0x02000, numblocks:  2 },
-			{ offset: 0x008000, erasesize: 0x08000, numblocks:  1 },
-			{ offset: 0x010000, erasesize: 0x10000, numblocks: 31 }
-		}
-	}, {
-		mfr_id: MANUFACTURER_FUJITSU,
-		dev_id: MBM29LV160BE,
-		name: "Fujitsu MBM29LV160BE",
-		size: 0x00200000,
-		numeraseregions: 4,
-		regions: {
-			{ offset: 0x000000, erasesize: 0x04000, numblocks:  1 },
-			{ offset: 0x004000, erasesize: 0x02000, numblocks:  2 },
-			{ offset: 0x008000, erasesize: 0x08000, numblocks:  1 },
-			{ offset: 0x010000, erasesize: 0x10000, numblocks: 31 }
-		}
-	}, {
-		mfr_id: MANUFACTURER_AMD,
-		dev_id: AM29LV800BB,
-		name: "AMD AM29LV800BB",
-		size: 0x00100000,
-		numeraseregions: 4,
-		regions: {
-			{ offset: 0x000000, erasesize: 0x04000, numblocks:  1 },
-			{ offset: 0x004000, erasesize: 0x02000, numblocks:  2 },
-			{ offset: 0x008000, erasesize: 0x08000, numblocks:  1 },
-			{ offset: 0x010000, erasesize: 0x10000, numblocks: 15 }
-		}
-	}, {
-		mfr_id: MANUFACTURER_AMD,
-		dev_id: AM29F800BB,
-		name: "AMD AM29F800BB",
-		size: 0x00100000,
-		numeraseregions: 4,
-		regions: {
-			{ offset: 0x000000, erasesize: 0x04000, numblocks:  1 },
-			{ offset: 0x004000, erasesize: 0x02000, numblocks:  2 },
-			{ offset: 0x008000, erasesize: 0x08000, numblocks:  1 },
-			{ offset: 0x010000, erasesize: 0x10000, numblocks: 15 }
-		}
-	}, {
-		mfr_id: MANUFACTURER_AMD,
-		dev_id: AM29LV800BT,
-		name: "AMD AM29LV800BT",
-		size: 0x00100000,
-		numeraseregions: 4,
-		regions: {
-			{ offset: 0x000000, erasesize: 0x10000, numblocks: 15 },
-			{ offset: 0x0F0000, erasesize: 0x08000, numblocks:  1 },
-			{ offset: 0x0F8000, erasesize: 0x02000, numblocks:  2 },
-			{ offset: 0x0FC000, erasesize: 0x04000, numblocks:  1 }
-		}
-	}, {
-		mfr_id: MANUFACTURER_AMD,
-		dev_id: AM29F800BT,
-		name: "AMD AM29F800BT",
-		size: 0x00100000,
-		numeraseregions: 4,
-		regions: {
-			{ offset: 0x000000, erasesize: 0x10000, numblocks: 15 },
-			{ offset: 0x0F0000, erasesize: 0x08000, numblocks:  1 },
-			{ offset: 0x0F8000, erasesize: 0x02000, numblocks:  2 },
-			{ offset: 0x0FC000, erasesize: 0x04000, numblocks:  1 }
-		}
-	}, {
-		mfr_id: MANUFACTURER_AMD,
-		dev_id: AM29LV800BB,
-		name: "AMD AM29LV800BB",
-		size: 0x00100000,
-		numeraseregions: 4,
-		regions: {
-			{ offset: 0x000000, erasesize: 0x10000, numblocks: 15 },
-			{ offset: 0x0F0000, erasesize: 0x08000, numblocks:  1 },
-			{ offset: 0x0F8000, erasesize: 0x02000, numblocks:  2 },
-			{ offset: 0x0FC000, erasesize: 0x04000, numblocks:  1 }
-		}
-	}, {
-		mfr_id: MANUFACTURER_ST,
-		dev_id: M29W800T,
-		name: "ST M29W800T",
-		size: 0x00100000,
-		numeraseregions: 4,
-		regions: {
-			{ offset: 0x000000, erasesize: 0x10000, numblocks: 15 },
-			{ offset: 0x0F0000, erasesize: 0x08000, numblocks:  1 },
-			{ offset: 0x0F8000, erasesize: 0x02000, numblocks:  2 },
-			{ offset: 0x0FC000, erasesize: 0x04000, numblocks:  1 }
-		}
-	}, {
-		mfr_id: MANUFACTURER_ST,
-		dev_id: M29W160DT,
-		name: "ST M29W160DT",
-		size: 0x00200000,
-		numeraseregions: 4,
-		regions: {
-			{ offset: 0x000000, erasesize: 0x10000, numblocks: 31 },
-			{ offset: 0x1F0000, erasesize: 0x08000, numblocks:  1 },
-			{ offset: 0x1F8000, erasesize: 0x02000, numblocks:  2 },
-			{ offset: 0x1FC000, erasesize: 0x04000, numblocks:  1 }
-		}
-	}, {
-		mfr_id: MANUFACTURER_ST,
-		dev_id: M29W160DB,
-		name: "ST M29W160DB",
-		size: 0x00200000,
-		numeraseregions: 4,
-		regions: {
-			{ offset: 0x000000, erasesize: 0x04000, numblocks:  1 },
-			{ offset: 0x004000, erasesize: 0x02000, numblocks:  2 },
-			{ offset: 0x008000, erasesize: 0x08000, numblocks:  1 },
-			{ offset: 0x010000, erasesize: 0x10000, numblocks: 31 }
-		}
-	}, {
-		mfr_id: MANUFACTURER_AMD,
-		dev_id: AM29BDS323D,
-		name: "AMD AM29BDS323D",
-		size: 0x00400000,
-		numeraseregions: 3,
-		regions: {
-			{ offset: 0x000000, erasesize: 0x10000, numblocks: 48 },
-			{ offset: 0x300000, erasesize: 0x10000, numblocks: 15 },
-			{ offset: 0x3f0000, erasesize: 0x02000, numblocks:  8 },
-		}
-	}, {
-		mfr_id: MANUFACTURER_AMD,
-		dev_id: AM29BDS643D,
-		name: "AMD AM29BDS643D",
-		size: 0x00800000,
-		numeraseregions: 3,
-		regions: {
-			{ offset: 0x000000, erasesize: 0x10000, numblocks: 96 },
-			{ offset: 0x600000, erasesize: 0x10000, numblocks: 31 },
-			{ offset: 0x7f0000, erasesize: 0x02000, numblocks:  8 },
+		.mfr_id = MANUFACTURER_AMD,
+		.dev_id = AM29LV160DT,
+		.name = "AMD AM29LV160DT",
+		.size = 0x00200000,
+		.numeraseregions = 4,
+		.regions = {
+			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 31 },
+			{ .offset = 0x1F0000, .erasesize = 0x08000, .numblocks  = 1 },
+			{ .offset = 0x1F8000, .erasesize = 0x02000, .numblocks  = 2 },
+			{ .offset = 0x1FC000, .erasesize = 0x04000, .numblocks  = 1 }
+		}
+	}, {
+		.mfr_id = MANUFACTURER_AMD,
+		.dev_id = AM29LV160DB,
+		.name = "AMD AM29LV160DB",
+		.size = 0x00200000,
+		.numeraseregions = 4,
+		.regions = {
+			{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
+			{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
+			{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
+			{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 31 }
+		}
+	}, {
+		.mfr_id = MANUFACTURER_TOSHIBA,
+		.dev_id = TC58FVT160,
+		.name = "Toshiba TC58FVT160",
+		.size = 0x00200000,
+		.numeraseregions = 4,
+		.regions = {
+			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 31 },
+			{ .offset = 0x1F0000, .erasesize = 0x08000, .numblocks  = 1 },
+			{ .offset = 0x1F8000, .erasesize = 0x02000, .numblocks  = 2 },
+			{ .offset = 0x1FC000, .erasesize = 0x04000, .numblocks  = 1 }
+		}
+	}, {
+		.mfr_id = MANUFACTURER_FUJITSU,
+		.dev_id = MBM29LV160TE,
+		.name = "Fujitsu MBM29LV160TE",
+		.size = 0x00200000,
+		.numeraseregions = 4,
+		.regions = {
+			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 31 },
+			{ .offset = 0x1F0000, .erasesize = 0x08000, .numblocks  = 1 },
+			{ .offset = 0x1F8000, .erasesize = 0x02000, .numblocks  = 2 },
+			{ .offset = 0x1FC000, .erasesize = 0x04000, .numblocks  = 1 }
+		}
+	}, {
+		.mfr_id = MANUFACTURER_TOSHIBA,
+		.dev_id = TC58FVB160,
+		.name = "Toshiba TC58FVB160",
+		.size = 0x00200000,
+		.numeraseregions = 4,
+		.regions = {
+			{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
+			{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
+			{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
+			{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 31 }
+		}
+	}, {
+		.mfr_id = MANUFACTURER_FUJITSU,
+		.dev_id = MBM29LV160BE,
+		.name = "Fujitsu MBM29LV160BE",
+		.size = 0x00200000,
+		.numeraseregions = 4,
+		.regions = {
+			{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
+			{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
+			{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
+			{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 31 }
+		}
+	}, {
+		.mfr_id = MANUFACTURER_AMD,
+		.dev_id = AM29LV800BB,
+		.name = "AMD AM29LV800BB",
+		.size = 0x00100000,
+		.numeraseregions = 4,
+		.regions = {
+			{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
+			{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
+			{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
+			{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 15 }
+		}
+	}, {
+		.mfr_id = MANUFACTURER_AMD,
+		.dev_id = AM29F800BB,
+		.name = "AMD AM29F800BB",
+		.size = 0x00100000,
+		.numeraseregions = 4,
+		.regions = {
+			{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
+			{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
+			{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
+			{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 15 }
+		}
+	}, {
+		.mfr_id = MANUFACTURER_AMD,
+		.dev_id = AM29LV800BT,
+		.name = "AMD AM29LV800BT",
+		.size = 0x00100000,
+		.numeraseregions = 4,
+		.regions = {
+			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 15 },
+			{ .offset = 0x0F0000, .erasesize = 0x08000, .numblocks  = 1 },
+			{ .offset = 0x0F8000, .erasesize = 0x02000, .numblocks  = 2 },
+			{ .offset = 0x0FC000, .erasesize = 0x04000, .numblocks  = 1 }
+		}
+	}, {
+		.mfr_id = MANUFACTURER_AMD,
+		.dev_id = AM29F800BT,
+		.name = "AMD AM29F800BT",
+		.size = 0x00100000,
+		.numeraseregions = 4,
+		.regions = {
+			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 15 },
+			{ .offset = 0x0F0000, .erasesize = 0x08000, .numblocks  = 1 },
+			{ .offset = 0x0F8000, .erasesize = 0x02000, .numblocks  = 2 },
+			{ .offset = 0x0FC000, .erasesize = 0x04000, .numblocks  = 1 }
+		}
+	}, {
+		.mfr_id = MANUFACTURER_AMD,
+		.dev_id = AM29LV800BB,
+		.name = "AMD AM29LV800BB",
+		.size = 0x00100000,
+		.numeraseregions = 4,
+		.regions = {
+			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 15 },
+			{ .offset = 0x0F0000, .erasesize = 0x08000, .numblocks  = 1 },
+			{ .offset = 0x0F8000, .erasesize = 0x02000, .numblocks  = 2 },
+			{ .offset = 0x0FC000, .erasesize = 0x04000, .numblocks  = 1 }
+		}
+	}, {
+		.mfr_id = MANUFACTURER_ST,
+		.dev_id = M29W800T,
+		.name = "ST M29W800T",
+		.size = 0x00100000,
+		.numeraseregions = 4,
+		.regions = {
+			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 15 },
+			{ .offset = 0x0F0000, .erasesize = 0x08000, .numblocks  = 1 },
+			{ .offset = 0x0F8000, .erasesize = 0x02000, .numblocks  = 2 },
+			{ .offset = 0x0FC000, .erasesize = 0x04000, .numblocks  = 1 }
+		}
+	}, {
+		.mfr_id = MANUFACTURER_ST,
+		.dev_id = M29W160DT,
+		.name = "ST M29W160DT",
+		.size = 0x00200000,
+		.numeraseregions = 4,
+		.regions = {
+			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 31 },
+			{ .offset = 0x1F0000, .erasesize = 0x08000, .numblocks  = 1 },
+			{ .offset = 0x1F8000, .erasesize = 0x02000, .numblocks  = 2 },
+			{ .offset = 0x1FC000, .erasesize = 0x04000, .numblocks  = 1 }
+		}
+	}, {
+		.mfr_id = MANUFACTURER_ST,
+		.dev_id = M29W160DB,
+		.name = "ST M29W160DB",
+		.size = 0x00200000,
+		.numeraseregions = 4,
+		.regions = {
+			{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
+			{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
+			{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
+			{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 31 }
+		}
+	}, {
+		.mfr_id = MANUFACTURER_AMD,
+		.dev_id = AM29BDS323D,
+		.name = "AMD AM29BDS323D",
+		.size = 0x00400000,
+		.numeraseregions = 3,
+		.regions = {
+			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 48 },
+			{ .offset = 0x300000, .erasesize = 0x10000, .numblocks = 15 },
+			{ .offset = 0x3f0000, .erasesize = 0x02000, .numblocks  = 8 },
+		}
+	}, {
+		.mfr_id = MANUFACTURER_AMD,
+		.dev_id = AM29BDS643D,
+		.name = "AMD AM29BDS643D",
+		.size = 0x00800000,
+		.numeraseregions = 3,
+		.regions = {
+			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 96 },
+			{ .offset = 0x600000, .erasesize = 0x10000, .numblocks = 31 },
+			{ .offset = 0x7f0000, .erasesize = 0x02000, .numblocks  = 8 },
 		}
 	} 
 	};
===== drivers/mtd/chips/cfi_cmdset_0001.c 1.5 vs edited =====
--- 1.5/drivers/mtd/chips/cfi_cmdset_0001.c	Tue Feb  5 01:49:33 2002
+++ edited/drivers/mtd/chips/cfi_cmdset_0001.c	Wed Feb 26 13:20:48 2003
@@ -47,10 +47,10 @@
 static struct mtd_info *cfi_intelext_setup (struct map_info *);
 
 static struct mtd_chip_driver cfi_intelext_chipdrv = {
-	probe: NULL, /* Not usable directly */
-	destroy: cfi_intelext_destroy,
-	name: "cfi_cmdset_0001",
-	module: THIS_MODULE
+	.probe		= NULL, /* Not usable directly */
+	.destroy	= cfi_intelext_destroy,
+	.name		= "cfi_cmdset_0001",
+	.module		= THIS_MODULE
 };
 
 /* #define DEBUG_LOCK_BITS */
===== drivers/mtd/chips/cfi_cmdset_0002.c 1.6 vs edited =====
--- 1.6/drivers/mtd/chips/cfi_cmdset_0002.c	Tue Feb  5 01:53:43 2002
+++ edited/drivers/mtd/chips/cfi_cmdset_0002.c	Wed Feb 26 13:21:22 2003
@@ -43,10 +43,10 @@
 
 
 static struct mtd_chip_driver cfi_amdstd_chipdrv = {
-	probe: NULL, /* Not usable directly */
-	destroy: cfi_amdstd_destroy,
-	name: "cfi_cmdset_0002",
-	module: THIS_MODULE
+	.probe		= NULL, /* Not usable directly */
+	.destroy	= cfi_amdstd_destroy,
+	.name		= "cfi_cmdset_0002",
+	.module		= THIS_MODULE
 };
 
 struct mtd_info *cfi_cmdset_0002(struct map_info *map, int primary)
===== drivers/mtd/chips/cfi_probe.c 1.4 vs edited =====
--- 1.4/drivers/mtd/chips/cfi_probe.c	Tue Feb  5 01:49:33 2002
+++ edited/drivers/mtd/chips/cfi_probe.c	Wed Feb 26 13:21:54 2003
@@ -294,8 +294,8 @@
 #endif /* DEBUG_CFI */
 
 static struct chip_probe cfi_chip_probe = {
-	name: "CFI",
-	probe_chip: cfi_probe_chip
+	.name		= "CFI",
+	.probe_chip	= cfi_probe_chip
 };
 
 struct mtd_info *cfi_probe(struct map_info *map)
@@ -308,9 +308,9 @@
 }
 
 static struct mtd_chip_driver cfi_chipdrv = {
-	probe: cfi_probe,
-	name: "cfi_probe",
-	module: THIS_MODULE
+	.probe		= cfi_probe,
+	.name		= "cfi_probe",
+	.module		= THIS_MODULE
 };
 
 int __init cfi_probe_init(void)
===== drivers/mtd/chips/jedec.c 1.7 vs edited =====
--- 1.7/drivers/mtd/chips/jedec.c	Sat Feb 15 15:13:54 2003
+++ edited/drivers/mtd/chips/jedec.c	Wed Feb 26 13:26:46 2003
@@ -33,14 +33,51 @@
 
 /* Listing of parts and sizes. We need this table to learn the sector
    size of the chip and the total length */
-static const struct JEDECTable JEDEC_table[] = 
-  {{0x013D,"AMD Am29F017D",2*1024*1024,64*1024,MTD_CAP_NORFLASH},
-   {0x01AD,"AMD Am29F016",2*1024*1024,64*1024,MTD_CAP_NORFLASH},
-   {0x01D5,"AMD Am29F080",1*1024*1024,64*1024,MTD_CAP_NORFLASH},
-   {0x01A4,"AMD Am29F040",512*1024,64*1024,MTD_CAP_NORFLASH},
-   {0x20E3,"AMD Am29W040B",512*1024,64*1024,MTD_CAP_NORFLASH},
-   {0xC2AD,"Macronix MX29F016",2*1024*1024,64*1024,MTD_CAP_NORFLASH},
-   {}};
+static const struct JEDECTable JEDEC_table[] = {
+	{
+		.jedec		= 0x013D,
+		.name		= "AMD Am29F017D",
+		.size		= 2*1024*1024,
+		.sectorsize	= 64*1024,
+		.capabilities	= MTD_CAP_NORFLASH
+	},
+	{
+		.jedec		= 0x01AD,
+		.name		= "AMD Am29F016",
+		.size		= 2*1024*1024,
+		.sectorsize	= 64*1024,
+		.capabilities	= MTD_CAP_NORFLASH
+	},
+	{
+		.jedec		= 0x01D5,
+		.name		= "AMD Am29F080",
+		.size		= 1*1024*1024,
+		.sectorsize	= 64*1024,
+		.capabilities	= MTD_CAP_NORFLASH
+	},
+	{
+		.jedec		= 0x01A4,
+		.name		= "AMD Am29F040",
+		.size		= 512*1024,
+		.sectorsize	= 64*1024,
+		.capabilities	= MTD_CAP_NORFLASH
+	},
+	{
+		.jedec		= 0x20E3,
+		.name		= "AMD Am29W040B",
+		.size		= 512*1024,
+		.sectorsize	= 64*1024,
+		.capabilities	= MTD_CAP_NORFLASH
+	},
+	{
+		.jedec		= 0xC2AD,
+		.name		= "Macronix MX29F016",
+		.size		= 2*1024*1024,
+		.sectorsize	= 64*1024,
+		.capabilities	= MTD_CAP_NORFLASH
+	},
+	{ .jedec = 0x0 }
+};
 
 static const struct JEDECTable *jedec_idtoinf(__u8 mfr,__u8 id);
 static void jedec_sync(struct mtd_info *mtd) {};
@@ -54,9 +91,9 @@
 
 
 static struct mtd_chip_driver jedec_chipdrv = {
-	probe: jedec_probe,
-	name: "jedec",
-	module: THIS_MODULE
+	.probe	= jedec_probe,
+	.name	= "jedec",
+	.module	= THIS_MODULE
 };
 
 /* Probe entry point */
===== drivers/mtd/chips/jedec_probe.c 1.4 vs edited =====
--- 1.4/drivers/mtd/chips/jedec_probe.c	Tue Feb  5 01:51:32 2002
+++ edited/drivers/mtd/chips/jedec_probe.c	Wed Feb 26 13:27:14 2003
@@ -75,176 +75,176 @@
 
 static const struct amd_flash_info jedec_table[] = {
 	{
-		mfr_id: MANUFACTURER_AMD,
-		dev_id: AM29LV160DT,
-		name: "AMD AM29LV160DT",
-		DevSize: SIZE_2MiB,
-		NumEraseRegions: 4,
-		regions: {ERASEINFO(0x10000,31),
+		.mfr_id = MANUFACTURER_AMD,
+		.dev_id = AM29LV160DT,
+		.name = "AMD AM29LV160DT",
+		.DevSize = SIZE_2MiB,
+		.NumEraseRegions = 4,
+		.regions = {ERASEINFO(0x10000,31),
 			  ERASEINFO(0x08000,1),
 			  ERASEINFO(0x02000,2),
 			  ERASEINFO(0x04000,1)
 		}
 	}, {
-		mfr_id: MANUFACTURER_AMD,
-		dev_id: AM29LV160DB,
-		name: "AMD AM29LV160DB",
-		DevSize: SIZE_2MiB,
-		NumEraseRegions: 4,
-		regions: {ERASEINFO(0x04000,1),
+		.mfr_id = MANUFACTURER_AMD,
+		.dev_id = AM29LV160DB,
+		.name = "AMD AM29LV160DB",
+		.DevSize = SIZE_2MiB,
+		.NumEraseRegions = 4,
+		.regions = {ERASEINFO(0x04000,1),
 			  ERASEINFO(0x02000,2),
 			  ERASEINFO(0x08000,1),
 			  ERASEINFO(0x10000,31)
 		}
 	}, {
-		mfr_id: MANUFACTURER_TOSHIBA,
-		dev_id: TC58FVT160,
-		name: "Toshiba TC58FVT160",
-		DevSize: SIZE_2MiB,
-		NumEraseRegions: 4,
-		regions: {ERASEINFO(0x10000,31),
+		.mfr_id = MANUFACTURER_TOSHIBA,
+		.dev_id = TC58FVT160,
+		.name = "Toshiba TC58FVT160",
+		.DevSize = SIZE_2MiB,
+		.NumEraseRegions = 4,
+		.regions = {ERASEINFO(0x10000,31),
 			  ERASEINFO(0x08000,1),
 			  ERASEINFO(0x02000,2),
 			  ERASEINFO(0x04000,1)
 		}
 	}, {
-		mfr_id: MANUFACTURER_FUJITSU,
-		dev_id: MBM29LV160TE,
-		name: "Fujitsu MBM29LV160TE",
-		DevSize: SIZE_2MiB,
-		NumEraseRegions: 4,
-		regions: {ERASEINFO(0x10000,31),
+		.mfr_id = MANUFACTURER_FUJITSU,
+		.dev_id = MBM29LV160TE,
+		.name = "Fujitsu MBM29LV160TE",
+		.DevSize = SIZE_2MiB,
+		.NumEraseRegions = 4,
+		.regions = {ERASEINFO(0x10000,31),
 			  ERASEINFO(0x08000,1),
 			  ERASEINFO(0x02000,2),
 			  ERASEINFO(0x04000,1)
 		}
 	}, {
-		mfr_id: MANUFACTURER_TOSHIBA,
-		dev_id: TC58FVB160,
-		name: "Toshiba TC58FVB160",
-		DevSize: SIZE_2MiB,
-		NumEraseRegions: 4,
-		regions: {ERASEINFO(0x04000,1),
+		.mfr_id = MANUFACTURER_TOSHIBA,
+		.dev_id = TC58FVB160,
+		.name = "Toshiba TC58FVB160",
+		.DevSize = SIZE_2MiB,
+		.NumEraseRegions = 4,
+		.regions = {ERASEINFO(0x04000,1),
 			  ERASEINFO(0x02000,2),
 			  ERASEINFO(0x08000,1),
 			  ERASEINFO(0x10000,31)
 		}
 	}, {
-		mfr_id: MANUFACTURER_FUJITSU,
-		dev_id: MBM29LV160BE,
-		name: "Fujitsu MBM29LV160BE",
-		DevSize: SIZE_2MiB,
-		NumEraseRegions: 4,
-		regions: {ERASEINFO(0x04000,1),
+		.mfr_id = MANUFACTURER_FUJITSU,
+		.dev_id = MBM29LV160BE,
+		.name = "Fujitsu MBM29LV160BE",
+		.DevSize = SIZE_2MiB,
+		.NumEraseRegions = 4,
+		.regions = {ERASEINFO(0x04000,1),
 			  ERASEINFO(0x02000,2),
 			  ERASEINFO(0x08000,1),
 			  ERASEINFO(0x10000,31)
 		}
 	}, {
-		mfr_id: MANUFACTURER_AMD,
-		dev_id: AM29LV800BB,
-		name: "AMD AM29LV800BB",
-		DevSize: SIZE_1MiB,
-		NumEraseRegions: 4,
-		regions: {ERASEINFO(0x04000,1),
+		.mfr_id = MANUFACTURER_AMD,
+		.dev_id = AM29LV800BB,
+		.name = "AMD AM29LV800BB",
+		.DevSize = SIZE_1MiB,
+		.NumEraseRegions = 4,
+		.regions = {ERASEINFO(0x04000,1),
 			  ERASEINFO(0x02000,2),
 			  ERASEINFO(0x08000,1),
 			  ERASEINFO(0x10000,15),
 		}
 	}, {
-		mfr_id: MANUFACTURER_AMD,
-		dev_id: AM29F800BB,
-		name: "AMD AM29F800BB",
-		DevSize: SIZE_1MiB,
-		NumEraseRegions: 4,
-		regions: {ERASEINFO(0x04000,1),
+		.mfr_id = MANUFACTURER_AMD,
+		.dev_id = AM29F800BB,
+		.name = "AMD AM29F800BB",
+		.DevSize = SIZE_1MiB,
+		.NumEraseRegions = 4,
+		.regions = {ERASEINFO(0x04000,1),
 			  ERASEINFO(0x02000,2),
 			  ERASEINFO(0x08000,1),
 			  ERASEINFO(0x10000,15),
 		}
 	}, {
-		mfr_id: MANUFACTURER_AMD,
-		dev_id: AM29LV800BT,
-		name: "AMD AM29LV800BT",
-		DevSize: SIZE_1MiB,
-		NumEraseRegions: 4,
-		regions: {ERASEINFO(0x10000,15),
+		.mfr_id = MANUFACTURER_AMD,
+		.dev_id = AM29LV800BT,
+		.name = "AMD AM29LV800BT",
+		.DevSize = SIZE_1MiB,
+		.NumEraseRegions = 4,
+		.regions = {ERASEINFO(0x10000,15),
 			  ERASEINFO(0x08000,1),
 			  ERASEINFO(0x02000,2),
 			  ERASEINFO(0x04000,1)
 		}
 	}, {
-		mfr_id: MANUFACTURER_AMD,
-		dev_id: AM29F800BT,
-		name: "AMD AM29F800BT",
-		DevSize: SIZE_1MiB,
-		NumEraseRegions: 4,
-		regions: {ERASEINFO(0x10000,15),
+		.mfr_id = MANUFACTURER_AMD,
+		.dev_id = AM29F800BT,
+		.name = "AMD AM29F800BT",
+		.DevSize = SIZE_1MiB,
+		.NumEraseRegions = 4,
+		.regions = {ERASEINFO(0x10000,15),
 			  ERASEINFO(0x08000,1),
 			  ERASEINFO(0x02000,2),
 			  ERASEINFO(0x04000,1)
 		}
 	}, {
-		mfr_id: MANUFACTURER_AMD,
-		dev_id: AM29LV800BB,
-		name: "AMD AM29LV800BB",
-		DevSize: SIZE_1MiB,
-		NumEraseRegions: 4,
-		regions: {ERASEINFO(0x10000,15),
+		.mfr_id = MANUFACTURER_AMD,
+		.dev_id = AM29LV800BB,
+		.name = "AMD AM29LV800BB",
+		.DevSize = SIZE_1MiB,
+		.NumEraseRegions = 4,
+		.regions = {ERASEINFO(0x10000,15),
 			  ERASEINFO(0x08000,1),
 			  ERASEINFO(0x02000,2),
 			  ERASEINFO(0x04000,1)
 		}
 	}, {
-		mfr_id: MANUFACTURER_ST,
-		dev_id: M29W800T,
-		name: "ST M29W800T",
-		DevSize: SIZE_1MiB,
-		NumEraseRegions: 4,
-		regions: {ERASEINFO(0x10000,15),
+		.mfr_id = MANUFACTURER_ST,
+		.dev_id = M29W800T,
+		.name = "ST M29W800T",
+		.DevSize = SIZE_1MiB,
+		.NumEraseRegions = 4,
+		.regions = {ERASEINFO(0x10000,15),
 			  ERASEINFO(0x08000,1),
 			  ERASEINFO(0x02000,2),
 			  ERASEINFO(0x04000,1)
 		}
 	}, {
-		mfr_id: MANUFACTURER_ST,
-		dev_id: M29W160DT,
-		name: "ST M29W160DT",
-		DevSize: SIZE_2MiB,
-		NumEraseRegions: 4,
-		regions: {ERASEINFO(0x10000,31),
+		.mfr_id = MANUFACTURER_ST,
+		.dev_id = M29W160DT,
+		.name = "ST M29W160DT",
+		.DevSize = SIZE_2MiB,
+		.NumEraseRegions = 4,
+		.regions = {ERASEINFO(0x10000,31),
 			  ERASEINFO(0x08000,1),
 			  ERASEINFO(0x02000,2),
 			  ERASEINFO(0x04000,1)
 		}
 	}, {
-		mfr_id: MANUFACTURER_ST,
-		dev_id: M29W160DB,
-		name: "ST M29W160DB",
-		DevSize: SIZE_2MiB,
-		NumEraseRegions: 4,
-		regions: {ERASEINFO(0x04000,1),
+		.mfr_id = MANUFACTURER_ST,
+		.dev_id = M29W160DB,
+		.name = "ST M29W160DB",
+		.DevSize = SIZE_2MiB,
+		.NumEraseRegions = 4,
+		.regions = {ERASEINFO(0x04000,1),
 			  ERASEINFO(0x02000,2),
 			  ERASEINFO(0x08000,1),
 			  ERASEINFO(0x10000,31)
 		}
 	}, {
-		mfr_id: MANUFACTURER_ATMEL,
-		dev_id: AT49BV16X4,
-		name: "Atmel AT49BV16X4",
-		DevSize: SIZE_2MiB,
-		NumEraseRegions: 3,
-		regions: {ERASEINFO(0x02000,8),
+		.mfr_id = MANUFACTURER_ATMEL,
+		.dev_id = AT49BV16X4,
+		.name = "Atmel AT49BV16X4",
+		.DevSize = SIZE_2MiB,
+		.NumEraseRegions = 3,
+		.regions = {ERASEINFO(0x02000,8),
 			  ERASEINFO(0x08000,2),
 			  ERASEINFO(0x10000,30)
 		}
 	}, {
-                mfr_id: MANUFACTURER_ATMEL,
-                dev_id: AT49BV16X4T,
-                name: "Atmel AT49BV16X4T",
-                DevSize: SIZE_2MiB,
-                NumEraseRegions: 3,
-                regions: {ERASEINFO(0x10000,30),
+                .mfr_id = MANUFACTURER_ATMEL,
+                .dev_id = AT49BV16X4T,
+                .name = "Atmel AT49BV16X4T",
+                .DevSize = SIZE_2MiB,
+                .NumEraseRegions = 3,
+                .regions = {ERASEINFO(0x10000,30),
                           ERASEINFO(0x08000,2),
 			  ERASEINFO(0x02000,8)
                 }
@@ -403,8 +403,8 @@
 }
 
 static struct chip_probe jedec_chip_probe = {
-	name: "JEDEC",
-	probe_chip: jedec_probe_chip
+	.name = "JEDEC",
+	.probe_chip = jedec_probe_chip
 };
 
 struct mtd_info *jedec_probe(struct map_info *map)
@@ -417,9 +417,9 @@
 }
 
 static struct mtd_chip_driver jedec_chipdrv = {
-	probe: jedec_probe,
-	name: "jedec_probe",
-	module: THIS_MODULE
+	.probe	= jedec_probe,
+	.name	= "jedec_probe",
+	.module	= THIS_MODULE
 };
 
 int __init jedec_probe_init(void)
===== drivers/mtd/chips/map_absent.c 1.1 vs edited =====
--- 1.1/drivers/mtd/chips/map_absent.c	Tue Feb  5 14:20:55 2002
+++ edited/drivers/mtd/chips/map_absent.c	Wed Feb 26 13:27:27 2003
@@ -36,10 +36,10 @@
 
 
 static struct mtd_chip_driver map_absent_chipdrv = {
-	probe: 		map_absent_probe,
-	destroy:	map_absent_destroy,
-	name: 		"map_absent",
-	module: 	THIS_MODULE
+	.probe 		= map_absent_probe,
+	.destroy	= map_absent_destroy,
+	.name 		= "map_absent",
+	.module 	= THIS_MODULE
 };
 
 static struct mtd_info *map_absent_probe(struct map_info *map)
===== drivers/mtd/chips/map_ram.c 1.4 vs edited =====
--- 1.4/drivers/mtd/chips/map_ram.c	Tue Feb  5 01:49:33 2002
+++ edited/drivers/mtd/chips/map_ram.c	Wed Feb 26 13:27:41 2003
@@ -23,9 +23,9 @@
 
 
 static struct mtd_chip_driver mapram_chipdrv = {
-	probe: map_ram_probe,
-	name: "map_ram",
-	module: THIS_MODULE
+	.probe	= map_ram_probe,
+	.name	= "map_ram",
+	.module	= THIS_MODULE
 };
 
 static struct mtd_info *map_ram_probe(struct map_info *map)
===== drivers/mtd/chips/map_rom.c 1.4 vs edited =====
--- 1.4/drivers/mtd/chips/map_rom.c	Tue Feb  5 01:49:33 2002
+++ edited/drivers/mtd/chips/map_rom.c	Wed Feb 26 13:27:53 2003
@@ -21,9 +21,9 @@
 struct mtd_info *map_rom_probe(struct map_info *map);
 
 static struct mtd_chip_driver maprom_chipdrv = {
-	probe: map_rom_probe,
-	name: "map_rom",
-	module: THIS_MODULE
+	.probe	= map_rom_probe,
+	.name	= "map_rom",
+	.module	= THIS_MODULE
 };
 
 struct mtd_info *map_rom_probe(struct map_info *map)
===== drivers/mtd/chips/sharp.c 1.3 vs edited =====
--- 1.3/drivers/mtd/chips/sharp.c	Wed Mar 27 07:07:16 2002
+++ edited/drivers/mtd/chips/sharp.c	Wed Feb 26 13:28:28 2003
@@ -98,10 +98,10 @@
 static void sharp_destroy(struct mtd_info *mtd);
 
 static struct mtd_chip_driver sharp_chipdrv = {
-	probe: sharp_probe,
-	destroy: sharp_destroy,
-	name: "sharp",
-	module: THIS_MODULE
+	.probe		= sharp_probe,
+	.destroy	= sharp_destroy,
+	.name		= "sharp",
+	.module		= THIS_MODULE
 };
 
 
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
