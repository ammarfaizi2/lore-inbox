Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262340AbVBQUfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbVBQUfF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 15:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262338AbVBQUex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 15:34:53 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:780 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262340AbVBQUct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 15:32:49 -0500
Date: Thu, 17 Feb 2005 21:32:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/ethertap.c: make 2 functions static
Message-ID: <20050217203247.GE6194@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/ethertap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.11-rc3-mm2-full/drivers/net/ethertap.c.old	2005-02-16 15:40:05.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/ethertap.c	2005-02-16 15:40:17.000000000 +0100
@@ -343,7 +343,7 @@
 }
 
 
-int __init ethertap_init(void)
+static int __init ethertap_init(void)
 {
 	int i, err = 0;
 
@@ -371,7 +371,7 @@
 }
 module_init(ethertap_init);
 
-void __exit ethertap_cleanup(void)
+static void __exit ethertap_cleanup(void)
 {
 	int i;
 

