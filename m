Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWJ3MPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWJ3MPY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 07:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWJ3MPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 07:15:24 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:13474 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1751353AbWJ3MPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 07:15:22 -0500
Date: Mon, 30 Oct 2006 05:15:21 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: [PARISC] Remove sched.h from uaccess.h
Message-ID: <20061030121521.GA10235@parisc-linux.org>
References: <E1GeUeP-0002oP-8U@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1GeUeP-0002oP-8U@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Al Viro has done the same thing to x86-64 and reduced the number of
files which depend on sched.h.  We had a missing dependency on sched.h
in unwind.c so add the include there.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

diff --git a/arch/parisc/kernel/unwind.c b/arch/parisc/kernel/unwind.c
index 920bdbf..9c98ed2 100644
--- a/arch/parisc/kernel/unwind.c
+++ b/arch/parisc/kernel/unwind.c
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/kallsyms.h>
 
diff --git a/include/asm-parisc/uaccess.h b/include/asm-parisc/uaccess.h
index d973e8b..2e87e82 100644
--- a/include/asm-parisc/uaccess.h
+++ b/include/asm-parisc/uaccess.h
@@ -4,7 +4,6 @@ #define __PARISC_UACCESS_H
 /*
  * User space memory access functions
  */
-#include <linux/sched.h>
 #include <asm/page.h>
 #include <asm/system.h>
 #include <asm/cache.h>
