Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbVAII7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVAII7s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 03:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbVAII7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 03:59:48 -0500
Received: from mx1.mail.ru ([194.67.23.121]:38732 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S262073AbVAII7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 03:59:14 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Christer Weinigel <christer@weinigel.se>
Subject: [PATCH] scx200: s/0/NULL/ in pointer context
Date: Sun, 9 Jan 2005 11:52:50 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200501091152.50151.adobriyan@mail.ru>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>

Index: linux-2.6.10-bk11-warnings/arch/i386/kernel/scx200.c
===================================================================
--- linux-2.6.10-bk11-warnings/arch/i386/kernel/scx200.c	(revision 3)
+++ linux-2.6.10-bk11-warnings/arch/i386/kernel/scx200.c	(revision 4)
@@ -48,7 +48,7 @@
 	base = pci_resource_start(pdev, 0);
 	printk(KERN_INFO NAME ": GPIO base 0x%x\n", base);
 
-	if (request_region(base, SCx200_GPIO_SIZE, "NatSemi SCx200 GPIO") == 0) {
+	if (request_region(base, SCx200_GPIO_SIZE, "NatSemi SCx200 GPIO") == NULL) {
 		printk(KERN_ERR NAME ": can't allocate I/O for GPIOs\n");
 		return -EBUSY;
 	}
