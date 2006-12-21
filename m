Return-Path: <linux-kernel-owner+w=401wt.eu-S1161138AbWLUCFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161138AbWLUCFx (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 21:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161140AbWLUCFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 21:05:52 -0500
Received: from smtp.rutgers.edu ([128.6.72.243]:12977 "EHLO
	annwn14.rutgers.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161138AbWLUCFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 21:05:51 -0500
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 21:05:51 EST
From: Michael Wu <flamingice@sourmilk.net>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Network drivers that don't suspend on interface down
Date: Wed, 20 Dec 2006 21:05:27 -0500
User-Agent: KMail/1.9.1
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
References: <20061220042648.GA19814@srcf.ucam.org> <20061220144906.7863bcd3@dxpl.pdx.osdl.net> <20061221011209.GA32625@srcf.ucam.org>
In-Reply-To: <20061221011209.GA32625@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4356205.82yB7HVHTv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200612202105.31093.flamingice@sourmilk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4356205.82yB7HVHTv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 20 December 2006 20:12, Matthew Garrett wrote:
> Veering off at something of a tangent - how much of this should be true
> for wireless devices? Softmac seems to be unhappy about setting the
> essid unless the card is up, which breaks various assumptions...
>
Softmac isn't the only wireless code that likes to be configured after goin=
g=20
up first. Configuring after the card goes up has generally been more=20
reliable, though that should not be necessary and is a bug IMHO.=20

> Beyond that, I think your descriptions of up and down states make sense
> for userspace. As Arjan suggests, there's then the intermediate state of
> "disable as much as possible while still providing scanning and link
> detection".
>
In order to scan, we need to have the radio on and we need to be able to se=
nd=20
and receive. What are you gonna turn off?

=2DMichael Wu

--nextPart4356205.82yB7HVHTv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFievrT3Oqt9AH4aERAkq6AJ9XIautZ/Kw9l/wGKN0aoVyh0xVoQCeM7OL
t8i3j+Z2tEYPAMH9LjD/5Io=
=BpWz
-----END PGP SIGNATURE-----

--nextPart4356205.82yB7HVHTv--
