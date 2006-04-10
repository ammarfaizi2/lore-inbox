Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWDJG0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWDJG0O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 02:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWDJG0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 02:26:14 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:18316 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750970AbWDJG0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 02:26:14 -0400
Date: Mon, 10 Apr 2006 15:28:02 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] build fix  CONFIG_MEMORY_HOTPLUG=y on i386
Message-Id: <20060410152802.c21adf9c.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#ifdef is wrong. (2.6.17-rc1-mm2)

-Kame
==
typo in #ifdefs

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.17-rc1-mm2/arch/i386/mm/init.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/arch/i386/mm/init.c
+++ linux-2.6.17-rc1-mm2/arch/i386/mm/init.c
@@ -651,7 +651,7 @@ void __init mem_init(void)
  * Specifically, in the case of x86, we will always add
  * memory to the highmem for now.
  */
-#ifdef CONFIG_HOTPLUG_MEMORY
+#ifdef CONFIG_MEMORY_HOTPLUG
 #ifndef CONFIG_NEED_MULTIPLE_NODES
 int add_memory(u64 start, u64 size)
 {

