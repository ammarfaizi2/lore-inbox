Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264053AbTJOSv6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264051AbTJOSva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:51:30 -0400
Received: from mail.kroah.org ([65.200.24.183]:59825 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263927AbTJOS0X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:26:23 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10662411473410@kroah.com>
Subject: [PATCH] More i2c driver fixes for 2.6.0-test7
In-Reply-To: <20031015180456.GA22107@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 15 Oct 2003 11:05:47 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1347.1.1, 2003/10/13 11:28:27-07:00, greg@kroah.com

[PATCH] I2C: remove unneeded MOD_INC and MOD_DEC calls.


 drivers/i2c/algos/i2c-algo-ite.c |    7 -------
 1 files changed, 7 deletions(-)


diff -Nru a/drivers/i2c/algos/i2c-algo-ite.c b/drivers/i2c/algos/i2c-algo-ite.c
--- a/drivers/i2c/algos/i2c-algo-ite.c	Wed Oct 15 10:58:15 2003
+++ b/drivers/i2c/algos/i2c-algo-ite.c	Wed Oct 15 10:58:15 2003
@@ -779,10 +779,6 @@
 	adap->retries = 3;		/* be replaced by defines	*/
 	adap->flags = 0;
 
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
-
 	i2c_add_adapter(adap);
 	iic_init(iic_adap);
 
@@ -815,9 +811,6 @@
 		return res;
 	DEB2(printk("i2c-algo-ite: adapter unregistered: %s\n",adap->name));
 
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
 	return 0;
 }
 

