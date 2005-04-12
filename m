Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262362AbVDLOIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbVDLOIA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 10:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbVDLOEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 10:04:20 -0400
Received: from mtk-sms-mail01.digi.com ([66.77.174.18]:5851 "EHLO
	mtk-sms-mail01.digi.com") by vger.kernel.org with ESMTP
	id S262362AbVDLOCk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 10:02:40 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Digi Neo 8: linux-2.6.12_r2  jsm driver
Date: Tue, 12 Apr 2005 09:02:42 -0500
Message-ID: <335DD0B75189FB428E5C32680089FB9F038FB8@mtk-sms-mail01.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Digi Neo 8: linux-2.6.12_r2  jsm driver
Thread-Index: AcU/VdJH29a/18JfRACM024wPtje4gAEYwYQ
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "Ihalainen Nickolay" <ihanic@dev.ehouse.ru>
Cc: <admin@list.net.ru>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Not having the 8 port board listed in the JSM driver was actually
intentional.

IBM and Digi only want the 2 port Neo board supported in the JSM driver,
as IBM are only using the 2 port Neo products.

Digi has a different and more fully featured driver for the other port
count boards. (1, 4, 8).

If you would like, I can send you the source tarball of this version of
the driver instead,
its called DGNC, and contains more diagnostics and utilities.

LKML, please, do *NOT* apply this patch to the kernel!
It will cause conflicts if our customers have both the Digi DGNC and
IBM/Digi JSM drivers installed!

Thanks!
Scott Kilau




-----Original Message-----
From: Ihalainen Nickolay [mailto:ihanic@dev.ehouse.ru] 
Sent: Tuesday, April 12, 2005 7:14 AM
To: Kilau, Scott
Cc: admin@list.net.ru; linux-kernel@vger.kernel.org
Subject: Digi Neo 8: linux-2.6.12_r2 jsm driver


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I compile linux-2.6.12_r2 sources with jsm support, but Digi Neo 8 is
unsupported.
after some code-modifications it works fine.

lspci -v
0000:00:09.0 Serial controller: Digi International Digi Neo 8 (rev 02)
(prog-if 02 [16550])
~        Subsystem: Digi International Digi Neo 8
~        Flags: fast devsel, IRQ 16
~        Memory at feb7e000 (32-bit, non-prefetchable)

diff -r linux-2.6.12-rc2/drivers/serial/jsm/jsm_driver.c
linux-2.6.12-rc2-modified/drivers/serial/jsm/jsm_driver.c
62a63
|
67a69
| { PCI_DEVICE (PCI_VENDOR_ID_DIGI,
PCI_DEVICE_NEO_8_DID),        0,      0,      4 },
76a79
| { PCI_DEVICE_NEO_8_DID          ,       8 },
169a173
| case PCI_DEVICE_NEO_8_DID:
diff -r linux-2.6.12-rc2/include/linux/pci_ids.h
linux-2.6.12-rc2-modified/include/linux/pci_ids.h
1532a1533
| #define PCI_DEVICE_NEO_8_DID            0x00B1

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCW7oFHI+uMg2HaCcRAraBAJ9ttNr3kTCIM4ztWk6DuMwwmaMVOgCeO8Rl
N7idPCAnZOIevdD4Wguty9w=
=ZFjm
-----END PGP SIGNATURE-----

