Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTESXCV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 19:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbTESW5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 18:57:53 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:15094 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263305AbTESW5i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 18:57:38 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10533859472025@kroah.com>
Subject: [PATCH] Yet more i2c driver changes for 2.5.69
In-Reply-To: <20030519231156.GA27535@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 May 2003 16:12:27 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1093.2.1, 2003/05/13 12:33:20-07:00, greg@kroah.com

[PATCH] i2c: piix4 driver: turn common error message to a debug level and rename the sysfs driver name.


 drivers/i2c/busses/i2c-piix4.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Mon May 19 15:59:14 2003
+++ b/drivers/i2c/busses/i2c-piix4.c	Mon May 19 15:59:14 2003
@@ -269,7 +269,7 @@
 
 	if (temp & 0x04) {
 		result = -1;
-		dev_err(&piix4_adapter.dev, "Error: no response!\n");
+		dev_dbg(&piix4_adapter.dev, "Error: no response!\n");
 	}
 
 	if (inb_p(SMBHSTSTS) != 0x00)
@@ -467,7 +467,7 @@
 
 
 static struct pci_driver piix4_driver = {
-	.name		= "piix4 smbus",
+	.name		= "piix4-smbus",
 	.id_table	= piix4_ids,
 	.probe		= piix4_probe,
 	.remove		= __devexit_p(piix4_remove),

