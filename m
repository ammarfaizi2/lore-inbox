Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272149AbTHIAcI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 20:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272152AbTHIAcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 20:32:07 -0400
Received: from mail.kroah.org ([65.200.24.183]:50367 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272149AbTHIAcE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 20:32:04 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10603891342225@kroah.com>
Subject: Re: [PATCH] More PCI fixes for 2.6.0-test2
In-Reply-To: <10603891331781@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 8 Aug 2003 17:32:14 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1119.1.2, 2003/08/06 15:41:35-07:00, greg@kroah.com

[PATCH] PCI: make eepro100 driver use pci_name() instead of dev.name.


 drivers/net/eepro100.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/net/eepro100.c b/drivers/net/eepro100.c
--- a/drivers/net/eepro100.c	Fri Aug  8 17:25:11 2003
+++ b/drivers/net/eepro100.c	Fri Aug  8 17:25:11 2003
@@ -743,7 +743,7 @@
 	if (eeprom[3] & 0x0100)
 		product = "OEM i82557/i82558 10/100 Ethernet";
 	else
-		product = pdev->dev.name;
+		product = pci_name(pdev);
 
 	printk(KERN_INFO "%s: %s, ", dev->name, product);
 

