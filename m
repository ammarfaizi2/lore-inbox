Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751541AbVKBKSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbVKBKSi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 05:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbVKBKSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 05:18:38 -0500
Received: from smtp2.pp.htv.fi ([213.243.153.35]:21191 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1751541AbVKBKSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 05:18:37 -0500
Date: Wed, 2 Nov 2005 12:18:35 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Pavel Machek <pavel@suse.cz>
Cc: vojtech@suse.cz, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: best way to handle LEDs
Message-ID: <20051102101835.GA14639@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Pavel Machek <pavel@suse.cz>, vojtech@suse.cz, rpurdie@rpsys.net,
	lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
	Russell King <rmk@arm.linux.org.uk>
References: <20051101234459.GA443@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20051101234459.GA443@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 02, 2005 at 12:44:59AM +0100, Pavel Machek wrote:
> Handheld machines have limited number of software-controlled status
> LEDs. Collie, for example has two of them; one is labeled "charge" and
> second is labeled "mail".
>=20
> At least the "mail" led should be handled from userspace, and it would
> be nice if (at least) different speeds of blinking could be used --
> original Sharp ROM uses at least:
>=20
> yellow off: 	not charging
> yellow on:	charging
> yellow fast blink: charge error
>=20
> I think even slow blinking was used somewhere. I have some code from
> John Lenz (attached); it uses sysfs interface, exports led collor, and
> allows setting different frequencies.
>=20
> Is that acceptable, or should some other interface be used?
>=20
I would also be in favour of having a more generic interface for
something like this (as opposed to each architecture rolling their own).

For example, sh currently has a very simplistic framework in place where
LED manipulation is done via a heartbeat callback in the machvec for each
timer tick, so it would be nice to have things somewhat more flexible in
this regard (especially for boards with multi-coloured LEDs, and for
userspace input).

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDaJJ71K+teJFxZ9wRAhnCAJ9t4Z7+3fa8V3ndYIbFSO3fg3WeGgCfZSsh
xZYQ0X1G2PllXLp+ZnGJUzQ=
=VMoB
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
