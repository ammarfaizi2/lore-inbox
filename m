Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWCaKF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWCaKF7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 05:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWCaKFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 05:05:34 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:12845 "EHLO
	linux") by vger.kernel.org with ESMTP id S932071AbWCaKEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 05:04:45 -0500
Message-Id: <20060331100423.881481000@towertech.it>
References: <20060331100423.175139000@towertech.it>
User-Agent: quilt/0.43-1
Date: Fri, 31 Mar 2006 12:04:27 +0200
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au, akpm@osdl.org
Subject: [PATCH 04/10] RTC subsystem, whitespaces and error messages cleanup
Content-Disposition: inline; filename=rtc-subsys-tidy.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - fixed whitespaces
 - removed some debugging in excess

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>

---
 drivers/rtc/rtc-m48t86.c  |    2 +-
 drivers/rtc/rtc-pcf8563.c |    2 --
 drivers/rtc/rtc-rs5c372.c |    3 ---
 drivers/rtc/rtc-x1205.c   |    3 ---
 4 files changed, 1 insertion(+), 9 deletions(-)

--- linux-rtc.orig/drivers/rtc/rtc-x1205.c	2006-03-29 02:33:58.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-x1205.c	2006-03-29 03:12:07.000000000 +0200
@@ -498,7 +498,6 @@ static DEVICE_ATTR(dtrim, S_IRUGO, x1205
 
 static int x1205_attach(struct i2c_adapter *adapter)
 {
-	dev_dbg(&adapter->dev, "%s\n", __FUNCTION__);
 	return i2c_probe(adapter, &addr_data, x1205_probe);
 }
 
@@ -587,8 +586,6 @@ static int x1205_detach(struct i2c_clien
 	int err;
 	struct rtc_device *rtc = i2c_get_clientdata(client);
 
-	dev_dbg(&client->dev, "%s\n", __FUNCTION__);
-
  	if (rtc)
 		rtc_device_unregister(rtc);
 
--- linux-rtc.orig/drivers/rtc/rtc-rs5c372.c	2006-03-29 02:47:17.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-rs5c372.c	2006-03-29 03:12:07.000000000 +0200
@@ -193,7 +193,6 @@ static DEVICE_ATTR(osc, S_IRUGO, rs5c372
 
 static int rs5c372_attach(struct i2c_adapter *adapter)
 {
-	dev_dbg(&adapter->dev, "%s\n", __FUNCTION__);
 	return i2c_probe(adapter, &addr_data, rs5c372_probe);
 }
 
@@ -260,8 +259,6 @@ static int rs5c372_detach(struct i2c_cli
 	int err;
 	struct rtc_device *rtc = i2c_get_clientdata(client);
 
-	dev_dbg(&client->dev, "%s\n", __FUNCTION__);
-
 	if (rtc)
 		rtc_device_unregister(rtc);
 
--- linux-rtc.orig/drivers/rtc/rtc-pcf8563.c	2006-03-29 02:47:17.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-pcf8563.c	2006-03-29 03:12:07.000000000 +0200
@@ -321,8 +321,6 @@ static int pcf8563_detach(struct i2c_cli
 	int err;
 	struct rtc_device *rtc = i2c_get_clientdata(client);
 
-	dev_dbg(&client->dev, "%s\n", __FUNCTION__);
-
 	if (rtc)
 		rtc_device_unregister(rtc);
 
--- linux-rtc.orig/drivers/rtc/rtc-m48t86.c	2006-03-29 02:47:17.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-m48t86.c	2006-03-29 03:12:07.000000000 +0200
@@ -23,7 +23,7 @@
 #define M48T86_REG_SECALRM	0x01
 #define M48T86_REG_MIN		0x02
 #define M48T86_REG_MINALRM	0x03
-#define M48T86_REG_HOUR	0x04
+#define M48T86_REG_HOUR		0x04
 #define M48T86_REG_HOURALRM	0x05
 #define M48T86_REG_DOW		0x06 /* 1 = sunday */
 #define M48T86_REG_DOM		0x07

--
