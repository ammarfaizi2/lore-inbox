Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316580AbSFPVE1>; Sun, 16 Jun 2002 17:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316579AbSFPVE0>; Sun, 16 Jun 2002 17:04:26 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:2667 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S316576AbSFPVEY>; Sun, 16 Jun 2002 17:04:24 -0400
Date: Sun, 16 Jun 2002 23:04:26 +0200
From: Kurt Garloff <garloff@suse.de>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: /proc/scsi/map
Message-ID: <20020616210426.GC21461@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>, Andries.Brouwer@cwi.nl,
	linux-kernel@vger.kernel.org,
	Linux SCSI list <linux-scsi@vger.kernel.org>
References: <UTC200206151604.g5FG4JQ26968.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline
In-Reply-To: <UTC200206151604.g5FG4JQ26968.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andries,

On Sat, Jun 15, 2002 at 06:04:19PM +0200, Andries Brouwer wrote:
> > How can one assign stable device names to SCSI devices in
> > case there are devices that may or may not be switched on or connected.
>=20
> An interesting unsolved problem.
> [Your discussion confuses a few things, especially in the context
> of removable devices: a uuid lives on the disk, the C,B,T,U tends
> to identify the drive rather than the disk.]

Sure. But those are the things that are normally proposed to relieve the
situation. (And yes, I got the uuid thing confused.)
I actually forgot one. LVM. There, signatures are stored on the disks.

> > Life would be easier if the scsi subsystem would just report which
> > SCSI device (uniquely identified by the controller,bus,target,unit tupl=
e)
> > belongs to which high-level device.
>=20
> Yes. I took your patch, ported it to 2.5, and tried it out.

Oh, I expected to do it myself if it does not get bashed too much ...
THANKS!
And, yes, I agree, I would prefer to know it's accepted in 2.5 before it's
applied to 2.4. It's just that I develop on 2.4 currently :-(

> Very good - in combination with /proc/scsi/scsi this gives
> good information. I like it.
>=20
> But just "cat /proc/scsi/map" is not good enough.

I did not want to duplicate the information from /proc/scsi/scsi. The=20
idea was that it should be straightforward to make device nodes from=20
the information provided in map and to allow more elaborated code in
userspace to know where to collect information from.

> >From the above output alone one cannot easily guess which is which.
> One would need a small utility that reads /proc/scsi/map and
> /proc/scsi/scsi and produces something readable.
> Will add sth to util-linux in case this gets accepted.

That would be great!=20
Because the mapping between sg and the other device is known, you can use
the sg device to do ioctls on it (or even send SCSI commands) or to use
the information from /proc/scsi/sg/ as well.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9DP1ZxmLh6hyYd04RAmy9AJsHx2k6sybkFrevDCKhhcrrBPrAPwCfRcIK
BsYSkXuvir9pEziU4+J4gdY=
=+Kuk
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
