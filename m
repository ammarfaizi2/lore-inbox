Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbVKUVM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVKUVM3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVKUVM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:12:29 -0500
Received: from minden014.server4you.de ([217.172.177.14]:34450 "EHLO
	himura.kakuri.org") by vger.kernel.org with ESMTP id S1750719AbVKUVM3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:12:29 -0500
From: Christian Parpart <trapni@gentoo.org>
Organization: Gentoo Foundation
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: virtual OSS devices [for making selfish apps happy]
Date: Mon, 21 Nov 2005 22:16:07 +0100
User-Agent: KMail/1.9
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1561462.aXt4xiTRBo";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511212216.10837.trapni@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1561462.aXt4xiTRBo
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

I'm having some apps running on my desktop that all want
exclusive access to my sound device just for playing audio
(and a single app for capturing), namely:

 * TeamSpeak (VoIP team voice chat)
 * Cedega (for playing some win32 games on my beloved box)
 * KDE/arts (my desktop wants to play some sounds as well wtf)

While I could easily disable my desktop sounds, and yeah, forget about the=
=20
music, but I'd still like to be in TeamSpeak (talking to friends and alike)=
=20
while playing a game using cedega.

Unfortunately, *all* those stupid (2) apps want exclusive access to the OSS=
=20
layout of my ALSA drivers, though, there just came into my mind to buy a=20
second audio device and wear a second headset (a little one below/under my=
=20
big one). But I couldn't find it handy anyway :(

So, in the end, what about writing a virtual OSS driver that can spawn=20
multiple (fake) /dev/vdsp%d's that all allow audio rendering (output) and a=
t=20
least a single one capturing (this at least would fit *my* needs).
This virtual driver then would has to know about the real audio device then=
 of=20
course that would it use to merge/mix the audio outputs to and to read the=
=20
requested capture data from.

Okay, neat idea, but I never ever wrote a single kernel code line!

So, can some guys of you please help me out there in *either* telling me wh=
ere=20
to find the basics on kernel module writing *and* how to do such things lik=
e=20
I said I want.
Or, even if you feel that happy about that idea and can't wait until I got=
=20
stuck in finishing it, and you can DIYS, that would be even much nicer.

C/C++ is not my problem, and I have already seen/read the linux kernel code=
=20
not just once, but I am definitely laggin in experience in kernel=20
development.

Please help.

Thanks in advance,
Christian Parpart.

--nextPart1561462.aXt4xiTRBo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.18 (GNU/Linux)

iD8DBQBDgjkaPpa2GmDVhK0RAgsrAJ4ifTHAfRiFeRVRspcaukWX2OuRsgCfYRw9
AJpLesu6Dnncr1M+NSV0ygY=
=u7T6
-----END PGP SIGNATURE-----

--nextPart1561462.aXt4xiTRBo--
