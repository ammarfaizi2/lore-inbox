Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbULaBvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbULaBvt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 20:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbULaBvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 20:51:49 -0500
Received: from mail.dif.dk ([193.138.115.101]:48842 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261807AbULaBvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 20:51:47 -0500
Date: Fri, 31 Dec 2004 03:02:57 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: David Howells <dhowells@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [patch] add loglevel to printk in fs/afs/cmservice.c
Message-ID: <Pine.LNX.4.61.0412310259230.4725@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

below is a small patch that adds loglevel to a printk in 
fs/afs/cmservice.c

If considered OK please consider applying.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-bk2-orig/fs/afs/cmservice.c linux-2.6.10-bk2/fs/afs/cmservice.c
--- linux-2.6.10-bk2-orig/fs/afs/cmservice.c	2004-12-24 22:34:44.000000000 +0100
+++ linux-2.6.10-bk2/fs/afs/cmservice.c	2004-12-31 02:59:13.000000000 +0100
@@ -118,7 +118,7 @@ static int kafscmd(void *arg)
 	_SRXAFSCM_xxxx_t func;
 	int die;
 
-	printk("kAFS: Started kafscmd %d\n", current->pid);
+	printk(KERN_INFO "kAFS: Started kafscmd %d\n", current->pid);
 
 	daemonize("kafscmd");
 




