Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbTFJSvE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbTFJSnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:43:35 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:17797 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264027AbTFJSh2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:28 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709691006@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709693825@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:29 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1373, 2003/06/09 16:18:27-07:00, greg@kroah.com

PCI: remove pci_present() from sound/oss/cs46xx.c


 sound/oss/cs46xx.c |    5 -----
 1 files changed, 5 deletions(-)


diff -Nru a/sound/oss/cs46xx.c b/sound/oss/cs46xx.c
--- a/sound/oss/cs46xx.c	Tue Jun 10 11:17:55 2003
+++ b/sound/oss/cs46xx.c	Tue Jun 10 11:17:55 2003
@@ -5725,11 +5725,6 @@
 	int rtn = 0;
 	CS_DBGOUT(CS_INIT | CS_FUNCTION, 2, printk(KERN_INFO 
 		"cs46xx: cs46xx_init_module()+ \n"));
-	if (!pci_present()) {	/* No PCI bus in this machine! */
-		CS_DBGOUT(CS_INIT | CS_FUNCTION, 2, printk(KERN_INFO
-			"cs46xx: cs46xx_init_module()- no pci bus found\n"));
-		return -ENODEV;
-	}
 	rtn = pci_module_init(&cs46xx_pci_driver);
 
 	if(rtn == -ENODEV)

