Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbVH3Oyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbVH3Oyq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 10:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVH3Oyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 10:54:46 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:62986 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932166AbVH3Oyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 10:54:45 -0400
Date: Tue, 30 Aug 2005 16:54:44 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-ID: <20050830145444.GC3708@stusta.de>
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

---

This patch was already sent on:
- 30 Jul 2005

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
 

