Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261699AbTCVA4F>; Fri, 21 Mar 2003 19:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261706AbTCVAzu>; Fri, 21 Mar 2003 19:55:50 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:59656 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261699AbTCVAxx>;
	Fri, 21 Mar 2003 19:53:53 -0500
Subject: Re: [PATCH] More i2c driver changes for 2.5.65
In-reply-to: <10482950873871@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Fri, 21 Mar 2003 17:04 -0800
Message-id: <10482950921680@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1195, 2003/03/21 16:39:04-08:00, greg@kroah.com

[PATCH] i2c: fix up the chip driver names to play nice with sysfs


 drivers/i2c/chips/adm1021.c |    2 +-
 drivers/i2c/chips/lm75.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Fri Mar 21 16:52:40 2003
+++ b/drivers/i2c/chips/adm1021.c	Fri Mar 21 16:52:40 2003
@@ -144,7 +144,7 @@
 /* This is the driver that will be inserted */
 static struct i2c_driver adm1021_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "ADM1021, MAX1617 sensor driver",
+	.name		= "ADM1021-MAX1617",
 	.id		= I2C_DRIVERID_ADM1021,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= adm1021_attach_adapter,
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Fri Mar 21 16:52:40 2003
+++ b/drivers/i2c/chips/lm75.c	Fri Mar 21 16:52:40 2003
@@ -82,7 +82,7 @@
 /* This is the driver that will be inserted */
 static struct i2c_driver lm75_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "LM75 sensor chip driver",
+	.name		= "LM75 sensor",
 	.id		= I2C_DRIVERID_LM75,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm75_attach_adapter,

