Return-Path: <linux-kernel-owner+w=401wt.eu-S1758849AbWLIEw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758849AbWLIEw2 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 23:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758853AbWLIEw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 23:52:28 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:49633 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758849AbWLIEw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 23:52:27 -0500
Date: Sat, 9 Dec 2006 13:55:52 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, clameter@engr.sgi.com, apw@shadowen.org,
       akpm@osdl.org
Subject: Re: [RFC] [PATCH] virtual memmap on sparsemem v3 [4/4] ia64 support
Message-Id: <20061209135552.613c6bbd.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061208160803.b6ea27ed.kamezawa.hiroyu@jp.fujitsu.com>
References: <20061208155608.14dcd2e5.kamezawa.hiroyu@jp.fujitsu.com>
	<20061208160803.b6ea27ed.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I tested ia64 with this patch under

- DISCONTIGMEM + VIRTUAL_MEM_MAP
- SPARSEMEM
- SPARSEMEM_VMEMMAP

on SMP with tiger4_defconfig.

Fix typo for  DISCONTIGMEM

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: devel-2.6.19/include/asm-ia64/pgtable.h
===================================================================
--- devel-2.6.19.orig/include/asm-ia64/pgtable.h	2006-12-09 13:22:47.000000000 +0900
+++ devel-2.6.19/include/asm-ia64/pgtable.h	2006-12-09 13:23:44.000000000 +0900
@@ -237,7 +237,7 @@
 #elif defined(CONFIG_VIRTUAL_MEM_MAP)
 #define VMALLOC_START		(RGN_BASE(RGN_GATE) + 0x200000000UL)
 
-#defineVMALLOC_END_INIT    (RGN_BASE(RGN_GATE) + (1UL << (4*PAGE_SHIFT - 9)))
+#define VMALLOC_END_INIT    (RGN_BASE(RGN_GATE) + (1UL << (4*PAGE_SHIFT - 9)))
 #define VMALLOC_END		vmalloc_end
 extern unsigned long vmalloc_end;
 #else

