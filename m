Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTJATbb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 15:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbTJATbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 15:31:31 -0400
Received: from dhcp160178171.columbus.rr.com ([24.160.178.171]:33801 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S262283AbTJATb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 15:31:29 -0400
Date: Wed, 1 Oct 2003 15:34:25 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Erik Andersen <andersen@codepoet.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix 2.4.x incorrect argv[0] for init
Message-ID: <20031001193425.GA19793@rivenstone.net>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Erik Andersen <andersen@codepoet.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0310011434400.6488-100000@dmt.cyclades> <20031001185613.GA13945@codepoet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20031001185613.GA13945@codepoet.org>
User-Agent: Mutt/1.5.4i
From: <jhf@rivenstone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2003 at 12:56:13PM -0600, Erik Andersen wrote:
> In 2.4.x when someone specifies "init=3D/bin/foo" to select an
> alternative binary to run instead of /sbin/init, argv[0] is not
> to the correct value.  This is a problem for programs such as
> busybox that multiplex applications based on the value of
> argv[0].  For example, even if you specify init=3D/bin/sh" on the
> kernel command line, busybox will still receive "/sbin/init" as
> argv[0], and will therefore run init rather than /bin/sh...
>=20
> This problem was recently fixed in 2.6.x.  This patch applies
> the same fix to 2.4.x.

    I didn't know that got merged.  Great!

    Debian users running 2.6: go install busybox-static, then make a
link from /sbin/sh to /bin/busybox.  If something bad happens to your
file system or libc or something like that, you can still boot with
init=3D/sbin/sh and get a shell prompt and all the important utilities
as long as /bin/busybox is okay.  It's a nice failsafe, especially
when testing kernels or running an unstable distribution.

   If this patch gets merged in 2.4, 2.4 users will be able to do this
too.

--=20
Joseph Fannin
jhf@rivenstone.net

"That's all I have to say about that." -- Forrest Gump.

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/eyxAWv4KsgKfSVgRAuYbAJ4j+dsDL+VwPQSWYMySx0nrBMZmWgCfZGz0
f2P3xMEky1SGuOQYJB+8Zww=
=gKL5
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
