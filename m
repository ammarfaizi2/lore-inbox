Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbVJZVsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbVJZVsh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 17:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbVJZVsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 17:48:37 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:1443 "EHLO gepetto.dc.ltu.se")
	by vger.kernel.org with ESMTP id S964954AbVJZVsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 17:48:37 -0400
Message-ID: <435FFADA.8030703@student.ltu.se>
Date: Wed, 26 Oct 2005 23:53:30 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com
Subject: [PATCH 2.6.14-rc5] drivers/net/dgrs.c: Fix potential "unused variable"-warning.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a cosmetic change to prevent compiler-warning about unused variable (+ save 2 or 4 bytes of memory).

BTW, the authors mail-address seems invalid.

Signed-off-by: Richard Knutsson

---

diff -uNr a/drivers/net/dgrs.c b/drivers/net/dgrs.c
--- a/drivers/net/dgrs.c	2005-08-29 01:41:01.000000000 +0200
+++ b/drivers/net/dgrs.c	2005-10-26 15:53:43.000000000 +0200
@@ -1549,7 +1549,7 @@
 static int __init dgrs_init_module (void)
 {
 	int	i;
-	int eisacount = 0, pcicount = 0;
+	int	count = 0;
 
 	/*
 	 *	Command line variable overrides
@@ -1591,14 +1591,14 @@
 	 *	Find and configure all the cards
 	 */
 #ifdef CONFIG_EISA
-	eisacount = eisa_driver_register(&dgrs_eisa_driver);
-	if (eisacount < 0)
-		return eisacount;
+	count = eisa_driver_register(&dgrs_eisa_driver);
+	if (count < 0)
+		return count;
 #endif
 #ifdef CONFIG_PCI
-	pcicount = pci_register_driver(&dgrs_pci_driver);
-	if (pcicount)
-		return pcicount;
+	count = pci_register_driver(&dgrs_pci_driver);
+	if (count)
+		return count;
 #endif
 	return 0;
 }


