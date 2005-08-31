Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbVHaS3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbVHaS3x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 14:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVHaS3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 14:29:53 -0400
Received: from [63.227.221.253] ([63.227.221.253]:23726 "EHLO home.keithp.com")
	by vger.kernel.org with ESMTP id S932075AbVHaS3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 14:29:52 -0400
Subject: Re: State of Linux graphics
From: Keith Packard <keithp@keithp.com>
To: Discuss issues related to the xorg tree 
	<xorg@lists.freedesktop.org>
Cc: lkml <linux-kernel@vger.kernel.org>, keithp@keithp.com
In-Reply-To: <20050831063355.GE27940@tuolumne.arden.org>
References: <9e47339105083009037c24f6de@mail.gmail.com>
	 <1125422813.20488.43.camel@localhost>
	 <20050831063355.GE27940@tuolumne.arden.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zNnLPhOHFcuLdGIX8t0Z"
Date: Wed, 31 Aug 2005 11:29:30 -0700
Message-Id: <1125512970.4798.180.camel@evo.keithp.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zNnLPhOHFcuLdGIX8t0Z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-08-30 at 23:33 -0700, Allen Akin wrote:
> On Tue, Aug 30, 2005 at 01:26:53PM -0400, David Reveman wrote:
> | On Tue, 2005-08-30 at 12:03 -0400, Jon Smirl wrote:
> | > In general, the whole concept of programmable graphics hardware is
> | > not addressed in APIs like xlib and Cairo. This is a very important
> | > point. A major new GPU feature, programmability is simply not
> | > accessible from the current X APIs. OpenGL exposes this
> | > programmability via its shader language.
> |=20
> |                                                           ... I don't
> | see why this can't be exposed through the Render extension. ...
>=20
> What has always concerned me about this approach is that when you add
> enough functionality to Render or some new X extensions to fully exploit
> previous (much less current and in-development!) generations of GPUs,
> you've essentially duplicated OpenGL 2.0.=20

I don't currently see any strong application motivation to provide this
kind of functionality in a general purpose 2D API, and so it wouldn't
make a lot of sense to push this into the 2D-centric X protocols either.

When that changes, we'll want to explore how best to provide that
functionality. One possibility is to transition applications to a pure
GL drawing model, perhaps using glitz as a shim between the 2D and 3D
worlds. That isn't currently practical as our GL implementations are
missing several key features (FBOs, accelerated indirect rendering,
per-component alpha compositing), but those things are all expected to
be fixed at some point.

The real goal is to provide a good programming environment for 2D
applications, not to push some particular low-level graphics library.

-keith


--=-zNnLPhOHFcuLdGIX8t0Z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDFfcKQp8BWwlsTdMRAgerAJ91ENXuAFRg0A5nY45gI+8qfc4gfwCgiGmD
byDB6KE8I8K0+c2/1onyUWw=
=c2Q1
-----END PGP SIGNATURE-----

--=-zNnLPhOHFcuLdGIX8t0Z--
