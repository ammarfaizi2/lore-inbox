Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268945AbTBZUxP>; Wed, 26 Feb 2003 15:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268944AbTBZUxN>; Wed, 26 Feb 2003 15:53:13 -0500
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:57617 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S268940AbTBZUvE>; Wed, 26 Feb 2003 15:51:04 -0500
Date: Wed, 26 Feb 2003 14:57:33 -0600
From: Art Haas <ahaas@airmail.net>
To: mtd@infradead.org, linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for drivers/mtd/maps
Message-ID: <20030226205733.GD8966@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here is a set of patches for converting drivers/mtd/maps to use C99
initializers. The patches are against the current BK.

Art Haas

===== drivers/mtd/maps/autcpu12-nvram.c 1.1 vs edited =====
--- 1.1/drivers/mtd/maps/autcpu12-nvram.c	Mon Oct 14 15:24:36 2002
+++ edited/drivers/mtd/maps/autcpu12-nvram.c	Wed Feb 26 12:18:43 2003
@@ -83,17 +83,17 @@
 static struct mtd_info *sram_mtd;
 
 struct map_info autcpu12_sram_map = {
-	name: "SRAM",
-	size: 32768,
-	buswidth: 8,
-	read8: autcpu12_read8,
-	read16: autcpu12_read16,
-	read32: autcpu12_read32,
-	copy_from: autcpu12_copy_from,
-	write8: autcpu12_write8,
-	write16: autcpu12_write16,
-	write32: autcpu12_write32,
-	copy_to: autcpu12_copy_to
+	.name		= "SRAM",
+	.size		= 32768,
+	.buswidth	= 8,
+	.read8		= autcpu12_read8,
+	.read16		= autcpu12_read16,
+	.read32		= autcpu12_read32,
+	.copy_from	= autcpu12_copy_from,
+	.write8		= autcpu12_write8,
+	.write16	= autcpu12_write16,
+	.write32	= autcpu12_write32,
+	.copy_to	= autcpu12_copy_to
 };
 
 static int __init init_autcpu12_sram (void)
===== drivers/mtd/maps/cdb89712.c 1.1 vs edited =====
--- 1.1/drivers/mtd/maps/cdb89712.c	Tue Feb  5 14:20:55 2002
+++ edited/drivers/mtd/maps/cdb89712.c	Wed Feb 26 12:21:33 2003
@@ -14,8 +14,6 @@
 #include <linux/mtd/map.h>
 #include <linux/mtd/partitions.h>
 
-
-
 __u8 cdb89712_read8(struct map_info *map, unsigned long ofs)
 {
 	return __raw_readb(map->map_priv_1 + ofs);
@@ -65,28 +63,27 @@
 	}
 }
 
-
 static struct mtd_info *flash_mtd;
 
 struct map_info cdb89712_flash_map = {
-	name: "flash",
-	size: FLASH_SIZE,
-	buswidth: FLASH_WIDTH,
-	read8: cdb89712_read8,
-	read16: cdb89712_read16,
-	read32: cdb89712_read32,
-	copy_from: cdb89712_copy_from,
-	write8: cdb89712_write8,
-	write16: cdb89712_write16,
-	write32: cdb89712_write32,
-	copy_to: cdb89712_copy_to
+	.name		= "flash",
+	.size		= FLASH_SIZE,
+	.buswidth	= FLASH_WIDTH,
+	.read8		= cdb89712_read8,
+	.read16		= cdb89712_read16,
+	.read32		= cdb89712_read32,
+	.copy_from	= cdb89712_copy_from,
+	.write8		= cdb89712_write8,
+	.write16	= cdb89712_write16,
+	.write32	= cdb89712_write32,
+	.copy_to	= cdb89712_copy_to
 };
 
 struct resource cdb89712_flash_resource = {
-	name:   "Flash",
-	start:  FLASH_START,
-	end:    FLASH_START + FLASH_SIZE - 1,
-	flags:  IORESOURCE_IO | IORESOURCE_BUSY,
+	.name	= "Flash",
+	.start	= FLASH_START,
+	.end	= FLASH_START + FLASH_SIZE - 1,
+	.flags	= IORESOURCE_IO | IORESOURCE_BUSY,
 };
 
 static int __init init_cdb89712_flash (void)
@@ -139,31 +136,27 @@
 	return err;
 }
 
-
-
-
-
 static struct mtd_info *sram_mtd;
 
 struct map_info cdb89712_sram_map = {
-	name: "SRAM",
-	size: SRAM_SIZE,
-	buswidth: SRAM_WIDTH,
-	read8: cdb89712_read8,
-	read16: cdb89712_read16,
-	read32: cdb89712_read32,
-	copy_from: cdb89712_copy_from,
-	write8: cdb89712_write8,
-	write16: cdb89712_write16,
-	write32: cdb89712_write32,
-	copy_to: cdb89712_copy_to
+	.name		= "SRAM",
+	.size		= SRAM_SIZE,
+	.buswidth	= SRAM_WIDTH,
+	.read8		= cdb89712_read8,
+	.read16		= cdb89712_read16,
+	.read32		= cdb89712_read32,
+	.copy_from	= cdb89712_copy_from,
+	.write8		= cdb89712_write8,
+	.write16	= cdb89712_write16,
+	.write32	= cdb89712_write32,
+	.copy_to	= cdb89712_copy_to
 };
 
 struct resource cdb89712_sram_resource = {
-	name:   "SRAM",
-	start:  SRAM_START,
-	end:    SRAM_START + SRAM_SIZE - 1,
-	flags:  IORESOURCE_IO | IORESOURCE_BUSY,
+	.name	= "SRAM",
+	.start	= SRAM_START,
+	.end	= SRAM_START + SRAM_SIZE - 1,
+	.flags	= IORESOURCE_IO | IORESOURCE_BUSY,
 };
 
 static int __init init_cdb89712_sram (void)
@@ -212,29 +205,23 @@
 	return err;
 }
 
-
-
-
-
-
-
 static struct mtd_info *bootrom_mtd;
 
 struct map_info cdb89712_bootrom_map = {
-	name: "BootROM",
-	size: BOOTROM_SIZE,
-	buswidth: BOOTROM_WIDTH,
-	read8: cdb89712_read8,
-	read16: cdb89712_read16,
-	read32: cdb89712_read32,
-	copy_from: cdb89712_copy_from,
+	.name		= "BootROM",
+	.size		= BOOTROM_SIZE,
+	.buswidth	= BOOTROM_WIDTH,
+	.read8		= cdb89712_read8,
+	.read16		= cdb89712_read16,
+	.read32		= cdb89712_read32,
+	.copy_from	= cdb89712_copy_from,
 };
 
 struct resource cdb89712_bootrom_resource = {
-	name:   "BootROM",
-	start:  BOOTROM_START,
-	end:    BOOTROM_START + BOOTROM_SIZE - 1,
-	flags:  IORESOURCE_IO | IORESOURCE_BUSY,
+	.name	= "BootROM",
+	.start	= BOOTROM_START,
+	.end	= BOOTROM_START + BOOTROM_SIZE - 1,
+	.flags	= IORESOURCE_IO | IORESOURCE_BUSY,
 };
 
 static int __init init_cdb89712_bootrom (void)
@@ -282,10 +269,6 @@
 out:
 	return err;
 }
-
-
-
-
 
 static int __init init_cdb89712_maps(void)
 {
===== drivers/mtd/maps/ceiva.c 1.2 vs edited =====
--- 1.2/drivers/mtd/maps/ceiva.c	Tue Feb 25 11:44:43 2003
+++ edited/drivers/mtd/maps/ceiva.c	Wed Feb 26 13:12:01 2003
@@ -76,15 +76,15 @@
 }
 
 static struct map_info clps_map __initdata = {
-	name:		"clps flash",
-	read8:		clps_read8,
-	read16:		clps_read16,
-	read32:		clps_read32,
-	copy_from:	clps_copy_from,
-	write8:		clps_write8,
-	write16:	clps_write16,
-	write32:	clps_write32,
-	copy_to:	clps_copy_to,
+	.name		= "clps flash",
+	.read8		= clps_read8,
+	.read16		= clps_read16,
+	.read32		= clps_read32,
+	.copy_from	= clps_copy_from,
+	.write8		= clps_write8,
+	.write16	= clps_write16,
+	.write32	= clps_write32,
+	.copy_to	= clps_copy_to,
 };
 
 #ifdef CONFIG_MTD_CEIVA_STATICMAP
@@ -115,23 +115,25 @@
 
 static struct mtd_partition ceiva_partitions[] = {
 	{
-		name: "Ceiva BOOT partition",
-		size:   BOOT_PARTITION_SIZE_KiB*1024,
-		offset: 0,
+		.name	= "Ceiva BOOT partition",
+		.size	= BOOT_PARTITION_SIZE_KiB*1024,
 
-	},{
-		name: "Ceiva parameters partition",
-		size:   PARAMS_PARTITION_SIZE_KiB*1024,
-		offset: (16 + 8) * 1024,
-	},{
-		name: "Ceiva kernel partition",
-		size: (KERNEL_PARTITION_SIZE_KiB)*1024,
-		offset: 0x20000,
+	},
+	{
+		.name	= "Ceiva parameters partition",
+		.size	= PARAMS_PARTITION_SIZE_KiB*1024,
+		.offset	= (16 + 8) * 1024,
+	},
+	{
+		.name	= "Ceiva kernel partition",
+		.size	= (KERNEL_PARTITION_SIZE_KiB)*1024,
+		.offset	= 0x20000,
 
-	},{
-		name: "Ceiva root filesystem partition",
-		offset: MTDPART_OFS_APPEND,
-		size: (ROOT_PARTITION_SIZE_KiB)*1024,
+	},
+	{
+		.name	= "Ceiva root filesystem partition",
+		.offset	= MTDPART_OFS_APPEND,
+		.size	= (ROOT_PARTITION_SIZE_KiB)*1024,
 	}
 };
 #endif
