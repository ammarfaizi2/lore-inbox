Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135328AbRDLVVJ>; Thu, 12 Apr 2001 17:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135330AbRDLVVA>; Thu, 12 Apr 2001 17:21:00 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:14090 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S135328AbRDLVUj>;
	Thu, 12 Apr 2001 17:20:39 -0400
Date: Thu, 12 Apr 2001 23:20:36 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Cc: kernel-janitor-discuss@lists.sourceforge.net
Subject: [upatch #11] 2.4.3-ac5 - static const char *foo to static char foo[]
Message-ID: <20010412232036.K16102@se1.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  it compiles fine and there is no MAINTAINER entry for it nor specific
email address in the source file.

diff -u --recursive linux-2.4.3-ac5.orig/drivers/char/keyboard.c linux-2.4.3-ac5/drivers/char/keyboard.c
--- linux-2.4.3-ac5.orig/drivers/char/keyboard.c	Thu Apr 12 20:23:06 2001
+++ linux-2.4.3-ac5/drivers/char/keyboard.c	Thu Apr 12 21:10:37 2001
@@ -632,8 +632,8 @@
 
 static void do_pad(unsigned char value, char up_flag)
 {
-	static const char *pad_chars = "0123456789+-*/\015,.?()";
-	static const char *app_map = "pqrstuvwxylSRQMnnmPQ";
+	static char pad_chars[] = "0123456789+-*/\015,.?()";
+	static char app_map[] = "pqrstuvwxylSRQMnnmPQ";
 
 	if (up_flag)
 		return;		/* no action, if this is a key release */
@@ -689,7 +689,7 @@
 
 static void do_cur(unsigned char value, char up_flag)
 {
-	static const char *cur_chars = "BDCA";
+	static char cur_chars[] = "BDCA";
 	if (up_flag)
 		return;
 

-- 
Ueimor
