Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbULER0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbULER0A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 12:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbULERXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 12:23:07 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:6668 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261323AbULERVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 12:21:30 -0500
Date: Sun, 5 Dec 2004 18:21:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jonathan@buzzard.org.uk
Cc: tlinux-users@tce.toshiba-dme.co.jp, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/toshiba.c: make a function static
Message-ID: <20041205172128.GB2953@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global function static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/char/toshiba.c.old	2004-11-07 01:25:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/toshiba.c	2004-11-07 01:25:08.000000000 +0100
@@ -407,7 +407,7 @@
  *   laptop, otherwise zero and determines the Machine ID, BIOS version and
  *   date, and SCI version.
  */
-int tosh_probe(void)
+static int tosh_probe(void)
 {
 	int i,major,minor,day,year,month,flag;
 	unsigned char signature[7] = { 0x54,0x4f,0x53,0x48,0x49,0x42,0x41 };

