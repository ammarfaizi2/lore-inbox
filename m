Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWIHWzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWIHWzb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 18:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWIHWzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 18:55:16 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:16523 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751236AbWIHWyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 18:54:49 -0400
From: Zach Brown <zach.brown@oracle.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Message-Id: <20060908225448.9340.48382.sendpatchset@kaori.pdx.zabbo.net>
In-Reply-To: <20060908225438.9340.69862.sendpatchset@kaori.pdx.zabbo.net>
References: <20060908225438.9340.69862.sendpatchset@kaori.pdx.zabbo.net>
Subject: [PATCH 2/10] aio: use size_t length modifier in pr_debug format arguments
Date: Fri,  8 Sep 2006 15:54:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aio: use size_t length modifier in pr_debug format arguments

Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 fs/aio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: 2.6.18-rc6-debug-args/fs/aio.c
===================================================================
--- 2.6.18-rc6-debug-args.orig/fs/aio.c
+++ 2.6.18-rc6-debug-args/fs/aio.c
@@ -671,7 +671,7 @@ static ssize_t aio_run_iocb(struct kiocb
 	}
 
 	if (!(iocb->ki_retried & 0xff)) {
-		pr_debug("%ld retry: %d of %d\n", iocb->ki_retried,
+		pr_debug("%ld retry: %zd of %zd\n", iocb->ki_retried,
 			iocb->ki_nbytes - iocb->ki_left, iocb->ki_nbytes);
 	}
 
@@ -1004,7 +1004,7 @@ int fastcall aio_complete(struct kiocb *
 
 	pr_debug("added to ring %p at [%lu]\n", iocb, tail);
 
-	pr_debug("%ld retries: %d of %d\n", iocb->ki_retried,
+	pr_debug("%ld retries: %zd of %zd\n", iocb->ki_retried,
 		iocb->ki_nbytes - iocb->ki_left, iocb->ki_nbytes);
 put_rq:
 	/* everything turned out well, dispose of the aiocb. */
