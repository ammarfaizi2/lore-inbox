Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbUBUQwV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 11:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbUBUQwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 11:52:21 -0500
Received: from D70dc.d.pppool.de ([80.184.112.220]:13282 "EHLO
	karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S261579AbUBUQwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 11:52:10 -0500
Subject: 2.6.3: Crash when trying to load usbnet
From: Daniel Egger <degger@fhm.edu>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aCL79oKdFdO0J77R7caO"
Message-Id: <1077381938.2394.205.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 21 Feb 2004 17:45:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aCL79oKdFdO0J77R7caO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hija,

I just observed the following two problems with USB:

     1. /proc/bus/usb/devices will block after the output of all
        available USB devices. Further tries to access it will block
        immediately.[1]
     2. When trying to inset the usbnet driver for a cdcnet cable modem
        using modprobe, modprobe will segfault and the driver causes an
        kernel oops.[2]

[1] Output was:
egger@alex:/proc/bus/usb$ cat devices
=20
T:  Bus=3D04 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  MxC=
h=3D 2
B:  Alloc=3D  0/900 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
S:  Manufacturer=3DLinux 2.6.3 uhci_hcd
S:  Product=3DUHCI Host Controller
S:  SerialNumber=3D0000:00:10.2
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms
=20
T:  Bus=3D03 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  MxC=
h=3D 2
B:  Alloc=3D  0/900 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
S:  Manufacturer=3DLinux 2.6.3 uhci_hcd
S:  Product=3DUHCI Host Controller
S:  SerialNumber=3D0000:00:10.1
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms
=20
T:  Bus=3D02 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  MxC=
h=3D 2
B:  Alloc=3D236/900 us (26%), #Int=3D  2, #Iso=3D  0
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
S:  Manufacturer=3DLinux 2.6.3 uhci_hcd
S:  Product=3DUHCI Host Controller
S:  SerialNumber=3D0000:00:10.0
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms
=20
T:  Bus=3D02 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2 Spd=3D1.5 MxC=
h=3D 0
D:  Ver=3D 1.10 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D046d ProdID=3Dc308 Rev=3D12.10
S:  Manufacturer=3DLogitech
S:  Product=3DLogitech USB Keyboard
C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3Da0 MxPwr=3D 80mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D03(HID  ) Sub=3D01 Prot=3D01 Driver=
=3Dhid
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D10ms
I:  If#=3D 1 Alt=3D 0 #EPs=3D 1 Cls=3D03(HID  ) Sub=3D00 Prot=3D00 Driver=
=3Dhid
E:  Ad=3D82(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D32ms
=20
T:  Bus=3D02 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D02 Dev#=3D  3 Spd=3D12  MxC=
h=3D 0
D:  Ver=3D 1.10 Cls=3D02(comm.) Sub=3D00 Prot=3D00 MxPS=3D32 #Cfgs=3D  1
P:  Vendor=3D077b ProdID=3D08b7 Rev=3D 1.01
S:  Manufacturer=3DThe Linksys Group, Inc.
S:  Product=3DUSB Cable Modem
C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D100mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D02(comm.) Sub=3D06 Prot=3D00 Driver=
=3D(none)
E:  Ad=3D85(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D64ms
I:  If#=3D 1 Alt=3D 0 #EPs=3D 0 Cls=3D0a(data ) Sub=3D00 Prot=3D00 Driver=
=3D(none)
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3D0a(data ) Sub=3D00 Prot=3D00 Driver=
=3D(none)
E:  Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
=20
T:  Bus=3D01 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D480 MxC=
h=3D 6
B:  Alloc=3D  0/800 us ( 0%), #Int=3D  0, #Iso=3D  0
D:  Ver=3D 2.00 Cls=3D09(hub  ) Sub=3D00 Prot=3D01 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
S:  Manufacturer=3DLinux 2.6.3 ehci_hcd
S:  Product=3DEHCI Host Controller
S:  SerialNumber=3D0000:00:10.3
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D256ms
=20
[2] The decoded kernel OOPS and additional info is as follows, please
    note that I've replugged the modem into a different port because I
    wanted to check whether this is possibly a USB 2.0 device and I
    connected to a USB 1.0 port in the first place (which to observe I
    used the devices output for).

usb 2-2: USB disconnect, address 3
usb 3-1: new full speed USB device using address 2
drivers/usb/core/message.c: string descriptor 0 too short
slab error in cache_free_debugcheck(): cache `size-1024': double free, or m=
emory outside object was overwritten
Call Trace:
 [<c0158b99>] kfree+0x2e9/0x410
 [<e1923f5e>] usbnet_probe+0x3ee/0x4d0 [usbnet]
 [<e1923f5e>] usbnet_probe+0x3ee/0x4d0 [usbnet]
 [<c02d42fb>] usb_probe_interface+0x5b/0x70
 [<c028387d>] bus_match+0x3d/0x70
 [<c02839aa>] driver_attach+0x5a/0x90
 [<c0283ca1>] bus_add_driver+0xa1/0xc0
 [<c0284168>] driver_register+0x88/0x90
 [<c02d43d5>] usb_register+0x45/0xa0
 [<c0265fc3>] get_random_bytes+0x43/0x50
 [<e1837038>] usbnet_init+0x38/0x3a [usbnet]
 [<c014923b>] sys_init_module+0x1eb/0x3c0
 [<c010a14f>] syscall_call+0x7/0xb
=20
c512f008: redzone 1: 0x0, redzone 2: 0xd0012.
------------[ cut here ]------------
kernel BUG at mm/slab.c:1696!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0158b30>]    Not tainted
EFLAGS: 00010002
EIP is at kfree+0x280/0x410
eax: c512f000   ebx: 80010c00   ecx: 00001000   edx: 00000008
esi: dffef980   edi: c512f000   ebp: ce8b7e78   esp: ce8b7e48
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 4304, threadinfo=3Dce8b6000 task=3Dd04f2960)
Stack: dffef980 c512f008 00000000 000d0012 0512f008 e1923f5e c512f008 dffe6=
f78
       00000286 d2833df8 ffffffea c512fc06 ce8b7eb8 e1923f5e c512fc00 d8a47=
ef8
       00000006 c79aaf38 000041ed cff21bf8 cff21cdc ffffffea e1924200 c2235=
f18
Call Trace:
 [<e1923f5e>] usbnet_probe+0x3ee/0x4d0 [usbnet]
 [<e1923f5e>] usbnet_probe+0x3ee/0x4d0 [usbnet]
 [<c02d42fb>] usb_probe_interface+0x5b/0x70
 [<c028387d>] bus_match+0x3d/0x70
 [<c02839aa>] driver_attach+0x5a/0x90
 [<c0283ca1>] bus_add_driver+0xa1/0xc0
 [<c0284168>] driver_register+0x88/0x90
 [<c02d43d5>] usb_register+0x45/0xa0
 [<c0265fc3>] get_random_bytes+0x43/0x50
 [<e1837038>] usbnet_init+0x38/0x3a [usbnet]
 [<c014923b>] sys_init_module+0x1eb/0x3c0
 [<c010a14f>] syscall_call+0x7/0xb
=20
Code: 0f 0b a0 06 c3 a5 41 c0 e9 e2 fe ff ff 0f 0b 9f 06 c3 a5 41
=20
--=20
Servus,
       Daniel

--=-aCL79oKdFdO0J77R7caO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQEVAwUAQDeLMjBkNMiD99JrAQICIAf/RAfWtU+vt0PzPaFdZp3yoS3HotiREFr/
3VkXf0xcESjBmPD5e0yl4pvxFEv6TPNRJ9J6fOLaxkEHRZMx68JEdhxAxz7qUSl8
0Spx2V7IxOigwjH5oYsYtLfNkpgz/BBSwz7eBezE5itcZo4bV8aiONdUiunQ/rVd
VYEZWY0ZD3PNwNghvD7J7rErDFeB9lZNXiwLSZ+Nwe0+95MVSdaT7h2EKBi3qPcQ
FC/wtAGvd3WZaoNaw6PyQITxrb6Id8/N/JI2grWDBj5Iwi1FMH/dvPVRV2yKwCSV
tJlH5peRLCaqHxGeYwBBgT8rtZKxWBhoiOnTJ9nq8ekbfO5WflbusA==
=lkgQ
-----END PGP SIGNATURE-----

--=-aCL79oKdFdO0J77R7caO--

