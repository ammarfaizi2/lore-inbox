Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbTFKUVF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 16:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264412AbTFKUVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 16:21:04 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:27886 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264363AbTFKUUz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 16:20:55 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10553638061285@kroah.com>
Subject: Re: [PATCH] More i2c driver changes for 2.5.70
In-Reply-To: <10553638061293@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 11 Jun 2003 13:36:46 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1419.1.6, 2003/06/11 12:29:21-07:00, greg@kroah.com

[PATCH] I2C: fix some errors found by sparse in include/linux/i2c.h


 include/linux/i2c.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Wed Jun 11 13:25:03 2003
+++ b/include/linux/i2c.h	Wed Jun 11 13:25:03 2003
@@ -176,7 +176,7 @@
 
 static inline void i2c_set_clientdata (struct i2c_client *dev, void *data)
 {
-	return dev_set_drvdata (&dev->dev, data);
+	dev_set_drvdata (&dev->dev, data);
 }
 
 #define I2C_DEVNAME(str)   .dev = { .name = str }
@@ -261,7 +261,7 @@
 
 static inline void i2c_set_adapdata (struct i2c_adapter *dev, void *data)
 {
-	return dev_set_drvdata (&dev->dev, data);
+	dev_set_drvdata (&dev->dev, data);
 }
 
 /*flags for the driver struct: */

