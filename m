Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265066AbSL0SJL>; Fri, 27 Dec 2002 13:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265093AbSL0SJL>; Fri, 27 Dec 2002 13:09:11 -0500
Received: from iucha.net ([209.98.146.184]:48172 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id <S265066AbSL0SJK>;
	Fri, 27 Dec 2002 13:09:10 -0500
Date: Fri, 27 Dec 2002 12:17:27 -0600
To: David Ford <david+cert@blue-labs.org>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: NFS problems with 2.5.53 on server
Message-ID: <20021227181727.GA14400@beaver>
References: <20021227162426.GA8070@iucha.net> <3E0C84FC.1020100@blue-labs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <3E0C84FC.1020100@blue-labs.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook: Where do you want [your files] to go today?
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 27, 2002 at 11:51:08AM -0500, David Ford wrote:
> Actually I have a bit more information.  Using both 2.5.5x (on NFS=20
> server) and 2.4.19/20, I get in dmesg, "kernel: RPC: garbage, exit EIO"=
=20
> and df reports zeroes across the board for NFS volumes.
>=20
> Nothing fixes it, the NFS server has to be rebooted.  During one of=20
> these moments, I also noticed the NFS server had a non-fatal OOPS w/=20
> rpc.kmountd.  Unfortunately I didn't save the OOPS.

This must be another problem, because I do not see the same problems as
you are seeing. There are no "RPC: garbage" messages and=20
   florin@bear:~$ df | grep archives
   beaver:/var/cache/apt/archives 995104    257560    737544  26% /var/auto=
fs/iucha/archives
shows the proper values.

> >I have:
> >   bear:/var/cache/apt/archives# mount | grep archives
> >   beaver:/var/cache/apt/archives on /var/autofs/iucha/archives type nfs=
 (rw,rsize=3D8192,wsize=3D8192,addr=3D10.10.0.10)
> >Then:
> >   bear:/var/cache/apt/archives# ls vim*
> >   ls: vim*: No such file or directory
> >   bear:/var/cache/apt/archives# find . -name vim\*
> >   bear:/var/cache/apt/archives# md5sum vim-gtk_1%3a6.1-266+1_i386.deb
> >   11a6d8dbfb51688d7ac275562540c327  vim-gtk_1%3a6.1-266+1_i386.deb
> >   bear:/var/cache/apt/archives#=20
> >
> >Note that /var/cache/apt/archives is a symbolic link to /var/autofs/iuch=
a/archives.
> >
> >So "ls", "find" cannot find the name for the file, but if I know the
> >file I can open it just fine.
> >
> >On the client:
> >   bear:/var/cache/apt/archives# ls | wc -l
> >   91
> >On the server:
> >   florin@beaver:/var/cache/apt/archives$ ls | wc -l
> >   441
> >
> >Server has 2.5.53 with no other patches. For clients I have used both 2.=
5.53
> >and 2.4.19 (Debian package).

Cheers,
florin
--=20

"NT is to UNIX what a dougnut is to a particle accelerator."

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+DJk3NLPgdTuQ3+QRAt90AJ9f2kV3Uc6P5G6zsfGYN+rJFitJEgCeI8Xh
M3st8lC6EjCCZk7WezwaiEs=
=S/0v
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
