Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268428AbRG3H5h>; Mon, 30 Jul 2001 03:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268429AbRG3H5b>; Mon, 30 Jul 2001 03:57:31 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:12553 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S268428AbRG3H5P>;
	Mon, 30 Jul 2001 03:57:15 -0400
Date: Mon, 30 Jul 2001 11:57:10 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.4.7-ac1 HPT370 lost interruprt(s)
Message-ID: <20010730115710.A21907@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 11:14am  up 2 days, 18:18,  2 users,  load average: 0.46, 0.93, 0.65
X-Uname: Linux orbita1.ru 2.2.20pre2-acl 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--GRPZ8SYKNexpdSJ7
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

after upgrading to Epox EP-D3VA dual cpu VIA PRO133 based motherboard i hav=
e=20
a problem with the onboard HPT370 IDE controller. I have 2 HD connected to=
=20
southebridge's IDE ports and old HD and CDROM connected to HPT370=20
(yes, this configuration is strange :)

When kernel (2.4.7, 2.4.7-ac1) tries to read partition table from /dev/hdg=
=20
(HD connected to HPT370) it pauses, prints some messages 'hdg: lost interru=
pts'
and finally reads the partition table. /proc/interrupts shows that no inter=
rupts=20
from HPT370 where occured. BOTH SMP and UP compiled kernel affected.

IMHO it's not hardware problem, because Win98 works with both HPT370 connec=
ted
HD and CDROM.

Additional information attached. I'm ready to provide more info and test pa=
tches
if they will appear.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename=report
Content-Transfer-Encoding: quoted-printable

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
Linux pazke-home 2.4.7-ac1 #17 SMP =FE=D4=D7 =E9=C0=CC 26 21:01:03 MSD 2001=
 i686 unknown
=20
Gnu C                  2.95.2
Gnu make               3.78.1
binutils               2.9.5.0.37
util-linux             2.10f
mount                  2.10f
modutils               2.3.14
e2fsprogs              1.18
PPP                    2.3.11
Linux C Library        2.1.3
ldd: version 1.9.11
Procps                 2.0.6
Net-tools              1.54
Kbd                    0.2.3
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         nls_koi8-r nls_cp866 vfat fat tulip

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : isapnp read
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
c000-c00f : VIA Technologies, Inc. Bus Master IDE
  c000-c007 : ide0
  c008-c00f : ide1
c400-c41f : VIA Technologies, Inc. UHCI USB
c800-c87f : Digital Equipment Corporation DECchip 21041 [Tulip Pass 3]
  c800-c87f : tulip
cc00-cc07 : HighPoint Technologies, Inc. HPT366/370 UltraDMA 66/100 IDE Con=
troller
  cc00-cc07 : ide2
d000-d003 : HighPoint Technologies, Inc. HPT366/370 UltraDMA 66/100 IDE Con=
troller
  d002-d002 : ide2
d400-d407 : HighPoint Technologies, Inc. HPT366/370 UltraDMA 66/100 IDE Con=
troller
d800-d803 : HighPoint Technologies, Inc. HPT366/370 UltraDMA 66/100 IDE Con=
troller
dc00-dcff : HighPoint Technologies, Inc. HPT366/370 UltraDMA 66/100 IDE Con=
troller
  dc00-dc07 : ide2
  dc08-dc0f : ide3
  dc10-dcff : HPT370A
e000-e007 : Siig Inc CyberSerial (1-port) 16550

           CPU0       CPU1      =20
  0:      50888      82069    IO-APIC-edge  timer
  1:       2956       3140    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
 14:         11          9    IO-APIC-edge  ide0
 15:        781       1378    IO-APIC-edge  ide1
 16:          0          0   IO-APIC-level  ide2
 17:          2          2   IO-APIC-level  eth0
NMI:          0          0=20
LOC:     132880     132879=20
ERR:          0
MIS:          0

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]=
 (rev c4)
00: 06 11 91 06 06 00 10 a2 c4 00 00 06 00 08 00 00
10: 08 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: fd d8 48 f6 01 00 04 04 00 00 01 02 04 04 04 04
60: 0f 2a 00 20 a5 a5 95 95 40 68 65 0d 18 2f 00 00
70: 40 88 cc 0c 0e 81 d2 00 00 f4 09 00 00 00 00 00
80: 0f 41 00 00 c0 00 00 00 02 00 00 00 ec 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 02 c0 20 00 13 02 00 1f 00 00 00 00 6f 02 10 00
b0: ff 63 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 01 00 00 00 00 00 00 04 22 00 00 00 00 00 00 00

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro13=
3x AGP]
00: 06 11 98 85 07 00 30 22 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 00 00
20: 00 d4 f0 d5 00 d6 f0 d6 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 0c 00
40: 48 cd 00 44 04 72 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 02 02 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] (rev=
 23)
