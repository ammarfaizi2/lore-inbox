Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbTE1GQL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 02:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264547AbTE1GQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 02:16:11 -0400
Received: from sullivan.realtime.net ([205.238.132.76]:49165 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id S264546AbTE1GQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 02:16:10 -0400
Date: Wed, 28 May 2003 01:29:21 -0500 (CDT)
Message-Id: <200305280629.h4S6TLUY027859@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] copy the tag_map
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jens

saw this on checkin ...

milton

===== drivers/block/ll_rw_blk.c 1.171 vs edited =====
--- 1.171/drivers/block/ll_rw_blk.c	Tue May 27 15:21:00 2003
+++ edited/drivers/block/ll_rw_blk.c	Wed May 28 00:43:33 2003
@@ -553,7 +553,7 @@
 
 	memcpy(bqt->tag_index, tag_index, max_depth * sizeof(struct request *));
 	bits = max_depth / BLK_TAGS_PER_LONG;
-	memcpy(bqt->tag_map, bqt->tag_map, bits * sizeof(unsigned long));
+	memcpy(bqt->tag_map, tag_map, bits * sizeof(unsigned long));
 
 	kfree(tag_index);
 	kfree(tag_map);
