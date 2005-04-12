Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262477AbVDLQqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbVDLQqV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 12:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbVDLQp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 12:45:26 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:8072 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S262489AbVDLQnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 12:43:07 -0400
Date: Tue, 12 Apr 2005 18:42:27 +0200
From: Jan Hudec <bulb@ucw.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, dan@debian.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Message-ID: <20050412164227.GA26907@vagabond>
References: <E1DL1Gj-000091-00@dorka.pomaz.szeredi.hu> <20050411181717.GA1129@nevyn.them.org> <E1DL4J4-0000Py-00@dorka.pomaz.szeredi.hu> <20050411192223.GA3707@nevyn.them.org> <E1DL51J-0000To-00@dorka.pomaz.szeredi.hu> <20050411221324.GA10541@nevyn.them.org> <E1DLEsQ-00015Z-00@dorka.pomaz.szeredi.hu> <20050412143237.GB10995@mail.shareable.org> <E1DLMrh-0001lm-00@dorka.pomaz.szeredi.hu> <20050412161303.GI10995@mail.shareable.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20050412161303.GI10995@mail.shareable.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 12, 2005 at 17:13:03 +0100, Jamie Lokier wrote:
> Miklos Szeredi wrote:
> > > Note that NFS checks the permissions on _both_ the client and server,
> > > for a reason.
> >=20
> > Does it?  If I read the code correctly the client checks credentials
> > supplied by the server (or cached).  But the server does the actual
> > checking of permissions.
> >=20
> > Am I missing something?
>=20
> Yes, for NFSv2, this test in nfs_permssion():
>=20
> 	if (!NFS_PROTO(inode)->access)
> 		goto out;
>=20
> And for either version of NFS, if the uid and gid are non-zero, and
> the permission bits indicate that an access is permitted, then the
> client does not consult the server for permission.

=2E.. but that clearly says that it checks the permissions on *either*
cleint *or* server. Not all requests are passed to the server and there
the client only checks the permission bits, even if the credentials are
different than what was originally used to obtain the information.

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCW/pzRel1vVwhjGURAgpWAJ4i0vhoErGhPG194Dezw07X09QVogCfXgt/
X3r9oWDUMYNsf7iqOW/Ro7E=
=wYSk
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
