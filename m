Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316934AbSEWQLW>; Thu, 23 May 2002 12:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316935AbSEWQLV>; Thu, 23 May 2002 12:11:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:55849 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S316934AbSEWQLU>;
	Thu, 23 May 2002 12:11:20 -0400
Date: Thu, 23 May 2002 18:11:04 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.4.17-cset1.656] patch to compile ext2 as module
Message-Id: <20020523181104.1896d674.sebastian.droege@gmx.de>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.D5uOyg8)22DjM4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.D5uOyg8)22DjM4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,
this trivial patch was necessary to compile ext2 as module (unresolved symbol write_mapping_buffers)... the problem exists since 2.5.16 I think

Bye

diff -Nur test/linux-2.5.17/kernel/ksyms.c linux-2.5.17/kernel/ksyms.c
--- test/linux-2.5.17/kernel/ksyms.c    Thu May 23 17:51:37 2002
+++ linux-2.5.17/kernel/ksyms.c Thu May 23 17:59:39 2002
@@ -48,6 +48,7 @@
 #include <linux/seq_file.h>
 #include <linux/binfmts.h>
 #include <linux/namei.h>
+#include <linux/buffer_head.h>
 #include <asm/checksum.h>
 
 #if defined(CONFIG_PROC_FS)
@@ -594,3 +595,4 @@
 
 EXPORT_SYMBOL(tasklist_lock);
 EXPORT_SYMBOL(pidhash);
+EXPORT_SYMBOL(write_mapping_buffers);

--=.D5uOyg8)22DjM4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE87RSde9FFpVVDScsRAo0fAJ4gv4uuFzArwBa3yUsQD+H7JoO4lQCfYmZE
mXEwpF3aNdBuY+ZR2sAZQPw=
=RAek
-----END PGP SIGNATURE-----

--=.D5uOyg8)22DjM4--

