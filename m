Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264142AbUARWNw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 17:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbUARWNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 17:13:52 -0500
Received: from ns.schottelius.org ([213.146.113.242]:19845 "HELO
	mobilemail.schottelius.org") by vger.kernel.org with SMTP
	id S264142AbUARWNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 17:13:44 -0500
Date: Sun, 18 Jan 2004 23:13:08 +0100
From: Nico Schottelius <nico-linux-net@schottelius.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: Slow Networking in 2.5/2.6 [reasons]
Message-ID: <20040118221308.GA13026@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-linux-net@schottelius.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-net@vger.kernel.org
References: <20040114091207.GA8207@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <20040114091207.GA8207@schottelius.org>
X-MSMail-Priority: gibbet nicht.
X-Mailer: cat << EOF | netcat mailhost 110
Organization: http://nerd-hosting.net/
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.1
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mojUlQ0s9EVzWg2t
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Well, now I have some more information, which make me wonder:

I am currently trying to debug the rtl8139 card:

00:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)

00:05.0 Class 0200: 10ec:8139 (rev 10)

Subsystem: 10ec:8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Step
ping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at d600 [size=3D256]
        Region 1: Memory at effaee00 (32-bit, non-prefetchable) [size=3D256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0-,D1+,=
D2+,D3h
ot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

What makes me wondering is the attached output of mii-diag and
8139-diag, can somebody tell me why the values are non standard and
why the flow control is disabled?

Greetings,

Nico

--=20
Keep it simple & stupid, use what's available.
pgp: 8D0E E27A          | Nico Schottelius
http://nerd-hosting.net | http://linux.schottelius.org

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=rtldiag

rtl8139-diag.c:v2.12 12/03/2003 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a RealTek RTL8139 adapter at 0xd600.
The RealTek chip appears to be active, so some registers will not be read.
To see all register values use the '-f' flag.
RealTek chip registers at 0xd600
 0x000: bae60a00 0000c2f6 80000000 40000040 0010a10a 0010a5ea 0010a08a 0010a5ea
 0x020: 0cb76000 0cb76600 0cb76c00 0cb77200 13530000 0d0a0000 658c657c 0000c07f
 0x040: 74400680 0000f78e f0a87d28 00000000 008d1000 00000000 0088c510 00100000
 0x060: 1100f00f 01e1782d 000141e1 00000000 00000704 000207c8 60f60c59 7b732660.
Realtek station address 00:0a:e6:ba:f6:c2, chip type 'rtl8139C'.
  Receiver configuration: Normal unicast and hashed multicast
     Rx FIFO threshold 2048 bytes, maximum burst 2048 bytes, 32KB ring
  Transmitter enabled with NONSTANDARD! settings, maximum burst 1024 bytes.
    Tx entry #0 status 0010a10a complete, 266 bytes.
    Tx entry #1 status 0010a5ea complete, 1514 bytes.
    Tx entry #2 status 0010a08a complete, 138 bytes.
    Tx entry #3 status 0010a5ea complete, 1514 bytes.
  Flow control: Tx disabled  Rx disabled.
  The chip configuration is 0x10 0x8d, MII half-duplex mode.
  No interrupt sources are pending.
Decoded EEPROM contents:
   PCI IDs -- Vendor 0xd942, Device 0xffff.
   PCI Subsystem IDs -- Vendor 0x10ec, Device 0x8139.
   PCI timer settings -- minimum grant 32, maximum latency 64.
  General purpose pins --  direction 0xe5  value 0x12.
  Station Address 00:0A:E6:BA:F6:C2.
  Configuration register 0/1 -- 0x8d / 0xc2.
 EEPROM active region checksum is 0c88.
 The RTL8139 does not use a MII transceiver.
 It does have internal MII-compatible registers:
   Basic mode control register   0x1100.
   Basic mode status register    0x782d.
   Autonegotiation Advertisement 0x01e1.
   Link Partner Ability register 0x41e1.
   Autonegotiation expansion     0x0001.
   Disconnects                   0x0000.
   False carrier sense counter   0x0000.
   NWay test register            0x0704.
   Receive frame error count     0x0000.

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=miidiag

Using the default interface 'eth0'.
Basic registers of MII PHY #32:  1100 782d 0000 0000 01e1 41e1 0001 0000.
 The autonegotiated capability is 01e0.
The autonegotiated media type is 100baseTx-FD.
 Basic mode control register 0x1100: Auto-negotiation enabled.
 You have link beat, and everything is working OK.
 Your link partner advertised 41e1: 100baseTx-FD 100baseTx 10baseT-FD 10baseT.
   End of basic transceiver information.


--RnlQjJ0d97Da+TV1--

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFACwT0zGnTqo0OJ6QRAszjAJ4yB5FsMhK7OU3V4fCLtsTsNBUQIgCdFRud
Nf447unUgDak76RookSgA2c=
=PC0H
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
