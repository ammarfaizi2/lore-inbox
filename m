Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270646AbRIFNS3>; Thu, 6 Sep 2001 09:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270661AbRIFNSW>; Thu, 6 Sep 2001 09:18:22 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:16999 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S270657AbRIFNSI>; Thu, 6 Sep 2001 09:18:08 -0400
Date: Thu, 6 Sep 2001 15:18:27 +0200
From: Kurt Garloff <garloff@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: page_launder() on 2.4.9/10 issue
Message-ID: <20010906151827.F21793@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Rik van Riel <riel@conectiva.com.br>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010906124700Z16067-32383+3773@humbolt.nl.linux.org> <Pine.LNX.4.33L.0109061002050.31200-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zs/RYxT/hKAHzkfQ"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0109061002050.31200-100000@imladris.rielhome.conectiva>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Zs/RYxT/hKAHzkfQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2001 at 10:03:03AM -0300, Rik van Riel wrote:
> On Thu, 6 Sep 2001, Daniel Phillips wrote:
> > On September 6, 2001 02:32 pm, Rik van Riel wrote:
> > > Two words:  "IO clustering".
> >
> > Yes, *after* the IO queue is fully loaded that makes sense.  Leaving it
> > partly or fully idle while waiting for it to load up makes no sense at =
all.
> >
> > IO clustering will happen naturally after the queue loads up.
>=20
> Exactly, so we need to give the queue some time to load
> up, right ?

Just use two limits:
* Time: After some time (say two seconds), we can always afford to write it
  out=20
* Queue filling: After it has a certain size, it's worth doing a writing.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--Zs/RYxT/hKAHzkfQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7l3eixmLh6hyYd04RAuJcAJ0R3gmlo4urF+EpRsFrY4/VKboxDQCgqPkB
mKXk3gXQn96h43CfQjsO2Yk=
=FuBq
-----END PGP SIGNATURE-----

--Zs/RYxT/hKAHzkfQ--
