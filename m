Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262644AbUKQVwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262644AbUKQVwD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 16:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbUKQVtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 16:49:18 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:28378 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S262657AbUKQVoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 16:44:10 -0500
Subject: Re: Network slowdown from 2.6.7 to 2.6.9
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Harry Edmon <harry@atmos.washington.edu>
Cc: Con Kolivas <kernel@kolivas.org>, Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <419BBF57.3040808@atmos.washington.edu>
References: <419A9151.2000508@atmos.washington.edu>
	 <20041116163257.0e63031d@zqx3.pdx.osdl.net>
	 <cone.1100651833.776334.15267.502@pc.kolivas.org>
	 <419BA5C4.4020503@atmos.washington.edu>
	 <1100722571.20185.9.camel@tux.rsn.bth.se>
	 <419BBF57.3040808@atmos.washington.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1LD/Z5b0DSX5MIzlv13T"
Message-Id: <1100727847.20185.31.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 17 Nov 2004 22:44:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1LD/Z5b0DSX5MIzlv13T
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-11-17 at 22:15, Harry Edmon wrote:
> No, it is not loaded.  Here is the list of loaded modules under 2.6.9:

Ok, then it's something else, maybe the TSO changes...

Here's some thigs to try:

You can see the current settings, TSO etc, with

'ethtool -k eth0'
and disable TSO with
'ethtool -K eth0 tso off'

If that doesn't help there's more things to try.

I don't know anything about the diffrent TCP congestion algorithms
(Stephen does), but you could try disabling BIC.

echo 0 > /proc/sys/net/ipv4/tcp_bic

(continuing with things I hardly know anything about...)

Or maybe the autotuning receive buffer, try disabling that with

echo 0 > /proc/sys/net/ipv4/tcp_moderate_rcvbuf


Stephen, any more things to try ?

--=20
/Martin

--=-1LD/Z5b0DSX5MIzlv13T
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBm8YnWm2vlfa207ERAgyHAJ9GrOuJTC0Elj3ut4IJ2VXUBxS+4ACfeZs5
OSS/aW7xCYrIyu1sdh0aF18=
=4tf/
-----END PGP SIGNATURE-----

--=-1LD/Z5b0DSX5MIzlv13T--
