Return-Path: <linux-kernel-owner+w=401wt.eu-S1751150AbXANJIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbXANJIz (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 04:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbXANJIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 04:08:55 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:36534 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751150AbXANJIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 04:08:54 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: 2.6.20-rc4: usb somehow broken
Date: Sun, 14 Jan 2007 10:08:37 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <200701111820.46121.prakash@punnoor.de> <200701111828.02119.oliver@neukum.org>
In-Reply-To: <200701111828.02119.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1326608.gmbgH2GEn4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200701141008.49986.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1326608.gmbgH2GEn4
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Donnerstag 11 Januar 2007 18:28 schrieb Oliver Neukum:
> Am Donnerstag, 11. Januar 2007 18:20 schrieb Prakash Punnoor:
> > Hi,
> >
> > I can't scan anymore. :-( I don't know which rc kernel introduced it, b=
ut
> > this are the messages I get (w/o touching the device/usb cable except
> > pluggin it in for the first time):
> >
> > usb 1-1.2: new full speed USB device using ehci_hcd and address 4
> > ehci_hcd 0000:00:0b.1: qh ffff81007bc6c280 (#00) state 4
> > usb 1-1.2: configuration #1 chosen from 1 choice
> > usb 1-1.2: USB disconnect, address 4
> > usb 1-1.2: new full speed USB device using ehci_hcd and address 5
> > usb 1-1.2: configuration #1 chosen from 1 choice
> > usb 1-1.2: USB disconnect, address 5
> > usb 1-1.2: new full speed USB device using ehci_hcd and address 6
> > usb 1-1.2: configuration #1 chosen from 1 choice
> > usb 1-1.2: USB disconnect, address 6
> > usb 1-1.2: new full speed USB device using ehci_hcd and address 7
> > usb 1-1.2: configuration #1 chosen from 1 choice
> > usb 1-1.2: USB disconnect, address 7
> > usb 1-1.2: new full speed USB device using ehci_hcd and address 8
> > usb 1-1.2: configuration #1 chosen from 1 choice
> >
> >
> > Shouldn't the ohci module handle the scanner? The scanner is connected
> > through a hub.
>
> Therefore it goes to EHCI. Can you try a direct connection?
>
> > I don't remember how 2.6.19 handled it, or whether I used some new exot=
ic
> > setting which causes the breakage.
>
> Could you try 2.6.19?
>
> > Well, I'll test this week-end and upload more infos then. If you already
> > have some ideas in the meantime, let me know.
>
> Please test with CONFIG_USB_DEBUG


Hi, I did more tests and I was wrong about "broken". It seems more a time-o=
ut=20
problem, ie if I try to use sane again in short intervalls, I will get my=20
device working. The cause seems CONFIG_USB_SUSPEND=3Dy. With 2.6.20-rc5 the=
=20
situation seems better, ie now I don't get "no device" very less often.

So do you still want me to try above stuff?

=2D-=20
(=C2=B0=3D                 =3D=C2=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1326608.gmbgH2GEn4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQBFqfMhxU2n/+9+t5gRAm88AJ0XWAcNMFluwb1WoCHPrhhVjtFbGwCfZZ6e
S5fgNsDZ8yqny0hLwD8VQC0=
=iH6t
-----END PGP SIGNATURE-----

--nextPart1326608.gmbgH2GEn4--
