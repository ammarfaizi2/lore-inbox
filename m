Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbVIBBYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbVIBBYQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 21:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030635AbVIBBYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 21:24:15 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30992 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030628AbVIBBXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 21:23:54 -0400
Date: Fri, 2 Sep 2005 03:23:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@redhat.com, neilb@cse.unsw.edu.au, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/md/raid1.c: make a function static
Message-ID: <20050902012353.GN3657@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 22 Aug 2005

--- linux-2.6.13-rc6-mm1-full/drivers/md/raid1.c.old	2005-08-22 02:50:14.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/drivers/md/raid1.c	2005-08-22 02:50:31.000000000 +0200
@@ -1703,7 +1703,7 @@
 	return 0;
 }
 
-void raid1_quiesce(mddev_t *mddev, int state)
+static void raid1_quiesce(mddev_t *mddev, int state)
 {
 	conf_t *conf = mddev_to_conf(mddev);
 

