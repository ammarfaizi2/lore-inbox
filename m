Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbTEFVGH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 17:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbTEFVGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 17:06:07 -0400
Received: from starcraft.mweb.co.za ([196.2.45.78]:8635 "EHLO
	starcraft.mweb.co.za") by vger.kernel.org with ESMTP
	id S261300AbTEFVGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 17:06:03 -0400
Date: Tue, 6 May 2003 23:18:22 +0200
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: ambx1@neo.rr.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][2.5.69][PNP] Remove deprecated __check_region
Message-Id: <20030506231822.201511c6.bonganilinux@mweb.co.za>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.Oju_65ZQ).(knN"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.Oju_65ZQ).(knN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Adam

You are listed as the maintainer of the ISAPNP code in the Maintainers file. 
Could you verify if this patch is fine and forward it to Linus. The patch 
has been test for compilation.

Thanx

	-- Bongani

--- linux-2.5/drivers/pnp/resource.c.orig       2003-05-06 22:43:52.000000000 +0200
+++ linux-2.5/drivers/pnp/resource.c    2003-05-06 22:51:41.000000000 +0200
@@ -295,7 +295,7 @@

        /* check if the resource is already in use, skip if the device is active because it itself may be in use */
        if(!dev->active) {
-               if (check_region(*port, length(port,end)))
+               if (!request_region(*port, length(port,end), "pnp"))
                        return CONFLICT_TYPE_IN_USE;
        }

@@ -366,7 +366,7 @@

        /* check if the resource is already in use, skip if the device is active because it itself may be in use */
        if(!dev->active) {
-               if (__check_region(&iomem_resource, *addr, length(addr,end)))
+               if (!__request_region(&iomem_resource, *addr, length(addr,end), "pnp"))
                        return CONFLICT_TYPE_IN_USE;
        }


--=.Oju_65ZQ).(knN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+uCan+pvEqv8+FEMRAo44AJ44rgNryrUXiAPHhtecGGNfJ/W7zQCfULIb
y7++EPUFhLIlrNVIoXQfbxI=
=fYPn
-----END PGP SIGNATURE-----

--=.Oju_65ZQ).(knN--
