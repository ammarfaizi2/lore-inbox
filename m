Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWCPDjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWCPDjN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbWCPDjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:39:12 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:48330 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932372AbWCPDjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:39:11 -0500
Date: Thu, 16 Mar 2006 12:38:05 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] for_each_possible_cpu [18/19] x86_64
Message-Id: <20060316123805.4e246e3a.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces for_each_cpu with for_each_possible_cpu.
Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.16-rc6-mm1/include/asm-x86_64/percpu.h
===================================================================
--- linux-2.6.16-rc6-mm1.orig/include/asm-x86_64/percpu.h
+++ linux-2.6.16-rc6-mm1/include/asm-x86_64/percpu.h
@@ -26,7 +26,7 @@
 #define percpu_modcopy(pcpudst, src, size)			\
 do {								\
 	unsigned int __i;					\
-	for_each_cpu(__i)					\
+	for_each_possible_cpu(__i)				\
 		memcpy((pcpudst)+__per_cpu_offset(__i),		\
 		       (src), (size));				\
 } while (0)
