Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274000AbRIXQag>; Mon, 24 Sep 2001 12:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273996AbRIXQa1>; Mon, 24 Sep 2001 12:30:27 -0400
Received: from bambam.amazingmedia.com ([192.245.235.57]:44577 "HELO
	bambam.amazingmedia.com") by vger.kernel.org with SMTP
	id <S273992AbRIXQaS>; Mon, 24 Sep 2001 12:30:18 -0400
Date: Mon, 24 Sep 2001 12:30:36 -0400 (EDT)
From: Ward Fenton <ward@amazingmedia.com>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
Subject: block-highmem-all-15 has sym53c8xx.h glitch
Message-ID: <Pine.LNX.4.21.0109241216390.10084-100000@bambam.amazingmedia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wasn't able to compile 2.4.10 patched with Jens Axboe's latest zero
bounce patch found below until fixing a small problem with
drivers/scsi/sym53c8xx.h

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.10/block-highmem-all-15


--- v2.4.10/linux/drivers/scsi/sym53c8xx.h.orig	Mon Sep 24 12:12:29 2001
+++ linux/drivers/scsi/sym53c8xx.h	Mon Sep 24 12:11:41 2001
@@ -97,7 +97,7 @@
 			sg_tablesize:   SCSI_NCR_SG_TABLESIZE,	\
 			cmd_per_lun:    SCSI_NCR_CMD_PER_LUN,	\
 			max_sectors:    MAX_SEGMENTS*8,		\
-			use_clustering: DISABLE_CLUSTERING},	\
+			use_clustering: DISABLE_CLUSTERING,	\
 			can_dma_32:	1,			\
 			single_sg_ok:	1}
 

Ward Fenton

