Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265105AbUATAMQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265101AbUATAL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:11:27 -0500
Received: from mail.kroah.org ([65.200.24.183]:19884 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265105AbUATAAD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:00:03 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
In-Reply-To: <10745567651848@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 15:59:25 -0800
Message-Id: <10745567653998@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.98.21, 2004/01/19 12:49:57-08:00, khali@linux-fr.org

[PATCH] I2C: Fix i2c-core.c with DEBUG

At the moment, i2c-core.c fails compiling with DEBUG. Following patch
should fix that.


 drivers/i2c/i2c-core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Mon Jan 19 15:29:13 2004
+++ b/drivers/i2c/i2c-core.c	Mon Jan 19 15:29:13 2004
@@ -373,7 +373,7 @@
 	}
 
 	DEB(dev_dbg(&adapter->dev, "client [%s] registered to adapter\n",
-			client->dev.name));
+			client->name));
 
 	if (client->flags & I2C_CLIENT_ALLOW_USE)
 		client->usage_count = 0;

