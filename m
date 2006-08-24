Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWHXHlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWHXHlh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 03:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWHXHl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 03:41:28 -0400
Received: from cantor.suse.de ([195.135.220.2]:38356 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750804AbWHXHlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 03:41:17 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 24 Aug 2006 17:41:18 +1000
Message-Id: <1060824074118.19171@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 004 of 4] md: Remove unnecessary variable x in stripe_to_pdidx().
References: <20060824173647.19026.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From : Coywolf Qi Hunt <qiyong@freeforge.net>

Signed-off-by: Coywolf Qi Hunt <qiyong@freeforge.net>


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff .prev/drivers/md/raid5.c ./drivers/md/raid5.c
--- .prev/drivers/md/raid5.c	2006-08-24 17:09:42.000000000 +1000
+++ ./drivers/md/raid5.c	2006-08-24 17:24:17.000000000 +1000
@@ -1350,10 +1350,9 @@ static int page_is_zero(struct page *p)
 static int stripe_to_pdidx(sector_t stripe, raid5_conf_t *conf, int disks)
 {
 	int sectors_per_chunk = conf->chunk_size >> 9;
-	sector_t x = stripe;
 	int pd_idx, dd_idx;
-	int chunk_offset = sector_div(x, sectors_per_chunk);
-	stripe = x;
+	int chunk_offset = sector_div(stripe, sectors_per_chunk);
+
 	raid5_compute_sector(stripe*(disks-1)*sectors_per_chunk
 			     + chunk_offset, disks, disks-1, &dd_idx, &pd_idx, conf);
 	return pd_idx;
