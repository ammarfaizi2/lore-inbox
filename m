Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbULPA44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbULPA44 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 19:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbULPA4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 19:56:22 -0500
Received: from mail.dif.dk ([193.138.115.101]:51876 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262537AbULPA3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:29:05 -0500
Date: Thu, 16 Dec 2004 01:39:29 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 25/30] return statement cleanup - kill pointless parentheses
 in net/irda/irnet/irnet.h
Message-ID: <Pine.LNX.4.61.0412160138330.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes pointless parentheses from return statements in 
net/irda/irnet/irnet.h

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.10-rc3-bk8-orig/net/irda/irnet/irnet.h	2004-10-18 23:54:39.000000000 +0200
+++ linux-2.6.10-rc3-bk8/net/irda/irnet/irnet.h	2004-12-15 23:56:32.000000000 +0100
@@ -363,13 +363,13 @@
 /* Exit a function with debug */
 #define DRETURN(ret, dbg, args...) \
 	{DEXIT(dbg, ": " args);\
-	return(ret); }
+	return ret; }
 
 /* Exit a function on failed condition */
 #define DABORT(cond, ret, dbg, args...) \
 	{if(cond) {\
 		DERROR(dbg, args);\
-		return(ret); }}
+		return ret; }}
 
 /* Invalid assertion, print out an error and exit... */
 #define DASSERT(cond, ret, dbg, args...) \



