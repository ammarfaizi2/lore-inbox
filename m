Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbTEJKqv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 06:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbTEJKqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 06:46:51 -0400
Received: from dclient217-162-28-172.hispeed.ch ([217.162.28.172]:14094 "EHLO
	homegate.delouw.ch") by vger.kernel.org with ESMTP id S261213AbTEJKqt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 06:46:49 -0400
Message-ID: <3EBCD7F0.3040700@delouw.ch>
Date: Sat, 10 May 2003 12:44:00 +0200
From: Luc de Louw <luc@delouw.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: de-ch, zh, en-us, ro, eu, fr-fr, da, ru, pt, hu, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCHLET] for typo in reiserfs in 2.4.21-rc2
Content-Type: multipart/mixed;
 boundary="------------030007030203050309040507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030007030203050309040507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I found a small typo in fs/reiserfs/do_balan.c which makes in unable to 
compile the reiserfs module.

Patchlet attached.

rgds

Luc

--------------030007030203050309040507
Content-Type: text/plain;
 name="do_balan.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="do_balan.c.diff"

--- linux-2.4.21-rc2/fs/reiserfs/do_balan.c	2003-05-10 12:38:59.000000000 +0200
+++ linux-2.4.21-rc2-luc/fs/reiserfs/do_balan.c	2003-05-10 12:30:04.000000000 +0200
@@ -801,7 +801,7 @@
 	if (tb->CFL[0]) {
 	    if (!tb->CFR[0])
 		reiserfs_panic (tb->tb_sb, "vs-12195: balance_leaf: CFR not initialized");
-	    copy_key (B_N_PDELIM_KEY (tb->CFL[0], tb->lkey[0]), B_N_PDELIM_KEY (tb->CFR[0], tb-<rkey[0]));
+	    copy_key (B_N_PDELIM_KEY (tb->CFL[0], tb->lkey[0]), B_N_PDELIM_KEY (tb->CFR[0], tb->rkey[0]));
 	    do_balance_mark_internal_dirty (tb, tb->CFL[0], 0);
 	}
 

--------------030007030203050309040507--

