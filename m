Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWE1RuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWE1RuE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 13:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWE1RuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 13:50:04 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:36796 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S1750830AbWE1RuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 13:50:03 -0400
Message-ID: <4479E2C5.90708@isotton.com>
Date: Sun, 28 May 2006 19:49:57 +0200
From: Aaron Isotton <aaron@isotton.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Dump the tcp_sock structure for every packet
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8B6E0FF836BFCD3169219719"
X-DCC-spamcheck-01.tornado.cablecom.ch-Metrics: smtp-03.tornado.cablecom.ch 1377;
	Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8B6E0FF836BFCD3169219719
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I'm doing some kernel hacking to evaluate different TCP congestion
control algorithms in a WLAN mesh network.

I need to output some TCP parameters (such as window sizes et al) over
time; what I'd wish to do is outputting them to a character device
whenever a packet comes in/is sent.

I've written the device code, now I just need to output the parameters
using that device. The easiest way would be simply outputting the whole
tcp_sock structure to the device, and then reading it in from user space.=


The problem is that I don't know where exactly in the TCP implementation
the packets are transmitted/received, i.e. where I should send the data
over to the device implementation.

The ideal case would of course be some kind of callback/hook function; I
imagine there might be something like this for the netfilter modules,
but I have no idea.

Can anybody help me with this?

Thank you,
Aaron
--=20
Aaron Isotton | http://www.isotton.com/
I'll give you a definite maybe. --Samuel Goldwyn


--------------enig8B6E0FF836BFCD3169219719
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEeeLIm2HPKfVbHyoRAlT5AJ9Vx41Wnd5MMoFf+dmufwnGiB5gkgCfdnQM
BehnIOukHqaKq4vuc7ATbJ0=
=xMow
-----END PGP SIGNATURE-----

--------------enig8B6E0FF836BFCD3169219719--
