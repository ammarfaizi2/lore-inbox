Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267760AbUHJVtC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267760AbUHJVtC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 17:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267755AbUHJVtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 17:49:01 -0400
Received: from ctb-mesg5.saix.net ([196.25.240.77]:34754 "EHLO
	ctb-mesg5.saix.net") by vger.kernel.org with ESMTP id S267763AbUHJVs2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 17:48:28 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: dwmw2@infradead.org, James.Bottomley@steeleye.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, axboe@suse.de, eric@lammerts.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <200408101303.i7AD36bD014078@burner.fokus.fraunhofer.de>
References: <200408101303.i7AD36bD014078@burner.fokus.fraunhofer.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-P+Jp5F8pLGWPGB5OLJRQ"
Message-Id: <1092171729.8976.33.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 23:02:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-P+Jp5F8pLGWPGB5OLJRQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-08-10 at 15:03, Joerg Schilling wrote:
> >From: David Woodhouse <dwmw2@infradead.org>
>=20
> >On Tue, 2004-08-10 at 14:47 +0200, Joerg Schilling wrote:
> >> Cdrecord does not read /etc/cdrecord.conf
>=20
> >And the world is flat.
>=20
> >shinybook /home/dwmw2 $ strace -e open cdrecord -inq 2>&1 | grep /etc/cd=
record.conf
> >open("/etc/cdrecord.conf", O_RDONLY)    =3D 3
> >open("/etc/cdrecord.conf", O_RDONLY)    =3D 3
> >open("/etc/cdrecord.conf", O_RDONLY)    =3D 3
> >open("/etc/cdrecord.conf", O_RDONLY)    =3D 3
>=20
> It seems that you like to constantly discredit yourself :-(
>=20
> What you use if DEFINITELY NOT cdrecord.
>=20

While I would rather have said something like:

  What you use is DEFINITELY a PATCHED cdrecord

it is not the original:

---
# strace -e open cdrecord -inq 2>&1 | grep '/etc/.*cdrecord'
open("/etc/default/cdrecord", O_RDONLY) =3D -1 ENOENT (No such file or dire=
ctory)
open("/etc/default/cdrecord", O_RDONLY) =3D -1 ENOENT (No such file or dire=
ctory)
open("/etc/default/cdrecord", O_RDONLY) =3D -1 ENOENT (No such file or dire=
ctory)
---

stupid question: why this name and placement of the config file?
I would think that /etc/cdrecord.conf or /etc/cdrecord/defaults might
have made more sence, but this is out of a mostly linux pov.

Also, out of a user point of view:

1)  What is the big issue with supporting -dev=3D/dev/xxx ?  As I did
    point out above, I have limited experience with solaris and fbsd,
    but don't they all support and use /dev/ to access devices ?  It
    really is not a new way to access devices in linux as you tried
    to point out earlier - and it should be possible to implement it
    on all *nix OS's ?  Sure, maybe the exact kernel interface might
    change, but your device node should always (mostly?) point you
    in the correct direction if you know the correct one to use?
    I and I am sure many (most?) other users that have ide/usb devices
    do not want to worry about scsi topology, etc - that and scsi
    emulation adds extra overhead that we with older machines do not
    want.

    Also, it would be less confusing - on 2.6 currently -scanbus do
    not even detect any cdrw devices (sure, not a problem of yours).
    But I still remember the first time I tried to use cdrecord - and
    later with 2.5 and the -dev=3Dx,y,z syntax ... I just went with
    gtoaster and did not look back as cli writing is not an issue
    here.

2)  As pointed out, some error messages could use some tweaking.
    There was also some nice examples ...


I hope this was put nicely enough (although a tad clueless), and valid
a similar response.  If not, please refrain from answering.


Regards,

--=20
Martin Schlemmer

--=-P+Jp5F8pLGWPGB5OLJRQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBGTfRqburzKaJYLYRAmhCAJsF/a+0be62Pp/EVgcYh1XEu6QktwCgjFVV
h0fYctCMbMZcoXFols0BoY8=
=GZXG
-----END PGP SIGNATURE-----

--=-P+Jp5F8pLGWPGB5OLJRQ--

