Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbVHVUKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbVHVUKr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbVHVUKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:10:47 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9490 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750828AbVHVUKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:10:46 -0400
Date: Mon, 22 Aug 2005 22:10:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: mingo@redhat.com, neilb@cse.unsw.edu.au
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/md/raid1.c: make a function static
Message-ID: <20050822201043.GG9927@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc6-mm1-full/drivers/md/raid1.c.old	2005-08-22 02:50:14.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/drivers/md/raid1.c	2005-08-22 02:50:31.000000000 +0200
@@ -1703,7 +1703,7 @@
 	return 0;
 }
 
-void raid1_quiesce(mddev_t *mddev, int state)
+static void raid1_quiesce(mddev_t *mddev, int state)
 {
 	conf_t *conf = mddev_to_conf(mddev);
 

