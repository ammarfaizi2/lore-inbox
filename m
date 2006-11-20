Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933889AbWKTC3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933889AbWKTC3F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 21:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933872AbWKTCXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 21:23:50 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35857 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933868AbWKTCXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 21:23:47 -0500
Date: Mon, 20 Nov 2006 03:23:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Brian King <brking@us.ibm.com>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/ipr.c: make 2 functions static
Message-ID: <20061120022346.GF31879@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/ipr.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.19-rc5-mm2/drivers/scsi/ipr.c.old	2006-11-20 00:50:09.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/scsi/ipr.c	2006-11-20 00:50:28.000000000 +0100
@@ -4615,7 +4615,7 @@
  * Return value:
  * 	0 on success / other on failure
  **/
-int ipr_ioctl(struct scsi_device *sdev, int cmd, void __user *arg)
+static int ipr_ioctl(struct scsi_device *sdev, int cmd, void __user *arg)
 {
 	struct ipr_resource_entry *res;
 
@@ -4655,7 +4655,7 @@
  * Return value:
  * 	EH_NOT_HANDLED
  **/
-enum scsi_eh_timer_return ipr_scsi_timed_out(struct scsi_cmnd *scsi_cmd)
+static enum scsi_eh_timer_return ipr_scsi_timed_out(struct scsi_cmnd *scsi_cmd)
 {
 	struct ipr_ioa_cfg *ioa_cfg;
 	struct ipr_cmnd *ipr_cmd;

