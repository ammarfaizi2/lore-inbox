Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262765AbUKTMD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbUKTMD0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 07:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUKTMBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 07:01:51 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:13786 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S262801AbUKTMAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 07:00:55 -0500
Date: Sat, 20 Nov 2004 13:00:39 +0100
From: Jan Hudec <bulb@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hbryan@us.ibm.com, akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz, torvalds@osdl.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-ID: <20041120120039.GS2870@vagabond>
References: <OF43CCF252.FCCFAB5B-ON88256F50.005CE35E-88256F50.005D8559@us.ibm.com> <E1CUprL-00041e-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bAwSoJxbKYwy34Oe"
Content-Disposition: inline
In-Reply-To: <E1CUprL-00041e-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bAwSoJxbKYwy34Oe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 18, 2004 at 18:14:15 +0100, Miklos Szeredi wrote:
>=20
> > I don't see how the OOM killer can help you here.  The OOM killer deals=
=20
> > with the system being out of virtual memory;
>=20
> What?  I think you are confusing something.  I'm not an expert, but I
> think usually you have lot's of virtual memory (4Gbyte per process),
> so killing off processes to get more of it makes no sense.=20
>=20
> Please corrent me if I'm wrong.

YOU are confusing something.

Virtual memory is RAM + swap (+ mmapped files, which behave similarly to
swap)

Virtual address space is a range of addresses that can be assigned to
that virtual memory and used to access it. Each process has 3GiB virtual
address space for disposition and kernel has another 1GiB mapped to
every process, making the total of 4GiB allowed by the CPU (talking
about i386 -- other CPU's can have different ranges).

If you run out of virtual memory, that is there is no room in RAM nor in
swap, than you have to kill some process -- that's what OOM killer is
about -- to free some.

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--bAwSoJxbKYwy34Oe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBnzHnRel1vVwhjGURAr3gAJ9kiLY//Gm+lLq+fsqIVJL8qVELTwCfW3iN
6Qa04v4EVB5tJ4Rp2FThrIc=
=5swc
-----END PGP SIGNATURE-----

--bAwSoJxbKYwy34Oe--
