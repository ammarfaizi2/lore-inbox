Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030562AbWBHGJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030562AbWBHGJs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030563AbWBHGJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:09:48 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:32741 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030562AbWBHGJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:09:47 -0500
Message-ID: <43E98B6B.2060300@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 15:10:51 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: gerg@uclinux.org
Subject: [PATCH] unify pfn_to_page take 2 [14/25] m68knommu funcs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

m68knommu uses virtual address to get page struct..
Because phys_to_virt(addr) == addr now, it looks to be able to use
generic one, by defining ARCH_PFN_OFFSET=PAGE_OFFSET >> PAGE_SHIFT.

But I remaind it as it is.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: test-layout-free-zone/arch/m68knommu/Kconfig
===================================================================
--- test-layout-free-zone.orig/arch/m68knommu/Kconfig
+++ test-layout-free-zone/arch/m68knommu/Kconfig
@@ -29,6 +29,10 @@ config GENERIC_CALIBRATE_DELAY
  	bool
  	default y

+config ARCH_HAS_PFN_TO_PAGE
+	bool
+	default y
+
  source "init/Kconfig"

  menu "Processor type and features"

