Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbULPA1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbULPA1O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 19:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbULPA0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 19:26:05 -0500
Received: from mail.dif.dk ([193.138.115.101]:48035 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262543AbULPAKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:10:48 -0500
Date: Thu, 16 Dec 2004 01:21:16 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 10/30] return statement cleanup - kill pointless parentheses
 in fs/xfs/support/debug.c
Message-ID: <Pine.LNX.4.61.0412160120190.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes pointless parentheses from return statements in 
fs/xfs/support/debug.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.10-rc3-bk8-orig/fs/xfs/support/debug.c	2004-10-18 23:53:21.000000000 +0200
+++ linux-2.6.10-rc3-bk8/fs/xfs/support/debug.c	2004-12-15 22:51:25.000000000 +0100
@@ -70,7 +70,7 @@ random(void)
 	lo = rv % 127773;
 	rv = 16807 * lo - 2836 * hi;
 	if( rv <= 0 ) rv += 2147483647;
-	return( RandomValue = rv );
+	return (RandomValue = rv);
 }
 
 int



