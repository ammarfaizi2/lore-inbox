Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVBQUaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVBQUaB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 15:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262295AbVBQU3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 15:29:32 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:48139 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262326AbVBQU2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 15:28:32 -0500
Date: Thu, 17 Feb 2005 21:28:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/dgrs.c: make 3 functions static
Message-ID: <20050217202831.GC6194@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes three needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/dgrs.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.11-rc3-mm2-full/drivers/net/dgrs.c.old	2005-02-16 15:25:53.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/dgrs.c	2005-02-16 15:26:27.000000000 +0100
@@ -454,7 +454,7 @@
  *	up some state variables to let the host CPU continue doing
  *	other things until a DMA completion interrupt comes along.
  */
-void
+static void
 dgrs_rcv_frame(
 	struct net_device	*dev0,
 	DGRS_PRIV	*priv0,
@@ -1150,7 +1150,7 @@
 /*
  *	Probe (init) a board
  */
-int __init 
+static int __init 
 dgrs_probe1(struct net_device *dev)
 {
 	DGRS_PRIV	*priv = (DGRS_PRIV *) dev->priv;
@@ -1228,7 +1228,7 @@
        	return rc;
 }
 
-int __init 
+static int __init 
 dgrs_initclone(struct net_device *dev)
 {
 	DGRS_PRIV	*priv = (DGRS_PRIV *) dev->priv;

