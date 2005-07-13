Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262593AbVGMFld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbVGMFld (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 01:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262595AbVGMFlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 01:41:32 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:26342 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262593AbVGMFkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 01:40:08 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] v850: Align ___start___param to match parameter alignment
Cc: linux-kernel@vger.kernel.org
From: Miles Bader <miles@gnu.org>
Message-Id: <20050713054003.CD2CB450@mctpc71>
Date: Wed, 13 Jul 2005 14:40:03 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 arch/v850/kernel/vmlinux.lds.S |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -ruN -X../cludes linux-2.6.11-uc0/arch/v850/kernel/vmlinux.lds.S linux-2.6.11-uc0-v850-20050713/arch/v850/kernel/vmlinux.lds.S
--- linux-2.6.11-uc0/arch/v850/kernel/vmlinux.lds.S	2004-12-27 11:26:17.694361000 +0900
+++ linux-2.6.11-uc0-v850-20050713/arch/v850/kernel/vmlinux.lds.S	2005-07-13 14:29:50.398591000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/vmlinux.lds.S -- kernel linker script for v850 platforms
  *
- *  Copyright (C) 2002,03,04  NEC Electronics Corporation
- *  Copyright (C) 2002,03,04  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2002,03,04,05  NEC Electronics Corporation
+ *  Copyright (C) 2002,03,04,05  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -61,6 +61,7 @@
 			*(__kcrctab_gpl)				      \
 		___stop___kcrctab_gpl = .;				      \
 		/* Built-in module parameters */			      \
+		. = ALIGN (4) ;						      \
 		___start___param = .;					      \
 		*(__param)						      \
 		___stop___param = .;
