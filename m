Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbULERib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbULERib (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 12:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbULEReL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 12:34:11 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62731 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261354AbULERUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 12:20:12 -0500
Date: Sun, 5 Dec 2004 18:20:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Romain Lievin <roms@lpg.ticalc.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/tipar.c: make two functions static
Message-ID: <20041205172009.GA2953@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes two needlessly global functions static.


diffstat output:
 drivers/char/tipar.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/char/tipar.c.old	2004-11-07 01:24:23.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/tipar.c	2004-11-07 01:24:45.000000000 +0100
@@ -489,7 +489,7 @@
 	.detach = tipar_detach,
 };
 
-int __init
+static int __init
 tipar_init_module(void)
 {
 	int err = 0;
@@ -526,7 +526,7 @@
 	return err;	
 }
 
-void __exit
+static void __exit
 tipar_cleanup_module(void)
 {
 	unsigned int i;

