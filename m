Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbSKJEUn>; Sat, 9 Nov 2002 23:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264740AbSKJEUn>; Sat, 9 Nov 2002 23:20:43 -0500
Received: from [68.96.149.130] ([68.96.149.130]:27810 "EHLO resonant.org")
	by vger.kernel.org with ESMTP id <S264739AbSKJEUm>;
	Sat, 9 Nov 2002 23:20:42 -0500
Date: Sat, 9 Nov 2002 22:27:26 -0600
From: Zed Pobre <zed@resonant.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [2.4.20-rc1, 2.5.46] Network timeouts, ACPI-related
Message-ID: <20021110042726.GA12831@resonant.org>
Mail-Followup-To: Zed Pobre <zed@resonant.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-No-Archive: Yes
X-GPG-Fingerprint: FF 75 8D 70 57 8D A4 7D  3A DE 6D 2F 25 C3 E6 E7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The specific card in question is a 3com 3c905c-tx-m, but the
motherboard (a Soyo KT400 Dragon Ultra) also has a via-rhine on-board
interface that behaves the same way.  I can reproduce this on 2.4.18,
2.4.19, 2.4.20-rc1, 2.5.44, 2.5.45, and 2.5.46, with the following
exception: if ACPI is turned on in the 2.5.x kernels (completely on --
if CPU enumeration only is used, the behaviour is the same as if ACPI
is turned off), the network starts working fine again, but USB (using
uhci-hcd) stops working (rather completely -- I have a USB hub that
has an LED to show whether or not it is powered, and it actually shuts
off if ACPI is turned on).  The various sub-options of ACPI seem to
have no effect.  It does not matter whether the driver is compiled as
a module, or compiled into the kernel.

The following is left in the logs, repeating once per minute or so:

Nov  7 17:03:23 singularity kernel: NETDEV WATCHDOG: eth0: transmit timed o=
ut
Nov  7 17:03:23 singularity kernel: eth0: transmit timed out, tx_status 00 =
status e601.
Nov  7 17:03:23 singularity kernel:   diagnostics: net 0ccc media 88c0 dma =
0000003a fifo 8000
Nov  7 17:03:23 singularity kernel: eth0: Interrupt posted but not delivere=
d -- IRQ blocked by another device?
Nov  7 17:03:23 singularity kernel:   Flags; bus-master 1, dirty 3728(0) cu=
rrent 3728(0)
Nov  7 17:03:23 singularity kernel:   Transmit list 00000000 vs. f5fcb200.
Nov  7 17:03:23 singularity kernel:   0: @f5fcb200  length 800000b9 status =
000100b9
Nov  7 17:03:23 singularity kernel:   1: @f5fcb240  length 800000b9 status =
000100b9
Nov  7 17:03:23 singularity kernel:   2: @f5fcb280  length 800000b9 status =
000100b9
Nov  7 17:03:23 singularity kernel:   3: @f5fcb2c0  length 80000079 status =
00010079
Nov  7 17:03:23 singularity kernel:   4: @f5fcb300  length 800000a2 status =
000100a2
Nov  7 17:03:23 singularity kernel:   5: @f5fcb340  length 80000079 status =
00010079
Nov  7 17:03:23 singularity kernel:   6: @f5fcb380  length 80000050 status =
00010050
Nov  7 17:03:23 singularity kernel:   7: @f5fcb3c0  length 8000002a status =
0001002a
Nov  7 17:03:23 singularity kernel:   8: @f5fcb400  length 80000050 status =
00010050
Nov  7 17:03:23 singularity kernel:   9: @f5fcb440  length 8000002a status =
0001002a
Nov  7 17:03:23 singularity kernel:   10: @f5fcb480  length 8000002a status=
 0001002a
Nov  7 17:03:23 singularity kernel:   11: @f5fcb4c0  length 8000002a status=
 0001002a
Nov  7 17:03:23 singularity kernel:   12: @f5fcb500  length 8000002a status=
 0001002a
Nov  7 17:03:23 singularity kernel:   13: @f5fcb540  length 8000002a status=
 0001002a
Nov  7 17:03:23 singularity kernel:   14: @f5fcb580  length 80000050 status=
 80010050
Nov  7 17:03:23 singularity kernel:   15: @f5fcb5c0  length 8000002a status=
 8001002a
Nov  7 17:03:23 singularity kernel: eth0: Resetting the Tx ring pointer.


Please let me know if there is anything else useful I can provide or
do.

--=20
Zed Pobre <zed@debian.org> a.k.a. Zed Pobre <zed@resonant.org>
PGP key and fingerprint available on finger; encrypted mail welcomed.

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iQEVAwUBPc3gLh0207zoJUw5AQHRDwgAuom2JZ0a4L60H+inhnXJfc6fxK6wnRsV
Lpqf0BU6MqAXRNomyyAgd9zfp6eDXCItuEq2irPUL7dwAD/NcLCNooAbu1B4c1xe
gBEwHgsl9FU5aC1zpmqfDQISeCD2fNbPPTzPHLMUKYpqN3ToRv9p+7gmBPm+iGIq
M7arQ0lnZeTFs6zc4Tirx4hCHUPTHxEpF7kctfAraftI6cW1MP0c0Uwhvj3dMHYm
ZytE8eWTgvT4kpYGchv8a8GwIyAb3NA8qnbtwsmK4wUST6h3QhejJmcKzvdVYcAs
3QquBP35e8yfvjyagQCje0nwhfNFbQqlKQIH/ReijHjLVFhG9Ic67Q==
=zHLl
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
