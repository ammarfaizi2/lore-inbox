Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUGLSzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUGLSzA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 14:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUGLSzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 14:55:00 -0400
Received: from wblv-244-142.telkomadsl.co.za ([165.165.244.142]:22725 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S261610AbUGLSyy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 14:54:54 -0400
Subject: Re: Linux 2.6.8-rc1
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <20040712092600.GB5979@merlin.emma.line.org>
References: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org>
	 <20040712092600.GB5979@merlin.emma.line.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TTvhwNKQDgpdyLNC5vC6"
Message-Id: <1089658495.9526.12.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 12 Jul 2004 20:54:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TTvhwNKQDgpdyLNC5vC6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-07-12 at 11:26, Matthias Andree wrote:
> On Sun, 11 Jul 2004, Linus Torvalds wrote:
>=20
> > Ok, there's been a long time between "public" releases, although the
> > automated BK snapshots have obviously been keeping people up-to-date.=20
> > Sorry about that, I blame mainly moving boxes and stuff around...
>=20
> ...
>=20
> > Alexander Viro:
>     ...
> >   o sparse: rt_sigsuspend/sigaltstack sanitized
>=20
> I consider this harmful right now, full log:
>=20
> ChangeSet@1.1743, 2004-06-18 13:35:31-07:00, viro@parcelfarce.linux.thepl=
anet.co.uk
>   [PATCH] sparse: rt_sigsuspend/sigaltstack sanitized
>  =20
>   rt_sigsuspend() and sigaltstack() prototype changed; instead of
>   playing games with casts of argument address to struct pt_regs * and
>   digging through it, we declare them as
>  =20
>         int <fn>(struct pt_regs regs)
>  =20
>   instead.
>=20
> This ChangeSet causes Java to get killed right away, to see this, just
> type "Java". Excluding this ChangeSet (ID
> viro@parcelfarce.linux.theplanet.co.uk[torvalds]|ChangeSet|20040618203531=
|62233)
> fixes the problem for me.
>=20

I might be missing something here, but it works fine over here
with 2.6.7-bk21 which seems to include the cset:

---
 $ uname -r
2.6.7-bk21
 $ java
Usage: java [-options] class [args...]
           (to execute a class)
   or  java -jar [-options] jarfile [args...]
           (to execute a jar file)

where options include:
    -client       to select the "client" VM
    -server       to select the "server" VM
    -hotspot      is a synonym for the "client" VM  [deprecated]
                  The default VM is client.

    -cp -classpath <directories and zip/jar files separated by :>
                  set search path for application classes and resources
    -D<name>=3D<value>
                  set a system property
    -verbose[:class|gc|jni]
                  enable verbose output
    -version      print product version and exit
    -showversion  print product version and continue
    -? -help      print this help message
    -X            print help on non-standard options
    -ea[:<packagename>...|:<classname>]
    -enableassertions[:<packagename>...|:<classname>]
                  enable assertions
    -da[:<packagename>...|:<classname>]
    -disableassertions[:<packagename>...|:<classname>]
                  disable assertions
    -esa | -enablesystemassertions
                  enable system assertions
    -dsa | -disablesystemassertions
                  disable system assertions
 $ java-config -f
blackdown-jdk-1.4.1
 $ gcc --version
gcc (GCC) 3.3.4 20040623 (Gentoo Linux 3.3.4-r1, ssp-3.3.2-2, pie-8.7.6)
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 $
---

Compiler issue like sombody suggested?


--=20
Martin Schlemmer

--=-TTvhwNKQDgpdyLNC5vC6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA8t5/qburzKaJYLYRAlxfAKCMzRipV4zEz5ns/HMBIbO1+LddwwCfdEh8
97j5yBMILlXUFG1i3VcwpbM=
=cXyF
-----END PGP SIGNATURE-----

--=-TTvhwNKQDgpdyLNC5vC6--

