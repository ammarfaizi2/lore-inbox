Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTFJVgo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263837AbTFJVgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:36:12 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:53422 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262528AbTFJShG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:06 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709674152@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <1055270967899@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:27 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1346, 2003/06/09 15:53:52-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/net/wan/sbni.c


 drivers/net/wan/sbni.c |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/drivers/net/wan/sbni.c b/drivers/net/wan/sbni.c
--- a/drivers/net/wan/sbni.c	Tue Jun 10 11:20:14 2003
+++ b/drivers/net/wan/sbni.c	Tue Jun 10 11:20:14 2003
@@ -263,9 +263,6 @@
 {
 	struct pci_dev  *pdev = NULL;
 
-	if( !pci_present( ) )
-		return  -ENODEV;
-
 	while( (pdev = pci_find_class( PCI_CLASS_NETWORK_OTHER << 8, pdev ))
 	       != NULL ) {
 		int  pci_irq_line;

