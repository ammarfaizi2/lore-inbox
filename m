Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317269AbSHTS5Q>; Tue, 20 Aug 2002 14:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317102AbSHTS5Q>; Tue, 20 Aug 2002 14:57:16 -0400
Received: from B5187.pppool.de ([213.7.81.135]:58335 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S317269AbSHTS5O>; Tue, 20 Aug 2002 14:57:14 -0400
Subject: Re: Pages swapped out even when free memory available...
From: Daniel Egger <degger@fhm.edu>
To: Jan Hudec <bulb@cimice.maxinet.cz>
Cc: Jean-Eric Cuendet <Jean-Eric.Cuendet@linkvest.com>,
       linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
In-Reply-To: <20020820102816.GC6981@vagabond>
References: <61FEFD6522F0F142B36E3F6CE511A4F01D37CC@hermes.linkvest.com> 
	<20020820102816.GC6981@vagabond>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-cCIanc71ivzeDFOT9CdC"
X-Mailer: Ximian Evolution 1.0.7 
Date: 20 Aug 2002 16:11:01 +0200
Message-Id: <1029852661.547.4.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cCIanc71ivzeDFOT9CdC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Die, 2002-08-20 um 12.28 schrieb Jan Hudec:

> Don't do it. In user-land, you simply don't have the info kernel does.
> Gimp tries to do things like this and results are truly horrible.
> It forces machine in deep swap if you set the cache large, while with
> small cache the actual size does not matter much as kernel takes care of
> the real caching.
=20
> You should rather open a file you want to swap in, mmap it and only keep
> minimum data in other memory. Only reason to do even this may be, that
> the data may get too large to fit in swap. For all other reasons you
> should just let kernel do it's work.

Interesting you mention it. A week ago I started a thread exactly for
that reason; I implemented GIMPs tilemanagement using mmap but
unfortunately the performance sucks even more than GIMPs "clever"=20
swapping. That having said it has at least one more severe disadvantage:
The maximum amount of mmapable memory is far less than the maximum
filesize with large file support.

--=20
Servus,
       Daniel

--=-cCIanc71ivzeDFOT9CdC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9Yk31chlzsq9KoIYRAvK1AJ0Qlef8IG9XD+X0/EceKK8v8/IqMwCfSyFX
mo4o7FvZN7sWfiv0swPC3B4=
=r2Ej
-----END PGP SIGNATURE-----

--=-cCIanc71ivzeDFOT9CdC--

