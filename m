Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVBSIo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVBSIo7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 03:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVBSIoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 03:44:09 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30478 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261661AbVBSImR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 03:42:17 -0500
Date: Sat, 19 Feb 2005 09:42:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: maxk@qualcomm.com
Cc: vtun@office.satix.net, jgarzik@pobox.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/tun.c: make 2 functions static
Message-ID: <20050219084215.GS4337@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/tun.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.11-rc3-mm2-full/drivers/net/tun.c.old	2005-02-16 18:55:46.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/tun.c	2005-02-16 18:55:57.000000000 +0100
@@ -843,7 +843,7 @@
 	.set_rx_csum	= tun_set_rx_csum
 };
 
-int __init tun_init(void)
+static int __init tun_init(void)
 {
 	int ret = 0;
 
@@ -856,7 +856,7 @@
 	return ret;
 }
 
-void tun_cleanup(void)
+static void tun_cleanup(void)
 {
 	struct tun_struct *tun, *nxt;
 

