Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbUKHDdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbUKHDdr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 22:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbUKHDdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 22:33:46 -0500
Received: from 80-26-154-28.adsl.nuria.telefonica-data.net ([80.26.154.28]:13572
	"EHLO debbie") by vger.kernel.org with ESMTP id S261738AbUKHDdl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 22:33:41 -0500
Date: Mon, 8 Nov 2004 04:41:38 +0100
From: Ramses Rodriguez Martinez <harpago@terra.es>
To: linux-kernel@vger.kernel.org
Subject: usb-storage: support for Konica Revio camera broken since 2.6.8
Message-ID: <20041108034138.GA968@debbie>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
i noticed usb-storage support for Konica DIMAGE was broken since 2.6.8, and
that some patch fixed the problem for 2.6.9.

But it seems this patch is not valid for my Konica Revio KD-3300, as it
still refuses to mount (and it worked with 2.6.7):

debbie:/ramses# mount /mnt/camara/
mount: wrong fs type, bad option, bad superblock on /dev/sda1,
       or too many mounted file systems

---------------------

KERNEL CONFIG: (the same as 2.6.7)

debbie:/usr/src# cat /boot/config-2.6.9 |grep -v "#"|grep "USB"
CONFIG_USB=3Dm
CONFIG_USB_DEVICEFS=3Dy
CONFIG_USB_BANDWIDTH=3Dy
CONFIG_USB_UHCI_HCD=3Dm
CONFIG_USB_STORAGE=3Dm
CONFIG_USB_STORAGE_DEBUG=3Dy
CONFIG_USB_STORAGE_DATAFAB=3Dy
CONFIG_USB_STORAGE_FREECOM=3Dy
CONFIG_USB_STORAGE_ISD200=3Dy
CONFIG_USB_STORAGE_DPCM=3Dy
CONFIG_USB_STORAGE_HP8200e=3Dy
CONFIG_USB_STORAGE_SDDR09=3Dy
CONFIG_USB_STORAGE_SDDR55=3Dy
CONFIG_USB_STORAGE_JUMPSHOT=3Dy

--------------------------------

debbie:/usr/src# cat /proc/bus/usb/devices

T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  3 Spd=3D12  MxC=
h=3D 0
D:  Ver=3D 1.10 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D04c8 ProdID=3D072a Rev=3D 0.00
S:  Manufacturer=3DUSB
S:  Product=3DDIGITAL CAMERA
S:  SerialNumber=3DDSC 2003
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3D08(stor.) Sub=3D05 Prot=3D50 Driver=
=3Dusb-storage
E:  Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D01(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms

----------------------------------

Please Cc me if you need more information, as i'm not susbribed.

Thank you.


--
--=20
"Be careful, because you, cute, are a bug too!". Irene Fernandez.
---
RAMSES
harpago@terra.es
---
Clave PGP en: http://pgp.rediris.es:11371/pks/lookup?op=3Dget&search=3D0xD1=
AF6D7E
MSN: harpagokafka@hotmail.com
Jabber: harpago@jabber.at
---
---


--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBjuryxk91vNGvbX4RAmyDAKCl+CmzsLXmvDdf9FYxw1I9K+JtdwCeI8EJ
NuuT3SumWGZgAsVcmHdDRU0=
=c9bd
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
