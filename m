Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262583AbULPBxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbULPBxn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 20:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbULPAzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 19:55:14 -0500
Received: from mail.dif.dk ([193.138.115.101]:41380 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262545AbULPAZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:25:58 -0500
Date: Thu, 16 Dec 2004 01:36:27 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 22/30] return statement cleanup - kill pointless parentheses
 in fs/coda/psdev.c
Message-ID: <Pine.LNX.4.61.0412160135470.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes pointless parentheses from return statements in 
fs/coda/psdev.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.10-rc3-bk8-orig/fs/coda/psdev.c	2004-10-18 23:54:37.000000000 +0200
+++ linux-2.6.10-rc3-bk8/fs/coda/psdev.c	2004-12-15 23:51:12.000000000 +0100
@@ -205,7 +205,7 @@ static ssize_t coda_psdev_write(struct f
 
         wake_up(&req->uc_sleep);
 out:
-        return(count ? count : retval);  
+        return count ? count : retval;
 }
 
 /*
@@ -271,7 +271,7 @@ static ssize_t coda_psdev_read(struct fi
 	upc_free(req);
 out:
 	unlock_kernel();
-	return (count ? count : retval);
+	return count ? count : retval;
 }
 
 static int coda_psdev_open(struct inode * inode, struct file * file)



