Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263040AbUFVN1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbUFVN1v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 09:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbUFVN1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 09:27:49 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:3052 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S261712AbUFVN1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 09:27:05 -0400
Subject: [netdev watchdog/b44] is something broken?
From: Ian Kumlien <pomac@vapor.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EDD4yLuRgn5eIeG/jHrs"
Message-Id: <1087910823.2971.145.camel@big>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Jun 2004 15:27:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EDD4yLuRgn5eIeG/jHrs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,=20

I mailed before about dlinks 4 port alta card using sundance...=20

Now i'm trying to transfer some data to my laptop and after about 1
minute of ~12mb/s this happens:

NETDEV WATCHDOG: eth0: transmit timed out
b44: eth0: transmit timed out, resetting
b44: eth0: Link is down.
eth0: no IPv6 routers present
b44: eth0: Link is up at 100 Mbps, full duplex.
b44: eth0: Flow control is on for TX and on for RX.

This is a udp link, but i disabled all tcp tweaks that i have been
playing with as well. Btw, this worked just fine for a while, then this
started. (tcp tweaks like westwood and bic)

Imho something is wrong with the watchdog (or the staircase scheduler
7.1 changes some behavior that the watchdog is depending on... Other
than that this is a pure 2.6.7 kernel)

Any comments clues suggestions?

I'm copying this to a firewire disk if that could have any
implications... But after seeing this in the sundance driver i'm
assuming that something else is broken.

Just prior to the watchdog timeout the transfer seems to act like a sine
wave, ie 8mb/s -> 533 b/s -> 12 mb/s -> 733b/s -> etc
(observations from gkrellm)

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-EDD4yLuRgn5eIeG/jHrs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA2DOn7F3Euyc51N8RAo23AJ4oEYUAGI0rnX1d8euHOUzmSV1U1gCfRE2i
wTbd4m0LQHQrcsEmahLQ+kE=
=zFxV
-----END PGP SIGNATURE-----

--=-EDD4yLuRgn5eIeG/jHrs--

