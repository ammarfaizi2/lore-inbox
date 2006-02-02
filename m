Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWBBPCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWBBPCf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 10:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWBBPCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 10:02:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52152 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751117AbWBBPCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 10:02:34 -0500
Subject: Re: 2.6.15-rt16
From: Clark Williams <williams@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: chris perkins <cperkins@OCF.Berkeley.EDU>, linux-kernel@vger.kernel.org
In-Reply-To: <1138843335.6632.35.camel@localhost.localdomain>
References: <Pine.SOL.4.63.0601300839050.8546@conquest.OCF.Berkeley.EDU>
	 <1138640592.12625.0.camel@localhost.localdomain>
	 <Pine.SOL.4.63.0601300917120.8546@conquest.OCF.Berkeley.EDU>
	 <1138653235.26657.7.camel@localhost.localdomain>
	 <Pine.SOL.4.63.0601310946000.8770@conquest.OCF.Berkeley.EDU>
	 <1138730835.5959.3.camel@localhost.localdomain>
	 <1138818770.6685.1.camel@localhost.localdomain>
	 <1138819142.18762.10.camel@localhost.localdomain>
	 <1138830476.6632.5.camel@localhost.localdomain>
	 <1138830694.18762.46.camel@localhost.localdomain>
	 <1138832179.6632.12.camel@localhost.localdomain>
	 <1138833380.18762.67.camel@localhost.localdomain>
	 <1138843335.6632.35.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-AHL0IMFpoUtMHKAt4oCs"
Date: Thu, 02 Feb 2006 09:01:59 -0600
Message-Id: <1138892519.3168.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AHL0IMFpoUtMHKAt4oCs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-02-01 at 20:22 -0500, Steven Rostedt wrote:
> Clark,
>=20
> [...]
> switchroot: exec'ing /sbin/init
> init[1]: segfault at ffffffff8010fadc rip ffffffff8010fadc rsp 00007fffff=
dacfc8 error 15
> Kernel panic - not syncing: Segfault in init
> [...]
>=20
>=20
> Could you find where that ffffffff8010fadc is.  Compile with debug info,
> and (what I do) is a "gdb vmlinux" and "li *0xffffffff8010fadc" to find
> the location.  The dump may be something that is done after the init
> exits.

If the panic backtrace is to be believed, that's the address of mcount
(arch/x86_64/kernel/entry.S).=20

The code 0x15 at the end of the segfault message means (according to the
comment in fault.c) that the segfault is the result of a user-mode
protection fault while reading the address ffffffff8010fadc.=20

Clark

--=20
Clark Williams <williams@redhat.com>

--=-AHL0IMFpoUtMHKAt4oCs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4h7nHyuj/+TTEp0RArbKAKCoyJhjlA2oi64jXc/9+m3nvFqkWwCeIJnb
Iro4FMHrIaACwMTZ+D9b7y0=
=W91+
-----END PGP SIGNATURE-----

--=-AHL0IMFpoUtMHKAt4oCs--

