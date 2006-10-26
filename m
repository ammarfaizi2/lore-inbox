Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422897AbWJZDfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422897AbWJZDfU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 23:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422893AbWJZDfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 23:35:20 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:59587 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1751749AbWJZDfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 23:35:17 -0400
Date: Thu, 26 Oct 2006 13:34:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org, ak@suse.de,
       linux-mm@kvack.org
Subject: [PATCH 3/3] [POWERPC] Wire up sys_migrate_pages
Message-Id: <20061026133430.09427c4e.sfr@canb.auug.org.au>
In-Reply-To: <20061026133305.b0db54e6.sfr@canb.auug.org.au>
References: <20061026132659.2ff90dd1.sfr@canb.auug.org.au>
	<20061026133305.b0db54e6.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 2.3.0beta3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-powerpc/systbl.h |    1 +
 include/asm-powerpc/unistd.h |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/asm-powerpc/systbl.h b/include/asm-powerpc/systbl.h
index eac85ce..4708ebe 100644
--- a/include/asm-powerpc/systbl.h
+++ b/include/asm-powerpc/systbl.h
@@ -304,3 +304,4 @@ SYSCALL_SPU(fchmodat)
 SYSCALL_SPU(faccessat)
 COMPAT_SYS_SPU(get_robust_list)
 COMPAT_SYS_SPU(set_robust_list)
+COMPAT_SYS(migrate_pages)
diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
index 464a48c..4cdab3f 100644
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -323,10 +323,11 @@ #define __NR_fchmodat		297
 #define __NR_faccessat		298
 #define __NR_get_robust_list	299
 #define __NR_set_robust_list	300
+#define __NR_migrate_pages	301
 
 #ifdef __KERNEL__
 
-#define __NR_syscalls		301
+#define __NR_syscalls		302
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
-- 
1.4.3.2

