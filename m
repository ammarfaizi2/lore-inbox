Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965089AbVKOXrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbVKOXrK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 18:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbVKOXrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 18:47:09 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:41373 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S965088AbVKOXrI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 18:47:08 -0500
Message-ID: <437A74AB.5060402@student.ltu.se>
Date: Wed, 16 Nov 2005 00:52:11 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: alex.kern@gmx.de
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -mm2] aty: remove unnecessary CONFIG_PCI
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Richard Knutsson

---

diff -Narup a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
--- a/drivers/video/aty/atyfb_base.c	2005-11-11 14:59:33.000000000 +0100
+++ b/drivers/video/aty/atyfb_base.c	2005-11-15 23:27:40.000000000 +0100
@@ -3692,9 +3692,7 @@ static int __init atyfb_init(void)
     atyfb_setup(option);
 #endif
 
-#ifdef CONFIG_PCI
     pci_register_driver(&atyfb_driver);
-#endif
 #ifdef CONFIG_ATARI
     atyfb_atari_probe();
 #endif
@@ -3703,9 +3701,7 @@ static int __init atyfb_init(void)
 
 static void __exit atyfb_exit(void)
 {
-#ifdef CONFIG_PCI
 	pci_unregister_driver(&atyfb_driver);
-#endif
 }
 
 module_init(atyfb_init);


