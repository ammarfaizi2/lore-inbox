Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbULUAoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbULUAoq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 19:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbULUAoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 19:44:07 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5389 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261491AbULUAl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 19:41:56 -0500
Date: Tue, 21 Dec 2004 01:41:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI megaraid_mm.c: make some code static (fwd)
Message-ID: <20041221004150.GH21288@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.10-rc3-mm1.

Please apply.



----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Mon, 15 Nov 2004 03:14:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI megaraid_mm.c: make some code static

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

