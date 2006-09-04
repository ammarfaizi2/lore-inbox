Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWIDNNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWIDNNK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 09:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWIDNNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 09:13:09 -0400
Received: from server6.greatnet.de ([83.133.96.26]:33670 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S964908AbWIDNNG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 09:13:06 -0400
Message-ID: <44FC268D.2020506@nachtwindheim.de>
Date: Mon, 04 Sep 2006 15:13:49 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [MM] 7/10 pci_module_init() conversion
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

pci_module_init() conversion for pata_pdc2027x
For use in mm-tree only, since the new location of the ata drivers.
In that case I don't know exactly how to change the version number.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

--- linux-2.6.18-rc5-mm1/drivers/ata/pata_pdc2027x.c	2006-09-13 17:54:16.000000000 +0200
+++ linux/drivers/ata/pata_pdc2027x.c	2006-09-13 21:41:56.488893480 +0200
@@ -854,7 +854,7 @@
  */
 static int __init pdc2027x_init(void)
 {
-	return pci_module_init(&pdc2027x_pci_driver);
+	return pci_register_driver(&pdc2027x_pci_driver);
 }
 
 /**


