Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbULTB5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbULTB5G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 20:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbULTB4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 20:56:14 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32273 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261387AbULTBxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 20:53:43 -0500
Date: Mon, 20 Dec 2004 02:53:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] init/initramfs.c: make unpack_to_rootfs static (fwd)
Message-ID: <20041220015337.GQ21288@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The trivial patch forwarded below still applies and compiles against 
2.6.10-rc3-mm1.

Please apply.

----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Mon, 6 Dec 2004 19:45:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] init/initramfs.c: make unpack_to_rootfs static

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

