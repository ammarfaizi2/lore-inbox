Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311840AbSCTRDe>; Wed, 20 Mar 2002 12:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311839AbSCTRDZ>; Wed, 20 Mar 2002 12:03:25 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:2646 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S311836AbSCTRDR>; Wed, 20 Mar 2002 12:03:17 -0500
Date: Wed, 20 Mar 2002 18:03:11 +0100
From: Kurt Garloff <garloff@suse.de>
To: Marion Steiner <msteiner@rbg.informatik.tu-darmstadt.de>
Cc: linux-kernel@vger.kernel.org, Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: SCSI-Problem with AM53C974
Message-ID: <20020320180311.D1700@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Marion Steiner <msteiner@rbg.informatik.tu-darmstadt.de>,
	linux-kernel@vger.kernel.org,
	Linux SCSI list <linux-scsi@vger.kernel.org>
In-Reply-To: <200203171439.g2HEdwX00738@orion.steiner.local> <20020318123038.B19273@gum01m.etpnet.phys.tue.nl> <200203201401.g2KE1Cs00998@orion.steiner.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bi5JUZtvcfApsciF"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bi5JUZtvcfApsciF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marion,

On Wed, Mar 20, 2002 at 03:01:12PM +0100, Marion Steiner wrote:
> In linux.dev.kernel, Kurt Garloff wrote:
> >Can you try the attached patch please? Patch is against 2.4.18.
> >
[...]
> >Please report back, whether it works, so I can ask Marcelo to include it.
>=20
> OK, I found a littler bug in it, that's why on my first try it didn't
> work. There was a "!" missing in the if statement whether the region is
> free. So the driver failed if the region was free and succeeded if it was
> busy.
>=20
> But now it seems to work well, so including it in the kernel would be
> great.

Right you are! I was confused because I had fixed the aic7xxx driver just
before where the statement reads request_region(...) =3D=3D 0.
Sorry about that.

I'll submit the corrected patch to Marcelo.

Thanks for testing and for spotting the typo!
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--bi5JUZtvcfApsciF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8mMDPxmLh6hyYd04RAs5yAKDEYUbDA0QolGRL+zAjvKvdHEJcEwCfXeCU
Jy/eNhxO7/eD2VOOjESHfjI=
=chO1
-----END PGP SIGNATURE-----

--bi5JUZtvcfApsciF--
