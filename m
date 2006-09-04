Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWIDMyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWIDMyL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWIDMyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:54:11 -0400
Received: from server6.greatnet.de ([83.133.96.26]:38795 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S964812AbWIDMyJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:54:09 -0400
Message-ID: <44FC221E.3010502@nachtwindheim.de>
Date: Mon, 04 Sep 2006 14:54:54 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [MM] 5/10 pci_module_init() conversion
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Removes an unneeded variable and changes pci_module_init() to
pci_register_driver().
For mm-tree only, cause the driver exists only there.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

--- linux-2.6.18-rc5-mm1/drivers/char/nozomi.c	2006-09-13 17:54:29.000000000 +0200
+++ linux/drivers/char/nozomi.c	2006-09-13 22:10:28.209108824 +0200
@@ -2168,11 +2168,8 @@
 
 static __init int nozomi_init(void)
 {
-	int rval = 0;
-
-	rval = pci_module_init(&nozomi_driver);
 	printk(KERN_INFO "Initializing %s\n", VERSION_STRING);
-	return rval;
+	return pci_register_driver(&nozomi_driver);
 }
 
 static __exit void nozomi_exit(void)


