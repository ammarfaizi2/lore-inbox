Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263477AbUJ2URy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263477AbUJ2URy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 16:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263525AbUJ2UNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 16:13:42 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:23185 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S263508AbUJ2UJs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 16:09:48 -0400
Subject: [PATCH] radeonfb: more initializer fixes
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.61.0410292046380.23014@waterleaf.sonytel.be>
References: <200410281712.i9SHCxDe025312@hera.kernel.org>
	 <Pine.GSO.4.61.0410292046380.23014@waterleaf.sonytel.be>
Date: Fri, 29 Oct 2004 23:11:01 +0300
Message-Id: <1099080661.9569.0.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use 8-bit palette entries for radeonfb and avoid zero-initialization
as suggested by Geert Uytterhoeven.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 radeon_monitor.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: 2.6.10-rc1-mm1/drivers/video/aty/radeon_monitor.c
===================================================================
--- 2.6.10-rc1-mm1.orig/drivers/video/aty/radeon_monitor.c	2004-10-29 11:07:54.000000000 +0300
+++ 2.6.10-rc1-mm1/drivers/video/aty/radeon_monitor.c	2004-10-29 23:02:58.854952680 +0300
@@ -12,9 +12,9 @@
 	.xres_virtual	= 640,
 	.yres_virtual	= 480,
 	.bits_per_pixel = 8,
-	.red		= { 0, 6, 0 },
-	.green		= { 0, 6, 0 },
-	.blue		= { 0, 6, 0 },
+	.red		= { .length = 8 },
+	.green		= { .length = 8 },
+	.blue		= { .length = 8 },
 	.activate	= FB_ACTIVATE_NOW,
 	.height		= -1,
 	.width		= -1,


