Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264023AbTFJVDp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbTFJVDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:03:15 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:63150 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263848AbTFJShK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:10 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709641098@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709641165@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:24 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1321, 2003/06/09 15:31:49-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/char/epca.c


 drivers/char/epca.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)


diff -Nru a/drivers/char/epca.c b/drivers/char/epca.c
--- a/drivers/char/epca.c	Tue Jun 10 11:22:18 2003
+++ b/drivers/char/epca.c	Tue Jun 10 11:22:18 2003
@@ -1639,16 +1639,9 @@
 	--------------------------------------------------------------------- */
   
 	pci_boards_found = 0;
-	if (pci_present())
-	{
-		if(num_cards < MAXBOARDS)
-			pci_boards_found += init_PCI();
-		num_cards += pci_boards_found;
-	}
-	else 
-	{
-		printk(KERN_ERR "<Error> - No PCI BIOS found\n");
-	}
+	if(num_cards < MAXBOARDS)
+		pci_boards_found += init_PCI();
+	num_cards += pci_boards_found;
 
 #endif /* ENABLE_PCI */
 

