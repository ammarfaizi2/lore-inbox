Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbTHTIIU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 04:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTHTIHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 04:07:21 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:50381 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S261764AbTHTIDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 04:03:24 -0400
Date: Wed, 20 Aug 2003 18:04:26 +1000
Message-Id: <200308200804.h7K84Q4X011772@theirongiant.lochness.weebeastie.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 12/16] C99: 2.6.0-t3-bk7/drivers
Cc: Linus Torvalds <torvalds@osdl.org>
From: CaT <cat@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -aur linux.backup/drivers/char/lcd.c linux/drivers/char/lcd.c
--- linux.backup/drivers/char/lcd.c	Mon Jul 21 23:34:54 2003
+++ linux/drivers/char/lcd.c	Wed Aug 20 16:40:22 2003
@@ -551,9 +551,9 @@
  */
 
 static struct file_operations lcd_fops = {
-	read:		lcd_read,
-	ioctl:		lcd_ioctl,
-	open:		lcd_open,
+	.read		= lcd_read,
+	.ioctl		= lcd_ioctl,
+	.open		= lcd_open,
 };
 
 static struct miscdevice lcd_dev=
diff -aur linux.backup/drivers/i2c/i2c-keywest.c linux/drivers/i2c/i2c-keywest.c
--- linux.backup/drivers/i2c/i2c-keywest.c	Sat Aug 16 15:02:44 2003
+++ linux/drivers/i2c/i2c-keywest.c	Wed Aug 20 16:40:22 2003
@@ -409,11 +409,11 @@
 
 /* For now, we only handle combined mode (smbus) */
 static struct i2c_algorithm keywest_algorithm = {
-	name:		"Keywest i2c",
-	id:		I2C_ALGO_SMBUS,
-	smbus_xfer:	keywest_smbus_xfer,
-	master_xfer:	keywest_xfer,
-	functionality:	keywest_func,
+	.name		= "Keywest i2c",
+	.id		= I2C_ALGO_SMBUS,
+	.smbus_xfer	= keywest_smbus_xfer,
+	.master_xfer	= keywest_xfer,
+	.functionality	= keywest_func,
 };
 
 
diff -aur linux.backup/drivers/macintosh/macio_asic.c linux/drivers/macintosh/macio_asic.c
--- linux.backup/drivers/macintosh/macio_asic.c	Tue Aug 19 20:56:55 2003
+++ linux/drivers/macintosh/macio_asic.c	Wed Aug 20 16:40:22 2003
@@ -37,8 +37,8 @@
 }
 
 struct bus_type macio_bus_type = {
-       name:	"macio",
-       match:	macio_bus_match,
+       .name	= "macio",
+       .match	= macio_bus_match,
 };
 
 static int __init
diff -aur linux.backup/drivers/media/common/saa7146_video.c linux/drivers/media/common/saa7146_video.c
--- linux.backup/drivers/media/common/saa7146_video.c	Sat Aug 16 15:02:45 2003
+++ linux/drivers/media/common/saa7146_video.c	Wed Aug 20 16:40:22 2003
@@ -359,41 +359,41 @@
 
 static struct v4l2_queryctrl controls[] = {
 	{
-		id:            V4L2_CID_BRIGHTNESS,
-		name:          "Brightness",
-		minimum:       0,
-		maximum:       255,
-		step:          1,
-		default_value: 128,
-		type:          V4L2_CTRL_TYPE_INTEGER,
+		.id            = V4L2_CID_BRIGHTNESS,
+		.name          = "Brightness",
+		.minimum       = 0,
+		.maximum       = 255,
+		.step          = 1,
+		.default_value = 128,
+		.type          = V4L2_CTRL_TYPE_INTEGER,
 	},{
-		id:            V4L2_CID_CONTRAST,
-		name:          "Contrast",
-		minimum:       0,
-		maximum:       127,
-		step:          1,
-		default_value: 64,
-		type:          V4L2_CTRL_TYPE_INTEGER,
+		.id            = V4L2_CID_CONTRAST,
+		.name          = "Contrast",
+		.minimum       = 0,
+		.maximum       = 127,
+		.step          = 1,
+		.default_value = 64,
+		.type          = V4L2_CTRL_TYPE_INTEGER,
 	},{
-		id:            V4L2_CID_SATURATION,
-		name:          "Saturation",
-		minimum:       0,
-		maximum:       127,
-		step:          1,
-		default_value: 64,
-		type:          V4L2_CTRL_TYPE_INTEGER,
+		.id            = V4L2_CID_SATURATION,
+		.name          = "Saturation",
+		.minimum       = 0,
+		.maximum       = 127,
+		.step          = 1,
+		.default_value = 64,
+		.type          = V4L2_CTRL_TYPE_INTEGER,
 	},{
-		id:            V4L2_CID_VFLIP,
-		name:          "Vertical flip",
-		minimum:       0,
-		maximum:       1,
-		type:          V4L2_CTRL_TYPE_BOOLEAN,
+		.id            = V4L2_CID_VFLIP,
+		.name          = "Vertical flip",
+		.minimum       = 0,
+		.maximum       = 1,
+		.type          = V4L2_CTRL_TYPE_BOOLEAN,
 	},{
-		id:            V4L2_CID_HFLIP,
-		name:          "Horizontal flip",
-		minimum:       0,
-		maximum:       1,
-		type:          V4L2_CTRL_TYPE_BOOLEAN,
+		.id            = V4L2_CID_HFLIP,
+		.name          = "Horizontal flip",
+		.minimum       = 0,
+		.maximum       = 1,
+		.type          = V4L2_CTRL_TYPE_BOOLEAN,
 	},
 };
 static int NUM_CONTROLS = sizeof(controls)/sizeof(struct v4l2_queryctrl);