===== drivers/mtd/maps/cfi_flagadm.c 1.2 vs edited =====
--- 1.2/drivers/mtd/maps/cfi_flagadm.c	Tue Feb  5 01:49:33 2002
+++ edited/drivers/mtd/maps/cfi_flagadm.c	Wed Feb 26 12:25:11 2003
@@ -99,39 +99,39 @@
 }
 
 struct map_info flagadm_map = {
-		name: "FlagaDM flash device",
-		size: FLASH_SIZE,
-		buswidth: 2,
-		read8: flagadm_read8,
-		read16: flagadm_read16,
-		read32: flagadm_read32,
-		copy_from: flagadm_copy_from,
-		write8: flagadm_write8,
-		write16: flagadm_write16,
-		write32: flagadm_write32,
-		copy_to: flagadm_copy_to
+	.name		= "FlagaDM flash device",
+	.size		= FLASH_SIZE,
+	.buswidth	= 2,
+	.read8		= flagadm_read8,
+	.read16		= flagadm_read16,
+	.read32		= flagadm_read32,
+	.copy_from	= flagadm_copy_from,
+	.write8		= flagadm_write8,
+	.write16	= flagadm_write16,
+	.write32	= flagadm_write32,
+	.copy_to	= flagadm_copy_to
 };
 
 struct mtd_partition flagadm_parts[] = {
 	{
-		name	: "Bootloader",
-		offset	: FLASH_PARTITION0_ADDR,
-		size	: FLASH_PARTITION0_SIZE
+		.name	= "Bootloader",
+		.offset	= FLASH_PARTITION0_ADDR,
+		.size	= FLASH_PARTITION0_SIZE
 	},
 	{
-		name	: "Kernel image",
-		offset	: FLASH_PARTITION1_ADDR,
-		size	: FLASH_PARTITION1_SIZE
+		.name	= "Kernel image",
+		.offset	= FLASH_PARTITION1_ADDR,
+		.size	= FLASH_PARTITION1_SIZE
 	},
 	{
-		name	: "Initial ramdisk image",
-		offset	: FLASH_PARTITION2_ADDR,
-		size	: FLASH_PARTITION2_SIZE
+		.name	= "Initial ramdisk image",
+		.offset	= FLASH_PARTITION2_ADDR,
+		.size	= FLASH_PARTITION2_SIZE
 	},
 	{	
-		name	: "Persistant storage",
-		offset	: FLASH_PARTITION3_ADDR,
-		size	: FLASH_PARTITION3_SIZE
+		.name	= "Persistant storage",
+		.offset	= FLASH_PARTITION3_ADDR,
+		.size	= FLASH_PARTITION3_SIZE
 	}
 };
 
===== drivers/mtd/maps/cstm_mips_ixx.c 1.3 vs edited =====
--- 1.3/drivers/mtd/maps/cstm_mips_ixx.c	Tue Feb 25 11:44:45 2003
+++ edited/drivers/mtd/maps/cstm_mips_ixx.c	Wed Feb 26 13:14:42 2003
@@ -132,20 +132,15 @@
 }
 
 const struct map_info basic_cstm_mips_ixx_map = {
-	NULL,
-	0,
-	0,
-	cstm_mips_ixx_read8,
-	cstm_mips_ixx_read16,
-	cstm_mips_ixx_read32,
-	cstm_mips_ixx_copy_from,
-	cstm_mips_ixx_write8,
-	cstm_mips_ixx_write16,
-	cstm_mips_ixx_write32,
-	cstm_mips_ixx_copy_to,
-        cstm_mips_ixx_set_vpp,
-	0,
-	0
+	.read8		= cstm_mips_ixx_read8,
+	.read16		= cstm_mips_ixx_read16,
+	.read32		= cstm_mips_ixx_read32,
+	.copy_from	= cstm_mips_ixx_copy_from,
+	.write8		= cstm_mips_ixx_write8,
+	.write16	= cstm_mips_ixx_write16,
+	.write32	= cstm_mips_ixx_write32,
+	.copy_to	= cstm_mips_ixx_copy_to,
+	.set_vpp	= cstm_mips_ixx_set_vpp,
 };
 
 /* board and partition description */
@@ -175,9 +170,8 @@
 static struct mtd_partition cstm_mips_ixx_partitions[PHYSMAP_NUMBER][MAX_PHYSMAP_PARTITIONS] = {
 {   // 28F128J3A in 2x16 configuration
 	{
-		name: "main partition ",
-		size: 0x02000000, // 128 x 2 x 128k byte sectors
-		offset: 0,
+		.name	= "main partition ",
+		.size	= 0x02000000, // 128 x 2 x 128k byte sectors
 	},
 },
 };
@@ -197,9 +191,8 @@
 static struct mtd_partition cstm_mips_ixx_partitions[PHYSMAP_NUMBER][MAX_PHYSMAP_PARTITIONS] = {
 { 
 	{
-		name: "main partition",
-		size:  CONFIG_MTD_CSTM_MIPS_IXX_LEN,
-		offset: 0,
+		.name	= "main partition",
+		.size	= CONFIG_MTD_CSTM_MIPS_IXX_LEN,
 	},
 },
 };
===== drivers/mtd/maps/dbox2-flash.c 1.2 vs edited =====
--- 1.2/drivers/mtd/maps/dbox2-flash.c	Tue Feb  5 01:49:33 2002
+++ edited/drivers/mtd/maps/dbox2-flash.c	Wed Feb 26 13:13:59 2003
@@ -16,22 +16,28 @@
 /* partition_info gives details on the logical partitions that the split the
  * single flash device into. If the size if zero we use up to the end of the
  * device. */
-static struct mtd_partition partition_info[]= {{name: "BR bootloader",		// raw
-						      size: 128 * 1024, 
-						      offset: 0,                  
-						      mask_flags: MTD_WRITEABLE},
-                                                     {name: "PPC bootloader",		// flfs
-						      size: 128 * 1024, 
-						      offset: MTDPART_OFS_APPEND, 
-						      mask_flags: 0},
-                                                     {name: "Kernel",			// idxfs
-						      size: 768 * 1024, 
-						      offset: MTDPART_OFS_APPEND, 
-						      mask_flags: 0},
-                                                     {name: "System",			// jffs
-						      size: MTDPART_SIZ_FULL, 
-						      offset: MTDPART_OFS_APPEND, 
-						      mask_flags: 0}};
+static struct mtd_partition partition_info[]= {
+	{
+		.name		= "BR bootloader",	/* raw */
+		.size		= 128 * 1024, 
+		.mask_flags	= MTD_WRITEABLE
+	},
+	{
+		.name		= "PPC bootloader",	/* flfs */
+		.size		= 128 * 1024, 
+		.offset		= MTDPART_OFS_APPEND, 
+	},
+	{
+		.name		= "Kernel",		/* idxfs */
+		.size		= 768 * 1024, 
+		.offset		= MTDPART_OFS_APPEND, 
+	},
+	{
+		.name		= "System",		/* jffs */
+		.size		= MTDPART_SIZ_FULL, 
+		.offset		= MTDPART_OFS_APPEND, 
+	}
+};
 
 #define NUM_PARTITIONS (sizeof(partition_info) / sizeof(partition_info[0]))
 
@@ -84,17 +90,17 @@
 }
 
 struct map_info dbox2_flash_map = {
-	name: "D-Box 2 flash memory",
-	size: WINDOW_SIZE,
-	buswidth: 4,
-	read8: dbox2_flash_read8,
-	read16: dbox2_flash_read16,
-	read32: dbox2_flash_read32,
-	copy_from: dbox2_flash_copy_from,
-	write8: dbox2_flash_write8,
-	write16: dbox2_flash_write16,
-	write32: dbox2_flash_write32,
-	copy_to: dbox2_flash_copy_to
+	.name		= "D-Box 2 flash memory",
+	.size		= WINDOW_SIZE,
+	.buswidth	= 4,
+	.read8		= dbox2_flash_read8,
+	.read16		= dbox2_flash_read16,
+	.read32		= dbox2_flash_read32,
+	.copy_from	= dbox2_flash_copy_from,
+	.write8		= dbox2_flash_write8,
+	.write16	= dbox2_flash_write16,
+	.write32	= dbox2_flash_write32,
+	.copy_to	= dbox2_flash_copy_to
 };
 
 int __init init_dbox2_flash(void)
