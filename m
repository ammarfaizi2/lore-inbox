Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262697AbVA1TYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbVA1TYe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbVA1TWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 14:22:20 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:55992 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S262792AbVA1TTL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 14:19:11 -0500
Subject: Re: Performance of iptables-restore on large rule sets
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Steve Bergman <steve@rueb.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41FA8ADE.6080708@rueb.com>
References: <41FA8ADE.6080708@rueb.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZU1n+a8ipbsoBM5QwL0+"
Date: Fri, 28 Jan 2005 20:19:07 +0100
Message-Id: <1106939947.1085.13.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZU1n+a8ipbsoBM5QwL0+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-01-28 at 12:56 -0600, Steve Bergman wrote:
> I have a large rule set (~53000 rules) that I sometimes load using=20
> iptables-restore.  (It takes almost an hour.
>=20
> Googling around tells me that the loop detection code in the kernel is=20
> slow with large rule sets.  The only thing  that seems odd to me is that=20
> throughout the entire loading process, iptables-restore is consistently=20
> at about 67% user and33% system processor time according to vmstat.  If=20
> the slowness is in the kernel, shouldn't I be seeing a high and ever=20
> increasing amount of "system" time?

The loop checking takes place in userspace.

> Kernel is 2.6.9-1.681_FC3.  Iptables is iptables-1.2.11-3.1.FC3.

Please try what is going to be released as iptables 1.3.0
You can get the latest snapshot here:
ftp://ftp.netfilter.org/pub/iptables/snapshot/iptables-1.3.0-20050127.tar.b=
z2

Read the file called INSTALL to see how to compile and install it. (and
make sure you are actually using the new version after it's installed,
either by using the absolute patch, /usr/local/sbin/iptables or by
uninstalling the iptables rpm)

It contains a rewrite of libiptc which is the library that performs the
ruleset modifications, it's much faster now.

I hope it improves your situation.

--=20
/Martin

--=-ZU1n+a8ipbsoBM5QwL0+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB+pArWm2vlfa207ERAk83AJ0Trq/fdOYozmUYOA/Q+3DxrUK9hQCbBqNe
M1HMFFey+KNiYko0eInp6Iw=
=9KOg
-----END PGP SIGNATURE-----

--=-ZU1n+a8ipbsoBM5QwL0+--
