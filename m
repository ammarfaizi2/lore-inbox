Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbWGSIeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbWGSIeB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 04:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWGSIeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 04:34:01 -0400
Received: from mgate02.necel.com ([203.180.232.82]:38900 "EHLO
	mgate02.necel.com") by vger.kernel.org with ESMTP id S932528AbWGSIeA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 04:34:00 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] v850: Call init_page_count instead of set_page_count
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
From: Miles Bader <miles@gnu.org>
Message-Id: <20060719083332.880D8481@dhapc248.dev.necel.com>
Date: Wed, 19 Jul 2006 17:33:32 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 arch/v850/kernel/setup.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -ruN -X../cludes linux-2.6.17-uc0/arch/v850/kernel/setup.c linux-2.6.17-uc0-v850-20060718/arch/v850/kernel/setup.c
--- linux-2.6.17-uc0/arch/v850/kernel/setup.c	2005-11-07 15:06:27.000000000 +0900
+++ linux-2.6.17-uc0-v850-20060718/arch/v850/kernel/setup.c	2006-07-18 14:52:39.237567000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/kernel/setup.c -- Arch-dependent initialization functions
  *
- *  Copyright (C) 2001,02,03,05  NEC Electronics Corporation
- *  Copyright (C) 2001,02,03,05  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03,05,06  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03,05,06  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -190,7 +190,7 @@
 		for (addr = start; addr < end; addr += PAGE_SIZE) {
 			struct page *page = virt_to_page (addr);
 			ClearPageReserved (page);
-			set_page_count (page, 1);
+			init_page_count (page);
 			__free_page (page);
 			total_ram_pages++;
 		}
