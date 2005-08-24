Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbVHXRCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbVHXRCH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 13:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbVHXRCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 13:02:07 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:7830 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1751189AbVHXRCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 13:02:04 -0400
Date: Wed, 24 Aug 2005 12:01:55 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: linux-kernel@vger.kernel.org
cc: Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
       sparclinux@vger.kernel.org
Subject: [PATCH 14/15] sparc: remove use of asm/segment.h
In-Reply-To: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
Message-ID: <Pine.LNX.4.61.0508241201010.23956@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed sparc architecture specific users of asm/segment.h and
asm-sparc/segment.h itself

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit bd988bbd37cb610800f19ac6891a519c81c96d95
tree dff7982106a16af59a65c158631f76d9fa118a1e
parent 4c42a86cb24cd46d20ccb883b196e29bef6df18f
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 11:14:02 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 11:14:02 -0500

 arch/sparc/kernel/setup.c     |    1 -
 arch/sparc/kernel/tick14.c    |    1 -
 arch/sparc/kernel/time.c      |    1 -
 arch/sparc/mm/fault.c         |    1 -
 arch/sparc/mm/init.c          |    1 -
 include/asm-sparc/processor.h |    1 -
 include/asm-sparc/segment.h   |    6 ------
 include/asm-sparc/system.h    |    1 -
 8 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/arch/sparc/kernel/setup.c b/arch/sparc/kernel/setup.c
--- a/arch/sparc/kernel/setup.c
+++ b/arch/sparc/kernel/setup.c
@@ -32,7 +32,6 @@
 #include <linux/spinlock.h>
 #include <linux/root_dev.h>
 
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/processor.h>
diff --git a/arch/sparc/kernel/tick14.c b/arch/sparc/kernel/tick14.c
--- a/arch/sparc/kernel/tick14.c
+++ b/arch/sparc/kernel/tick14.c
@@ -19,7 +19,6 @@
 #include <linux/interrupt.h>
 
 #include <asm/oplib.h>
-#include <asm/segment.h>
 #include <asm/timer.h>
 #include <asm/mostek.h>
 #include <asm/system.h>
diff --git a/arch/sparc/kernel/time.c b/arch/sparc/kernel/time.c
--- a/arch/sparc/kernel/time.c
+++ b/arch/sparc/kernel/time.c
@@ -32,7 +32,6 @@
 #include <linux/profile.h>
 
 #include <asm/oplib.h>
-#include <asm/segment.h>
 #include <asm/timer.h>
 #include <asm/mostek.h>
 #include <asm/system.h>
diff --git a/arch/sparc/mm/fault.c b/arch/sparc/mm/fault.c
--- a/arch/sparc/mm/fault.c
+++ b/arch/sparc/mm/fault.c
@@ -23,7 +23,6 @@
 #include <linux/module.h>
 
 #include <asm/system.h>
-#include <asm/segment.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/memreg.h>
diff --git a/arch/sparc/mm/init.c b/arch/sparc/mm/init.c
--- a/arch/sparc/mm/init.c
+++ b/arch/sparc/mm/init.c
@@ -25,7 +25,6 @@
 #include <linux/bootmem.h>
 
 #include <asm/system.h>
-#include <asm/segment.h>
 #include <asm/vac-ops.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
diff --git a/include/asm-sparc/processor.h b/include/asm-sparc/processor.h
--- a/include/asm-sparc/processor.h
+++ b/include/asm-sparc/processor.h
@@ -19,7 +19,6 @@
 #include <asm/ptrace.h>
 #include <asm/head.h>
 #include <asm/signal.h>
-#include <asm/segment.h>
 #include <asm/btfixup.h>
 #include <asm/page.h>
 
diff --git a/include/asm-sparc/segment.h b/include/asm-sparc/segment.h
deleted file mode 100644
--- a/include/asm-sparc/segment.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __SPARC_SEGMENT_H
-#define __SPARC_SEGMENT_H
-
-/* Only here because we have some old header files that expect it.. */
-
-#endif
diff --git a/include/asm-sparc/system.h b/include/asm-sparc/system.h
--- a/include/asm-sparc/system.h
+++ b/include/asm-sparc/system.h
@@ -9,7 +9,6 @@
 #include <linux/threads.h>	/* NR_CPUS */
 #include <linux/thread_info.h>
 
-#include <asm/segment.h>
 #include <asm/page.h>
 #include <asm/psr.h>
 #include <asm/ptrace.h>
