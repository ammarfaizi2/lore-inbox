Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbTLPWxT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 17:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264142AbTLPWxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 17:53:19 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:19594 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S264134AbTLPWxQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 17:53:16 -0500
Subject: 2.6.0-test11-bk{9,11,12} (possibly bk0) breaks k3b device scanning
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LcxaDlQg5uHiOSEV0Jba"
Message-Id: <1071615313.5067.7.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Dec 2003 00:55:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LcxaDlQg5uHiOSEV0Jba
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi

Have not been able to test much kernels lately due to time issues,
but trying to run k3b with above kernels give below issue.  test9
kernels that I still have around seems fine though.

Error:

--
# k3b
QPixmap: Cannot create a QPixmap when no GUI is being used
QPixmap: Cannot create a QPixmap when no GUI is being used
QPixmap: Cannot create a QPixmap when no GUI is being used
QPixmap: Cannot create a QPixmap when no GUI is being used
kbuildsycoca running...
ERROR: (K3bCdDevice) Unable to do inquiry.
ERROR: (K3bCdDevice) Unable to do inquiry.
--

Which results in no devices being detected (using ATAPI interface).
If i run cdrecord though, it seems to work ok:

--
[?]
[?]
scsidev: '/dev/hdb'
devname: '/dev/hdb'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.7'
Device type    : Removable CD-ROM
Version        : 0
Response Format: 1
Vendor_info    : 'ASUS    '
Identifikation : 'CRW-2410A       '
Revision       : '1.0 '
Device seems to be: Generic mmc CD-RW.
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P
RAW/R96R
--

Suggestions to what patch to try and back out?


Thanks,

--=20
Martin Schlemmer

--=-LcxaDlQg5uHiOSEV0Jba
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/341RqburzKaJYLYRAlDqAKCBS/aOKNvAWQy6ZclZ42ZttlLHuQCcDf0J
9+VbyrBL6CcWAkQqEBtp2TA=
=XXGm
-----END PGP SIGNATURE-----

--=-LcxaDlQg5uHiOSEV0Jba--

