Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbVHXQ5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVHXQ5Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbVHXQ5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:57:16 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:55443 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1751174AbVHXQ5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:57:15 -0400
Date: Wed, 24 Aug 2005 11:56:56 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: linux-kernel@vger.kernel.org
cc: Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH 09/15] ppc64: remove use of asm/segment.h
In-Reply-To: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
Message-ID: <Pine.LNX.4.61.0508241156170.23956@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed PPC64 architecture specific users of asm/segment.h and
asm-ppc64/segment.h itself

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 21a31cb366a764793dc532b525b95bfc3e1723a2
tree 2c40ec80e781b61fef42e5914d8f336dc72f2200
parent 53cbc8f4b0d47965e2d673bcc9dc5e6a8388350b
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 10:55:55 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 10:55:55 -0500

 arch/ppc64/kernel/time.c    |    1 -
 include/asm-ppc64/segment.h |    6 ------
 2 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/ppc64/kernel/time.c b/arch/ppc64/kernel/time.c
--- a/arch/ppc64/kernel/time.c
+++ b/arch/ppc64/kernel/time.c
@@ -51,7 +51,6 @@
 #include <linux/cpu.h>
 #include <linux/security.h>
 
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/nvram.h>
diff --git a/include/asm-ppc64/segment.h b/include/asm-ppc64/segment.h
deleted file mode 100644
--- a/include/asm-ppc64/segment.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __PPC64_SEGMENT_H
-#define __PPC64_SEGMENT_H
-
-/* Only here because we have some old header files that expect it.. */
-
-#endif /* __PPC64_SEGMENT_H */
