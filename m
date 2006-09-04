Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWIDMhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWIDMhp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWIDMho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:37:44 -0400
Received: from server6.greatnet.de ([83.133.96.26]:31447 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S964816AbWIDMhn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:37:43 -0400
Message-ID: <44FC1E44.1080202@nachtwindheim.de>
Date: Mon, 04 Sep 2006 14:38:28 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [MM] 1/10 pci_module_init() conversion
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

pci_module_init convertion in ata_generic.c.
For mm-tree only.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

--- linux-2.6.18-rc5-mm1/drivers/ata/ata_generic.c	2006-09-13 17:54:15.000000000 +0200
+++ linux/drivers/ata/ata_generic.c	2006-09-13 21:34:45.851360336 +0200
@@ -230,7 +230,7 @@
 
 static int __init ata_generic_init(void)
 {
-	return pci_module_init(&ata_generic_pci_driver);
+	return pci_register_driver(&ata_generic_pci_driver);
 }
 
 


-- 
VGER BF report: H 0.182422
