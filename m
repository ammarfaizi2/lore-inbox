Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262437AbVAUSAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbVAUSAg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 13:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVAUSAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 13:00:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44191 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262437AbVAUR6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 12:58:37 -0500
Date: Fri, 21 Jan 2005 17:58:28 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: device-mapper: remove unused bs_bio_init()
Message-ID: <20050121175828.GG10195@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused bs_bio_init().

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
--- diff/drivers/md/dm-io.c	2005-01-12 15:21:22.000000000 +0000
+++ source/drivers/md/dm-io.c	2005-01-12 18:58:09.000000000 +0000
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
