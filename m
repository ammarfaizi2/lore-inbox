Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbVAHFrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVAHFrx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 00:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVAHFrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 00:47:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:12421 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261795AbVAHFrv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:47:51 -0500
Subject: [PATCH] I2C patches for 2.6.10
In-Reply-To: <20050108053849.GA8065@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:39:33 -0800
Message-Id: <11051627732623@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.44, 2005/01/06 13:53:47-08:00, mhoffman@lightlink.com

[PATCH] I2C: probe fewer addresses for asb100 (sensors) driver

This patch limits SMBus scanning for the asb100 sensor chip
to just one address - the only one we've ever seen in practice.

Signed-off-by Mark M. Hoffman <mhoffman@lightlink.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/asb100.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)


diff -Nru a/drivers/i2c/chips/asb100.c b/drivers/i2c/chips/asb100.c
--- a/drivers/i2c/chips/asb100.c	2005-01-07 14:54:56 -08:00
+++ b/drivers/i2c/chips/asb100.c	2005-01-07 14:54:56 -08:00
@@ -56,8 +56,7 @@
 #define ASB100_VERSION "1.0.0"
 
 /* I2C addresses to scan */
-static unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
-					0x2e, 0x2f, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x2d, I2C_CLIENT_END };
 
 /* ISA addresses to scan (none) */
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };

