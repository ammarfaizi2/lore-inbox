Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbVIIT3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbVIIT3O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030317AbVIIT3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:29:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:64215 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030309AbVIIT3N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:29:13 -0400
Date: Fri, 9 Sep 2005 20:29:12 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: [PATCH] trivial __user annotations (evdev)
Message-ID: <20050909192912.GX9623@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git8-base/drivers/input/evdev.c current/drivers/input/evdev.c
--- RC13-git8-base/drivers/input/evdev.c	2005-09-08 10:17:39.000000000 -0400
+++ current/drivers/input/evdev.c	2005-09-08 23:53:33.000000000 -0400
@@ -509,7 +509,7 @@
 	int len = NBITS_COMPAT((max)) * sizeof(compat_long_t); \
 	if (len > _IOC_SIZE(cmd)) len = _IOC_SIZE(cmd); \
 	for (i = 0; i < len / sizeof(compat_long_t); i++) \
-		if (copy_to_user((compat_long_t*) p + i, \
+		if (copy_to_user((compat_long_t __user *) p + i, \
 				 (compat_long_t*) (bit) + i + 1 - ((i % 2) << 1), \
 				 sizeof(compat_long_t))) \
 			return -EFAULT; \
