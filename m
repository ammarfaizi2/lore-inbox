Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965111AbVLVEws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965111AbVLVEws (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbVLVEwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:52:42 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:48051 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965105AbVLVEwF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:52:05 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 36/36] m68k: cast in strnlen switched to unsigned long
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIQu-0004uF-Ps@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:52:04 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1135012341 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 include/asm-m68k/uaccess.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

1dcba025aa483559af90e88e91ab4fd62304bb5c
diff --git a/include/asm-m68k/uaccess.h b/include/asm-m68k/uaccess.h
index a653bf8..2ffd87b 100644
--- a/include/asm-m68k/uaccess.h
+++ b/include/asm-m68k/uaccess.h
@@ -805,7 +805,7 @@ static inline long strnlen_user(const ch
 {
 	long res;
 
-	res = -(long)src;
+	res = -(unsigned long)src;
 	__asm__ __volatile__
 		("1:\n"
 		 "   tstl %2\n"
-- 
0.99.9.GIT

