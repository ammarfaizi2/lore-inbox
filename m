Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbUJYTQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbUJYTQq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 15:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbUJYTOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 15:14:51 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:46055 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261269AbUJYTNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 15:13:19 -0400
Message-Id: <200410251913.i9PJDCdC004434@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Nico Augustijn <kernel@janestarz.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cryptoloop patch for builtin default passphrase 
In-Reply-To: Your message of "Mon, 25 Oct 2004 20:57:57 +0200."
             <200410252057.58151.kernel@janestarz.com> 
From: Valdis.Kletnieks@vt.edu
References: <200410251354.31226.kernel@janestarz.com> <200410251719.i9PHJmOi009687@turing-police.cc.vt.edu>
            <200410252057.58151.kernel@janestarz.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-543223136P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Oct 2004 15:13:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-543223136P
Content-Type: text/plain; charset=us-ascii

On Mon, 25 Oct 2004 20:57:57 +0200, Nico Augustijn said:

> > Is this considered a desirable result?
> Yes. In this case it is very much a desirable result.
> As this patch is meant (as far as I am concerned) for embedded systems only, I 
> really don't want people to muck about with the BIOS settings (primary boot 
> device, for instance).

+config USE_CRYPTOLOOP_DEFAULTPASSPHRASE
+	bool "Use default passphrase for cryptoloop"
+	depends on BLK_DEV_CRYPTOLOOP && NVRAM

In that case, you probably wanted:

	depends on BLK_DEV_CRYPTOLOOP && NVRAM && EMBEDDED
	default n

It's just *too* fragile otherwise.

Remember - just because you don't want people to muck with the BIOS settings
doesn't mean that they won't.  And when they do, they probably won't remember
the warning they may or may not have read closely when they built the
kernel many moons ago.....


--==_Exmh_-543223136P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBfVBIcC3lWbTT17ARAnD5AJ9CftbshP+noTzLh4DxCdrRNdWtnACfeScS
IO3AngePTMACuOSlWhsnKlA=
=lSxg
-----END PGP SIGNATURE-----

--==_Exmh_-543223136P--
