Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270757AbTHOSqx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 14:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270751AbTHOSes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:34:48 -0400
Received: from mail.kroah.org ([65.200.24.183]:55428 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270756AbTHOSdM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:33:12 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1060972406359@kroah.com>
Subject: Re: [PATCH] i2c driver changes 2.6.0-test3
In-Reply-To: <1060972405413@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 15 Aug 2003 11:33:26 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1123.18.3, 2003/08/11 14:36:57-07:00, greg@kroah.com

[PATCH] i2c: fix up "raw" printk() call.


 drivers/i2c/busses/i2c-piix4.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Fri Aug 15 11:27:05 2003
+++ b/drivers/i2c/busses/i2c-piix4.c	Fri Aug 15 11:27:05 2003
@@ -164,7 +164,7 @@
 	/* Some BIOS will set up the chipset incorrectly and leave a register
 	   in an undefined state (causing I2C to act very strangely). */
 	if (temp & 0x02) {
-		printk("Fixed I2C problem on Force CPCI735\n");
+		dev_info(&PIIX4_dev->dev, "Fixed I2C problem on Force CPCI735\n");
 		temp = temp & 0xfd;
 		pci_write_config_byte(PIIX4_dev, SMBHSTCFG, temp);
 	}

