Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbVAQRRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbVAQRRt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 12:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbVAQRRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 12:17:49 -0500
Received: from hostmaster.org ([212.186.110.32]:36304 "EHLO hostmaster.org")
	by vger.kernel.org with ESMTP id S262294AbVAQRRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 12:17:33 -0500
Subject: usb-storage on SMP?
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/d7/8/ZpWTZNUjFb95HV"
Date: Mon, 17 Jan 2005 18:17:27 +0100
Message-Id: <1105982247.21895.26.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/d7/8/ZpWTZNUjFb95HV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

can anyone confirm that writing to usb-storage devices is working on SMP
systems? Especially to a SD Card in an USB 1.1 card reader attached to a
64-bit Dual Opteron with NUMA enabled?

I have a noname USB 1.1 card reader that identifies itself as 0dda:0001
'Integrated Circuit Solution, Inc.' attached to a Tyan Thunder K8W
(S2885) dual Opteron NUMA system. After copying data to the disk, the
activity light flashes for some time and the following messages appear
in syslog:

2005-01-15 13:41:39 +0100 kernel: ohci_hcd 0000:03:00.1: urb 0000010068400d=
40 path 1 ep2out 6fce0000 cc 6 --> status -71
2005-01-15 13:42:59 +0100 kernel: ohci_hcd 0000:03:00.1: GetStatus roothub.=
portstatus [0] =3D 0x00100103 PRSC PPS PES CCS
2005-01-15 13:42:59 +0100 kernel: usb 2-1: reset full speed USB device usin=
g ohci_hcd and address 10
2005-01-15 13:42:59 +0100 kernel: ohci_hcd 0000:03:00.1: GetStatus roothub.=
portstatus [0] =3D 0x00100103 PRSC PPS PES CCS
2005-01-15 13:42:59 +0100 kernel: usb 2-1: ep0 maxpacket =3D 8
2005-01-15 13:42:59 +0100 kernel: usb 2-1: manual set_interface for iface 0=
, alt 0
2005-01-15 13:43:15 +0100 kernel: scsi: Device offlined - not ready after e=
rror recovery: host 7 channel 0 id 0 lun 2
2005-01-15 13:43:15 +0100 kernel: SCSI error : <7 0 0 2> return code =3D 0x=
50000
2005-01-15 13:43:15 +0100 kernel: end_request: I/O error, dev sdc, sector 1=
47093
2005-01-15 13:43:15 +0100 kernel: printk: 310019 messages suppressed.
2005-01-15 13:43:15 +0100 kernel: Buffer I/O error on device sdc, logical b=
lock 147093

The system behaves as expected if I boot the kernel with 'maxcpus=3D1'.

Tom

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
      finger thomasz@hostmaster.org for key

Experience is what you get when you expected something else.




--=-/d7/8/ZpWTZNUjFb95HV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iQEVAwUAQevzJ2D1OYqW/8uJAQJ3JAf9Hxmj0qYriapDOPhPYbCBc2k838XNPKJf
nIe93390IF47+J93h5ki3pnDm1RApCkEmPzTwCHfau2B0PtM9cubzBKB+i5GCoTs
BK7Qohe3icIRKlYjwpGE+xLt0hGLeanNNBiFFsTS9OgNB4OBKbuprXDGEyh5VUKY
L4Do53Rfw/Kr/5wpfa4M7JzQ6NJZWrqBLxX6hKCNo+RlhzJ4qD+Hsrs//4a/Pspo
/2oFn3Hj8vrOXX7kGvURxWd9D6tPeAJPYlPzE0/JCN1+Mj/kPmykSTEw7AmGi7Lq
ri5KCvCzbHAlRKpdvCHh24O34usjznoLGIxAS7eKntw+pobEYxL9FQ==
=qLov
-----END PGP SIGNATURE-----

--=-/d7/8/ZpWTZNUjFb95HV--

