Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbTEQFLu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 01:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbTEQFLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 01:11:50 -0400
Received: from dhcp160176008.columbus.rr.com ([24.160.176.8]:52741 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S261233AbTEQFLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 01:11:48 -0400
From: "Joseph Fannin" <jhf@rivenstone.net>
Date: Sat, 17 May 2003 01:16:21 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, pizza@shaftnet.org
Subject: Re: 2.6 must-fix, v4
Message-ID: <20030517051621.GA10348@rivenstone.net>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org, pizza@shaftnet.org
References: <20030516161717.1e629364.akpm@digeo.com> <20030516161753.08470617.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <20030516161753.08470617.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2003 at 04:17:53PM -0700, Andrew Morton wrote:

> - synaptic touchpad support
>=20
>   Apparently there's a userspace `tpconfig'

   For 2.4, yes, but the new input layer doesn't allow the raw
access to the device needed for tpconfig to frob the touchpads'
configuration -- this is the reason for Bugzilla #18.  Vojitech
Pavlik said writing support for raw access from userspace wouldn't be
much less work than writing the kernel support.

   Solomon Peachy is working on such a driver -- he posted a
preliminary patch to lkml about 3 weeks ago (I've CC'ed him, I hope he
doesn't mind).  He told me that he's completed a decent amount of work
on an absolute mode driver that would set the stage for support for
all the touchpad's features.

    The patch Solomon posted is finally enough for me to use 2.5 on my
laptop, but it doesn't restore all the functionality available via
tpconfig (and friends), so that's a regression that could probably be
called a 'must-fix'.  If he could make an absolute mode driver work it
would have more features than tpconfig, and also not break the input
layer's abstraction of pointing devices, IMHO.=20

    Without any patch, 2.5 is a frustratingly unusable experience for
me, and though I might have been the first vocal laptop user, I'm sure
I won't be the last.


--=20
Joseph Fannin
jhf@rivenstone.net

"Linus, please apply.  Breaks everything.  But is cool." -- Rusty Russell.

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+xcWkWv4KsgKfSVgRAnBbAJ93n377OY9IZGAGyiKzplELZiRHWACcDSIj
DPzyM/ZdwPl+wbCJuNjdd/s=
=LlVe
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
