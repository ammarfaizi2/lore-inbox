Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293688AbSCKLNY>; Mon, 11 Mar 2002 06:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293691AbSCKLNW>; Mon, 11 Mar 2002 06:13:22 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:51531 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S293686AbSCKLNI>; Mon, 11 Mar 2002 06:13:08 -0500
Date: Mon, 11 Mar 2002 12:13:00 +0100
From: Kurt Garloff <garloff@suse.de>
To: Douglas Gilbert <dougg@torque.net>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Jeremy Higdon <jeremy@classic.engr.sgi.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Message-ID: <20020311121300.G2346@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Douglas Gilbert <dougg@torque.net>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Jeremy Higdon <jeremy@classic.engr.sgi.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
In-Reply-To: <200202281536.g1SFaqF02079@localhost.localdomain> <E16heCm-0000Q5-00@starship.berlin> <10203032021.ZM443706@classic.engr.sgi.com> <E16hl4R-0000Zx-00@starship.berlin> <phillips@bonn-fries.net> <10203032209.ZM424559@classic.engr.sgi.com> <20020304165216.A1444@redhat.com> <3C8AEDFC.502CAD04@torque.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7IgncvKP0CVPV/ZZ"
Content-Disposition: inline
In-Reply-To: <3C8AEDFC.502CAD04@torque.net>
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7IgncvKP0CVPV/ZZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Doug,

On Sun, Mar 10, 2002 at 12:24:12AM -0500, Douglas Gilbert wrote:
> "Stephen C. Tweedie" wrote:
> > Even if WCE is enabled in the caching mode page, we can still set FUA
> > (Force Unit Access) in individual write commands to force platter
> > completion before commands complete.
> >=20
> > Of course, it's a good question whether this is honoured properly on
> > all drives.
> >=20
> > FUA is not available on WRITE6, only WRITE10 or WRITE12 commands.
>=20
> Stephen,
[...]
>=20
> Also SYNCHRONIZE CACHE(10) allows a range of blocks to be sent
> to the platter but the size of the range is limited to 2**16 - 1
> blocks which is probably too small to be useful. If the
> "number of blocks" field is set to 0 then the whole disk cache
> is flushed to the platter.

Which I think we should send before shutdown (and possible poweroff) for
disks (DASDs), Write-Once and Optical Memory devices. (Funny enough, the
SCSI spec also lists SYNCHRONIZE_CACHE for CD-Rom devices
Unfortunately, SYNCHRONIZE CACHE is optional, so we would need to ignore any
errors returned by this command.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--7IgncvKP0CVPV/ZZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8jJE8xmLh6hyYd04RArF2AJ9jQ0iQdKVTyth28OZaFtqeWr3zBgCg1pzc
KkAub5YVSAyAsHU58JIiBRc=
=L3yN
-----END PGP SIGNATURE-----

--7IgncvKP0CVPV/ZZ--
