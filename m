Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316672AbSFZQHt>; Wed, 26 Jun 2002 12:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316668AbSFZQHs>; Wed, 26 Jun 2002 12:07:48 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:56885 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S316666AbSFZQHo>; Wed, 26 Jun 2002 12:07:44 -0400
Date: Wed, 26 Jun 2002 18:07:45 +0200
From: Kurt Garloff <garloff@suse.de>
To: Austin Gonyou <austin@digitalroadkill.net>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: max_scsi_luns and 2.4.19-pre10.
Message-ID: <20020626160745.GF3023@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Austin Gonyou <austin@digitalroadkill.net>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Linux SCSI list <linux-scsi@vger.kernel.org>
References: <1025052385.19462.5.camel@UberGeek> <20020626123337.GC1217@gum01m.etpnet.phys.tue.nl> <1025101125.19558.4.camel@UberGeek>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i3lJ51RuaGWuFYNw"
Content-Disposition: inline
In-Reply-To: <1025101125.19558.4.camel@UberGeek>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--i3lJ51RuaGWuFYNw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Austin,

On Wed, Jun 26, 2002 at 09:18:45AM -0500, Austin Gonyou wrote:
> On Wed, 2002-06-26 at 07:33, Kurt Garloff wrote:
> > enough guesses have been there not answering your questions ...
>=20
> Sure I hear that. But I posted an earlier question about QLA2200 and a

You don't think that somebody who reads your message and tries to post a
helpful comment scans the list for earlier messages of yours, do you?

> PV 660F and not seeing > 8 luns with 2.4.19-pre10.
  ^^^^^^^

This device needs BLIST_LARGELUN.

> I'll take a look at that, and see if I can merge it into -aa4.=20

The patch should be in there, just not the additional devices that need
BLIST_LARGELUN.

> > The flag does allow a device to use more than 8 LUNs despite it reporti=
ng
> > as SCSI Version 2 devices (which can not support more than 8 LUNs norma=
lly
> > ...)=20
> > The flag also needs to be set for some more devices, look for DGC, DELL=
, CMD
> > and CNSi/CNSI devices that already have the BLIST_SPARSELUN flag.
>=20
> This would be a DELL device, so I'll see about changing it from
> SPARESLUN to LARGELUN?

No. Add " | BLIST_LARGELUN" .

> > But as you did not post the output of /proc/scsi/scsi nor the syslog
> > meesages from your SCSI subsystem nobody knows what devices you're usin=
g or
> > what actually happens. Just speculations ...
>=20
> There's nothing to post from /proc/scsi/scsi or the syslog other than
> there's no more than 8 devices on my FC chain. I guess the real point
> here is that if you're using FC, you're probably going to use more than
> 8 luns, even if not immediately. Especially for large Databases.=20

People could have seen what SCSI device you're using.
So I could have told you instead of guessing and risking to add to the noise
myself.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--i3lJ51RuaGWuFYNw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9GebQxmLh6hyYd04RAm3FAKCC0vde624pbJGqc6nrmfHxhtzWlwCdEgbv
H24DfGZ4+GbxeqRkM+A12z8=
=Bt7M
-----END PGP SIGNATURE-----

--i3lJ51RuaGWuFYNw--
