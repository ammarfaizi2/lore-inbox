Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293106AbSCENQ6>; Tue, 5 Mar 2002 08:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293119AbSCENQs>; Tue, 5 Mar 2002 08:16:48 -0500
Received: from mail.gmx.de ([213.165.64.20]:13137 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S293106AbSCENQd>;
	Tue, 5 Mar 2002 08:16:33 -0500
Date: Tue, 5 Mar 2002 14:20:43 +0100
From: Sebastian Droege <sebastian.droege@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: [2.5.6-pre2] Fix for dmfe.c with newer binutils
Message-Id: <20020305142043.7b2884b4.sebastian.droege@gmx.de>
X-Mailer: Sylpheed version 0.7.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary=":Fe39S=.L.QLz3bZ"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--:Fe39S=.L.QLz3bZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,
here is a really simple fix for the link problems with newer binutils
it's already fixed this way in 2.4.18 and 2.5.5-dj2

Bye

--- linux-2.5.5/drivers/net/dmfe.c~     Tue Mar  5 14:12:49 2002
+++ linux-2.5.5/drivers/net/dmfe.c      Tue Mar  5 14:09:43 2002
@@ -1986,7 +1986,7 @@
        name:           "dmfe",
        id_table:       dmfe_pci_tbl,
        probe:          dmfe_init_one,
-       remove:         dmfe_remove_one,
+       remove:         __devexit_p(dmfe_remove_one),
 };
 
 MODULE_AUTHOR("Sten Wang, sten_wang@davicom.com.tw");
--:Fe39S=.L.QLz3bZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8hMYue9FFpVVDScsRAm3qAKDnHtAYqQ0HpqhIsMV0KPOPjzb56QCg9I+z
iV1GI7Kcng2hOzth9ATKbSk=
=gymR
-----END PGP SIGNATURE-----

--:Fe39S=.L.QLz3bZ--

