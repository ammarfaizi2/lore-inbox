Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267628AbTALXGf>; Sun, 12 Jan 2003 18:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267634AbTALXGf>; Sun, 12 Jan 2003 18:06:35 -0500
Received: from h80ad2762.async.vt.edu ([128.173.39.98]:11136 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267628AbTALXFM>; Sun, 12 Jan 2003 18:05:12 -0500
Message-Id: <200301122313.h0CNDCkr003745@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: linus@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.56 - missing EXPORT_SYMBOL in fs/devfs/base.c
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1721785525P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 12 Jan 2003 18:13:12 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1721785525P
Content-Type: text/plain; charset=us-ascii

Tripped over this while trying to build arch/i386/kernel/microcode.c as
a module.

This apparently got removed by accident in 2.5.53 while cleaning up
the devfs_{get,set} stuff.

*** fs/devfs/base.c.dist	2003-01-12 18:06:51.000000000 -0500
--- fs/devfs/base.c	2003-01-12 18:07:41.000000000 -0500
***************
*** 1954,1959 ****
--- 1954,1960 ----
  EXPORT_SYMBOL(devfs_remove);
  EXPORT_SYMBOL(devfs_generate_path);
  EXPORT_SYMBOL(devfs_only);
+ EXPORT_SYMBOL(devfs_set_file_size);
  
  
  /**



--==_Exmh_-1721785525P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+IfaHcC3lWbTT17ARAkFxAKDv99ZCy6smUyz48YOnzVVhgzc0YQCfcprL
BXEUHOr+nxgmjxSRUFtLN54=
=2rmg
-----END PGP SIGNATURE-----

--==_Exmh_-1721785525P--
