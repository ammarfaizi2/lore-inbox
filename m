Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268229AbUI2Gij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268229AbUI2Gij (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 02:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268230AbUI2Gij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 02:38:39 -0400
Received: from 60.Red-213-97-200.pooles.rima-tde.net ([213.97.200.60]:11659
	"EHLO marlow.intranet.hisitech.com") by vger.kernel.org with ESMTP
	id S268229AbUI2Gih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 02:38:37 -0400
Message-ID: <415A5866.6010708@apache.org>
Date: Wed, 29 Sep 2004 08:38:30 +0200
From: Santiago Gala <sgala@apache.org>
Organization: Apache Software Foundation
User-Agent: Mozilla Thunderbird 0.8 (X11/20040917)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PPC] 2.6.9-rc2-mm4 does not link (resend)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

When I sent it yesterday I put a typo in the subject: it is
2.6.9-rc2-mm4 (not 8).

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


Regards
Santiago
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBWlhmZAeG2a2/nhoRAub3AKCdTTTLfrZwizPbAdsXeTLQDkZK6ACeJU5/
/HrpfcIDz5DsGserW1+Uuwo=
=8QBQ
-----END PGP SIGNATURE-----
