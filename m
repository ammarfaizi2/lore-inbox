Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbVDKXBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVDKXBQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 19:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVDKXAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 19:00:13 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:21492 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261987AbVDKW7h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 18:59:37 -0400
Subject: [PATCH 1/3] mm/Kconfig: kill unused ARCH_FLATMEM_DISABLE
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, zippel@linux-m68k.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Mon, 11 Apr 2005 15:59:29 -0700
Message-Id: <E1DL7sQ-00030O-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This used to be used to disable FLATMEM selection, but I decided
to change it to be done generically when DISCONTIG is enabled.
The option is unused, so this kills it.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/./arch/mips/Kconfig   |    4 ----
 memhotplug-dave/./arch/parisc/Kconfig |    4 ----
 memhotplug-dave/./arch/sh/Kconfig     |    4 ----
 3 files changed, 12 deletions(-)

diff -puN ./arch/parisc/Kconfig~A0-mm-Kconfig-kill-ARCH_FLATMEM_DISABLE ./arch/parisc/Kconfig
--- memhotplug/./arch/parisc/Kconfig~A0-mm-Kconfig-kill-ARCH_FLATMEM_DISABLE	2005-04-11 15:49:09.000000000 -0700
+++ memhotplug-dave/./arch/parisc/Kconfig	2005-04-11 15:49:09.000000000 -0700
@@ -153,10 +153,6 @@ config ARCH_DISCONTIGMEM_ENABLE
 	  or have huge holes in the physical address space for other reasons.
 	  See <file:Documentation/vm/numa> for more.
 
-config ARCH_FLATMEM_DISABLE
-	def_bool y
-	depends on ARCH_DISCONTIGMEM_ENABLE
-
 source "mm/Kconfig"
 
 config PREEMPT
diff -puN ./arch/sh/Kconfig~A0-mm-Kconfig-kill-ARCH_FLATMEM_DISABLE ./arch/sh/Kconfig
--- memhotplug/./arch/sh/Kconfig~A0-mm-Kconfig-kill-ARCH_FLATMEM_DISABLE	2005-04-11 15:49:09.000000000 -0700
+++ memhotplug-dave/./arch/sh/Kconfig	2005-04-11 15:49:09.000000000 -0700
@@ -496,10 +496,6 @@ config ARCH_DISCONTIGMEM_ENABLE
 	  or have huge holes in the physical address space for other reasons.
 	  See <file:Documentation/vm/numa> for more.
 
-config ARCH_FLATMEM_DISABLE
-	def_bool y
-	depends on ARCH_DISCONTIGMEM_ENABLE
-
 source "mm/Kconfig"
 
 config ZERO_PAGE_OFFSET
diff -puN ./arch/mips/Kconfig~A0-mm-Kconfig-kill-ARCH_FLATMEM_DISABLE ./arch/mips/Kconfig
--- memhotplug/./arch/mips/Kconfig~A0-mm-Kconfig-kill-ARCH_FLATMEM_DISABLE	2005-04-11 15:49:09.000000000 -0700
+++ memhotplug-dave/./arch/mips/Kconfig	2005-04-11 15:49:09.000000000 -0700
@@ -501,10 +501,6 @@ config ARCH_DISCONTIGMEM_ENABLE
 	  or have huge holes in the physical address space for other reasons.
 	  See <file:Documentation/vm/numa> for more.
 
-config ARCH_FLATMEM_DISABLE
-	def_bool y
-	depends on ARCH_DISCONTIGMEM_ENABLE
-
 config NUMA
 	bool "NUMA Support"
 	depends on SGI_IP27
_
