Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTKLCPZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 21:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbTKLCPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 21:15:24 -0500
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:3845 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S261309AbTKLCPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 21:15:19 -0500
Date: Tue, 11 Nov 2003 18:15:16 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: jim beam <jim_jim33@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB mass storage device problem
Message-ID: <20031111181516.D22248@one-eyed-alien.net>
Mail-Followup-To: jim beam <jim_jim33@hotmail.com>,
	linux-kernel@vger.kernel.org
References: <BAY8-F125ED2QfgNy3T000559e2@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <BAY8-F125ED2QfgNy3T000559e2@hotmail.com>; from jim_jim33@hotmail.com on Wed, Nov 12, 2003 at 02:03:03AM +0000
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

You're talking to the first (and wrong) LUN of a multi-LUN device.

You can:
	(1) Use a SCSI module option to set the number of LUNs higher
	(2) Do an echo "scsi add-single-device 0 0 0 1" > /proc/scsi/scsi

Matt

On Wed, Nov 12, 2003 at 02:03:03AM +0000, jim beam wrote:
> Hello,
>=20
> I am attempting to get a CompactFlash reader to work (Soyo SB-K7VXBP).  T=
he=20
> device sits in a 3.5" bay and plugs directly into a USB1 connector on my=
=20
> motherboard.  It also provides two USB ports, which work.
>=20
> The CompactFlash reader almost works.  At bootup, I get this message:
>=20
> hub 3-0:1.0: new USB device on port 1, assigned address 2
> scsi0 : SCSI emulation for USB Mass Storage devices
>   Vendor: SOYO      Model: USB Storage-SMC   Rev: 0214
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
> WARNING: USB Mass Storage data integrity not assured
> USB Mass Storage device found at 2
>=20
> The device shows up in /sys/block/sda and in=20
> /sys/bus/usb/drivers/usb-storage.  Also, /dev/sda is created as a symlink=
 to=20
> /dev/scsi/host0/bus0/target0/lun0/disc (I am using devfs).
>=20
> However, when try to mount /dev/sda, I get an error saying "No medium=20
> found".  I have tried inserting the card after booting and also before=20
> booting, with the same result.  I am using the 2.6.0-test9 kernel, but I=
=20
> have had this device since early 2.4 and it has never worked.  It is not=
=20
> damaged hardware because Windows detects it as a drive.
>=20
> Trying to run fdisk on /dev/sda gives the message "Unable to open /dev/sd=
a".=20
>   Is there something else I need to do, or any more information I can=20
> provide to debug this problem?
>=20
> Thanks,
> Jim
>=20
> _________________________________________________________________
> Is your computer infected with a virus?  Find out with a FREE computer vi=
rus=20
> scan from McAfee.  Take the FreeScan now!=20
> http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3D3963
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It's monday.  It must be monday.
					-- Greg
User Friendly, 5/4/1998

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/sZezIjReC7bSPZARAvg9AJ99PoaLCQDARg2XQFd0RBsR3sFspACglk08
B+r4FzrkmM7USez9L4VrvWQ=
=rAXS
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--
