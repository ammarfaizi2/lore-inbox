Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbVAYLaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbVAYLaq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 06:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVAYL3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 06:29:44 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:53254 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261903AbVAYL2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 06:28:01 -0500
Date: Tue, 25 Jan 2005 12:27:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] floppy.c: make some code static
Message-ID: <20050125112758.GG30909@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/block/floppy.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

This patch was already sent on:
- 29 Nov 2004

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

