Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbVJLRlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbVJLRlD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 13:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbVJLRlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 13:41:03 -0400
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:40552 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751232AbVJLRlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 13:41:00 -0400
Message-ID: <434D4AAA.9010905@gmail.com>
Date: Wed, 12 Oct 2005 12:40:58 -0500
From: Hareesh Nagarajan <hnagar2@gmail.com>
Reply-To: hnagar2@gmail.com
User-Agent: Thunderbird 1.4 (X11/20050908)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: geert@linux-m68k.org, davem@davemloft.net
Subject: [PATCH] Trivial patch to remove the unused member 'list' from the
 *_par structures in some files in drivers/video/
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This trivial patch removes the unused member 'list' from the 
corresponding *_par structure from some files in drivers/video/

For e.g.: struct tcx_par, in drivers/video/tcx.c

Signed-off-by: Hareesh Nagarajan <hnagar2@gmail.com>

---
diff -ruN linux-2.6.13.4/drivers/video/bw2.c 
linux-2.6.13.4-edit/drivers/video/bw2.c
--- linux-2.6.13.4/drivers/video/bw2.c	2005-10-10 13:54:29.000000000 -0500
+++ linux-2.6.13.4-edit/drivers/video/bw2.c	2005-10-12 
00:06:48.239981000 -0500
@@ -119,7 +119,6 @@
  	unsigned long		fbsize;

  	struct sbus_dev		*sdev;
-	struct list_head	list;
  };

  /**
diff -ruN linux-2.6.13.4/drivers/video/cg14.c 
linux-2.6.13.4-edit/drivers/video/cg14.c
--- linux-2.6.13.4/drivers/video/cg14.c	2005-10-10 13:54:29.000000000 -0500
+++ linux-2.6.13.4-edit/drivers/video/cg14.c	2005-10-12 
00:10:25.039490000 -0500
@@ -204,7 +204,6 @@
  	int			mode;
  	int			ramsize;
  	struct sbus_dev		*sdev;
-	struct list_head	list;
  };

  static void __cg14_reset(struct cg14_par *par)
diff -ruN linux-2.6.13.4/drivers/video/cg3.c 
linux-2.6.13.4-edit/drivers/video/cg3.c
--- linux-2.6.13.4/drivers/video/cg3.c	2005-10-10 13:54:29.000000000 -0500
+++ linux-2.6.13.4-edit/drivers/video/cg3.c	2005-10-12 
00:07:06.759939000 -0500
@@ -122,7 +122,6 @@
  	unsigned long		fbsize;

  	struct sbus_dev		*sdev;
-	struct list_head	list;
  };

  /**
diff -ruN linux-2.6.13.4/drivers/video/cg6.c 
linux-2.6.13.4-edit/drivers/video/cg6.c
--- linux-2.6.13.4/drivers/video/cg6.c	2005-10-10 13:54:29.000000000 -0500
+++ linux-2.6.13.4-edit/drivers/video/cg6.c	2005-10-12 
00:06:04.330080000 -0500
@@ -263,7 +263,6 @@
  	unsigned long		fbsize;

  	struct sbus_dev		*sdev;
-	struct list_head	list;
  };

  static int cg6_sync(struct fb_info *info)
diff -ruN linux-2.6.13.4/drivers/video/ffb.c 
linux-2.6.13.4-edit/drivers/video/ffb.c
--- linux-2.6.13.4/drivers/video/ffb.c	2005-10-10 13:54:29.000000000 -0500
+++ linux-2.6.13.4-edit/drivers/video/ffb.c	2005-10-12 
00:10:44.739447000 -0500
@@ -359,7 +359,6 @@
  	int			prom_parent_node;
  	int			dac_rev;
  	int			board_type;
-	struct list_head	list;
  };

  static void FFBFifo(struct ffb_par *par, int n)
diff -ruN linux-2.6.13.4/drivers/video/leo.c 
linux-2.6.13.4-edit/drivers/video/leo.c
--- linux-2.6.13.4/drivers/video/leo.c	2005-10-10 13:54:29.000000000 -0500
+++ linux-2.6.13.4-edit/drivers/video/leo.c	2005-10-12 
00:10:10.839522000 -0500
@@ -195,7 +195,6 @@
  	unsigned long		fbsize;

  	struct sbus_dev		*sdev;
-	struct list_head	list;
  };

  static void leo_wait(struct leo_lx_krn __iomem *lx_krn)
diff -ruN linux-2.6.13.4/drivers/video/p9100.c 
linux-2.6.13.4-edit/drivers/video/p9100.c
--- linux-2.6.13.4/drivers/video/p9100.c	2005-10-10 13:54:29.000000000 -0500
+++ linux-2.6.13.4-edit/drivers/video/p9100.c	2005-10-12 
00:07:30.459885000 -0500
@@ -138,7 +138,6 @@
  	unsigned long		fbsize;

  	struct sbus_dev		*sdev;
-	struct list_head	list;
  };

  /**
diff -ruN linux-2.6.13.4/drivers/video/tcx.c 
linux-2.6.13.4-edit/drivers/video/tcx.c
--- linux-2.6.13.4/drivers/video/tcx.c	2005-10-10 13:54:29.000000000 -0500
+++ linux-2.6.13.4-edit/drivers/video/tcx.c	2005-10-12 
00:02:53.710511000 -0500
@@ -123,7 +123,6 @@
  	int			lowdepth;

  	struct sbus_dev		*sdev;
-	struct list_head	list;
  };

  /* Reset control plane so that WID is 8-bit plane. */
