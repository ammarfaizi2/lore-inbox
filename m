Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbULAASg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbULAASg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 19:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbULAAPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:15:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:32996 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261188AbULAAOO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:14:14 -0500
Subject: Re: [PATCH] I2C fixes for 2.6.10-rc2
In-Reply-To: <11018600192512@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Nov 2004 16:13:39 -0800
Message-Id: <1101860019530@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2223.2.8, 2004/11/24 14:34:51-08:00, greg@kroah.com

[PATCH] I2C: make fixup_fan_min static in adm1026 driver.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/adm1026.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/adm1026.c b/drivers/i2c/chips/adm1026.c
--- a/drivers/i2c/chips/adm1026.c	2004-11-30 16:00:48 -08:00
+++ b/drivers/i2c/chips/adm1026.c	2004-11-30 16:00:48 -08:00
@@ -914,7 +914,7 @@
 fan_offset(8);
 
 /* Adjust fan_min to account for new fan divisor */
-void fixup_fan_min(struct device *dev, int fan, int old_div)
+static void fixup_fan_min(struct device *dev, int fan, int old_div)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);

