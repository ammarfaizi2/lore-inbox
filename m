Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267810AbUI1OkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267810AbUI1OkA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 10:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267860AbUI1OfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 10:35:22 -0400
Received: from 60.Red-213-97-200.pooles.rima-tde.net ([213.97.200.60]:45194
	"EHLO marlow.intranet.hisitech.com") by vger.kernel.org with ESMTP
	id S267866AbUI1Oen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 10:34:43 -0400
Message-ID: <41597679.7090406@apache.org>
Date: Tue, 28 Sep 2004 16:34:33 +0200
From: Santiago Gala <sgala@apache.org>
Organization: Apache Software Foundation
User-Agent: Mozilla Thunderbird 0.8 (X11/20040917)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.8-rc2-mm4 does not link (PPC)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

It looks like a trivial error: a structure used in PCI architecture
independent code (quirks.c) gets defined (only) in i386 architecture
(raw_pci_ops). I'm not an expert and cannot help to define this under
ppc arch:

drivers/built-in.o(.text+0x350a): In function `quirk_pcie_aspm_read':
: undefined reference to `raw_pci_ops'
drivers/built-in.o(.text+0x351e): In function `quirk_pcie_aspm_read':
: undefined reference to `raw_pci_ops'
drivers/built-in.o(.text+0x3566): In function `quirk_pcie_aspm_write':
: undefined reference to `raw_pci_ops'
drivers/built-in.o(.text+0x35a6): In function `quirk_pcie_aspm_write':
: undefined reference to `raw_pci_ops'
make: *** [.tmp_vmlinux1] Error 1

I sent a typo for rc2-mm2. Just to report that it never booted after
the typo was corrected. hard freeze.

Regards
Santiago
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBWXZ4ZAeG2a2/nhoRAuGTAJ0RKnoCJ6nE2w2/OIrh1j3a2OwZgACcDWSU
wvvtDnuhiF+jen7KZgWsfrg=
=AHg8
-----END PGP SIGNATURE-----

