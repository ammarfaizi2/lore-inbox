Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWBCU0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWBCU0S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945947AbWBCU0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:26:14 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39437 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751302AbWBCU0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:26:13 -0500
Date: Fri, 3 Feb 2006 21:26:11 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Hannes Reinecke <hare@suse.de>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/aic7xxx/aic79xx_core.c: make ahd_done_with_status() static
Message-ID: <20060203202611.GH4408@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc1-mm5-full/drivers/scsi/aic7xxx/aic79xx_core.c.old	2006-02-03 16:41:13.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/drivers/scsi/aic7xxx/aic79xx_core.c	2006-02-03 16:41:28.000000000 +0100
@@ -7382,7 +7382,7 @@
 	ahd->flags &= ~AHD_UPDATE_PEND_CMDS;
 }
 
-void
+static void
 ahd_done_with_status(struct ahd_softc *ahd, struct scb *scb, uint32_t status)
 {
 	cam_status ostat;