00: 06 11 96 05 87 00 00 02 23 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 01 00 00 00 80 60 ee 01 00 c4 00 00 00 00 f3
50: 24 00 00 00 00 b0 ca 00 00 06 f4 08 c0 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 03 06 00 00 94 02 f0 40 00 00 00 00
80: 03 00 00 00 00 00 00 00 00 00 00 03 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00: 06 11 71 05 07 00 90 02 10 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 c0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 00 00 00
40: 03 c2 08 3a 1c 1f c0 00 22 20 a8 20 30 00 22 20
50: 0f e1 0b e2 14 00 00 00 a8 a8 a8 a8 00 00 00 00
60: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
70: 02 01 00 00 00 00 00 00 02 01 00 00 00 00 00 00
80: 00 d0 16 01 00 00 00 00 00 b0 16 01 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 10 00 71 05 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 11)
00: 06 11 38 30 07 00 10 02 11 00 03 0c 08 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 c4 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 04 00 00
40: 00 02 01 00 c2 00 30 08 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.3 Bridge: VIA Technologies, Inc. VT82C596 Power Management (rev 30)
00: 06 11 50 30 00 00 80 02 30 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 20 84 49 00 fa 60 00 00 01 40 00 00 d8 00 00 00
50: 00 ff ff 88 10 00 00 00 00 ff ff 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 01 50 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:09.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 [T=
ulip Pass 3] (rev 21)
00: 11 10 14 00 07 00 80 02 21 00 00 02 00 20 00 00
10: 01 c8 00 00 00 00 00 d8 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 11 00 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00
40: 00 4e 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0b.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 =
(rev 04)
00: 03 11 04 00 05 00 30 02 04 00 80 01 08 40 00 00
10: 01 cc 00 00 01 d0 00 00 01 d4 00 00 01 d8 00 00
20: 01 dc 00 00 00 00 00 00 00 00 00 00 03 11 01 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 08 08
40: 33 6c 40 22 a7 4e 81 06 a7 4e 81 06 a7 4e 81 06
50: 05 00 00 00 05 00 00 00 1b 00 10 23 24 00 26 00
60: 01 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 96 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0c.0 Serial controller: Siig Inc CyberSerial (1-port) 16550
00: 1f 13 00 20 03 00 90 02 00 02 00 07 08 00 00 00
10: 01 e0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 1f 13 00 20
30: 00 00 00 00 a0 00 00 00 00 00 00 00 0c 01 00 00
40: 05 00 00 38 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 07 00 00 00 49 0d 00 00
60: 00 00 00 00 00 00 00 00 00 00 03 00 00 00 00 30
70: 00 00 00 20 00 00 00 20 00 00 00 20 00 00 00 20
80: 00 00 00 20 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 13 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: NVidia / SGS Thomson (Joint Venture) Riv=
a128 (rev 10)
00: d2 12 18 00 07 00 b0 02 10 00 00 03 00 20 00 00
10: 00 00 00 d4 08 00 00 d6 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 15 2a a3 54
30: 00 00 00 00 44 00 00 00 00 00 00 00 ff 01 03 01
40: 15 2a a3 54 02 00 10 00 01 00 00 04 00 00 00 00
50: bf 00 00 00 01 00 00 00 ce d6 23 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 6
model name	: Celeron (Mendocino)
stepping	: 5
cpu MHz		: 534.555
cache size	: 128 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 mmx fxsr
bogomips	: 1064.96

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 6
model name	: Celeron (Mendocino)
stepping	: 5
cpu MHz		: 534.555
cache size	: 128 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 mmx fxsr
bogomips	: 1068.23


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=pci
Content-Transfer-Encoding: quoted-printable

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (re=
v 196).
      Master Capable.  Latency=3D8. =20
      Prefetchable 32 bit memory at 0xd0000000 [0xd3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x A=
GP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=3D12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] (rev 35).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 16).
      Master Capable.  Latency=3D32. =20
      I/O at 0xc000 [0xc00f].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 17).
      Master Capable.  Latency=3D32. =20
      I/O at 0xc400 [0xc41f].
  Bus  0, device   7, function  3:
    Bridge: VIA Technologies, Inc. VT82C596 Power Management (rev 48).
  Bus  0, device   9, function  0:
    Ethernet controller: Digital Equipment Corporation DECchip 21041 [Tulip=
 Pass 3] (rev 33).
      IRQ 10.
      Master Capable.  Latency=3D32. =20
      I/O at 0xc800 [0xc87f].
      Non-prefetchable 32 bit memory at 0xd8000000 [0xd800007f].
  Bus  0, device  11, function  0:
    Unknown mass storage controller: HighPoint Technologies, Inc. HPT366/37=
