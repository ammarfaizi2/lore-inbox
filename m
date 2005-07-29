Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262813AbVG3AWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbVG3AWW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbVG2TTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:19:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:2991 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262748AbVG2TQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:16:25 -0400
Date: Fri, 29 Jul 2005 12:15:07 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, khali@linux-fr.org
Subject: [patch 08/29] I2C: Missing space in split strings
Message-ID: <20050729191507.GJ5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>

A few split string in i2c (and now hwmon) drivers lack a joining space,
causing them to display incorrectly. This trivial patch fixes that up.
Please apply, thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/hwmon/adm1026.c       |    2 +-
 drivers/hwmon/max1619.c       |    2 +-
 drivers/hwmon/pc87360.c       |    2 +-
 drivers/i2c/busses/i2c-i801.c |    6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

--- gregkh-2.6.orig/drivers/hwmon/pc87360.c	2005-07-29 11:30:00.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/pc87360.c	2005-07-29 11:34:03.000000000 -0700
@@ -1043,7 +1043,7 @@
 	if (init >= 2 && data->innr) {
 		reg = pc87360_read_value(data, LD_IN, NO_BANK,
 					 PC87365_REG_IN_CONVRATE);
-		dev_info(&client->dev, "VLM conversion set to"
+		dev_info(&client->dev, "VLM conversion set to "
 			 "1s period, 160us delay\n");
 		pc87360_write_value(data, LD_IN, NO_BANK,
 				    PC87365_REG_IN_CONVRATE,
--- gregkh-2.6.orig/drivers/i2c/busses/i2c-i801.c	2005-07-29 11:30:00.000000000 -0700
+++ gregkh-2.6/drivers/i2c/busses/i2c-i801.c	2005-07-29 11:34:03.000000000 -0700
@@ -137,7 +137,7 @@
 		pci_read_config_word(I801_dev, SMBBA, &i801_smba);
 		i801_smba &= 0xfff0;
 		if(i801_smba == 0) {
-			dev_err(&dev->dev, "SMB base address uninitialized"
+			dev_err(&dev->dev, "SMB base address uninitialized "
 				"- upgrade BIOS or use force_addr=0xaddr\n");
 			return -ENODEV;
 		}
@@ -186,7 +186,7 @@
 	int result = 0;
 	int timeout = 0;
 
-	dev_dbg(&I801_dev->dev, "Transaction (pre): CNT=%02x, CMD=%02x,"
+	dev_dbg(&I801_dev->dev, "Transaction (pre): CNT=%02x, CMD=%02x, "
 		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT),
 		inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
 		inb_p(SMBHSTDAT1));
@@ -240,7 +240,7 @@
 		outb_p(inb(SMBHSTSTS), SMBHSTSTS);
 
 	if ((temp = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
-		dev_dbg(&I801_dev->dev, "Failed reset at end of transaction"
+		dev_dbg(&I801_dev->dev, "Failed reset at end of transaction "
 			"(%02x)\n", temp);
 	}
 	dev_dbg(&I801_dev->dev, "Transaction (post): CNT=%02x, CMD=%02x, "
--- gregkh-2.6.orig/drivers/hwmon/adm1026.c	2005-07-29 11:30:00.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/adm1026.c	2005-07-29 11:34:03.000000000 -0700
@@ -393,7 +393,7 @@
 
 	value = data->config3;
 	if (data->config3 & CFG3_GPIO16_ENABLE) {
-		dev_dbg(&client->dev, "GPIO16 enabled.  THERM"
+		dev_dbg(&client->dev, "GPIO16 enabled.  THERM "
 			"pin disabled.\n");
 	} else {
 		dev_dbg(&client->dev, "THERM pin enabled.  "
--- gregkh-2.6.orig/drivers/hwmon/max1619.c	2005-07-29 11:30:00.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/max1619.c	2005-07-29 11:34:03.000000000 -0700
@@ -363,7 +363,7 @@
 	i2c_del_driver(&max1619_driver);
 }
 
-MODULE_AUTHOR("Alexey Fisher <fishor@mail.ru> and"
+MODULE_AUTHOR("Alexey Fisher <fishor@mail.ru> and "
 	"Jean Delvare <khali@linux-fr.org>");
 MODULE_DESCRIPTION("MAX1619 sensor driver");
 MODULE_LICENSE("GPL");

--
