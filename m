Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbUK2Cb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbUK2Cb5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 21:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbUK2C35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 21:29:57 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35085 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261621AbUK2C3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 21:29:41 -0500
Date: Mon, 29 Nov 2004 03:29:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] dm: remove unused functions (fwd)
Message-ID: <20041129022940.GQ4390@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch forwarded below still applies and compiles against 
2.6.10-rc2-mm3.

Please apply or comment on it.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Fri, 29 Oct 2004 02:15:49 +0200
From: Adrian Bunk <bunk@stusta.de>
To: dm-devel@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] dm: remove unused functions

[ this time without the problems due to a digital signature... ]

The patch below removes two unsed functions from dm code.


diffstat output:
 drivers/md/dm-io.c   |   16 ----------------
 drivers/md/dm-snap.c |    5 -----
 2 files changed, 21 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/drivers/md/dm-io.c.old	2004-10-28 23:03:35.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/md/dm-io.c	2004-10-28 23:03:44.000000000 +0200
@@ -149,22 +149,6 @@
 	return 0;
 }
 
-static inline void bs_bio_init(struct bio *bio)
-{
-	bio->bi_next = NULL;
-	bio->bi_flags = 1 << BIO_UPTODATE;
-	bio->bi_rw = 0;
-	bio->bi_vcnt = 0;
-	bio->bi_idx = 0;
-	bio->bi_phys_segments = 0;
-	bio->bi_hw_segments = 0;
-	bio->bi_size = 0;
-	bio->bi_max_vecs = 0;
-	bio->bi_end_io = NULL;
-	atomic_set(&bio->bi_cnt, 1);
-	bio->bi_private = NULL;
-}
-
 static unsigned _bio_count = 0;
 struct bio *bio_set_alloc(struct bio_set *bs, int gfp_mask, int nr_iovecs)
 {
--- linux-2.6.10-rc1-mm1-full/drivers/md/dm-snap.c.old	2004-10-28 23:04:16.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/md/dm-snap.c	2004-10-28 23:04:24.000000000 +0200
@@ -271,11 +271,6 @@
 	return e;
 }
 
-static inline void free_exception(struct exception *e)
-{
-	kmem_cache_free(exception_cache, e);
-}
-
 static inline struct pending_exception *alloc_pending_exception(void)
 {
 	return mempool_alloc(pending_pool, GFP_NOIO);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

