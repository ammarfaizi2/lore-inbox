Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319343AbSH2Uzy>; Thu, 29 Aug 2002 16:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319346AbSH2Uzy>; Thu, 29 Aug 2002 16:55:54 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:48044 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319343AbSH2Uzw>;
	Thu, 29 Aug 2002 16:55:52 -0400
Subject: [TRIVIAL][PATCH] fix __FUNCTION__ pasting in generic_serial.c
From: Paul Larson <plars@linuxtestproject.org>
To: Trivial Patch Monkey <trivial@rustcorp.com.au>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 29 Aug 2002 15:50:00 -0500
Message-Id: <1030654201.7151.4.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial fix for __FUNCTION__ pasting in generic_serial.c against current bk tree.

-Paul Larson

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.558   -> 1.559  
#	drivers/char/generic_serial.c	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/29	plars@austin.ibm.com	1.559
# fix __FUNCTION__ pasting in generic_serial.c
# --------------------------------------------
#
diff -Nru a/drivers/char/generic_serial.c b/drivers/char/generic_serial.c
--- a/drivers/char/generic_serial.c	Thu Aug 29 15:42:43 2002
+++ b/drivers/char/generic_serial.c	Thu Aug 29 15:42:43 2002
@@ -41,8 +41,8 @@
 #define gs_dprintk(f, str...) /* nothing */
 #endif
 
-#define func_enter() gs_dprintk (GS_DEBUG_FLOW, "gs: enter " __FUNCTION__ "\n")
-#define func_exit()  gs_dprintk (GS_DEBUG_FLOW, "gs: exit  " __FUNCTION__ "\n")
+#define func_enter() gs_dprintk (GS_DEBUG_FLOW, "gs: enter %s\n", __FUNCTION__)
+#define func_exit()  gs_dprintk (GS_DEBUG_FLOW, "gs: exit  %s\n", __FUNCTION__)
 
 #if NEW_WRITE_LOCKING
 #define DECL      /* Nothing */