0 UltraDMA 66/100 IDE Controller (rev 4).
      IRQ 11.
      Master Capable.  Latency=3D64.  Min Gnt=3D8.Max Lat=3D8.
      I/O at 0xcc00 [0xcc07].
      I/O at 0xd000 [0xd003].
      I/O at 0xd400 [0xd407].
      I/O at 0xd800 [0xd803].
      I/O at 0xdc00 [0xdcff].
  Bus  0, device  12, function  0:
    Serial controller: Siig Inc CyberSerial (1-port) 16550 (rev 0).
      IRQ 12.
      I/O at 0xe000 [0xe007].
  Bus  1, device   0, function  0:
    VGA compatible controller: NVidia / SGS Thomson (Joint Venture) Riva128=
 (rev 16).
      Master Capable.  Latency=3D32.  Min Gnt=3D3.Max Lat=3D1.
      Non-prefetchable 32 bit memory at 0xd4000000 [0xd4ffffff].
      Prefetchable 32 bit memory at 0xd6000000 [0xd6ffffff].

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename=messages
Content-Transfer-Encoding: quoted-printable

Jul 29 22:40:39 pazke-home kernel: Linux version 2.4.7-ac1 (root@pazke-home=
) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #17 SMP =FE=D4=D7 =E9=C0=
=CC 26 21:01:03 MSD 2001
Jul 29 22:40:39 pazke-home kernel: BIOS-provided physical RAM map:
Jul 29 22:40:39 pazke-home kernel:  BIOS-e820: 0000000000000000 - 000000000=
00a0000 (usable)
Jul 29 22:40:39 pazke-home kernel:  BIOS-e820: 00000000000f0000 - 000000000=
0100000 (reserved)
Jul 29 22:40:39 pazke-home kernel:  BIOS-e820: 0000000000100000 - 000000000=
3ff0000 (usable)
Jul 29 22:40:39 pazke-home kernel:  BIOS-e820: 0000000003ff0000 - 000000000=
3ff3000 (ACPI NVS)
Jul 29 22:40:39 pazke-home kernel:  BIOS-e820: 0000000003ff3000 - 000000000=
4000000 (ACPI data)
Jul 29 22:40:39 pazke-home kernel:  BIOS-e820: 00000000fec00000 - 000000010=
0000000 (reserved)
Jul 29 22:40:39 pazke-home kernel: found SMP MP-table at 000f5a40
Jul 29 22:40:39 pazke-home kernel: hm, page 000f5000 reserved twice.
Jul 29 22:40:39 pazke-home kernel: hm, page 000f6000 reserved twice.
Jul 29 22:40:39 pazke-home kernel: hm, page 000f1000 reserved twice.
Jul 29 22:40:39 pazke-home kernel: hm, page 000f2000 reserved twice.
Jul 29 22:40:39 pazke-home kernel: On node 0 totalpages: 16368
Jul 29 22:40:39 pazke-home kernel: zone(0): 4096 pages.
Jul 29 22:40:39 pazke-home kernel: zone(1): 12272 pages.
Jul 29 22:40:39 pazke-home kernel: zone(2): 0 pages.
Jul 29 22:40:39 pazke-home kernel: Intel MultiProcessor Specification v1.4
Jul 29 22:40:39 pazke-home kernel:     Virtual Wire compatibility mode.
Jul 29 22:40:39 pazke-home kernel: OEM ID: OEM00000 Product ID: PROD0000000=
0 APIC at: 0xFEE00000
Jul 29 22:40:39 pazke-home kernel: Processor #0 Pentium(tm) Pro APIC versio=
n 17
Jul 29 22:40:39 pazke-home kernel: Processor #1 Pentium(tm) Pro APIC versio=
n 17
Jul 29 22:40:39 pazke-home kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Jul 29 22:40:39 pazke-home kernel: Processors: 2
Jul 29 22:40:39 pazke-home kernel: Kernel command line: BOOT_IMAGE=3Dl ro r=
oot=3D1601 BOOT_FILE=3D/boot/vmlinuz-2.4.7-ac1
Jul 29 22:40:39 pazke-home kernel: Initializing CPU#0
Jul 29 22:40:39 pazke-home kernel: Detected 534.561 MHz processor.
Jul 29 22:40:39 pazke-home kernel: Console: colour VGA+ 80x25
Jul 29 22:40:39 pazke-home kernel: Calibrating delay loop... 1064.96 BogoMI=
PS
Jul 29 22:40:39 pazke-home kernel: Memory: 62320k/65472k available (821k ke=
rnel code, 2768k reserved, 201k data, 224k init, 0k highmem)
Jul 29 22:40:39 pazke-home kernel: Dentry-cache hash table entries: 8192 (o=
rder: 4, 65536 bytes)
Jul 29 22:40:39 pazke-home kernel: Inode-cache hash table entries: 4096 (or=
der: 3, 32768 bytes)
Jul 29 22:40:39 pazke-home kernel: Mount-cache hash table entries: 1024 (or=
der: 1, 8192 bytes)
Jul 29 22:40:39 pazke-home kernel: Buffer-cache hash table entries: 1024 (o=
rder: 0, 4096 bytes)
Jul 29 22:40:39 pazke-home kernel: Page-cache hash table entries: 16384 (or=
der: 4, 65536 bytes)
Jul 29 22:40:39 pazke-home kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Jul 29 22:40:39 pazke-home kernel: CPU: L2 cache: 128K
Jul 29 22:40:39 pazke-home kernel: Intel machine check architecture support=
ed.
Jul 29 22:40:39 pazke-home kernel: Intel machine check reporting enabled on=
 CPU#0.
