Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318325AbSGRTRX>; Thu, 18 Jul 2002 15:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318326AbSGRTRW>; Thu, 18 Jul 2002 15:17:22 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:18283 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S318325AbSGRTRV>; Thu, 18 Jul 2002 15:17:21 -0400
Date: Thu, 18 Jul 2002 21:20:19 +0200
From: Kurt Garloff <garloff@suse.de>
To: Rudmer van Dijk <rvandijk@science.uva.nl>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc2-ac1
Message-ID: <20020718192019.GB29155@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Rudmer van Dijk <rvandijk@science.uva.nl>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
References: <200207181545.g6IFjgG24953@devserv.devel.redhat.com> <20020718181213Z318284-686+2229@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline
In-Reply-To: <20020718181213Z318284-686+2229@vger.kernel.org>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alan, Rudmer,

On Thu, Jul 18, 2002 at 08:19:59PM +0200, Rudmer van Dijk wrote:
> On Thursday 18 July 2002 17:45, Alan Cox wrote:
> > Linux 2.4.19rc2-ac1
[...]
> > o=A0=A0=A0=A0=A0=A0=A0Clear allocated gendisk in IDE=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(Kurt Garloff)
>=20
> build ok, but panics at boot.
>=20
> panic occured after these messages:
> <snip>
> hda: QUANTUM FIREBALLP AS20.5, ATA DISK drive
> hdc: HL-DT-ST CD-RW GCE-8240B, ATAPI CD/DVD-ROM drive
> hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[...]
> Code: f3 ab 8b 54 24 5c 8b 4c 24 14 31 ff 0f b6 82 34 03 00 00 89
>=20
> >>EIP; c01bf838 <init_gendisk+b8/310>   <=3D=3D=3D=3D=3D

Alan, you should not have moved the memset() down, after the first gendisk
fields have already been filled in.
But I saw you corrected the merging error in -ac2 already.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9NxTzxmLh6hyYd04RAvPoAKCWl33oJFC+P+aCchjjJMx1qjoU+wCfX1Is
4hnUNf3iXaoCpHlUYbB5Uvw=
=DcvM
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
