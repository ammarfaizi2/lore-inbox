Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264643AbSKNPOL>; Thu, 14 Nov 2002 10:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264844AbSKNPOL>; Thu, 14 Nov 2002 10:14:11 -0500
Received: from host217-36-81-41.in-addr.btopenworld.com ([217.36.81.41]:61069
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S264643AbSKNPOK>; Thu, 14 Nov 2002 10:14:10 -0500
Subject: Re: Path Name to kdev_t
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: chandrasekhar.nagaraj@patni.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000101c28be4$9ff1bf20$e9bba5cc@patni.com>
References: <000101c28be4$9ff1bf20$e9bba5cc@patni.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WA4IRUIfA2HfBvIS4fNw"
Organization: 
Message-Id: <1037287255.9317.30.camel@lemsip>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 14 Nov 2002 15:20:55 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WA4IRUIfA2HfBvIS4fNw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2002-11-14 at 13:49, chandrasekhar.nagaraj wrote:
> In one of the part of my driver module , I have a path name to a device f=
ile
> (for eg:- /dev/hda1) .Now if I want to obtain the associated major number
> and minor number i.e. device ID(kdev_t) of this file what would be the
> procedure?

You need to lookup the inode from the path using namei() or something
then it's just a field in the inode.

Check out fs/namei.c and related headers for more details.

--=20
// Gianni Tedesco (gianni at ecsc dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-WA4IRUIfA2HfBvIS4fNw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9079WkbV2aYZGvn0RAu7sAJ47ghzncjg7TPns0hWzUNQiIIor0QCfRFYj
+Er8K+hkkQwLysJ2IFpTgxU=
=1WrO
-----END PGP SIGNATURE-----

--=-WA4IRUIfA2HfBvIS4fNw--

