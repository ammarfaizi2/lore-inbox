Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbULYNle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbULYNle (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 08:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbULYNle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 08:41:34 -0500
Received: from golobica.uni-mb.si ([164.8.100.4]:42192 "EHLO
	golobica.uni-mb.si") by vger.kernel.org with ESMTP id S261440AbULYNl3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 08:41:29 -0500
Subject: [patch 1/4] delete unused file
To: rth@twiddle.net
Cc: linux-kernel@vger.kernel.org, domen@coderock.org
From: domen@coderock.org
Date: Sat, 25 Dec 2004 14:41:28 +0100
Message-Id: <20041225134120.050934DC0EB@golobica.uni-mb.si>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj/arch/alpha/lib/dbg_stackcheck.S |   27 ---------------------------
 1 files changed, 27 deletions(-)

diff -L arch/alpha/lib/dbg_stackcheck.S -puN arch/alpha/lib/dbg_stackcheck.S~remove_file-arch_alpha_lib_dbg_stackcheck.S /dev/null
--- kj/arch/alpha/lib/dbg_stackcheck.S
+++ /dev/null	2004-12-24 01:21:08.000000000 +0100
@@ -1,27 +0,0 @@
-/*
- * arch/alpha/lib/stackcheck.S
- * Contributed by Richard Henderson (rth@tamu.edu)
- *
- * Verify that we have not overflowed the stack.  Oops if we have.
- */
-
-#include <asm/asm_offsets.h>
-
-	.text
-	.set noat
-
-	.align 3
-	.globl _mcount
-	.ent _mcount
-_mcount:
-	.frame $30, 0, $28, 0
-	.prologue 0
-
-	lda	$0, TASK_SIZE($8)
-	cmpult	$30, $0, $0
-	bne	$0, 1f
-	ret	($28)
-1:	stq	$31, -8($31)	# oops me, damn it.
-	br	1b
-
-	.end _mcount
_
