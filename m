Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265273AbUFAWct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265273AbUFAWct (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 18:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265262AbUFAWam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 18:30:42 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:13221 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265257AbUFAWaV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 18:30:21 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] IDE update [7/10]
Date: Wed, 2 Jun 2004 00:27:30 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200406020020.46912.bzolnier@elka.pw.edu.pl>
Cc: Andi Kleen <ak@muc.de>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: use <asm-i386/ide.h> as <asm-x86_64/ide.h>

They are identical (modulo infamous PC9800 stuff).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-rc2-bk2-bzolnier/include/asm-x86_64/ide.h |   68 ------------------
 1 files changed, 1 insertion(+), 67 deletions(-)

diff -puN include/asm-x86_64/ide.h~x86_64_asm_ide include/asm-x86_64/ide.h
--- linux-2.6.7-rc2-bk2/include/asm-x86_64/ide.h~x86_64_asm_ide	2004-06-01 19:57:26.838146184 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/include/asm-x86_64/ide.h	2004-06-01 19:57:26.841145728 +0200
@@ -1,67 +1 @@
-/*
- *  linux/include/asm-x86_64/ide.h
- *
- *  Copyright (C) 1994-1996  Linus Torvalds & authors
- */
-
-/*
- *  This file contains the x86_64 architecture specific IDE code.
- */
-
-#ifndef __ASMx86_64_IDE_H
-#define __ASMx86_64_IDE_H
-
-#ifdef __KERNEL__
-
-#include <linux/config.h>
-
-#ifndef MAX_HWIFS
-# ifdef CONFIG_BLK_DEV_IDEPCI
-#define MAX_HWIFS	10
-# else
-#define MAX_HWIFS	6
-# endif
-#endif
-
-static __inline__ int ide_default_irq(unsigned long base)
-{
-	switch (base) {
-		case 0x1f0: return 14;
-		case 0x170: return 15;
-		case 0x1e8: return 11;
-		case 0x168: return 10;
-		case 0x1e0: return 8;
-		case 0x160: return 12;
-		default:
-			return 0;
-	}
-}
-
-static __inline__ unsigned long ide_default_io_base(int index)
-{
-	switch (index) {
-		case 0:	return 0x1f0;
-		case 1:	return 0x170;
-		case 2: return 0x1e8;
-		case 3: return 0x168;
-		case 4: return 0x1e0;
-		case 5: return 0x160;
-		default:
-			return 0;
-	}
-}
-
-#define IDE_ARCH_OBSOLETE_INIT
-#define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
-
-#ifdef CONFIG_BLK_DEV_IDEPCI
-#define ide_init_default_irq(base)	(0)
-#else
-#define ide_init_default_irq(base)	ide_default_irq(base)
-#endif
-
-#include <asm-generic/ide_iops.h>
-
-#endif /* __KERNEL__ */
-
-#endif /* __ASMx86_64_IDE_H */
+#include <asm-i386/ide.h>

_