===== drivers/mtd/maps/dc21285.c 1.3 vs edited =====
--- 1.3/drivers/mtd/maps/dc21285.c	Mon Oct 14 15:24:34 2002
+++ edited/drivers/mtd/maps/dc21285.c	Wed Feb 26 12:36:27 2003
@@ -92,16 +92,16 @@
 }
 
 struct map_info dc21285_map = {
-	name: "DC21285 flash",
-	size: 16*1024*1024,
-	read8: dc21285_read8,
-	read16: dc21285_read16,
-	read32: dc21285_read32,
-	copy_from: dc21285_copy_from,
-	write8: dc21285_write8,
-	write16: dc21285_write16,
-	write32: dc21285_write32,
-	copy_to: dc21285_copy_to
+	.name		= "DC21285 flash",
+	.size		= 16*1024*1024,
+	.read8		= dc21285_read8,
+	.read16		= dc21285_read16,
+	.read32		= dc21285_read32,
+	.copy_from	= dc21285_copy_from,
+	.write8		= dc21285_write8,
+	.write16	= dc21285_write16,
+	.write32	= dc21285_write32,
+	.copy_to	= dc21285_copy_to
 };
 
 
===== drivers/mtd/maps/edb7312.c 1.1 vs edited =====
--- 1.1/drivers/mtd/maps/edb7312.c	Mon Oct 14 15:24:39 2002
+++ edited/drivers/mtd/maps/edb7312.c	Wed Feb 26 12:38:07 2003
@@ -79,17 +79,17 @@
 }
 
 struct map_info edb7312nor_map = {
-	name: "NOR flash on EDB7312",
-	size: WINDOW_SIZE,
-	buswidth: BUSWIDTH,
-	read8: edb7312nor_read8,
-	read16: edb7312nor_read16,
-	read32: edb7312nor_read32,
-	copy_from: edb7312nor_copy_from,
-	write8: edb7312nor_write8,
-	write16: edb7312nor_write16,
-	write32: edb7312nor_write32,
-	copy_to: edb7312nor_copy_to
+	.name		= "NOR flash on EDB7312",
+	.size		= WINDOW_SIZE,
+	.buswidth	= BUSWIDTH,
+	.read8		= edb7312nor_read8,
+	.read16		= edb7312nor_read16,
+	.read32		= edb7312nor_read32,
+	.copy_from	= edb7312nor_copy_from,
+	.write8		= edb7312nor_write8,
+	.write16	= edb7312nor_write16,
+	.write32	= edb7312nor_write32,
+	.copy_to	= edb7312nor_copy_to
 };
 
 #ifdef CONFIG_MTD_PARTITIONS
@@ -97,23 +97,22 @@
 /*
  * MTD partitioning stuff 
  */
-static struct mtd_partition static_partitions[3] =
-{
-    {
-	name: "ARMboot",
-	  size: 0x40000,
-	  offset: 0
-    },
-    {
-	name: "Kernel",
-	  size: 0x200000,
-	  offset: 0x40000
-    },
-    {
-	name: "RootFS",
-	  size: 0xDC0000,
-	  offset: 0x240000
-    },
+static struct mtd_partition static_partitions[3] = {
+	{
+		.name = "ARMboot",
+		.size = 0x40000,
+		.offset = 0
+	},
+	{
+		.name = "Kernel",
+		.size = 0x200000,
+		.offset = 0x40000
+	},
+	{
+		.name = "RootFS",
+		.size = 0xDC0000,
+		.offset = 0x240000
+	},
 };
 
 #define NB_OF(x) (sizeof (x) / sizeof (x[0]))
===== drivers/mtd/maps/elan-104nc.c 1.4 vs edited =====
--- 1.4/drivers/mtd/maps/elan-104nc.c	Thu Feb  6 09:33:47 2003
+++ edited/drivers/mtd/maps/elan-104nc.c	Wed Feb 26 13:14:46 2003
@@ -58,15 +58,20 @@
 /* partition_info gives details on the logical partitions that the split the 
  * single flash device into. If the size if zero we use up to the end of the
  * device. */
-static struct mtd_partition partition_info[]={
-    { name: "ELAN-104NC flash boot partition", 
-      offset: 0, 
-      size: 640*1024 },
-    { name: "ELAN-104NC flash partition 1", 
-      offset: 640*1024, 
-      size: 896*1024 },
-    { name: "ELAN-104NC flash partition 2", 
-      offset: (640+896)*1024 }
+static struct mtd_partition partition_info[] = {
+	{
+		.name	= "ELAN-104NC flash boot partition", 
+		.size	= 640*1024
+	},
+	{
+		.name	= "ELAN-104NC flash partition 1", 
+		.offset	= 640*1024, 
+		.size	= 896*1024
+	},
+	{
+		.name	= "ELAN-104NC flash partition 2", 
+		.offset = (640+896)*1024,
+	}
 };
 #define NUM_PARTITIONS (sizeof(partition_info)/sizeof(partition_info[0]))
 
@@ -195,19 +200,20 @@
 }
 
 static struct map_info elan_104nc_map = {
-	name: "ELAN-104NC flash",
-	size: 8*1024*1024, /* this must be set to a maximum possible amount
-			of flash so the cfi probe routines find all
-			the chips */
-	buswidth: 2,
-	read8: elan_104nc_read8,
-	read16: elan_104nc_read16,
-	read32: elan_104nc_read32,
-	copy_from: elan_104nc_copy_from,
-	write8: elan_104nc_write8,
-	write16: elan_104nc_write16,
-	write32: elan_104nc_write32,
-	copy_to: elan_104nc_copy_to
+	.name		= "ELAN-104NC flash",
+	.size		= 8*1024*1024, /* this must be set to a maximum
+					  possible amount of flash so the
+					  cfi probe routines find all
+					  the chips */
+	.buswidth	= 2,
+	.read8		= elan_104nc_read8,
+	.read16		= elan_104nc_read16,
+	.read32		= elan_104nc_read32,
+	.copy_from	= elan_104nc_copy_from,
+	.write8		= elan_104nc_write8,
+	.write16	= elan_104nc_write16,
+	.write32	= elan_104nc_write32,
+	.copy_to	= elan_104nc_copy_to
 };
 
 /* MTD device for all of the flash. */
===== drivers/mtd/maps/epxa10db-flash.c 1.1 vs edited =====
--- 1.1/drivers/mtd/maps/epxa10db-flash.c	Mon Oct 14 15:24:40 2002
+++ edited/drivers/mtd/maps/epxa10db-flash.c	Wed Feb 26 12:10:09 2003
@@ -92,17 +92,17 @@
 
 
 static struct map_info epxa_map = {
-	name:		"EPXA flash",
-	size:		FLASH_SIZE,
-	buswidth:	2,
-	read8:		epxa_read8,
-	read16:		epxa_read16,
-	read32:		epxa_read32,
-	copy_from:	epxa_copy_from,
-	write8:		epxa_write8,
-	write16:	epxa_write16,
-	write32:	epxa_write32,
-	copy_to:	epxa_copy_to
+	.name		= "EPXA flash",
+	.size		= FLASH_SIZE,
+	.buswidth	= 2,
+	.read8		= epxa_read8,
+	.read16		= epxa_read16,
+	.read32		= epxa_read32,
+	.copy_from	= epxa_copy_from,
+	.write8		= epxa_write8,
+	.write16	= epxa_write16,
+	.write32	= epxa_write32,
+	.copy_to	= epxa_copy_to
 };
 
 
===== drivers/mtd/maps/fortunet.c 1.1 vs edited =====
--- 1.1/drivers/mtd/maps/fortunet.c	Mon Oct 14 15:24:42 2002
+++ edited/drivers/mtd/maps/fortunet.c	Wed Feb 26 12:42:32 2003
@@ -78,16 +78,16 @@
 }
 
 struct map_info default_map = {
-	size: DEF_WINDOW_SIZE,
-	buswidth: 4,
-	read8: fortunet_read8,
-	read16: fortunet_read16,
-	read32: fortunet_read32,
-	copy_from: fortunet_copy_from,
-	write8: fortunet_write8,
-	write16: fortunet_write16,
-	write32: fortunet_write32,
-	copy_to: fortunet_copy_to
+	.size		= DEF_WINDOW_SIZE,
+	.buswidth	= 4,
+	.read8		= fortunet_read8,
+	.read16		= fortunet_read16,
+	.read32		= fortunet_read32,
+	.copy_from	= fortunet_copy_from,
+	.write8		= fortunet_write8,
+	.write16	= fortunet_write16,
+	.write32	= fortunet_write32,
+	.copy_to	= fortunet_copy_to
 };
 
 static char * __init get_string_option(char *dest,int dest_size,char *sor)
