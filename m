Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266692AbUGQD7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266692AbUGQD7e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 23:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266695AbUGQD7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 23:59:34 -0400
Received: from mail022.syd.optusnet.com.au ([211.29.132.100]:46023 "EHLO
	mail022.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266692AbUGQD7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 23:59:30 -0400
Date: Sat, 17 Jul 2004 13:59:22 +1000
From: Andrew Lau <netsnipe@users.sourceforge.net>
To: Simon Kelley <simon@thekelleys.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Atmel at76c50x PCMCIA 2.6.6 kernel panic
Message-ID: <20040717035922.GA2415@espresso>
References: <20040511134101.GA19530@espresso> <40A0E1CB.20209@thekelleys.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <40A0E1CB.20209@thekelleys.org.uk>
X-PGP-Key-ID: 0x2E8B68BD
X-PGP-Fingerprint: 0B77 73D0 4F3B F286 63F1 9F4A 9B24 C07D 2E8B 68BD
X-PGP-Key: http://pgp.dtype.org:11371/pks/lookup?op=get&search=0x2E8B68BD
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear Simon,

Is this patch still necessary? It wasn't merged in with 2.6.7 and I
haven't noticed it in the 2.6.8-rc1 changelog either. I'd test it
myself, but I don't have access to a wireless access point at the
moment.

Cheers,
Andrew "Netsnipe" Lau

On Tue, May 11, 2004 at 03:23:07PM +0100, Simon Kelley wrote:
> Andrew Lau wrote:
> >Hi Simon and co.,
> >
> >My Atmel AT76C502AR_D 802.11b PCMCIA card was previously working fine
> >under the 2.6.5 kernel via the atmel/atmel_cs modules. However, since
> >upgrading to 2.6.6 I now get a kernel panic whenever I insert my card
> >and hotplug (2004-03-29) attempts to upload the 0.7-1 version of Simon's
> >firmware <http://thekelleys.org.uk/atmel/>. I've provided as much
> >debugging information as I can below, so feel free to let me know if
> >I've missed out on anything.
> >
> >Thanks in advanced,
> >Andrew "Netsnipe" Lau
> >
> >PS: Please CC: me as I'm not on LKML.
> >
>=20
> Sorry 'bout that: I believe that this is a casualty of ongoing=20
> driver-model changes. I have the following patch which purports to work=
=20
> around the problem. Please could you try i and let me know:
>=20
>=20
> Cheers,
>=20
> Simon.
>=20
> --- linux.orig/drivers/net/wireless/atmel_cs.c
> +++ linux/drivers/net/wireless/atmel_cs.c
> @@ -350,6 +350,9 @@ static struct {
>=20
>  static struct device atmel_device =3D {
>          .bus_id    =3D "pcmcia",
> +	.kobj =3D {
> +		.k_name =3D "atmel_cs"
> +	}
>  };
>=20
>  static void atmel_config(dev_link_t *link)
>=20

--=20
---------------------------------------------------------------------------
	Andrew "Netsnipe" Lau	<http://www.cse.unsw.edu.au/~alau/>
 Debian GNU/Linux Maintainer & UNSW Computing Students' Society President
				     -
		  "Nobody expects the Debian Inquisition!
     Our two weapons are fear and surprise...and ruthless efficiency!"
---------------------------------------------------------------------------

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA+KQZmyTAfS6LaL0RAmHIAKCm1aiykxkds8EhLKfAzYP820cQFQCgmZ+/
JVhhRF/Chq2XtAGs+ujAwVU=
=2/9t
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
