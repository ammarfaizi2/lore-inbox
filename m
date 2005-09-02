Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbVIBTOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVIBTOd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 15:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbVIBTOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 15:14:33 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:2469 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750809AbVIBTOc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 15:14:32 -0400
Date: Fri, 2 Sep 2005 20:14:32 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] missed gratitious includes of asm/segment.h
Message-ID: <20050902191432.GD5155@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A bunch of gratitious includes of asm/segment.h (outside of arch/*, at that)
had been missed by removals.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-s390-phy/drivers/isdn/hisax/hisax.h RC13-segment/drivers/isdn/hisax/hisax.h
--- RC13-s390-phy/drivers/isdn/hisax/hisax.h	2005-08-10 10:37:49.000000000 -0400
+++ RC13-segment/drivers/isdn/hisax/hisax.h	2005-09-02 03:34:22.000000000 -0400
@@ -10,7 +10,6 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/major.h>
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
diff -urN RC13-s390-phy/drivers/media/video/adv7170.c RC13-segment/drivers/media/video/adv7170.c
--- RC13-s390-phy/drivers/media/video/adv7170.c	2005-08-10 10:37:49.000000000 -0400
+++ RC13-segment/drivers/media/video/adv7170.c	2005-09-02 03:34:22.000000000 -0400
@@ -43,7 +43,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 
 #include <linux/videodev.h>
diff -urN RC13-s390-phy/drivers/media/video/adv7175.c RC13-segment/drivers/media/video/adv7175.c
--- RC13-s390-phy/drivers/media/video/adv7175.c	2005-08-10 10:37:49.000000000 -0400
+++ RC13-segment/drivers/media/video/adv7175.c	2005-09-02 03:34:22.000000000 -0400
@@ -39,7 +39,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 
 #include <linux/videodev.h>
diff -urN RC13-s390-phy/drivers/media/video/bt819.c RC13-segment/drivers/media/video/bt819.c
--- RC13-s390-phy/drivers/media/video/bt819.c	2005-08-10 10:37:49.000000000 -0400
+++ RC13-segment/drivers/media/video/bt819.c	2005-09-02 03:34:22.000000000 -0400
@@ -43,7 +43,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 
 #include <linux/videodev.h>
diff -urN RC13-s390-phy/drivers/media/video/bt856.c RC13-segment/drivers/media/video/bt856.c
--- RC13-s390-phy/drivers/media/video/bt856.c	2005-08-10 10:37:49.000000000 -0400
+++ RC13-segment/drivers/media/video/bt856.c	2005-09-02 03:34:22.000000000 -0400
@@ -43,7 +43,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 
 #include <linux/videodev.h>
diff -urN RC13-s390-phy/drivers/media/video/saa7111.c RC13-segment/drivers/media/video/saa7111.c
--- RC13-s390-phy/drivers/media/video/saa7111.c	2005-08-10 10:37:49.000000000 -0400
+++ RC13-segment/drivers/media/video/saa7111.c	2005-09-02 03:34:22.000000000 -0400
@@ -42,7 +42,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 
 #include <linux/videodev.h>
diff -urN RC13-s390-phy/drivers/media/video/saa7114.c RC13-segment/drivers/media/video/saa7114.c
--- RC13-s390-phy/drivers/media/video/saa7114.c	2005-08-10 10:37:49.000000000 -0400
+++ RC13-segment/drivers/media/video/saa7114.c	2005-09-02 03:34:22.000000000 -0400
@@ -45,7 +45,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 
 #include <linux/videodev.h>
diff -urN RC13-s390-phy/drivers/media/video/saa7185.c RC13-segment/drivers/media/video/saa7185.c
--- RC13-s390-phy/drivers/media/video/saa7185.c	2005-08-10 10:37:49.000000000 -0400
+++ RC13-segment/drivers/media/video/saa7185.c	2005-09-02 03:34:22.000000000 -0400
@@ -39,7 +39,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 
 #include <linux/videodev.h>
diff -urN RC13-s390-phy/include/linux/isdn.h RC13-segment/include/linux/isdn.h
--- RC13-s390-phy/include/linux/isdn.h	2005-06-17 15:48:29.000000000 -0400
+++ RC13-segment/include/linux/isdn.h	2005-09-02 03:34:22.000000000 -0400
@@ -150,7 +150,6 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/major.h>
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <linux/kernel.h>
 #include <linux/signal.h>
