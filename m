Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbUC0Jul (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 04:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbUC0Jul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 04:50:41 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:44690 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S261615AbUC0Jug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 04:50:36 -0500
Date: Sat, 27 Mar 2004 01:50:29 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernels 2.6.4 and 2.6.5rc don't handle HAMA USB device correctly
Message-ID: <20040327095029.GA3583@one-eyed-alien.net>
Mail-Followup-To: Andreas Hartmann <andihartmann@freenet.de>,
	linux-kernel@vger.kernel.org
References: <40654BC0.3090902@p3EE060C4.dip0.t-ipconnect.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <40654BC0.3090902@p3EE060C4.dip0.t-ipconnect.de>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Do you have CONFIG_SCSI_MULTI_LUN enabled in 2.6?

What does /proc/bus/usb/devices say about your device?

Matt

On Sat, Mar 27, 2004 at 10:39:12AM +0100, Andreas Hartmann wrote:
> Hello all,
>=20
> I have a USB device from hama, "8 in 1 card reader", USB 2.0. Kernel=20
> 2.4.25 recognizes this device correctly and I can use it:
>=20
> Mar 27 10:23:54 athlon kernel: hub.c: new USB device 00:10.1-1, assigned=
=20
> address 2
> Mar 27 10:23:55 athlon kernel: scsi0 : SCSI emulation for USB Mass Storag=
e=20
> devices
> Mar 27 10:23:55 athlon kernel:   Vendor: SMSC      Model: 223 U HS-CF=20
>   Rev: 1.95
> Mar 27 10:23:55 athlon kernel:   Type:   Direct-Access=20
>   ANSI SCSI revision: 02
> Mar 27 10:23:55 athlon kernel:   Vendor: SMSC      Model: 223 U HS-MS=20
>   Rev: 1.95
> Mar 27 10:23:55 athlon kernel:   Type:   Direct-Access=20
>   ANSI SCSI revision: 02
> Mar 27 10:23:55 athlon kernel:   Vendor: SMSC      Model: 223 U HS-SM=20
>   Rev: 1.95
> Mar 27 10:23:55 athlon kernel:   Type:   Direct-Access=20
>   ANSI SCSI revision: 02
> Mar 27 10:23:55 athlon kernel:   Vendor: SMSC      Model: 223 U HS-SD/MMC=
=20
>   Rev: 1.95
> Mar 27 10:23:55 athlon kernel:   Type:   Direct-Access=20
>   ANSI SCSI revision: 02
> Mar 27 10:23:55 athlon kernel: WARNING: USB Mass Storage data integrity=
=20
> not assured
> Mar 27 10:23:55 athlon kernel: USB Mass Storage device found at 2
>=20
> These are the modules, I'm using in 2.4.25:
> usb-storage            26384   0
> scsi_mod               87328   2  [sd_mod usb-storage]
> uhci                   25436   0  (unused)
> usbcore                62252   0  [usb-storage uhci]
>=20
>=20
>=20
> Kernel 2.6.4 or 5rc2 doesn't handle the device correctly:
>=20
> Mar 27 09:52:02 athlon kernel: usb 2-1: new full speed USB device using=
=20
> address 8
> Mar 27 09:52:02 athlon kernel: scsi6 : SCSI emulation for USB Mass Storag=
e=20
> devices
> Mar 27 09:52:02 athlon kernel:   Vendor: SMSC      Model: 223 U HS-CF=20
>   Rev: 1.95
> Mar 27 09:52:02 athlon kernel:   Type:   Direct-Access=20
>   ANSI SCSI revision: 02
> Mar 27 09:52:02 athlon kernel: Attached scsi removable disk sda at scsi6,=
=20
> channel 0, id 0, lun 0
> Mar 27 09:52:02 athlon kernel: WARNING: USB Mass Storage data integrity=
=20
> not assured
> Mar 27 09:52:02 athlon kernel: USB Mass Storage device found at 8
>=20
> I tried to mount it with /dev/sda[1-8], but I always got the answer, that=
=20
> there would be no media - but this is definitely wrong. Kernel 2.4.25=20
> finds the media and handles it correctly.
>=20
>=20
>=20
> Kind regards,
> Andreas Hartmann
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

You were using cheat codes too.  You guys suck.
					-- Greg to General Studebaker
User Friendly, 12/16/1997

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAZU5lIjReC7bSPZARAveLAJ9P8nbhDih5pkdjdshM7NmtXTH/WgCcCRDn
azqLFLS+UH4T52ociobg7DE=
=JYHh
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
