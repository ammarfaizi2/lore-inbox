Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVAWKPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVAWKPU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 05:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVAWKPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 05:15:20 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:47623 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261268AbVAWKPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 05:15:12 -0500
Date: Sun, 23 Jan 2005 11:15:11 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI NCR_Q720.c: make some code static
Message-ID: <20050123101511.GA3212@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global structs static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 15 Nov 2004

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/NCR_Q720.c.old	2004-11-13 16:34:15.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/NCR_Q720.c	2004-11-13 16:34:32.000000000 +0100
@@ -48,7 +48,7 @@
 	struct Scsi_Host	*hosts[4];
 };
 
-struct scsi_host_template NCR_Q720_tpnt = {
+static struct scsi_host_template NCR_Q720_tpnt = {
 	.module			= THIS_MODULE,
 	.proc_name		= "NCR_Q720",
 };
@@ -345,7 +345,7 @@
 
 static short NCR_Q720_id_table[] = { NCR_Q720_MCA_ID, 0 };
 
-struct mca_driver NCR_Q720_driver = {
+static struct mca_driver NCR_Q720_driver = {
 	.id_table = NCR_Q720_id_table,
 	.driver = {
 		.name		= "NCR_Q720",

