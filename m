Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWIDMn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWIDMn1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWIDMn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:43:26 -0400
Received: from server6.greatnet.de ([83.133.96.26]:36022 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S964849AbWIDMn0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:43:26 -0400
Message-ID: <44FC1F9B.5050503@nachtwindheim.de>
Date: Mon, 04 Sep 2006 14:44:11 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [MM] 3/10 pci_module_init() conversion
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

pci_module_init() convertion for k8_edac.c
For use in mm-tree only, cause the driver exists only there.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

--- linux-2.6.18-rc5-mm1/drivers/edac/k8_edac.c	2006-09-13 17:54:34.000000000 +0200
+++ linux/drivers/edac/k8_edac.c	2006-09-13 21:48:56.573030984 +0200
@@ -1865,7 +1865,7 @@
 
 static int __init k8_init(void)
 {
-	return pci_module_init(&k8_driver);
+	return pci_register_driver(&k8_driver);
 }
 
 static void __exit k8_exit(void)


