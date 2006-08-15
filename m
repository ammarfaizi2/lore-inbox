Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752079AbWHOCtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbWHOCtq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 22:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbWHOCtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 22:49:46 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26376 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752079AbWHOCtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 22:49:45 -0400
Date: Tue, 15 Aug 2006 02:42:25 +0200
From: Adrian Bunk <bunk@stusta.de>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>, dwmw2@infradead.org
Cc: jffs-dev@axis.com, linux-kernel@vger.kernel.or
Subject: [2.6 patch] fs/jffs2/xattr.c: remove dead code
Message-ID: <20060815004225.GH3543@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes some obvious dead code spotted by the Coverity 
checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc4-mm1/fs/jffs2/xattr.c.old	2006-08-15 02:11:07.000000000 +0200
+++ linux-2.6.18-rc4-mm1/fs/jffs2/xattr.c	2006-08-15 02:11:25.000000000 +0200
@@ -1215,7 +1215,6 @@ int jffs2_garbage_collect_xattr_datum(st
 	rc = jffs2_reserve_space_gc(c, totlen, &length, JFFS2_SUMMARY_XATTR_SIZE);
 	if (rc) {
 		JFFS2_WARNING("jffs2_reserve_space_gc()=%d, request=%u\n", rc, totlen);
-		rc = rc ? rc : -EBADFD;
 		goto out;
 	}
 	rc = save_xattr_datum(c, xd);

