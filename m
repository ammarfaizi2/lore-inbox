Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263097AbTCSRiP>; Wed, 19 Mar 2003 12:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263099AbTCSRiP>; Wed, 19 Mar 2003 12:38:15 -0500
Received: from zeus.eurotux.com ([194.38.142.74]:14732 "HELO zeus.eurotux.com")
	by vger.kernel.org with SMTP id <S263097AbTCSRiK>;
	Wed, 19 Mar 2003 12:38:10 -0500
Subject: pcmcia trouble
From: Ricardo Manuel Oliveira <rmo@eurotux.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-bDvp6K9oqIiWS/PQVeAp"
Organization: Eurotux =?ISO-8859-1?Q?Inform=C3=A1tica,?= SA
Message-Id: <1048096038.4222.4811.camel@linus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 19 Mar 2003 17:47:18 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bDvp6K9oqIiWS/PQVeAp
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

 I'm having a bit of a trouble with the ide pcmcia support in 2.4.20,
although it works perfectly in 2.4.18.

 The trouble is with a 2GB Toshiba PCMCIA disk, which I can use
perfectly in my previous kernel (2.4.18); after I upgraded to
2.4.20+swsusp+acpi+crypto_loop I can't even use the disk.

 Error messages follow:

Mar 19 10:25:04 bofh cardmgr[2258]: starting, version is 3.1.22
Mar 19 10:25:04 bofh cardmgr[2258]: watching 1 sockets
Mar 19 10:25:07 bofh cardmgr[2258]: initializing socket 0
Mar 19 10:25:07 bofh kernel: cs: memory probe 0x0c0000-0x0fffff:
excluding 0xc0000-0xcbfff 0xd8000-0xdbfff 0xe0000-0xfffff
Mar 19 10:25:07 bofh cardmgr[2258]: socket 0: ATA/IDE Fixed Disk
Mar 19 10:25:07 bofh cardmgr[2258]: executing: 'modprobe ide-cs'
Mar 19 10:25:10 bofh kernel: hdc: TOSHIBA MK2001MPL, ATA DISK drive
Mar 19 10:25:10 bofh kernel: hdc: IRQ probe failed (0xa4f8)
Mar 19 10:25:10 bofh kernel: hdd: IRQ probe failed (0xa4f8)
Mar 19 10:25:10 bofh kernel: hdd: IRQ probe failed (0xa4f8)
Mar 19 10:25:10 bofh kernel: ide1: DISABLED, NO IRQ
Mar 19 10:25:12 bofh kernel: hdc: ERROR, PORTS ALREADY IN USE
Mar 19 10:25:14 bofh kernel: ide1: ports already in use, skipping probe
Mar 19 10:25:29 bofh last message repeated 7 times
Mar 19 10:25:29 bofh kernel: ide_cs: ide_register() at 0x100 & 0x10e,
irq 0 failed
Mar 19 10:25:29 bofh kernel: Trying to free nonexistent resource
<00000100-0000010f>
Mar 19 10:25:30 bofh cardmgr[2258]: get dev info on socket 0 failed:
Resource temporarily unavailable

 Strangest thing is: a quick reboot to my old 2.4.18 and it works like a
charm.

 Any changes in the pcmcia/ide-cs code from 2.4.18 to 2.4.20 that could
lead to this problem?


 Thanks,

  Ricardo Oliveira.


--=20
Ricardo Manuel Oliveira <rmo@eurotux.com>
Eurotux Inform=E1tica, SA

--=-bDvp6K9oqIiWS/PQVeAp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iQIXAwUAPnitJaNrMuK8+gb0FAK3Zgf+NrpUMDq3gaoK6Zx1lq5mUf8cyxJ07BDE
ob61Eezp57TFhEGYNzXDbQf8ycrETNX22RAIDW4yU80Yy0ZLHCLcrnMjrFVPVyeW
2dwDHzXSrZAFBBNng8lv9r6b0JC6GeALpUb8pjZuQ6TxXfu2fDemkARl199WRBGu
pQ1QPiqn1xnCy1OKajgQhB3NlnrvB1dFp5sWYFLIg9gozXIdATl0KAr2eW5sq0BT
s4i+jXxkfpNjHzpoFk2QKFhTqvSTxWX1PsvOB//SzQ2XzBIsrX/koLRDDhcKMgV8
47Nk+2ViNupx3yYDB6StNu5YDVXjSjgzJqvCBbq/gqjusMBWDXO1dwgAvdxqsTcq
Y8vMlYHkPsvLDvVO0mkDBt7fopNaDfJE39p6PfK2DKKEzZVLhWkdgZq1kMd6Xn4A
cNZYp8ZCkEPlt9xMX+EWsVpy1Xs8MrPGsXNqjSscL9I+1elu0FWn645P5szEBa1O
AjG4d7/Y4TI32O8O5hGfs3upHodAjW/A6QeJRl/V+JdVHCWMGP4Du3YN70bJLH8p
hRHYeGkHP65QS2SCrS/UWtzlS83NpRwfkYBFLP6+5L9Lg9yK5xLJY6QuEjs57o0C
A7wB4uotHkMtfCXjAy3XuvmgFLszoP5KCJ6obJ1ABWg9WRuyol9bL3qD4e2qYA1F
kBZYhca/LqnFSw==
=/tWl
-----END PGP SIGNATURE-----

--=-bDvp6K9oqIiWS/PQVeAp--

