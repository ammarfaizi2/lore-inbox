Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWDDQaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWDDQaq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 12:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWDDQae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 12:30:34 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5646 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750751AbWDDQaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 12:30:08 -0400
Date: Tue, 4 Apr 2006 18:30:06 +0200
From: Adrian Bunk <bunk@stusta.de>
To: rl@hellgate.ch
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/via-rhine.c: make a function static
Message-ID: <20060404163006.GP6529@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global rhine_set_carrier() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

