Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbVHXQro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbVHXQro (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVHXQrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:47:43 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:13976 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751149AbVHXQrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:47:43 -0400
Date: Wed, 24 Aug 2005 11:47:17 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: linux-kernel@vger.kernel.org
cc: Andrew Morton <akpm@osdl.org>, rth@twiddle.net, ink@jurassic.park.msu.ru
Subject: [PATCH 01/15] alpha: remove use of asm/segment.h
In-Reply-To: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
Message-ID: <Pine.LNX.4.61.0508241146160.23956@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed Alpha architecture specific users of asm/segment.h and
asm-alpha/segment.h itself

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 19150fe1698293dc2c4f4f48c6b05d83595544e6
tree 9c45366378a1c34d755da01efc162bd7d80d48ab
parent acda3853951d4b9dbe97dffbefd6d2a4fd9d3df0
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 10:33:40 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 10:33:40 -0500

 arch/alpha/kernel/smc37c669.c |    1 -
 arch/alpha/kernel/smc37c93x.c |    1 -
 include/asm-alpha/segment.h   |    6 ------
 3 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/alpha/kernel/smc37c669.c b/arch/alpha/kernel/smc37c669.c
--- a/arch/alpha/kernel/smc37c669.c
+++ b/arch/alpha/kernel/smc37c669.c
@@ -11,7 +11,6 @@
 
 #include <asm/hwrpb.h>
 #include <asm/io.h>
-#include <asm/segment.h>
 
 #if 0
 # define DBG_DEVS(args)         printk args
diff --git a/arch/alpha/kernel/smc37c93x.c b/arch/alpha/kernel/smc37c93x.c
--- a/arch/alpha/kernel/smc37c93x.c
+++ b/arch/alpha/kernel/smc37c93x.c
@@ -12,7 +12,6 @@
 
 #include <asm/hwrpb.h>
 #include <asm/io.h>
-#include <asm/segment.h>
 
 #define SMC_DEBUG 0
 
diff --git a/include/asm-alpha/segment.h b/include/asm-alpha/segment.h
deleted file mode 100644
--- a/include/asm-alpha/segment.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __ALPHA_SEGMENT_H
-#define __ALPHA_SEGMENT_H
-
-/* Only here because we have some old header files that expect it.. */
-
-#endif
