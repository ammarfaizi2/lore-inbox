Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVGTIjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVGTIjh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 04:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVGTIjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 04:39:37 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:33674 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261273AbVGTIil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 04:38:41 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] v850: Define pfn_valid
Cc: linux-kernel@vger.kernel.org
From: Miles Bader <miles@gnu.org>
Message-Id: <20050720083829.2495340B@mctpc71>
Date: Wed, 20 Jul 2005 17:38:29 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 include/asm-v850/page.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -ruN -X../cludes linux-2.6.12-uc0/include/asm-v850/page.h linux-2.6.12-uc0-v850-20050720/include/asm-v850/page.h
--- linux-2.6.12-uc0/include/asm-v850/page.h	2003-04-21 10:53:17.281477000 +0900
+++ linux-2.6.12-uc0-v850-20050720/include/asm-v850/page.h	2005-07-20 17:10:08.902014000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/page.h -- VM ops
  *
- *  Copyright (C) 2001,02,03  NEC Electronics Corporation
- *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03,05  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03,05  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -132,6 +132,7 @@
 
 #define pfn_to_page(pfn)	virt_to_page (pfn_to_virt (pfn))
 #define page_to_pfn(page)	virt_to_pfn (page_to_virt (page))
+#define pfn_valid(pfn)	        ((pfn) < max_mapnr)
 
 #define	virt_addr_valid(kaddr)						\
   (((void *)(kaddr) >= (void *)PAGE_OFFSET) && MAP_NR (kaddr) < max_mapnr)
