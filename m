Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbVHXQxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbVHXQxo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbVHXQxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:53:44 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:16538 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1751162AbVHXQxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:53:42 -0400
Date: Wed, 24 Aug 2005 11:53:23 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: linux-kernel@vger.kernel.org
cc: Andrew Morton <akpm@osdl.org>, tony.luck@intel.com,
       linux-ia64@vger.kernel.org
Subject: [PATCH 05/15] ia64: remove use of asm/segment.h
In-Reply-To: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
Message-ID: <Pine.LNX.4.61.0508241152380.23956@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed IA64 architecture specific users of asm/segment.h and
asm-ia64/segment.h itself

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 53cbc8f4b0d47965e2d673bcc9dc5e6a8388350b
tree d05c25c406d023dce7c797ede8119b8ab68767e5
parent 352a43ca6e4cb29ca7ee1742a00f3b6d98465a0d
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 10:54:23 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 10:54:23 -0500

 arch/ia64/ia32/ia32_signal.c        |    1 -
 arch/ia64/pci/pci.c                 |    1 -
 arch/ia64/sn/kernel/sn2/sn_hwperf.c |    1 -
 include/asm-ia64/segment.h          |    6 ------
 4 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/ia64/ia32/ia32_signal.c b/arch/ia64/ia32/ia32_signal.c
--- a/arch/ia64/ia32/ia32_signal.c
+++ b/arch/ia64/ia32/ia32_signal.c
@@ -29,7 +29,6 @@
 #include <asm/uaccess.h>
 #include <asm/rse.h>
 #include <asm/sigcontext.h>
-#include <asm/segment.h>
 
 #include "ia32priv.h"
 
diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -24,7 +24,6 @@
 
 #include <asm/machvec.h>
 #include <asm/page.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/sal.h>
diff --git a/arch/ia64/sn/kernel/sn2/sn_hwperf.c b/arch/ia64/sn/kernel/sn2/sn_hwperf.c
--- a/arch/ia64/sn/kernel/sn2/sn_hwperf.c
+++ b/arch/ia64/sn/kernel/sn2/sn_hwperf.c
@@ -36,7 +36,6 @@
 #include <asm/topology.h>
 #include <asm/smp.h>
 #include <asm/semaphore.h>
-#include <asm/segment.h>
 #include <asm/uaccess.h>
 #include <asm/sal.h>
 #include <asm/sn/io.h>
diff --git a/include/asm-ia64/segment.h b/include/asm-ia64/segment.h
deleted file mode 100644
--- a/include/asm-ia64/segment.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _ASM_IA64_SEGMENT_H
-#define _ASM_IA64_SEGMENT_H
-
-/* Only here because we have some old header files that expect it.. */
-
-#endif /* _ASM_IA64_SEGMENT_H */
