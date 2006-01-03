Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbWACQEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWACQEn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 11:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWACQEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 11:04:43 -0500
Received: from 6.143.111.62.revers.nsm.pl ([62.111.143.6]:4616 "HELO
	matthew.ogrody.nsm.pl") by vger.kernel.org with SMTP
	id S932420AbWACQEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 11:04:42 -0500
Date: Tue, 3 Jan 2006 17:05:02 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       Adrian Bunk <bunk@stusta.de>, perex@suse.cz,
       alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20060103160502.GB5262@irc.pl>
Mail-Followup-To: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
	Adrian Bunk <bunk@stusta.de>, perex@suse.cz,
	alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
	sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
	kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
	jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
	zwane@commfireservices.com, zaitcev@yahoo.com,
	linux-kernel@vger.kernel.org
References: <20050726150837.GT3160@stusta.de> <200601031441.27519.s0348365@sms.ed.ac.uk> <Pine.LNX.4.61.0601031548210.436@yvahk01.tjqt.qr> <200601031522.06898.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
In-Reply-To: <200601031522.06898.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 03, 2006 at 03:22:06PM +0000, Alistair John Strachan wrote:
> On Tuesday 03 January 2006 14:50, Jan Engelhardt wrote:
> > >The problem with using OSS compatibility, at least on this machine with
> > > ALSA 1.0.9, is that if you use it you automatically lose the software
> > > mixing capabilities of ALSA, so it really is less than ideal.
> >
> > Well, I am able to open /dev/dsp multiple times here without problems.
> > (Is /dev/dsp soft- or hardmixing?)
>=20
> As far as I'm aware, it depends on your hardware. For example, software m=
ixing=20
> kicks in with zero configuration on most hardware that won't mix in hardw=
are,=20
> e.g. my laptop's i810 audio.
>=20
> [alistair] 15:18 [~] cat /proc/asound/cards
> 0 [I82801DBICH4   ]: ICH4 - Intel 82801DB-ICH4
>                      Intel 82801DB-ICH4 with AD1981B at 0xa0100000, irq 11
> 1 [Modem          ]: ICH-MODEM - Intel 82801DB-ICH4 Modem
>                      Intel 82801DB-ICH4 Modem at 0x3400, irq 11
>=20
> I can successfully hear two mixed sources when I execute the following:
>=20
> ogg123 -q --device=3Dalsa09 01\ -\ Good\ Times\ Bad\ Times.ogg
>=20
> And on another terminal
>=20
> ogg123 -q --device=3Dalsa09 01\ -\ Good\ Times\ Bad\ Times.og
>=20
> This is ALSA soft mixing the two sources for me. Very nifty. However, if =
I=20
> throw an OSS into the mix (whilst these other two are playing).
>=20
> [alistair] 15:20 [~/Music/Led Zeppelin - I] ogg123 -q --device=3Doss 01\ =
-\=20
> Good\ Times\ Bad\ Times.ogg
> Error: Cannot open device oss.

 Proper way (using userspace OSS emulation):
aoss ogg123 -q --device=3Doss [...]

--=20
Tomasz Torcz                "Funeral in the morning, IDE hacking
zdzichu@irc.-nie.spam-.pl    in the afternoon and evening." - Alan Cox


--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFDuqCuThhlKowQALQRAtznAJ0WS7D2YFJ/8F/WgWgXjd4P3rzmwgCeOAEs
dWJKMaY0Jt0wOQicCyT8RHE=
=05kY
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
