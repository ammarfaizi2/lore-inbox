Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265302AbSJRQkR>; Fri, 18 Oct 2002 12:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265306AbSJRQkR>; Fri, 18 Oct 2002 12:40:17 -0400
Received: from host217-36-81-41.in-addr.btopenworld.com ([217.36.81.41]:54148
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S265302AbSJRQkP>; Fri, 18 Oct 2002 12:40:15 -0400
Subject: Re: referencing other modules
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: dijital1 <dijital1@underboost.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0210162322070.12334-100000@area51.underboost.net>
References: <Pine.LNX.4.44.0210162322070.12334-100000@area51.underboost.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Pvul4En7smgr2lnT8vL/"
Organization: 
Message-Id: <1034959588.29675.0.camel@lemsip>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 18 Oct 2002 17:46:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Pvul4En7smgr2lnT8vL/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2002-10-17 at 04:25, dijital1 wrote:
> Does anyone have any ideas as to why this following 3 lines of code
> don't work? The kernel version is 2.5.43 and I have several other modules
> loaded before I load the module containing this code. From what I can
> discern in linux/kernel/module.c new modules are added to the head of the
> list to it seems that my code would work. Any help or suggestions would b=
e
> appreciated. Incidentally, this code is being called from the module
> initialisation function.
>=20
>     struct module *next_mod;
>     next_mod=3DTHIS_MODULE->next;
>     printk(KERN_DEBUG"%s\n", next_mod->name);

presumably next_mod=3D=3DNULL, items may be inserted backwards in to the
list (that is usual for singly linked lists).

--=20
// Gianni Tedesco (gianni at ecsc dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-Pvul4En7smgr2lnT8vL/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9sDrkkbV2aYZGvn0RAm4NAJ9vksY1yzRkRoyrRoemPPqp3Yw07wCfbn49
uVnyzhb40lxC0VYVWZrGSUA=
=vz85
-----END PGP SIGNATURE-----

--=-Pvul4En7smgr2lnT8vL/--

