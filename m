Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263090AbUKTESg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263090AbUKTESg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 23:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbUKTCm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:42:26 -0500
Received: from baikonur.stro.at ([213.239.196.228]:442 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S262857AbUKTCgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:36:01 -0500
Subject: [patch 2/4]  minmax-removal 	arch/mips/au1000/common/usbdev.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at,
       michael.veeck@gmx.net
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:35:57 +0100
Message-ID: <E1CVL6T-0001nB-Li@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Patch (against 2.6.8.1) removes unnecessary min/max macros and changes
calls to use kernel.h macros instead.

Since I dont have the hardware those patches are not tested.

Best regards
Veeck

Signed-off-by: Michael Veeck <michael.veeck@gmx.net>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk4-max/arch/mips/au1000/common/usbdev.c |    2 --
 1 files changed, 2 deletions(-)

diff -puN arch/mips/au1000/common/usbdev.c~min-max-arch_mips_au1000_common_usbdev arch/mips/au1000/common/usbdev.c
--- linux-2.6.10-rc2-bk4/arch/mips/au1000/common/usbdev.c~min-max-arch_mips_au1000_common_usbdev	2004-11-19 17:15:20.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/arch/mips/au1000/common/usbdev.c	2004-11-19 17:15:20.000000000 +0100
@@ -61,8 +61,6 @@
 #define vdbg(fmt, arg...) do {} while (0)
 #endif
 
-#define MAX(a,b)	(((a)>(b))?(a):(b))
-
 #define ALLOC_FLAGS (in_interrupt () ? GFP_ATOMIC : GFP_KERNEL)
 
 #define EP_FIFO_DEPTH 8
_
