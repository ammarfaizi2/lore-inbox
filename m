Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbUK2M37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbUK2M37 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 07:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbUK2M2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 07:28:35 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:47890 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261705AbUK2M2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 07:28:05 -0500
Date: Mon, 29 Nov 2004 13:28:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] loop.c: make two functions static
Message-ID: <20041129122803.GK9722@stusta.de>
References: <20041124231055.GN19873@stusta.de> <20041125101220.GC29539@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125101220.GC29539@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes two needlessly global functions static.


diffstat output:
 drivers/block/loop.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

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
 

