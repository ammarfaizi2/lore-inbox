Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267978AbUJCP5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267978AbUJCP5r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 11:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267986AbUJCP5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 11:57:47 -0400
Received: from [213.205.33.42] ([213.205.33.42]:13796 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S267978AbUJCP5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 11:57:45 -0400
Subject: [patch 1/1] uml: fix get_user warning
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Sun, 03 Oct 2004 15:41:08 +0200
Message-Id: <20041003134109.248FFCBF1@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adds some more parenthesis for a macro arg to fix a warning (which was in
kernel/uid16.c).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/include/asm-um/uaccess.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN include/asm-um/uaccess.h~uml-fix-get_user-warning include/asm-um/uaccess.h
--- linux-2.6.9-current/include/asm-um/uaccess.h~uml-fix-get_user-warning	2004-10-03 15:37:45.654671792 +0200
+++ linux-2.6.9-current-paolo/include/asm-um/uaccess.h	2004-10-03 15:37:45.657671336 +0200
@@ -55,7 +55,7 @@
 
 #define get_user(x, ptr) \
 ({ \
-        const __typeof__((*ptr)) *private_ptr = (ptr); \
+        const __typeof__((*(ptr))) *private_ptr = (ptr); \
         (access_ok(VERIFY_READ, private_ptr, sizeof(*private_ptr)) ? \
 	 __get_user(x, private_ptr) : ((x) = 0, -EFAULT)); \
 })
_
