Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267383AbTAVI1T>; Wed, 22 Jan 2003 03:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267385AbTAVI1T>; Wed, 22 Jan 2003 03:27:19 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:61064 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267383AbTAVI1Q>; Wed, 22 Jan 2003 03:27:16 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Include <asm/page.h> in fs/seq_file.c, as it uses PAGE_SIZE
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030122083505.EFCD537BD@mcspd15.ucom.lsi.nec.co.jp>
Date: Wed, 22 Jan 2003 17:35:05 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise it won't compile.  I guesss this used to work because
<asm/page.h> was included somewhere to get the BUG macros, but now with
the advent of <asm/bug.h> that's changed.

diff -ruN -X../cludes linux-2.5.59-uc0.orig/fs/seq_file.c linux-2.5.59-uc0/fs/seq_file.c
--- linux-2.5.59-uc0.orig/fs/seq_file.c	2002-09-18 09:59:04.000000000 +0900
+++ linux-2.5.59-uc0/fs/seq_file.c	2003-01-22 11:49:41.000000000 +0900
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 
 #include <asm/uaccess.h>
+#include <asm/page.h>
 
 /**
  *	seq_open -	initialize sequential file
