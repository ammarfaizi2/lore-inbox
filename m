Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263253AbVCDVXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263253AbVCDVXy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 16:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263238AbVCDVTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 16:19:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:64673 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263153AbVCDUy3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:29 -0500
Cc: stefan@desire.ch
Subject: [PATCH] I2C: fix for fscpos voltage values
In-Reply-To: <11099685944086@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:34 -0800
Message-Id: <11099685943850@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2089, 2005/03/02 11:59:41-08:00, stefan@desire.ch

[PATCH] I2C: fix for fscpos voltage values

Multiplied the voltage multipliers by 10 in order to comply with the sysfs
guidelines.

Signed-off-by: Stefan Ott <stefan@desire.ch>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/fscpos.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/chips/fscpos.c b/drivers/i2c/chips/fscpos.c
--- a/drivers/i2c/chips/fscpos.c	2005-03-04 12:25:44 -08:00
+++ b/drivers/i2c/chips/fscpos.c	2005-03-04 12:25:44 -08:00
@@ -244,19 +244,19 @@
 static ssize_t show_volt_12(struct device *dev, char *buf)
 {
 	struct fscpos_data *data = fscpos_update_device(dev);
-	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[0], 1420));
+	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[0], 14200));
 }
 
 static ssize_t show_volt_5(struct device *dev, char *buf)
 {
 	struct fscpos_data *data = fscpos_update_device(dev);
-	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[1], 660));
+	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[1], 6600));
 }
 
 static ssize_t show_volt_batt(struct device *dev, char *buf)
 {
 	struct fscpos_data *data = fscpos_update_device(dev);
-	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[2], 330));
+	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[2], 3300));
 }
 
 /* Watchdog */

