Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265055AbTFLXUi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 19:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbTFLXUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 19:20:37 -0400
Received: from ce.fis.unam.mx ([132.248.33.1]:58014 "EHLO ce.fis.unam.mx")
	by vger.kernel.org with ESMTP id S265055AbTFLXUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 19:20:05 -0400
Subject: Re: 2.5.70: Lilo needs patching?
From: Max Valdez <maxvalde@fis.unam.mx>
To: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030612154333.608bca2c.akpm@digeo.com>
References: <200306122329.47365.Unai.Garro@ee.ed.ac.uk>
	 <20030612154333.608bca2c.akpm@digeo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-mp7EQEAyRqKicmgVmgPf"
Organization: 
Message-Id: <1055442915.2690.9.camel@garaged.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 12 Jun 2003 18:35:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mp7EQEAyRqKicmgVmgPf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I wish I knew that before ruining my boot sector

But at the end I got to give gentoo a try, so, now i need to go back and
compile 2.5 and try it with that trick

BTW, only woosies have a boot disk, if anybody is willing to make the
comment :-P

Thanks anyway for that advice=20
On Thu, 2003-06-12 at 22:43, Andrew Morton wrote:
> Unai Garro Arrazola <Unai.Garro@ee.ed.ac.uk> wrote:
> >
> > Since version 2.5.69 (now with 2.5.70-mm6), I'm having trouble using li=
lo.=20
> > Every time I try to change the lilo boot, the boot menu is either not=20
> > changed, or it's corrupted. It looks like if Lilo doesn't manage to=20
> > completely write the boot sector.
> >=20
> > I've been looking around, but I haven't found any information about thi=
s. Has=20
> > anything changed in the latest versions? Are there any patches that I n=
eed to=20
> > apply to lilo to make it work now?=20
> >=20
>=20
> It's a bug.  Seems that the ramdisk driver has somehow managed to
> compromise the livelock avoidance logic in the sync() system call.
>=20
> For now you can
>=20
> a) stop using the ramdisk driver (don't mount it) or
>=20
> b) manually run `blockdev --flushbufs /dev/hdXX' against the boot
>    partition before rebooting.
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
uname -a: Linux garaged.fis.unam.mx 2.4.21-pre4-ac4 #5 SMP Thu Feb 13 10:26=
:24 CST 2003 i686 unknown unknown GNU/Linux
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GS/ d-s:a-28C++ILHA+++P+L++>+++E---W++N*o--K-w++++O-M--V--PS+PEY--PGP++t5XR=
tv++b++DI--D-G++e++h-r+y**
------END GEEK CODE BLOCK------
gpg-key: http://garaged.homeip.net/gpg-key.txt

--=-mp7EQEAyRqKicmgVmgPf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+6MfjsrSE6THXcZwRAibCAKCKgHcOhWSCNKzRu+rQl+wqGwcb3gCgiUQh
rgWjqQtNxPlh4YctGxqMTuE=
=SG60
-----END PGP SIGNATURE-----

--=-mp7EQEAyRqKicmgVmgPf--

