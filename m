Return-Path: <linux-kernel-owner+w=401wt.eu-S1030447AbXAKNtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbXAKNtI (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 08:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030455AbXAKNtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 08:49:07 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4597 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030448AbXAKNsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 08:48:55 -0500
Date: Thu, 11 Jan 2007 14:48:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [2.6 patch] make hdlc_setup() static again
Message-ID: <20070111134859.GD20027@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hdlc_setup was exported, but this export was never used.

If a driver using it actually shows up it can still be exported again.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Krzysztof Halasa <khc@pm.waw.pl>

---

This patch was already sent on:
- 25 Nov 2006

--- linux-2.6.19-rc6-mm1/drivers/net/wan/hdlc.c.old	2006-11-25 00:16:13.000000000 +0100
+++ linux-2.6.19-rc6-mm1/drivers/net/wan/hdlc.c	2006-11-25 00:16:26.000000000 +0100
@@ -222,7 +222,7 @@
 	return -EINVAL;
 }
 
-void hdlc_setup(struct net_device *dev)
+static void hdlc_setup(struct net_device *dev)
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 
@@ -325,7 +325,6 @@
 EXPORT_SYMBOL(hdlc_open);
 EXPORT_SYMBOL(hdlc_close);
 EXPORT_SYMBOL(hdlc_ioctl);
-EXPORT_SYMBOL(hdlc_setup);
 EXPORT_SYMBOL(alloc_hdlcdev);
 EXPORT_SYMBOL(unregister_hdlc_device);
 EXPORT_SYMBOL(register_hdlc_protocol);

