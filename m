Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262724AbTCTW0C>; Thu, 20 Mar 2003 17:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262708AbTCTWZQ>; Thu, 20 Mar 2003 17:25:16 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:42501 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262705AbTCTWVk>;
	Thu, 20 Mar 2003 17:21:40 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.65
In-reply-to: <1048199573873@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Thu, 20 Mar 2003 14:32 -0800
Message-id: <1048199573405@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1143.1.13, 2003/03/20 11:16:19-08:00, greg@kroah.com

[PATCH] i2c i2c-amd8111.c: change a few printk() to dev_warn()


 drivers/i2c/busses/i2c-amd8111.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
--- a/drivers/i2c/busses/i2c-amd8111.c	Thu Mar 20 12:53:50 2003
+++ b/drivers/i2c/busses/i2c-amd8111.c	Thu Mar 20 12:53:50 2003
@@ -74,7 +74,7 @@
 		udelay(1);
 
 	if (!timeout) {
-		printk(KERN_WARNING "i2c-amd8111.c: Timeout while waiting for IBF to clear\n");
+		dev_warn(&smbus->dev->dev, "Timeout while waiting for IBF to clear\n");
 		return -1;
 	}
 
@@ -89,7 +89,7 @@
 		udelay(1);
 
 	if (!timeout) {
-		printk(KERN_WARNING "i2c-amd8111.c: Timeout while waiting for OBF to set\n");
+		dev_warn(&smbus->dev->dev, "Timeout while waiting for OBF to set\n");
 		return -1;
 	}
 
@@ -256,11 +256,11 @@
 		case I2C_SMBUS_BLOCK_DATA_PEC:
 		case I2C_SMBUS_PROC_CALL_PEC:
 		case I2C_SMBUS_BLOCK_PROC_CALL_PEC:
-			printk(KERN_WARNING "i2c-amd8111.c: Unexpected software PEC transaction %d\n.", size);
+			dev_warn(&adap->dev, "Unexpected software PEC transaction %d\n.", size);
 			return -1;
 
 		default:
-			printk(KERN_WARNING "i2c-amd8111.c: Unsupported transaction %d\n", size);
+			dev_warn(&adap->dev, "Unsupported transaction %d\n", size);
 			return -1;
 	}
 

