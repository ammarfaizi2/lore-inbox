Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbUAFNUe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 08:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUAFNUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 08:20:34 -0500
Received: from smtp2.actcom.co.il ([192.114.47.15]:58566 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S262052AbUAFNUc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 08:20:32 -0500
Date: Tue, 6 Jan 2004 15:19:59 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Libor Vanek <libor@conet.cz>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: 2.6.0-mm1 - kernel panic (VFS bug?)
Message-ID: <20040106131958.GB4268@actcom.co.il>
References: <1aQy3-2y1-7@gated-at.bofh.it> <m3znd139ur.fsf@averell.firstfloor.org> <3FFAAB91.6090207@conet.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
In-Reply-To: <3FFAAB91.6090207@conet.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2004 at 01:35:29PM +0100, Libor Vanek wrote:

> >PATH_MAX is 4096. The i386 stack is only 6k. You already overflowed it.
> >You're lucky if your machine only panics, much worse things can happen
> >with kernel stack overflows.

> OK - what's correct implementation? Do a "char * tmp_path" and
> kmalloc it?

Generally speaking, yes. That way you get reentrancy for free and
don't use up too much kernel stack. If speed is of the utmost
importance, there are other possible solutions.=20

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

"the nucleus of linux oscillates my world" - gccbot@#offtopic


--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/+rX+KRs727/VN8sRAi1jAKCUXpW7eHOlc7seEjgajeXI7aXhMACgobTO
7SmUVkVVwnWnKAMYmn4WYxk=
=JfMO
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
