Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbUKOC3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbUKOC3c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 21:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUKOC2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 21:28:14 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:61970 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261447AbUKOCZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:25:47 -0500
Date: Mon, 15 Nov 2004 03:13:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI mca_53c9x.c: make 2 functions static
Message-ID: <20041115021334.GP2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes two functions without external users static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/mca_53c9x.c.old	2004-11-13 22:42:09.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/mca_53c9x.c	2004-11-13 22:42:22.000000000 +0100
@@ -103,7 +103,7 @@
 static struct ESP_regs eregs;
 
 /***************************************************************** Detection */
-int mca_esp_detect(Scsi_Host_Template *tpnt)
+static int mca_esp_detect(Scsi_Host_Template *tpnt)
 {
 	struct NCR_ESP *esp;
 	static int io_port_by_pos[] = MCA_53C9X_IO_PORTS;
@@ -283,7 +283,7 @@
 
 /******************************************************************* Release */
 
-int mca_esp_release(struct Scsi_Host *host)
+static int mca_esp_release(struct Scsi_Host *host)
 {
 	struct NCR_ESP *esp = (struct NCR_ESP *)host->hostdata;
 	unsigned char tmp_byte;

