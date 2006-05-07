Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWEGNpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWEGNpf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 09:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWEGNpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 09:45:35 -0400
Received: from master.altlinux.org ([62.118.250.235]:59151 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP id S932163AbWEGNpe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 09:45:34 -0400
Date: Sun, 7 May 2006 17:45:27 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Michael Buesch <mb@bu3sch.de>
Cc: akpm@osdl.org, Deepak Saxena <dsaxena@plexity.net>,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/6] New Generic HW RNG
Message-ID: <20060507134527.GA14704@procyon.home>
References: <20060507113513.418451000@pc1> <20060507170320.3ce0d3e0.vsu@altlinux.ru> <200605071516.09167.mb@bu3sch.de> <200605071527.33376.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <200605071527.33376.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 07, 2006 at 03:27:33PM +0200, Michael Buesch wrote:
> On Sunday 07 May 2006 15:16, you wrote:
> > On Sunday 07 May 2006 15:03, you wrote:
> > > This does not handle the case of partial read correctly - the code
> > > should be
> > >=20
> > > 			return ret ? : -ERESTARTSYS;
>=20
> Or, hm. Shouldn't we
> return ret ? : err;
>=20
> err is -EINTR

-ERESTARTSYS is the proper return code for this case - the signal
handling code will either convert it to EINTR for userspace, or
restart the system call after handling the signal, depending on the
state of the SA_RESTART flag set by sigaction().

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEXfn3W82GfkQfsqIRAjD+AJ439toerJ8Y6NW8QA1xIq3LuOhhmACfbAqo
pKIwjGSlAwXqu6P9JnEtdWg=
=2bRN
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
