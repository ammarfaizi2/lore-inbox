Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbTIVXuM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 19:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbTIVXtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 19:49:33 -0400
Received: from mail.kroah.org ([65.200.24.183]:13217 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262788AbTIVXbC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:31:02 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10642734172743@kroah.com>
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
In-Reply-To: <1064273416272@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 22 Sep 2003 16:30:17 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1153.85.3, 2003/08/27 15:32:28-07:00, hirofumi@mail.parknet.co.jp

[PATCH] DEVICE_NAME_SIZE/_HALF removal (I2C stuff)


 drivers/i2c/busses/i2c-ali1535.c |    2 +-
 drivers/i2c/busses/i2c-ali15x3.c |    2 +-
 drivers/i2c/busses/i2c-amd756.c  |    2 +-
 drivers/i2c/busses/i2c-amd8111.c |    2 +-
 drivers/i2c/busses/i2c-i801.c    |    2 +-
 drivers/i2c/busses/i2c-nforce2.c |    2 +-
 drivers/i2c/busses/i2c-piix4.c   |    2 +-
 drivers/i2c/busses/i2c-sis96x.c  |    2 +-
 drivers/i2c/busses/i2c-viapro.c  |    2 +-
 drivers/i2c/chips/adm1021.c      |    2 +-
 drivers/i2c/chips/it87.c         |    2 +-
 drivers/i2c/chips/lm75.c         |    2 +-
 drivers/i2c/chips/lm78.c         |    2 +-
 drivers/i2c/chips/lm85.c         |   10 +++++-----
 drivers/i2c/chips/via686a.c      |    2 +-
 drivers/i2c/chips/w83781d.c      |    4 ++--
 drivers/i2c/scx200_acb.c         |    2 +-
 include/linux/i2c.h              |    6 ++++--
 18 files changed, 26 insertions(+), 24 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
--- a/drivers/i2c/busses/i2c-ali1535.c	Mon Sep 22 16:16:54 2003
+++ b/drivers/i2c/busses/i2c-ali1535.c	Mon Sep 22 16:16:54 2003
@@ -507,7 +507,7 @@
 	/* set up the driverfs linkage to our parent device */
 	ali1535_adapter.dev.parent = &dev->dev;
 
-	snprintf(ali1535_adapter.name, DEVICE_NAME_SIZE, 
+	snprintf(ali1535_adapter.name, I2C_NAME_SIZE, 
 		"SMBus ALI1535 adapter at %04x", ali1535_smba);
 	return i2c_add_adapter(&ali1535_adapter);
 }
diff -Nru a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
--- a/drivers/i2c/busses/i2c-ali15x3.c	Mon Sep 22 16:16:54 2003
+++ b/drivers/i2c/busses/i2c-ali15x3.c	Mon Sep 22 16:16:54 2003
@@ -498,7 +498,7 @@
 	/* set up the driverfs linkage to our parent device */
 	ali15x3_adapter.dev.parent = &dev->dev;
 
-	snprintf(ali15x3_adapter.name, DEVICE_NAME_SIZE,
+	snprintf(ali15x3_adapter.name, I2C_NAME_SIZE,
 		"SMBus ALI15X3 adapter at %04x", ali15x3_smba);
 	return i2c_add_adapter(&ali15x3_adapter);
 }
diff -Nru a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
--- a/drivers/i2c/busses/i2c-amd756.c	Mon Sep 22 16:16:54 2003
+++ b/drivers/i2c/busses/i2c-amd756.c	Mon Sep 22 16:16:54 2003
@@ -369,7 +369,7 @@
 	/* set up the driverfs linkage to our parent device */
 	amd756_adapter.dev.parent = &pdev->dev;
 
-	snprintf(amd756_adapter.name, DEVICE_NAME_SIZE,
+	snprintf(amd756_adapter.name, I2C_NAME_SIZE,
 		"SMBus AMD75x adapter at %04x", amd756_ioport);
 
 	error = i2c_add_adapter(&amd756_adapter);
diff -Nru a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
--- a/drivers/i2c/busses/i2c-amd8111.c	Mon Sep 22 16:16:54 2003
+++ b/drivers/i2c/busses/i2c-amd8111.c	Mon Sep 22 16:16:54 2003
@@ -356,7 +356,7 @@
 		goto out_kfree;
 
 	smbus->adapter.owner = THIS_MODULE;
-	snprintf(smbus->adapter.name, DEVICE_NAME_SIZE,
+	snprintf(smbus->adapter.name, I2C_NAME_SIZE,
 		"SMBus2 AMD8111 adapter at %04x", smbus->base);
 	smbus->adapter.id = I2C_ALGO_SMBUS | I2C_HW_SMBUS_AMD8111;
 	smbus->adapter.class = I2C_ADAP_CLASS_SMBUS;
diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	Mon Sep 22 16:16:54 2003
+++ b/drivers/i2c/busses/i2c-i801.c	Mon Sep 22 16:16:54 2003
@@ -598,7 +598,7 @@
 	/* set up the driverfs linkage to our parent device */
 	i801_adapter.dev.parent = &dev->dev;
 
-	snprintf(i801_adapter.name, DEVICE_NAME_SIZE,
+	snprintf(i801_adapter.name, I2C_NAME_SIZE,
 		"SMBus I801 adapter at %04x", i801_smba);
 	return i2c_add_adapter(&i801_adapter);
 }
diff -Nru a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
--- a/drivers/i2c/busses/i2c-nforce2.c	Mon Sep 22 16:16:54 2003
+++ b/drivers/i2c/busses/i2c-nforce2.c	Mon Sep 22 16:16:54 2003
@@ -321,7 +321,7 @@
 	smbus->adapter = nforce2_adapter;
 	smbus->adapter.algo_data = smbus;
 	smbus->adapter.dev.parent = &dev->dev;
-	snprintf(smbus->adapter.name, DEVICE_NAME_SIZE,
+	snprintf(smbus->adapter.name, I2C_NAME_SIZE,
 		"SMBus nForce2 adapter at %04x", smbus->base);
 
 	error = i2c_add_adapter(&smbus->adapter);
diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Mon Sep 22 16:16:54 2003
+++ b/drivers/i2c/busses/i2c-piix4.c	Mon Sep 22 16:16:54 2003
@@ -451,7 +451,7 @@
 	/* set up the driverfs linkage to our parent device */
 	piix4_adapter.dev.parent = &dev->dev;
 
-	snprintf(piix4_adapter.name, DEVICE_NAME_SIZE,
+	snprintf(piix4_adapter.name, I2C_NAME_SIZE,
 		"SMBus PIIX4 adapter at %04x", piix4_smba);
 
 	retval = i2c_add_adapter(&piix4_adapter);
diff -Nru a/drivers/i2c/busses/i2c-sis96x.c b/drivers/i2c/busses/i2c-sis96x.c
--- a/drivers/i2c/busses/i2c-sis96x.c	Mon Sep 22 16:16:54 2003
+++ b/drivers/i2c/busses/i2c-sis96x.c	Mon Sep 22 16:16:54 2003
@@ -318,7 +318,7 @@
 	/* set up the driverfs linkage to our parent device */
 	sis96x_adapter.dev.parent = &dev->dev;
 
-	snprintf(sis96x_adapter.name, DEVICE_NAME_SIZE,
+	snprintf(sis96x_adapter.name, I2C_NAME_SIZE,
 		"SiS96x SMBus adapter at 0x%04x", sis96x_smbus_base);
 
 	if ((retval = i2c_add_adapter(&sis96x_adapter))) {
diff -Nru a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
--- a/drivers/i2c/busses/i2c-viapro.c	Mon Sep 22 16:16:54 2003
+++ b/drivers/i2c/busses/i2c-viapro.c	Mon Sep 22 16:16:54 2003
@@ -376,7 +376,7 @@
 	dev_dbg(&pdev->dev, "VT596_smba = 0x%X\n", vt596_smba);
 
 	vt596_adapter.dev.parent = &pdev->dev;
-	snprintf(vt596_adapter.name, DEVICE_NAME_SIZE,
+	snprintf(vt596_adapter.name, I2C_NAME_SIZE,
 			"SMBus Via Pro adapter at %04x", vt596_smba);
 	
 	return i2c_add_adapter(&vt596_adapter);
diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Mon Sep 22 16:16:54 2003
+++ b/drivers/i2c/chips/adm1021.c	Mon Sep 22 16:16:54 2003
@@ -320,7 +320,7 @@
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
-	strlcpy(new_client->name, client_name, DEVICE_NAME_SIZE);
+	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
 	data->type = kind;
 
 	new_client->id = adm1021_id++;
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Mon Sep 22 16:16:54 2003
+++ b/drivers/i2c/chips/it87.c	Mon Sep 22 16:16:54 2003
@@ -692,7 +692,7 @@
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
-	strlcpy(new_client->name, name, DEVICE_NAME_SIZE);
+	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 
 	data->type = kind;
 
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Mon Sep 22 16:16:54 2003
+++ b/drivers/i2c/chips/lm75.c	Mon Sep 22 16:16:54 2003
@@ -194,7 +194,7 @@
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
-	strlcpy(new_client->name, name, DEVICE_NAME_SIZE);
+	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 
 	new_client->id = lm75_id++;
 	data->valid = 0;
diff -Nru a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c	Mon Sep 22 16:16:54 2003
+++ b/drivers/i2c/chips/lm78.c	Mon Sep 22 16:16:54 2003
@@ -638,7 +638,7 @@
 	}
 
 	/* Fill in the remaining client fields and put into the global list */
-	strlcpy(new_client->name, client_name, DEVICE_NAME_SIZE);
+	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
 	data->type = kind;
 
 	data->valid = 0;
diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	Mon Sep 22 16:16:54 2003
+++ b/drivers/i2c/chips/lm85.c	Mon Sep 22 16:16:54 2003
@@ -853,19 +853,19 @@
 	/* Fill in the chip specific driver values */
 	if ( kind == any_chip ) {
 		type_name = "lm85";
-		strlcpy(new_client->name, "Generic LM85", DEVICE_NAME_SIZE);
+		strlcpy(new_client->name, "Generic LM85", I2C_NAME_SIZE);
 	} else if ( kind == lm85b ) {
 		type_name = "lm85b";
-		strlcpy(new_client->name, "National LM85-B", DEVICE_NAME_SIZE);
+		strlcpy(new_client->name, "National LM85-B", I2C_NAME_SIZE);
 	} else if ( kind == lm85c ) {
 		type_name = "lm85c";
-		strlcpy(new_client->name, "National LM85-C", DEVICE_NAME_SIZE);
+		strlcpy(new_client->name, "National LM85-C", I2C_NAME_SIZE);
 	} else if ( kind == adm1027 ) {
 		type_name = "adm1027";
-		strlcpy(new_client->name, "Analog Devices ADM1027", DEVICE_NAME_SIZE);
+		strlcpy(new_client->name, "Analog Devices ADM1027", I2C_NAME_SIZE);
 	} else if ( kind == adt7463 ) {
 		type_name = "adt7463";
-		strlcpy(new_client->name, "Analog Devices ADT7463", DEVICE_NAME_SIZE);
+		strlcpy(new_client->name, "Analog Devices ADT7463", I2C_NAME_SIZE);
 	} else {
 		dev_dbg(&adapter->dev, "Internal error, invalid kind (%d)!", kind);
 		err = -EFAULT ;
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Mon Sep 22 16:16:54 2003
+++ b/drivers/i2c/chips/via686a.c	Mon Sep 22 16:16:54 2003
@@ -727,7 +727,7 @@
 	new_client->dev.parent = &adapter->dev;
 
 	/* Fill in the remaining client fields and put into the global list */
-	snprintf(new_client->name, DEVICE_NAME_SIZE, client_name);
+	snprintf(new_client->name, I2C_NAME_SIZE, client_name);
 
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Mon Sep 22 16:16:54 2003
+++ b/drivers/i2c/chips/w83781d.c	Mon Sep 22 16:16:54 2003
@@ -1117,7 +1117,7 @@
 		data->lm75[i]->driver = &w83781d_driver;
 		data->lm75[i]->flags = 0;
 		strlcpy(data->lm75[i]->name, client_name,
-			DEVICE_NAME_SIZE);
+			I2C_NAME_SIZE);
 		if ((err = i2c_attach_client(data->lm75[i]))) {
 			dev_err(&new_client->dev, "Subclient %d "
 				"registration at address 0x%x "
@@ -1326,7 +1326,7 @@
 	}
 
 	/* Fill in the remaining client fields and put into the global list */
-	strlcpy(new_client->name, client_name, DEVICE_NAME_SIZE);
+	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
 	data->type = kind;
 
 	data->valid = 0;
diff -Nru a/drivers/i2c/scx200_acb.c b/drivers/i2c/scx200_acb.c
--- a/drivers/i2c/scx200_acb.c	Mon Sep 22 16:16:54 2003
+++ b/drivers/i2c/scx200_acb.c	Mon Sep 22 16:16:54 2003
@@ -456,7 +456,7 @@
 	memset(iface, 0, sizeof(*iface));
 	adapter = &iface->adapter;
 	i2c_set_adapdata(adapter, iface);
-	snprintf(adapter->name, DEVICE_NAME_SIZE, "SCx200 ACB%d", index);
+	snprintf(adapter->name, I2C_NAME_SIZE, "SCx200 ACB%d", index);
 	adapter->owner = THIS_MODULE;
 	adapter->id = I2C_ALGO_SMBUS;
 	adapter->algo = &scx200_acb_algorithm;
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Mon Sep 22 16:16:54 2003
+++ b/include/linux/i2c.h	Mon Sep 22 16:16:54 2003
@@ -146,6 +146,8 @@
 
 extern struct bus_type i2c_bus_type;
 
+#define I2C_NAME_SIZE	50
+
 /*
  * i2c_client identifies a single device (i.e. chip) that is connected to an 
  * i2c bus. The behaviour is defined by the routines of the driver. This
@@ -166,7 +168,7 @@
 					/* to the client		*/
 	struct device dev;		/* the device structure		*/
 	struct list_head list;
-	char name[DEVICE_NAME_SIZE];
+	char name[I2C_NAME_SIZE];
 	struct completion released;
 };
 #define to_i2c_client(d) container_of(d, struct i2c_client, dev)
@@ -253,7 +255,7 @@
 	int nr;
 	struct list_head clients;
 	struct list_head list;
-	char name[DEVICE_NAME_SIZE];
+	char name[I2C_NAME_SIZE];
 	struct completion dev_released;
 	struct completion class_dev_released;
 };

