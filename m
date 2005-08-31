Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbVHaGPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbVHaGPe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 02:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbVHaGPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 02:15:34 -0400
Received: from 69-30-77-85.dq1sn.easystreet.com ([69.30.77.85]:7911 "EHLO
	leguin.anholt.net") by vger.kernel.org with ESMTP id S932381AbVHaGPd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 02:15:33 -0400
Subject: Re: State of Linux graphics
From: Eric Anholt <eta@lclark.edu>
To: Discuss issues related to the xorg tree 
	<xorg@lists.freedesktop.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Xserver development <xorg@freedesktop.org>
In-Reply-To: <9e47339105083009037c24f6de@mail.gmail.com>
References: <9e47339105083009037c24f6de@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jWrPxpR8OeEib61na8ut"
Date: Tue, 30 Aug 2005 23:15:20 -0700
Message-Id: <1125468920.84445.21.camel@leguin>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.8 FreeBSD GNOME Team Port 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jWrPxpR8OeEib61na8ut
Content-Type: text/plain; charset=iso-8859-13
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-08-30 at 12:03 -0400, Jon Smirl wrote:
> I've written an article that surveys the current State of Linux
> graphics and proposes a possible path forward. This is a long article
> containing a lot of detailed technical information as a guide to
> future developers. Skip over the detailed parts if they aren't
> relevant to your area of work.
>=20
> http://www.freedesktop.org/~jonsmirl/graphics.html
>=20
> Topics include the current X server, framebuffer, Xgl, graphics
> drivers, multiuser support, using the GPU, and a new server design.
> Hopefully it will help you fill in the pieces and build an overall
> picture of the graphics landscape.
>=20
> The article has been reviewed but if it still contains technical
> errors please let me know. Opinions on the content are also
> appreciated.

"EXA extends the XAA driver concept to use the 3D hardware to accelerate
the X Render extension."  No, EXA is a different acceleration
architecture making different basic design decisions related to memory
management and driver API.

"If the old hardware is missing the hardware needed to accelerate render
there is nothing EXA can do to help."  Better memory management allows
for better performance with composite due to improved placement of
pixmaps, which XAA doesn't do.  So EXA can help.

"So it ends up that the hardware EXA works on is the same hardware we
already had existing OpenGL drivers for."  No.  See, for example, the nv
or i128 driver ports, both completed in very short timeframes.

"The EXA driver programs the 3D hardware from the 2D XAA driver adding
yet another conflicting user to the long line of programs all trying to
use the video hardware at the same time."  No, EXA is not an addition to
XAA, it's a replacement.  It's not "yet another conflicting user" on
your machine (and I have yet to actually see this purported conflict in
my usage of either acceleration architecture).

"There is also a danger that EXA will keep expanding to expose more of
the chip=FFs 3D capabilities."  If people put effort into this because
they see value in it, without breaking other people's code, why is this
a "danger?"

--=20
Eric Anholt                                     eta@lclark.edu
http://people.freebsd.org/~anholt/              anholt@FreeBSD.org

--=-jWrPxpR8OeEib61na8ut
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (FreeBSD)

iD8DBQBDFUr4HUdvYGzw6vcRAl0SAKCVOCHuVweh5CJoz8UzmkTqNxrEuwCfU/t0
BJVf4HCTUJGn/g4JtsQO0Ds=
=tWVr
-----END PGP SIGNATURE-----

--=-jWrPxpR8OeEib61na8ut--
