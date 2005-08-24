Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbVHXQ42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbVHXQ42 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbVHXQ42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:56:28 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:33006 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751177AbVHXQ41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:56:27 -0400
Date: Wed, 24 Aug 2005 11:56:11 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: linux-kernel@vger.kernel.org
cc: Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 08/15] ppc32: remove use of asm/segment.h
In-Reply-To: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
Message-ID: <Pine.LNX.4.61.0508241155330.23956@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed ppc32 architecture specific users of asm/segment.h and
asm-ppc/segment.h itself

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 503a812c1f9cef08e6f96b2b2cf1f32bbfef2bc6
tree b61a93eb582e90fafda6ff9d064b2ab25e7d3ede
parent 21a31cb366a764793dc532b525b95bfc3e1723a2
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 10:58:02 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 10:58:02 -0500

 arch/ppc/kernel/temp.c         |    1 -
 arch/ppc/kernel/time.c         |    1 -
 arch/ppc/platforms/chrp_time.c |    1 -
 arch/ppc/syslib/prep_nvram.c   |    1 -
 include/asm-ppc/segment.h      |    1 -
 5 files changed, 0 insertions(+), 5 deletions(-)

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
diff --git a/arch/ppc/syslib/prep_nvram.c b/arch/ppc/syslib/prep_nvram.c
--- a/arch/ppc/syslib/prep_nvram.c
+++ b/arch/ppc/syslib/prep_nvram.c
@@ -15,7 +15,6 @@
 #include <linux/ioport.h>
 
 #include <asm/sections.h>
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
 #include <asm/prep_nvram.h>
diff --git a/include/asm-ppc/segment.h b/include/asm-ppc/segment.h
deleted file mode 100644
--- a/include/asm-ppc/segment.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm/uaccess.h>
