Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265377AbUBIXXO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265375AbUBIXXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:23:03 -0500
Received: from mail.kroah.org ([65.200.24.183]:51899 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265377AbUBIXTk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:19:40 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.3-rc1
In-Reply-To: <10763687753019@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:19:35 -0800
Message-Id: <10763687752678@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.11.6, 2004/02/03 17:01:31-08:00, greg@kroah.com

[PATCH] I2C: fix oops when CONFIG_I2C_DEBUG_CORE is enabled and the bttv driver is loaded.


 drivers/i2c/i2c-core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Mon Feb  9 15:05:46 2004
+++ b/drivers/i2c/i2c-core.c	Mon Feb  9 15:05:46 2004
@@ -598,7 +598,7 @@
 		ret = adap->algo->master_xfer(adap,&msg,1);
 		up(&adap->bus_lock);
 	
-		dev_dbg(&client->dev, "master_recv: return:%d (count:%d, addr:0x%02x)\n",
+		dev_dbg(&client->adapter->dev, "master_recv: return:%d (count:%d, addr:0x%02x)\n",
 			ret, count, client->addr);
 	
 		/* if everything went ok (i.e. 1 msg transmitted), return #bytes

