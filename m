Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933870AbWKTC2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933870AbWKTC2d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 21:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933871AbWKTC2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 21:28:15 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38417 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933870AbWKTCXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 21:23:50 -0500
Date: Mon, 20 Nov 2006 03:23:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Sumant Patro <Sumant.Patro@lsil.com>
Cc: Neela.Kolli@engenio.com, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/megaraid/megaraid_sas.c: make 2 functions static
Message-ID: <20061120022349.GG31879@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/megaraid/megaraid_sas.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.19-rc5-mm2/drivers/scsi/megaraid/megaraid_sas.c.old	2006-11-20 00:55:39.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/scsi/megaraid/megaraid_sas.c	2006-11-20 00:55:57.000000000 +0100
@@ -517,7 +517,7 @@
  * Returns the number of frames required for numnber of sge's (sge_count)
  */
 
-u32 megasas_get_frame_count(u8 sge_count)
+static u32 megasas_get_frame_count(u8 sge_count)
 {
 	int num_cnt;
 	int sge_bytes;
@@ -1733,7 +1733,7 @@
  *
  * Tasklet to complete cmds
  */
-void megasas_complete_cmd_dpc(unsigned long instance_addr)
+static void megasas_complete_cmd_dpc(unsigned long instance_addr)
 {
 	u32 producer;
 	u32 consumer;