Jul 29 22:40:39 pazke-home kernel: Enabling fast FPU save and restore... do=
ne.
Jul 29 22:40:39 pazke-home kernel: Checking 'hlt' instruction... OK.
Jul 29 22:40:39 pazke-home kernel: POSIX conformance testing by UNIFIX
Jul 29 22:40:39 pazke-home kernel: mtrr: v1.40 (20010327) Richard Gooch (rg=
ooch@atnf.csiro.au)
Jul 29 22:40:39 pazke-home kernel: mtrr: detected mtrr type: Intel
Jul 29 22:40:39 pazke-home kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Jul 29 22:40:39 pazke-home kernel: CPU: L2 cache: 128K
Jul 29 22:40:39 pazke-home kernel: Intel machine check reporting enabled on=
 CPU#0.
Jul 29 22:40:39 pazke-home kernel: CPU0: Intel Celeron (Mendocino) stepping=
 05
Jul 29 22:40:39 pazke-home kernel: per-CPU timeslice cutoff: 366.07 usecs.
Jul 29 22:40:39 pazke-home kernel: enabled ExtINT on CPU#0
Jul 29 22:40:39 pazke-home kernel: ESR value before enabling vector: 000000=
00
Jul 29 22:40:39 pazke-home kernel: ESR value after enabling vector: 00000000
Jul 29 22:40:39 pazke-home kernel: Booting processor 1/1 eip 2000
Jul 29 22:40:39 pazke-home kernel: Initializing CPU#1
Jul 29 22:40:39 pazke-home kernel: masked ExtINT on CPU#1
Jul 29 22:40:39 pazke-home kernel: ESR value before enabling vector: 000000=
00
Jul 29 22:40:39 pazke-home kernel: ESR value after enabling vector: 00000000
Jul 29 22:40:39 pazke-home kernel: Calibrating delay loop... 1068.23 BogoMI=
PS
Jul 29 22:40:39 pazke-home kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Jul 29 22:40:39 pazke-home kernel: CPU: L2 cache: 128K
Jul 29 22:40:39 pazke-home kernel: Intel machine check reporting enabled on=
 CPU#1.
Jul 29 22:40:39 pazke-home kernel: CPU1: Intel Celeron (Mendocino) stepping=
 05
Jul 29 22:40:39 pazke-home kernel: Total of 2 processors activated (2133.19=
 BogoMIPS).
