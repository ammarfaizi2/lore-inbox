Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTLTUlF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 15:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbTLTUlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 15:41:04 -0500
Received: from adsl-67-121-154-253.dsl.pltn13.pacbell.net ([67.121.154.253]:36031
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S261464AbTLTUlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 15:41:00 -0500
Date: Sat, 20 Dec 2003 12:40:57 -0800
To: linux kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 ps2 mouse
Message-ID: <20031220204057.GE7522@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	linux kernel ML <linux-kernel@vger.kernel.org>
References: <1071923389.3476.6.camel@cripat.acasa-tr.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline
In-Reply-To: <1071923389.3476.6.camel@cripat.acasa-tr.it>
User-Agent: Mutt/1.5.4i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2003 at 01:29:50PM +0100, Cristiano De Michele wrote:
> I gave new 2.6.0 kernel a try and one thing I noticed is that mouse
> pointer (imps2 logitech optical mouse on /dev/psaux) has become too
> sensitive, that is in other words it's almost unusable.
> With 2.4.x I haven't any problem

This is typically a problem with your XF86Config because many read from
both /dev/psaux AND /dev/input/mice concurrently. However, in 2.6,
the data from /dev/psaux is included in /dev/input/mice, so all mouse
events appear to be recorded twice.

Just remove the entry from the ServerLayout section, and restart the X
server.

--=20
Joshua Kwan

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBP+Sz2KOILr94RG8mAQKBYQ//UPZeNC3Xf7Gy/L0Wk6yNoSWE7bY/Pisk
wiuYWVWPPlptpb68apgz+nIYPFpfF6+O7BpD5HqynoAt0ee0Y/4xO+8/5z7qAQ7l
gKwLHPmtH4ui/rRYDzCJY2yLKv5gSb/hbCtFCBwFNKwlsyjdeSCgiezIvdrHkpDZ
0FkT+tKWh1LYsFnw/6pYtQMxYQ9OVHaNKB7BN2w20eq9OYjld36a8daZ4LtQ/2wp
G2GWd8acbFdbpMVgecsgR4SpJKNj+TKmXXhi0vLoKTtSBP8zUFxuZfc4ABHWwD5g
WH82LoEoeWuyLI2tbOc54WXvtief23HoU5XbudBaRh9uXWryBUsrYbbkbWGT+Cw5
x72aINHDhWE0PymTGeIKWVCjXAJIvdgTKsb1/SmpR9pWChEG/s39CdM7ta93rp3t
+q8La/sE3bH4MB0GEAPRsIpgJDkqSbabxAC+2eUdgGW0R2Zev+BfTJ5ifvZgklnZ
1M7FIfyLRXPwbOoOWLa7vtK52KYiu82ls/RvcV/dH7Xq/MP+MN9PwSKjrQnX8jAq
xQ45vIIN76pOMzeyBph9hw4M5zkX7Y35i496LyudiNdfOYKuwunf6BcWCh5C8z1m
sHnkIdFUc1ba3fiRul6GG8rHPNvZO7WRn8H03y4giwD2Hk/MfOD8s5ipcWoy+9EC
f++A+TXwqL8=
=ihyT
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--
