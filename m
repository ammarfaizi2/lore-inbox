Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266817AbUHWTxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266817AbUHWTxB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266819AbUHWTwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:52:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:43971 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266817AbUHWSgQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:16 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860841820@kroah.com>
Date: Mon, 23 Aug 2004 11:34:44 -0700
Message-Id: <1093286084674@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.54.6, 2004/08/02 16:10:33-07:00, amalysh@web.de

[PATCH] I2C: new device for sis630

this patch adds SiS 1039:0018 to PCI device list of sis630.c. This is needed,
due to changes in pci quirks that cause sis630/sis730 LPC to change id from
008 -> 0018. This patch doesn't have any side effects, because i2c-sis630
checks for supported devices.


Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-sis630.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
--- a/drivers/i2c/busses/i2c-sis630.c	2004-08-23 11:07:14 -07:00
+++ b/drivers/i2c/busses/i2c-sis630.c	2004-08-23 11:07:14 -07:00
@@ -464,6 +464,7 @@
 
 static struct pci_device_id sis630_ids[] __devinitdata = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_503) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_LPC) },
 	{ 0, }
 };
 

