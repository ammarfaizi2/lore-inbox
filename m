Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263910AbSIQIiL>; Tue, 17 Sep 2002 04:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263917AbSIQIiK>; Tue, 17 Sep 2002 04:38:10 -0400
Received: from fusion.wineasy.se ([195.42.198.105]:24335 "HELO
	fusion.wineasy.se") by vger.kernel.org with SMTP id <S263910AbSIQIiI>;
	Tue, 17 Sep 2002 04:38:08 -0400
Date: Tue, 17 Sep 2002 10:43:03 +0200
From: Andreas Schuldei <andreas@schuldei.org>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: usb keyboard registering twice
Message-ID: <20020917084303.GC2277@lukas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have here a usb keyboard which is registering once with the
usb layer and twice with the input layer. Here is /proc/bus/usb/devices

dev:~# cat /proc/bus/usb/devices
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=466/900 us (52%), #Int=  8, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=b400
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 4
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0451 ProdID=1446 Rev= 1.10
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms
T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  4 Spd=1.5 MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=045e ProdID=002b Rev= 1.11
S:  Product=Microsoft Internet Keyboard Pro
C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
I:  If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=hid
E:  Ad=82(I) Atr=03(Int.) MxPS=   3 Ivl=10ms
T:  Bus=01 Lev=02 Prnt=02 Port=02 Cnt=02 Dev#=  5 Spd=1.5 MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=c001 Rev= 4.01
S:  Manufacturer=Logitech
S:  Product=N48
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 26mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=12  MxCh= 4
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=03eb ProdID=3301 Rev= 3.00
S:  Product=Standard USB Hub
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr= 64mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms
T:  Bus=01 Lev=02 Prnt=03 Port=00 Cnt=01 Dev#=  6 Spd=1.5 MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=056e ProdID=0009 Rev= 0.01
S:  Manufacturer=ELECOM
S:  Product=ELECOM image sensor mouse with wheel
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10ms
T:  Bus=01 Lev=02 Prnt=03 Port=01 Cnt=02 Dev#=  7 Spd=12  MxCh= 3
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0472 ProdID=0065 Rev= 1.00
S:  Manufacturer=Chicony
S:  Product=Generic USB Hub
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 90mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms
T:  Bus=01 Lev=03 Prnt=07 Port=00 Cnt=01 Dev#=  8 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0472 ProdID=0065 Rev= 1.00
S:  Manufacturer=Chicony
S:  Product=PFU-65 USB Keyboard
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=24ms

and here is /proc/bus/input/devices
dev:~# cat /proc/bus/input/devices
I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="Chicony  PFU-65 USB Keyboard"
P: Phys=usb1:2.2.1/input0
D: Drivers=kbd event4
B: EV=120002
B: KEY=10000 7f ffe7207a c14057ff ffbeffdf ffffffff ffffffff
fffffffe
B: LED=1f

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="ELECOM ELECOM image sensor mouse with wheel"
P: Phys=usb1:2.1/input0
D: Drivers=event3 mouse1
B: EV=6
B: KEY=70000 0 0 0 0 0 0 0 0
B: REL=103

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="Logitech N48"
P: Phys=usb1:1.3/input0
D: Drivers=event2 mouse0
B: EV=6
B: KEY=70000 0 0 0 0 0 0 0 0
B: REL=103

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="045e:002b"
P: Phys=usb1:1.1/input1
D: Drivers=kbd event1
B: EV=10000a
B: KEY=ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
ffffffff ffffffff ffff0000 38000 39fa d843d7a9 9e0000 0 0 1
B: ABS=1 0

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="045e:002b"
P: Phys=usb1:1.1/input0
D: Drivers=kbd event0
B: EV=120002
B: KEY=10000 0 ffe00000 7ff ffbeffdf ffffffff ffffffff fffffffe
B: LED=7


Here you see that the last two entries describe the same device. 

Is this a bogus keyboard (As you can see it is a Microsoft
product!), or is it the kernels responsibility to catch that?
Would it be the usb layer or the input layer which is responsible
to varify that the devices are unique?

In this case the USB layer cold have caught it, since the it is
both at usb1:1.1. But why do they have different keys? is that a
hardware feature like the mac-address in ethernet cards?

I am working with 2.4.19-backstreet-ruby, which is a backport of
greater parts of the usb, input and console work from 2.5 to
2.4.19. And i do not expect anyone but me to fix this. I would be
thankfull for any help regarding HOW it would be fixed, though.

I am not on lkml, so cc me, please.
