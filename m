Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbULFSpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbULFSpT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 13:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbULFSpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 13:45:18 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:41490 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261604AbULFSpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 13:45:12 -0500
Date: Mon, 6 Dec 2004 19:45:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] init/initramfs.c: make unpack_to_rootfs static
Message-ID: <20041206184509.GJ7250@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global function static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/init/initramfs.c.old	2004-12-06 19:32:54.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/init/initramfs.c	2004-12-06 19:33:01.000000000 +0100
@@ -410,7 +410,7 @@
 	outcnt = 0;
 }
 
-char * __init unpack_to_rootfs(char *buf, unsigned len, int check_only)
+static char * __init unpack_to_rootfs(char *buf, unsigned len, int check_only)
 {
 	int written;
 	dry_run = check_only;