===== drivers/mtd/maps/impa7.c 1.1 vs edited =====
--- 1.1/drivers/mtd/maps/impa7.c	Mon Oct 14 15:24:44 2002
+++ edited/drivers/mtd/maps/impa7.c	Wed Feb 26 12:45:46 2003
@@ -82,30 +82,30 @@
 
 static struct map_info impa7_map[NUM_FLASHBANKS] = {
 	{
-	name: "impA7 NOR Flash Bank #0",
-	size: WINDOW_SIZE0,
-	buswidth: BUSWIDTH,
-	read8: impa7_read8,
-	read16: impa7_read16,
-	read32: impa7_read32,
-	copy_from: impa7_copy_from,
-	write8: impa7_write8,
-	write16: impa7_write16,
-	write32: impa7_write32,
-	copy_to: impa7_copy_to
+		.name		= "impA7 NOR Flash Bank #0",
+		.size		= WINDOW_SIZE0,
+		.buswidth	= BUSWIDTH,
+		.read8		= impa7_read8,
+		.read16		= impa7_read16,
+		.read32		= impa7_read32,
+		.copy_from	= impa7_copy_from,
+		.write8		= impa7_write8,
+		.write16	= impa7_write16,
+		.write32	= impa7_write32,
+		.copy_to	= impa7_copy_to
 	},
 	{
-	name: "impA7 NOR Flash Bank #1",
-	size: WINDOW_SIZE1,
-	buswidth: BUSWIDTH,
-	read8: impa7_read8,
-	read16: impa7_read16,
-	read32: impa7_read32,
-	copy_from: impa7_copy_from,
-	write8: impa7_write8,
-	write16: impa7_write16,
-	write32: impa7_write32,
-	copy_to: impa7_copy_to
+		.name		= "impA7 NOR Flash Bank #1",
+		.size		= WINDOW_SIZE1,
+		.buswidth	= BUSWIDTH,
+		.read8		= impa7_read8,
+		.read16		= impa7_read16,
+		.read32		= impa7_read32,
+		.copy_from	= impa7_copy_from,
+		.write8		= impa7_write8,
+		.write16	= impa7_write16,
+		.write32	= impa7_write32,
+		.copy_to = impa7_copy_to
 	},
 };
 
@@ -114,13 +114,12 @@
 /*
  * MTD partitioning stuff 
  */
-static struct mtd_partition static_partitions[] =
-{
-    {
-	name: "FileSystem",
-	  size: 0x800000,
-	  offset: 0x00000000
-    },
+static struct mtd_partition static_partitions[] = {
+	{
+		.name	= "FileSystem",
+		.size	= 0x800000,
+		.offset	= 0x00000000
+	},
 };
 
 #define NB_OF(x) (sizeof (x) / sizeof (x[0]))
@@ -143,8 +142,8 @@
 	const char *part_type = 0;
 	int i;
 	static struct { u_long addr; u_long size; } pt[NUM_FLASHBANKS] = {
-	  { WINDOW_ADDR0, WINDOW_SIZE0 },
-	  { WINDOW_ADDR1, WINDOW_SIZE1 },
+	  { .addr = WINDOW_ADDR0, .size = WINDOW_SIZE0 },
+	  { .addr = WINDOW_ADDR1, .size = WINDOW_SIZE1 },
         };
 	char mtdid[10];
 	int devicesfound = 0;
===== drivers/mtd/maps/integrator-flash.c 1.2 vs edited =====
--- 1.2/drivers/mtd/maps/integrator-flash.c	Sun Oct 13 13:17:39 2002
+++ edited/drivers/mtd/maps/integrator-flash.c	Wed Feb 26 12:10:05 2003
@@ -195,16 +195,16 @@
 
 static struct map_info armflash_map =
 {
-	name:		"AFS",
-	read8:		armflash_read8,
-	read16:		armflash_read16,
-	read32:		armflash_read32,
-	copy_from:	armflash_copy_from,
-	write8:		armflash_write8,
-	write16:	armflash_write16,
-	write32:	armflash_write32,
-	copy_to:	armflash_copy_to,
-	set_vpp:	armflash_set_vpp,
+	.name		= "AFS",
+	.read8		= armflash_read8,
+	.read16		= armflash_read16,
+	.read32		= armflash_read32,
+	.copy_from	= armflash_copy_from,
+	.write8		= armflash_write8,
+	.write16	= armflash_write16,
+	.write32	= armflash_write32,
+	.copy_to	= armflash_copy_to,
+	.set_vpp	= armflash_set_vpp,
 };
 
 static struct mtd_info *mtd;
===== drivers/mtd/maps/iq80310.c 1.3 vs edited =====
--- 1.3/drivers/mtd/maps/iq80310.c	Mon Oct 14 15:24:34 2002
+++ edited/drivers/mtd/maps/iq80310.c	Wed Feb 26 12:47:14 2003
@@ -67,38 +67,40 @@
 }
 
 static struct map_info iq80310_map = {
-	name: "IQ80310 flash",
-	size: WINDOW_SIZE,
-	buswidth: BUSWIDTH,
-	read8:		iq80310_read8,
-	read16:		iq80310_read16,
-	read32:		iq80310_read32,
-	copy_from:	iq80310_copy_from,
-	write8:		iq80310_write8,
-	write16:	iq80310_write16,
-	write32:	iq80310_write32,
-	copy_to:	iq80310_copy_to
+	.name		= "IQ80310 flash",
+	.size		= WINDOW_SIZE,
+	.buswidth	= BUSWIDTH,
+	.read8		= iq80310_read8,
+	.read16		= iq80310_read16,
+	.read32		= iq80310_read32,
+	.copy_from	= iq80310_copy_from,
+	.write8		= iq80310_write8,
+	.write16	= iq80310_write16,
+	.write32	= iq80310_write32,
+	.copy_to	= iq80310_copy_to
 };
 
 static struct mtd_partition iq80310_partitions[4] = {
 	{
-		name:		"Firmware",
-		size:		0x00080000,
-		offset:		0,
-		mask_flags:	MTD_WRITEABLE  /* force read-only */
-	},{
-		name:		"Kernel",
-		size:		0x000a0000,
-		offset:		0x00080000,
-	},{
-		name:		"Filesystem",
-		size:		0x00600000,
-		offset:		0x00120000
-	},{
-		name:		"RedBoot",
-		size:		0x000e0000,
-		offset:		0x00720000,
-		mask_flags:	MTD_WRITEABLE
+		.name		= "Firmware",
+		.size		= 0x00080000,
+		.mask_flags	= MTD_WRITEABLE  /* force read-only */
+	},
+	{
+		.name		= "Kernel",
+		.size		= 0x000a0000,
+		.offset		= 0x00080000,
+	},
+	{
+		.name		= "Filesystem",
+		.size		= 0x00600000,
+		.offset		= 0x00120000
+	},
+	{
+		.name		= "RedBoot",
+		.size		= 0x000e0000,
+		.offset		= 0x00720000,
+		.mask_flags	= MTD_WRITEABLE
 	}
 };
 
===== drivers/mtd/maps/l440gx.c 1.1 vs edited =====
--- 1.1/drivers/mtd/maps/l440gx.c	Tue Feb  5 14:20:55 2002
+++ edited/drivers/mtd/maps/l440gx.c	Wed Feb 26 12:47:52 2003
@@ -76,18 +76,18 @@
 }
 
 struct map_info l440gx_map = {
-	name: "L440GX BIOS",
-	size: WINDOW_SIZE,
-	buswidth: BUSWIDTH,
-	read8: l440gx_read8,
-	read16: l440gx_read16,
-	read32: l440gx_read32,
-	copy_from: l440gx_copy_from,
-	write8: l440gx_write8,
-	write16: l440gx_write16,
-	write32: l440gx_write32,
-	copy_to: l440gx_copy_to,
-	set_vpp: l440gx_set_vpp
+	.name		= "L440GX BIOS",
+	.size		= WINDOW_SIZE,
+	.buswidth	= BUSWIDTH,
+	.read8		= l440gx_read8,
+	.read16		= l440gx_read16,
+	.read32		= l440gx_read32,
+	.copy_from	= l440gx_copy_from,
+	.write8		= l440gx_write8,
+	.write16	= l440gx_write16,
+	.write32	= l440gx_write32,
+	.copy_to	= l440gx_copy_to,
+	.set_vpp	= l440gx_set_vpp
 };
 
 static int __init init_l440gx(void)
===== drivers/mtd/maps/netsc520.c 1.2 vs edited =====
--- 1.2/drivers/mtd/maps/netsc520.c	Tue Feb  5 01:49:33 2002
+++ edited/drivers/mtd/maps/netsc520.c	Wed Feb 26 12:50:13 2003
@@ -93,27 +93,26 @@
 /* partition_info gives details on the logical partitions that the split the 
  * single flash device into. If the size if zero we use up to the end of the
  * device. */
