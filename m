Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267430AbUGVXwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267430AbUGVXwG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 19:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267431AbUGVXwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 19:52:06 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:51594 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S267430AbUGVXwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 19:52:04 -0400
Date: Thu, 22 Jul 2004 16:52:02 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Fix PPC44x early uart setup
Message-ID: <20040722165202.A20296@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a bug introduced in the PPC44x early uart setup from the
last set of 44x fixes.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== arch/ppc/kernel/head_44x.S 1.11 vs edited =====
--- 1.11/arch/ppc/kernel/head_44x.S	Thu Jul  1 22:23:47 2004
+++ edited/arch/ppc/kernel/head_44x.S	Thu Jul 22 16:45:42 2004
@@ -209,14 +209,6 @@
 	tlbwe	r4,r0,PPC44x_TLB_XLAT	/* Load the translation fields */
 	tlbwe	r5,r0,PPC44x_TLB_ATTRIB	/* Load the attrib/access fields */
 
-	ori	r3,r3,PPC44x_TLB_TS	/* Translation state 1 */
-
-        li      r0,1			/* TLB slot 1 */
-
-	tlbwe	r3,r0,PPC44x_TLB_PAGEID	/* Load the pageid fields */
-	tlbwe	r4,r0,PPC44x_TLB_XLAT	/* Load the translation fields */
-	tlbwe	r5,r0,PPC44x_TLB_ATTRIB	/* Load the attrib/access fields */
-
 	/* Force context change */
 	isync
 #endif /* CONFIG_SERIAL_TEXT_DEBUG */
