Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266717AbUGLEt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266717AbUGLEt4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 00:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266720AbUGLEt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 00:49:56 -0400
Received: from lists.us.dell.com ([143.166.224.162]:51843 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S266717AbUGLEty
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 00:49:54 -0400
Date: Sun, 11 Jul 2004 23:49:46 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       akpm <akpm@osdl.org>
Subject: Re: [PATCH] edd (Re: Linux 2.6.8-rc1)
Message-ID: <20040712044946.GA21325@lists.us.dell.com>
References: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org> <20040711160019.00c2d658.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20040711160019.00c2d658.rddunlap@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 11, 2004 at 04:00:19PM -0700, Randy.Dunlap wrote:
> drivers/built-in.o: In function `edd_has_mbr_signature':
> drivers/built-in.o(.text+0x13b84f): undefined reference to `edd'
> drivers/built-in.o(.init.text+0xd39c): more undefined references to `edd'=
 follow
>=20
> CONFIG_EDD=3Dy on X86o
>=20
> 'edd' needs to be exported for drivers/firmware/edd.c

I don't think so.  It only needs be exported if a module is going to
use it.  Since you're building it in, not as a module, it should be
fine.

My own 'make defconfig' on a clean BK tree, enabling CONFIG_EDD=3Dy,
links correctly.  Perhaps a make mrproper; make would be in order, as the
deps stage should have caught it for you...

Thanks,
Matt

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA8hhqIavu95Lw/AkRAm0+AJ9gPH7dzCOAKWXqropmaU20KHGyEQCbB+M9
E2eUa6PSl22kvVYL0utWXqE=
=d+nU
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
