Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbUKHJMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbUKHJMl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 04:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbUKHJMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 04:12:41 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:18142 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261792AbUKHJA1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 04:00:27 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 8 Nov 2004 09:53:59 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: v4l1-compat modparam
Message-ID: <20041108085359.GA19322@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert v4l1-compat module to new-style insmod options.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/v4l1-compat.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -u linux-2.6.10/drivers/media/video/v4l1-compat.c linux/drivers/media/video/v4l1-compat.c
--- linux-2.6.10/drivers/media/video/v4l1-compat.c	2004-11-07 12:23:00.000000000 +0100
+++ linux/drivers/media/video/v4l1-compat.c	2004-11-07 16:08:43.865616761 +0100
@@ -44,7 +44,7 @@
 #endif
 
 static unsigned int debug  = 0;
-MODULE_PARM(debug,"i");
+module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug,"enable debug messages");
 MODULE_AUTHOR("Bill Dirks");
 MODULE_DESCRIPTION("v4l(1) compatibility layer for v4l2 drivers.");

-- 
#define printk(args...) fprintf(stderr, ## args)
