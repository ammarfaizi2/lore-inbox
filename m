Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbUK2M2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbUK2M2R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 07:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbUK2M2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 07:28:00 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42514 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261701AbUK2M0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 07:26:37 -0500
Date: Mon, 29 Nov 2004 13:26:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] floppy.c: make some code static
Message-ID: <20041129122634.GJ9722@stusta.de>
References: <20041124231055.GN19873@stusta.de> <20041125101220.GC29539@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125101220.GC29539@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code static.


diffstat output:
 drivers/block/floppy.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/block/floppy.c.old	2004-11-06 19:55:49.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/floppy.c	2004-11-06 20:06:29.000000000 +0100
@@ -4397,7 +4397,7 @@
 }
 #endif
 
-int __init floppy_init(void)
+static int __init floppy_init(void)
 {
 	int i, unit, drive;
 	int err, dr;
@@ -4738,7 +4738,7 @@
 
 #ifdef MODULE
 
-char *floppy;
+static char *floppy;
 
 static void unregister_devfs_entries(int drive)
 {

