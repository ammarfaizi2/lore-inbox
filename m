Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbUKOCMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbUKOCMM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 21:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbUKOCMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 21:12:06 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32269 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261421AbUKOCLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:11:05 -0500
Date: Mon, 15 Nov 2004 02:57:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: deanna_bonds@adaptec.com
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI: dpt_i2o.c: make some code static
Message-ID: <20041115015736.GH2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/dpt_i2o.c.old	2004-11-13 21:01:47.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/dpt_i2o.c	2004-11-13 21:01:57.000000000 +0100
@@ -108,7 +108,7 @@
  *============================================================================
  */
 
-DECLARE_MUTEX(adpt_configuration_lock);
+static DECLARE_MUTEX(adpt_configuration_lock);
 
 static struct i2o_sys_tbl *sys_tbl = NULL;
 static int sys_tbl_ind = 0;

