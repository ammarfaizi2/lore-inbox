Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316535AbSFZMdj>; Wed, 26 Jun 2002 08:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316533AbSFZMdi>; Wed, 26 Jun 2002 08:33:38 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:39986 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S316532AbSFZMdg>; Wed, 26 Jun 2002 08:33:36 -0400
Date: Wed, 26 Jun 2002 14:33:37 +0200
From: Kurt Garloff <garloff@suse.de>
To: Austin Gonyou <austin@digitalroadkill.net>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: max_scsi_luns and 2.4.19-pre10.
Message-ID: <20020626123337.GC1217@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Austin Gonyou <austin@digitalroadkill.net>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Linux SCSI list <linux-scsi@vger.kernel.org>
References: <1025052385.19462.5.camel@UberGeek>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZmUaFz6apKcXQszQ"
Content-Disposition: inline
In-Reply-To: <1025052385.19462.5.camel@UberGeek>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Austin,

enough guesses have been there not answering your questions ...

On Tue, Jun 25, 2002 at 07:46:25PM -0500, Austin Gonyou wrote:
> This originally was asking for help regarding QLA2200's, but I've since
> discovered it's a kernel param problem that I'm not sure how to solve.
>=20
> Using a default RH kernel (from SGI XFS installer) and passing
> max_scsi_luns=3D128 in grub, and for scsi_mod, it seems to work.=20

In 2.4.19pre1 a patch was merged into mainline which introduced a flag
BLIST_LARGELUN and set it for EMC Symmetrix devices. Some distributors
(incl. RH and SuSE) did ship kernels with this patch included.
http://van-dijk.net/linuxkernel/200206/0347.html
(An older patch for 2.4.16 exists as well.)

The flag does allow a device to use more than 8 LUNs despite it reporting
as SCSI Version 2 devices (which can not support more than 8 LUNs normally
=2E..)=20
The flag also needs to be set for some more devices, look for DGC, DELL, CMD
and CNSi/CNSI devices that already have the BLIST_SPARSELUN flag.

But as you did not post the output of /proc/scsi/scsi nor the syslog
meesages from your SCSI subsystem nobody knows what devices you're using or
what actually happens. Just speculations ...

PS: The better list for such questions is linux-scsi@vger.kernel.org

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9GbShxmLh6hyYd04RApUpAKCPCxlFaamChzBdpqzjattlZv/nTACZAWy3
E/Uo/PRsFunt4IW/MObgRUc=
=OWki
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--
