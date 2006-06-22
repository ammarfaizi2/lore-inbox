Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161044AbWFVKE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161044AbWFVKE3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 06:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161036AbWFVKDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 06:03:48 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44047 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161033AbWFVKDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 06:03:30 -0400
Date: Thu, 22 Jun 2006 12:03:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ayaz Abdulla <aabdulla@nvidia.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, netdev@vger.kernel.org
Subject: [2.6 patch] make drivers/net/forcedeth.c:nv_update_pause() static
Message-ID: <20060622100329.GB9111@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global nv_update_pause() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 16 May 2006

--- linux-2.6.17-rc4-mm1-full/drivers/net/forcedeth.c.old	2006-05-16 13:03:01.000000000 +0200
+++ linux-2.6.17-rc4-mm1-full/drivers/net/forcedeth.c	2006-05-16 13:03:08.000000000 +0200
@@ -2221,7 +2221,7 @@
 	spin_unlock_irq(&np->lock);
 }
 
-void nv_update_pause(struct net_device *dev, u32 pause_flags)
+static void nv_update_pause(struct net_device *dev, u32 pause_flags)
 {
 	struct fe_priv *np = netdev_priv(dev);
 	u8 __iomem *base = get_hwbase(dev);