Jul 29 22:40:39 pazke-home kernel: ENABLING IO-APIC IRQs
Jul 29 22:40:39 pazke-home kernel: ...changing IO-APIC physical APIC ID to =
2 ... ok.
Jul 29 22:40:39 pazke-home kernel: ..TIMER: vector=3D0x31 pin1=3D2 pin2=3D0
Jul 29 22:40:39 pazke-home kernel: testing the IO APIC.....................=
..
Jul 29 22:40:39 pazke-home kernel:=20
Jul 29 22:40:39 pazke-home kernel: .................................... don=
e.
Jul 29 22:40:39 pazke-home kernel: Using local APIC timer interrupts.
Jul 29 22:40:39 pazke-home kernel: calibrating APIC timer ...
Jul 29 22:40:39 pazke-home kernel: ..... CPU clock speed is 534.5680 MHz.
Jul 29 22:40:39 pazke-home kernel: ..... host bus clock speed is 66.8209 MH=
z.
Jul 29 22:40:39 pazke-home kernel: cpu: 0, clocks: 668209, slice: 222736
Jul 29 22:40:39 pazke-home kernel: CPU0<T0:668208,T1:445472,D:0,S:222736,C:=
668209>
Jul 29 22:40:39 pazke-home kernel: cpu: 1, clocks: 668209, slice: 222736
Jul 29 22:40:39 pazke-home kernel: CPU1<T0:668208,T1:222736,D:0,S:222736,C:=
668209>
Jul 29 22:40:39 pazke-home kernel: checking TSC synchronization across CPUs=
: passed.
Jul 29 22:40:39 pazke-home kernel: mtrr: your CPUs had inconsistent variabl=
e MTRR settings
Jul 29 22:40:39 pazke-home kernel: mtrr: probably your BIOS does not setup =
all CPUs
Jul 29 22:40:39 pazke-home kernel: PCI: Using configuration type 1
Jul 29 22:40:39 pazke-home kernel: PCI: Probing PCI hardware
Jul 29 22:40:39 pazke-home kernel: PCI: Using IRQ router VIA [1106/0596] at=
 00:07.0
Jul 29 22:40:39 pazke-home kernel: PCI->APIC IRQ transform: (B0,I9,P0) -> 17
Jul 29 22:40:39 pazke-home kernel: PCI->APIC IRQ transform: (B0,I11,P0) -> =
16
Jul 29 22:40:39 pazke-home kernel: PCI->APIC IRQ transform: (B0,I12,P0) -> =
18
Jul 29 22:40:39 pazke-home kernel: Activating ISA DMA hang workarounds.
Jul 29 22:40:39 pazke-home kernel: isapnp: Scanning for PnP cards...
Jul 29 22:40:39 pazke-home kernel: isapnp: SB audio device quirk - increasi=
ng port range
Jul 29 22:40:39 pazke-home kernel: isapnp: AWE32 quirk - adding two ports
Jul 29 22:40:39 pazke-home kernel: isapnp: Card 'Creative SB AWE64  PnP'
Jul 29 22:40:39 pazke-home kernel: isapnp: 1 Plug & Play card detected total
Jul 29 22:40:39 pazke-home kernel: PnP: PNP BIOS installation structure at =
0xc00fbd10
Jul 29 22:40:39 pazke-home kernel: PnP: PNP BIOS version 1.0, entry at f000=
0:bd40, dseg at f0000
Jul 29 22:40:39 pazke-home kernel: PnP: 15 devices detected total
Jul 29 22:40:39 pazke-home kernel: Linux NET4.0 for Linux 2.4
Jul 29 22:40:39 pazke-home kernel: Based upon Swansea University Computer S=
ociety NET3.039
Jul 29 22:40:39 pazke-home kernel: apm: BIOS version 1.2 Flags 0x07 (Driver=
 version 1.14)
Jul 29 22:40:39 pazke-home kernel: apm: disabled - APM is not SMP safe.
Jul 29 22:40:39 pazke-home kernel: Starting kswapd v1.8
Jul 29 22:40:39 pazke-home kernel: VFS: Diskquotas version dquot_6.5.0 init=
ialized
Jul 29 22:40:39 pazke-home kernel: Detected PS/2 Mouse Port.
Jul 29 22:40:39 pazke-home kernel: pty: 256 Unix98 ptys configured
Jul 29 22:40:39 pazke-home kernel: block: queued sectors max/low 41080kB/13=
693kB, 128 slots per queue
Jul 29 22:40:39 pazke-home kernel: Uniform Multi-Platform E-IDE driver Revi=
sion: 6.31
Jul 29 22:40:39 pazke-home kernel: ide: Assuming 33MHz system bus speed for=
 PIO modes; override with idebus=3Dxx
Jul 29 22:40:39 pazke-home kernel: VP_IDE: IDE controller on PCI bus 00 dev=
 39
Jul 29 22:40:39 pazke-home kernel: VP_IDE: chipset revision 16
Jul 29 22:40:39 pazke-home kernel: VP_IDE: not 100% native mode: will probe=
 irqs later
Jul 29 22:40:39 pazke-home kernel: ide: Assuming 33MHz system bus speed for=
 PIO modes; override with idebus=3Dxx