diff -aur linux.backup/drivers/media/dvb/frontends/grundig_29504-401.c linux/drivers/media/dvb/frontends/grundig_29504-401.c
--- linux.backup/drivers/media/dvb/frontends/grundig_29504-401.c	Sat Aug 16 15:02:19 2003
+++ linux/drivers/media/dvb/frontends/grundig_29504-401.c	Wed Aug 20 16:40:22 2003
@@ -37,15 +37,15 @@
 
 
 struct dvb_frontend_info grundig_29504_401_info = {
-	name: "Grundig 29504-401",
-	type: FE_OFDM,
-/*	frequency_min: ???,*/
-/*	frequency_max: ???,*/
-	frequency_stepsize: 166666,
-/*      frequency_tolerance: ???,*/
-/*      symbol_rate_tolerance: ???,*/
-	notifier_delay: 0,
-	caps: FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 | 
+	.name = "Grundig 29504-401",
+	.type = FE_OFDM,
+/*	.frequency_min = ???,*/
+/*	.frequency_max = ???,*/
+	.frequency_stepsize = 166666,
+/*      .frequency_tolerance = ???,*/
+/*      .symbol_rate_tolerance = ???,*/
+	.notifier_delay = 0,
+	.caps = FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 | 
 	      FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 |
 	      FE_CAN_QPSK | FE_CAN_QAM_16 | FE_CAN_QAM_64 |
 	      FE_CAN_MUTE_TS /*| FE_CAN_CLEAN_SETUP*/
diff -aur linux.backup/drivers/media/dvb/frontends/ves1820.c linux/drivers/media/dvb/frontends/ves1820.c
--- linux.backup/drivers/media/dvb/frontends/ves1820.c	Sat Aug 16 15:02:19 2003
+++ linux/drivers/media/dvb/frontends/ves1820.c	Wed Aug 20 16:40:22 2003
@@ -81,9 +81,9 @@
 	.symbol_rate_min = (XIN/2)/64,     /* SACLK/64 == (XIN/2)/64 */
 	.symbol_rate_max = (XIN/2)/4,      /* SACLK/4 */
 #if 0
-	frequency_tolerance: ???,
-	symbol_rate_tolerance: ???,  /* ppm */  /* == 8% (spec p. 5) */
-	notifier_delay: ?,
+	.frequency_tolerance = ???,
+	.symbol_rate_tolerance = ???,  /* ppm */  /* == 8% (spec p. 5) */
+	.notifier_delay = ?,
 #endif
 	.caps = FE_CAN_QAM_16 | FE_CAN_QAM_32 | FE_CAN_QAM_64 |
 		FE_CAN_QAM_128 | FE_CAN_QAM_256 | 
diff -aur linux.backup/drivers/media/dvb/ttusb-dec/dec2000_frontend.c linux/drivers/media/dvb/ttusb-dec/dec2000_frontend.c
--- linux.backup/drivers/media/dvb/ttusb-dec/dec2000_frontend.c	Sat Aug 16 15:02:20 2003
+++ linux/drivers/media/dvb/ttusb-dec/dec2000_frontend.c	Wed Aug 20 16:40:22 2003
@@ -30,12 +30,12 @@
 #define dprintk	if (debug) printk
 
 static struct dvb_frontend_info dec2000_frontend_info = {
-	name:			"TechnoTrend/Hauppauge DEC-2000-t Frontend",
-	type:			FE_OFDM,
-	frequency_min:		51000000,
-	frequency_max:		858000000,
-	frequency_stepsize:	62500,
-	caps:	FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
+	.name			= "TechnoTrend/Hauppauge DEC-2000-t Frontend",
+	.type			= FE_OFDM,
+	.frequency_min		= 51000000,
+	.frequency_max		= 858000000,
+	.frequency_stepsize	= 62500,
+	.caps =	FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
 		FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 | FE_CAN_FEC_AUTO |
 		FE_CAN_QAM_16 | FE_CAN_QAM_64 | FE_CAN_QAM_AUTO |
 		FE_CAN_TRANSMISSION_MODE_AUTO | FE_CAN_GUARD_INTERVAL_AUTO |
diff -aur linux.backup/drivers/media/dvb/ttusb-dec/ttusb_dec.c linux/drivers/media/dvb/ttusb-dec/ttusb_dec.c
--- linux.backup/drivers/media/dvb/ttusb-dec/ttusb_dec.c	Tue Aug 19 20:56:55 2003
+++ linux/drivers/media/dvb/ttusb-dec/ttusb_dec.c	Wed Aug 20 16:40:22 2003
@@ -1003,10 +1003,10 @@
 };
 
 static struct usb_driver ttusb_dec_driver = {
-      name:		DRIVER_NAME,
-      probe:		ttusb_dec_probe,
-      disconnect:	ttusb_dec_disconnect,
-      id_table:		ttusb_dec_table,
+      .name		= DRIVER_NAME,
+      .probe		= ttusb_dec_probe,
+      .disconnect	= ttusb_dec_disconnect,
+      .id_table		= ttusb_dec_table,
 };
 
 static int __init ttusb_dec_init(void)
diff -aur linux.backup/drivers/mtd/maps/ceiva.c linux/drivers/mtd/maps/ceiva.c
--- linux.backup/drivers/mtd/maps/ceiva.c	Thu Jun 26 23:47:35 2003
+++ linux/drivers/mtd/maps/ceiva.c	Wed Aug 20 16:40:22 2003
@@ -64,23 +64,23 @@
 
 static struct mtd_partition ceiva_partitions[] = {
 	{
-		name: "Ceiva BOOT partition",
-		size:   BOOT_PARTITION_SIZE_KiB*1024,
-		offset: 0,
+		.name = "Ceiva BOOT partition",
+		.size   = BOOT_PARTITION_SIZE_KiB*1024,
+		.offset = 0,
 
 	},{
-		name: "Ceiva parameters partition",
-		size:   PARAMS_PARTITION_SIZE_KiB*1024,
-		offset: (16 + 8) * 1024,
+		.name = "Ceiva parameters partition",
+		.size   = PARAMS_PARTITION_SIZE_KiB*1024,
+		.offset = (16 + 8) * 1024,
 	},{
-		name: "Ceiva kernel partition",
-		size: (KERNEL_PARTITION_SIZE_KiB)*1024,
-		offset: 0x20000,
+		.name = "Ceiva kernel partition",
+		.size = (KERNEL_PARTITION_SIZE_KiB)*1024,
+		.offset = 0x20000,
 
 	},{
-		name: "Ceiva root filesystem partition",
-		offset: MTDPART_OFS_APPEND,
-		size: (ROOT_PARTITION_SIZE_KiB)*1024,
+		.name = "Ceiva root filesystem partition",
+		.offset = MTDPART_OFS_APPEND,
+		.size = (ROOT_PARTITION_SIZE_KiB)*1024,
 	}
 };
 #endif
diff -aur linux.backup/drivers/mtd/nand/autcpu12.c linux/drivers/mtd/nand/autcpu12.c
--- linux.backup/drivers/mtd/nand/autcpu12.c	Mon Jul 21 23:34:57 2003
+++ linux/drivers/mtd/nand/autcpu12.c	Wed Aug 20 16:40:22 2003
@@ -73,39 +73,39 @@
 extern struct nand_oobinfo jffs2_oobinfo;
 
 static struct mtd_partition partition_info16k[] = {
-	{ name: "AUTCPU12 flash partition 1",
-	  offset:  0,
-	  size:    8 * SZ_1M },
-	{ name: "AUTCPU12 flash partition 2",
-	  offset:  8 * SZ_1M,
-	  size:    8 * SZ_1M },
+	{ .name = "AUTCPU12 flash partition 1",
+	  .offset  = 0,
+	  .size =    8 * SZ_1M },
+	{ .name = "AUTCPU12 flash partition 2",
+	  .offset =  8 * SZ_1M,
+	  .size =    8 * SZ_1M },
 };
 
 static struct mtd_partition partition_info32k[] = {
-	{ name: "AUTCPU12 flash partition 1",
-	  offset:  0,
-	  size:    8 * SZ_1M },
-	{ name: "AUTCPU12 flash partition 2",
-	  offset:  8 * SZ_1M,
-	  size:   24 * SZ_1M },
+	{ .name = "AUTCPU12 flash partition 1",
+	  .offset  = 0,
+	  .size =    8 * SZ_1M },
+	{ .name = "AUTCPU12 flash partition 2",
+	  .offset =  8 * SZ_1M,
+	  .size =   24 * SZ_1M },
 };
 
 static struct mtd_partition partition_info64k[] = {
-	{ name: "AUTCPU12 flash partition 1",
-	  offset:  0,
-	  size:   16 * SZ_1M },
-	{ name: "AUTCPU12 flash partition 2",
-	  offset: 16 * SZ_1M,
-	  size:   48 * SZ_1M },
+	{ .name = "AUTCPU12 flash partition 1",
+	  .offset  = 0,
+	  .size =   16 * SZ_1M },
+	{ .name = "AUTCPU12 flash partition 2",
+	  .offset = 16 * SZ_1M,
+	  .size =   48 * SZ_1M },
 };
 
 static struct mtd_partition partition_info128k[] = {
-	{ name: "AUTCPU12 flash partition 1",
-	  offset:  0,
-	  size:   16 * SZ_1M },
-	{ name: "AUTCPU12 flash partition 2",
-	  offset: 16 * SZ_1M,
-	  size:   112 * SZ_1M },
+	{ .name = "AUTCPU12 flash partition 1",
+	  .offset  = 0,
+	  .size =   16 * SZ_1M },
+	{ .name = "AUTCPU12 flash partition 2",
+	  .offset = 16 * SZ_1M,
+	  .size =   112 * SZ_1M },
 };
 
 #define NUM_PARTITIONS16K 2
diff -aur linux.backup/drivers/mtd/nand/edb7312.c linux/drivers/mtd/nand/edb7312.c
--- linux.backup/drivers/mtd/nand/edb7312.c	Thu Jun 26 23:47:35 2003
+++ linux/drivers/mtd/nand/edb7312.c	Wed Aug 20 16:40:22 2003
@@ -71,9 +71,9 @@
  * Define static partitions for flash device
  */
 static struct mtd_partition partition_info[] = {
-	{ name: "EP7312 Nand Flash",
-		  offset: 0,
-		  size: 8*1024*1024 }
+	{ .name = "EP7312 Nand Flash",
+		  .offset = 0,
+		  .size = 8*1024*1024 }
 };
 #define NUM_PARTITIONS 1
 
diff -aur linux.backup/drivers/net/arm/ether00.c linux/drivers/net/arm/ether00.c
--- linux.backup/drivers/net/arm/ether00.c	Sat Aug 16 15:02:48 2003
+++ linux/drivers/net/arm/ether00.c	Wed Aug 20 16:40:22 2003
@@ -991,9 +991,9 @@
 }
 
 static struct pld_hotswap_ops ether00_pldhs_ops={
-	name: ETHER00_NAME,
-	add_device: ether00_add_device,
-	remove_devices: ether00_remove_devices,
+	.name = ETHER00_NAME,
+	.add_device = ether00_add_device,
+	.remove_devices = ether00_remove_devices,
 };
 
 
