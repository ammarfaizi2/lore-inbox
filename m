Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbVG2UGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbVG2UGl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 16:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbVG2TTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:19:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:3247 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262753AbVG2TQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:16:25 -0400
Date: Fri, 29 Jul 2005 12:15:29 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, khali@linux-fr.org
Subject: [patch 10/29] I2C: missing new lines in i2c-core messages
Message-ID: <20050729191529.GL5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>

Two log messages lack their trailing new line in i2c-core. I'd swear I had
fixed them already, but it seems not. Bonus: improved coding style.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/i2c/i2c-core.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- gregkh-2.6.orig/drivers/i2c/i2c-core.c	2005-07-29 11:29:59.000000000 -0700
+++ gregkh-2.6/drivers/i2c/i2c-core.c	2005-07-29 11:34:04.000000000 -0700
@@ -231,8 +231,8 @@
 		if (driver->detach_adapter)
 			if ((res = driver->detach_adapter(adap))) {
 				dev_warn(&adap->dev, "can't detach adapter "
-					 "while detaching driver %s: driver not "
-					 "detached!", driver->name);
+					 "while detaching driver %s: driver "
+					 "not detached!\n", driver->name);
 				goto out_unlock;
 			}
 	}
@@ -456,8 +456,8 @@
 		res = adapter->client_unregister(client);
 		if (res) {
 			dev_err(&client->dev,
-			       "client_unregister [%s] failed, "
-			       "client not detached", client->name);
+				"client_unregister [%s] failed, "
+				"client not detached\n", client->name);
 			goto out;
 		}
 	}

--
