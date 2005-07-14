Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVGNV4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVGNV4J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 17:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbVGNVoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 17:44:37 -0400
Received: from coderock.org ([193.77.147.115]:60064 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S263136AbVGNVnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 17:43:18 -0400
Message-Id: <20050714214248.726446000@homer>
Date: Thu, 14 Jul 2005 23:42:49 +0200
From: domen@coderock.org
To: clemens@endorphin.org
Cc: linux-kernel@vger.kernel.org, Victor Fusco <victor@cetuc.puc-rio.br>,
       domen@coderock.org
Subject: [patch 1/1] dm-crypt: Fix "nocast type" warnings
Content-Disposition: inline; filename=sparse-drivers_md_dm-crypt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Fusco <victor@cetuc.puc-rio.br>


Fix the sparse warning "implicit cast to nocast type"

File/Subsystem:drivers/md/dm-crypt.c

Signed-off-by: Victor Fusco <victor@cetuc.puc-rio.br>
Signed-off-by: Domen Puncer <domen@coderock.org>

--

---
 dm-crypt.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: quilt/drivers/md/dm-crypt.c
===================================================================
--- quilt.orig/drivers/md/dm-crypt.c
+++ quilt/drivers/md/dm-crypt.c
@@ -330,7 +330,7 @@ crypt_alloc_buffer(struct crypt_config *
 {
 	struct bio *bio;
 	unsigned int nr_iovecs = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	int gfp_mask = GFP_NOIO | __GFP_HIGHMEM;
+	unsigned int gfp_mask = GFP_NOIO | __GFP_HIGHMEM;
 	unsigned int i;
 
 	/*

--
