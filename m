Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbULVLww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbULVLww (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 06:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbULVLvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 06:51:04 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59409 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261966AbULVLuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 06:50:08 -0500
Date: Wed, 22 Dec 2004 12:50:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: jgarzik@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/hw_random.c: make a variable static (fwd)
Message-ID: <20041222115006.GN5217@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.10-rc3-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sun, 5 Dec 2004 17:57:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/hw_random.c: make a variable static

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

