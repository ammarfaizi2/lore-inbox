Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264859AbSKENtE>; Tue, 5 Nov 2002 08:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264860AbSKENtE>; Tue, 5 Nov 2002 08:49:04 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:17158 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S264859AbSKENtD>; Tue, 5 Nov 2002 08:49:03 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15815.52697.903554.908594@laputa.namesys.com>
Date: Tue, 5 Nov 2002 16:55:37 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Linus Torvalds <Torvalds@Transmeta.COM>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: [PATCH]: fix typo in usr/Makefile
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Antipastobozoticataclysm: When George Bush projectile vomits antipasto on the Japanese.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

following patch fixes typo introduced by last changeset: "./$<" already
contains directory.

Please apply.
Nikita.
===== usr/Makefile 1.3 vs edited =====
--- 1.3/usr/Makefile	Tue Nov  5 01:04:41 2002
+++ edited/usr/Makefile	Tue Nov  5 16:48:19 2002
@@ -11,6 +11,6 @@
 	$(call if_changed,ld)
 
 $(obj)/initramfs_data.cpio.gz: $(obj)/gen_init_cpio
-	( cd $(obj) ; ./$< | gzip -9c > $@ )
+	( ./$< | gzip -9c > $@ )
 
 

