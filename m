Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbVAIKyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVAIKyi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 05:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbVAIKyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 05:54:38 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:28638 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S262082AbVAIKyV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 05:54:21 -0500
Date: Sun, 9 Jan 2005 05:54:18 -0500
From: Hikaru1@verizon.net
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ide-cd in 2.6.8-2.6.10 and 2.4.26-2.4.28 high cpu use with dma
Message-ID: <20050109105418.GD12497@roll>
References: <20050109105201.GB12497@roll>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <20050109105201.GB12497@roll>
User-Agent: Mutt/1.4.2.1i
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [70.19.162.94] at Sun, 9 Jan 2005 04:54:19 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Whoops! Forgot to include the patch.

Sorry.

Timothy Charles McGrath
--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide-cdfix.pat"

diff -ur linux-2.6.10-orig/drivers/ide/ide-cd.c linux-2.6.10/drivers/ide/ide-cd.c
--- linux-2.6.10-orig/drivers/ide/ide-cd.c	2004-12-24 16:34:33.000000000 -0500
+++ linux-2.6.10/drivers/ide/ide-cd.c	2005-01-07 07:49:43.000000000 -0500
@@ -3151,7 +3151,7 @@
 	int nslots;
 
 	blk_queue_prep_rq(drive->queue, ide_cdrom_prep_fn);
-	blk_queue_dma_alignment(drive->queue, 31);
+	blk_queue_dma_alignment(drive->queue, 3);
 	drive->queue->unplug_delay = (1 * HZ) / 1000;
 	if (!drive->queue->unplug_delay)
 		drive->queue->unplug_delay = 1;
Only in linux-2.6.10/drivers/ide: ide-cd.c~

--gBBFr7Ir9EOA20Yy--
