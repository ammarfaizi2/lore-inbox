Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262445AbVAPHsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbVAPHsg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 02:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbVAPHsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 02:48:36 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39182 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262445AbVAPHsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 02:48:21 -0500
Date: Sun, 16 Jan 2005 08:48:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ak@suse.de
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] x86_64: kill stale mtrr_centaur_report_mcr
Message-ID: <20050116074817.GX4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't know the x86_64 port supports the Centaur CPU.  ;-)


diffstat output:
 include/asm-x86_64/mtrr.h |    3 ---
 1 files changed, 3 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc1-mm1-full/include/asm-x86_64/mtrr.h.old	2005-01-16 04:27:41.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-x86_64/mtrr.h	2005-01-16 04:27:54.000000000 +0100
@@ -79,7 +79,6 @@
 		     unsigned int type, char increment);
 extern int mtrr_del (int reg, unsigned long base, unsigned long size);
 extern int mtrr_del_page (int reg, unsigned long base, unsigned long size);
-extern void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi);
 #  else
 static __inline__ int mtrr_add (unsigned long base, unsigned long size,
 				unsigned int type, char increment)
@@ -102,8 +101,6 @@
     return -ENODEV;
 }
 
-static __inline__ void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi) {}
-
 #  endif
 
 #endif

