Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVDEWck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVDEWck (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 18:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVDEWck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 18:32:40 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:64822 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261860AbVDEWcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 18:32:35 -0400
Date: Tue, 05 Apr 2005 16:32:37 -0600
From: Jeremy Nickurak <atrus@lkml.spam.rifetech.com>
Subject: Re: Logitech MX1000 Horizontal Scrolling
In-reply-to: <87br8ttgpw.fsf@quasar.esben-stien.name>
To: Esben Stien <b0ef@esben-stien.name>
Cc: linux-kernel@vger.kernel.org
Message-id: <1112740357.26671.8.camel@localhost>
MIME-version: 1.0
X-Mailer: Evolution 2.2.1.1
Content-type: multipart/signed; boundary="=-n2ht0/e2RhbiAWJMdDqo";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <873bxfoq7g.fsf@quasar.esben-stien.name>
 <87zmylaenr.fsf@quasar.esben-stien.name> <20050204195410.GA5279@ucw.cz>
 <873bvyfsvs.fsf@quasar.esben-stien.name>
 <87zmxil0g8.fsf@quasar.esben-stien.name> <1110056942.16541.4.camel@localhost>
 <87sm37vfre.fsf@quasar.esben-stien.name>
 <87wtsjtii6.fsf@quasar.esben-stien.name> <20050308205210.GA3986@ucw.cz>
 <1112083646.12986.3.camel@localhost> <87psxcsq06.fsf@quasar.esben-stien.name>
 <87u0mn3l4e.fsf@blackdown.de> <87acodvrw5.fsf@quasar.esben-stien.name>
 <87br8ttgpw.fsf@quasar.esben-stien.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-n2ht0/e2RhbiAWJMdDqo
Content-Type: multipart/mixed; boundary="=-iAFElCS3YKhUQHF5XuoD"


--=-iAFElCS3YKhUQHF5XuoD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On mar, 2005-04-05 at 16:56 +0200, Esben Stien wrote:
> Esben Stien <b0ef@esben-stien.name> writes:
>=20
> > can't find a single problem with the device.
>=20
> I should mention a couple of things after some testing: There are some
> inconsistencies with regard to cruise control.
>=20
> When I press TOP CLICK BACKWARD/TOP CLICK FORWARD to cruise control
> down/up, it waits about 100ms before it starts cruising. This means
> that pressing a single click does not move me anywhere. I have to hold
> the key down and wait until it starts cruising.

This is probabbly because you're using the referenced xbindkeys trick to
delete the button11/12 event. Unfortunately, binding 11/12 while cruise
control is enabled also obscures the first scroll event.

The horrible-ugly-very-nasty-workaround is to bind that event to a
command that re-simulates the up/down click. I've attached a piece of C
code that'll do that. ('./click 4' will simulate button 4 going up and
down.)


> >=20
> > # "cruise control" disabled:
> > "~/click/click 4"
> >   m:0x10 + b:11
> > "~/click/click 5"
> >   m:0x10 + b:12

I'm sort of guessing at the xbindkeys setting for this. Myself, i've
performed this bind event in my openbox configuration.

This still doesn't catch the button 11/12 mouse-up event, although that
doesn't seem to bother many applications


--=-iAFElCS3YKhUQHF5XuoD
Content-Disposition: attachment; filename=click.tgz
Content-Type: application/x-compressed-tar; name=click.tgz
Content-Transfer-Encoding: base64

H4sIANMRU0IAA+2VX2/TQAzA89p8CmsIKa2aJpekiVToHhjsqYCEiqgEe8jSaxctvVTJZTCxfnd8
l2SjUK0IqdsQ/j3cH9u17+zUl2RpcukYB8VFouFQzSwaMr1nQaDnBoO5nheEzA2jyHAZLkMDhoc9
Vk1VyrgAMGJZVOW9dry4T99epJ3/ERJdfz0OkgPFUPkI63rvqj/zh76qPwuZ73mej/X3Izcw4EGS
+J/X3+nBMknAXoL9Kc4ysHPQHwM0nwTYE3CqsnBmjH0InSw9d8DOcKNGWUroOab5LBVJVs05vESF
M0OjwcXxL1L+TXJRprkondmUl3LbopTzNP9N1DgyUyFhFafCArWKi2XSh+QCy9bD9dXnM+jCdxOQ
12m5zuJr6M3X1zCG2fs1F43MgncfJxPovjA7ysl5JUW1ajb6rriuhWOGSy0au8pgAZYKCcfgqTid
xgz9xzJPLX0EdqYc17/aUnhasQGelRx+csX2uNrUga3G4xjcLtzcwN2edWsP6wJvgJZHp/FlKpbq
YjIX8HwO8/yr+CKO+s1dlVeVI519NOavtOWbKy6kBZiw1rAP06LifTipigJ103TF4Y+O5O09UrX+
uwOdxpi+nSfSZZ+dZHnJbwutio9qpSm4rAoBWMeN+dh/tSdJ3f/fYvYXacYPE2NP/3e9IFL9H4U4
+CH2/4BR/38YsOeP6v5nmknGYzEyO8UK7EXzAOR3SpxGrdTs6Fdj15OR73syGl+DvPWWbHlLbh22
wdHgsdNEEARBEARBEARBEARBEARBEARBEATx5PkBNmVk/wAoAAA=


--=-iAFElCS3YKhUQHF5XuoD--

--=-n2ht0/e2RhbiAWJMdDqo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCUxIFtjFmtbiy5uYRAlMNAKCJhmCOYlKdkMFS8CiCVJv8bMWsQQCfWELX
8ca1xPLXt+PvrF/bGmDqQiA=
=/WX4
-----END PGP SIGNATURE-----

--=-n2ht0/e2RhbiAWJMdDqo--
