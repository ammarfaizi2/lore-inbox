Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbUKOCJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUKOCJa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 21:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUKOCJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 21:09:23 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:11276 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261411AbUKOCH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:07:29 -0500
Date: Mon, 15 Nov 2004 02:54:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Red Hat <alan@redhat.com>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI atp870u.c: make a needlessly global function static
Message-ID: <20041115015430.GF2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes the function is870 which has no external users 
static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/atp870u.c.old	2004-11-13 17:17:15.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/atp870u.c	2004-11-13 17:17:41.000000000 +0100
@@ -1085,7 +1085,7 @@
 
 }
 
-void is870(struct Scsi_Host *host, unsigned int wkport)
+static void is870(struct Scsi_Host *host, unsigned int wkport)
 {
 	unsigned int tmport;
 	unsigned char i, j, k, rmb, n;

