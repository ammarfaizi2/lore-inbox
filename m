Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315420AbSEGLyM>; Tue, 7 May 2002 07:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315421AbSEGLyL>; Tue, 7 May 2002 07:54:11 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:45323 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S315420AbSEGLyK>;
	Tue, 7 May 2002 07:54:10 -0400
Date: Tue, 7 May 2002 15:58:54 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: linux-kernel@vger.kernel.org
Subject: [Q] get_ma_area() function
Message-ID: <20020507115854.GB620@pazke.ipt>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.10 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

looking at mm/vmalloc.c i found one strange (for me) line of code.

=46rom mm/vmalloc.c:

struct vm_struct * get_vm_area(unsigned long size, unsigned long flags)
{
	unsigned long addr;
	struct vm_struct **p, *tmp, *area;

	area =3D (struct vm_struct *) kmalloc(sizeof(*area), GFP_KERNEL);
	if (!area)
		return NULL;
	size +=3D PAGE_SIZE;
	^^^^^^^^^^^^^^^^^^
Why ? Maybe size =3D PAGE_ALIGN(size); is more correct here ?

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE818F+Bm4rlNOo3YgRAp77AJ9s+2G2DUgieX5Bzg85nih65NpXmACfYjC4
l7Yz0VBbZ658/9l0+TFCy98=
=jz9v
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--
