Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265059AbUATACH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbUATACE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:02:04 -0500
Received: from mail.kroah.org ([65.200.24.183]:14252 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265059AbUASX75 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 18:59:57 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
In-Reply-To: <10745567623125@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 15:59:23 -0800
Message-Id: <1074556763176@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.98.12, 2004/01/14 11:44:33-08:00, khali@linux-fr.org

[PATCH] I2C: Fix debug bug in lm83 driver

The following patch fixes lm83 failing to compile if DEBUG is set.


 drivers/i2c/chips/lm83.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/lm83.c b/drivers/i2c/chips/lm83.c
--- a/drivers/i2c/chips/lm83.c	Mon Jan 19 15:31:08 2004
+++ b/drivers/i2c/chips/lm83.c	Mon Jan 19 15:31:08 2004
@@ -270,7 +270,7 @@
 		    & 0x48) != 0x00) ||
 		    ((i2c_smbus_read_byte_data(new_client, LM83_REG_R_CONFIG)
 		    & 0x41) != 0x00)) {
-			dev_dbg(&client->dev,
+			dev_dbg(&adapter->dev,
 			    "LM83 detection failed at 0x%02x.\n", address);
 			goto exit_free;
 		}

