Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313505AbSFBUGt>; Sun, 2 Jun 2002 16:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313508AbSFBUGs>; Sun, 2 Jun 2002 16:06:48 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:61705 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S313505AbSFBUGr>;
	Sun, 2 Jun 2002 16:06:47 -0400
Date: Sun, 2 Jun 2002 22:06:46 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: [2.5.19] Oops during PCI scan on Alpha
Message-ID: <20020602200646.GB20788@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux mail 2.4.18 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm getting this Oops on my Alpha (Avanti aka AlphaStation 255/300) on
startup:


ksymoops 2.4.5 on alpha 2.2.20.  Options used
     -v /boot/vmlinux-2.5.19--02debug (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.5.19/ (specified)
     -m /boot/System.map-2.5.19--02debug (specified)

No modules in ksyms, skipping objects
Kernel bug at /usr/src/packages/linux-2.5.19/include/linux/device.h:78
swapper(1): Kernel Bug 1
pc =3D [<fffffc00003cb0cc>]  ra =3D [<fffffc00003c9f04>]  ps =3D 0000    No=
t tainted
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 =3D 0000000000000000  t0 =3D 0000000000000000  t1 =3D fffffc000050e628
t2 =3D fffffc000050e628  t3 =3D 0000000000000000  t4 =3D ffffffff00000000
t5 =3D 0000000000000001  t6 =3D fffffc0007f403a0  t7 =3D fffffc0007f58000
a0 =3D fffffc0000696878  a1 =3D 0000000000000000  a2 =3D 0000000000000000
a3 =3D 0000000000000000  a4 =3D fffffffffffffffe  a5 =3D 0000000000000001
t8 =3D fffffc0000506ad0  t9 =3D 0000000000002000  t10=3D 0000000000008000
t11=3D 0000000000008000  pv =3D fffffc00003cb0a0  at =3D fffffc0000509318
gp =3D fffffc0000549868  sp =3D fffffc0007f5b7a0
Trace:fffffc00003c9f04 fffffc00003c4e18 fffffc00003c4f0c fffffc00003c5060 f=
ffffc00003c53a0 fffffc00003100f8 fffffc0000310748 fffffc0000324448 fffffc00=
003100a8 fffffc00003100e0 fffffc0000310730=20
Code: e460001a  47e30402  2ffe0000  a022000c  f4200006  00000081 <0000004e>=
 004ea5a0=20


>>RA;  fffffc00003c9f04 <device_register+144/1c0>

>>PC;  fffffc00003cb0cc <bus_add_device+2c/a0>   <=3D=3D=3D=3D=3D

Trace; fffffc00003c9f04 <device_register+144/1c0>
Trace; fffffc00003c4e18 <pci_scan_device+118/160>
Trace; fffffc00003c4f0c <pci_scan_slot+ac/180>
Trace; fffffc00003c5060 <pci_do_scan_bus+80/140>
Trace; fffffc00003c53a0 <pci_scan_bus+40/80>
Trace; fffffc00003100f8 <init+18/200>
Trace; fffffc0000310748 <kernel_thread+28/90>
Trace; fffffc0000324448 <printk+228/280>
Trace; fffffc00003100a8 <rest_init+28/60>
Trace; fffffc00003100e0 <init+0/200>
Trace; fffffc0000310730 <kernel_thread+10/90>

Code;  fffffc00003cb0b4 <bus_add_device+14/a0>
0000000000000000 <_PC>:
Code;  fffffc00003cb0b4 <bus_add_device+14/a0>
   0:   1a 00 60 e4       beq  t2,6c <_PC+0x6c> fffffc00003cb120 <bus_add_d=
evice+80/a0>
Code;  fffffc00003cb0b8 <bus_add_device+18/a0>
   4:   02 04 e3 47       mov  t2,t1
Code;  fffffc00003cb0bc <bus_add_device+1c/a0>
   8:   00 00 fe 2f       unop=20
Code;  fffffc00003cb0c0 <bus_add_device+20/a0>
   c:   0c 00 22 a0       ldl  t0,12(t1)
Code;  fffffc00003cb0c4 <bus_add_device+24/a0>
  10:   06 00 20 f4       bne  t0,2c <_PC+0x2c> fffffc00003cb0e0 <bus_add_d=
evice+40/a0>
Code;  fffffc00003cb0c8 <bus_add_device+28/a0>
  14:   81 00 00 00       call_pal     0x81
Code;  fffffc00003cb0cc <bus_add_device+2c/a0>   <=3D=3D=3D=3D=3D
  18:   4e 00 00 00       call_pal     0x4e   <=3D=3D=3D=3D=3D
Code;  fffffc00003cb0d0 <bus_add_device+30/a0>
  1c:   a0 a5 4e 00       call_pal     0x4ea5a0

Kernel panic: Attempted to kill init!

While running 2.2.20, I can get these informations from lspci:


00:06.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 5=
3c810 (rev 11)
	Flags: bus master, medium devsel, latency 255, IRQ 11
	I/O ports at 8000
	Memory at 0000000004200000 (32-bit, non-prefetchable)
00: 00 10 01 00 47 00 00 02 11 00 00 01 00 ff 00 00
10: 01 80 00 00 00 00 20 04 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 08 40

00:07.0 Non-VGA unclassified device: Intel Corp. 82378IB [SIO ISA Bridge] (=
rev 43)
	Flags: bus master, medium devsel, latency 0
00: 86 80 84 04 07 00 00 02 43 00 00 00 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0d.0 VGA compatible controller: Digital Equipment Corporation PBXGB [TGA=
2] (rev 22) (prog-if 00 [VGA])
	Flags: bus master, medium devsel, latency 255, IRQ 10
	Memory at 0000000005000000 (32-bit, prefetchable)
	Expansion ROM at 00000000000c0000 [disabled]
00: 11 10 0d 00 47 00 80 82 22 00 00 03 00 ff 00 00
10: 08 00 00 05 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 01 00 0c 00 00 00 00 00 00 00 00 00 0a 01 08 40

00:0e.0 Ethernet controller: Digital Equipment Corporation DECchip 21040 [T=
ulip] (rev 26)
	Flags: bus master, medium devsel, latency 255, IRQ 15
	I/O ports at 8800
	Memory at 0000000006000000 (32-bit, non-prefetchable)
00: 11 10 02 00 47 00 80 02 26 00 00 02 00 ff 00 00
10: 01 88 00 00 00 00 00 06 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0f 01 00 00

Any help here?

MfG, JBG

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE8+nrVHb1edYOZ4bsRAiT8AJ4/VHxm7UEcD32NrvFCimtY/tQ6GgCdEH5W
T6nBDAG64P5gLquDJDcTRO0=
=kquq
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
