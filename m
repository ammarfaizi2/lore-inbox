Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbVJYR5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbVJYR5F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 13:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbVJYR5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 13:57:04 -0400
Received: from relay01.roc.ny.frontiernet.net ([66.133.182.164]:36743 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S932272AbVJYR5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 13:57:02 -0400
Reply-To: <jbowler@acm.org>
From: John Bowler <jbowler@acm.org>
To: "'Deepak Saxena'" <dsaxena@plexity.net>
Cc: <linux-arm-kernel@lists.arm.linux.org.uk>, <trivial@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.14-rc5 arch-ixp4xx/io.h: make const args const to remove compiler warning
Date: Tue, 25 Oct 2005 10:50:50 -0700
Message-ID: <001801c5d98c$a43b3680$1001a8c0@kalmiopsis>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial compiler warning fix; the inline callers of these APIs were changed
to have const vaddr parameters.

Signed-off-by: John Bowler <jbowler@acm.org>

--- linux-2.6.13/include/asm-arm/arch-ixp4xx/io.h.orig	2005-09-24
17:06:19.968099976 -0700
+++ linux-2.6.13/include/asm-arm/arch-ixp4xx/io.h	2005-09-24
17:06:52.542149731 -0700
@@ -113,7 +113,7 @@
 }

 static inline void
-__ixp4xx_writesb(u32 bus_addr, u8 *vaddr, int count)
+__ixp4xx_writesb(u32 bus_addr, const u8 *vaddr, int count)
 {
 	while (count--)
 		writeb(*vaddr++, bus_addr);
@@ -136,7 +136,7 @@
 }

 static inline void
-__ixp4xx_writesw(u32 bus_addr, u16 *vaddr, int count)
+__ixp4xx_writesw(u32 bus_addr, const u16 *vaddr, int count)
 {
 	while (count--)
 		writew(*vaddr++, bus_addr);
@@ -154,7 +154,7 @@
 }

 static inline void
-__ixp4xx_writesl(u32 bus_addr, u32 *vaddr, int count)
+__ixp4xx_writesl(u32 bus_addr, const u32 *vaddr, int count)
 {
 	while (count--)
 		writel(*vaddr++, bus_addr);

