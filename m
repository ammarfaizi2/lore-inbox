Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261997AbVCVWBC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbVCVWBC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 17:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVCVWA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 17:00:29 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59404 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262119AbVCVV7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 16:59:53 -0500
Date: Tue, 22 Mar 2005 22:59:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: osst@riede.org
Cc: osst-users@lists.sourceforge.net, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/osst.c: remove unused code
Message-ID: <20050322215948.GP1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to both the Coverity checker and GNU gcc, it was found that this 
variable is completely unused.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/drivers/scsi/osst.c.old	2005-03-22 21:04:36.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/scsi/osst.c	2005-03-22 22:09:32.000000000 +0100
@@ -4770,9 +4770,6 @@ static int os_scsi_tape_close(struct ino
 {
 	int		      result = 0;
 	struct osst_tape    * STp    = filp->private_data;
-	struct scsi_request * SRpnt  = NULL;
-
-	if (SRpnt) scsi_release_request(SRpnt);
 
 	if (STp->door_locked == ST_LOCKED_AUTO)
 		do_door_lock(STp, 0);

