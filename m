Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267436AbTBNUyC>; Fri, 14 Feb 2003 15:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267458AbTBNUyC>; Fri, 14 Feb 2003 15:54:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20490 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267436AbTBNUxs>; Fri, 14 Feb 2003 15:53:48 -0500
Subject: PATCH: make starfire compile
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Fri, 14 Feb 2003 21:03:47 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18jmzr-0005fg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.60-ref/drivers/net/starfire.c linux-2.5.60-ac1/drivers/net/starfire.c
--- linux-2.5.60-ref/drivers/net/starfire.c	2003-02-14 21:45:55.000000000 +0000
+++ linux-2.5.60-ac1/drivers/net/starfire.c	2003-02-14 19:34:00.000000000 +0000
@@ -339,7 +339,7 @@
 		intr_enable = readl(ioaddr + IntrEnable); \
 		intr_enable &= ~(IntrRxDone | IntrRxEmpty); \
 		writel(intr_enable, ioaddr + IntrEnable); \
-		readl(ioaddr + IntrEnable); \	/* flush PCI posting buffers */
+		readl(ioaddr + IntrEnable); /* flush PCI posting buffers */ \
 	} else { \
 		/* Paranoia check */ \
 		intr_enable = readl(ioaddr + IntrEnable); \
