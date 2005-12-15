Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422659AbVLOJYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422659AbVLOJYS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422637AbVLOJSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:18:10 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:13994 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422638AbVLOJSF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:18:05 -0500
To: torvalds@osdl.org
Subject: [PATCH] wdrtas.c: fix __user annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EmpFV-0007zQ-10@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 15 Dec 2005 09:18:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


---

 drivers/char/watchdog/wdrtas.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

9dfed0b4cd3f6f0ddc1d9eeb7dccaa1af0e710f3
diff --git a/drivers/char/watchdog/wdrtas.c b/drivers/char/watchdog/wdrtas.c
index 619e2ff..dacfe31 100644
--- a/drivers/char/watchdog/wdrtas.c
+++ b/drivers/char/watchdog/wdrtas.c
@@ -320,7 +320,7 @@ static int
 wdrtas_ioctl(struct inode *inode, struct file *file,
 	     unsigned int cmd, unsigned long arg)
 {
-	int __user *argp = (void *)arg;
+	int __user *argp = (void __user *)arg;
 	int i;
 	static struct watchdog_info wdinfo = {
 		.options = WDRTAS_SUPPORTED_MASK,
-- 
0.99.9.GIT

