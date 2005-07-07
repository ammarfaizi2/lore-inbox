Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbVGGVdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbVGGVdK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 17:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbVGGVbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 17:31:11 -0400
Received: from coderock.org ([193.77.147.115]:10636 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262028AbVGGVaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 17:30:11 -0400
Message-Id: <20050707212957.724863000@homer>
Date: Thu, 07 Jul 2005 23:29:55 +0200
From: domen@coderock.org
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, Victor Fusco <victor@cetuc.puc-rio.br>,
       domen@coderock.org
Subject: [patch 4/4] as-iosched: fix sparse warnings (__nocast type)
Content-Disposition: inline; filename=sparse-drivers_block_as-iosched
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Fusco <victor@cetuc.puc-rio.br>


Fix the sparse warning "implicit cast to nocast type"
 
File/Subsystem: drivers/block/as-iosched

Signed-off-by: Victor Fusco <victor@cetuc.puc-rio.br>
Signed-off-by: Domen Puncer <domen@coderock.org>
 

---
 as-iosched.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: quilt/drivers/block/as-iosched.c
===================================================================
--- quilt.orig/drivers/block/as-iosched.c
+++ quilt/drivers/block/as-iosched.c
@@ -1807,7 +1807,7 @@ static void as_put_request(request_queue
 }
 
 static int as_set_request(request_queue_t *q, struct request *rq,
-			  struct bio *bio, int gfp_mask)
+			  struct bio *bio, unsigned int __nocast gfp_mask)
 {
 	struct as_data *ad = q->elevator->elevator_data;
 	struct as_rq *arq = mempool_alloc(ad->arq_pool, gfp_mask);

--
