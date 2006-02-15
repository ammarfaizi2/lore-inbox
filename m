Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030497AbWBOB4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030497AbWBOB4H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 20:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbWBOB4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 20:56:07 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:13227 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1030497AbWBOB4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 20:56:05 -0500
X-Sasl-enc: XDDNWKicED7jqVm0bJM2GPqm3OqT4vPcDXFpToBNwqOF 1139968562
Message-ID: <43F28A6D.5080109@imap.cc>
Date: Wed, 15 Feb 2006 02:57:01 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, Hansjoerg Lipp <hjlipp@web.de>,
       linux-kernel@vger.kernel.org, kkeil@suse.de, kai.germaschewski@gmx.de,
       isdn4linux@listserv.isdn4linux.de
Subject: Re: 2.6.16-rc3-mm1: ISDN_DRV_GIGASET driver
References: <20060214014157.59af972f.akpm@osdl.org> <20060214140019.GD10701@stusta.de>
In-Reply-To: <20060214140019.GD10701@stusta.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4FD37C5211FDEF68C541405B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4FD37C5211FDEF68C541405B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Adrian,

thank you very much for taking the time to comment.

On 14.02.2006 15:00, you wrote:
> - Do we really want to add new non-CAPI drivers to the kernel?

I have been in contact with the isdn4linux maintainer Karsten Keil on
that topic for quite some time and he didn't voice any objections to
submitting the driver in its current state.

Personally I am a great fan of CAPI, and of course we'll be happy to
port the driver to CAPI as soon as the capi4linux / mISDN framework is
ready for such an endeavour. This may however take some time yet, if I
understand Karsten correctly. In particular, we are talking here about
the mISDN L3 interface which seems to be the most appropriate for this
purpose, but has not been documented so far.

In the meantime, I take it from the discussions on lkml that it is
strongly discouraged to maintain working drivers outside the kernel
tree, which is what prompted us to submit ours in the first place.
Therefore I think it's in the best interest of everybody to merge its
current isnd4linux gestalt now, and convert it to CAPI at the earliest
convenience.

> - A new driver that can only be built modular is not acceptable.

No problem. In fact, the submitted drivers work fine if linked directly
into the kernel, too. The dependency on modular build in gigaset/Kconfig
only exists for the benefit of the ser_gigaset driver which we didn't
submit anyway. (See part 0 for the reasons.) We left it in because tests
have been done almost exclusively with modular builds; but if that turns
out to be a problem we'll just remove it.

Regards
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig4FD37C5211FDEF68C541405B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD8optMdB4Whm86/kRAhtGAJ44OMzojNX3weAX3bLgZRbY285LNwCfUMat
KSh3svjmcbG2zUbJ5KFiSAU=
=UlxY
-----END PGP SIGNATURE-----

--------------enig4FD37C5211FDEF68C541405B--
