Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311898AbSC0Qxt>; Wed, 27 Mar 2002 11:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312992AbSC0Qxm>; Wed, 27 Mar 2002 11:53:42 -0500
Received: from vracs001.vrac.iastate.edu ([129.186.232.215]:39194 "EHLO
	vracs001.vrac.iastate.edu") by vger.kernel.org with ESMTP
	id <S311898AbSC0Qx1>; Wed, 27 Mar 2002 11:53:27 -0500
Subject: ne2k-pci  module for  EZCARD10 i.e SMC1208T  --connections dying out
From: "Daniel E. Shipton" <dshipton@vrac.iastate.edu>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-v/7sC7wvQeUXSTnYghsC"
X-Mailer: Ximian Evolution 1.0.3 
Date: 27 Mar 2002 10:53:25 -0600
Message-Id: <1017248005.10060.4.camel@regatta>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-v/7sC7wvQeUXSTnYghsC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I have a computer that on most web sites, ftp transfers or anything
related to the network
will start a connection and atart transferring for about 2 seconds and
then the connection
will die out.  This does not happen on all sites but with most.  When
booted into windows it has
no problem. It is very strange.  Have tried many different kernels
including 2.4.18 with no luck.
all info is below.  There seems to be no pattern also for this.  but it
doesn't matter=20
it is ssh, http, ftp...they have this problem......any clues.

here are is all the info on the card

EZCARD10
SMC1208T
SMC

p/n: 143128-403
rev: 03
FCC ID: HED1208ENI
    (or HED1208EN1)


here is the mainboard
the machine uses a Trinity KT system board from Tyan
(product #S2390) which has the following specs:
AMD Duron,200MHz FSB,
VIA KT - 133 chipset (VT82C686A), PC100/133 SDRAM, ATX



cat /proc/interrupts

           CPU0      =20
  0:     107504          XT-PIC  timer
  1:       2085          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  EMU10K1
 10:      51167          XT-PIC  nvidia
 11:      11754          XT-PIC  eth0
 12:       4142          XT-PIC  PS/2 Mouse
 14:      19161          XT-PIC  ide0
 15:      17578          XT-PIC  ide1
NMI:          0=20
LOC:          0=20
ERR:          0
MIS:          0

lspci

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev =
02)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 0583
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (r=
ev 22)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (r=
ev 30)
00:09.0 Ethernet controller: Advanced Micro Devices [AMD] 79c978 [HomePNA] =
(rev 51)
00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 0=
8)
00:0b.1 Input device controller: Creative Labs SB Live! (rev 08)
00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15)

cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 2).
      Prefetchable 32 bit memory at 0xd0000000 [0xd3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: PCI device 1106:0583 (VIA Technologies, Inc.) (rev 0).
      Master Capable.  No bursts.  Min Gnt=3D12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 3=
4).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 16).
      Master Capable.  Latency=3D32. =20
      I/O at 0xc000 [0xc00f].
  Bus  0, device   7, function  4:
    Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 4=
8).
      IRQ 11.
  Bus  0, device   9, function  0:
    Ethernet controller: Advanced Micro Devices [AMD] 79c978 [HomePNA] (rev=
 81).
      IRQ 11.
      Master Capable.  Latency=3D32.  Min Gnt=3D24.Max Lat=3D24.
      I/O at 0xd800 [0xd81f].
      Non-prefetchable 32 bit memory at 0xd8000000 [0xd800001f].
  Bus  0, device  11, function  0:
    Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 8).
      IRQ 9.
      Master Capable.  Latency=3D32.  Min Gnt=3D2.Max Lat=3D20.
      I/O at 0xdc00 [0xdc1f].
  Bus  0, device  11, function  1:
    Input device controller: Creative Labs SB Live! (rev 8).
      Master Capable.  Latency=3D32. =20
      I/O at 0xe000 [0xe007].
  Bus  0, device  12, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS) (rev =
0).
      IRQ 11.
      I/O at 0xe400 [0xe41f].
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 21).
      IRQ 10.
      Master Capable.  Latency=3D248.  Min Gnt=3D5.Max Lat=3D1.
      Non-prefetchable 32 bit memory at 0xd6000000 [0xd6ffffff].
      Prefetchable 32 bit memory at 0xd4000000 [0xd5ffffff].

--=-v/7sC7wvQeUXSTnYghsC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8ofkF/jQriTaG5JURArlVAJwNXP97Bcue3PNfzPGsaiuBZaZ+8gCfWMO7
FxkysrSrcM1tSMps6G1ifrw=
=XLbb
-----END PGP SIGNATURE-----

--=-v/7sC7wvQeUXSTnYghsC--