-static struct mtd_partition partition_info[]={
-    { 
-	    name: "NetSc520 boot kernel", 
-	    offset: 0, 
-	    size: 	0xc0000
-    },
-    { 
-	    name: "NetSc520 Low BIOS", 
-	    offset: 0xc0000, 
-	    size: 	0x40000
-    },
-    { 
-	    name: "NetSc520 file system", 
-	    offset: 0x100000, 
-	    size: 	0xe80000
-    },
-    { 
-	    name: "NetSc520 High BIOS", 
-	    offset: 0xf80000, 
-	    size: 0x80000
-    },
+static struct mtd_partition partition_info[] = {
+	{ 
+		.name	= "NetSc520 boot kernel", 
+		.size	= 0xc0000
+	},
+	{ 
+		.name	= "NetSc520 Low BIOS", 
+		.offset	= 0xc0000, 
+		.size	= 0x40000
+	},
+	{ 
+		.name	= "NetSc520 file system", 
+		.offset	= 0x100000, 
+		.size	= 0xe80000
+	},
+	{ 
+		.name	= "NetSc520 High BIOS", 
+		.offset	= 0xf80000, 
+		.size	= 0x80000
+	},
 };
 #define NUM_PARTITIONS (sizeof(partition_info)/sizeof(partition_info[0]))
 
@@ -127,18 +126,18 @@
 #define WINDOW_ADDR	0x00200000
 
 static struct map_info netsc520_map = {
-	name: "netsc520 Flash Bank",
-	size: WINDOW_SIZE,
-	buswidth: 4,
-	read8: netsc520_read8,
-	read16: netsc520_read16,
-	read32: netsc520_read32,
-	copy_from: netsc520_copy_from,
-	write8: netsc520_write8,
-	write16: netsc520_write16,
-	write32: netsc520_write32,
-	copy_to: netsc520_copy_to,
-	map_priv_2: WINDOW_ADDR
+	.name		= "netsc520 Flash Bank",
+	.size		= WINDOW_SIZE,
+	.buswidth	= 4,
+	.read8		= netsc520_read8,
+	.read16		= netsc520_read16,
+	.read32		= netsc520_read32,
+	.copy_from	= netsc520_copy_from,
+	.write8		= netsc520_write8,
+	.write16	= netsc520_write16,
+	.write32	= netsc520_write32,
+	.copy_to	= netsc520_copy_to,
+	.map_priv_2	= WINDOW_ADDR
 };
 
 #define NUM_FLASH_BANKS	(sizeof(netsc520_map)/sizeof(struct map_info))
===== drivers/mtd/maps/nora.c 1.3 vs edited =====
--- 1.3/drivers/mtd/maps/nora.c	Tue Feb  5 01:49:33 2002
+++ edited/drivers/mtd/maps/nora.c	Wed Feb 26 12:53:17 2003
@@ -58,17 +58,17 @@
 }
 
 struct map_info nora_map = {
-	name: "NORA",
-	size: WINDOW_SIZE,
-	buswidth: 2,
-	read8: nora_read8,
-	read16: nora_read16,
-	read32: nora_read32,
-	copy_from: nora_copy_from,
-	write8: nora_write8,
-	write16: nora_write16,
-	write32: nora_write32,
-	copy_to: nora_copy_to
+	.name		= "NORA",
+	.size		= WINDOW_SIZE,
+	.buswidth	= 2,
+	.read8		= nora_read8,
+	.read16		= nora_read16,
+	.read32		= nora_read32,
+	.copy_from	= nora_copy_from,
+	.write8		= nora_write8,
+	.write16	= nora_write16,
+	.write32	= nora_write32,
+	.copy_to	= nora_copy_to
 };
 
 
@@ -106,64 +106,63 @@
 
 static struct mtd_info nora_mtds[4] = {  /* boot, kernel, ramdisk, fs */
 	{
-		type: MTD_NORFLASH,
-		flags: MTD_CAP_NORFLASH,
-		size: 0x60000,
-		erasesize: 0x20000,
-		name: "NORA boot firmware",
-		module: THIS_MODULE,
-		erase: nora_mtd_erase,
-		read: nora_mtd_read,
-		write: nora_mtd_write,
-		suspend: nora_mtd_suspend,
-		resume: nora_mtd_resume,
-		sync: nora_mtd_sync,
-		priv: (void *)0
+		.type		= MTD_NORFLASH,
+		.flags		= MTD_CAP_NORFLASH,
+		.size		= 0x60000,
+		.erasesize	= 0x20000,
+		.name		= "NORA boot firmware",
+		.module		= THIS_MODULE,
+		.erase		= nora_mtd_erase,
+		.read		= nora_mtd_read,
+		.write		= nora_mtd_write,
+		.suspend	= nora_mtd_suspend,
+		.resume		= nora_mtd_resume,
+		.sync		= nora_mtd_sync,
 	},
 	{
-		type: MTD_NORFLASH,
-		flags: MTD_CAP_NORFLASH,
-		size: 0x0a0000,
-		erasesize: 0x20000,
-		name: "NORA kernel",
-		module: THIS_MODULE,
-		erase: nora_mtd_erase,
-		read: nora_mtd_read,
-		write: nora_mtd_write,
-		suspend: nora_mtd_suspend,
-		resume: nora_mtd_resume,
-		sync: nora_mtd_sync,
-		priv: (void *)0x60000
+		.type		= MTD_NORFLASH,
+		.flags		= MTD_CAP_NORFLASH,
+		.size		= 0x0a0000,
+		.erasesize	= 0x20000,
+		.name		= "NORA kernel",
+		.module		= THIS_MODULE,
+		.erase		= nora_mtd_erase,
+		.read		= nora_mtd_read,
+		.write		= nora_mtd_write,
+		.suspend	= nora_mtd_suspend,
+		.resume		= nora_mtd_resume,
+		.sync		= nora_mtd_sync,
+		.priv		= (void *)0x60000
 	},
 	{
-		type: MTD_NORFLASH,
-		flags: MTD_CAP_NORFLASH,
-		size: 0x900000,
-		erasesize: 0x20000,
-		name: "NORA root filesystem",
-		module: THIS_MODULE,
-		erase: nora_mtd_erase,
-		read: nora_mtd_read,
-		write: nora_mtd_write,
-		suspend: nora_mtd_suspend,
-		resume: nora_mtd_resume,
-		sync: nora_mtd_sync,
-		priv: (void *)0x100000
+		.type		= MTD_NORFLASH,
+		.flags		= MTD_CAP_NORFLASH,
+		.size		= 0x900000,
+		.erasesize	= 0x20000,
+		.name		= "NORA root filesystem",
+		.module		= THIS_MODULE,
+		.erase		= nora_mtd_erase,
+		.read		= nora_mtd_read,
+		.write		= nora_mtd_write,
+		.suspend	= nora_mtd_suspend,
+		.resume		= nora_mtd_resume,
+		.sync		= nora_mtd_sync,
+		.priv		= (void *)0x100000
 	},
 	{
-		type: MTD_NORFLASH,
-		flags: MTD_CAP_NORFLASH,
-		size: 0x1600000,
-		erasesize: 0x20000,
-		name: "NORA second filesystem",
-		module: THIS_MODULE,
-		erase: nora_mtd_erase,
-		read: nora_mtd_read,
-		write: nora_mtd_write,
-		suspend: nora_mtd_suspend,
-		resume: nora_mtd_resume,
-		sync: nora_mtd_sync,
-		priv: (void *)0xa00000
+		.type		= MTD_NORFLASH,
+		.flags		= MTD_CAP_NORFLASH,
+		.size		= 0x1600000,
+		.erasesize	= 0x20000,
+		.name		= "NORA second filesystem",
+		.module		= THIS_MODULE,
+		.erase		= nora_mtd_erase,
+		.read		= nora_mtd_read,
+		.write		= nora_mtd_write,
+		.suspend	= nora_mtd_suspend,
+		.resume		= nora_mtd_resume,
+		.sync		= nora_mtd_sync,
+		.priv		= (void *)0xa00000
 	}
 };
 
===== drivers/mtd/maps/ocelot.c 1.2 vs edited =====
--- 1.2/drivers/mtd/maps/ocelot.c	Tue Feb  5 01:49:33 2002
+++ edited/drivers/mtd/maps/ocelot.c	Wed Feb 26 12:54:00 2003
@@ -70,22 +70,22 @@
 static struct mtd_partition *parsed_parts;
 
 struct map_info ocelot_flash_map = {
-	name: "Ocelot boot flash",
-	size: FLASH_WINDOW_SIZE,
-	buswidth: FLASH_BUSWIDTH,
-	read8: ocelot_read8,
-	copy_from: ocelot_copy_from_cache,
-	write8: ocelot_write8,
+	.name		= "Ocelot boot flash",
+	.size		= FLASH_WINDOW_SIZE,
+	.buswidth	= FLASH_BUSWIDTH,
+	.read8		= ocelot_read8,
+	.copy_from	= ocelot_copy_from_cache,
+	.write8		= ocelot_write8,
 };
 
 struct map_info ocelot_nvram_map = {
-	name: "Ocelot NVRAM",
-	size: NVRAM_WINDOW_SIZE,
-	buswidth: NVRAM_BUSWIDTH,
-	read8: ocelot_read8,
-	copy_from: ocelot_copy_from,
-	write8: ocelot_write8,
-	copy_to: ocelot_copy_to
+	.name		= "Ocelot NVRAM",
+	.size		= NVRAM_WINDOW_SIZE,
+	.buswidth	= NVRAM_BUSWIDTH,
+	.read8		= ocelot_read8,
+	.copy_from	= ocelot_copy_from,
+	.write8		= ocelot_write8,
+	.copy_to	= ocelot_copy_to
 };
 
 static int __init init_ocelot_maps(void)
