Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262560AbULPA4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbULPA4O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 19:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbULPAza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 19:55:30 -0500
Received: from mail.dif.dk ([193.138.115.101]:39076 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262560AbULPAZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:25:10 -0500
Date: Thu, 16 Dec 2004 01:35:39 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 21/30] return statement cleanup - kill pointless parentheses
 in fs/coda/upcall.c
Message-ID: <Pine.LNX.4.61.0412160134390.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes pointless parentheses from return statements in 
fs/coda/upcall.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.10-rc3-bk8-orig/fs/coda/upcall.c	2004-10-18 23:54:55.000000000 +0200
+++ linux-2.6.10-rc3-bk8/fs/coda/upcall.c	2004-12-15 23:50:18.000000000 +0100
@@ -838,12 +838,12 @@ int coda_downcall(int opcode, union outp
 		   coda_cache_clear_all(sb);
 		   shrink_dcache_sb(sb);
 		   coda_flag_inode(sb->s_root->d_inode, C_FLUSH);
-		   return(0);
+		   return 0;
 	  }
 
 	  case CODA_PURGEUSER : {
 		   coda_cache_clear_all(sb);
-		   return(0);
+		   return 0;
 	  }
 
 	  case CODA_ZAPDIR : {
@@ -857,7 +857,7 @@ int coda_downcall(int opcode, union outp
 			  iput(inode);
 		  }
 		  
-		  return(0);
+		  return 0;
 	  }
 
 	  case CODA_ZAPFILE : {
@@ -901,4 +901,3 @@ int coda_downcall(int opcode, union outp
 	  }
 	  return 0;
 }
-





