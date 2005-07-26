Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVGZPX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVGZPX5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 11:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVGZO4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 10:56:37 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15365 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261842AbVGZO4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 10:56:00 -0400
Date: Tue, 26 Jul 2005 16:55:50 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/asm-i386/: "extern inline" -> "static inline"
Message-ID: <20050726145550.GQ3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/asm-i386/div64.h     |    2 +-
 include/asm-i386/processor.h |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.13-rc3-mm1-full/include/asm-i386/div64.h.old	2005-07-26 01:38:12.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/include/asm-i386/div64.h	2005-07-26 01:38:20.000000000 +0200
@@ -35,7 +35,7 @@
  */
 #define div_long_long_rem(a,b,c) div_ll_X_l_rem(a,b,c)
 
-extern inline long
+static inline long
 div_ll_X_l_rem(long long divs, long div, long *rem)
 {
 	long dum2;
--- linux-2.6.13-rc3-mm1-full/include/asm-i386/processor.h.old	2005-07-26 01:38:28.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/include/asm-i386/processor.h	2005-07-26 01:38:57.000000000 +0200
@@ -665,7 +665,7 @@
    However we don't do prefetches for pre XP Athlons currently
    That should be fixed. */
 #define ARCH_HAS_PREFETCH
-extern inline void prefetch(const void *x)
+static inline void prefetch(const void *x)
 {
 	alternative_input(ASM_NOP4,
 			  "prefetchnta (%1)",
@@ -679,7 +679,7 @@
 
 /* 3dnow! prefetch to get an exclusive cache line. Useful for 
    spinlocks to avoid one state transition in the cache coherency protocol. */
-extern inline void prefetchw(const void *x)
+static inline void prefetchw(const void *x)
 {
 	alternative_input(ASM_NOP4,
 			  "prefetchw (%1)",

