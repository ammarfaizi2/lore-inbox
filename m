Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbWIDMuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWIDMuS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWIDMuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:50:18 -0400
Received: from server6.greatnet.de ([83.133.96.26]:5335 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S964838AbWIDMuR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:50:17 -0400
Message-ID: <44FC213B.3060908@nachtwindheim.de>
Date: Mon, 04 Sep 2006 14:51:07 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [MM] 4/10 pci_module_init() convertion
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

pci_module_init() convertion in the legacy megaraid driver.
This is for mm only, cause the patch doesn't apply cleanly in linus tree.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

--- linux-2.6.18-rc5-mm1/drivers/scsi/megaraid.c	2006-09-13 17:55:48.000000000 +0200
+++ linux/drivers/scsi/megaraid.c	2006-09-13 22:34:28.364171976 +0200
@@ -5076,7 +5076,7 @@
 				"megaraid: failed to create megaraid root\n");
 	}
 #endif
-	error = pci_module_init(&megaraid_pci_driver);
+	error = pci_register_driver(&megaraid_pci_driver);
 	if (error) {
 #ifdef CONFIG_PROC_FS
 		remove_proc_entry("megaraid", &proc_root);


