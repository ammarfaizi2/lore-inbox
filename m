Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263200AbVCDVAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263200AbVCDVAQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 16:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbVCDU6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 15:58:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:8610 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263165AbVCDUye convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:34 -0500
Cc: ben-linux@fluff.org
Subject: [PATCH] I2C: S3C2410 missing I2C_CLASS_HWMON
In-Reply-To: <11099685961021@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:37 -0800
Message-Id: <11099685971397@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2109, 2005/03/02 15:02:43-08:00, ben-linux@fluff.org

[PATCH] I2C: S3C2410 missing I2C_CLASS_HWMON

None of the standard sensor drivers currently recognise the s3c24xx
I2C controller as it does not have I2C_CLASS_HWMON set in the
adapter class field.

The attached patch initialises the adapter class to I2C_CLASS_HWMON

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/busses/i2c-s3c2410.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
--- a/drivers/i2c/busses/i2c-s3c2410.c	2005-03-04 12:23:28 -08:00
+++ b/drivers/i2c/busses/i2c-s3c2410.c	2005-03-04 12:23:28 -08:00
@@ -569,6 +569,7 @@
 		.name			= "s3c2410-i2c",
 		.algo			= &s3c24xx_i2c_algorithm,
 		.retries		= 2,
+		.class			= I2C_CLASS_HWMON,
 	},
 };
 

