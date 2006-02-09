Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbWBIQKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbWBIQKn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 11:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbWBIQKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 11:10:43 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:1348 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932512AbWBIQKn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 11:10:43 -0500
Date: Thu, 9 Feb 2006 17:10:40 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: [patch] sparc64: fix syscall table - sys_newfstatat
Message-ID: <20060209161040.GD20554@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The sparc64 64 bit syscall table seems to be broken as it has
compat_sys_newfstatat in its syscall table instead of sys_newfstatat.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/sparc64/kernel/systbls.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc64/kernel/systbls.S b/arch/sparc64/kernel/systbls.S
index 5928b3c..a191685 100644
--- a/arch/sparc64/kernel/systbls.S
+++ b/arch/sparc64/kernel/systbls.S
@@ -146,7 +146,7 @@ sys_call_table:
 /*270*/	.word sys_io_submit, sys_io_cancel, sys_io_getevents, sys_mq_open, sys_mq_unlink
 	.word sys_mq_timedsend, sys_mq_timedreceive, sys_mq_notify, sys_mq_getsetattr, sys_waitid
 /*280*/	.word sys_nis_syscall, sys_add_key, sys_request_key, sys_keyctl, sys_openat
-	.word sys_mkdirat, sys_mknodat, sys_fchownat, sys_futimesat, compat_sys_newfstatat
+	.word sys_mkdirat, sys_mknodat, sys_fchownat, sys_futimesat, sys_newfstatat
 /*285*/	.word sys_unlinkat, sys_renameat, sys_linkat, sys_symlinkat, sys_readlinkat
 	.word sys_fchmodat, sys_faccessat, sys_pselect6, sys_ppoll, sys_unshare
 
