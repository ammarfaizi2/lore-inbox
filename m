Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTKCN53 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 08:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbTKCN53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 08:57:29 -0500
Received: from 24-216-47-96.charter.com ([24.216.47.96]:37015 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S261801AbTKCN51
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 08:57:27 -0500
Date: Mon, 3 Nov 2003 08:57:25 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Unresolved symbols?
Message-ID: <20031103135725.GC29841@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



I just compiled a stripped down kernel used for installs and I'm getting
this:

depmod: *** Unresolved symbols in
/lib/modules/2.4.22-bk45/kernel/drivers/ide/ide-core.o
depmod:         ide_wait_hwif_ready
depmod:         ide_probe_for_drive
depmod:         ide_probe_reset
depmod:         ide_tune_drives
make: *** [_modinst_post] Error 1

I know I had to have left out a driver I need but I can't figure out
which one. =20

root@cvs.acs:/usr/src/kernels/2.4.22/# grep IDE .config
# ATA/IDE/MFM/RLL support
CONFIG_IDE=3Dm
# IDE, ATA and ATAPI Block devices
CONFIG_BLK_DEV_IDE=3Dm
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=3Dm
CONFIG_IDEDISK_MULTI_MODE=3Dy
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=3Dm
CONFIG_BLK_DEV_IDETAPE=3Dm
CONFIG_BLK_DEV_IDEFLOPPY=3Dm
CONFIG_BLK_DEV_IDESCSI=3Dm
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=3Dy
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=3Dy
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_AMD74XX_OVERRIDE=3Dy
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=3Dy
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_IDE_MODES=3Dy



:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/pl7F8+1vMONE2jsRAih1AKCOyeB2IeCioB49kCQrkdL+V0zbeQCgzTlm
6xomqAOEM0ky5ejXqQXKA5Q=
=viiY
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--
