Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWDJJ0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWDJJ0s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 05:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWDJJ0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 05:26:48 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:30336 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751089AbWDJJ0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 05:26:47 -0400
Date: Mon, 10 Apr 2006 18:28:50 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] 2.6.17-rc1-mm2/ia64 compile acpi_memhotplug as module fix.
Message-Id: <20060410182850.5ba1e2a0.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This export was necessary to compile acpi_memhotplug.c as module.


Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Index: linux-2.6.17-rc1-mm2/arch/ia64/mm/init.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/arch/ia64/mm/init.c	2006-04-10 18:09:39.000000000 +0900
+++ linux-2.6.17-rc1-mm2/arch/ia64/mm/init.c	2006-04-10 18:22:32.000000000 +0900
@@ -671,9 +671,11 @@
 
 	return ret;
 }
+EXPORT_SYMBOL(add_memory);
 
 int remove_memory(u64 start, u64 size)
 {
 	return -EINVAL;
 }
+EXPORT_SYMBOL(remove_memory);
 #endif

