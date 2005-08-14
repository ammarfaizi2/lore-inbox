Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbVHNPQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbVHNPQg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 11:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbVHNPQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 11:16:36 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:9484 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932547AbVHNPQg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 11:16:36 -0400
Date: Sun, 14 Aug 2005 17:17:16 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] (5/5) I2C updates for 2.4.32-pre3
Message-Id: <20050814171716.099b8f55.khali@linux-fr.org>
In-Reply-To: <20050814151320.76e906d5.khali@linux-fr.org>
References: <20050814151320.76e906d5.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Five log messages lack their trailing new line in i2c-core.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/i2c-core.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

--- linux-2.4.31.orig/drivers/i2c/i2c-core.c	2005-04-09 12:35:59.000000000 +0200
+++ linux-2.4.31/drivers/i2c/i2c-core.c	2005-07-28 19:29:25.000000000 +0200
@@ -208,7 +208,7 @@
 			if ((res = drivers[j]->attach_adapter(adap))) {
 				printk(KERN_WARNING "i2c-core.o: can't detach adapter %s "
 				       "while detaching driver %s: driver not "
-				       "detached!",adap->name,drivers[j]->name);
+				       "detached!\n", adap->name, drivers[j]->name);
 				goto ERROR1;	
 			}
 	DRV_UNLOCK();
@@ -226,7 +226,7 @@
 			if ((res=client->driver->detach_client(client))) {
 				printk(KERN_ERR "i2c-core.o: adapter %s not "
 					"unregistered, because client at "
-					"address %02x can't be detached. ",
+					"address %02x can't be detached\n",
 					adap->name, client->addr);
 				goto ERROR0;
 			}
@@ -339,7 +339,7 @@
 				printk(KERN_WARNING "i2c-core.o: while unregistering "
 				       "dummy driver %s, adapter %s could "
 				       "not be detached properly; driver "
-				       "not unloaded!",driver->name,
+				       "not unloaded!\n", driver->name,
 				       adap->name);
 				ADAP_UNLOCK();
 				return res;
@@ -361,7 +361,7 @@
 						       "address %02x of "
 						       "adapter `%s' could not"
 						       "be detached; driver"
-						       "not unloaded!",
+						       "not unloaded!\n",
 						       driver->name,
 						       client->addr,
 						       adap->name);
@@ -448,7 +448,7 @@
 	if (adapter->client_unregister != NULL) 
 		if ((res = adapter->client_unregister(client))) {
 			printk(KERN_ERR "i2c-core.o: client_unregister [%s] failed, "
-			       "client not detached",client->name);
+			       "client not detached\n", client->name);
 			return res;
 		}
 

-- 
Jean Delvare
