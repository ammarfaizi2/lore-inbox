Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131535AbQLVCNX>; Thu, 21 Dec 2000 21:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131571AbQLVCNN>; Thu, 21 Dec 2000 21:13:13 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:57870 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S131535AbQLVCNK>; Thu, 21 Dec 2000 21:13:10 -0500
Date: Fri, 22 Dec 2000 02:30:53 +0100
From: Kurt Garloff <garloff@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Willem Riede <osst@riede.org>, Kai Makisara <Kai.Makisara@metla.fi>,
        linux-kernel@vger.kernel.org
Subject: osst driver for 2.4.0
Message-ID: <20001222023053.M7400@garloff.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="GvuyDaC2GNSBQusT"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvuyDaC2GNSBQusT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

I'd like to ask you to include the osst driver into the next 2.4 kernels.
The osst driver is a new SCSI high-level driver, able to drive the OnStream
SC-x0, DI-x0 and USBx0 tape driver, offering a st interface to the userspac=
e.
The reason for its existance is, that those OnStream devs are different
from the SCSI-2 spec for SASDs (QIC157), but rather provide a QIC172 like
interface.
Unlike ide-tape, which includes a driver for the DI-30, after some
discussion with Kai Makisara (st maintainer), we decided to not add
lots of if (ST->onstream); to the code but to create a new driver,
which was based on st, of course. Most work has been done by Willem Riede,
BTW, who will also function as maintainer.=20

See http://linux1.onstream.nl/

The thing has proven very stable during the beta test since April, so we
believe it's time for integration into the mainstrean kernel.

Alan just accepted the driver into 2.2.19pre1 and we'd like to have the
driver in 2.4 as well.

And no, there's no risk, otherwise I wouldn't dare to send it to you
at this time.
The only change to existing code is just preventing the st driver from
attempting to drive those OnStream devices.=20
The code for this is by Kai and has already been merged into the kernel ...

So, please consider applying the patch against 2.4.0-test13-pre3, which
I send to you in private mail.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--GvuyDaC2GNSBQusT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6Qq7NxmLh6hyYd04RAsNdAKDI2j1+lV5j+FBtTf+P5FDkmSdy0ACfTNAF
SXXbvkUY9OImp+0UJ0sA5NY=
=gwVF
-----END PGP SIGNATURE-----

--GvuyDaC2GNSBQusT--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
