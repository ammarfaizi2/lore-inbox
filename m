Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967130AbWKYTPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967130AbWKYTPp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 14:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967133AbWKYTPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 14:15:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:65036 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S967130AbWKYTPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 14:15:38 -0500
Date: Sat, 25 Nov 2006 20:15:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: dwmw2@infradead.org, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] make drivers/mtd/cmdlinepart.c:mtdpart_setup() static
Message-ID: <20061125191541.GH3702@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global mtdpart_setup() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 27 Jun 2006

--- linux-2.6.17-mm2-full/drivers/mtd/cmdlinepart.c.old	2006-06-26 23:18:39.000000000 +0200
+++ linux-2.6.17-mm2-full/drivers/mtd/cmdlinepart.c	2006-06-26 23:18:51.000000000 +0200
@@ -346,7 +346,7 @@
  *
  * This function needs to be visible for bootloaders.
  */
-int mtdpart_setup(char *s)
+static int mtdpart_setup(char *s)
 {
 	cmdline = s;
 	return 1;

