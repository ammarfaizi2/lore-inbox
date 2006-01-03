Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965091AbWACXae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbWACXae (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbWACX3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:29:55 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:33688 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965091AbWACX3Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:29:16 -0500
To: torvalds@osdl.org
Subject: [PATCH 34/41] m68k: cast in strnlen switched to unsigned long
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1Etvad-0003PA-Oy@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 23:29:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1135012341 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 include/asm-m68k/uaccess.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

db2c42670cf6d3dcab286b15d4947de579a34172
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

