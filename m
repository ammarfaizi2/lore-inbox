Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318007AbSHVXEI>; Thu, 22 Aug 2002 19:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318016AbSHVXEI>; Thu, 22 Aug 2002 19:04:08 -0400
Received: from splat.lanl.gov ([128.165.17.254]:29868 "EHLO
	balance.radtt.lanl.gov") by vger.kernel.org with ESMTP
	id <S318007AbSHVXEH>; Thu, 22 Aug 2002 19:04:07 -0400
Date: Thu, 22 Aug 2002 17:08:16 -0600
From: Eric Weigle <ehw@lanl.gov>
To: rwhron@earthlink.net
Cc: "Linux kernel mailing list (lkml)" <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.31 qlogic error "this should not happen"
Message-ID: <20020822230816.GC21548@lanl.gov>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Eric-Conspiracy: There is no conspiracy
X-Editor: Vim, http://www.vim.org
X-GnuPG-fingerprint: 112E F8CA 12A9 771E DB10  6514 D4B0 D758 59EA 9C4F
X-GnuPG-key: http://public.lanl.gov/ehw/ehw.gpg.key
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

FWIW-

I occasionally saw that error on our 2.4 RAID system; it went away when I
increased the size of the handles array in qlogicfc.h:

-#define QLOGICFC_REQ_QUEUE_LEN  127 /* must be power of two - 1 */
+#define QLOGICFC_REQ_QUEUE_LEN  255 /* must be power of two - 1 */


I know this probably isn't the ``right'' solution, but it worked for me...
your mileage may vary.

-Eric

--=20
------------------------------------------------
 Eric H. Weigle -- http://public.lanl.gov/ehw/=20
------------------------------------------------

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9ZW7g1LDXWFnqnE8RAgFDAJ9TUsDntY84E8wQobv50b2sx7JPVgCgrEGi
Sa052MlhF2Z0kbfuYd89oeU=
=DJ9+
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
