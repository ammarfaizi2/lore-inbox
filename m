Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274957AbRIXUeb>; Mon, 24 Sep 2001 16:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274953AbRIXUeT>; Mon, 24 Sep 2001 16:34:19 -0400
Received: from ns.suse.de ([213.95.15.193]:5650 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S274952AbRIXUeE>;
	Mon, 24 Sep 2001 16:34:04 -0400
Date: Mon, 24 Sep 2001 22:34:28 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: <dwmw2@infradead.org>, Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] compilation fix for nand.c
Message-ID: <Pine.LNX.4.30.0109242233150.18098-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


nand.c uses do_softirq() without including interrupt.h.
Patch below makes things compile again.

regards,

Dave.

diff -urN --exclude-from=/home/davej/.exclude linux-test/drivers/mtd/nand/nand.c linux-dj/drivers/mtd/nand/nand.c
--- linux-test/drivers/mtd/nand/nand.c	Mon Sep 24 21:24:40 2001
+++ linux-dj/drivers/mtd/nand/nand.c	Mon Sep 24 02:36:43 2001
@@ -21,6 +21,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/nand_ids.h>
+#include <linux/interrupt.h>
 #include <asm/io.h>

 #ifdef CONFIG_MTD_NAND_ECC


-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

