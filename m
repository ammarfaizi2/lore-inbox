Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbTE0JJg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 05:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbTE0JJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 05:09:16 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:36231 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262976AbTE0JIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 05:08:31 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  Define flush_page_to_ram on v850/nb85e
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030527092133.2B7A0375B@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 27 May 2003 18:21:33 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.70/include/asm-v850/nb85e_cache.h linux-2.5.70-v850-20030527/include/asm-v850/nb85e_cache.h
--- linux-2.5.70/include/asm-v850/nb85e_cache.h	2003-04-21 10:53:17.000000000 +0900
+++ linux-2.5.70-v850-20030527/include/asm-v850/nb85e_cache.h	2003-05-27 16:09:43.000000000 +0900
@@ -62,6 +62,7 @@
 						 unsigned long adr, int len);
 extern void nb85e_cache_flush_sigtramp (unsigned long addr);
 
+#define flush_page_to_ram(x)	((void)0)
 #define flush_cache_all		nb85e_cache_flush_all
 #define flush_cache_mm		nb85e_cache_flush_mm
 #define flush_cache_range	nb85e_cache_flush_range
