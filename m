Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030401AbWAXJIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbWAXJIt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 04:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbWAXJIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 04:08:49 -0500
Received: from marla.ludost.net ([194.12.255.250]:24983 "EHLO marla.ludost.net")
	by vger.kernel.org with ESMTP id S1030409AbWAXJIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 04:08:48 -0500
Subject: kobject_register failed for Promise_Old_IDE (-17)
From: Vasil Kolev <vasil@ludost.net>
To: linux-kernel@vger.kernel.org
Cc: andre@linux-ide.org, frankt@promise.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3lFs7BnHPm8jnh/hXG14"
Date: Tue, 24 Jan 2006 11:08:47 +0200
Message-Id: <1138093728.5828.8.camel@lyra.home.ludost.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3lFs7BnHPm8jnh/hXG14
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello,
I have a machine that's currently running 2.4.28 with the promise_old
driver, which runs ok. I tried upgrading it last night to 2.6.15, and
the following error occured, and no drives were detected/made available:

 [17179598.940000] kobject_register failed for Promise_Old_IDE (-17)
 [17179598.940000]  [dump_stack+21/23] dump_stack+0x15/0x17
 [17179598.940000]  [kobject_register+52/64] kobject_register+0x34/0x40
 [17179598.940000]  [bus_add_driver+69/163] bus_add_driver+0x45/0xa3
 [17179598.940000]  [driver_register+57/60] driver_register+0x39/0x3c
 [17179598.940000]  [__pci_register_driver+125/132] __pci_register_driver+0=
x7d/0x84
 [17179598.940000]  [__ide_pci_register_driver+19/53] __ide_pci_register_dr=
iver+0x13/0x35
 [17179598.940000]  [pg0+945449588/1069855744] pdc202xx_ide_init+0x12/0x16 =
[pdc202xx_old]
 [17179598.940000]  [sys_init_module+193/430] sys_init_module+0xc1/0x1ae
 [17179598.940000]  [syscall_call+7/11] syscall_call+0x7/0xb

I'm appending here the lspci output, if you need some more info, I can
send it. Doing tests is somewhat harder, because this is a production
machine, and I have a very limited window to do test, but it can be
managed.

0000:00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Expr=
ess Processor to DRAM Controller (rev 03)
0000:00:01.0 PCI bridge: Intel Corporation Mobile 915GM/PM Express PCI Expr=
ess Root Port (rev 03)
0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Fami=
ly) PCI Express Port 1 (rev 04)
0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 =
Family) USB UHCI #1 (rev 04)
0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 =
Family) USB UHCI #2 (rev 04)
0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 =
Family) USB UHCI #3 (rev 04)
0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 =
Family) USB UHCI #4 (rev 04)
0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 =
Family) USB2 EHCI Controller (rev 04)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4)
0000:00:1e.2 Multimedia audio controller: Intel Corporation 82801FB/FBM/FR/=
FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 04)
0000:00:1e.3 Modem: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) A=
C'97 Modem Controller (rev 04)
0000:00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface B=
ridge (rev 04)
0000:00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 F=
amily) IDE Controller (rev 04)
0000:00:1f.2 0106: Intel Corporation 82801FBM (ICH6M) SATA Controller (rev =
04)
0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) S=
MBus Controller (rev 04)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce Go=
 6600] (rev a2)
0000:06:05.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev=
 05)
0000:06:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 =
Gigabit Ethernet (rev 10)
0000:06:09.0 CardBus bridge: Texas Instruments PCIxx21/x515 Cardbus Control=
ler
0000:06:09.2 FireWire (IEEE 1394): Texas Instruments OHCI Compliant IEEE 13=
94 Host Controller
0000:06:09.3 Mass storage controller: Texas Instruments PCIxx21 Integrated =
FlashMedia Controller
0000:06:09.4 0805: Texas Instruments PCI6411, PCI6421, PCI6611, PCI6621, PC=
I7411, PCI7421, PCI7611, PCI7621 Secure Digital (SD) Controller


--=-3lFs7BnHPm8jnh/hXG14
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: =?iso-8859-5?Q?=C2=DE=D2=D0?= =?iso-8859-5?Q?_=D5?=
	=?iso-8859-5?Q?_=E6=D8=E4=E0=DE=D2=DE?=
	=?iso-8859-5?Q?_=DF=DE=D4=DF=D8=E1=D0=DD=D0?=
	=?iso-8859-5?Q?_=E7=D0=E1=E2?= =?iso-8859-5?Q?_=DE=E2?=
	=?iso-8859-5?Q?_=DF=D8=E1=DC=DE=E2=DE?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD1e6fXGxMwFp5iTARAqWvAJ9kaKtnf+VFASxFVOEf2SOD6Gn3XwCgx3MV
K1oQiLrUVkU7IepBFIbU45I=
=EPut
-----END PGP SIGNATURE-----

--=-3lFs7BnHPm8jnh/hXG14--

