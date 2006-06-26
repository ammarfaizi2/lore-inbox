Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWFZWCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWFZWCR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWFZWCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:02:17 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34574 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751262AbWFZWCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:02:16 -0400
Date: Tue, 27 Jun 2006 00:02:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: dwmw2@infradead.org
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] make drivers/mtd/cmdlinepart.c:mtdpart_setup() static
Message-ID: <20060626220215.GI23314@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global mtdpart_setup() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

