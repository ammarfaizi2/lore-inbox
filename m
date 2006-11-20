Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933863AbWKTC2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933863AbWKTC2N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 21:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933896AbWKTC2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 21:28:13 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39697 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933863AbWKTCXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 21:23:53 -0500
Date: Mon, 20 Nov 2006 03:23:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [-mm patch] drivers/scsi/scsi_scan.c: make 2 functions static
Message-ID: <20061120022352.GH31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 01:41:25AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-rc5-mm2:
>...
>  git-scsi-misc.patch
>...
>  git trees
>...

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/scsi_scan.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.19-rc5-mm2/drivers/scsi/scsi_scan.c.old	2006-11-20 00:57:44.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/scsi/scsi_scan.c	2006-11-20 00:58:05.000000000 +0100
@@ -1633,7 +1633,7 @@
  * that other asynchronous scans started after this one won't affect the
  * ordering of the discovered devices.
  */
-struct async_scan_data *scsi_prep_async_scan(struct Scsi_Host *shost)
+static struct async_scan_data *scsi_prep_async_scan(struct Scsi_Host *shost)
 {
 	struct async_scan_data *data;
 
@@ -1677,7 +1677,7 @@
  * This function announces all the devices it has found to the rest
  * of the system.
  */
-void scsi_finish_async_scan(struct async_scan_data *data)
+static void scsi_finish_async_scan(struct async_scan_data *data)
 {
 	struct Scsi_Host *shost;
 

