Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311262AbSCVJPD>; Fri, 22 Mar 2002 04:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311274AbSCVJOy>; Fri, 22 Mar 2002 04:14:54 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:5127 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S311262AbSCVJOr>; Fri, 22 Mar 2002 04:14:47 -0500
Date: Fri, 22 Mar 2002 01:14:14 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] ide-cd-typo.patch (Re: Linux 2.4.19-pre3-ac5)
In-Reply-To: <20020322095628.A28751@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.10.10203220109130.9319-200000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1430322656-1414004738-1016788454=:9319"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1430322656-1414004738-1016788454=:9319
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


Goto Line 790 in ide-cd.c and manually edit it.

But since you asked for a patch here is one.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On Fri, 22 Mar 2002, J=F6rn Engel wrote:

> Hi!
>=20
> > kernel BUG at ide-cd.c:790!
> > invalid operand: 0000
>=20
> The code appears to be too paranoid here. In case noone else submitted
> a patch yet, here is mine.
> Apply with patch -p0.
>=20
> J=F6rn
>=20
> --=20
> Measure. Don't tune for speed until you've measured, and even then
> don't unless one part of the code overwhelms the rest.
> -- Rob Pike
>=20
> --- drivers/ide/ide-cd.c=09Fri Mar 22 09:48:42 2002
> +++ drivers/ide/ide-cd.c.new=09Fri Mar 22 09:52:59 2002
> @@ -786,9 +786,6 @@
>  =09=09=09return startstop;
>  =09}
> =20
> -=09if (HWGROUP(drive)->handler =3D=3D NULL)=09/* paranoia check */
> -=09=09BUG();
> -
>  =09/* Arm the interrupt handler. */
>  =09ide_set_handler (drive, handler, timeout, cdrom_timer_expiry);
> =20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--1430322656-1414004738-1016788454=:9319
Content-Type: text/plain; charset=us-ascii; name="ide-cd-typo.patch"
Content-Transfer-Encoding: base64
Content-ID: <Pine.LNX.4.10.10203220114140.9319@master.linux-ide.org>
Content-Description: 
Content-Disposition: attachment; filename="ide-cd-typo.patch"

LS0tIGxpbnV4L2RyaXZlcnMvaWRlL2lkZS1jZC5jLm9yaWcJRnJpIE1hciAy
MiAwMToxMTo1MSAyMDAyDQorKysgbGludXgvZHJpdmVycy9pZGUvaWRlLWNk
LmMJRnJpIE1hciAyMiAwMToxMToxOCAyMDAyDQpAQCAtNzg2LDcgKzc4Niw3
IEBADQogCQkJcmV0dXJuIHN0YXJ0c3RvcDsNCiAJfQ0KIA0KLQlpZiAoSFdH
Uk9VUChkcml2ZSktPmhhbmRsZXIgPT0gTlVMTCkJLyogcGFyYW5vaWEgY2hl
Y2sgKi8NCisJaWYgKEhXR1JPVVAoZHJpdmUpLT5oYW5kbGVyICE9IE5VTEwp
CS8qIHBhcmFub2lhIGNoZWNrICovDQogCQlCVUcoKTsNCiANCiAJLyogQXJt
IHRoZSBpbnRlcnJ1cHQgaGFuZGxlci4gKi8NCg==
--1430322656-1414004738-1016788454=:9319--
