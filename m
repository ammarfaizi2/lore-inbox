Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWDIP6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWDIP6V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 11:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWDIP6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 11:58:21 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:52229 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750802AbWDIP6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 11:58:20 -0400
Date: Sun, 9 Apr 2006 17:58:20 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: rl@hellgate.ch, jgarzik@pobox.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/via-rhine.c: make a function static
Message-ID: <20060409155820.GH8454@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global rhine_set_carrier() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 4 Apr 2006

--- linux-2.6.17-rc1-mm1-full/drivers/net/via-rhine.c.old	2006-04-04 17:41:16.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/drivers/net/via-rhine.c	2006-04-04 17:41:29.000000000 +0200
@@ -1091,7 +1091,7 @@
 }
 
 /* Called after status of force_media possibly changed */
-void rhine_set_carrier(struct mii_if_info *mii)
+static void rhine_set_carrier(struct mii_if_info *mii)
 {
 	if (mii->force_media) {
 		/* autoneg is off: Link is always assumed to be up */

