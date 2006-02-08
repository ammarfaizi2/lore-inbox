Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030468AbWBHGG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030468AbWBHGG4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965179AbWBHGG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:06:56 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:58335 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965173AbWBHGGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:06:55 -0500
Message-ID: <43E98AC2.4090005@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 15:08:02 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: linux-m68k@vger.kernel.org
Subject: [PATCH] unify pfn_to_page take 2 [13/25] m68k funcs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

m68k seems not to keep 'memmap + pfn == page_to_pfn(pfn)'
because kaddr is remapped.

Use its own pfn_to_page() funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Index: test-layout-free-zone/arch/m68k/Kconfig
===================================================================
--- test-layout-free-zone.orig/arch/m68k/Kconfig
+++ test-layout-free-zone/arch/m68k/Kconfig
@@ -26,6 +26,10 @@ config ARCH_MAY_HAVE_PC_FDC
  	depends on Q40 || (BROKEN && SUN3X)
  	default y

+config ARHC_HAS_PFN_TO_PAGE
+	bool
+	default y
+
  mainmenu "Linux/68k Kernel Configuration"

  source "init/Kconfig"

