Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbUDDSp1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 14:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbUDDSp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 14:45:27 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:16328 "EHLO
	smtp1.actcom.co.il") by vger.kernel.org with ESMTP id S262545AbUDDSpZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 14:45:25 -0400
Date: Sun, 4 Apr 2004 20:38:25 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: kernel stack challenge
Message-ID: <20040404183825.GA18536@mulix.org>
References: <m3ad1s0yq7.fsf@averell.firstfloor.org> <20040404182438.79937.qmail@web40504.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <20040404182438.79937.qmail@web40504.mail.yahoo.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 04, 2004 at 11:24:38AM -0700, Sergiy Lozovsky wrote:

> I wonder how it is possible to access task struct
> having current stack pointer. %esp points at the
> middle of the stack (when we are in the kernel) when
> interrupt occures.

Look at the curren()t and get_current() macros. Basically, the stack
is page aligned, so with the proper masking of %esp you can get to the
bottom of the stack.=20

See http://www.kernelnewbies.org/faq/, "how does get_current work?".=20

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/


--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAcFYhKRs727/VN8sRAvJoAJ4hMQ8G72sraCqMkKSpCWx6l9fz0wCdEOX5
DHLauBnleljYqhvHnb96+to=
=1ieU
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
