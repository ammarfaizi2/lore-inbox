Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbVHPWAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbVHPWAv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 18:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbVHPWAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 18:00:51 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:34199 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1751099AbVHPWAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 18:00:50 -0400
Date: Tue, 16 Aug 2005 17:00:39 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc32: removed usage of <asm/segment.h> 
Message-ID: <Pine.LNX.4.61.0508161700050.5751@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Made <asm/segment.h> a dummy include like it is in ppc64 and removed any
users if it in arch/ppc.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit f63ab7e926d6c5e96de501ec9eac7f28af188a65
tree adcc67a572ec8e4d1520a7a5493ea909028e76f9
parent d88b795bc4c4b59c29a98e2a551c2ad4d65901c5
author Kumar K. Gala <kumar.gala@freescale.com> Tue, 16 Aug 2005 16:59:22 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Tue, 16 Aug 2005 16:59:22 -0500

 arch/ppc/kernel/temp.c         |    1 -
 arch/ppc/kernel/time.c         |    1 -
 arch/ppc/platforms/chrp_time.c |    1 -
 include/asm-ppc/segment.h      |    7 ++++++-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/ppc/kernel/temp.c b/arch/ppc/kernel/temp.c
--- a/arch/ppc/kernel/temp.c
+++ b/arch/ppc/kernel/temp.c
@@ -21,7 +21,6 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <asm/reg.h>
 #include <asm/nvram.h>
diff --git a/arch/ppc/kernel/time.c b/arch/ppc/kernel/time.c
--- a/arch/ppc/kernel/time.c
+++ b/arch/ppc/kernel/time.c
@@ -58,7 +58,6 @@
 #include <linux/init.h>
 #include <linux/profile.h>
 
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <asm/nvram.h>
 #include <asm/cache.h>
diff --git a/arch/ppc/platforms/chrp_time.c b/arch/ppc/platforms/chrp_time.c
--- a/arch/ppc/platforms/chrp_time.c
+++ b/arch/ppc/platforms/chrp_time.c
@@ -22,7 +22,6 @@
 #include <linux/init.h>
 #include <linux/bcd.h>
 
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <asm/nvram.h>
 #include <asm/prom.h>
diff --git a/include/asm-ppc/segment.h b/include/asm-ppc/segment.h
--- a/include/asm-ppc/segment.h
+++ b/include/asm-ppc/segment.h
@@ -1 +1,6 @@
-#include <asm/uaccess.h>
+#ifndef __PPC_SEGMENT_H
+#define __PPC_SEGMENT_H
+
+/* Only here because we have some old header files that expect it.. */
+
+#endif /* __PPC_SEGMENT_H */
