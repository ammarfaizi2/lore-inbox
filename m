Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756512AbWKVTAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756512AbWKVTAQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 14:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756580AbWKVTAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 14:00:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30367 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1756575AbWKVTAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 14:00:13 -0500
Date: Wed, 22 Nov 2006 19:00:05 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>,
       Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Subject: [PATCH 02/11] dm: tidy core formatting
Message-ID: <20061122190005.GS6993@agk.surrey.redhat.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, dm-devel@redhat.com,
	Jun'ichi Nomura <j-nomura@ce.jp.nec.com>,
	Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>

This patch removes unnecessary spaces in dm.c.

Signed-off-by: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Cc: dm-devel@redhat.com

Index: linux-2.6.19-rc6/drivers/md/dm.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/md/dm.c	2006-11-22 17:26:47.000000000 +0000
+++ linux-2.6.19-rc6/drivers/md/dm.c	2006-11-22 17:26:56.000000000 +0000
@@ -89,7 +89,7 @@ struct mapped_device {
 	 */
 	atomic_t pending;
 	wait_queue_head_t wait;
- 	struct bio_list deferred;
+	struct bio_list deferred;
 
 	/*
 	 * The current mapping.
@@ -482,7 +482,6 @@ static int clone_endio(struct bio *bio, 
 		r = endio(tio->ti, bio, error, &tio->info);
 		if (r < 0)
 			error = r;
-
 		else if (r > 0)
 			/* the target wants another shot at the io */
 			return 1;
@@ -551,9 +550,7 @@ static void __map_bio(struct dm_target *
 				    clone->bi_sector);
 
 		generic_make_request(clone);
-	}
-
-	else if (r < 0) {
+	} else if (r < 0) {
 		/* error the io and bail out */
 		md = tio->io->md;
 		dec_pending(tio->io, r);
@@ -966,8 +963,8 @@ static struct mapped_device *alloc_dev(i
 	md->queue->issue_flush_fn = dm_flush_all;
 
 	md->io_pool = mempool_create_slab_pool(MIN_IOS, _io_cache);
- 	if (!md->io_pool)
- 		goto bad2;
+	if (!md->io_pool)
+		goto bad2;
 
 	md->tio_pool = mempool_create_slab_pool(MIN_IOS, _tio_cache);
 	if (!md->tio_pool)
