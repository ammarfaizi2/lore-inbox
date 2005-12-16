Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbVLPWfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbVLPWfa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 17:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbVLPWfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 17:35:30 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:26600 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964778AbVLPWf3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 17:35:29 -0500
To: torvalds@osdl.org
Subject: [PATCH] ppc: booke_wdt compile fix
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Message-Id: <E1EnOAi-0006JX-TK@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Fri, 16 Dec 2005 22:35:28 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


booke_wdt.c had been missed in cpu_specs[] removal sweep

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


---

 drivers/char/watchdog/booke_wdt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

c845a90e7ff367deb10a66dbf37c3709b8d76325
diff --git a/drivers/char/watchdog/booke_wdt.c b/drivers/char/watchdog/booke_wdt.c
index c800cce..b664060 100644
--- a/drivers/char/watchdog/booke_wdt.c
+++ b/drivers/char/watchdog/booke_wdt.c
@@ -173,7 +173,7 @@ static int __init booke_wdt_init(void)
 	int ret = 0;
 
 	printk (KERN_INFO "PowerPC Book-E Watchdog Timer Loaded\n");
-	ident.firmware_version = cpu_specs[0].pvr_value;
+	ident.firmware_version = cur_cpu_spec->pvr_value;
 
 	ret = misc_register(&booke_wdt_miscdev);
 	if (ret) {
-- 
0.99.9.GIT

