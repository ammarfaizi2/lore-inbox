Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318140AbSHDKJ5>; Sun, 4 Aug 2002 06:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318142AbSHDKJ5>; Sun, 4 Aug 2002 06:09:57 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:27657 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S318140AbSHDKJ5>;
	Sun, 4 Aug 2002 06:09:57 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 make allmodconfig - undefined symbols
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 04 Aug 2002 20:13:20 +1000
Message-ID: <29906.1028456000@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.19 make allmodconfig.  Besides the perennial drivers/net/wan/comx.o
wanting proc_get_inode, there was only one undefined symbol.  In the
extremely unlikely event that binfmt_elf is a module (how do you load
modules when binfmt_elf is a module?), smp_num_siblings is unresolved.

Index: 19.1/arch/i386/kernel/i386_ksyms.c
--- 19.1/arch/i386/kernel/i386_ksyms.c Wed, 17 Jul 2002 12:08:06 +1000 kaos (linux-2.4/S/c/7_i386_ksyms 1.2.1.21 644)
+++ 19.1(w)/arch/i386/kernel/i386_ksyms.c Sun, 04 Aug 2002 20:09:37 +1000 kaos (linux-2.4/S/c/7_i386_ksyms 1.2.1.21 644)
@@ -129,6 +129,7 @@ EXPORT_SYMBOL(mmx_copy_page);
 EXPORT_SYMBOL(cpu_data);
 EXPORT_SYMBOL(kernel_flag_cacheline);
 EXPORT_SYMBOL(smp_num_cpus);
+EXPORT_SYMBOL(smp_num_siblings);
 EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL_NOVERS(__write_lock_failed);
 EXPORT_SYMBOL_NOVERS(__read_lock_failed);

