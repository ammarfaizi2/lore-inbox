Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267280AbTBDPiJ>; Tue, 4 Feb 2003 10:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267281AbTBDPiJ>; Tue, 4 Feb 2003 10:38:09 -0500
Received: from B5b4a.pppool.de ([213.7.91.74]:26074 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S267280AbTBDPiE>; Tue, 4 Feb 2003 10:38:04 -0500
Subject: Re: CPU throttling??
From: Daniel Egger <degger@fhm.edu>
To: Valdis.Kletnieks@vt.edu
Cc: Matt Reppert <arashi@arashi.yi.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200302031924.h13JO9a0026095@turing-police.cc.vt.edu>
References: <200302031713.h13HD2K8000181@darkstar.example.net>
	 <200302031857.h13IvHa0025735@turing-police.cc.vt.edu>
	 <20030203131456.34c04df8.arashi@arashi.yi.org>
	 <200302031924.h13JO9a0026095@turing-police.cc.vt.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-y1GlG7ZumchtiuG+wM5N"
Organization: 
Message-Id: <1044369243.24397.12.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 04 Feb 2003 15:34:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-y1GlG7ZumchtiuG+wM5N
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mon, 2003-02-03 um 20.24 schrieb Valdis.Kletnieks@vt.edu:

> I knew that.  The question I asked was whether halted at 700Mhz takes mor=
e
> power than halted at 400Mhz...=20

PowerPC CPUs will shut down unneeded units. There's no such things as a
"hlt" instruction. The natural way to slow down the CPU causing more
sparetime to shut down single units is to throttle the dispatching of
instructions for which there's are flags in the control register set.

I've no idea where the frequency scaling should happen but it either
needs some hardware clock control or it's the mentioned dispatch
throttling. In case of the former there'd be some powersave effects
because the power drawn by a CPU is direct proportional to the
frequency. In the latter case the difference between an automatically=20
sleeping 700Mhz and a throttled 700Mhz cpu at "400Mhz" should be pretty
small, in case the cpu is mostly idle.

--=20
Servus,
       Daniel

--=-y1GlG7ZumchtiuG+wM5N
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+P89bchlzsq9KoIYRAoV3AKCHZwjTSmFgmV2uuu4tECBV4kjsYwCfVen+
FKmdhn8kMK+vuYCf10tXPzM=
=WsJN
-----END PGP SIGNATURE-----

--=-y1GlG7ZumchtiuG+wM5N--

