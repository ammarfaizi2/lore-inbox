Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267053AbRG1UaQ>; Sat, 28 Jul 2001 16:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267074AbRG1UaG>; Sat, 28 Jul 2001 16:30:06 -0400
Received: from schiele.swm.uni-mannheim.de ([134.155.20.124]:37256 "EHLO
	schiele.swm.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S267053AbRG1U34>; Sat, 28 Jul 2001 16:29:56 -0400
Date: Sat, 28 Jul 2001 22:29:43 +0200
From: Robert Schiele <rschiele@uni-mannheim.de>
To: Philip Blundell <philb@gnu.org>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.4.8-pre1 build error in drivers/parport/parport_pc.c
Message-ID: <20010728222943.A24586@schiele.swm.uni-mannheim.de>
In-Reply-To: <01072619531103.06728@localhost.localdomain> <20010727101241.A15014@schiele.swm.uni-mannheim.de> <rschiele@uni-mannheim.de> <E15QX7a-0000gl-00@kings-cross.london.uk.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <E15QX7a-0000gl-00@kings-cross.london.uk.eu.org>; from philb@gnu.org on Sat, Jul 28, 2001 at 05:39:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 28, 2001 at 05:39:22PM +0100, Philip Blundell wrote:
> I think you did miss the vital point: this will probably break with=20
> CONFIG_PARPORT_OTHER.

No this cannot happen. These functions are only used from source files
that also include parport_pc.h. If this were not the case, it would
have been a bug anyway.

>=20
> Declaring them "extern inline" in parport_pc.h is exactly the right thing=
 to=20
> do.  What do you think is wrong with that?

The "extern" was only an escape for the case that the compiler cannot
inline the function. Due to the fact, that current gcc has "static
inline" it is better to use this, because with "static inline" we do
not need to keep a global symbol just for the case the compiler is not
capable to inline the function in some place.

Let's turn the tables: What do you think is wrong with "static
inline"? In my opinion it's a much cleaner solution than "extern
inline".

Robert

--=20
Robert Schiele			mailto:rschiele@uni-mannheim.de
Tel./Fax: +49-621-10059		http://webrum.uni-mannheim.de/math/rschiele/

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iQEVAwUBO2Mgt8QAnns5HcHpAQGJCAgApoPZJ+sVSS5pnGyy8Y7Pnbcwc0Jz0BmM
/lnJ2vz3IWR49l6CwetXz15XqxELs1mCoKPoiA10y6gO7Vou4KxizdqED+KG7JJp
qqOfwGxJjTnYv7rcJ9AmqttfFK8u6VFWpcEBpu2EhXiV/BOLhiYWSN/wOhuUf+vd
yRidbhbSCVKK1aPbbinYKbGwT60B2zZB/yCYygEqbKyFSKqhAouFfQbnwA6RG1kd
mnh7zTMzW9KcppyvdK9LjmyRyXquXnGz9ffnIpPKCXQY7SgPqd/OrV5zJPVBtDJG
2O7iJaJlpHR7y04GbSJ399P55kvUEDud5slwkyafPFbbUYPtOo2AhA==
=OlPk
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