===== drivers/mtd/maps/octagon-5066.c 1.5 vs edited =====
--- 1.5/drivers/mtd/maps/octagon-5066.c	Tue Feb  5 01:49:33 2002
+++ edited/drivers/mtd/maps/octagon-5066.c	Wed Feb 26 12:55:28 2003
@@ -151,32 +151,32 @@
 
 static struct map_info oct5066_map[2] = {
 	{
-		name: "Octagon 5066 Socket",
-		size: 512 * 1024,
-		buswidth: 1,
-		read8: oct5066_read8,
-		read16: oct5066_read16,
-		read32: oct5066_read32,
-		copy_from: oct5066_copy_from,
-		write8: oct5066_write8,
-		write16: oct5066_write16,
-		write32: oct5066_write32,
-		copy_to: oct5066_copy_to,
-		map_priv_1: 1<<6
+		.name		= "Octagon 5066 Socket",
+		.size		= 512 * 1024,
+		.buswidth	= 1,
+		.read8		= oct5066_read8,
+		.read16		= oct5066_read16,
+		.read32		= oct5066_read32,
+		.copy_from	= oct5066_copy_from,
+		.write8		= oct5066_write8,
+		.write16	= oct5066_write16,
+		.write32	= oct5066_write32,
+		.copy_to	= oct5066_copy_to,
+		.map_priv_1	= 1<<6
 	},
 	{
-		name: "Octagon 5066 Internal Flash",
-		size: 2 * 1024 * 1024,
-		buswidth: 1,
-		read8: oct5066_read8,
-		read16: oct5066_read16,
-		read32: oct5066_read32,
-		copy_from: oct5066_copy_from,
-		write8: oct5066_write8,
-		write16: oct5066_write16,
-		write32: oct5066_write32,
-		copy_to: oct5066_copy_to,
-		map_priv_1: 2<<6
+		.name		= "Octagon 5066 Internal Flash",
+		.size		= 2 * 1024 * 1024,
+		.buswidth	= 1,
+		.read8		= oct5066_read8,
+		.read16		= oct5066_read16,
+		.read32		= oct5066_read32,
+		.copy_from	= oct5066_copy_from,
+		.write8		= oct5066_write8,
+		.write16	= oct5066_write16,
+		.write32	= oct5066_write32,
+		.copy_to	= oct5066_copy_to,
+		.map_priv_1	= 2<<6
 	}
 };
 
===== drivers/mtd/maps/pci.c 1.1 vs edited =====
--- 1.1/drivers/mtd/maps/pci.c	Mon Oct 14 15:24:45 2002
+++ edited/drivers/mtd/maps/pci.c	Wed Feb 26 13:15:32 2003
@@ -98,10 +98,10 @@
 }
 
 static struct mtd_pci_info intel_iq80310_info = {
-	init:		intel_iq80310_init,
-	exit:		intel_iq80310_exit,
-	translate:	intel_iq80310_translate,
-	map_name:	"cfi_probe",
+	.init		= intel_iq80310_init,
+	.exit		= intel_iq80310_exit,
+	.translate	= intel_iq80310_translate,
+	.map_name	= "cfi_probe",
 };
 
 /*
@@ -181,10 +181,10 @@
 }
 
 static struct mtd_pci_info intel_dc21285_info = {
-	init:		intel_dc21285_init,
-	exit:		intel_dc21285_exit,
-	translate:	intel_dc21285_translate,
-	map_name:	"jedec_probe",
+	.init		= intel_dc21285_init,
+	.exit		= intel_dc21285_exit,
+	.translate	= intel_dc21285_translate,
+	.map_name	= "jedec_probe",
 };
 
 /*
@@ -193,24 +193,22 @@
 
 static struct pci_device_id mtd_pci_ids[] __devinitdata = {
 	{
-		vendor:		PCI_VENDOR_ID_INTEL,
-		device:		0x530d,
-		subvendor:	PCI_ANY_ID,
-		subdevice:	PCI_ANY_ID,
-		class:		PCI_CLASS_MEMORY_OTHER << 8,
-		class_mask:	0xffff00,
-		driver_data:	(unsigned long)&intel_iq80310_info,
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= 0x530d,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.class		= PCI_CLASS_MEMORY_OTHER << 8,
+		.class_mask	= 0xffff00,
+		.driver_data	= (unsigned long)&intel_iq80310_info,
 	},
 	{
-		vendor:		PCI_VENDOR_ID_DEC,
-		device:		PCI_DEVICE_ID_DEC_21285,
-		subvendor:	0,	/* DC21285 defaults to 0 on reset */
-		subdevice:	0,	/* DC21285 defaults to 0 on reset */
-		class:		0,
-		class_mask:	0,
-		driver_data:	(unsigned long)&intel_dc21285_info,
+		.vendor		= PCI_VENDOR_ID_DEC,
+		.device		= PCI_DEVICE_ID_DEC_21285,
+		.subvendor	= 0,	/* DC21285 defaults to 0 on reset */
+		.subdevice	= 0,	/* DC21285 defaults to 0 on reset */
+		.driver_data	= (unsigned long)&intel_dc21285_info,
 	},
-	{ 0, }
+	{ .vendor = 0, }
 };
 
 /*
@@ -275,14 +273,14 @@
 }
 
 static struct map_info mtd_pci_map = {
-	read8:		mtd_pci_read8,
-	read16:		mtd_pci_read16,
-	read32:		mtd_pci_read32,
-	copy_from:	mtd_pci_copyfrom,
-	write8:		mtd_pci_write8,
-	write16:	mtd_pci_write16,
-	write32:	mtd_pci_write32,
-	copy_to:	mtd_pci_copyto,
+	.read8		= mtd_pci_read8,
+	.read16		= mtd_pci_read16,
+	.read32		= mtd_pci_read32,
+	.copy_from	= mtd_pci_copyfrom,
+	.write8		= mtd_pci_write8,
+	.write16	= mtd_pci_write16,
+	.write32	= mtd_pci_write32,
+	.copy_to	= mtd_pci_copyto,
 };
 
 static int __devinit
@@ -359,10 +357,10 @@
 }
 
 static struct pci_driver mtd_pci_driver = {
-	name:		"MTD PCI",
-	probe:		mtd_pci_probe,
-	remove:		mtd_pci_remove,
-	id_table:	mtd_pci_ids,
+	.name		= "MTD PCI",
+	.probe		= mtd_pci_probe,
+	.remove		= mtd_pci_remove,
+	.id_table	= mtd_pci_ids,
 };
 
 static int __init mtd_pci_maps_init(void)
===== drivers/mtd/maps/physmap.c 1.3 vs edited =====
--- 1.3/drivers/mtd/maps/physmap.c	Tue Feb  5 01:49:33 2002
+++ edited/drivers/mtd/maps/physmap.c	Wed Feb 26 12:57:14 2003
@@ -63,17 +63,17 @@
 }
 
 struct map_info physmap_map = {
-	name: "Physically mapped flash",
-	size: WINDOW_SIZE,
-	buswidth: BUSWIDTH,
-	read8: physmap_read8,
-	read16: physmap_read16,
-	read32: physmap_read32,
-	copy_from: physmap_copy_from,
-	write8: physmap_write8,
-	write16: physmap_write16,
-	write32: physmap_write32,
-	copy_to: physmap_copy_to
+	.name		= "Physically mapped flash",
+	.size		= WINDOW_SIZE,
+	.buswidth	= BUSWIDTH,
+	.read8		= physmap_read8,
+	.read16		= physmap_read16,
+	.read32		= physmap_read32,
+	.copy_from	= physmap_copy_from,
+	.write8		= physmap_write8,
+	.write16	= physmap_write16,
+	.write32	= physmap_write32,
+	.copy_to	= physmap_copy_to
 };
 
 int __init init_physmap(void)
===== drivers/mtd/maps/pnc2000.c 1.3 vs edited =====
--- 1.3/drivers/mtd/maps/pnc2000.c	Tue Feb  5 01:49:33 2002
+++ edited/drivers/mtd/maps/pnc2000.c	Wed Feb 26 12:58:13 2003
@@ -65,17 +65,17 @@
 }
 
 struct map_info pnc_map = {
-	name: "PNC-2000",
-	size: WINDOW_SIZE,
-	buswidth: 4,
-	read8: pnc_read8,
-	read16: pnc_read16,
-	read32: pnc_read32,
-	copy_from: pnc_copy_from,
-	write8: pnc_write8,
-	write16: pnc_write16,
-	write32: pnc_write32,
-	copy_to: pnc_copy_to
+	.name		= "PNC-2000",
+	.size		= WINDOW_SIZE,
+	.buswidth	= 4,
+	.read8		= pnc_read8,
+	.read16		= pnc_read16,
+	.read32		= pnc_read32,
+	.copy_from	= pnc_copy_from,
+	.write8		= pnc_write8,
+	.write16	= pnc_write16,
+	.write32	= pnc_write32,
+	.copy_to	= pnc_copy_to
 };
 
 
@@ -84,19 +84,18 @@
  */
 static struct mtd_partition pnc_partitions[3] = {
 	{
-		name: "PNC-2000 boot firmware",
-		size: 0x20000,
-		offset: 0
+		.name	= "PNC-2000 boot firmware",
+		.size	= 0x20000,
 	},
 	{
-		name: "PNC-2000 kernel",
-		size: 0x1a0000,
-		offset: 0x20000
+		.name	= "PNC-2000 kernel",
+		.size	= 0x1a0000,
+		.offset	= 0x20000
 	},
 	{
-		name: "PNC-2000 filesystem",
-		size: 0x240000,
-		offset: 0x1c0000
+		.name	= "PNC-2000 filesystem",
+		.size	= 0x240000,
+		.offset	= 0x1c0000
 	}
 };
 
