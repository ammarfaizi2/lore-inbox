Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264453AbTGBTYw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 15:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbTGBTYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 15:24:52 -0400
Received: from 24-216-225-11.charter.com ([24.216.225.11]:53895 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S264453AbTGBTYn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 15:24:43 -0400
Date: Wed, 2 Jul 2003 15:39:03 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Douglas Gilbert <dgilbert@interlog.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: removing a single device?
Message-ID: <20030702193903.GA6600@rdlg.net>
Mail-Followup-To: Douglas Gilbert <dgilbert@interlog.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3EBC43CC.3090808@interlog.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <3EBC43CC.3090808@interlog.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Just had it hit me again.

# cat /proc/scsi/scsi=20
Attached devices:=20
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST318404LC       Rev: 0006
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SEAGATE  Model: ST318404LC       Rev: 0006
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: SEAGATE  Model: ST318404LC       Rev: 0006
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: SEAGATE  Model: ST318404LC       Rev: 0006
  Type:   Direct-Access                    ANSI SCSI revision: 03
# echo "scsi remove-single-device 0 0 2 0" > /proc/scsi/scsi
# cat /proc/scsi/scsi=20
Attached devices:=20
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST318404LC       Rev: 0006
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SEAGATE  Model: ST318404LC       Rev: 0006
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: SEAGATE  Model: ST318404LC       Rev: 0006
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: SEAGATE  Model: ST318404LC       Rev: 0006
  Type:   Direct-Access                    ANSI SCSI revision: 03


  Kernel is 2.4.16.  Unfortunately I didn't build the kernel so I don't
know what options it was compiled with.  Is it possible the previous
admin left out a piece needed to enable this?

Thus spake Douglas Gilbert (dgilbert@interlog.com):

> Robert L. Harris wrote:
> > A long time ago I used to be able to do:
> >
> > echo "scsi add-single-device 0 0 11 0" > /proc/scsi/scsi
> > echo "scsi remove-single-device 0 0 11 0" > /proc/scsi/scsi
> >
> > When I wanted to unplug a SCA scsi drive for replacement.  I tried this
> > recently on my 2.4.20 kernel and nothing happened.  No errors, no change
> > to /proc/scsi/scsi, no entry in dmsg, it just ignored it.  Has this been
> > deprecated for a new way of removing hotswap drives?
>=20
> Robert,
> It is not deprecated (and is still present in the lk 2.5
> development series since we still have no other way of
> doing this from the user space).
>=20
> The parsing of that expression is very rigid: no tabs
> or redundant spaces.
>=20
> Doug Gilbert

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/AzTX8+1vMONE2jsRAhNgAJ0RxNKvltWX+S+exFgC/Bo/zCoCNACgtaEO
7odgtoecseUYHzpgzIkUQ/I=
=2Smr
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
