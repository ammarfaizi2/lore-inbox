Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbVHXRBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbVHXRBq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 13:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbVHXRBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 13:01:45 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:37616 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751185AbVHXRBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 13:01:43 -0400
Date: Wed, 24 Aug 2005 12:00:59 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: linux-kernel@vger.kernel.org
cc: Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
       sparclinux@vger.kernel.org, ultralinux@vger.kernel.org
Subject: [PATCH 13/15] sparc64: remove use of asm/segment.h
In-Reply-To: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
Message-ID: <Pine.LNX.4.61.0508241159570.23956@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed sparc64 architecture specific users of asm/segment.h and
asm-sparc64/segment.h itself

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 4c42a86cb24cd46d20ccb883b196e29bef6df18f
tree 83888c48157ecf0783f19cd73634d6446ac29482
parent 6ee9ded730a875d63e42add1c3094eca7d5a6cdf
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 11:04:10 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 11:04:10 -0500

 b/arch/sparc64/kernel/setup.c     |    1 -
 b/include/asm-sparc64/processor.h |    1 -
 include/asm-sparc64/segment.h     |    6 ------
 3 files changed, 8 deletions(-)

diff --git a/arch/sparc64/kernel/setup.c b/arch/sparc64/kernel/setup.c
--- a/arch/sparc64/kernel/setup.c
+++ b/arch/sparc64/kernel/setup.c
@@ -33,7 +33,6 @@
 #include <linux/cpu.h>
 #include <linux/initrd.h>
 
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/processor.h>
diff --git a/include/asm-sparc64/processor.h b/include/asm-sparc64/processor.h
--- a/include/asm-sparc64/processor.h
+++ b/include/asm-sparc64/processor.h
@@ -18,7 +18,6 @@
 #include <asm/a.out.h>
 #include <asm/pstate.h>
 #include <asm/ptrace.h>
-#include <asm/segment.h>
 #include <asm/page.h>
 
 /* The sparc has no problems with write protection */
diff --git a/include/asm-sparc64/segment.h b/include/asm-sparc64/segment.h
deleted file mode 100644
--- a/include/asm-sparc64/segment.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __SPARC64_SEGMENT_H
-#define __SPARC64_SEGMENT_H
-
-/* Only here because we have some old header files that expect it.. */
-
-#endif
