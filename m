Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268970AbUIBU24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268970AbUIBU24 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268985AbUIBU1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:27:34 -0400
Received: from sp36.amenworld.com ([62.193.200.26]:46050 "EHLO tuxedo-es.org")
	by vger.kernel.org with ESMTP id S268970AbUIBUWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:22:34 -0400
Subject: random.c Entropy pool enhancements for external TRNG connection.
From: Lorenzo Hernandez Garcia-Hierro <lorenzo@gnu.org>
Reply-To: lorenzo@gnu.org
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2zHm3HOMeZIgI+k0qD1t"
Message-Id: <1094156314.22241.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 02 Sep 2004 22:18:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2zHm3HOMeZIgI+k0qD1t
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,
I'm working together with a friend of my secondary school on a True
Random Number Generator,following the schemas of Fourmilab HotBits TRNG,
hardware based and connected by the standard serial connector.
The idea is to provide a big quality random numbers to inject in the
kernel entropy pool, receiving all of them by the serial cable.
I'm trying to modify random.c to implement some of these things but i'm
a bit stuck (i'm not a C master, i'm just 15 old and learning it since 2
months).

This is what i have done yet:
=3D=3D=3D=3D=3D
/*******************************************************=20
 * 		True Random Number Generator (TRNG) routines		     *
 *******************************************************
 * Author: Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>
 * Description:
 * These routines are intended to make use of an external TRNG device
 * by the COM1 port (serial conector), adding more strong entropy to the
 * pool.These routines have been tested using the Fourmilab HotBits
Atomic
 * TRNG, which uses a Geiger counter to make true random bits based on
 * the atoms' (unpredictable) destruction times.
 */
=20
void add_trng_randomless(unsigned char trngflow)
{
	[HERE SHOULD COME THE STUFF TO GET THE DATA FROM THE TRNG]
	add_timer_randomness(&trng_timer_state, trngflowsc);
}

/*****************************************************
 * 	End of True Random Number Generator (TRNG) routines		 *
 *****************************************************/

memset(&trng_timer_state, 0, sizeof(struct timer_rand_state));
=3D=3D=3D=3D

trngflow should be the data that comes from the TRNG, also i want to
know if i should add the symbols in the end of random.c, for
add_trng_randomless function as each other (blk,irq,kb,mouse).

Is anybody interested in this project?
I will appreciate any idea or tip.

Best regards,
--=20
Lorenzo Hernandez Garcia-Hierro <lorenzo@gnu.org>

--=-2zHm3HOMeZIgI+k0qD1t
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBN4AZDcEopW8rLewRAuylAKDNK0mgSIGF7DkfhyRbuUuatjHp0QCfRC83
wO6w69eZD6+FuJm27x4o3qs=
=h/Pv
-----END PGP SIGNATURE-----

--=-2zHm3HOMeZIgI+k0qD1t--

