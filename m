Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263347AbRFAEAP>; Fri, 1 Jun 2001 00:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263353AbRFAEAG>; Fri, 1 Jun 2001 00:00:06 -0400
Received: from ads.rallyarg.com.ar ([200.43.120.145]:48901 "EHLO
	kylix.cordoba.com.ar") by vger.kernel.org with ESMTP
	id <S263347AbRFAD75>; Thu, 31 May 2001 23:59:57 -0400
Date: Fri, 1 Jun 2001 01:01:06 -0300
From: John R Lenton <john@grulic.org.ar>
To: rui.sousa@mindspeed.com
Cc: David Raufeisen <david@fortyoz.org>, linux-kernel@vger.kernel.org,
        bpringle@sympatico.ca, emu10k1-devel@opensource.creative.com
Subject: Re: how to crash 2.4.4 w/SBLive
Message-ID: <20010601010106.G13446@grulic.org.ar>
Mail-Followup-To: rui.sousa@mindspeed.com,
	David Raufeisen <david@fortyoz.org>, linux-kernel@vger.kernel.org,
	bpringle@sympatico.ca, emu10k1-devel@opensource.creative.com
In-Reply-To: <20010524114219.B21442@fortyoz.org> <Pine.LNX.4.33.0105311157430.17958-200000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1xGqyAVbSpAWs5A"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.33.0105311157430.17958-200000@localhost.localdomain>; from rui.sousa@mindspeed.com on Thu, May 31, 2001 at 12:01:05PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1xGqyAVbSpAWs5A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 31, 2001 at 12:01:05PM +0200, rui.sousa@mindspeed.com wrote:
Content-Description: emu10k1 patch
> Index: audio.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /usr/local/cvsroot/emu10k1/audio.c,v
> retrieving revision 1.166
> diff -u -r1.166 audio.c
> --- audio.c	2001/04/22 15:44:25	1.166
> +++ audio.c	2001/05/31 08:47:25
> @@ -1231,6 +1231,7 @@
>  		woinst->buffer.ossfragshift =3D 0;
>  		woinst->buffer.numfrags =3D 0;
>  		woinst->device =3D (card->audio_dev1 =3D=3D minor);
> +		woinst->timer.state =3D TIMER_STATE_UNINSTALLED;
> =20
>  		init_waitqueue_head(&woinst->wait_queue);

the closest I can find (in 2.4.5) is

             woinst->buffer.fragment_size =3D 0;
             woinst->buffer.ossfragshift =3D 0;
             woinst->buffer.numfrags =3D 0;
             woinst->device =3D (card->audio1_num =3D=3D minor);

             init_waitqueue_head(&woinst->wait_queue);

at lines 1111--1116...

--=20
John Lenton (john@grulic.org.ar) -- Random fortune:
New York... when civilization falls apart, remember, we were way ahead of y=
ou.
- David Letterman

--X1xGqyAVbSpAWs5A
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7FxOCgPqu395ykGsRAtWfAKDQacZBgsOTNHe/mKbVdiqr7MIZIACeJEcJ
V6Fx+HZMO8OKCShQl8q80CQ=
=A7Pv
-----END PGP SIGNATURE-----

--X1xGqyAVbSpAWs5A--
