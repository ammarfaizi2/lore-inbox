Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbTEGATM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 20:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbTEGATM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 20:19:12 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:14209 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262073AbTEGATK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 20:19:10 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10522676153273@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.69
In-Reply-To: <1052267615125@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 6 May 2003 17:33:35 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1085, 2003/05/06 17:18:27-07:00, greg@kroah.com

[PATCH] i2c: fix compile error due to previous patches.


 drivers/i2c/i2c-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Tue May  6 17:24:28 2003
+++ b/drivers/i2c/i2c-core.c	Tue May  6 17:24:28 2003
@@ -309,8 +309,8 @@
 		}
 	}
 
-	DEB(dev_dbg(&adapter->dev, "client [%s] registered to adapter "
-			"(pos. %d).\n", client->dev.name, i));
+	DEB(dev_dbg(&adapter->dev, "client [%s] registered to adapter\n",
+			client->dev.name));
 
 	if (client->flags & I2C_CLIENT_ALLOW_USE)
 		client->usage_count = 0;

