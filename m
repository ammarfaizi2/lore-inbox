Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751852AbWHUKn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbWHUKn6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 06:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbWHUKn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 06:43:58 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2823 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751853AbWHUKn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 06:43:57 -0400
Date: Mon, 21 Aug 2006 12:43:57 +0200
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/wd33c93.c: cleanups
Message-ID: <20060821104357.GH11651@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- #include <linux/irq.h> for getting the prototypes of
  {dis,en}able_irq()
- make the needlessly global wd33c93_setup() static

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc4-mm2/drivers/scsi/wd33c93.c.old	2006-08-21 03:16:42.000000000 +0200
+++ linux-2.6.18-rc4-mm2/drivers/scsi/wd33c93.c	2006-08-21 03:17:10.000000000 +0200
@@ -79,6 +79,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/blkdev.h>
+#include <linux/irq.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
@@ -1710,7 +1711,7 @@
 static char setup_used[MAX_SETUP_ARGS];
 static int done_setup = 0;
 
-int
+static int
 wd33c93_setup(char *str)
 {
 	int i;
