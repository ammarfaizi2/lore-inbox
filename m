Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVABXc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVABXc3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 18:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVABXc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 18:32:29 -0500
Received: from one.firstfloor.org ([213.235.205.2]:39350 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261345AbVABXcV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 18:32:21 -0500
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, davidel@xmailserver.org, mh@codeweavers.com,
       dan@debian.org, the3dfxdude@gmail.com
Subject: [PATCH] Fix typo in i386 single step changes
From: Andi Kleen <ak@muc.de>
Date: Mon, 03 Jan 2005 00:32:19 +0100
Message-ID: <m1brc7xv98.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix an obvious typo in the recent i386 single stepping changes.

I would recommend to redo all the Wine etc. testing that lead to this patch
since it probably never worked.

Signed-off-by: Andi Kleen <ak@muc.de>

--- linux-2.6.10-bk5/arch/i386/kernel/traps.c-o	Mon Jan  3 01:02:06 2005
+++ linux-2.6.10-bk5/arch/i386/kernel/traps.c	Mon Jan  3 01:03:05 2005
@@ -725,7 +725,7 @@
 		if (tsk->ptrace & PT_DTRACE) {
 			regs->eflags &= ~TF_MASK;
 			tsk->ptrace &= ~PT_DTRACE;
-			if (!tsk->ptrace & PT_DTRACE)
+			if (!(tsk->ptrace & PT_DTRACE))
 				goto clear_TF;
 		}
 	}

