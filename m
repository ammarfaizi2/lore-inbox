Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268490AbUIXGt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268490AbUIXGt4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 02:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268532AbUIXGpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 02:45:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48858 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268515AbUIXGkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 02:40:51 -0400
Subject: Re: 2.6.9-rc2-mm2: devmem_is_allowed
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Martin Diehl <lists@mdiehl.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0409240030210.14340-100000@notebook.home.mdiehl.de>
References: <Pine.LNX.4.44.0409240030210.14340-100000@notebook.home.mdiehl.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kgikf2By5opisltrc6k4"
Organization: Red Hat UK
Message-Id: <1096008029.2612.37.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 24 Sep 2004 08:40:29 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kgikf2By5opisltrc6k4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-09-24 at 00:37, Martin Diehl wrote:
> Hi,
>=20
> after switching from working 2.6.9-rc2 to -mm2, X refused to start on my=20
> testbox. It turned out this was because it failed (EPERM) reading from=20
> /dev/mem beyond the 1MB limit.

can you get me a strace of the failing X server?
The code as is is as designed; X has no business messing with kernel ram
over 1Mb, there is nothing there for it to (ab)use.
(There is PCI memory much higher up but that is allowed again)

--=-kgikf2By5opisltrc6k4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBU8FdxULwo51rQBIRAkrAAJ9slpgdOouPWhsN0dUNn25LxpSZQACfZCkG
1ixIHRk114FvJ/SXdoDUzM4=
=uknC
-----END PGP SIGNATURE-----

--=-kgikf2By5opisltrc6k4--

