Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbTEFC5G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 22:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbTEFC5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 22:57:06 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:31632 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262268AbTEFC5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 22:57:05 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  Define flush_page_to_ram on v850/nb85e
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030506030924.DC001377C@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue,  6 May 2003 12:09:24 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.69-uc0/include/asm-v850/nb85e_cache.h linux-2.5.69-uc0-v850-20030506/include/asm-v850/nb85e_cache.h
--- linux-2.5.69-uc0/include/asm-v850/nb85e_cache.h	2003-04-21 10:53:17.000000000 +0900
+++ linux-2.5.69-uc0-v850-20030506/include/asm-v850/nb85e_cache.h	2003-05-06 10:40:26.000000000 +0900
@@ -62,6 +62,7 @@
 						 unsigned long adr, int len);
 extern void nb85e_cache_flush_sigtramp (unsigned long addr);
 
+#define flush_page_to_ram(x)	((void)0)
 #define flush_cache_all		nb85e_cache_flush_all
 #define flush_cache_mm		nb85e_cache_flush_mm
 #define flush_cache_range	nb85e_cache_flush_range
