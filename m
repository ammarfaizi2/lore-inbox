Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVBSIpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVBSIpl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 03:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbVBSIpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 03:45:15 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:50702 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261659AbVBSIof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 03:44:35 -0500
Date: Sat, 19 Feb 2005 09:44:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: rl@hellgate.ch
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/via-rhine.c: make a variable static
Message-ID: <20050219084433.GU4337@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global variable static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc3-mm2-full/drivers/net/via-rhine.c.old	2005-02-16 18:56:59.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/via-rhine.c	2005-02-16 18:57:05.000000000 +0100
@@ -390,7 +390,7 @@
 
 #ifdef USE_MMIO
 /* Registers we check that mmio and reg are the same. */
-int mmio_verify_registers[] = {
+static int mmio_verify_registers[] = {
 	RxConfig, TxConfig, IntrEnable, ConfigA, ConfigB, ConfigC, ConfigD,
 	0
 };

