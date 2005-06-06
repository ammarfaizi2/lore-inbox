Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbVFFSq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVFFSq2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 14:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVFFSq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 14:46:28 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:51679 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261523AbVFFSqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 14:46:24 -0400
Date: Mon, 6 Jun 2005 11:46:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.12-rc5 ppc32] Add <linux/compiler.h> to <asm/sigcontext.h>
Message-ID: <20050606184618.GA3194@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On ppc32, <asm/sigcontext.h> uses __user, but doesn't directly include
<linux/compiler.h>.  This adds that in.  Without this, glibc will not
compile.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

Index: include/asm-ppc/sigcontext.h
===================================================================
--- 475459da3d3cc0071c71900cfbcdc389d3d71597/include/asm-ppc/sigcontext.h  (mode:100644)
+++ uncommitted/include/asm-ppc/sigcontext.h  (mode:100644)
@@ -2,7 +2,7 @@
 #define _ASM_PPC_SIGCONTEXT_H
 
 #include <asm/ptrace.h>
-
+#include <linux/compiler.h>
 
 struct sigcontext {
 	unsigned long	_unused[4];

-- 
Tom Rini
http://gate.crashing.org/~trini/
