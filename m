Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263817AbUDFNgN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 09:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263820AbUDFNgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 09:36:13 -0400
Received: from ns.suse.de ([195.135.220.2]:54939 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263817AbUDFNgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 09:36:01 -0400
Date: Tue, 6 Apr 2004 15:35:18 +0200
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: NUMA API for Linux 2/ Add x86-64 support
Message-Id: <20040406153518.43b125ad.ak@suse.de>
In-Reply-To: <20040406153322.5d6e986e.ak@suse.de>
References: <20040406153322.5d6e986e.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add NUMA API system calls on x86-64

diff -u linux-2.6.5-numa/include/asm-x86_64/unistd.h-o linux-2.6.5-numa/include/asm-x86_64/unistd.h
--- linux-2.6.5-numa/include/asm-x86_64/unistd.h-o	2004-03-17 12:17:59.000000000 +0100
+++ linux-2.6.5-numa/include/asm-x86_64/unistd.h	2004-04-06 13:36:12.000000000 +0200
@@ -532,10 +532,14 @@
 __SYSCALL(__NR_utimes, sys_utimes)
 #define __NR_vserver		236
 __SYSCALL(__NR_vserver, sys_ni_syscall)
+#define __NR_mbind 237
+__SYSCALL(__NR_mbind, sys_mbind)
+#define __NR_set_mempolicy 238
+__SYSCALL(__NR_set_mempolicy, sys_set_mempolicy)
+#define __NR_get_mempolicy 239
+__SYSCALL(__NR_get_mempolicy, sys_get_mempolicy)
 
-/* 237,238,239 reserved for NUMA API */
-
-#define __NR_syscall_max __NR_vserver
+#define __NR_syscall_max __NR_get_mempolicy
 #ifndef __NO_STUBS
 
 /* user-visible error numbers are in the range -1 - -4095 */