diff -aur linux.backup/drivers/net/irda/via-ircc.c linux/drivers/net/irda/via-ircc.c
--- linux.backup/drivers/net/irda/via-ircc.c	Sat Aug 16 15:02:49 2003
+++ linux/drivers/net/irda/via-ircc.c	Wed Aug 20 16:40:22 2003
@@ -134,10 +134,10 @@
 
 
 static struct pci_driver via_driver = {
-	name:		VIA_MODULE_NAME,
-	id_table:	via_pci_tbl,
-	probe:		via_init_one,
-	remove:		via_remove_one,
+	.name		= VIA_MODULE_NAME,
+	.id_table	= via_pci_tbl,
+	.probe		= via_init_one,
+	.remove		= via_remove_one,
 };
 
 
diff -aur linux.backup/drivers/net/sungem_phy.c linux/drivers/net/sungem_phy.c
--- linux.backup/drivers/net/sungem_phy.c	Thu Jun 26 23:46:36 2003
+++ linux/drivers/net/sungem_phy.c	Wed Aug 20 16:40:22 2003
@@ -634,116 +634,116 @@
 
 /* Broadcom BCM 5201 */
 static struct mii_phy_ops bcm5201_phy_ops = {
-	init:		bcm5201_init,
-	suspend:	bcm5201_suspend,
-	setup_aneg:	genmii_setup_aneg,
-	setup_forced:	genmii_setup_forced,
-	poll_link:	genmii_poll_link,
-	read_link:	genmii_read_link,
+	.init		= bcm5201_init,
+	.suspend	= bcm5201_suspend,
+	.setup_aneg	= genmii_setup_aneg,
+	.setup_forced	= genmii_setup_forced,
+	.poll_link	= genmii_poll_link,
+	.read_link	= genmii_read_link,
 };
 
 static struct mii_phy_def bcm5201_phy_def = {
-	phy_id:		0x00406210,
-	phy_id_mask:	0xfffffff0,
-	name:		"BCM5201",
-	features:	MII_BASIC_FEATURES,
-	magic_aneg:	0,
-	ops:		&bcm5201_phy_ops
+	.phy_id		= 0x00406210,
+	.phy_id_mask	= 0xfffffff0,
+	.name		= "BCM5201",
+	.features	= MII_BASIC_FEATURES,
+	.magic_aneg	= 0,
+	.ops		= &bcm5201_phy_ops
 };
 
 /* Broadcom BCM 5221 */
 static struct mii_phy_ops bcm5221_phy_ops = {
-	suspend:	bcm5201_suspend,
-	init:		bcm5221_init,
-	setup_aneg:	genmii_setup_aneg,
-	setup_forced:	genmii_setup_forced,
-	poll_link:	genmii_poll_link,
-	read_link:	genmii_read_link,
+	.suspend	= bcm5201_suspend,
+	.init		= bcm5221_init,
+	.setup_aneg	= genmii_setup_aneg,
+	.setup_forced	= genmii_setup_forced,
+	.poll_link	= genmii_poll_link,
+	.read_link	= genmii_read_link,
 };
 
 static struct mii_phy_def bcm5221_phy_def = {
-	phy_id:		0x004061e0,
-	phy_id_mask:	0xfffffff0,
-	name:		"BCM5221",
-	features:	MII_BASIC_FEATURES,
-	magic_aneg:	0,
-	ops:		&bcm5221_phy_ops
+	.phy_id		= 0x004061e0,
+	.phy_id_mask	= 0xfffffff0,
+	.name		= "BCM5221",
+	.features	= MII_BASIC_FEATURES,
+	.magic_aneg	= 0,
+	.ops		= &bcm5221_phy_ops
 };
 
 /* Broadcom BCM 5400 */
 static struct mii_phy_ops bcm5400_phy_ops = {
-	init:		bcm5400_init,
-	suspend:	bcm5400_suspend,
-	setup_aneg:	bcm54xx_setup_aneg,
-	setup_forced:	bcm54xx_setup_forced,
-	poll_link:	genmii_poll_link,
-	read_link:	bcm54xx_read_link,
+	.init		= bcm5400_init,
+	.suspend	= bcm5400_suspend,
+	.setup_aneg	= bcm54xx_setup_aneg,
+	.setup_forced	= bcm54xx_setup_forced,
+	.poll_link	= genmii_poll_link,
+	.read_link	= bcm54xx_read_link,
 };
 
 static struct mii_phy_def bcm5400_phy_def = {
-	phy_id:		0x00206040,
-	phy_id_mask:	0xfffffff0,
-	name:		"BCM5400",
-	features:	MII_GBIT_FEATURES,
-	magic_aneg:	1,
-	ops:		&bcm5400_phy_ops
+	.phy_id		= 0x00206040,
+	.phy_id_mask	= 0xfffffff0,
+	.name		= "BCM5400",
+	.features	= MII_GBIT_FEATURES,
+	.magic_aneg	= 1,
+	.ops		= &bcm5400_phy_ops
 };
 
 /* Broadcom BCM 5401 */
 static struct mii_phy_ops bcm5401_phy_ops = {
-	init:		bcm5401_init,
-	suspend:	bcm5401_suspend,
-	setup_aneg:	bcm54xx_setup_aneg,
-	setup_forced:	bcm54xx_setup_forced,
-	poll_link:	genmii_poll_link,
-	read_link:	bcm54xx_read_link,
+	.init		= bcm5401_init,
+	.suspend	= bcm5401_suspend,
+	.setup_aneg	= bcm54xx_setup_aneg,
+	.setup_forced	= bcm54xx_setup_forced,
+	.poll_link	= genmii_poll_link,
+	.read_link	= bcm54xx_read_link,
 };
 
 static struct mii_phy_def bcm5401_phy_def = {
-	phy_id:		0x00206050,
-	phy_id_mask:	0xfffffff0,
-	name:		"BCM5401",
-	features:	MII_GBIT_FEATURES,
-	magic_aneg:	1,
-	ops:		&bcm5401_phy_ops
+	.phy_id		= 0x00206050,
+	.phy_id_mask	= 0xfffffff0,
+	.name		= "BCM5401",
+	.features	= MII_GBIT_FEATURES,
+	.magic_aneg	= 1,
+	.ops		= &bcm5401_phy_ops
 };
 
 /* Broadcom BCM 5411 */
 static struct mii_phy_ops bcm5411_phy_ops = {
-	init:		bcm5411_init,
-	suspend:	bcm5411_suspend,
-	setup_aneg:	bcm54xx_setup_aneg,
-	setup_forced:	bcm54xx_setup_forced,
-	poll_link:	genmii_poll_link,
-	read_link:	bcm54xx_read_link,
+	.init		= bcm5411_init,
+	.suspend	= bcm5411_suspend,
+	.setup_aneg	= bcm54xx_setup_aneg,
+	.setup_forced	= bcm54xx_setup_forced,
+	.poll_link	= genmii_poll_link,
+	.read_link	= bcm54xx_read_link,
 };
 
 static struct mii_phy_def bcm5411_phy_def = {
-	phy_id:		0x00206070,
-	phy_id_mask:	0xfffffff0,
-	name:		"BCM5411",
-	features:	MII_GBIT_FEATURES,
-	magic_aneg:	1,
-	ops:		&bcm5411_phy_ops
+	.phy_id		= 0x00206070,
+	.phy_id_mask	= 0xfffffff0,
+	.name		= "BCM5411",
+	.features	= MII_GBIT_FEATURES,
+	.magic_aneg	= 1,
+	.ops		= &bcm5411_phy_ops
 };
 
 /* Broadcom BCM 5421 */
 static struct mii_phy_ops bcm5421_phy_ops = {
-	init:		bcm5421_init,
-	suspend:	bcm5411_suspend,
-	setup_aneg:	bcm54xx_setup_aneg,
-	setup_forced:	bcm54xx_setup_forced,
-	poll_link:	genmii_poll_link,
-	read_link:	bcm54xx_read_link,
+	.init		= bcm5421_init,
+	.suspend	= bcm5411_suspend,
+	.setup_aneg	= bcm54xx_setup_aneg,
+	.setup_forced	= bcm54xx_setup_forced,
+	.poll_link	= genmii_poll_link,
+	.read_link	= bcm54xx_read_link,
 };
 
 static struct mii_phy_def bcm5421_phy_def = {
-	phy_id:		0x002060e0,
-	phy_id_mask:	0xfffffff0,
-	name:		"BCM5421",
-	features:	MII_GBIT_FEATURES,
-	magic_aneg:	1,
-	ops:		&bcm5421_phy_ops
+	.phy_id		= 0x002060e0,
+	.phy_id_mask	= 0xfffffff0,
+	.name		= "BCM5421",
+	.features	= MII_GBIT_FEATURES,
+	.magic_aneg	= 1,
+	.ops		= &bcm5421_phy_ops
 };
 
 /* Marvell 88E1101 (Apple seem to deal with 2 different revs,
@@ -751,36 +751,36 @@
  * would be useful here) --BenH.
  */
 static struct mii_phy_ops marvell_phy_ops = {
-	setup_aneg:	marvell_setup_aneg,
-	setup_forced:	marvell_setup_forced,
-	poll_link:	genmii_poll_link,
-	read_link:	marvell_read_link
+	.setup_aneg	= marvell_setup_aneg,
+	.setup_forced	= marvell_setup_forced,
+	.poll_link	= genmii_poll_link,
+	.read_link	= marvell_read_link
 };
 
 static struct mii_phy_def marvell_phy_def = {
-	phy_id:		0x01410c00,
-	phy_id_mask:	0xffffff00,
-	name:		"Marvell 88E1101",
-	features:	MII_GBIT_FEATURES,
-	magic_aneg:	1,
-	ops:		&marvell_phy_ops
+	.phy_id		= 0x01410c00,
+	.phy_id_mask	= 0xffffff00,
+	.name		= "Marvell 88E1101",
+	.features	= MII_GBIT_FEATURES,
+	.magic_aneg	= 1,
+	.ops		= &marvell_phy_ops
 };
 
 /* Generic implementation for most 10/100 PHYs */
 static struct mii_phy_ops generic_phy_ops = {
-	setup_aneg:	genmii_setup_aneg,
-	setup_forced:	genmii_setup_forced,
-	poll_link:	genmii_poll_link,
-	read_link:	genmii_read_link
+	.setup_aneg	= genmii_setup_aneg,
+	.setup_forced	= genmii_setup_forced,
+	.poll_link	= genmii_poll_link,
+	.read_link	= genmii_read_link
 };
 
 static struct mii_phy_def genmii_phy_def = {
-	phy_id:		0x00000000,
-	phy_id_mask:	0x00000000,
-	name:		"Generic MII",
-	features:	MII_BASIC_FEATURES,
-	magic_aneg:	0,
-	ops:		&generic_phy_ops
+	.phy_id		= 0x00000000,
+	.phy_id_mask	= 0x00000000,
+	.name		= "Generic MII",
+	.features	= MII_BASIC_FEATURES,
+	.magic_aneg	= 0,
+	.ops		= &generic_phy_ops
 };
 
 static struct mii_phy_def* mii_phy_table[] = {
diff -aur linux.backup/drivers/s390/net/qeth.c linux/drivers/s390/net/qeth.c
--- linux.backup/drivers/s390/net/qeth.c	Sat Aug 16 15:02:22 2003
+++ linux/drivers/s390/net/qeth.c	Wed Aug 20 16:40:22 2003
@@ -9765,19 +9765,19 @@
 };
 
 static struct file_operations qeth_procfile_fops = {
-	ioctl:qeth_procfile_ioctl,
-	read:qeth_procfile_read,
-	open:qeth_procfile_open,
-	release:qeth_procfile_release,
+	.ioctl = qeth_procfile_ioctl,
+	.read = qeth_procfile_read,
+	.open = qeth_procfile_open,
+	.release = qeth_procfile_release,
 };
 
 static struct proc_dir_entry *qeth_proc_file;
 
 static struct file_operations qeth_ipato_procfile_fops = {
-	read:qeth_procfile_read,	/* same as above! */
-	write:qeth_ipato_procfile_write,
-	open:qeth_ipato_procfile_open,
-	release:qeth_procfile_release	/* same as above! */
+	.read = qeth_procfile_read,	/* same as above! */
+	.write = qeth_ipato_procfile_write,
+	.open = qeth_ipato_procfile_open,
+	.release = qeth_procfile_release	/* same as above! */
 };
 
 static struct proc_dir_entry *qeth_ipato_proc_file;
