Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319314AbSH2TZk>; Thu, 29 Aug 2002 15:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319315AbSH2TZj>; Thu, 29 Aug 2002 15:25:39 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:28401 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319314AbSH2TZj>; Thu, 29 Aug 2002 15:25:39 -0400
Subject: [TRIVIAL][PATCH] fix __FUNCTION__ pasting in iucv.c
From: Paul Larson <plars@linuxtestproject.org>
To: Trivial Patch Monkey <trivial@rustcorp.com.au>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 29 Aug 2002 14:19:47 -0500
Message-Id: <1030648788.5187.46.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial fix for __FUNCTION__ pasting in iucv.c against current bk tree.

-Paul Larson


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.554   -> 1.555  
#	drivers/s390/net/iucv.c	1.11    -> 1.12   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/29	plars@austin.ibm.com	1.555
# fix __FUNCTION__ pasting in iucv.c
# --------------------------------------------
#
diff -Nru a/drivers/s390/net/iucv.c b/drivers/s390/net/iucv.c
--- a/drivers/s390/net/iucv.c	Thu Aug 29 14:58:56 2002
+++ b/drivers/s390/net/iucv.c	Thu Aug 29 14:58:56 2002
@@ -302,7 +302,7 @@
 	if (debuglevel < 3)
 		return;
 
-	printk(KERN_DEBUG __FUNCTION__ ": %s\n", title);
+	printk(KERN_DEBUG "%s: %s\n", __FUNCTION__, title);
 	printk("  ");
 	for (i = 0; i < len; i++) {
 		if (!(i % 16) && i != 0)
@@ -318,7 +318,7 @@
 #define iucv_debug(lvl, fmt, args...) \
 do { \
 	if (debuglevel >= lvl) \
-		printk(KERN_DEBUG __FUNCTION__ ": " fmt "\n" , ## args); \
+		printk(KERN_DEBUG "%s: " fmt "\n" , __FUNCTION__, ## args); \
 } while (0)
 
 #else


