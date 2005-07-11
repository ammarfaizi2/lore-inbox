Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262894AbVGKWJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbVGKWJP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262807AbVGKWGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:06:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:2013 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262902AbVGKWDz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:03:55 -0400
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Strip trailing whitespace from strings
In-Reply-To: <11211193762160@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 11 Jul 2005 15:02:56 -0700
Message-Id: <11211193763732@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: Strip trailing whitespace from strings

Here is a simple patch originally from Denis Vlasenko, which strips a
useless trailing whitespace from 8 strings in 4 i2c drivers. Please
apply, thanks.

From: Denis Vlasenko <vda@ilport.com.ua>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 541e6a02768404efb06bd1ea5f33d614732f41fc
tree 933f4e7b38580c69e61b8a0002d4e5c129c5abaa
parent 65fc50e50ff9f8b82c3756eccd7e7db6a267ffe9
author Jean Delvare <khali@linux-fr.org> Thu, 23 Jun 2005 22:18:08 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 11 Jul 2005 14:10:36 -0700

 drivers/i2c/algos/i2c-algo-ite.c |    8 ++++----
 drivers/i2c/busses/i2c-i801.c    |    4 ++--
 drivers/i2c/busses/i2c-piix4.c   |    2 +-
 drivers/i2c/busses/i2c-sis5595.c |    2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-ite.c b/drivers/i2c/algos/i2c-algo-ite.c
--- a/drivers/i2c/algos/i2c-algo-ite.c
+++ b/drivers/i2c/algos/i2c-algo-ite.c
@@ -208,7 +208,7 @@ static int test_bus(struct i2c_algo_iic_
 		goto bailout;
 	}
 	sdalo(adap);
-	printk("test_bus:1 scl: %d  sda: %d \n",getscl(adap),
+	printk("test_bus:1 scl: %d  sda: %d\n", getscl(adap),
 	       getsda(adap));
 	if ( 0 != getsda(adap) ) {
 		printk("test_bus: %s SDA stuck high!\n",name);
@@ -221,7 +221,7 @@ static int test_bus(struct i2c_algo_iic_
 		goto bailout;
 	}		
 	sdahi(adap);
-	printk("test_bus:2 scl: %d  sda: %d \n",getscl(adap),
+	printk("test_bus:2 scl: %d  sda: %d\n", getscl(adap),
 	       getsda(adap));
 	if ( 0 == getsda(adap) ) {
 		printk("test_bus: %s SDA stuck low!\n",name);
@@ -234,7 +234,7 @@ static int test_bus(struct i2c_algo_iic_
 	goto bailout;
 	}
 	scllo(adap);
-	printk("test_bus:3 scl: %d  sda: %d \n",getscl(adap),
+	printk("test_bus:3 scl: %d  sda: %d\n", getscl(adap),
 	       getsda(adap));
 	if ( 0 != getscl(adap) ) {
 
@@ -247,7 +247,7 @@ static int test_bus(struct i2c_algo_iic_
 		goto bailout;
 	}
 	sclhi(adap);
-	printk("test_bus:4 scl: %d  sda: %d \n",getscl(adap),
+	printk("test_bus:4 scl: %d  sda: %d\n", getscl(adap),
 	       getsda(adap));
 	if ( 0 == getscl(adap) ) {
 		printk("test_bus: %s SCL stuck low!\n",name);
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -194,7 +194,7 @@ static int i801_transaction(void)
 	/* Make sure the SMBus host is ready to start transmitting */
 	/* 0x1f = Failed, Bus_Err, Dev_Err, Intr, Host_Busy */
 	if ((temp = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
-		dev_dbg(&I801_dev->dev, "SMBus busy (%02x). Resetting... \n",
+		dev_dbg(&I801_dev->dev, "SMBus busy (%02x). Resetting...\n",
 			temp);
 		outb_p(temp, SMBHSTSTS);
 		if ((temp = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
@@ -315,7 +315,7 @@ static int i801_block_transaction(union 
 		}
 		if (temp & errmask) {
 			dev_dbg(&I801_dev->dev, "SMBus busy (%02x). "
-				"Resetting... \n", temp);
+				"Resetting...\n", temp);
 			outb_p(temp, SMBHSTSTS);
 			if (((temp = inb_p(SMBHSTSTS)) & errmask) != 0x00) {
 				dev_err(&I801_dev->dev,
diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -243,7 +243,7 @@ static int piix4_transaction(void)
 	/* Make sure the SMBus host is ready to start transmitting */
 	if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
 		dev_dbg(&piix4_adapter.dev, "SMBus busy (%02x). "
-			"Resetting... \n", temp);
+			"Resetting...\n", temp);
 		outb_p(temp, SMBHSTSTS);
 		if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
 			dev_err(&piix4_adapter.dev, "Failed! (%02x)\n", temp);
diff --git a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-sis5595.c
--- a/drivers/i2c/busses/i2c-sis5595.c
+++ b/drivers/i2c/busses/i2c-sis5595.c
@@ -228,7 +228,7 @@ static int sis5595_transaction(struct i2
 	/* Make sure the SMBus host is ready to start transmitting */
 	temp = sis5595_read(SMB_STS_LO) + (sis5595_read(SMB_STS_HI) << 8);
 	if (temp != 0x00) {
-		dev_dbg(&adap->dev, "SMBus busy (%04x). Resetting... \n", temp);
+		dev_dbg(&adap->dev, "SMBus busy (%04x). Resetting...\n", temp);
 		sis5595_write(SMB_STS_LO, temp & 0xff);
 		sis5595_write(SMB_STS_HI, temp >> 8);
 		if ((temp = sis5595_read(SMB_STS_LO) + (sis5595_read(SMB_STS_HI) << 8)) != 0x00) {

