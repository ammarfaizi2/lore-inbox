Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422638AbVLOJTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422638AbVLOJTD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422653AbVLOJS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:18:58 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:17066 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422651AbVLOJSf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:18:35 -0500
To: torvalds@osdl.org
Subject: [PATCH] tlclk.c: pointers are handled by %p
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EmpFz-00080I-2r@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 15 Dec 2005 09:18:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


---

 drivers/char/tlclk.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

f1bbf945c86b729c20199133daba358284fa3c32
diff --git a/drivers/char/tlclk.c b/drivers/char/tlclk.c
index 12167c0..e8467dc 100644
--- a/drivers/char/tlclk.c
+++ b/drivers/char/tlclk.c
@@ -776,8 +776,8 @@ static int __init tlclk_init(void)
 	tlclk_device = platform_device_register_simple("telco_clock",
 				-1, NULL, 0);
 	if (!tlclk_device) {
-		printk(KERN_ERR " platform_device_register retruns 0x%X\n",
-			(unsigned int) tlclk_device);
+		printk(KERN_ERR " platform_device_register retruns 0x%p\n",
+			tlclk_device);
 		ret = -EBUSY;
 		goto out4;
 	}
-- 
0.99.9.GIT

