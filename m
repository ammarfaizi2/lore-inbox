Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264359AbUAIVgy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 16:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbUAIVgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 16:36:54 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:18932 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S264359AbUAIVgv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 16:36:51 -0500
Date: Sat, 10 Jan 2004 10:26:34 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: PATCH 1/2: Make gotoxy & siblings use unsigned variables
In-reply-to: <20040109213327.A2699@pclin040.win.tue.nl>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: root@chaos.analogic.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1073683594.4582.36.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-ZzgcaVyfDb/WKgpFuE+h";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <1073672901.2069.15.camel@laptop-linux>
 <Pine.LNX.4.53.0401091415430.571@chaos>
 <1073677435.2069.23.camel@laptop-linux>
 <20040109213327.A2699@pclin040.win.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZzgcaVyfDb/WKgpFuE+h
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

Of course you're right about 2^31 columns, but the rest of the code used
unsigned ints as well, not because it expects 2^31 columns, but because
(if I understand the code right), the numbers can be part of escape
sequences... I'm looking at csi_m in vt.c.

Regards,

Nigel

On Sat, 2004-01-10 at 09:33, Andries Brouwer wrote:
> >> Shouldn't we be using "size_t" for unsigned int
>=20
> > You might be right. I was just being consistent with the other definiti=
ons.
>=20
> These are character positions on a screen.
> When did you last see a console in text mode with a line length
> of more than 2^31 ?
>=20
> If you go for a minimal patch then you should replace "char"
> in one or two places by "unsigned char" and that is all.
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-ZzgcaVyfDb/WKgpFuE+h
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA//xyKVfpQGcyBBWkRAmSdAJ4gQnEz73sXnA9I/+Ty4p9pa+f0VACfbKR2
Esv8K5wWgds6EpXvry5FWwU=
=YTJ7
-----END PGP SIGNATURE-----

--=-ZzgcaVyfDb/WKgpFuE+h--

