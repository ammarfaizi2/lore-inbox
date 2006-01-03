Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWACQvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWACQvo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 11:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWACQvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 11:51:04 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:8614 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932428AbWACQqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 11:46:40 -0500
Date: Tue, 3 Jan 2006 17:46:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 07/19] mutex subsystem, add default include/asm-*/mutex.h files
Message-ID: <20060103164626.GH25802@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@infradead.org>

add the per-arch mutex.h files for the remaining architectures.

We default to asm-generic/mutex-dec.h, because that performs
quite well on most arches. Arches that do not have atomic
decrement/increment instructions should switch to mutex-xchg.h
instead. Arches can also provide their own implementation for
the mutex fastpath primitives.

Signed-off-by: Arjan van de Ven <arjan@infradead.org>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 include/asm-alpha/mutex.h     |    9 +++++++++
 include/asm-cris/mutex.h      |    9 +++++++++
 include/asm-frv/mutex.h       |    9 +++++++++
 include/asm-h8300/mutex.h     |    9 +++++++++
 include/asm-ia64/mutex.h      |    9 +++++++++
 include/asm-m32r/mutex.h      |    9 +++++++++
 include/asm-m68k/mutex.h      |    9 +++++++++
 include/asm-m68knommu/mutex.h |    9 +++++++++
 include/asm-mips/mutex.h      |    9 +++++++++
 include/asm-parisc/mutex.h    |    9 +++++++++
 include/asm-powerpc/mutex.h   |    9 +++++++++
 include/asm-s390/mutex.h      |    9 +++++++++
 include/asm-sh/mutex.h        |    9 +++++++++
 include/asm-sh64/mutex.h      |    9 +++++++++
 include/asm-sparc/mutex.h     |    9 +++++++++
 include/asm-sparc64/mutex.h   |    9 +++++++++
 include/asm-um/mutex.h        |    9 +++++++++
 include/asm-v850/mutex.h      |    9 +++++++++
 include/asm-xtensa/mutex.h    |    9 +++++++++
 19 files changed, 171 insertions(+)

Index: linux/include/asm-alpha/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-alpha/mutex.h
@@ -0,0 +1,9 @@
+/*
+ * Pull in the generic implementation for the mutex fastpath.
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based generic
+ * implementation. (see asm-generic/mutex-xchg.h for details)
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-cris/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-cris/mutex.h
@@ -0,0 +1,9 @@
+/*
+ * Pull in the generic implementation for the mutex fastpath.
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based generic
+ * implementation. (see asm-generic/mutex-xchg.h for details)
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-frv/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-frv/mutex.h
@@ -0,0 +1,9 @@
+/*
+ * Pull in the generic implementation for the mutex fastpath.
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based generic
+ * implementation. (see asm-generic/mutex-xchg.h for details)
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-h8300/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-h8300/mutex.h
@@ -0,0 +1,9 @@
+/*
+ * Pull in the generic implementation for the mutex fastpath.
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based generic
+ * implementation. (see asm-generic/mutex-xchg.h for details)
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-ia64/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-ia64/mutex.h
@@ -0,0 +1,9 @@
+/*
+ * Pull in the generic implementation for the mutex fastpath.
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based generic
+ * implementation. (see asm-generic/mutex-xchg.h for details)
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-m32r/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-m32r/mutex.h
@@ -0,0 +1,9 @@
+/*
+ * Pull in the generic implementation for the mutex fastpath.
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based generic
+ * implementation. (see asm-generic/mutex-xchg.h for details)
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-m68k/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-m68k/mutex.h
@@ -0,0 +1,9 @@
+/*
+ * Pull in the generic implementation for the mutex fastpath.
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based generic
+ * implementation. (see asm-generic/mutex-xchg.h for details)
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-m68knommu/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-m68knommu/mutex.h
@@ -0,0 +1,9 @@
+/*
+ * Pull in the generic implementation for the mutex fastpath.
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based generic
+ * implementation. (see asm-generic/mutex-xchg.h for details)
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-mips/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-mips/mutex.h
@@ -0,0 +1,9 @@
+/*
+ * Pull in the generic implementation for the mutex fastpath.
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based generic
+ * implementation. (see asm-generic/mutex-xchg.h for details)
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-parisc/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-parisc/mutex.h
@@ -0,0 +1,9 @@
+/*
+ * Pull in the generic implementation for the mutex fastpath.
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based generic
+ * implementation. (see asm-generic/mutex-xchg.h for details)
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-powerpc/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-powerpc/mutex.h
@@ -0,0 +1,9 @@
+/*
+ * Pull in the generic implementation for the mutex fastpath.
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based generic
+ * implementation. (see asm-generic/mutex-xchg.h for details)
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-s390/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-s390/mutex.h
@@ -0,0 +1,9 @@
+/*
+ * Pull in the generic implementation for the mutex fastpath.
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based generic
+ * implementation. (see asm-generic/mutex-xchg.h for details)
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-sh/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-sh/mutex.h
@@ -0,0 +1,9 @@
+/*
+ * Pull in the generic implementation for the mutex fastpath.
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based generic
+ * implementation. (see asm-generic/mutex-xchg.h for details)
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-sh64/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-sh64/mutex.h
@@ -0,0 +1,9 @@
+/*
+ * Pull in the generic implementation for the mutex fastpath.
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based generic
+ * implementation. (see asm-generic/mutex-xchg.h for details)
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-sparc/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-sparc/mutex.h
@@ -0,0 +1,9 @@
+/*
+ * Pull in the generic implementation for the mutex fastpath.
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based generic
+ * implementation. (see asm-generic/mutex-xchg.h for details)
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-sparc64/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-sparc64/mutex.h
@@ -0,0 +1,9 @@
+/*
+ * Pull in the generic implementation for the mutex fastpath.
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based generic
+ * implementation. (see asm-generic/mutex-xchg.h for details)
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-um/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-um/mutex.h
@@ -0,0 +1,9 @@
+/*
+ * Pull in the generic implementation for the mutex fastpath.
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based generic
+ * implementation. (see asm-generic/mutex-xchg.h for details)
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-v850/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-v850/mutex.h
@@ -0,0 +1,9 @@
+/*
+ * Pull in the generic implementation for the mutex fastpath.
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based generic
+ * implementation. (see asm-generic/mutex-xchg.h for details)
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-xtensa/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-xtensa/mutex.h
@@ -0,0 +1,9 @@
+/*
+ * Pull in the generic implementation for the mutex fastpath.
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based generic
+ * implementation. (see asm-generic/mutex-xchg.h for details)
+ */
+
+#include <asm-generic/mutex-dec.h>
