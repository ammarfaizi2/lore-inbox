Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262823AbSJaQCd>; Thu, 31 Oct 2002 11:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbSJaQBq>; Thu, 31 Oct 2002 11:01:46 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:4622 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S262808AbSJaQB3>;
	Thu, 31 Oct 2002 11:01:29 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15809.21556.364239.763833@laputa.namesys.com>
Date: Thu, 31 Oct 2002 19:03:00 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Linus Torvalds <Torvalds@Transmeta.COM>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: [PATCH]: reiser4 [3/8] export page_cache_readahead()
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Antipastobozoticataclysm: Bariumenemanilow
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

    Following patch exports page_cache_readahead() so that file systems
    that don't use generic_file_read(), but do use page cache can
    perform readahead consistently.

Please apply.
Nikita.
diff -rup -X dontdiff linus-bk-2.5/kernel/ksyms.c linux-2.5-reiser4/kernel/ksyms.c
--- linus-bk-2.5/kernel/ksyms.c Fri Oct 18 03:00:41 2002
+++ linux-2.5-reiser4/kernel/ksyms.c    Tue Oct 29 17:18:22 2002
@@ -134,6 +134,7 @@ EXPORT_SYMBOL(kmap_pte);
 EXPORT_SYMBOL(page_address);
 #endif
 EXPORT_SYMBOL(get_user_pages);
+EXPORT_SYMBOL(page_cache_readahead);
 
 /* filesystem internal functions */
 EXPORT_SYMBOL(def_blk_fops);
