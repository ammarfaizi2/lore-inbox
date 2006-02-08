Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030436AbWBHUC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030436AbWBHUC6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 15:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030515AbWBHUCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 15:02:12 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38097 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030513AbWBHUB7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 15:01:59 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] v850: cast xchg() to void in set_rmb()
Message-Id: <E1F6vVm-0008Bz-L4@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 20:01:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1135880405 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 include/asm-v850/system.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

00e007cf433f2b768ab095fe62fd2a2a74eebecc
diff --git a/include/asm-v850/system.h b/include/asm-v850/system.h
index 107decb..cda8fa6 100644
--- a/include/asm-v850/system.h
+++ b/include/asm-v850/system.h
@@ -68,7 +68,7 @@ static inline int irqs_disabled (void)
 #define rmb()			mb ()
 #define wmb()			mb ()
 #define read_barrier_depends()	((void)0)
-#define set_rmb(var, value)	do { xchg (&var, value); } while (0)
+#define set_rmb(var, value)	do { (void)xchg (&var, value); } while (0)
 #define set_mb(var, value)	set_rmb (var, value)
 #define set_wmb(var, value)	do { var = value; wmb (); } while (0)
 
-- 
0.99.9.GIT

