Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265538AbUALSZy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 13:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265584AbUALSZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 13:25:54 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:38567 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S265538AbUALSZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 13:25:52 -0500
Subject: Re: [PROBLEM] ip_conntrack_ftp module oops under 2.6.1-mm2
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Srihari Vijayaraghavan <harisri@bigpond.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200401122329.38659.harisri@bigpond.com>
References: <200401122329.38659.harisri@bigpond.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WQH6cIrwrILMCAhv7Jb2"
Message-Id: <1073931946.752.80.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 12 Jan 2004 19:25:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WQH6cIrwrILMCAhv7Jb2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-01-12 at 13:29, Srihari Vijayaraghavan wrote:
> Executing
> "modprobe ip_conntrack_ftp" causes this oops:
>=20
> ip_conntrack version 2.1 (3968 buckets, 31744 max) - 300 bytes per conntr=
ack
> Module len 7233 truncated
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
004

This is probably due to a bug in a patch to the module subsystem in
2.6.1-mm2.

Please do a 'patch -R' of
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-m=
m2/broken-out/check-for-truncated-modules.patch
and try again.

--=20
/Martin

--=-WQH6cIrwrILMCAhv7Jb2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAAuaqWm2vlfa207ERAkBWAJ4+1llrK54DZXBX5RY0ZRMxEGHfPgCfYDfR
j6t9xmKFc17YbqEIRAT6PzQ=
=fumG
-----END PGP SIGNATURE-----

--=-WQH6cIrwrILMCAhv7Jb2--
