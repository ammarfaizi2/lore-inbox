Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752755AbWKBJGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbWKBJGZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 04:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752757AbWKBJGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 04:06:25 -0500
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:22493 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1752755AbWKBJGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 04:06:24 -0500
Date: Thu, 2 Nov 2006 10:05:46 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch -mm] s390: pagefault_disable/enable build fix
Message-ID: <20061102090546.GA7131@osiris.boeblingen.de.ibm.com>
References: <20061101235407.a92f94a5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101235407.a92f94a5.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

arch/s390/lib/lib.a(uaccess_std.o)(.text+0x282): In function `futex_atomic_op':
: undefined reference to `pagefault_disable'

Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

Looks like we want to replace all asm/uaccess.h with linux/uaccess.h...

 arch/s390/lib/uaccess_std.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.19-rc4-mm2/arch/s390/lib/uaccess_std.c
===================================================================
--- linux-2.6.19-rc4-mm2.orig/arch/s390/lib/uaccess_std.c	2006-11-02 09:37:08.000000000 +0100
+++ linux-2.6.19-rc4-mm2/arch/s390/lib/uaccess_std.c	2006-11-02 09:48:31.000000000 +0100
@@ -11,7 +11,7 @@
 
 #include <linux/errno.h>
 #include <linux/mm.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <asm/futex.h>
 
 #ifndef __s390x__
