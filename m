Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVCUPj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVCUPj4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 10:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVCUPjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 10:39:55 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:29635 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261829AbVCUPjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 10:39:42 -0500
Date: Mon, 21 Mar 2005 09:39:12 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: Andrew Morton <akpm@osdl.org>
cc: Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: typo fix in load/store string emulation
In-Reply-To: <34e690a54bb55ad44bb2518e1d7bf4f3@freescale.com>
Message-ID: <Pine.LNX.4.61.0503210937280.27668@blarg.somerset.sps.mot.com>
References: <34e690a54bb55ad44bb2518e1d7bf4f3@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Patch fixes a typo in the emulation of load/store string emulations 
pointed out by Segher Boessenkool.


Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
diff -Nru a/arch/ppc/kernel/traps.c b/arch/ppc/kernel/traps.c
--- a/arch/ppc/kernel/traps.c	2005-03-21 09:36:28 -06:00
+++ b/arch/ppc/kernel/traps.c	2005-03-21 09:36:28 -06:00
@@ -412,7 +412,7 @@
 			return -EINVAL;
 
 	/* Early out if we are an invalid form of lswi */
-	if ((instword & INST_STRING_MASK) == INST_LSWX)
+	if ((instword & INST_STRING_MASK) == INST_LSWI)
 		if ((rA >= rT) || (rT == rA))
 			return -EINVAL;
 
