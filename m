Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264134AbUE1WIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbUE1WIq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 18:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264131AbUE1WIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 18:08:43 -0400
Received: from mail.kroah.org ([65.200.24.183]:34238 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264061AbUE1WB3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 18:01:29 -0400
Subject: Re: [PATCH] I2C update for 2.6.7-rc1
In-Reply-To: <1085781643301@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 28 May 2004 15:00:43 -0700
Message-Id: <10857816431154@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1717.6.27, 2004/05/19 00:26:13-07:00, ebs@ebshome.net

[PATCH] I2C PPC4xx IIC driver: fix debug build with gcc3

this patch fixes PPC4xx IIC driver debug mode build with gcc 3.x compiler.
Noticed by Evgenij Polyakov.


 drivers/i2c/busses/i2c-ibm_iic.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
--- a/drivers/i2c/busses/i2c-ibm_iic.c	Fri May 28 14:52:17 2004
+++ b/drivers/i2c/busses/i2c-ibm_iic.c	Fri May 28 14:52:17 2004
@@ -69,14 +69,14 @@
 #endif
 
 #if DBG_LEVEL > 0
-#  define DBG(x...)	printk(KERN_DEBUG "ibm-iic" ##x)
+#  define DBG(f,x...)	printk(KERN_DEBUG "ibm-iic" f, ##x)
 #else
-#  define DBG(x...)	((void)0)
+#  define DBG(f,x...)	((void)0)
 #endif
 #if DBG_LEVEL > 1
-#  define DBG2(x...) 	DBG( ##x )
+#  define DBG2(f,x...) 	DBG(f, ##x)
 #else
-#  define DBG2(x...) 	((void)0)
+#  define DBG2(f,x...) 	((void)0)
 #endif
 #if DBG_LEVEL > 2
 static void dump_iic_regs(const char* header, struct ibm_iic_private* dev)

