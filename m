Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbUKODvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUKODvH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 22:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbUKOC16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 21:27:58 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26387 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261463AbUKOC1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:27:00 -0500
Date: Mon, 15 Nov 2004 03:14:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI megaraid_mm.c: make some code static
Message-ID: <20041115021457.GQ2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/megaraid/megaraid_mm.c.old	2004-11-13 22:43:49.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/megaraid/megaraid_mm.c	2004-11-13 22:43:58.000000000 +0100
@@ -65,7 +65,7 @@
 static int adapters_count_g;
 static struct list_head adapters_list_g;
 
-wait_queue_head_t wait_q;
+static wait_queue_head_t wait_q;
 
 static struct file_operations lsi_fops = {
 	.open	= mraid_mm_open,

