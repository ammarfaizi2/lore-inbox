Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbUAMJtE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 04:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbUAMJtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 04:49:03 -0500
Received: from smtp2.actcom.co.il ([192.114.47.15]:1203 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S263793AbUAMJtA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 04:49:00 -0500
Date: Tue, 13 Jan 2004 11:48:53 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: "Sirotkin, Alexander" <demiurg@ti.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: skb fragmentation
Message-ID: <20040113094853.GY680@actcom.co.il>
References: <4003B134.7040707@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="su+CkryO4QJrkqP3"
Content-Disposition: inline
In-Reply-To: <4003B134.7040707@ti.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--su+CkryO4QJrkqP3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2004 at 10:49:56AM +0200, Sirotkin, Alexander wrote:

> I've seen a couple of drivers (for instance - e100) using fragmented skb=
=20
> on transmit path.
> I was wondering, how one can do the same on receive  ?

How? build a fragmented skb on the receive path and send it
upwards. Last I looked at the relevant code (2.4.something), however,
the tcp/ip stack called skb_linearize() on the skb on its way up, so
you wouldn't gain anything unless you teach it to deal with fragmented
skb's all the way up. That's just what I recall - this subject was
discussed several times in the past, look in the archives for details.

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

"the nucleus of linux oscillates my world" - gccbot@#offtopic


--su+CkryO4QJrkqP3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAA78FKRs727/VN8sRAvSCAJ9GwdgJocewPG5OwtKXdu/NAE2YqgCcCwwC
ANv0JzB4jiKHdx8JmqdIOtQ=
=Or/W
-----END PGP SIGNATURE-----

--su+CkryO4QJrkqP3--
