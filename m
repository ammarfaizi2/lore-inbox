Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264560AbUEOAA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264560AbUEOAA0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 20:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbUEOAAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 20:00:12 -0400
Received: from dhcp160178171.columbus.rr.com ([24.160.178.171]:24329 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S264560AbUENX4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:56:33 -0400
Date: Fri, 14 May 2004 19:56:28 -0400
To: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2
Message-ID: <20040514235628.GA877@samarkand.rivenstone.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
References: <20040513032736.40651f8e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <20040513032736.40651f8e.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
From: jhf@rivenstone.net (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 13, 2004 at 03:27:36AM -0700, Andrew Morton wrote:
>=20
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6=
-mm2/

> +rlim-add-rlimit-entry-for-posix-mqueue-allocation.patch

    The above patch includes linux/mqueue.h from
arch/*/kernel/init_task.c for each arch.  Building the kernel fails on
ppc because ppc doesn't have an init_task.c; the setting of
CONFIG_POSIX_MQUEUE doesn't matter.  I added the include to
arch/ppc/kernel/process.c and the resulting kernel boots ok, but this
is probably not the correct place to put it.

    cris and m68k don't have an init_task.c either.

--=20
Joseph Fannin
jhf@rivenstone.net

"Bull in pure form is rare; there is usually some contamination by data."
    -- William G. Perry Jr.

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFApVyqWv4KsgKfSVgRAk/HAJ4wZEfiIUy+LbFLSG3jQql9wZb9pgCdFGLu
oMXBYvYsg95LfDkTijfgyRM=
=engL
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
