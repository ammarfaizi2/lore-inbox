Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318957AbSICWKf>; Tue, 3 Sep 2002 18:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318958AbSICWKf>; Tue, 3 Sep 2002 18:10:35 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:59838 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318957AbSICWKc>; Tue, 3 Sep 2002 18:10:32 -0400
Subject: Re: __func__ in 2.5.33?
From: Paul Larson <plars@austin.ibm.com>
To: rasmus@jaquet.dk
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-mXEXJrThjzccSlk2lSmc"
X-Mailer: Ximian Evolution 1.0.5 
Date: 03 Sep 2002 17:03:42 -0500
Message-Id: <1031090622.23823.15.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mXEXJrThjzccSlk2lSmc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I posted this a few days ago, but I don't think it's been picked up yet.

-Paul Larson

--=-mXEXJrThjzccSlk2lSmc
Content-Disposition: inline
Content-Description: Forwarded message - [TRIVIAL][PATCH] fix __FUNCTION__
	pasting in sx.c
Content-Type: message/rfc822

Subject: [TRIVIAL][PATCH] fix __FUNCTION__ pasting in sx.c
From: Paul Larson <plars@linuxtestproject.org>
To: Trivial Patch Monkey <trivial@rustcorp.com.au>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 29 Aug 2002 15:49:14 -0500
Message-Id: <1030654155.7151.1.camel@plars.austin.ibm.com>
Mime-Version: 1.0

Trivial fix for __FUNCTION__ pasting in sx.c against current bk tree.

-Paul Larson

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.557   -> 1.558  
#	   drivers/char/sx.c	1.10    -> 1.11   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/29	plars@austin.ibm.com	1.558
# fix __FUNCTION__ pasting in sx.c
# --------------------------------------------
#
diff -Nru a/drivers/char/sx.c b/drivers/char/sx.c
--- a/drivers/char/sx.c	Thu Aug 29 15:43:20 2002
+++ b/drivers/char/sx.c	Thu Aug 29 15:43:20 2002
@@ -405,11 +405,11 @@
 


-#define func_enter() sx_dprintk (SX_DEBUG_FLOW, "sx: enter " __FUNCTION__ "\n")
-#define func_exit()  sx_dprintk (SX_DEBUG_FLOW, "sx: exit  " __FUNCTION__ "\n")
+#define func_enter() sx_dprintk (SX_DEBUG_FLOW, "sx: enter %s\n", __FUNCTION__)
+#define func_exit()  sx_dprintk (SX_DEBUG_FLOW, "sx: exit  %s\n", __FUNCTION__)
 
-#define func_enter2() sx_dprintk (SX_DEBUG_FLOW, "sx: enter " __FUNCTION__ \
-                                  "(port %d)\n", port->line)
+#define func_enter2() sx_dprintk (SX_DEBUG_FLOW, "sx: enter %s (port %d)\n", \
+					__FUNCTION__, port->line)
 



--=-mXEXJrThjzccSlk2lSmc--

