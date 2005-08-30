Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbVISSOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbVISSOF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 14:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbVISSOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 14:14:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9601 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932542AbVISSOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 14:14:04 -0400
Date: Tue, 30 Aug 2005 17:40:49 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] missed gratitious includes of asm/segment.h 
Message-ID: <20050830164049.GL9322@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	A bunch of gratitious includes of asm/segment.h (outside of arch/*,
at that) had been missed by removals.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-base/drivers/isdn/hisax/hisax.h current/drivers/isdn/hisax/hisax.h
--- RC13-base/drivers/isdn/hisax/hisax.h	2005-08-28 23:09:43.000000000 -0400
+++ current/drivers/isdn/hisax/hisax.h	2005-08-30 03:25:18.000000000 -0400
@@ -10,7 +10,6 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/major.h>
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
diff -urN RC13-base/drivers/media/video/adv7170.c current/drivers/media/video/adv7170.c
--- RC13-base/drivers/media/video/adv7170.c	2005-08-28 23:09:43.000000000 -0400
+++ current/drivers/media/video/adv7170.c	2005-08-30 03:25:18.000000000 -0400
@@ -43,7 +43,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 
 #include <linux/videodev.h>
diff -urN RC13-base/drivers/media/video/adv7175.c current/drivers/media/video/adv7175.c
--- RC13-base/drivers/media/video/adv7175.c	2005-08-28 23:09:43.000000000 -0400
+++ current/drivers/media/video/adv7175.c	2005-08-30 03:25:18.000000000 -0400
@@ -39,7 +39,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 
 #include <linux/videodev.h>
diff -urN RC13-base/drivers/media/video/bt819.c current/drivers/media/video/bt819.c
--- RC13-base/drivers/media/video/bt819.c	2005-08-28 23:09:43.000000000 -0400
+++ current/drivers/media/video/bt819.c	2005-08-30 03:25:18.000000000 -0400
@@ -43,7 +43,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 
 #include <linux/videodev.h>
diff -urN RC13-base/drivers/media/video/bt856.c current/drivers/media/video/bt856.c
--- RC13-base/drivers/media/video/bt856.c	2005-08-28 23:09:43.000000000 -0400
+++ current/drivers/media/video/bt856.c	2005-08-30 03:25:18.000000000 -0400
@@ -43,7 +43,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 
 #include <linux/videodev.h>
diff -urN RC13-base/drivers/media/video/saa7111.c current/drivers/media/video/saa7111.c
--- RC13-base/drivers/media/video/saa7111.c	2005-08-28 23:09:43.000000000 -0400
+++ current/drivers/media/video/saa7111.c	2005-08-30 03:25:18.000000000 -0400
@@ -42,7 +42,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 
 #include <linux/videodev.h>
diff -urN RC13-base/drivers/media/video/saa7114.c current/drivers/media/video/saa7114.c
--- RC13-base/drivers/media/video/saa7114.c	2005-08-28 23:09:43.000000000 -0400
+++ current/drivers/media/video/saa7114.c	2005-08-30 03:25:18.000000000 -0400
@@ -45,7 +45,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 
 #include <linux/videodev.h>
diff -urN RC13-base/drivers/media/video/saa7185.c current/drivers/media/video/saa7185.c
--- RC13-base/drivers/media/video/saa7185.c	2005-08-28 23:09:43.000000000 -0400
+++ current/drivers/media/video/saa7185.c	2005-08-30 03:25:18.000000000 -0400
@@ -39,7 +39,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 
 #include <linux/videodev.h>
diff -urN RC13-base/include/linux/isdn.h current/include/linux/isdn.h
--- RC13-base/include/linux/isdn.h	2005-06-17 15:48:29.000000000 -0400
+++ current/include/linux/isdn.h	2005-08-30 03:25:18.000000000 -0400
@@ -150,7 +150,6 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/major.h>
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <linux/kernel.h>
 #include <linux/signal.h>
