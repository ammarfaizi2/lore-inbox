Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265374AbUBIXy7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265373AbUBIXUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:20:15 -0500
Received: from mail.kroah.org ([65.200.24.183]:49595 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265374AbUBIXTh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:19:37 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.3-rc1
In-Reply-To: <10763687741075@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:19:35 -0800
Message-Id: <10763687754014@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.11.3, 2004/02/02 14:51:45-08:00, khali@linux-fr.org

[PATCH] I2C: Bring w83l785ts in compliance with sysfs naming conventions

Here is a patch that brings the w83l785ts driver in compliance with
sysfs naming conventions. This is pretty much the same problem and
solution that occured very recently with the lm75 and lm78 drivers.

The patch was tested to work fine by James Bolt.


 drivers/i2c/chips/w83l785ts.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/chips/w83l785ts.c b/drivers/i2c/chips/w83l785ts.c
--- a/drivers/i2c/chips/w83l785ts.c	Mon Feb  9 15:05:59 2004
+++ b/drivers/i2c/chips/w83l785ts.c	Mon Feb  9 15:05:59 2004
@@ -137,8 +137,8 @@
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_over));
 }
 
-static DEVICE_ATTR(temp_input, S_IRUGO, show_temp, NULL)
-static DEVICE_ATTR(temp_max, S_IRUGO, show_temp_over, NULL)
+static DEVICE_ATTR(temp_input1, S_IRUGO, show_temp, NULL)
+static DEVICE_ATTR(temp_max1, S_IRUGO, show_temp_over, NULL)
 
 /*
  * Real code
@@ -249,8 +249,8 @@
 	 */
 
 	/* Register sysfs hooks */
-	device_create_file(&new_client->dev, &dev_attr_temp_input);
-	device_create_file(&new_client->dev, &dev_attr_temp_max);
+	device_create_file(&new_client->dev, &dev_attr_temp_input1);
+	device_create_file(&new_client->dev, &dev_attr_temp_max1);
 
 	return 0;
 

