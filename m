Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262147AbSJPLrX>; Wed, 16 Oct 2002 07:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262255AbSJPLrW>; Wed, 16 Oct 2002 07:47:22 -0400
Received: from [211.167.76.68] ([211.167.76.68]:40659 "HELO soulinfo")
	by vger.kernel.org with SMTP id <S262147AbSJPLrV>;
	Wed, 16 Oct 2002 07:47:21 -0400
Date: Wed, 16 Oct 2002 19:51:41 +0800
From: Hu Gang <hugang@soulinfo.com>
To: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: patch: make software suspend speedup in vmware virtual machine.
Message-Id: <20021016195141.653ec380.hugang@soulinfo.com>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.8.2claws28 (GTK+ 1.2.10; i386-linux-debian-i386-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.B21I2j0:vv:cO6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.B21I2j0:vv:cO6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello all:

With this patch 2.5.43 can resume only need ~5sec.
without this patch 2.5.43 also can resume, but need ~240sec.

This patch also can work in normal machine. But need more test.
--------------------------------------------------
--- arch/i386/kernel/suspend.c~old	Wed Oct 16 19:39:42 2002
+++ arch/i386/kernel/suspend.c	Wed Oct 16 19:38:21 2002
@@ -290,8 +290,8 @@
 		for (loop2=0; loop2 < PAGE_SIZE; loop2++) {
 			*(((char *)((pagedir_nosave+loop)->orig_address))+loop2) =
 				*(((char *)((pagedir_nosave+loop)->address))+loop2);
-			__flush_tlb();
 		}
+		__flush_tlb();
 	}
 
 	restore_processor_context();


-- 
		- Hu Gang

--=.B21I2j0:vv:cO6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9rVLQPM4uCy7bAJgRAouXAJ9LvxGejdHyZgKmr2jFv8cBqPI+hQCdHqYg
nSNH1S7P2DUNdRLRMSJLJtg=
=Hfqw
-----END PGP SIGNATURE-----

--=.B21I2j0:vv:cO6--
