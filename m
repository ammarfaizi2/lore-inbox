Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265833AbTL3WG3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265834AbTL3WG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:06:29 -0500
Received: from mail.kroah.org ([65.200.24.183]:42689 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265833AbTL3WGX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:06:23 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.0
In-Reply-To: <1072821975626@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Dec 2003 14:06:15 -0800
Message-Id: <10728219753853@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1496.9.7, 2003/12/04 13:53:58-08:00, khali@linux-fr.org

[PATCH] I2C: add KT600 support to i2c-viapro driver

This patch adds support for the KT600 to the i2c-viapro driver. It was
confirmed to work by Lou, lm-sensors at fixit dot nospammail dot net in
this post:
http://archives.andrew.net.au/lm-sensors/msg05299.html


 drivers/i2c/busses/Kconfig      |    1 +
 drivers/i2c/busses/i2c-viapro.c |    8 ++++++++
 2 files changed, 9 insertions(+)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Tue Dec 30 12:31:28 2003
+++ b/drivers/i2c/busses/Kconfig	Tue Dec 30 12:31:28 2003
@@ -310,6 +310,7 @@
 	  8233
 	  8233A
 	  8235
+	  8237
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-viapro.
diff -Nru a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
--- a/drivers/i2c/busses/i2c-viapro.c	Tue Dec 30 12:31:28 2003
+++ b/drivers/i2c/busses/i2c-viapro.c	Tue Dec 30 12:31:28 2003
@@ -29,6 +29,7 @@
 	8233
 	8233A (0x3147 and 0x3177)
 	8235
+	8237
    Note: we assume there can only be one device, with one SMBus interface.
 */
 
@@ -430,6 +431,13 @@
 	{
 		.vendor		= PCI_VENDOR_ID_VIA,
 		.device 	= PCI_DEVICE_ID_VIA_8235,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= SMBBA3
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_VIA,
+		.device 	= PCI_DEVICE_ID_VIA_8237,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.driver_data	= SMBBA3

