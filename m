Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161148AbWAHTie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161148AbWAHTie (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 14:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161141AbWAHTiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 14:38:10 -0500
Received: from cabal.ca ([134.117.69.58]:61110 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1161142AbWAHTiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 14:38:05 -0500
Date: Sun, 8 Jan 2006 14:38:03 -0500
From: Kyle McMartin <kyle@parisc-linux.org>
To: akpm@osdl.org
Cc: schwidefsky@de.ibm.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
       parisc-linux@lists.parisc-linux.org, carlos@parisc-linux.org,
       willy@parisc-linux.org
Subject: [PATCH 3/5] Fix generic compat_siginfo_t on s390 and sparc64
Message-ID: <20060108193803.GJ3782@tachyon.int.mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carlos O'Donell <carlos@parisc-linux.org>

Define types needed for generic compat_siginfo_t on s390 and sparc64.

Signed-off-by: Carlos O'Donell <carlos@parisc-linux.org>
Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>

---

 include/asm-s390/compat.h    |    3 +++
 include/asm-sparc64/compat.h |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

c5833cf4215cfbab87f83d32520251da5631355f
diff --git a/include/asm-s390/compat.h b/include/asm-s390/compat.h
index a007715..38b1165 100644
--- a/include/asm-s390/compat.h
+++ b/include/asm-s390/compat.h
@@ -15,6 +15,9 @@ typedef s32		compat_clock_t;
 typedef s32		compat_pid_t;
 typedef u16		__compat_uid_t;
 typedef u16		__compat_gid_t;
+/* Define for use in compat_siginfo_t */
+#undef __ARCH_SI_COMPAT_UID_T
+#define __ARCH_SI_COMPAT_UID_T __compat_uid32_t
 typedef u32		__compat_uid32_t;
 typedef u32		__compat_gid32_t;
 typedef u16		compat_mode_t;
diff --git a/include/asm-sparc64/compat.h b/include/asm-sparc64/compat.h
index c73935d..06fbfb8 100644
--- a/include/asm-sparc64/compat.h
+++ b/include/asm-sparc64/compat.h
@@ -14,6 +14,9 @@ typedef s32		compat_clock_t;
 typedef s32		compat_pid_t;
 typedef u16		__compat_uid_t;
 typedef u16		__compat_gid_t;
+/* Define for use in the compat_siginfo_t */
+#undef __ARCH_SI_COMPAT_UID_T
+#define __ARCH_SI_COMPAT_UID_T compat_uint_t
 typedef u32		__compat_uid32_t;
 typedef u32		__compat_gid32_t;
 typedef u16		compat_mode_t;
-- 
1.0.7

