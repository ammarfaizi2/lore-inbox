Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVGBOId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVGBOId (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 10:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVGBOId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 10:08:33 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:46864 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S261168AbVGBOI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 10:08:28 -0400
Date: Sat, 2 Jul 2005 22:04:40 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] autofs4 - mistake in debug print
Message-ID: <Pine.LNX.4.63.0507022201220.5902@donald.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-98.9, required 8,
	RCVD_IN_ORBS, RCVD_IN_OSIRUSOFT_COM, USER_AGENT_PINE,
	USER_IN_WHITELIST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry, I made a mistake in one of my last patches.

Signed-off-by: Ian Kent <raven@themaw.net>

--- linux-2.6.13-rc1-mm1/fs/autofs4/waitq.c.debug-print	2005-07-02 21:57:00.000000000 +0800
+++ linux-2.6.13-rc1-mm1/fs/autofs4/waitq.c	2005-07-02 21:56:04.000000000 +0800
@@ -231,8 +231,8 @@ int autofs4_wait(struct autofs_sb_info *
 		int type = (notify == NFY_MOUNT ?
 			autofs_ptype_missing : autofs_ptype_expire_multi);
 
-		DPRINTK(("new wait id = 0x%08lx, name = %.*s, nfy=%d\n",
-			(unsigned long) wq->wait_queue_token, wq->len, wq->name, notify));
+		DPRINTK("new wait id = 0x%08lx, name = %.*s, nfy=%d\n",
+			(unsigned long) wq->wait_queue_token, wq->len, wq->name, notify);
 
 		/* autofs4_notify_daemon() may block */
 		autofs4_notify_daemon(sbi, wq, type);
