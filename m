Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTFJVig (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbTFJVg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:36:58 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:19612 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263152AbTFJSg7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:36:59 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709651073@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709651054@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:25 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1330, 2003/06/09 15:37:14-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/i2c/i2c-elektor.c


 drivers/i2c/i2c-elektor.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/i2c-elektor.c b/drivers/i2c/i2c-elektor.c
--- a/drivers/i2c/i2c-elektor.c	Tue Jun 10 11:21:36 2003
+++ b/drivers/i2c/i2c-elektor.c	Tue Jun 10 11:21:36 2003
@@ -188,7 +188,7 @@
 #ifdef __alpha__
 	/* check to see we have memory mapped PCF8584 connected to the 
 	Cypress cy82c693 PCI-ISA bridge as on UP2000 board */
-	if ((base == 0) && pci_present()) {
+	if (base == 0) {
 		
 		struct pci_dev *cy693_dev =
                     pci_find_device(PCI_VENDOR_ID_CONTAQ, 

