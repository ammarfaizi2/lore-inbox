Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbVC1Roa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVC1Roa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 12:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbVC1Roa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 12:44:30 -0500
Received: from fep19.inet.fi ([194.251.242.244]:60318 "EHLO fep19.inet.fi")
	by vger.kernel.org with ESMTP id S261969AbVC1Rlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 12:41:35 -0500
Subject: [PATCH 2/9] isofs: inline macros in rock.c
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <ie2p45.fn0xkb.3bgqrzdsi2bnjwwpzvx2x3vr3.refire@cs.helsinki.fi>
In-Reply-To: <ie2p3w.8axj20.6dtzk29izx5dbxb43kc9fm7y4.refire@cs.helsinki.fi>
Date: Mon, 28 Mar 2005 20:41:34 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch inlines the CONTINUE_DECLS macro in fs/isofs/rock.c.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 rock.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

Index: 2.6/fs/isofs/rock.c
===================================================================
--- 2.6.orig/fs/isofs/rock.c	2005-03-28 16:27:39.000000000 +0300
+++ 2.6/fs/isofs/rock.c	2005-03-28 16:27:40.000000000 +0300
@@ -38,10 +38,6 @@
    same thing in certain places.  We use the macros to ensure that everything
    is done correctly */
 
-#define CONTINUE_DECLS \
-  int cont_extent = 0, cont_offset = 0, cont_size = 0;   \
-  void *buffer = NULL
-
 #define CHECK_CE	       			\
       {cont_extent = isonum_733(rr->u.CE.extent); \
       cont_offset = isonum_733(rr->u.CE.offset); \
@@ -95,7 +91,8 @@
 {
 	int len;
 	unsigned char *chr;
-	CONTINUE_DECLS;
+	int cont_extent = 0, cont_offset = 0, cont_size = 0;
+	void *buffer = NULL;
 	int retnamlen = 0, truncate = 0;
 
 	if (!ISOFS_SB(inode->i_sb)->s_rock)
@@ -184,7 +181,8 @@
 	int len;
 	unsigned char *chr;
 	int symlink_len = 0;
-	CONTINUE_DECLS;
+	int cont_extent = 0, cont_offset = 0, cont_size = 0;
+	void *buffer = NULL;
 
 	if (!ISOFS_SB(inode->i_sb)->s_rock)
 		return 0;
@@ -527,7 +525,8 @@
 	char *rpnt = link;
 	unsigned char *pnt;
 	struct iso_directory_record *raw_inode;
-	CONTINUE_DECLS;
+	int cont_extent = 0, cont_offset = 0, cont_size = 0;
+	void *buffer = NULL;
 	unsigned long block, offset;
 	int sig;
 	int len;
