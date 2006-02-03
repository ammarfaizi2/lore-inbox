Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946020AbWBCWgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946020AbWBCWgz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 17:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946018AbWBCWgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 17:36:50 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:52238 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1946019AbWBCWg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 17:36:26 -0500
Date: Fri, 3 Feb 2006 23:36:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386: HIGHMEM64G must depend on X86_CMPXCHG64
Message-ID: <20060203223625.GV4408@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the usage of set_64bit in include/asm-i386/pgtable-3level.h, 
HIGHMEM64G must depend on X86_CMPXCHG64.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 28 Jan 2006

--- linux-2.6.16-rc1-mm3-386/arch/i386/Kconfig.old	2006-01-28 16:04:45.000000000 +0100
+++ linux-2.6.16-rc1-mm3-386/arch/i386/Kconfig	2006-01-28 16:05:25.000000000 +0100
@@ -442,6 +442,7 @@
 
 config HIGHMEM64G
 	bool "64GB"
+	depends on X86_CMPXCHG64
 	help
 	  Select this if you have a 32-bit processor and more than 4
 	  gigabytes of physical RAM.
