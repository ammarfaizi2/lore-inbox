Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbTFJUsl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbTFJUro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:47:44 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:10415 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263922AbTFJShQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:16 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709653253@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <105527096525@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:25 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1332, 2003/06/09 15:38:24-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/isdn/eicon/Divas_mod.c


 drivers/isdn/eicon/Divas_mod.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)


diff -Nru a/drivers/isdn/eicon/Divas_mod.c b/drivers/isdn/eicon/Divas_mod.c
--- a/drivers/isdn/eicon/Divas_mod.c	Tue Jun 10 11:21:26 2003
+++ b/drivers/isdn/eicon/Divas_mod.c	Tue Jun 10 11:21:26 2003
@@ -50,17 +50,9 @@
 
 	DivasInitDpc();
 
-	if (pci_present())
+	if (DivasCardsDiscover() < 0)
 	{
-		if (DivasCardsDiscover() < 0)
-		{
-			printk(KERN_WARNING "Divas: Not loaded\n");
-			return -ENODEV;
-		}
-	}
-	else
-	{
-		printk(KERN_WARNING "Divas: No PCI bus present\n");
+		printk(KERN_WARNING "Divas: Not loaded\n");
 		return -ENODEV;
 	}
 

