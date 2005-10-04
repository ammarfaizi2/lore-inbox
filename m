Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbVJDHho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbVJDHho (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 03:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbVJDHhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 03:37:43 -0400
Received: from wg.technophil.ch ([213.189.149.230]:4048 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S932119AbVJDHhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 03:37:43 -0400
Date: Tue, 4 Oct 2005 09:37:40 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: coywolf@lovecn.org
Cc: Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org
Subject: Re: halt: init exits/panic
Message-ID: <20051004073740.GA1498@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	coywolf@lovecn.org, linux-kernel@vger.kernel.org
References: <20050709151227.GM1322@schottelius.org> <2cd57c9005070910091f1051f7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <2cd57c9005070910091f1051f7@mail.gmail.com>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Coywolf Qi Hunt [Sun, Jul 10, 2005 at 01:09:22AM +0800]:
> On 7/9/05, Nico Schottelius <nico-kernel@schottelius.org> wrote:
> > Hello!
> >=20
> > What's the 'correct behaviour' of an init system, if someone wants
> > to shutdown the system?
> >=20
> > I currently do:
> >=20
> > - call reboot(RB_POWER_OFF/RB_AUTOBOOT/RB_HALT_SYSTEM)
> > - _exit(0)
> >=20
> > Is this exit() call wrong? If I do RB_HALT_SYSTEM and _exit(0) after,
> > the kernel panics.
>=20
> What the panic shows?

To be fully correct:

"Kernel panic - not syncing: Attempted to kill init" (from the last time
I tried, 2.6.13.2)

Perhaps _exit(0) is not correct for an init system?
This at least explains why it always looks like nothing is synced.

Nico

--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ0IxQ7OTBMvCUbrlAQLQRw//SP4YEcSZBIJKP0UKkD+Fgo9g/qEKXw0u
C4rJW8A5buLE4ld1pBT9XLu57pg+RT/1auemBUUdNC2TbT5oIHNz1tcjZrXtUk62
cnjLFwgy7lwFT/opr2I2yl0nY0PVVvX8aBgXYXCutEtqBXaVKrHs1ipbDMf0cCyu
05jQWl/qjBfXoV8hUOppaFb8wMd7xnVWkIYg/cq1D7rmIGwzOZsZlUWG58zjaVKx
AkxRcTzo0SXOJY2v+A7MEPK8OayD/qDoecPbXOPeDllPF+sFd4I3+E8XrEstbTTy
QYoM/4rbuuIlYV7XLfqLyYyiuHnHEVn4uPLGmXpxqZczF+OLIITmJmtdOZOAEfol
DEpSsLAHBzGNwGJC8XxY3kc/prebX2p8TkMWJcNUhm2ndPDjsM9r/TN7RoFddazX
+3legSp2nCYy7pMx7f+xqRJEEs9FXjq0p2Pkifzf0sXoNVwHwBxkBaJifMwULKVz
ckYjbX8e4lIaz7OlCoI1YSEhR5kqTmL90NqYFR02FXZkPP8rcv1ruzi4wHjQpuTj
3MvelEiv//VTePVjyXpr5m1a+B10fI7Byd7VgBSf9nM+Vm4QWQ7SpD834hgSTq5u
mK80/sLIpm/wOZDg3InE7N635ZNd7NN6LhnpyP4q8oB9caWTOT/KV7FReFVb99Za
A7pKmdzgHag=
=OiNI
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
