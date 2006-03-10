Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752217AbWCJWZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbWCJWZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 17:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752197AbWCJWZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 17:25:25 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12548 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752213AbWCJWZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 17:25:01 -0500
Date: Fri, 10 Mar 2006 23:25:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/sim710.c: fix a NULL pointer dereference
Message-ID: <20060310222500.GZ21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a NULL pointer dereference spotted by the Coverity 
checker.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm3-full/drivers/scsi/sim710.c.old	2006-03-10 20:48:32.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/drivers/scsi/sim710.c	2006-03-10 20:49:24.000000000 +0100
@@ -146,7 +146,7 @@ sim710_probe_common(struct device *dev, 
  out_put_host:
 	scsi_host_put(host);
  out_release:
-	release_region(host->base, 64);
+	release_region(base_addr, 64);
  out_free:
 	kfree(hostdata);
  out:

