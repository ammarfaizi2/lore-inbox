Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVAWKRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVAWKRo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 05:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVAWKRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 05:17:44 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:63239 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261286AbVAWKRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 05:17:12 -0500
Date: Sun, 23 Jan 2005 11:17:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] loop.c: make two functions static
Message-ID: <20050123101710.GJ3212@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/block/loop.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

This patch was already sent on:
- 29 Nov 2004

--- linux-2.6.10-rc1-mm3-full/drivers/block/loop.c.old	2004-11-06 20:09:10.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/loop.c	2004-11-06 20:09:31.000000000 +0100
@@ -1114,7 +1114,7 @@
 EXPORT_SYMBOL(loop_register_transfer);
 EXPORT_SYMBOL(loop_unregister_transfer);
 
-int __init loop_init(void)
+static int __init loop_init(void)
 {
 	int	i;
 
@@ -1189,7 +1189,7 @@
 	return -ENOMEM;
 }
 
-void loop_exit(void)
+static void loop_exit(void)
 {
 	int i;
 

