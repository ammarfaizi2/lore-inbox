Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbTFJUc4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbTFJUc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:32:28 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:39842 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263949AbTFJShT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:19 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709693478@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709693294@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:29 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1371, 2003/06/09 16:14:28-07:00, greg@kroah.com

PCI: remove pci_present() from sound/oss/cmpci.c


 sound/oss/cmpci.c |    4 ----
 1 files changed, 4 deletions(-)


diff -Nru a/sound/oss/cmpci.c b/sound/oss/cmpci.c
--- a/sound/oss/cmpci.c	Tue Jun 10 11:18:04 2003
+++ b/sound/oss/cmpci.c	Tue Jun 10 11:18:04 2003
@@ -3139,10 +3139,6 @@
 	struct pci_dev *pcidev = NULL;
 	int index = 0;
 
-#ifdef CONFIG_PCI
-	if (!pci_present())   /* No PCI bus in this machine! */
-#endif
-		return -ENODEV;
 	printk(KERN_INFO "cmpci: version $Revision: 5.64 $ time " __TIME__ " " __DATE__ "\n");
 
 	while (index < NR_DEVICE && (

