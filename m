Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbULEQ7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbULEQ7U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 11:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbULEQ5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 11:57:53 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14346 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261321AbULEQ5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 11:57:41 -0500
Date: Sun, 5 Dec 2004 17:57:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/hw_random.c: make a variable static
Message-ID: <20041205165739.GO2953@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global variable static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/char/hw_random.c.old	2004-11-07 00:10:30.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/hw_random.c	2004-11-07 00:10:39.000000000 +0100
@@ -369,7 +369,7 @@
 	VIA_RNG_CHUNK_1_MASK	= 0xFF,
 };
 
-u32 via_rng_datum;
+static u32 via_rng_datum;
 
 /*
  * Investigate using the 'rep' prefix to obtain 32 bits of random data