Jul 29 22:40:39 pazke-home kernel: VP_IDE: VIA vt82c596b (rev 23) IDE UDMA6=
6 controller on pci00:07.1
Jul 29 22:40:39 pazke-home kernel:     ide0: BM-DMA at 0xc000-0xc007, BIOS =
settings: hda:DMA, hdb:pio
Jul 29 22:40:39 pazke-home kernel:     ide1: BM-DMA at 0xc008-0xc00f, BIOS =
settings: hdc:DMA, hdd:pio
Jul 29 22:40:39 pazke-home kernel: HPT370A: IDE controller on PCI bus 00 de=
v 58
Jul 29 22:40:39 pazke-home kernel: HPT370A: chipset revision 4
Jul 29 22:40:39 pazke-home kernel: HPT370A: not 100% native mode: will prob=
e irqs later
Jul 29 22:40:39 pazke-home kernel:     ide2: BM-DMA at 0xdc00-0xdc07, BIOS =
settings: hde:pio, hdf:pio
Jul 29 22:40:39 pazke-home kernel:     ide3: BM-DMA at 0xdc08-0xdc0f, BIOS =
settings: hdg:pio, hdh:pio
Jul 29 22:40:39 pazke-home kernel: hda: IBM-DHEA-34331, ATA DISK drive
Jul 29 22:40:39 pazke-home kernel: hdc: QUANTUM FIREBALLlct20 30, ATA DISK =
drive
Jul 29 22:40:39 pazke-home kernel: hdg: WDC AC2850F, ATA DISK drive
Jul 29 22:40:39 pazke-home kernel: hdh: MATSHITA CR-585, ATAPI CD/DVD-ROM d=
rive
Jul 29 22:40:39 pazke-home kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jul 29 22:40:39 pazke-home kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jul 29 22:40:39 pazke-home kernel: ide3 at 0xd400-0xd407,0xd802 on irq 16
Jul 29 22:40:39 pazke-home kernel: hda: 8467200 sectors (4335 MB) w/472KiB =
Cache, CHS=3D527/255/63, UDMA(33)
Jul 29 22:40:39 pazke-home kernel: hdc: 58633344 sectors (30020 MB) w/418Ki=
B Cache, CHS=3D58168/16/63, UDMA(66)
Jul 29 22:40:39 pazke-home kernel: hdg: 1667232 sectors (854 MB) w/64KiB Ca=
che, CHS=3D1654/16/63
Jul 29 22:40:39 pazke-home kernel: Partition check:
Jul 29 22:40:39 pazke-home kernel:  hda: hda1
Jul 29 22:40:39 pazke-home kernel:  hdc: hdc1 hdc2
Jul 29 22:40:39 pazke-home kernel:  hdg:hdg: lost interrupt
Jul 29 22:40:39 pazke-home kernel: hdg: lost interrupt
Jul 29 22:40:39 pazke-home last message repeated 2 times
Jul 29 22:40:39 pazke-home kernel:  [PTBL] [827/32/63] hdg1 hdg2 <hdg: lost=
 interrupt
Jul 29 22:40:39 pazke-home kernel:  hdg5 > hdg3
Jul 29 22:40:39 pazke-home kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Jul 29 22:40:39 pazke-home kernel: IP Protocols: ICMP, UDP, TCP
Jul 29 22:40:39 pazke-home kernel: IP: routing cache hash table of 512 buck=
ets, 4Kbytes
Jul 29 22:40:39 pazke-home kernel: TCP: Hash tables configured (established=
 4096 bind 4096)
Jul 29 22:40:39 pazke-home kernel: NET4: Unix domain sockets 1.0/SMP for Li=
nux NET4.0.
Jul 29 22:40:39 pazke-home kernel: VFS: Mounted root (ext2 filesystem) read=
only.
Jul 29 22:40:39 pazke-home kernel: Freeing unused kernel memory: 224k freed
Jul 29 22:40:39 pazke-home kernel: Adding Swap: 58964k swap-space (priority=
 -1)
Jul 29 22:40:39 pazke-home kernel: Linux Tulip driver version 0.9.15-pre6 (=
July 2, 2001)
Jul 29 22:40:39 pazke-home kernel: tulip0: 21041 Media table, default media=
 0800 (Autosense).
Jul 29 22:40:39 pazke-home kernel: tulip0:  21041 media #0, 10baseT.
Jul 29 22:40:39 pazke-home kernel: tulip0:  21041 media #4, 10baseT-FDX.
Jul 29 22:40:39 pazke-home kernel: tulip0:  21041 media #1, 10base2.
Jul 29 22:40:39 pazke-home kernel: eth0: Digital DC21041 Tulip rev 33 at 0x=
c4813000, 21041 mode, 00:80:C8:7A:04:13, IRQ 17.
Jul 29 22:40:39 pazke-home kernel: MSDOS FS: IO charset koi8-r
Jul 29 22:40:39 pazke-home kernel: MSDOS FS: Using codepage 866
Jul 29 22:40:39 pazke-home kernel: eth0: No 21041 10baseT link beat, Media =
switched to 10base2.

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_TOSHIBA is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y

