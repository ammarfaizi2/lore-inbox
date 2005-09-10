Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbVIJMVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVIJMVO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 08:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbVIJMVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 08:21:14 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:29063 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1750777AbVIJMVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 08:21:13 -0400
Date: Sat, 10 Sep 2005 14:21:09 +0200
Message-Id: <200509101221.j8ACL9ad017242@localhost.localdomain>
In-reply-to: <200509101219.j8ACJHeb017063@localhost.localdomain>
Subject: [PATCH 4/10] drivers/char: pci_find_device remove (drivers/char/rocket.c)
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 rocket.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/rocket.c b/drivers/char/rocket.c
--- a/drivers/char/rocket.c
+++ b/drivers/char/rocket.c
@@ -2234,7 +2234,7 @@ static int __init init_PCI(int boards_fo
 	int count = 0;
 
 	/*  Work through the PCI device list, pulling out ours */
-	while ((dev = pci_find_device(PCI_VENDOR_ID_RP, PCI_ANY_ID, dev))) {
+	while ((dev = pci_get_device(PCI_VENDOR_ID_RP, PCI_ANY_ID, dev))) {
 		if (register_PCI(count + boards_found, dev))
 			count++;
 	}
