Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315162AbSGEBjd>; Thu, 4 Jul 2002 21:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315182AbSGEBjc>; Thu, 4 Jul 2002 21:39:32 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:7955 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S315162AbSGEBjb>; Thu, 4 Jul 2002 21:39:31 -0400
Date: Thu, 4 Jul 2002 18:41:59 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: LaCie USB hard drive fails to work on Linux/Pmac
Message-ID: <20020704184159.M17360@one-eyed-alien.net>
Mail-Followup-To: Bastien Nocera <hadess@hadess.net>,
	LKML <linux-kernel@vger.kernel.org>
References: <1025832594.31953.97.camel@dozo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="HVCoas+krw6dou6l"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1025832594.31953.97.camel@dozo>; from hadess@hadess.net on Fri, Jul 05, 2002 at 02:29:53AM +0100
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HVCoas+krw6dou6l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Only some of the LaCie units work.  They have indicated to me that they
changed the internals of the unit without changing the PID, VID, or
revision data.  There is no way to tell, as far as I know, what type of
unit you have.

Matt

On Fri, Jul 05, 2002 at 02:29:53AM +0100, Bastien Nocera wrote:
> Hi,
>=20
> I've posted this a couple of times already to linuxppc-dev and to the
> linux-usb devel list, without any results.
>=20
> Here are the details:
> tested with iBook dual-USB 2001 (500 MHz) and iMac g3 400 (summer 2000)
> kernels ranging from 2.4.7 to 2.4.19-pre10
>=20
> LaCie USB 20G hard-drive, 0x59f/0xa601 ID (it's in the unusual_devs.h)
> Some people got it to work it seems:
> http://www.qbik.ch/usb/devices/showdev.php?id=3D68
>=20
> Here's the log when I plug the device in:
> Jun 18 21:04:26 dozo kernel: hub.c: USB new device connect on bus1/1,
> assigned device number 2
> Jun 18 21:04:26 dozo kernel: usb.c: USB device 2 (vend/prod
> 0x59f/0xa601) is not claimed by any active driver.
> Jun 18 21:04:27 dozo kernel: Initializing USB Mass Storage driver...
> Jun 18 21:04:27 dozo kernel: usb.c: registered new driver usb-storage
> Jun 18 21:04:30 dozo kernel: usb_control/bulk_msg: timeout
> Jun 18 21:04:33 dozo kernel: usb_control/bulk_msg: timeout
> Jun 18 21:04:33 dozo kernel: scsi0 : SCSI emulation for USB Mass Storage
> devicesJun 18 21:04:44 dozo kernel: usb_control/bulk_msg: timeout
>=20
> and the debug messages from the usb-storage module:
> Initializing USB Mass Storage driver...
> usb.c: registered new driver usb-storage
> USB Mass Storage support registered.
> hub.c: USB new device connect on bus1/1, assigned device number 3
> usb-storage: act_altsettting is 0
> usb-storage: id_index calculated to be: 32
> usb-storage: Array length appears to be: 86
> usb-storage: Vendor: LaCie
> usb-storage: Product: USB Hard Disk
> usb-storage: USB Mass Storage device detected
> usb-storage: Endpoints: In: 0xc8cc34a0 Out: 0xc8cc34b4 Int: 0xc8cc34c8
> (Period 100)
> usb_control/bulk_msg: timeout
> usb.c: error getting string descriptor 0 (error=3D-110)
> usb_control/bulk_msg: timeout
> usb.c: error getting string descriptor 0 (error=3D-110)
> usb-storage: New GUID 059fa6010000000000000000
> usb-storage: Transport: Control/Bulk
> usb-storage: Protocol: Reduced Block Commands (RBC)
> usb-storage: *** thread sleeping.
> scsi0 : SCSI emulation for USB Mass Storage devices
> usb-storage: queuecommand() called
> usb-storage: *** thread awakened.
> usb-storage: Command INQUIRY (6 bytes)
> usb-storage: 12 00 00 00 ff 00 00 00 00 00 00 01
> usb-storage: command_abort() called
> usb-storage: Call to usb_stor_control_msg() returned -104
> usb-storage: -- transport indicates error, resetting
> usb-storage: CB_reset() called
> usb_control/bulk_msg: timeout
> usb-storage: CB[I] soft reset failed -110
> usb-storage: scsi cmd done, result=3D0x70000
> usb-storage: *** thread sleeping.
> usb-storage: usb_stor_exit() called
> usb-storage: -- calling usb_deregister()
> usb.c: deregistering driver usb-storage
>=20
> This is plugging and unplugging the device. The usb-storage module is
> removable. But the socket it was plugged in is unusable, I have to
> reboot to be able to use it again.
>=20
> Did anybody got this drive to work on an OHCI controller or even better,
> on a PPC ?
>=20
> Cheers
>=20
> PS: CC me as I'm not on the list.
> --=20
> /Bastien Nocera
> http://hadess.net



--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

We can customize our colonels.
					-- Tux
User Friendly, 12/1/1998

--HVCoas+krw6dou6l
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9JPlnIjReC7bSPZARAquRAKCYrtDRozv5XGOiTQ4+roUtBCo2CwCgmnEE
quNOqUvX5F1DgyL8/jd11GU=
=fNbf
-----END PGP SIGNATURE-----

--HVCoas+krw6dou6l--
