Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbVBQPEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbVBQPEi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 10:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbVBQPEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 10:04:02 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:774 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261411AbVBQPBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 10:01:12 -0500
Date: Thu, 17 Feb 2005 16:01:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/amd8111e.c: make 2 functions static
Message-ID: <20050217150107.GL24808@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/amd8111e.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.11-rc3-mm2-full/drivers/net/amd8111e.c.old	2005-02-16 15:14:01.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/amd8111e.c	2005-02-16 15:14:29.000000000 +0100
@@ -1487,7 +1487,7 @@
 amd8111e crc generator implementation is different from the kernel
 ether_crc() function.
 */
-int amd8111e_ether_crc(int len, char* mac_addr)
+static int amd8111e_ether_crc(int len, char* mac_addr)
 {
 	int i,byte;
 	unsigned char octet;
@@ -1715,7 +1715,7 @@
 /* 
 This function changes the mtu of the device. It restarts the device  to initialize the descriptor with new receive buffers.
 */  
-int amd8111e_change_mtu(struct net_device *dev, int new_mtu)
+static int amd8111e_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct amd8111e_priv *lp = netdev_priv(dev);
 	int err;

