Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030575AbWJaIhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030575AbWJaIhO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 03:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030581AbWJaIhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 03:37:14 -0500
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:37021 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S1030575AbWJaIhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 03:37:11 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: fatih.asici@gmail.com
Subject: Re: [Alsa-devel] [RFC: 2.6.19 patch] snd-hda-intel: default MSI to off
Date: Tue, 31 Oct 2006 09:37:38 +0100
User-Agent: KMail/1.9.5
Cc: "Takashi Iwai" <tiwai@suse.de>, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org, mingo@redhat.com, hnguyen@de.ibm.com,
       perex@suse.cz, "Stephen Hemminger" <shemminger@osdl.org>
References: <200610050938.10997.prakash@punnoor.de> <s5hhcxv1bc3.wl%tiwai@suse.de> <5aa69f860610302256u61e30b2aj2501e5c1f5b7335@mail.gmail.com>
In-Reply-To: <5aa69f860610302256u61e30b2aj2501e5c1f5b7335@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3068189.yOAyV9dVk0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610310937.42576.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3068189.yOAyV9dVk0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Dienstag 31 Oktober 2006 07:56 schrieb Fatih Asici:
> On 10/23/06, Takashi Iwai <tiwai@suse.de> wrote:
> > At Sun, 22 Oct 2006 22:29:13 +0200,
> >
> > Prakash Punnoor wrote:
> > > Am Mittwoch 18 Oktober 2006 19:21 schrieb Takashi Iwai:
> > > > > Yes, it would be better to check the value and reset chip->msi if
> > > > > not successful.  But it's not a fatal error, so the current code
> > > > > should work.
> > > >
> > > > The below is the revised patch.
> > >
> > > I tried it and it works fine for me now (with the driver not using msi
> > > automatically now).
> >
> > Thanks for checking.  I applied the patch to ALSA tree for the next
> > push round.
>
> It does not solve my problem. I still need to boot with pci=3Dnomsi optio=
n.
>
> Prakash: did you use Takashi's patch or Andrian's patch?

I used Takashi's revised patch, but rc3 works w/o patching:

dvanced Linux Sound Architecture Driver Version 1.0.13 (Sun Oct 22 08:56:16=
=20
2006 UTC).
ACPI: PCI Interrupt Link [AAZA] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [AAZA] -> GSI 23 (level, low) -=
>=20
IRQ 23
PCI: Setting latency timer of device 0000:00:10.1 to 64
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
hda_intel: No response from codec, disabling MSI...
ALSA device list:
  #0: HDA NVidia at 0xfe028000 irq 316

And it disables MSI automatically.
=2D-=20
(=C2=B0=3D                 =3D=C2=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart3068189.yOAyV9dVk0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFRwtWxU2n/+9+t5gRAvG4AKDLJUK+KHGL708uwjMgWrXY3IN+vQCgxKVg
8Kh/XWS5wdiJWkt+JXbX0m0=
=onh0
-----END PGP SIGNATURE-----

--nextPart3068189.yOAyV9dVk0--
