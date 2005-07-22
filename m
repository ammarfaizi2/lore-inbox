Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbVGVIRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbVGVIRp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 04:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVGVIRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 04:17:45 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:2273 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S262065AbVGVIRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 04:17:44 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.13-rc3-git4] watchdog: add missing 0x in alim1535_wdt.c
Date: Fri, 22 Jul 2005 10:22:10 +0200
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507221022.11424@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

usually the device IDs are given in hex. This one is a bit strange: it is 
without 0x in the first place and used with it some lines later. I suspect the 
first one to be the wrong. Patch attached.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

--- a/drivers/char/watchdog/alim1535_wdt.c	2005-07-22 01:17:42.000000000 +0200
+++ b/drivers/char/watchdog/alim1535_wdt.c	2005-07-22 01:17:52.000000000 +0200
@@ -317,7 +317,7 @@ static int ali_notify_sys(struct notifie
  */
 
 static struct pci_device_id ali_pci_tbl[] = {
-	{ PCI_VENDOR_ID_AL, 1535, PCI_ANY_ID, PCI_ANY_ID,},
+	{ PCI_VENDOR_ID_AL, 0x1535, PCI_ANY_ID, PCI_ANY_ID,},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, ali_pci_tbl);
