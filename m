Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161010AbWBHGoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161010AbWBHGoR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161012AbWBHGnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:43:50 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:38610 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161010AbWBHGnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:43:18 -0500
Message-ID: <43E99351.20806@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 15:44:33 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Kyle McMartin <kyle@mcmartin.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: linux-m68k@vger.kernel.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH] unify pfn_to_page take 2 [13/25] m68k funcs
References: <43E98AC2.4090005@jp.fujitsu.com> <20060208060853.GB12258@quicksilver.road.mcmartin.ca>
In-Reply-To: <20060208060853.GB12258@quicksilver.road.mcmartin.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle McMartin wrote:
> On Wed, Feb 08, 2006 at 03:08:02PM +0900, KAMEZAWA Hiroyuki wrote:
>> +config ARHC_HAS_PFN_TO_PAGE
> 
> ARCH_HAS_PFN_TO_PAGE..
> 
Oh.....its typo. Thank you!

This is fixed one.
-- Kame

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

+config ARCH_HAS_PFN_TO_PAGE
+	bool
+	default y
+
  mainmenu "Linux/68k Kernel Configuration"

  source "init/Kconfig"

