Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbVHaHEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbVHaHEZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 03:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbVHaHDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 03:03:51 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:65430 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S932406AbVHaHDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 03:03:30 -0400
Date: Wed, 31 Aug 2005 17:02:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/7] Consolidate the asm-ppc*/fcntl.h files into asm-powerpc
Message-Id: <20050831170259.19f0c398.sfr@canb.auug.org.au>
In-Reply-To: <20050831170129.29673e4c.sfr@canb.auug.org.au>
References: <20050831164738.6cee5830.sfr@canb.auug.org.au>
	<20050831165039.3740c832.sfr@canb.auug.org.au>
	<20050831165358.63910cfb.sfr@canb.auug.org.au>
	<20050831165550.7a477884.sfr@canb.auug.org.au>
	<20050831165724.114c4600.sfr@canb.auug.org.au>
	<20050831165939.50138ae5.sfr@canb.auug.org.au>
	<20050831170129.29673e4c.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This makes sense now that we have asm-powerpc.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 include/asm-powerpc/fcntl.h |   11 +++++++++++
 include/asm-ppc/fcntl.h     |   11 -----------
 include/asm-ppc64/fcntl.h   |    1 -
 3 files changed, 11 insertions(+), 12 deletions(-)
 create mode 100644 include/asm-powerpc/fcntl.h
 delete mode 100644 include/asm-ppc/fcntl.h
 delete mode 100644 include/asm-ppc64/fcntl.h

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/include/asm-powerpc/fcntl.h b/include/asm-powerpc/fcntl.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/fcntl.h
@@ -0,0 +1,11 @@
+#ifndef _ASM_FCNTL_H
+#define _ASM_FCNTL_H
+
+#define O_DIRECTORY      040000	/* must be a directory */
+#define O_NOFOLLOW      0100000	/* don't follow links */
+#define O_LARGEFILE     0200000
+#define O_DIRECT	0400000	/* direct disk access hint */
+
+#include <asm-generic/fcntl.h>
+
+#endif /* _ASM_FCNTL_H */
diff --git a/include/asm-ppc/fcntl.h b/include/asm-ppc/fcntl.h
deleted file mode 100644
--- a/include/asm-ppc/fcntl.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef _PPC_FCNTL_H
-#define _PPC_FCNTL_H
-
-#define O_DIRECTORY      040000	/* must be a directory */
-#define O_NOFOLLOW      0100000	/* don't follow links */
-#define O_LARGEFILE     0200000
-#define O_DIRECT	0400000	/* direct disk access hint */
-
-#include <asm-generic/fcntl.h>
-
-#endif /* _PPC_FCNTL_H */
diff --git a/include/asm-ppc64/fcntl.h b/include/asm-ppc64/fcntl.h
deleted file mode 100644
--- a/include/asm-ppc64/fcntl.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-ppc/fcntl.h>
