Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265128AbUATAMP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265218AbUATALs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:11:48 -0500
Received: from mail.kroah.org ([65.200.24.183]:21932 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265128AbUATAAE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:00:04 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
In-Reply-To: <10745567643254@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 15:59:25 -0800
Message-Id: <10745567651848@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.98.20, 2004/01/19 12:49:37-08:00, khali@linux-fr.org

[PATCH] I2C: Fix lm90.c with DEBUG

The recent patch that fixes lm83.c with DEBUG also applies to lm90.c. No
wonder since I used the first as a template when porting the second.
Patch follows.


 drivers/i2c/chips/lm90.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c	Mon Jan 19 15:29:26 2004
+++ b/drivers/i2c/chips/lm90.c	Mon Jan 19 15:29:26 2004
@@ -320,8 +320,8 @@
 
 		if ((reg_config1 & 0x2A) != 0x00
 		 || reg_convrate > 0x0A) {
-			dev_dbg(&client->dev,
-				"LM90 detection failed at 0x%02x.\n"
+			dev_dbg(&adapter->dev,
+				"LM90 detection failed at 0x%02x.\n",
 				address);
 			goto exit_free;
 		}

