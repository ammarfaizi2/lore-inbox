Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267375AbUHWTWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267375AbUHWTWP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267442AbUHWTV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:21:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:1732 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267232AbUHWSgs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:48 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860862720@kroah.com>
Date: Mon, 23 Aug 2004 11:34:46 -0700
Message-Id: <10932860863161@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.22, 2004/08/06 12:42:19-07:00, akpm@osdl.org

[PATCH] I2C: scx200_i2c build fix

drivers/i2c/busses/scx200_i2c.c: In function `__check_scl':
drivers/i2c/busses/scx200_i2c.c:41: `scl' undeclared (first use in this function)
drivers/i2c/busses/scx200_i2c.c:41: (Each undeclared identifier is reported only once


Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/scx200_i2c.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/busses/scx200_i2c.c b/drivers/i2c/busses/scx200_i2c.c
--- a/drivers/i2c/busses/scx200_i2c.c	2004-08-23 11:04:30 -07:00
+++ b/drivers/i2c/busses/scx200_i2c.c	2004-08-23 11:04:30 -07:00
@@ -38,13 +38,13 @@
 MODULE_DESCRIPTION("NatSemi SCx200 I2C Driver");
 MODULE_LICENSE("GPL");
 
+static int scl = CONFIG_SCx200_I2C_SCL;
+static int sda = CONFIG_SCx200_I2C_SDA;
+
 module_param(scl, int, 0);
 MODULE_PARM_DESC(scl, "GPIO line for SCL");
 module_param(sda, int, 0);
 MODULE_PARM_DESC(sda, "GPIO line for SDA");
-
-static int scl = CONFIG_SCx200_I2C_SCL;
-static int sda = CONFIG_SCx200_I2C_SDA;
 
 static void scx200_i2c_setscl(void *data, int state)
 {

