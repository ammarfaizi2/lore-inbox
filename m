Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbTLEN4R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 08:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264137AbTLEN4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 08:56:17 -0500
Received: from [68.114.43.143] ([68.114.43.143]:11228 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S264134AbTLEN4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 08:56:13 -0500
Date: Fri, 5 Dec 2003 08:56:07 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Kristian Peters <kristian.peters@korseby.net>
Cc: Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: oom killer in 2.4.23
Message-ID: <20031205135607.GP16568@rdlg.net>
Mail-Followup-To: Kristian Peters <kristian.peters@korseby.net>,
	Andrea Arcangeli <andrea@suse.de>,
	lkml <linux-kernel@vger.kernel.org>
References: <Z6Iv-7O2-29@gated-at.bofh.it> <Z8Ag-3BK-3@gated-at.bofh.it> <Zbyn-23P-29@gated-at.bofh.it> <20031205140520.39289a3a.kristian.peters@korseby.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0aF+6pWUK5w8WdCh"
Content-Disposition: inline
In-Reply-To: <20031205140520.39289a3a.kristian.peters@korseby.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0aF+6pWUK5w8WdCh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable




Thus spake Kristian Peters (kristian.peters@korseby.net):

> Andrea Arcangeli <andrea@suse.de> schrieb:
> > Marcelo asked me to to make it configurable at runtime so you could go
> > in the deadlock prone stautus of 2.4.22 on demand, but I'm not going to
> > add more features to 2.4 today unless they're blocker bugs (even if that
> > would be simple to implement), actually it's not even my choice so don't
> > ask me for that sorry.
>=20
> Andrea, your vm does not work correctly in any cases.
>=20
> It's so simple. I've tried to fill up my memory with that crappy khexedit=
 that comes with kde2. You'll see how my memory fills with the contents of =
the whole file I load. When I have started 2 or 3 instances of khexedit my =
memory was nearly completely filled. Than I tried to start another khexedit=
 (with a file that should nearly fit into memory), and the pain began.
>=20
> See:
>=20
> Dec  5 13:33:52 adlib kernel: __alloc_pages: 2-order allocation failed (g=
fp=3D0x1f0/0)
> Dec  5 13:33:52 adlib kernel: __alloc_pages: 0-order allocation failed (g=
fp=3D0x1f0/0)
> Dec  5 13:33:59 adlib kernel: __alloc_pages: 0-order allocation failed (g=
fp=3D0xf0/0)
> Dec  5 13:33:59 adlib kernel: __alloc_pages: 0-order allocation failed (g=
fp=3D0x1f0/0)
<snip>
> Dec  5 13:37:57 adlib kernel: __alloc_pages: 0-order allocation failed (g=
fp=3D0xf0/0)
> Dec  5 13:37:58 adlib kernel: __alloc_pages: 0-order allocation failed (g=
fp=3D0x1f0/0)
> Dec  5 13:40:32 adlib kernel: __alloc_pages: 0-order allocation failed (g=
fp=3D0x1d2/0)
> Dec  5 13:40:32 adlib kernel: VM: killing process XFree86
>=20
> -------> ouch ...
>=20
>=20
> Ok. Could you please describe what your vm really does here in my specifi=
c case ?
> Rick's old vm worked better. It'd have killed the task that had last allo=
cated memory.
>=20
> PS: If you need more details it should be no problem to do this again.
>=20
>=20

I'm see'ing similar except it's killing random apps such as CRON, named
and some others.

How far do I have to roll back to get the previous oomkiller?  Trying to
roll 2.4.23 out.


:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--0aF+6pWUK5w8WdCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/0I538+1vMONE2jsRAh0oAKCe07ON8E4P1h1gi300O3QHcVbmnwCfVRcH
b96GiWKOooF/a4oFt1RvLP0=
=kFeI
-----END PGP SIGNATURE-----

--0aF+6pWUK5w8WdCh--
