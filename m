Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265872AbSKFRz7>; Wed, 6 Nov 2002 12:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265873AbSKFRz7>; Wed, 6 Nov 2002 12:55:59 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:1796 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S265872AbSKFRz6>; Wed, 6 Nov 2002 12:55:58 -0500
Date: Wed, 6 Nov 2002 21:02:29 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5-bk] export ptrace_notify
Message-ID: <20021106210229.A686@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

binfmt_elf and binfmt_aout need this.

Ivan.

--- 2.5-bk/linux/kernel/ksyms.c	Wed Nov  6 01:44:33 2002
+++ linux/kernel/ksyms.c	Wed Nov  6 02:53:26 2002
@@ -53,6 +53,7 @@
 #include <linux/percpu.h>
 #include <linux/smp_lock.h>
 #include <linux/dnotify.h>
+#include <linux/ptrace.h>
 #include <asm/checksum.h>
 
 #if defined(CONFIG_PROC_FS)
@@ -600,3 +601,4 @@ EXPORT_SYMBOL(__per_cpu_offset);
 
 /* debug */
 EXPORT_SYMBOL(dump_stack);
+EXPORT_SYMBOL(ptrace_notify);
