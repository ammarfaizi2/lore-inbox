Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWIDMlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWIDMlF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWIDMlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:41:05 -0400
Received: from server6.greatnet.de ([83.133.96.26]:16361 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S964856AbWIDMlE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:41:04 -0400
Message-ID: <44FC1F0E.5030504@nachtwindheim.de>
Date: Mon, 04 Sep 2006 14:41:50 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [MM] 2/10 pci_module_init() conversion
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

pci_module_init() convertion in amso1100 driver.
This is for mm only, cause this driver only exists there.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

--- linux-2.6.18-rc5-mm1/drivers/infiniband/hw/amso1100/c2.c	2006-09-04 14:00:01.000000000 +0200
+++ linux/drivers/infiniband/hw/amso1100/c2.c	2006-09-04 14:13:07.000000000 +0200
@@ -1243,7 +1243,7 @@
 
 static int __init c2_init_module(void)
 {
-	return pci_module_init(&c2_pci_driver);
+	return pci_register_driver(&c2_pci_driver);
 }
 
 static void __exit c2_exit_module(void)


