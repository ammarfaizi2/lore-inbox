Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265140AbUATARF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264445AbUATAPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:15:43 -0500
Received: from mail.kroah.org ([65.200.24.183]:28588 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265152AbUATAAL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:00:11 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
In-Reply-To: <10745567584195@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 15:59:19 -0800
Message-Id: <10745567592337@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.98.5, 2004/01/14 11:12:07-08:00, ebs@ebshome.net

[PATCH] I2C: IBM IIC compile fix

please apply this trivial one-liner. It fixes compilation of IBM IIC
driver.


 drivers/i2c/busses/i2c-ibm_iic.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
--- a/drivers/i2c/busses/i2c-ibm_iic.c	Mon Jan 19 15:32:37 2004
+++ b/drivers/i2c/busses/i2c-ibm_iic.c	Mon Jan 19 15:32:37 2004
@@ -601,7 +601,7 @@
 	
 	/* Register it with i2c layer */
 	adap = &dev->adap;
-	strcpy(adap->dev.name, "IBM IIC");
+	strcpy(adap->name, "IBM IIC");
 	i2c_set_adapdata(adap, dev);
 	adap->id = I2C_HW_OCP | iic_algo.id;
 	adap->algo = &iic_algo;