diff -aur linux.backup/drivers/scsi/aic7xxx/aic79xx_osm_pci.c linux/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
--- linux.backup/drivers/scsi/aic7xxx/aic79xx_osm_pci.c	Thu Jun 26 23:48:40 2003
+++ linux/drivers/scsi/aic7xxx/aic79xx_osm_pci.c	Wed Aug 20 16:40:22 2003
@@ -72,10 +72,10 @@
 MODULE_DEVICE_TABLE(pci, ahd_linux_pci_id_table);
 
 struct pci_driver aic79xx_pci_driver = {
-	name:		"aic79xx",
-	probe:		ahd_linux_pci_dev_probe,
-	remove:		ahd_linux_pci_dev_remove,
-	id_table:	ahd_linux_pci_id_table
+	.name		= "aic79xx",
+	.probe		= ahd_linux_pci_dev_probe,
+	.remove		= ahd_linux_pci_dev_remove,
+	.id_table	= ahd_linux_pci_id_table
 };
 
 static void
diff -aur linux.backup/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c linux/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
--- linux.backup/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	Thu Jun 26 23:47:40 2003
+++ linux/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	Wed Aug 20 16:40:22 2003
@@ -75,10 +75,10 @@
 MODULE_DEVICE_TABLE(pci, ahc_linux_pci_id_table);
 
 struct pci_driver aic7xxx_pci_driver = {
-	name:		"aic7xxx",
-	probe:		ahc_linux_pci_dev_probe,
-	remove:		ahc_linux_pci_dev_remove,
-	id_table:	ahc_linux_pci_id_table
+	.name		= "aic7xxx",
+	.probe		= ahc_linux_pci_dev_probe,
+	.remove		= ahc_linux_pci_dev_remove,
+	.id_table	= ahc_linux_pci_id_table
 };
 
 static void
