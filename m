Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263311AbTJKNld (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 09:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263314AbTJKNld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 09:41:33 -0400
Received: from 24-216-47-19.charter.com ([24.216.47.19]:62104 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S263311AbTJKNla
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 09:41:30 -0400
Date: Sat, 11 Oct 2003 09:41:27 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Stale NFS Handles in 2.6
Message-ID: <20031011134127.GU20940@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0cPfB1ccX8kkdppm"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0cPfB1ccX8kkdppm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Hi,
> > since 2.6.0-test6 I get "Stale NFS file handle" when transferring huge
> > amounts=20
> > of data from a nfs-server which is running on -test6.
> > The client also runs -test6. Transfers from a server running kernel
> > 2.4.22=20
> > work flawless.
> >=20
> > I use the nfs-kernel-server 1.0.6 on Debian/sid.
>=20
> Are you using mount options when mounting the NFS volume?
> I had this problem when I used rsize=3D8192 and wsize=3D8192 as nfs mount
> options. Just left them out and everything was fine again.
>=20
> Axel

Will this help the Stale NFS problem I'm getting as well? (Detailed
below)

---------------------------------
> >
> >
> >   I've been trying to run my NFS server on 2.6 kernels for a while
> >   now.
> > My desktop and my Firewall are both 2.6 already and happy.  My
> > fileserver though is giving me an ulcer.
>
> >   I get the stale handles.  Reverting back to 2.4 and all is well on
> >   the
> > same export and mount configs.
> >
> > Thoughts?
> you could search the archives for "NFS Problem" and "STALE", you
> will probably find my post near end of September. The short solution:
>=20
> Use "no_subtree_check" in /etc/exports like this:
>=20
> /home \
>   tony.local.net(rw,sync,no_root_squash,no_subtree_check)
>=20
> I think I have found a bug in the nfs server code that always
> returns a failure on subtree checks. I described my findings in
> a post to this list, but nobody answered.
----------------------------------



:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--0cPfB1ccX8kkdppm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/iAiH8+1vMONE2jsRApsbAKCQ4tnaCI3e0794+rDry/x2MmmCewCghKY2
7EXAbxZ/ag2BAiOS/zYhkrM=
=Vr9U
-----END PGP SIGNATURE-----

--0cPfB1ccX8kkdppm--
