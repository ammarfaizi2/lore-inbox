Return-Path: <linux-kernel-owner+w=401wt.eu-S964823AbWLMAU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWLMAU6 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 19:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbWLMASX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 19:18:23 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:39711 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964829AbWLMARy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 19:17:54 -0500
X-Greylist: delayed 1873 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 19:17:54 EST
X-Sasl-enc: dDt+mmLnnbrWyfMwS8Q6nU6sRwMPmqNNooPGTxEuQKCq 1165969073
Message-ID: <457F478C.2010702@imap.cc>
Date: Wed, 13 Dec 2006 01:21:32 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: Corey Minyard <cminyard@mvista.com>,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       linux-serial@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Hansjoerg Lipp <hjlipp@web.de>, Russell Doty <rdoty@redhat.com>
Subject: Re: [PATCH] Add the ability to layer another driver over the serial
 driver
References: <4533B8FB.5080108@mvista.com>	<20061210201438.tilman@imap.cc>	<Pine.LNX.4.60.0612102117590.9993@poirot.grange>	<457CB32A.2060804@mvista.com>	<20061211102016.43e76da2@localhost.localdomain>	<457D8E35.9050706@imap.cc> <20061211174004.5605fb47@localhost.localdomain>
In-Reply-To: <20061211174004.5605fb47@localhost.localdomain>
X-Enigmail-Version: 0.94.1.2
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA9A3F79F6EA252CA77252C51"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA9A3F79F6EA252CA77252C51
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 11.12.2006 18:40 schrieb Alan:
> On Mon, 11 Dec 2006 17:58:29 +0100
> Tilman Schmidt <tilman@imap.cc> wrote:
>=20
>> On Mon, 11 Dec 2006 10:20:16 +0000, Alan wrote:
>>> This looks wrong. You already have a kernel interface to serial drive=
rs.
>>> It is called a line discipline. We use it for ppp, we use it for slip=
, we
>>> use it for a few other things such as attaching sync drivers to some
>>> devices.
>> I was under the impression that line disciplines need a user space
>> process to open the serial device and push them onto it.=20
>=20
> Yes that is correct. You need a way for the user to tell you which port=

> to use and to the permission and usage management for it anyway (as wel=
l
> as load the module and configure settings), so this seems quite
> reasonable.

I'm afraid I'm not familiar with Linux' SLIP implementation.
So there's a line discipline called "slip" which, when pushed
onto a serial port, registers as a network device, right? How
does it get - and stay - pushed? Is there a daemon process which
opens the serial port, pushes the line discipline onto it, and
then just sleeps, keeping the serial port open so that the line
discipline stays put? Can you point me to the source for such a
daemon for reference?

What I am actually looking for is a way to port an existing driver
which directly programs an i8250 serial port, to cooperate more
cleanly with the existing serial port drivers of Linux (and, at
the same time, shed the dependency on the specific serial port
hardware.) If that requires a permanently running (or sleeping)
userspace daemon, then so be it. (Although I admit I'd rather do
without.)

Thanks
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enigA9A3F79F6EA252CA77252C51
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFf0eMMdB4Whm86/kRAjTKAJ4x7QFA3ra01lXKy5ah+6gp0GMHkgCeMq9t
hcjtJ5NXvmSzqWcH2S0wDL0=
=1cFk
-----END PGP SIGNATURE-----

--------------enigA9A3F79F6EA252CA77252C51--
