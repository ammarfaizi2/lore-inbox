Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265037AbSL0QQL>; Fri, 27 Dec 2002 11:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265132AbSL0QQK>; Fri, 27 Dec 2002 11:16:10 -0500
Received: from iucha.net ([209.98.146.184]:55595 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id <S265037AbSL0QQJ>;
	Fri, 27 Dec 2002 11:16:09 -0500
Date: Fri, 27 Dec 2002 10:24:26 -0600
From: Florin Iucha <florin@iucha.net>
To: linux-kernel@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: NFS problems with 2.5.53 on server
Message-ID: <20021227162426.GA8070@iucha.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Trond Myklebust <trond.myklebust@fys.uio.no>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook: Where do you want [your files] to go today?
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I have:
   bear:/var/cache/apt/archives# mount | grep archives
   beaver:/var/cache/apt/archives on /var/autofs/iucha/archives type nfs (r=
w,rsize=3D8192,wsize=3D8192,addr=3D10.10.0.10)
Then:
   bear:/var/cache/apt/archives# ls vim*
   ls: vim*: No such file or directory
   bear:/var/cache/apt/archives# find . -name vim\*
   bear:/var/cache/apt/archives# md5sum vim-gtk_1%3a6.1-266+1_i386.deb
   11a6d8dbfb51688d7ac275562540c327  vim-gtk_1%3a6.1-266+1_i386.deb
   bear:/var/cache/apt/archives#=20

Note that /var/cache/apt/archives is a symbolic link to /var/autofs/iucha/a=
rchives.

So "ls", "find" cannot find the name for the file, but if I know the
file I can open it just fine.

On the client:
   bear:/var/cache/apt/archives# ls | wc -l
   91
On the server:
   florin@beaver:/var/cache/apt/archives$ ls | wc -l
   441

Server has 2.5.53 with no other patches. For clients I have used both 2.5.53
and 2.4.19 (Debian package).

Cheers,
florin
--=20

"If it's not broken, let's fix it till it is."

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+DH66NLPgdTuQ3+QRApI5AJ0eHWFchVY6/YnYUv6TTrpr4eiQagCgkAwl
qumFH6epyw2b/ty/mix9yLg=
=Cc/W
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
