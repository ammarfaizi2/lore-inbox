Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbUKODwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbUKODwd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 22:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbUKODvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 22:51:35 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39952 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261438AbUKOCTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:19:18 -0500
Date: Mon, 15 Nov 2004 03:07:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] ide-scsi.c: make 2 functions static
Message-ID: <20041115020755.GM2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes two functions without external users static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/ide-scsi.c.old	2004-11-13 21:51:26.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/ide-scsi.c	2004-11-13 21:51:41.000000000 +0100
@@ -301,7 +301,7 @@
 	return ide_do_drive_cmd(drive, rq, ide_preempt);
 }
 
-ide_startstop_t idescsi_atapi_error (ide_drive_t *drive, const char *msg, byte stat)
+static ide_startstop_t idescsi_atapi_error (ide_drive_t *drive, const char *msg, byte stat)
 {
 	struct request *rq;
 	byte err;
@@ -327,7 +327,7 @@
 	return ide_stopped;
 }
 
-ide_startstop_t idescsi_atapi_abort (ide_drive_t *drive, const char *msg)
+static ide_startstop_t idescsi_atapi_abort (ide_drive_t *drive, const char *msg)
 {
 	struct request *rq;
 

