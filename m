Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263058AbUCPBWr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263021AbUCPBTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:19:00 -0500
Received: from mail.kroah.org ([65.200.24.183]:55215 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262871AbUCPADO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:03:14 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <10793913911774@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:31 -0800
Message-Id: <10793913913301@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1557.61.8, 2004/02/23 16:27:03-08:00, khali@linux-fr.org

[PATCH] I2C: fix space in message

BTW, I found something to be fixed in i2c-core:


 drivers/i2c/i2c-core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Mon Mar 15 14:37:19 2004
+++ b/drivers/i2c/i2c-core.c	Mon Mar 15 14:37:19 2004
@@ -175,7 +175,7 @@
 		driver = list_entry(item, struct i2c_driver, list);
 		if (driver->detach_adapter)
 			if ((res = driver->detach_adapter(adap))) {
-				dev_warn(&adap->dev, "can't detach adapter"
+				dev_warn(&adap->dev, "can't detach adapter "
 					 "while detaching driver %s: driver not "
 					 "detached!", driver->name);
 				goto out_unlock;

