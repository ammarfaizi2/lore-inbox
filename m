Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbUKOCJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbUKOCJH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 21:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbUKOCHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 21:07:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:48139 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261411AbUKOCG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:06:28 -0500
Date: Mon, 15 Nov 2004 02:53:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI aic7xxx_old.c: make a function static
Message-ID: <20041115015300.GE2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes the needlessly global function aic7xxx_info 
static.

diffstat output:
 drivers/scsi/aic7xxx_old.c              |    2 +-
 drivers/scsi/aic7xxx_old/aic7xxx_proc.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/aic7xxx_old.c.old	2004-11-13 17:15:23.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/aic7xxx_old.c	2004-11-13 17:16:12.000000000 +0100
@@ -1838,7 +1838,7 @@
  * Description:
  *   Return a string describing the driver.
  *-F*************************************************************************/
-const char *
+static const char *
 aic7xxx_info(struct Scsi_Host *dooh)
 {
   static char buffer[256];
--- linux-2.6.10-rc1-mm5-full/drivers/scsi/aic7xxx_old/aic7xxx_proc.c.old	2004-11-13 17:16:28.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/aic7xxx_old/aic7xxx_proc.c	2004-11-13 17:16:45.000000000 +0100
@@ -64,7 +64,7 @@
  * Description:
  *   Set parameters for the driver from the /proc filesystem.
  *-F*************************************************************************/
-int
+static int
 aic7xxx_set_info(char *buffer, int length, struct Scsi_Host *HBAptr)
 {
   proc_debug("aic7xxx_set_info(): %s\n", buffer);

