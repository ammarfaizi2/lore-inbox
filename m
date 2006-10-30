Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030520AbWJ3HSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030520AbWJ3HSt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 02:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030522AbWJ3HSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 02:18:49 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:6299 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1030520AbWJ3HSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 02:18:48 -0500
Date: Mon, 30 Oct 2006 18:18:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org, ak@suse.de,
       linux-mm@kvack.org, Christoph Lameter <clameter@sgi.com>, pj@sgi.com
Subject: [PATCH 2/2] [POWERPC] Wire up sys_migrate_pages
Message-Id: <20061030181826.634e086d.sfr@canb.auug.org.au>
In-Reply-To: <20061030181701.23ea7cba.sfr@canb.auug.org.au>
References: <20061030181701.23ea7cba.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 2.3.0beta3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-powerpc/systbl.h |    2 +-
 include/asm-powerpc/unistd.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/asm-powerpc/systbl.h b/include/asm-powerpc/systbl.h
index eac85ce..c6a0318 100644
--- a/include/asm-powerpc/systbl.h
+++ b/include/asm-powerpc/systbl.h
@@ -261,7 +261,7 @@ SYSX(sys_ni_syscall, ppc_fadvise64_64, p
 PPC_SYS_SPU(rtas)
 OLDSYS(debug_setcontext)
 SYSCALL(ni_syscall)
-SYSCALL(ni_syscall)
+COMPAT_SYS(migrate_pages)
 COMPAT_SYS(mbind)
 COMPAT_SYS(get_mempolicy)
 COMPAT_SYS(set_mempolicy)
diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
index 464a48c..b5fe932 100644
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -276,7 +276,7 @@ #endif
 #define __NR_rtas		255
 #define __NR_sys_debug_setcontext 256
 /* Number 257 is reserved for vserver */
-/* 258 currently unused */
+#define __NR_migrate_pages	258
 #define __NR_mbind		259
 #define __NR_get_mempolicy	260
 #define __NR_set_mempolicy	261
-- 
1.4.3.2

