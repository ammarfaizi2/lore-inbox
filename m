Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTFJSy2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbTFJSn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:43:28 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:18845 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264029AbTFJSh2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:28 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709672859@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709674152@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:27 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1347, 2003/06/09 15:54:20-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/net/wan/sdladrv.c


 drivers/net/wan/sdladrv.c |    8 +-------
 1 files changed, 1 insertion(+), 7 deletions(-)


diff -Nru a/drivers/net/wan/sdladrv.c b/drivers/net/wan/sdladrv.c
--- a/drivers/net/wan/sdladrv.c	Tue Jun 10 11:20:07 2003
+++ b/drivers/net/wan/sdladrv.c	Tue Jun 10 11:20:07 2003
@@ -1905,13 +1905,7 @@
 	struct pci_dev *pci_dev;
 
 
-#ifdef CONFIG_PCI
-        if(!pci_present())
-        {
-                printk(KERN_INFO "%s: PCI BIOS not present!\n", modname);
-                return 0;
-        }
-#else
+#ifndef CONFIG_PCI
         printk(KERN_INFO "%s: Linux not compiled for PCI usage!\n", modname);
         return 0;
 #endif

