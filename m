Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbVB1WDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbVB1WDg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 17:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVB1WDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 17:03:36 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:11273 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261775AbVB1WB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 17:01:56 -0500
Date: Mon, 28 Feb 2005 23:01:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: matthew@wil.cx
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/sym53c8xx_2/sym_hipd.c: make a function static
Message-ID: <20050228220155.GS4021@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/sym53c8xx_2/sym_hipd.c |    2 +-
 drivers/scsi/sym53c8xx_2/sym_hipd.h |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.11-rc4-mm1-full/drivers/scsi/sym53c8xx_2/sym_hipd.h.old	2005-02-28 20:29:13.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/sym53c8xx_2/sym_hipd.h	2005-02-28 20:29:19.000000000 +0100
@@ -1091,7 +1091,6 @@
 lcb_p sym_alloc_lcb (struct sym_hcb *np, u_char tn, u_char ln);
 int sym_queue_scsiio(struct sym_hcb *np, struct scsi_cmnd *csio, ccb_p cp);
 int sym_abort_scsiio(struct sym_hcb *np, struct scsi_cmnd *ccb, int timed_out);
-int sym_abort_ccb(struct sym_hcb *np, ccb_p cp, int timed_out);
 int sym_reset_scsi_target(struct sym_hcb *np, int target);
 void sym_hcb_free(struct sym_hcb *np);
 int sym_hcb_attach(struct sym_hcb *np, struct sym_fw *fw, struct sym_nvram *nvram);
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/sym53c8xx_2/sym_hipd.c.old	2005-02-28 20:29:27.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/sym53c8xx_2/sym_hipd.c	2005-02-28 20:29:40.000000000 +0100
@@ -5351,7 +5351,7 @@
 /*
  *  Abort a SCSI IO.
  */
-int sym_abort_ccb(struct sym_hcb *np, ccb_p cp, int timed_out)
+static int sym_abort_ccb(struct sym_hcb *np, ccb_p cp, int timed_out)
 {
 	/*
 	 *  Check that the IO is active.

