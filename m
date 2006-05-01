Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWEAUzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWEAUzm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 16:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWEAUzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 16:55:41 -0400
Received: from mail.fuug.fi ([83.145.198.117]:5073 "EHLO mail.fuug.fi")
	by vger.kernel.org with ESMTP id S932253AbWEAUzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 16:55:41 -0400
Date: Mon, 1 May 2006 23:55:27 +0300 (EEST)
From: "Petri T. Koistinen" <petri.koistinen@iki.fi>
To: Andrew Morton <akpm@osdl.org>
cc: trivial@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/bio.c: initialize variable, remove warning
Message-ID: <Pine.LNX.4.64.0605012353100.5245@joo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petri T. Koistinen <petri.koistinen@iki.fi>

Remove compiler warning by initializing uninitialized variable.

Signed-off-by: Petri T. Koistinen <petri.koistinen@iki.fi>
---
 fs/bio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
---
diff --git a/fs/bio.c b/fs/bio.c
index eb8fbc5..c4deed9 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -166,7 +166,7 @@ struct bio *bio_alloc_bioset(gfp_t gfp_m

 		bio_init(bio);
 		if (likely(nr_iovecs)) {
-			unsigned long idx;
+			unsigned long idx = 0;

 			bvl = bvec_alloc_bs(gfp_mask, nr_iovecs, &idx, bs);
 			if (unlikely(!bvl)) {