diff -aur linux.backup/drivers/video/68328fb.c linux/drivers/video/68328fb.c
--- linux.backup/drivers/video/68328fb.c	Tue Dec 10 15:18:53 2002
+++ linux/drivers/video/68328fb.c	Wed Aug 20 16:40:22 2003
@@ -401,12 +401,12 @@
                                               ((1<<(width))-1)) : 0))
 
 static struct fb_ops mc68328_fb_ops = {
-	.owner:		THIS_MODULE,
-	.fb_setcolreg:	mc68328fb_setcolreg,
-	.fb_fillrect:	cfbfillrect,
-	.fb_copyarea:	cfbcopyarea,
-	.fb_imageblit:	cfbimgblt,
-	.fb_cursor:	softcursor,
+	.owner		= THIS_MODULE,
+	.fb_setcolreg	= mc68328fb_setcolreg,
+	.fb_fillrect	= cfbfillrect,
+	.fb_copyarea	= cfbcopyarea,
+	.fb_imageblit	= cfbimgblt,
+	.fb_cursor	= softcursor,
 };
 
 
diff -aur linux.backup/drivers/video/riva/fbdev.c linux/drivers/video/riva/fbdev.c
--- linux.backup/drivers/video/riva/fbdev.c	Sat Aug 16 15:02:55 2003
+++ linux/drivers/video/riva/fbdev.c	Wed Aug 20 16:40:22 2003
@@ -297,34 +297,34 @@
 #endif
 
 static struct fb_fix_screeninfo rivafb_fix = {
-	id:		"nVidia",
-	type:		FB_TYPE_PACKED_PIXELS,
-	xpanstep:	1,
-	ypanstep:	1,
+	.id		= "nVidia",
+	.type		= FB_TYPE_PACKED_PIXELS,
+	.xpanstep	= 1,
+	.ypanstep	= 1,
 };
 
 static struct fb_var_screeninfo rivafb_default_var = {
-	xres:		640,
-	yres:		480,
-	xres_virtual:	640,
-	yres_virtual:	480,
-	bits_per_pixel:	8,
-	red:		{0, 8, 0},
-	green:		{0, 8, 0},
-	blue:		{0, 8, 0},
-	transp:		{0, 0, 0},
-	activate:	FB_ACTIVATE_NOW,
-	height:		-1,
-	width:		-1,
-	accel_flags:	FB_ACCELF_TEXT,
-	pixclock:	39721,
-	left_margin:	40,
-	right_margin:	24,
-	upper_margin:	32,
-	lower_margin:	11,
-	hsync_len:	96,
-	vsync_len:	2,
-	vmode:		FB_VMODE_NONINTERLACED
+	.xres		= 640,
+	.yres		= 480,
+	.xres_virtual	= 640,
+	.yres_virtual	= 480,
+	.bits_per_pixel	= 8,
+	.red		= {0, 8, 0},
+	.green		= {0, 8, 0},
+	.blue		= {0, 8, 0},
+	.transp		= {0, 0, 0},
+	.activate	= FB_ACTIVATE_NOW,
+	.height		= -1,
+	.width		= -1,
+	.accel_flags	= FB_ACCELF_TEXT,
+	.pixclock	= 39721,
+	.left_margin	= 40,
+	.right_margin	= 24,
+	.upper_margin	= 32,
+	.lower_margin	= 11,
+	.hsync_len	= 96,
+	.vsync_len	= 2,
+	.vmode		= FB_VMODE_NONINTERLACED
 };
 
 /* from GGI */
