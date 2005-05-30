Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVE3U66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVE3U66 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 16:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVE3U6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 16:58:03 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25870 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261751AbVE3U4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 16:56:50 -0400
Date: Mon, 30 May 2005 22:56:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/socket.c: unexport move_addr_to_kernel
Message-ID: <20050530205647.GW10441@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any modular usage in the kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 7 May 2005

--- linux-2.6.12-rc3-mm2-full/net/socket.c.old	2005-05-03 11:03:23.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/net/socket.c	2005-05-03 11:03:53.000000000 +0200
@@ -2070,8 +2070,7 @@
 }
 #endif /* CONFIG_PROC_FS */
 
-/* ABI emulation layers need these two */
-EXPORT_SYMBOL(move_addr_to_kernel);
+/* ABI emulation layers need this one */
 EXPORT_SYMBOL(move_addr_to_user);
 EXPORT_SYMBOL(sock_create);
 EXPORT_SYMBOL(sock_create_kern);

