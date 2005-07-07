Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVGGVdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVGGVdK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 17:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbVGGVbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 17:31:18 -0400
Received: from coderock.org ([193.77.147.115]:9100 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261934AbVGGVaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 17:30:04 -0400
Message-Id: <20050707212954.950374000@homer>
Date: Thu, 07 Jul 2005 23:29:53 +0200
From: domen@coderock.org
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, Victor Fusco <victor@cetuc.puc-rio.br>,
       domen@coderock.org
Subject: [patch 2/4] deadline-iosched: fix sparse warnings (__nocast type)
Content-Disposition: inline; filename=sparse-drivers_block_deadline-iosched
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Fusco <victor@cetuc.puc-rio.br>


Fix the sparse warning "implicit cast to nocast type"
 
File/Subsystem: drivers/block/deadline-iosched

Signed-off-by: Victor Fusco <victor@cetuc.puc-rio.br>
Signed-off-by: Domen Puncer <domen@coderock.org>
 

---
 deadline-iosched.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: quilt/drivers/block/deadline-iosched.c
===================================================================
--- quilt.orig/drivers/block/deadline-iosched.c
+++ quilt/drivers/block/deadline-iosched.c
@@ -761,7 +761,7 @@ static void deadline_put_request(request
 
 static int
 deadline_set_request(request_queue_t *q, struct request *rq, struct bio *bio,
-		     int gfp_mask)
+		    unsigned int __nocast gfp_mask)
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
 	struct deadline_rq *drq;

--
