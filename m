Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263219AbVCDVXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbVCDVXu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 16:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbVCDVFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 16:05:41 -0500
Received: from mail.kroah.org ([69.55.234.183]:16034 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263162AbVCDUyh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:37 -0500
Cc: greg@kroah.com
Subject: [PATCH] I2C: Fix up some build warnings in the fscpos driver.
In-Reply-To: <1109968592905@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:33 -0800
Message-Id: <11099685931959@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2082, 2005/03/02 11:51:21-08:00, greg@kroah.com

[PATCH] I2C: Fix up some build warnings in the fscpos driver.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/fscpos.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)


diff -Nru a/drivers/i2c/chips/fscpos.c b/drivers/i2c/chips/fscpos.c
--- a/drivers/i2c/chips/fscpos.c	2005-03-04 12:26:32 -08:00
+++ b/drivers/i2c/chips/fscpos.c	2005-03-04 12:26:32 -08:00
@@ -51,8 +51,6 @@
  * The FSCPOS registers
  */
 
-#define DEBUG
-
 /* chip identification */
 #define FSCPOS_REG_IDENT_0		0x00
 #define FSCPOS_REG_IDENT_1		0x01
@@ -566,10 +564,10 @@
 
 	if ((jiffies - data->last_updated > 2 * HZ) ||
 			(jiffies < data->last_updated) || !data->valid) {
+		int i;
 
 		dev_dbg(&client->dev, "Starting fscpos update\n");
 
-		int i;
 		for (i = 0; i < 3; i++) {
 			data->temp_act[i] = fscpos_read_value(client,
 						FSCPOS_REG_TEMP_ACT[i]);