#
# General setup
#
CONFIG_NET=y
# CONFIG_VISWS is not set
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
CONFIG_PCI_GODIRECT=y
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
CONFIG_PM=y
# CONFIG_ACPI is not set
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_ISAPNP=y
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_BLK_DEV_ATARAID=m
CONFIG_BLK_DEV_ATARAID_PDC=m
CONFIG_BLK_DEV_ATARAID_HPT=m

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
CONFIG_BONDING=m
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNLANCE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_LANCE=m
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
CONFIG_AT1700=m
CONFIG_DEPCA=m
CONFIG_HP100=m
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
CONFIG_ADAPTEC_STARFIRE=m
CONFIG_AC3200=m
CONFIG_APRICOT=m
CONFIG_CS89x0=m
CONFIG_TULIP=m
CONFIG_TULIP_MWI=y
CONFIG_TULIP_MMIO=y
CONFIG_DE4X5=m
CONFIG_DGRS=m
CONFIG_DM9102=m
CONFIG_EEPRO100=m
# CONFIG_LNE390 is not set
CONFIG_FEALNX=m
CONFIG_NATSEMI=m
CONFIG_NE2K_PCI=m
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
CONFIG_SIS900=m
CONFIG_EPIC100=m
CONFIG_SUNDANCE=m
CONFIG_TLAN=m
CONFIG_VIA_RHINE=m
CONFIG_WINBOND_840=m
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
CONFIG_DL2K=m
# CONFIG_MYRI_SBUS is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
CONFIG_TR=y
CONFIG_IBMTR=m
CONFIG_IBMOL=m
CONFIG_IBMLS=m
CONFIG_TMS380TR=m
CONFIG_TMSPCI=m
# CONFIG_TMSISA is not set
CONFIG_ABYSS=m
# CONFIG_MADGEMC is not set
CONFIG_SMCTR=m
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=m
# CONFIG_INPUT_KEYBDEV is not set
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_EVDEV is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
# CONFIG_SERIAL_EXTENDED is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_COMPUTONE is not set
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
CONFIG_DIGIEPCA=m
# CONFIG_ESPSERIAL is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_ISI is not set
# CONFIG_SYNCLINK is not set
# CONFIG_N_HDLC is not set
# CONFIG_RISCOM8 is not set
# CONFIG_SPECIALIX is not set
# CONFIG_SX is not set
# CONFIG_RIO is not set
# CONFIG_STALDRV is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
# CONFIG_I2C_PHILIPSPAR is not set
# CONFIG_I2C_ELV is not set
# CONFIG_I2C_VELLEMAN is not set
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_CHARDEV is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=m
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set

#
# Joysticks
#
CONFIG_INPUT_GAMEPORT=m
CONFIG_INPUT_NS558=m
# CONFIG_INPUT_LIGHTNING is not set
# CONFIG_INPUT_PCIGAME is not set
# CONFIG_INPUT_CS461X is not set
# CONFIG_INPUT_EMU10K1 is not set
# CONFIG_INPUT_SERIO is not set
# CONFIG_INPUT_SERPORT is not set
CONFIG_INPUT_ANALOG=m
# CONFIG_INPUT_A3D is not set
# CONFIG_INPUT_ADI is not set
# CONFIG_INPUT_COBRA is not set
# CONFIG_INPUT_GF2K is not set
# CONFIG_INPUT_GRIP is not set
# CONFIG_INPUT_INTERACT is not set
# CONFIG_INPUT_TMDC is not set
# CONFIG_INPUT_SIDEWINDER is not set
# CONFIG_INPUT_IFORCE_USB is not set
# CONFIG_INPUT_IFORCE_232 is not set
# CONFIG_INPUT_WARRIOR is not set
# CONFIG_INPUT_MAGELLAN is not set
# CONFIG_INPUT_SPACEORB is not set
# CONFIG_INPUT_SPACEBALL is not set
# CONFIG_INPUT_STINGER is not set
# CONFIG_INPUT_DB9 is not set
# CONFIG_INPUT_GAMECON is not set
# CONFIG_INPUT_TURBOGRAFX is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDT=m
CONFIG_WDTPCI=m
CONFIG_WDT_501=y
CONFIG_WDT_501_FAN=y
CONFIG_PCWATCHDOG=m
CONFIG_ACQUIRE_WDT=m
CONFIG_ADVANTECH_WDT=m
CONFIG_60XX_WDT=m
# CONFIG_W83877F_WDT is not set
CONFIG_MIXCOMWD=m
CONFIG_I810_TCO=m
CONFIG_MACHZ_WDT=m
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
CONFIG_AGP_VIA=y
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_DRM is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=y
# CONFIG_I2C_PARPORT is not set
CONFIG_VIDEO_BT848=m
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_ZR36120 is not set
# CONFIG_VIDEO_MEYE is not set

