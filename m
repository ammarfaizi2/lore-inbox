Return-Path: <linux-kernel-owner+w=401wt.eu-S1762754AbWLKKam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762754AbWLKKam (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 05:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762762AbWLKKam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 05:30:42 -0500
Received: from smtp.ocgnet.org ([64.20.243.3]:45499 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762754AbWLKKal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 05:30:41 -0500
Date: Mon, 11 Dec 2006 19:30:06 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] smc91x: Kill off excessive versatile hooks.
Message-ID: <20061211103006.GA32119@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
	Russell King <rmk@arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This looks like a result of too many auto-merges. The
CONFIG_ARCH_VERSATILE case was handled a total of 6 times.
This kills 5 of them.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

--

 drivers/net/smc91x.h |   90 ---------------------------------------------------
 1 file changed, 90 deletions(-)

diff --git a/drivers/net/smc91x.h b/drivers/net/smc91x.h
index 9367c57..d2767e6 100644
--- a/drivers/net/smc91x.h
+++ b/drivers/net/smc91x.h
@@ -362,96 +362,6 @@ static inline void LPD7_SMC_outsw (unsig
 
 #define SMC_IRQ_FLAGS		(0)
 
-#elif	defined(CONFIG_ARCH_VERSATILE)
-
-#define SMC_CAN_USE_8BIT	1
-#define SMC_CAN_USE_16BIT	1
-#define SMC_CAN_USE_32BIT	1
-#define SMC_NOWAIT		1
-
-#define SMC_inb(a, r)		readb((a) + (r))
-#define SMC_inw(a, r)		readw((a) + (r))
-#define SMC_inl(a, r)		readl((a) + (r))
-#define SMC_outb(v, a, r)	writeb(v, (a) + (r))
-#define SMC_outw(v, a, r)	writew(v, (a) + (r))
-#define SMC_outl(v, a, r)	writel(v, (a) + (r))
-#define SMC_insl(a, r, p, l)	readsl((a) + (r), p, l)
-#define SMC_outsl(a, r, p, l)	writesl((a) + (r), p, l)
-
-#define SMC_IRQ_FLAGS		(0)
-
-#elif	defined(CONFIG_ARCH_VERSATILE)
-
-#define SMC_CAN_USE_8BIT	1
-#define SMC_CAN_USE_16BIT	1
-#define SMC_CAN_USE_32BIT	1
-#define SMC_NOWAIT		1
-
-#define SMC_inb(a, r)		readb((a) + (r))
-#define SMC_inw(a, r)		readw((a) + (r))
-#define SMC_inl(a, r)		readl((a) + (r))
-#define SMC_outb(v, a, r)	writeb(v, (a) + (r))
-#define SMC_outw(v, a, r)	writew(v, (a) + (r))
-#define SMC_outl(v, a, r)	writel(v, (a) + (r))
-#define SMC_insl(a, r, p, l)	readsl((a) + (r), p, l)
-#define SMC_outsl(a, r, p, l)	writesl((a) + (r), p, l)
-
-#define SMC_IRQ_FLAGS		(0)
-
-#elif	defined(CONFIG_ARCH_VERSATILE)
-
-#define SMC_CAN_USE_8BIT	1
-#define SMC_CAN_USE_16BIT	1
-#define SMC_CAN_USE_32BIT	1
-#define SMC_NOWAIT		1
-
-#define SMC_inb(a, r)		readb((a) + (r))
-#define SMC_inw(a, r)		readw((a) + (r))
-#define SMC_inl(a, r)		readl((a) + (r))
-#define SMC_outb(v, a, r)	writeb(v, (a) + (r))
-#define SMC_outw(v, a, r)	writew(v, (a) + (r))
-#define SMC_outl(v, a, r)	writel(v, (a) + (r))
-#define SMC_insl(a, r, p, l)	readsl((a) + (r), p, l)
-#define SMC_outsl(a, r, p, l)	writesl((a) + (r), p, l)
-
-#define SMC_IRQ_FLAGS		(0)
-
-#elif	defined(CONFIG_ARCH_VERSATILE)
-
-#define SMC_CAN_USE_8BIT	1
-#define SMC_CAN_USE_16BIT	1
-#define SMC_CAN_USE_32BIT	1
-#define SMC_NOWAIT		1
-
-#define SMC_inb(a, r)		readb((a) + (r))
-#define SMC_inw(a, r)		readw((a) + (r))
-#define SMC_inl(a, r)		readl((a) + (r))
-#define SMC_outb(v, a, r)	writeb(v, (a) + (r))
-#define SMC_outw(v, a, r)	writew(v, (a) + (r))
-#define SMC_outl(v, a, r)	writel(v, (a) + (r))
-#define SMC_insl(a, r, p, l)	readsl((a) + (r), p, l)
-#define SMC_outsl(a, r, p, l)	writesl((a) + (r), p, l)
-
-#define SMC_IRQ_FLAGS		(0)
-
-#elif	defined(CONFIG_ARCH_VERSATILE)
-
-#define SMC_CAN_USE_8BIT	1
-#define SMC_CAN_USE_16BIT	1
-#define SMC_CAN_USE_32BIT	1
-#define SMC_NOWAIT		1
-
-#define SMC_inb(a, r)		readb((a) + (r))
-#define SMC_inw(a, r)		readw((a) + (r))
-#define SMC_inl(a, r)		readl((a) + (r))
-#define SMC_outb(v, a, r)	writeb(v, (a) + (r))
-#define SMC_outw(v, a, r)	writew(v, (a) + (r))
-#define SMC_outl(v, a, r)	writel(v, (a) + (r))
-#define SMC_insl(a, r, p, l)	readsl((a) + (r), p, l)
-#define SMC_outsl(a, r, p, l)	writesl((a) + (r), p, l)
-
-#define SMC_IRQ_FLAGS		(0)
-
 #else
 
 #define SMC_CAN_USE_8BIT	1
