Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbTHaJ0U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 05:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262533AbTHaJ0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 05:26:20 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:14767 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S262524AbTHaJ0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 05:26:18 -0400
Date: Sun, 31 Aug 2003 11:26:16 +0200
From: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Linux-2.4.22: crypto compile on Alpha
Message-ID: <20030831092616.GX14093@os.inf.tu-dresden.de>
Mail-Followup-To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A kmap_types.h is needed to compile crypto on alpha.

diff -urN linux-2.4.22.orig/include/asm-alpha/kmap_types.h linux-2.4.22/include/asm-alpha/kmap_types.h
--- linux-2.4.22.orig/include/asm-alpha/kmap_types.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.22/include/asm-alpha/kmap_types.h	2003-08-31 11:24:26.000000000 +0200
@@ -0,0 +1,18 @@
+#ifdef __KERNEL__
+#ifndef _ASM_KMAP_TYPES_H
+#define _ASM_KMAP_TYPES_H
+
+enum km_type {
+	KM_BOUNCE_READ,
+	KM_SKB_SUNRPC_DATA,
+	KM_SKB_DATA_SOFTIRQ,
+	KM_USER0,
+	KM_USER1,
+	KM_BH_IRQ,
+	KM_SOFTIRQ0,
+	KM_SOFTIRQ1,
+	KM_TYPE_NR
+};
+
+#endif
+#endif /* __KERNEL__ */

The file is just copied from m68k.





Adam
-- 
Adam                 adam@os.inf.tu-dresden.de
  Lackorzynski         http://os.inf.tu-dresden.de/~adam/
