Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266257AbTBLCzy>; Tue, 11 Feb 2003 21:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266224AbTBLCzx>; Tue, 11 Feb 2003 21:55:53 -0500
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:11017 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S266081AbTBLCzs>; Tue, 11 Feb 2003 21:55:48 -0500
Date: Tue, 11 Feb 2003 20:46:18 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Add small C99 named initializers to fs/bio.c
Message-ID: <20030212024618.GB914@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This trivial patch adds C99 named initializers to the file. Doing so
reduces a couple of compile warnings if '-W' is added.

Art Haas

===== fs/bio.c 1.37 vs edited =====
--- 1.37/fs/bio.c	Fri Jan 10 23:06:28 2003
+++ edited/fs/bio.c	Tue Feb 11 09:37:41 2003
@@ -46,7 +46,7 @@
  * unsigned short
  */
 
-#define BV(x) { x, "biovec-" #x }
+#define BV(x) { .nr_vecs = x, .name = "biovec-" #x }
 static struct biovec_pool bvec_array[BIOVEC_NR_POOLS] = {
 	BV(1), BV(4), BV(16), BV(64), BV(128), BV(BIO_MAX_PAGES),
 };
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