===== drivers/mtd/maps/rpxlite.c 1.4 vs edited =====
--- 1.4/drivers/mtd/maps/rpxlite.c	Tue Feb  5 01:49:33 2002
+++ edited/drivers/mtd/maps/rpxlite.c	Wed Feb 26 12:58:44 2003
@@ -61,17 +61,17 @@
 }
 
 struct map_info rpxlite_map = {
-	name: "RPX",
-	size: WINDOW_SIZE,
-	buswidth: 4,
-	read8: rpxlite_read8,
-	read16: rpxlite_read16,
-	read32: rpxlite_read32,
-	copy_from: rpxlite_copy_from,
-	write8: rpxlite_write8,
-	write16: rpxlite_write16,
-	write32: rpxlite_write32,
-	copy_to: rpxlite_copy_to
+	.name		= "RPX",
+	.size		= WINDOW_SIZE,
+	.buswidth	= 4,
+	.read8		= rpxlite_read8,
+	.read16		= rpxlite_read16,
+	.read32		= rpxlite_read32,
+	.copy_from	= rpxlite_copy_from,
+	.write8		= rpxlite_write8,
+	.write16	= rpxlite_write16,
+	.write32	= rpxlite_write32,
+	.copy_to	= rpxlite_copy_to
 };
 
 int __init init_rpxlite(void)
===== drivers/mtd/maps/sbc_gxx.c 1.3 vs edited =====
--- 1.3/drivers/mtd/maps/sbc_gxx.c	Wed Feb 20 07:53:30 2002
+++ edited/drivers/mtd/maps/sbc_gxx.c	Wed Feb 26 13:01:56 2003
@@ -90,15 +90,20 @@
 /* partition_info gives details on the logical partitions that the split the 
  * single flash device into. If the size if zero we use up to the end of the
  * device. */
-static struct mtd_partition partition_info[]={
-    { name: "SBC-GXx flash boot partition", 
-      offset: 0, 
-      size:   BOOT_PARTITION_SIZE_KiB*1024 },
-    { name: "SBC-GXx flash data partition", 
-      offset: BOOT_PARTITION_SIZE_KiB*1024, 
-      size: (DATA_PARTITION_SIZE_KiB)*1024 },
-    { name: "SBC-GXx flash application partition", 
-      offset: (BOOT_PARTITION_SIZE_KiB+DATA_PARTITION_SIZE_KiB)*1024 }
+static struct mtd_partition partition_info[] = {
+	{
+		.name	= "SBC-GXx flash boot partition", 
+		.size	= BOOT_PARTITION_SIZE_KiB*1024
+	},
+	{
+		.name	= "SBC-GXx flash data partition", 
+		.offset	= BOOT_PARTITION_SIZE_KiB*1024, 
+		.size	= (DATA_PARTITION_SIZE_KiB)*1024
+	},
+	{
+		.name	= "SBC-GXx flash application partition", 
+		.offset	= (BOOT_PARTITION_SIZE_KiB+DATA_PARTITION_SIZE_KiB)*1024
+	}
 };
 
 #define NUM_PARTITIONS 3
@@ -203,19 +208,20 @@
 }
 
 static struct map_info sbc_gxx_map = {
-	name: "SBC-GXx flash",
-	size: MAX_SIZE_KiB*1024, /* this must be set to a maximum possible amount
-			 of flash so the cfi probe routines find all
-			 the chips */
-	buswidth: 1,
-	read8: sbc_gxx_read8,
-	read16: sbc_gxx_read16,
-	read32: sbc_gxx_read32,
-	copy_from: sbc_gxx_copy_from,
-	write8: sbc_gxx_write8,
-	write16: sbc_gxx_write16,
-	write32: sbc_gxx_write32,
-	copy_to: sbc_gxx_copy_to
+	.name		= "SBC-GXx flash",
+	.size		= MAX_SIZE_KiB*1024, /* this must be set to a maximum
+						possible amount of flash so
+						the cfi probe routines find
+						all the chips */
+	.buswidth	= 1,
+	.read8		= sbc_gxx_read8,
+	.read16		= sbc_gxx_read16,
+	.read32		= sbc_gxx_read32,
+	.copy_from	= sbc_gxx_copy_from,
+	.write8		= sbc_gxx_write8,
+	.write16	= sbc_gxx_write16,
+	.write32	= sbc_gxx_write32,
+	.copy_to	= sbc_gxx_copy_to
 };
 
 /* MTD device for all of the flash. */
===== drivers/mtd/maps/sc520cdp.c 1.2 vs edited =====
--- 1.2/drivers/mtd/maps/sc520cdp.c	Tue Feb  5 01:49:33 2002
+++ edited/drivers/mtd/maps/sc520cdp.c	Wed Feb 26 13:03:40 2003
@@ -125,46 +125,46 @@
 
 static struct map_info sc520cdp_map[] = {
 	{
-		name: "SC520CDP Flash Bank #0",
-		size: WINDOW_SIZE_0,
-		buswidth: 4,
-		read8: sc520cdp_read8,
-		read16: sc520cdp_read16,
-		read32: sc520cdp_read32,
-		copy_from: sc520cdp_copy_from,
-		write8: sc520cdp_write8,
-		write16: sc520cdp_write16,
-		write32: sc520cdp_write32,
-		copy_to: sc520cdp_copy_to,
-		map_priv_2: WINDOW_ADDR_0
+		.name		= "SC520CDP Flash Bank #0",
+		.size		= WINDOW_SIZE_0,
+		.buswidth	= 4,
+		.read8		= sc520cdp_read8,
+		.read16		= sc520cdp_read16,
+		.read32		= sc520cdp_read32,
+		.copy_from	= sc520cdp_copy_from,
+		.write8		= sc520cdp_write8,
+		.write16	= sc520cdp_write16,
+		.write32	= sc520cdp_write32,
+		.copy_to	= sc520cdp_copy_to,
+		.map_priv_2	= WINDOW_ADDR_0
 	},
 	{
-		name: "SC520CDP Flash Bank #1",
-		size: WINDOW_SIZE_1,
-		buswidth: 4,
-		read8: sc520cdp_read8,
-		read16: sc520cdp_read16,
-		read32: sc520cdp_read32,
-		copy_from: sc520cdp_copy_from,
-		write8: sc520cdp_write8,
-		write16: sc520cdp_write16,
-		write32: sc520cdp_write32,
-		copy_to: sc520cdp_copy_to,
-		map_priv_2: WINDOW_ADDR_1
+		.name		= "SC520CDP Flash Bank #1",
+		.size		= WINDOW_SIZE_1,
+		.buswidth	= 4,
+		.read8		= sc520cdp_read8,
+		.read16		= sc520cdp_read16,
+		.read32		= sc520cdp_read32,
+		.copy_from	= sc520cdp_copy_from,
+		.write8		= sc520cdp_write8,
+		.write16	= sc520cdp_write16,
+		.write32	= sc520cdp_write32,
+		.copy_to	= sc520cdp_copy_to,
+		.map_priv_2	= WINDOW_ADDR_1
 	},
 	{
-		name: "SC520CDP DIL Flash",
-		size: WINDOW_SIZE_2,
-		buswidth: 1,
-		read8: sc520cdp_read8,
-		read16: sc520cdp_read16,
-		read32: sc520cdp_read32,
-		copy_from: sc520cdp_copy_from,
-		write8: sc520cdp_write8,
-		write16: sc520cdp_write16,
-		write32: sc520cdp_write32,
-		copy_to: sc520cdp_copy_to,
-		map_priv_2: WINDOW_ADDR_2
+		.name		= "SC520CDP DIL Flash",
+		.size		= WINDOW_SIZE_2,
+		.buswidth	= 1,
+		.read8		= sc520cdp_read8,
+		.read16		= sc520cdp_read16,
+		.read32		= sc520cdp_read32,
+		.copy_from	= sc520cdp_copy_from,
+		.write8		= sc520cdp_write8,
+		.write16	= sc520cdp_write16,
+		.write32	= sc520cdp_write32,
+		.copy_to	= sc520cdp_copy_to,
+		.map_priv_2	= WINDOW_ADDR_2
 	},
 };
 
===== drivers/mtd/maps/solutionengine.c 1.1 vs edited =====
--- 1.1/drivers/mtd/maps/solutionengine.c	Tue Feb  5 14:20:55 2002
+++ edited/drivers/mtd/maps/solutionengine.c	Wed Feb 26 13:04:15 2003
@@ -42,19 +42,19 @@
 static struct mtd_partition *parsed_parts;
 
 struct map_info soleng_eprom_map = {
-	name: "Solution Engine EPROM",
-	size: 0x400000,
-	buswidth: 4,
-	copy_from: soleng_copy_from,
+	.name		= "Solution Engine EPROM",
+	.size		= 0x400000,
+	.buswidth	= 4,
+	.copy_from	= soleng_copy_from,
 };
 
 struct map_info soleng_flash_map = {
-	name: "Solution Engine FLASH",
-	size: 0x400000,
-	buswidth: 4,
-	read32: soleng_read32,
-	copy_from: soleng_copy_from,
-	write32: soleng_write32,
+	.name		= "Solution Engine FLASH",
+	.size		= 0x400000,
+	.buswidth	= 4,
+	.read32		= soleng_read32,
+	.copy_from	= soleng_copy_from,
+	.write32	= soleng_write32,
 };
 
 static int __init init_soleng_maps(void)
