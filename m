Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751800AbWEPMRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbWEPMRA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 08:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbWEPMRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 08:17:00 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25363 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751800AbWEPMQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 08:16:59 -0400
Date: Tue, 16 May 2006 14:16:58 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ayaz Abdulla <aabdulla@nvidia.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, netdev@vger.kernel.org
Subject: [-mm patch] make drivers/net/forcedeth.c:nv_update_pause() static
Message-ID: <20060516121658.GQ6931@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global nv_update_pause() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

