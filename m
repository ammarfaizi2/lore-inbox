Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbVL3OuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbVL3OuT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 09:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbVL3OuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 09:50:18 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:35304 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932176AbVL3OuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 09:50:17 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: jgarzik@pobox.com
Subject: libata support for JMicron JMB360 ?
Date: Fri, 30 Dec 2005 15:41:31 +0100
User-Agent: KMail/1.9
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1193343.BGzqgVWsVG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200512301541.36483.prakash@punnoor.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cec1af1025af73746bdd9be3587eb485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1193343.BGzqgVWsVG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I read in an old thread that this question was asked once and you replied y=
ou=20
never heard of this chip. Maybe now the situation has changed? If not, plea=
se=20
take a look here:

http://www.jmicron.com/product/jmb360.htm

It claims the chip is ahci compatible, but the libata ahci driver can't det=
ect=20
it (tried 2.6.14.2 and 2.6.15-rc7).

Maybe just adding some ids or such is enough for supporting it?=20
=46ollowing lspci -vvv -xxx regrading the Jmicron stuff:

in IDE compatibility mode (can be set in bios):
0000:03:00.0 IDE interface: JMicron Technologies, Inc. JMicron 20360/20363=
=20
AHCI Controller (prog-if 85 [Master SecO PriO])
	Subsystem: ASRock Incorporation: Unknown device 0360
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-=
=20
<MAbort- >SERR- <PERR-
	Latency: 0, cache line size 10
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at cc00 [size=3D8]
	Region 1: I/O ports at c880 [size=3D4]
	Region 2: I/O ports at c800 [size=3D8]
	Region 3: I/O ports at c480 [size=3D4]
	Region 4: I/O ports at c400 [size=3D16]
	Region 5: Memory at fe8fe000 (32-bit, non-prefetchable) [size=3D8K]
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot+,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [50] #10 [0211]
00: 7b 19 60 23 07 01 10 00 00 85 01 01 10 00 00 00
10: 01 cc 00 00 81 c8 00 00 01 c8 00 00 81 c4 00 00
20: 01 c4 00 00 00 e0 8f fe 00 00 00 00 49 18 60 03
30: 00 00 00 00 68 00 00 00 00 00 00 00 05 01 00 00
40: 11 f1 00 00 00 00 7f f0 30 00 00 0f 00 00 00 00
50: 10 00 11 02 00 00 00 00 00 20 09 00 11 f4 03 01
60: 00 00 11 10 00 00 00 00 01 50 02 40 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: c3 8b 48 00 03 45 02 00 9c 34 3f 00 00 03 09 00
d0: 18 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

diff in sata mode:
=2D0000:03:00.0 IDE interface: JMicron Technologies, Inc. JMicron 20360/203=
63=20
AHCI Controller (prog-if 85 [Master SecO PriO])
+0000:03:00.0 SATA controller: JMicron Technologies, Inc. JMicron 20360/203=
63=20
AHCI Controller (prog-if 01 [AHCI 1.0])
        Subsystem: ASRock Incorporation: Unknown device 0360
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR-
@@ -535,11 +535,11 @@
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [50] #10 [0211]
=2D00: 7b 19 60 23 07 01 10 00 00 85 01 01 10 00 00 00
+00: 7b 19 60 23 07 01 10 00 00 01 06 01 10 00 00 00
 10: 01 cc 00 00 81 c8 00 00 01 c8 00 00 81 c4 00 00
 20: 01 c4 00 00 00 e0 8f fe 00 00 00 00 49 18 60 03
 30: 00 00 00 00 68 00 00 00 00 00 00 00 05 01 00 00
=2D40: 11 f1 00 00 00 00 7f f0 30 00 00 0f 00 00 00 00
+40: 11 f1 02 00 00 00 7f f0 30 00 00 0f 00 00 00 00
 50: 10 00 11 02 00 00 00 00 00 20 09 00 11 f4 03 01
 60: 00 00 11 10 00 00 00 00 01 50 02 40 00 00 00 00
 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


It would be nice if we could support in Linux. Maybe you want to contact=20
JMicron?

Cheers,
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1193343.BGzqgVWsVG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDtUcgxU2n/+9+t5gRAnvcAKDEX52ILosevpZjT50bQE6cv/fP3gCfXLBd
oMasCWdwiV4euVknnYxPSMM=
=UFm1
-----END PGP SIGNATURE-----

--nextPart1193343.BGzqgVWsVG--
