Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbTLYUjN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 15:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264359AbTLYUjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 15:39:13 -0500
Received: from mail.actcom.co.il ([192.114.47.15]:58082 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S264358AbTLYUjL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 15:39:11 -0500
Date: Thu, 25 Dec 2003 22:38:54 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Andrea Barisani <lcars@infis.univ.trieste.it>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: kernel 2.6.0, wrong Kconfig directives
Message-ID: <20031225203853.GV31789@actcom.co.il>
References: <20031222235622.GA17030@sole.infis.univ.trieste.it> <87smj8bt6y.fsf@devron.myhome.or.jp> <20031225195115.GQ31789@actcom.co.il> <87isk4bptp.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rsp728Nwk8twChKq"
Content-Disposition: inline
In-Reply-To: <87isk4bptp.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Rsp728Nwk8twChKq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2003 at 05:33:06AM +0900, OGAWA Hirofumi wrote:

> > +# Yes, this looks a bit odd. Yes, it ends up being turned on in lots
> > +# of cases. Please don't touch it. It is here to handle the case where
> > +# a sound driver can be either a module or compiled in if GAMEPORT is
> > +# not selected, but must be a module if the joystick is selected as a=
=20
> > +# module. The sound driver calls GAMEPORT functions. If GAMEPORT is
> > +# not selected, stubs are provided. If GAMEPORT is built in,
> > +# everything is fine. If GAMEPORT is a module, however, it would need
> > +# to be loaded for the sound driver to be able to link
> > +# properly. Therefore, the sound driver must be a module as well in
> > +# that case (and the GAMEPORT module must be loaded first).=20
> >  config SOUND_GAMEPORT
> >  	tristate
> >  	default y if GAMEPORT!=3Dm
>=20
> I see. So why did we need the SOUND_GAMEPORT?

I thought I explained this above, quite verbosely :-)=20
Rather than make the sound drivers depend directly on GAMEPORT, which
is troublesome because Kconfig has no provisions for this type of
dependancy, we create an artificial dependency, SOUND_GAMEPORT, which
the sound driver depends on. SOUND_GAMEPORT depends on GAMEPORT, and
Kconfig ends up doing the right thing. I hope that was clearer.=20

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

"the nucleus of linux oscillates my world" - gccbot@#offtopic


--Rsp728Nwk8twChKq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/60rdKRs727/VN8sRAjDBAKC6q/DcJ4/L+706a/WKQjg9N5QbqgCfWChy
URqpSUfROwy4/IL1doTUvKE=
=VAn9
-----END PGP SIGNATURE-----

--Rsp728Nwk8twChKq--
