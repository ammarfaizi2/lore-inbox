Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWIDM6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWIDM6X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWIDM6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:58:23 -0400
Received: from server6.greatnet.de ([83.133.96.26]:41941 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S964870AbWIDM6S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:58:18 -0400
Message-ID: <44FC231C.1000807@nachtwindheim.de>
Date: Mon, 04 Sep 2006 14:59:08 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [MM] 6/10 pci_module_init() conversion
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

pci_module_init() convertion in olympic.c
This one works on linus tree(2.6.18-rc6) too.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

--- linux-2.6.18-rc5-mm1/drivers/net/tokenring/olympic.c	2006-09-13 17:46:50.000000000 +0200
+++ linux/drivers/net/tokenring/olympic.c	2006-09-13 22:23:50.475145848 +0200
@@ -1771,7 +1771,7 @@
 
 static int __init olympic_pci_init(void) 
 {
-	return pci_module_init (&olympic_driver) ; 
+	return pci_register_driver(&olympic_driver) ; 
 }
 
 static void __exit olympic_pci_cleanup(void)


