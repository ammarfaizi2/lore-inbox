Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262173AbSJHMaA>; Tue, 8 Oct 2002 08:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262174AbSJHMaA>; Tue, 8 Oct 2002 08:30:00 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:14089 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S262173AbSJHM3z>; Tue, 8 Oct 2002 08:29:55 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15778.48230.397957.681553@laputa.namesys.com>
Date: Tue, 8 Oct 2002 15:07:18 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Jeff Dike <jdike@karaya.com>
Cc: user-mode-linux-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Reiserfs developers mail-list <Reiserfs-Dev@Namesys.COM>
Subject: [PATCH] export __do_copy_to_user
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-NSA-Fodder: SEAL Team 6 Vickie Weaver Noriega Ft. Knox munitions encryption
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Jeff,

this patch exports __do_copy_to_user() in arch/um/kernel/ksyms.c. This
is necessary to build any file-system as module in the UML.

Please, apply.

Nikita.
===== arch/um/kernel/ksyms.c 1.1 vs edited =====
--- 1.1/arch/um/kernel/ksyms.c	Thu Sep 12 16:23:05 2002
+++ edited/arch/um/kernel/ksyms.c	Tue Oct  8 14:31:14 2002
@@ -20,6 +20,7 @@
 EXPORT_SYMBOL(sys_waitpid);
 EXPORT_SYMBOL(task_size);
 EXPORT_SYMBOL(__do_copy_from_user);
+EXPORT_SYMBOL(__do_copy_to_user);
 EXPORT_SYMBOL(__do_strncpy_from_user);
 EXPORT_SYMBOL(__do_strnlen_user); 
 EXPORT_SYMBOL(flush_tlb_range);
