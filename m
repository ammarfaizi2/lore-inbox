Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315120AbSGEB1L>; Thu, 4 Jul 2002 21:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315162AbSGEB1K>; Thu, 4 Jul 2002 21:27:10 -0400
Received: from pc3-guil4-0-cust133.gfd.cable.ntl.com ([80.4.26.133]:55719 "EHLO
	dozo.hadess.net") by vger.kernel.org with ESMTP id <S315120AbSGEB1J>;
	Thu, 4 Jul 2002 21:27:09 -0400
Subject: LaCie USB hard drive fails to work on Linux/Pmac
From: Bastien Nocera <hadess@hadess.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-wQK5r4Wg5icJ83Gg7dXX"
X-Mailer: Ximian Evolution 1.0.7 
Date: 05 Jul 2002 02:29:53 +0100
Message-Id: <1025832594.31953.97.camel@dozo>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wQK5r4Wg5icJ83Gg7dXX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I've posted this a couple of times already to linuxppc-dev and to the
linux-usb devel list, without any results.

Here are the details:
tested with iBook dual-USB 2001 (500 MHz) and iMac g3 400 (summer 2000)
kernels ranging from 2.4.7 to 2.4.19-pre10

LaCie USB 20G hard-drive, 0x59f/0xa601 ID (it's in the unusual_devs.h)
Some people got it to work it seems:
http://www.qbik.ch/usb/devices/showdev.php?id=3D68

Here's the log when I plug the device in:
Jun 18 21:04:26 dozo kernel: hub.c: USB new device connect on bus1/1,
assigned device number 2
Jun 18 21:04:26 dozo kernel: usb.c: USB device 2 (vend/prod
0x59f/0xa601) is not claimed by any active driver.
Jun 18 21:04:27 dozo kernel: Initializing USB Mass Storage driver...
Jun 18 21:04:27 dozo kernel: usb.c: registered new driver usb-storage
Jun 18 21:04:30 dozo kernel: usb_control/bulk_msg: timeout
Jun 18 21:04:33 dozo kernel: usb_control/bulk_msg: timeout
Jun 18 21:04:33 dozo kernel: scsi0 : SCSI emulation for USB Mass Storage
devicesJun 18 21:04:44 dozo kernel: usb_control/bulk_msg: timeout

and the debug messages from the usb-storage module:
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
hub.c: USB new device connect on bus1/1, assigned device number 3
usb-storage: act_altsettting is 0
usb-storage: id_index calculated to be: 32
usb-storage: Array length appears to be: 86
usb-storage: Vendor: LaCie
usb-storage: Product: USB Hard Disk
usb-storage: USB Mass Storage device detected
usb-storage: Endpoints: In: 0xc8cc34a0 Out: 0xc8cc34b4 Int: 0xc8cc34c8
(Period 100)
usb_control/bulk_msg: timeout
usb.c: error getting string descriptor 0 (error=3D-110)
usb_control/bulk_msg: timeout
usb.c: error getting string descriptor 0 (error=3D-110)
usb-storage: New GUID 059fa6010000000000000000
usb-storage: Transport: Control/Bulk
usb-storage: Protocol: Reduced Block Commands (RBC)
usb-storage: *** thread sleeping.
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage: 12 00 00 00 ff 00 00 00 00 00 00 01
usb-storage: command_abort() called
usb-storage: Call to usb_stor_control_msg() returned -104
usb-storage: -- transport indicates error, resetting
usb-storage: CB_reset() called
usb_control/bulk_msg: timeout
usb-storage: CB[I] soft reset failed -110
usb-storage: scsi cmd done, result=3D0x70000
usb-storage: *** thread sleeping.
usb-storage: usb_stor_exit() called
usb-storage: -- calling usb_deregister()
usb.c: deregistering driver usb-storage

This is plugging and unplugging the device. The usb-storage module is
removable. But the socket it was plugged in is unusable, I have to
reboot to be able to use it again.

Did anybody got this drive to work on an OHCI controller or even better,
on a PPC ?

Cheers

PS: CC me as I'm not on the list.
--=20
/Bastien Nocera
http://hadess.net

--=-wQK5r4Wg5icJ83Gg7dXX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9JPaRJ4ZuIYMGqDYRAs+LAJ0QabmsWNdKMTOtS8n7imu3R4x/bQCeJaYk
R3M2Cj93jvnnIHrW4enD2eQ=
=j33L
-----END PGP SIGNATURE-----

--=-wQK5r4Wg5icJ83Gg7dXX--

