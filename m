Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262013AbSJDSl6>; Fri, 4 Oct 2002 14:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261954AbSJDSlt>; Fri, 4 Oct 2002 14:41:49 -0400
Received: from 3512-780200-170.dialup.surnet.ru ([212.57.170.170]:50702 "EHLO
	zzz.zzz") by vger.kernel.org with ESMTP id <S262013AbSJDSlp>;
	Fri, 4 Oct 2002 14:41:45 -0400
Date: Fri, 4 Oct 2002 22:43:43 +0600
From: Denis Zaitsev <zzz@cd-club.ru>
To: davej@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [TRIVIAL] 2.5.40 APM module: unresolved cpu_gdt_table 
Message-ID: <20021004224343.A346@natasha.zzz.zzz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the "unresolved cpu_gdt_table" error for the APM
module.  Please, apply it.  (I suspect that smth. like is already
applied...)


--- arch/i386/kernel/i386_ksyms.c.orig	Thu Oct  3 23:34:55 2002
+++ arch/i386/kernel/i386_ksyms.c	Fri Oct  4 10:00:28 2002
@@ -38,6 +38,8 @@
 EXPORT_SYMBOL(machine_real_restart);
 extern void default_idle(void);
 EXPORT_SYMBOL(default_idle);
+extern struct desc_struct cpu_gdt_table[][];
+EXPORT_SYMBOL(cpu_gdt_table);
 #endif
 
 #ifdef CONFIG_SMP
