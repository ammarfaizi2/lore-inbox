Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265135AbSJPQHi>; Wed, 16 Oct 2002 12:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265144AbSJPQHi>; Wed, 16 Oct 2002 12:07:38 -0400
Received: from pina.terra.com.br ([200.176.3.17]:64389 "EHLO pina.terra.com.br")
	by vger.kernel.org with ESMTP id <S265135AbSJPQHf>;
	Wed, 16 Oct 2002 12:07:35 -0400
Subject: [TRIVIAL PATCH - 2.5.43] brokem module compile
From: Lucio Maciel <abslucio@terra.com.br>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-To+Uqh4W9E4p8BeYgMp7"
X-Mailer: Ximian Evolution 1.0.7 
Date: 16 Oct 2002 13:13:30 -0300
Message-Id: <1034784811.5354.3.camel@walker>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-To+Uqh4W9E4p8BeYgMp7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all..

This patch export some symbols to compile nfs, nfsd, ext3 and ext2 (and
possible others ??) as modules in 2.5.43.

best regards
-- 
::: Lucio F. Maciel
::: abslucio@terra.com.br
::: icq 93065464
::: Absoluta.net

--=-To+Uqh4W9E4p8BeYgMp7
Content-Disposition: attachment; filename=export_symbols.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=export_symbols.diff; charset=ANSI_X3.4-1968

diff --exclude=3Darch --exclude=3Ddrivers --exclude=3Dinclude --exclude=3Di=
nit --exclude=3Dipc --exclude=3Dkernel --exclude=3Dlib --exclude=3Dscripts =
--exclude=3Dsecurity --exclude=3Dsound --exclude=3D'*.diff' -uNr ../linux-2=
.5.42/mm/filemap.c ./mm/filemap.c
--- ../linux-2.5.43-old/mm/filemap.c	2002-10-16 10:37:14.000000000 -0300
+++ ./mm/filemap.c	2002-10-16 10:19:26.000000000 -0300
@@ -891,6 +891,7 @@
 	BUG_ON(iocb->ki_pos !=3D pos);
 	return __generic_file_aio_read(iocb, &local_iov, 1, &iocb->ki_pos);
 }
+EXPORT_SYMBOL(generic_file_aio_read);
=20
 ssize_t
 generic_file_read(struct file *filp, char *buf, size_t count, loff_t *ppos=
)
@@ -1650,6 +1651,7 @@
 {
 	return generic_file_write(iocb->ki_filp, buf, count, &iocb->ki_pos);
 }
+EXPORT_SYMBOL(generic_file_aio_write);
=20
 ssize_t generic_file_write(struct file *file, const char *buf,
 			   size_t count, loff_t *ppos)
diff --exclude=3Darch --exclude=3Ddrivers --exclude=3Dinclude --exclude=3Di=
nit --exclude=3Dipc --exclude=3Dkernel --exclude=3Dlib --exclude=3Dscripts =
--exclude=3Dsecurity --exclude=3Dsound --exclude=3D'*.diff' -uNr ../linux-2=
.5.42/net/sunrpc/sunrpc_syms.c ./net/sunrpc/sunrpc_syms.c
--- ../linux-2.5.43-old/net/sunrpc/sunrpc_syms.c	2002-10-12 00:22:18.000000=
000 -0400
+++ ./net/sunrpc/sunrpc_syms.c	2002-10-16 10:34:06.000000000 -0300
@@ -23,6 +23,26 @@
 #include <linux/sunrpc/svcsock.h>
 #include <linux/sunrpc/auth.h>
=20
+/* CACHE FUNCTIONS for nfsd */
+EXPORT_SYMBOL(cache_fresh);
+EXPORT_SYMBOL(cache_check);
+EXPORT_SYMBOL(cache_flush);
+EXPORT_SYMBOL(cache_unregister);
+EXPORT_SYMBOL(cache_clean);
+EXPORT_SYMBOL(cache_register);
+EXPORT_SYMBOL(cache_init);
+
+EXPORT_SYMBOL(auth_domain_find);
+EXPORT_SYMBOL(auth_unix_lookup);
+EXPORT_SYMBOL(auth_unix_add_addr);
+EXPORT_SYMBOL(auth_unix_forget_old);
+EXPORT_SYMBOL(auth_domain_put);
+EXPORT_SYMBOL(svcauth_unix_purge);
+
+EXPORT_SYMBOL(unix_domain_find);
+EXPORT_SYMBOL(add_hex);
+EXPORT_SYMBOL(get_word);
+EXPORT_SYMBOL(add_word);
=20
 /* RPC scheduler */
 EXPORT_SYMBOL(rpc_allocate);


--=-To+Uqh4W9E4p8BeYgMp7--

