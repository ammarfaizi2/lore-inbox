Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264096AbUE1WIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264096AbUE1WIh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 18:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264103AbUE1WIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 18:08:21 -0400
Received: from mail.kroah.org ([65.200.24.183]:35006 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264096AbUE1WBa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 18:01:30 -0400
Subject: Re: [PATCH] I2C update for 2.6.7-rc1
In-Reply-To: <10857816433753@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 28 May 2004 15:00:43 -0700
Message-Id: <1085781643301@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1717.6.26, 2004/05/19 00:25:54-07:00, ebs@ebshome.net

[PATCH] I2C PPC4xx IIC driver: Kconfig cleanup

this patch renames Kconfig entry for PPC4xx IIC driver making it more clear and
also adds a help text.


 drivers/i2c/busses/Kconfig |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Fri May 28 14:52:22 2004
+++ b/drivers/i2c/busses/Kconfig	Fri May 28 14:52:22 2004
@@ -118,8 +118,14 @@
 	  will be called i2c-i810.
 
 config I2C_IBM_IIC
-	tristate "IBM IIC I2C"
+	tristate "IBM PPC 4xx on-chip I2C interface"
 	depends on IBM_OCP && I2C
+	help
+	  Say Y here if you want to use IIC peripheral found on 
+	  embedded IBM PPC 4xx based systems. 
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-ibm_iic.
 
 config I2C_IOP3XX
 	tristate "Intel XScale IOP3xx on-chip I2C interface"

