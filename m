Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbVI3So2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbVI3So2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 14:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbVI3So2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 14:44:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:58250 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932258AbVI3So1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 14:44:27 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.14-rc2-mm2 (PHY reset until link up)
Date: Fri, 30 Sep 2005 20:49:35 +0200
User-Agent: KMail/1.8.91
Cc: linux-kernel@vger.kernel.org
References: <20050929143732.59d22569.akpm@osdl.org>
In-Reply-To: <20050929143732.59d22569.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1295553.BOe6icmaHn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509302049.45143.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1295553.BOe6icmaHn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 29 September 2005 23:37, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/=
2.
>6.14-rc2-mm2/

hi,
I'm not sure if this bug is in 2.6.14-rc2 too. I get hundreds of these=20
messages:
Sep 30 20:12:28 amd64box eth2: PHY reset until link up
Sep 30 20:12:38 amd64box eth2: PHY reset until link up
Sep 30 20:12:48 amd64box eth2: PHY reset until link up
Sep 30 20:12:58 amd64box eth2: PHY reset until link up

eth2 uses the r8169 driver. _No_ network cable was connected at that moment!
here is lspci output:
0000:00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169=
=20
Gigabit Ethernet (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet
        Flags: 66Mhz, medium devsel, IRQ 217
        I/O ports at b000 [size=3D256]
        Memory at fde00000 (32-bit, non-prefetchable) [size=3D256]
        Expansion ROM at fdd00000 [disabled] [size=3D128K]
        Capabilities: [dc] Power Management version 2

and dmesg:
r8169 Gigabit Ethernet driver 2.2LK-NAPI loaded
ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 217
eth2: Identified chip type is 'RTL8169s/8110s'.
eth2: RTL8169 at 0xffffc200009ca000, 00:0c:f6:04:87:c0, IRQ 217
r8169: eth2: link down

hth,
dominik

--nextPart1295553.BOe6icmaHn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)

iQCVAwUAQz2IyQvcoSHvsHMnAQIRxAP+M7wrqaYEFl1ev2lKXI/qt6o2oPSN33y4
HZ2bDT7p+EDvR08vpjHPSFmapThiUFsxAWDGxZIHUJdttzFhWi4Xyl29WNqwxwsp
1cocRGk8ASTIJTHnJ3cx9O5unY1j7jz8vDaKnkiHcM3LlJfd7nmpQMfvDZUl6jBs
g4UzrdW+IwU=
=His/
-----END PGP SIGNATURE-----

--nextPart1295553.BOe6icmaHn--
