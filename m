Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262367AbVDLLzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbVDLLzE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVDLLwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:52:06 -0400
Received: from village.ehouse.ru ([193.111.92.18]:17929 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S262365AbVDLLu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 07:50:29 -0400
Message-ID: <425BBB77.9000509@dev.ehouse.ru>
Date: Tue, 12 Apr 2005 16:13:43 +0400
From: Ihalainen Nickolay <ihanic@dev.ehouse.ru>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050304)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Scott_Kilau@digi.com
CC: admin@list.net.ru, linux-kernel@vger.kernel.org
Subject: Digi Neo 8: linux-2.6.12_r2  jsm driver
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

