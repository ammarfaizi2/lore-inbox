Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288801AbSATQXW>; Sun, 20 Jan 2002 11:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288800AbSATQXM>; Sun, 20 Jan 2002 11:23:12 -0500
Received: from warande3094.warande.uu.nl ([131.211.123.94]:11350 "EHLO
	xar.sliepen.oi") by vger.kernel.org with ESMTP id <S288801AbSATQXC>;
	Sun, 20 Jan 2002 11:23:02 -0500
Date: Sun, 20 Jan 2002 17:22:58 +0100
From: Guus Sliepen <guus@warande3094.warande.uu.nl>
To: lkml <linux-kernel@vger.kernel.org>
Cc: christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@ufies.org>
Subject: Re: usb-ohci, ov511, video4linux
Message-ID: <20020120162258.GC16166@sliepen.warande.net>
Mail-Followup-To: Guus Sliepen <guus@sliepen.warande.net>,
	lkml <linux-kernel@vger.kernel.org>,
	christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@ufies.org>
In-Reply-To: <20020120154119.GB2873@online.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Content-Disposition: inline
In-Reply-To: <20020120154119.GB2873@online.fr>
User-Agent: Mutt/1.3.25i
X-oi: oi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 20, 2002 at 10:41:19AM -0500, christophe barb=E9 wrote:

> The Xawtv outputs are interesting :
>=20
> # xawtv
> This is xawtv-3.68, running on Linux/i586 (2.4.17)
> /dev/video0 [v4l]: no overlay support

That's normal.

> v4l-conf had some trouble, trying to continue anyway

That too, because of the earlier warning about overlay.

> v4l: timeout (got SIGALRM), hardware/driver problems?
> ioctl: VIDIOCSYNC(0): Appel syst=E8me interrompu
> v4l: timeout (got SIGALRM), hardware/driver problems?
> ioctl: VIDIOCSYNC(1): Appel syst=E8me interrompu

xawtv has a very short timeout when it tries to grab frames. It really
was made for TV cards, not webcams. You can either change xawtv's
libng/grab-v4l.c and edit the line containing #define SYNC_TIMEOUT, or
use a program like gqcam that is written especially for slow USB
webcams.

The problems with the other USB devices might be caused by the fact that
USB webcams will use all the available bandwidth.

--=20
Met vriendelijke groet / with kind regards,
  Guus Sliepen <guus@sliepen.warande.net>

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8Su7hAxLow12M2nsRAsYEAKCysu+G88bRuGzHyfREflRb0pgzpgCfePV2
OL7c9d20mHifT0kYShjSPbI=
=cgeY
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