@@ -1977,10 +1977,10 @@
 #endif /* !MODULE */
 
 static struct pci_driver rivafb_driver = {
-	name:		"rivafb",
-	id_table:	rivafb_pci_tbl,
-	probe:		rivafb_probe,
-	remove:		__exit_p(rivafb_remove),
+	.name		= "rivafb",
+	.id_table	= rivafb_pci_tbl,
+	.probe		= rivafb_probe,
+	.remove		= __exit_p(rivafb_remove),
 };
 
 
diff -aur linux.backup/drivers/video/sis/sis_accel.c linux/drivers/video/sis/sis_accel.c
--- linux.backup/drivers/video/sis/sis_accel.c	Tue Mar 25 10:54:08 2003
+++ linux/drivers/video/sis/sis_accel.c	Wed Aug 20 16:40:22 2003
@@ -591,38 +591,38 @@
 
 #ifdef FBCON_HAS_CFB8
 struct display_switch fbcon_sis8 = {
-	setup:			fbcon_cfb8_setup,
-	bmove:			fbcon_sis_bmove,
-	clear:			fbcon_sis_clear8,
-	putc:			fbcon_cfb8_putc,
-	putcs:			fbcon_cfb8_putcs,
-	revc:			fbcon_cfb8_revc,
-	clear_margins:		fbcon_cfb8_clear_margins,
-	fontwidthmask:		FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
+	.setup			= fbcon_cfb8_setup,
+	.bmove			= fbcon_sis_bmove,
+	.clear			= fbcon_sis_clear8,
+	.putc			= fbcon_cfb8_putc,
+	.putcs			= fbcon_cfb8_putcs,
+	.revc			= fbcon_cfb8_revc,
+	.clear_margins		= fbcon_cfb8_clear_margins,
+	.fontwidthmask		= FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
 };
 #endif
 #ifdef FBCON_HAS_CFB16
 struct display_switch fbcon_sis16 = {
-	setup:			fbcon_cfb16_setup,
-	bmove:			fbcon_sis_bmove,
-	clear:			fbcon_sis_clear16,
-	putc:			fbcon_cfb16_putc,
-	putcs:			fbcon_cfb16_putcs,
-	revc:			fbcon_sis_revc,
-	clear_margins:		fbcon_cfb16_clear_margins,
-	fontwidthmask:		FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
+	.setup			= fbcon_cfb16_setup,
+	.bmove			= fbcon_sis_bmove,
+	.clear			= fbcon_sis_clear16,
+	.putc			= fbcon_cfb16_putc,
+	.putcs			= fbcon_cfb16_putcs,
+	.revc			= fbcon_sis_revc,
+	.clear_margins		= fbcon_cfb16_clear_margins,
+	.fontwidthmask		= FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
 };
 #endif
 #ifdef FBCON_HAS_CFB32
 struct display_switch fbcon_sis32 = {
-	setup:			fbcon_cfb32_setup,
-	bmove:			fbcon_sis_bmove,
-	clear:			fbcon_sis_clear32,
-	putc:			fbcon_cfb32_putc,
-	putcs:			fbcon_cfb32_putcs,
-	revc:			fbcon_sis_revc,
-	clear_margins:		fbcon_cfb32_clear_margins,
-	fontwidthmask:		FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
+	.setup			= fbcon_cfb32_setup,
+	.bmove			= fbcon_sis_bmove,
+	.clear			= fbcon_sis_clear32,
+	.putc			= fbcon_cfb32_putc,
+	.putcs			= fbcon_cfb32_putcs,
+	.revc			= fbcon_sis_revc,
+	.clear_margins		= fbcon_cfb32_clear_margins,
+	.fontwidthmask		= FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
 };
 #endif
 
