Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318860AbSIIUbz>; Mon, 9 Sep 2002 16:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318888AbSIIUbz>; Mon, 9 Sep 2002 16:31:55 -0400
Received: from pop016pub.verizon.net ([206.46.170.173]:36518 "EHLO
	pop016.verizon.net") by vger.kernel.org with ESMTP
	id <S318860AbSIIUby>; Mon, 9 Sep 2002 16:31:54 -0400
Message-Id: <200209092047.g89KldtA000217@pool-141-150-242-242.delv.east.verizon.net>
Date: Mon, 9 Sep 2002 16:47:37 -0400
From: Skip Ford <skip.ford@verizon.net>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] 2.5.34 ufs/super.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at pop016.verizon.net from [141.150.242.242] using ID <vze2j9fk@verizon.net> at Mon, 9 Sep 2002 15:36:34 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've needed this patch since 2.5.32 to successfully mount a UFS
partition.

--- linux/fs/ufs/super.c~	Mon Sep  9 16:39:52 2002
+++ linux/fs/ufs/super.c	Mon Sep  9 16:39:57 2002
@@ -605,7 +605,7 @@
 	}
 	
 again:	
-	if (sb_set_blocksize(sb, block_size)) {
+	if (!sb_set_blocksize(sb, block_size)) {
 		printk(KERN_ERR "UFS: failed to set blocksize\n");
 		goto failed;
 	}

-- 
Skip
