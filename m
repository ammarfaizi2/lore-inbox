Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbTEFVFa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 17:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTEFVF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 17:05:29 -0400
Received: from kknd.mweb.co.za ([196.2.45.79]:4836 "EHLO kknd.mweb.co.za")
	by vger.kernel.org with ESMTP id S261769AbTEFVFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 17:05:25 -0400
Date: Tue, 6 May 2003 23:17:25 +0200
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: perex@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][2.5.69][ISAPNP] Remove deprecated __check_region
Message-Id: <20030506231725.40e3a0d3.bonganilinux@mweb.co.za>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.yIH6:'WL_Piugi"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.yIH6:'WL_Piugi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jaroslav

You are listed as the maintainer of the ISAPNP code in the Maintainers file. 
Could you verify if this patch is fine and forward it to Linus. The patch 
has been test for compilation.

Thanx

	-- Bongani


--- linux-2.5/drivers/pnp/isapnp/core.c.orig    2003-05-06 22:52:20.000000000 +0200
+++ linux-2.5/drivers/pnp/isapnp/core.c 2003-05-06 23:11:13.000000000 +0200
@@ -262,7 +262,7 @@
                 *      We cannot use NE2000 probe spaces for ISAPnP or we
                 *      will lock up machines.
                 */
-               if ((rdp < 0x280 || rdp >  0x380) && !check_region(rdp, 1))
+               if ((rdp < 0x280 || rdp >  0x380) && request_region(rdp, 1, "isapnp"))
                {
                        isapnp_rdp = rdp;
                        return 0;

--=.yIH6:'WL_Piugi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+uCZx+pvEqv8+FEMRAmjpAJ4qr4gqzyiZmyX57s4dMoSoBUSfRwCdEXAD
etZQfYmV4x0js27GyGm3jm4=
=ZVQh
-----END PGP SIGNATURE-----

--=.yIH6:'WL_Piugi--
