Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbULPBKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbULPBKq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 20:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbULPBKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 20:10:22 -0500
Received: from mail.dif.dk ([193.138.115.101]:2725 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262585AbULPAcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:32:45 -0500
Date: Thu, 16 Dec 2004 01:43:11 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH 29/30] return statement cleanup - kill pointless parentheses
 in kernel/signal.c
Message-ID: <Pine.LNX.4.61.0412160142240.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes pointless parentheses from return statements in 
kernel/signal.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.10-rc3-bk8-orig/kernel/signal.c	2004-12-06 22:24:56.000000000 +0100
+++ linux-2.6.10-rc3-bk8/kernel/signal.c	2004-12-16 00:04:32.000000000 +0100
@@ -279,7 +279,7 @@ static struct sigqueue *__sigqueue_alloc
 		q->user = get_uid(t->user);
 		atomic_inc(&q->user->sigpending);
 	}
-	return(q);
+	return q;
 }
 
 static inline void __sigqueue_free(struct sigqueue *q)
@@ -1294,7 +1294,7 @@ struct sigqueue *sigqueue_alloc(void)
 
 	if ((q = __sigqueue_alloc(current, GFP_KERNEL)))
 		q->flags |= SIGQUEUE_PREALLOC;
-	return(q);
+	return q;
 }
 
 void sigqueue_free(struct sigqueue *q)
@@ -1358,7 +1358,7 @@ send_sigqueue(int sig, struct sigqueue *
 out:
 	spin_unlock_irqrestore(&p->sighand->siglock, flags);
 	read_unlock(&tasklist_lock);
-	return(ret);
+	return ret;
 }
 
 int
@@ -1403,7 +1403,7 @@ send_group_sigqueue(int sig, struct sigq
 out:
 	spin_unlock_irqrestore(&p->sighand->siglock, flags);
 	read_unlock(&tasklist_lock);
-	return(ret);
+	return ret;
 }
 
 /*


