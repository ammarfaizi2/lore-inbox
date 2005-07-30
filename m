Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263066AbVG3QwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263066AbVG3QwG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 12:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263069AbVG3QwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 12:52:06 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:54030 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263066AbVG3QwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 12:52:05 -0400
Date: Sat, 30 Jul 2005 18:52:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-ID: <20050730165202.GI5590@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, using an undeclared function gives a compile warning, but it 
can lead to a link or even a runtime error.

With -Werror-implicit-function-declaration, we are getting an immediate 
compile error instead.

This patch also removes some unneeded spaces between two tabs in the 
following line.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc3-mm3-full/Makefile.old	2005-07-30 13:55:32.000000000 +0200
+++ linux-2.6.13-rc3-mm3-full/Makefile	2005-07-30 13:55:56.000000000 +0200
@@ -351,7 +351,8 @@
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
 CFLAGS 		:= -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
-	  	   -fno-strict-aliasing -fno-common \
+		   -Werror-implicit-function-declaration \
+		   -fno-strict-aliasing -fno-common \
 		   -ffreestanding
 AFLAGS		:= -D__ASSEMBLY__
 

