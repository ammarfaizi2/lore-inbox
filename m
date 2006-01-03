Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965118AbWACXb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbWACXb7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbWACXb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:31:58 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37528 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965109AbWACX3w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:29:52 -0500
To: torvalds@osdl.org
Subject: [PATCH 41/41] m68k: console code in head.S needs framebuffer support built in
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1EtvbD-0003Q9-CK@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 23:29:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1136288095 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/m68k/kernel/head.S |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

84f4e93cb893f69ee4a053aa4cd13604327aff63
diff --git a/arch/m68k/kernel/head.S b/arch/m68k/kernel/head.S
index d4336d8..70002c1 100644
--- a/arch/m68k/kernel/head.S
+++ b/arch/m68k/kernel/head.S
@@ -273,8 +273,10 @@
  * Macintosh console support
  */
 
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE
 #define CONSOLE
 #define CONSOLE_PENGUIN
+#endif
 
 /*
  * Macintosh serial debug support; outputs boot info to the printer
-- 
0.99.9.GIT