===== drivers/mtd/maps/sun_uflash.c 1.2 vs edited =====
--- 1.2/drivers/mtd/maps/sun_uflash.c	Tue Feb  5 01:49:33 2002
+++ edited/drivers/mtd/maps/sun_uflash.c	Wed Feb 26 13:04:41 2003
@@ -91,17 +91,17 @@
 }
 
 struct map_info uflash_map_templ = {
-		name:		"SUNW,???-????",
-		size:		UFLASH_WINDOW_SIZE,
-		buswidth:	UFLASH_BUSWIDTH,
-		read8:		uflash_read8,
-		read16:		uflash_read16,
-		read32:		uflash_read32,
-		copy_from:	uflash_copy_from,
-		write8:		uflash_write8,
-		write16:	uflash_write16,
-		write32:	uflash_write32,
-		copy_to:	uflash_copy_to
+	.name		= "SUNW,???-????",
+	.size		= UFLASH_WINDOW_SIZE,
+	.buswidth	= UFLASH_BUSWIDTH,
+	.read8		= uflash_read8,
+	.read16		= uflash_read16,
+	.read32		= uflash_read32,
+	.copy_from	= uflash_copy_from,
+	.write8		= uflash_write8,
+	.write16	= uflash_write16,
+	.write32	= uflash_write32,
+	.copy_to	= uflash_copy_to
 };
 
 int uflash_devinit(struct linux_ebus_device* edev)
===== drivers/mtd/maps/tqm8xxl.c 1.1 vs edited =====
--- 1.1/drivers/mtd/maps/tqm8xxl.c	Tue Feb  5 14:20:55 2002
+++ edited/drivers/mtd/maps/tqm8xxl.c	Wed Feb 26 13:08:39 2003
@@ -92,17 +92,16 @@
 }
 
 struct map_info tqm8xxl_map = {
-	name: "TQM8xxL",
-	//size: WINDOW_SIZE,
-	buswidth: 4,
-	read8: tqm8xxl_read8,
-	read16: tqm8xxl_read16,
-	read32: tqm8xxl_read32,
-	copy_from: tqm8xxl_copy_from,
-	write8: tqm8xxl_write8,
-	write16: tqm8xxl_write16,
-	write32: tqm8xxl_write32,
-	copy_to: tqm8xxl_copy_to
+	.name		= "TQM8xxL",
+	.buswidth	= 4,
+	.read8		= tqm8xxl_read8,
+	.read16		= tqm8xxl_read16,
+	.read32		= tqm8xxl_read32,
+	.copy_from	= tqm8xxl_copy_from,
+	.write8		= tqm8xxl_write8,
+	.write16	= tqm8xxl_write16,
+	.write32	= tqm8xxl_write32,
+	.copy_to	= tqm8xxl_copy_to
 };
 
 /*
@@ -125,40 +124,39 @@
  */
 static struct mtd_partition tqm8xxl_partitions[] = {
 	{
-	  name: "ppcboot",
-	  offset: 0x00000000,
-	  size: 0x00020000,           /* 128KB           */
-	  mask_flags: MTD_WRITEABLE,  /* force read-only */
+		.name		= "ppcboot",
+		.offset		= 0x00000000,
+		.size 		= 0x00020000,	/* 128KB */
+		.mask_flags	= MTD_WRITEABLE, /* force read-only */
 	},
 	{
-	  name: "kernel",             /* default kernel image */
-	  offset: 0x00020000,
-	  size: 0x000e0000,
-	  mask_flags: MTD_WRITEABLE,  /* force read-only */
+		.name		= "kernel",	/* default kernel image */
+		.offset		= 0x00020000,
+		.size		= 0x000e0000,
+		.mask_flags	= MTD_WRITEABLE, /* force read-only */
 	},
 	{
-	  name: "user",
-	  offset: 0x00100000,
-	  size: 0x00100000,
+		.name		= "user",
+		.offset		= 0x00100000,
+		.size		= 0x00100000,
 	},
 	{
-	  name: "initrd",
-	  offset: 0x00200000,
-	  size: 0x00200000,
+		.name		= "initrd",
+		.offset		= 0x00200000,
+		.size		= 0x00200000,
 	}
 };
 /* partition definition for second flahs bank */
 static struct mtd_partition tqm8xxl_fs_partitions[] = {
 	{
-	  name: "cramfs",
-	  offset: 0x00000000,
-	  size: 0x00200000,
+		.name	= "cramfs",
+		.offset	= 0x00000000,
+		.size	= 0x00200000,
 	},
 	{
-	  name: "jffs",
-	  offset: 0x00200000,
-	  size: 0x00200000,
-	  //size: MTDPART_SIZ_FULL,
+		.name	= "jffs",
+		.offset	= 0x00200000,
+		.size	= 0x00200000,
 	}
 };
 #endif
===== drivers/mtd/maps/uclinux.c 1.1 vs edited =====
--- 1.1/drivers/mtd/maps/uclinux.c	Thu Oct 31 09:05:38 2002
+++ edited/drivers/mtd/maps/uclinux.c	Wed Feb 26 13:08:58 2003
@@ -66,15 +66,15 @@
 /****************************************************************************/
 
 struct map_info uclinux_ram_map = {
-	name:		"RAM",
-	read8:		uclinux_read8,
-	read16:		uclinux_read16,
-	read32:		uclinux_read32,
-	copy_from:	uclinux_copy_from,
-	write8:		uclinux_write8,
-	write16:	uclinux_write16,
-	write32:	uclinux_write32,
-	copy_to:	uclinux_copy_to,
+	.name		= "RAM",
+	.read8		= uclinux_read8,
+	.read16		= uclinux_read16,
+	.read32		= uclinux_read32,
+	.copy_from	= uclinux_copy_from,
+	.write8		= uclinux_write8,
+	.write16	= uclinux_write16,
+	.write32	= uclinux_write32,
+	.copy_to	= uclinux_copy_to,
 };
 
 struct mtd_info *uclinux_ram_mtdinfo;
@@ -82,7 +82,7 @@
 /****************************************************************************/
 
 struct mtd_partition uclinux_romfs[] = {
-	{ name: "ROMfs", offset: 0 }
+	{ .name = "ROMfs", .offset = 0 }
 };
 
 #define	NUM_PARTITIONS	(sizeof(uclinux_romfs) / sizeof(uclinux_romfs[0]))
===== drivers/mtd/maps/vmax301.c 1.5 vs edited =====
--- 1.5/drivers/mtd/maps/vmax301.c	Tue Feb  5 01:49:33 2002
+++ edited/drivers/mtd/maps/vmax301.c	Wed Feb 26 13:16:11 2003
@@ -142,34 +142,33 @@
 
 static struct map_info vmax_map[2] = {
 	{
-		name: "VMAX301 Internal Flash",
-		size: 3*2*1024*1024,
-		buswidth: 1,
-		read8: vmax301_read8,
-		read16: vmax301_read16,
-		read32: vmax301_read32,
-		copy_from: vmax301_copy_from,
-		write8: vmax301_write8,
-		write16: vmax301_write16,
-		write32: vmax301_write32,
-		copy_to: vmax301_copy_to,
-		map_priv_1: WINDOW_START + WINDOW_LENGTH,
-		map_priv_2: 0xFFFFFFFF
+		.name		= "VMAX301 Internal Flash",
+		.size		= 3*2*1024*1024,
+		.buswidth	= 1,
+		.read8		= vmax301_read8,
+		.read16		= vmax301_read16,
+		.read32		= vmax301_read32,
+		.copy_from	= vmax301_copy_from,
+		.write8		= vmax301_write8,
+		.write16	= vmax301_write16,
+		.write32	= vmax301_write32,
+		.copy_to	= vmax301_copy_to,
+		.map_priv_1	= WINDOW_START + WINDOW_LENGTH,
+		.map_priv_2	= 0xFFFFFFFF
 	},
 	{
-		name: "VMAX301 Socket",
-		size: 0,
-		buswidth: 1,
-		read8: vmax301_read8,
-		read16: vmax301_read16,
-		read32: vmax301_read32,
-		copy_from: vmax301_copy_from,
-		write8: vmax301_write8,
-		write16: vmax301_write16,
-		write32: vmax301_write32,
-		copy_to: vmax301_copy_to,
-		map_priv_1: WINDOW_START + (3*WINDOW_LENGTH),
-		map_priv_2: 0xFFFFFFFF
+		.name		= "VMAX301 Socket",
+		.buswidth	= 1,
+		.read8		= vmax301_read8,
+		.read16		= vmax301_read16,
+		.read32		= vmax301_read32,
+		.copy_from	= vmax301_copy_from,
+		.write8		= vmax301_write8,
+		.write16	= vmax301_write16,
+		.write32	= vmax301_write32,
+		.copy_to	= vmax301_copy_to,
+		.map_priv_1	= WINDOW_START + (3*WINDOW_LENGTH),
+		.map_priv_2	= 0xFFFFFFFF
 	}
 };
 
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
