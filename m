Return-Path: <linux-kernel-owner+w=401wt.eu-S1751387AbXAUTMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbXAUTMw (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 14:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbXAUTMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 14:12:52 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4192 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751387AbXAUTMv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 14:12:51 -0500
Date: Sun, 21 Jan 2007 20:12:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] make seagate_st0x_detect() static
Message-ID: <20070121191255.GK9093@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

seagate_st0x_detect() can become static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 6 Jan 2007

--- linux-2.6.20-rc3-mm1/drivers/scsi/seagate.c.old	2007-01-05 22:53:13.000000000 +0100
+++ linux-2.6.20-rc3-mm1/drivers/scsi/seagate.c	2007-01-05 22:57:54.000000000 +0100
@@ -420,7 +420,7 @@
 #define ULOOP( i ) for (clock = i*8;;)
 #define TIMEOUT (!(clock--))
 
-int __init seagate_st0x_detect (struct scsi_host_template * tpnt)
+static int __init seagate_st0x_detect (struct scsi_host_template * tpnt)
 {
 	struct Scsi_Host *instance;
 	int i, j;

