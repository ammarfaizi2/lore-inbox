Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbUDGJKB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 05:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbUDGJKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 05:10:00 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:52735 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261976AbUDGJJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 05:09:53 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  Make v850 dma-mapping.h header work when !CONFIG_PCI
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20040407090947.1244C131DA@mcspd15>
Date: Wed,  7 Apr 2004 18:09:47 +0900 (JST)
From: miles@mcspd15.ucom.lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

[Is this something that should be done in <asm-generic/dma-mapping/h>?]

diff -ruN -X../cludes linux-2.6.5-uc0/include/asm-v850/dma-mapping.h linux-2.6.5-uc0-v850-20040407/include/asm-v850/dma-mapping.h
--- linux-2.6.5-uc0/include/asm-v850/dma-mapping.h	2002-12-24 15:01:24.000000000 +0900
+++ linux-2.6.5-uc0-v850-20040407/include/asm-v850/dma-mapping.h	2004-04-07 16:28:51.000000000 +0900
@@ -1 +1,12 @@
+#ifndef __V850_DMA_MAPPING_H__
+#define __V850_DMA_MAPPING_H__
+
+#include <linux/config.h>
+
+#ifdef CONFIG_PCI
 #include <asm-generic/dma-mapping.h>
+#else
+#include <asm-generic/dma-mapping-broken.h>
+#endif
+
+#endif /* __V850_DMA_MAPPING_H__ */