diff -aur linux.backup/drivers/video/sis/sis_main.c linux/drivers/video/sis/sis_main.c
--- linux.backup/drivers/video/sis/sis_main.c	Thu Jun 26 23:47:47 2003
+++ linux/drivers/video/sis/sis_main.c	Wed Aug 20 16:40:22 2003
@@ -2033,17 +2033,17 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
 static struct fb_ops sisfb_ops = {
-	owner:		THIS_MODULE,
-	fb_get_fix:	sisfb_get_fix,
-	fb_get_var:	sisfb_get_var,
-	fb_set_var:	sisfb_set_var,
-	fb_get_cmap:	sisfb_get_cmap,
-	fb_set_cmap:	sisfb_set_cmap,
+	.owner		= THIS_MODULE,
+	.fb_get_fix	= sisfb_get_fix,
+	.fb_get_var	= sisfb_get_var,
+	.fb_set_var	= sisfb_set_var,
+	.fb_get_cmap	= sisfb_get_cmap,
+	.fb_set_cmap	= sisfb_set_cmap,
 #ifdef SISFB_PAN
-        fb_pan_display:	sisfb_pan_display,
+        .fb_pan_display	= sisfb_pan_display,
 #endif
-	fb_ioctl:	sisfb_ioctl,
-	fb_mmap:	sisfb_mmap,
+	.fb_ioctl	= sisfb_ioctl,
+	.fb_mmap	= sisfb_mmap,
 };
 #endif
 