#
# Radio Adapters
#
CONFIG_RADIO_CADET=m
CONFIG_RADIO_RTRACK=m
CONFIG_RADIO_RTRACK2=m
CONFIG_RADIO_AZTECH=m
CONFIG_RADIO_GEMTEK=m
CONFIG_RADIO_GEMTEK_PCI=m
CONFIG_RADIO_MAXIRADIO=m
CONFIG_RADIO_MAESTRO=m
# CONFIG_RADIO_MIROPCM20 is not set
# CONFIG_RADIO_MIROPCM20_RDS is not set
CONFIG_RADIO_SF16FMI=m
CONFIG_RADIO_TERRATEC=m
CONFIG_RADIO_TRUST=m
CONFIG_RADIO_TYPHOON=m
# CONFIG_RADIO_TYPHOON_PROC_FS is not set
CONFIG_RADIO_ZOLTRIX=m

#
# File systems
#
CONFIG_QUOTA=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_CMS_FS is not set
CONFIG_FAT_FS=m
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_MINIX_FS is not set
# CONFIG_FREEVXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
CONFIG_UDF_FS=m
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_NFS_FS is not set
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_SMB_NLS is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="koi8-r"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=m
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=m
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_RIVA=m
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_HGA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_E1355 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FBCON_ADVANCED is not set
CONFIG_FBCON_CFB8=m
CONFIG_FBCON_CFB16=m
CONFIG_FBCON_CFB32=m
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Sound
#
CONFIG_SOUND=m
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_MIDI_VIA82CXXX is not set
CONFIG_SOUND_OSS=m
# CONFIG_SOUND_TRACEINIT is not set
# CONFIG_SOUND_DMAP is not set
# CONFIG_SOUND_AD1816 is not set
# CONFIG_SOUND_SGALAXY is not set
# CONFIG_SOUND_ADLIB is not set
# CONFIG_SOUND_ACI_MIXER is not set
# CONFIG_SOUND_CS4232 is not set
# CONFIG_SOUND_SSCAPE is not set
# CONFIG_SOUND_GUS is not set
# CONFIG_SOUND_VMIDI is not set
# CONFIG_SOUND_TRIX is not set
# CONFIG_SOUND_MSS is not set
# CONFIG_SOUND_MPU401 is not set
# CONFIG_SOUND_NM256 is not set
# CONFIG_SOUND_MAD16 is not set
# CONFIG_SOUND_PAS is not set
# CONFIG_PAS_JOYSTICK is not set
# CONFIG_SOUND_PSS is not set
CONFIG_SOUND_SB=m
CONFIG_SOUND_AWE32_SYNTH=m
# CONFIG_SOUND_WAVEFRONT is not set
# CONFIG_SOUND_MAUI is not set
# CONFIG_SOUND_YM3812 is not set
# CONFIG_SOUND_OPL3SA1 is not set
# CONFIG_SOUND_OPL3SA2 is not set
# CONFIG_SOUND_YMFPCI is not set
# CONFIG_SOUND_YMFPCI_LEGACY is not set
# CONFIG_SOUND_UART6850 is not set
# CONFIG_SOUND_AEDSP16 is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set
# CONFIG_USB_LONG_TIMEOUT is not set
# CONFIG_USB_LARGE_CONFIG is not set
# CONFIG_USB_DEVICEFS is not set
# CONFIG_USB_BANDWIDTH is not set
CONFIG_USB_UHCI=m
# CONFIG_USB_UHCI_ALT is not set
# CONFIG_USB_OHCI is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_HID is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HP5300 is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_PLUSB is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_KAWETH is not set
CONFIG_USB_CATC=m
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_RIO500 is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_BUGVERBOSE is not set

--Qxx1br4bt0+wmkIi--

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7ZRNWBm4rlNOo3YgRAof8AKCQbKOmHWFmx7ynrNvnFxZzedd/hwCfYuuj
QsHdQ/n02c3LB6+IBo1oA7M=
=CAgX
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
