Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262940AbUJ1WUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbUJ1WUD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 18:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbUJ1WT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 18:19:56 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57614 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262940AbUJ1WOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 18:14:45 -0400
Date: Fri, 29 Oct 2004 00:14:13 +0200
From: Adrian Bunk <bunk@stusta.de>
To: dm-devel@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] dm: remove unused functions
Message-ID: <20041028221413.GK3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes two unsed functions from dm code.


diffstat output:
 drivers/md/dm-io.c   |   16 ----------------
 drivers/md/dm-snap.c |    5 -----
 2 files changed, 21 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/drivers/md/dm-io.c.old	2004-10-28 23:03:35.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/md/dm-io.c	2004-10-28 23:03:44.000000000 +0200
@@ -149,22 +149,6 @@
 	return 0;
 }
 
- -static inline void bs_bio_init(struct bio *bio)
- -{
- -	bio->bi_next = NULL;
- -	bio->bi_flags = 1 << BIO_UPTODATE;
- -	bio->bi_rw = 0;
- -	bio->bi_vcnt = 0;
- -	bio->bi_idx = 0;
- -	bio->bi_phys_segments = 0;
- -	bio->bi_hw_segments = 0;
- -	bio->bi_size = 0;
- -	bio->bi_max_vecs = 0;
- -	bio->bi_end_io = NULL;
- -	atomic_set(&bio->bi_cnt, 1);
- -	bio->bi_private = NULL;
- -}
- -
 static unsigned _bio_count = 0;
 struct bio *bio_set_alloc(struct bio_set *bs, int gfp_mask, int nr_iovecs)
 {
- --- linux-2.6.10-rc1-mm1-full/drivers/md/dm-snap.c.old	2004-10-28 23:04:16.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/md/dm-snap.c	2004-10-28 23:04:24.000000000 +0200
@@ -271,11 +271,6 @@
 	return e;
 }
 
- -static inline void free_exception(struct exception *e)
- -{
- -	kmem_cache_free(exception_cache, e);
- -}
- -
 static inline struct pending_exception *alloc_pending_exception(void)
 {
 	return mempool_alloc(pending_pool, GFP_NOIO);
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgW81mfzqmE8StAARAoYsAKDBEpKORD8iJPSKS6UmDZsm/Uwa6ACfXgi0
oYRbUOT1YyHHFq0lkpHhpW0=
=z6pR
-----END PGP SIGNATURE-----
