Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135801AbRAJPP6>; Wed, 10 Jan 2001 10:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135817AbRAJPPu>; Wed, 10 Jan 2001 10:15:50 -0500
Received: from dnvrdslgw14poolB96.dnvr.uswest.net ([63.228.85.96]:45142 "EHLO
	q.dyndns.org") by vger.kernel.org with ESMTP id <S135312AbRAJPPh>;
	Wed, 10 Jan 2001 10:15:37 -0500
Date: Wed, 10 Jan 2001 08:15:26 -0700 (MST)
From: Benson Chow <blc@q.dyndns.org>
To: Vojtech Pavlik <vojtech@suse.cz>, <dwmw2@infradead.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: USB Keyboards for x86/uhci in 2.4- kernels?
In-Reply-To: <20010110124911.A2134@suse.cz>
Message-ID: <Pine.LNX.4.31.0101100742370.23627-100000@q.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I think David (his message is not copied in this response) actually
has the same problem.

He describes that his typing is poor.  That pretty much summarizes what I
am seeing on my USB keyboard too - it types poorly.  You need to type
slowly and firmly to work - key rollover doesn't seem to work properly.
Also if you hold the key long enough, it will repeat so I get too many
typing errors.  I tend to hold my keys down too long (so that Linux's
PS/2 default repeat delay/rate always causes typos - and I rely in the
n-key rollover els I cannot use the keyboard) but I can usually adjust my
keyboarding to compensate (just not comfortable for me yet).  However I
just cannot type in my password without seeing what has been typed.  Too
many typos!

So, the usb keyboard becomes unuseable for me and I have to hold back to a
PS/2 which works fine (see the way bottom of my message to see what
happens if my password was "the quick brown fox...").

This same keyboard works fine on another computer (HP Visualize C3600) - I
see -none- of the keyboarding problems on that computer (it natively
supports USB keyboards).  Also after booting Windows 98, and it loads its
own HID driver, it works fine too - no more keyboarding errors.  Before
that time, it has the same problem that I see in BIOS keyboard support.

My Via machine just died last night (again... I hate pc-chips...)
so I no longer have a windows machine to grab info from.  My PIIX3
motherboard is still working (knock on wood).  The PIIX3 doesn't
initialize USB properly so I can't use USB keyboards in BIOS nor DOS.
(This machine also doesn't have any microsoft OS's on it so I can't check
if the kbd will work in windows.  I suspect it will, after drivers are
loaded.)

dmesg, /proc/bus/usb/devices, typing sample (without backspace
corrections which can't be reliably done anyway), and lsmod follows.

Thanks a bunch,

-bc

Current lsmod:

blc@q:~$ lsmod
Module                  Size  Used by
belkin_sa               5088   0 (unused)
usbserial              13032   2 [belkin_sa]
printer                 5108   0
[ snip... to remove (i think unrelated) lines: nfsd lockd sunrpc eepro100
sb sb_lib uart401 sound isa-pnp ]
mousedev                4244   1
keybdev                 2036   0 (unused)
hid                    12056   0 (unused)
input                   3328   0 [mousedev keybdev hid]
uhci                   19880   0 (unused)
usbcore                49572   1 [belkin_sa usbserial printer hid uhci]

last lines of dmesg after hotplug:

ttyS01 at 0x02f8 (irq = 3) is a 16550A
hub.c: USB new device connect on bus1/1/4, assigned device number 17
keybdev.c: Adding keyboard: input1
input1: USB HID v1.10 Keyboard [NMB NMB USB Keyboard] on usb1:17.0

/proc/bus/usb/devices, which i think also shows my wiring topology:
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=222/900 us (25%), #Int=  3, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI-alt Root Hub
S:  SerialNumber=df80
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 11 Spd=12  MxCh= 7
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0451 ProdID=1446 Rev= 1.00
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms
T:  Bus=01 Lev=02 Prnt=11 Port=01 Cnt=01 Dev#= 12 Spd=1.5 MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=045e ProdID=0025 Rev= 1.00
S:  Manufacturer=Microsoft
S:  Product=Microsoft IntelliMouse ® with IntelliEye
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl= 10ms
T:  Bus=01 Lev=02 Prnt=11 Port=02 Cnt=02 Dev#= 13 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=03f0 ProdID=0104 Rev= 1.00
S:  Manufacturer=Hewlett-Packard
S:  Product=DeskJet 880C
S:  SerialNumber=MY91T1623TFA
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=07(print) Sub=01 Prot=01 Driver=usblp
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
I:  If#= 0 Alt= 1 #EPs= 2 Cls=07(print) Sub=01 Prot=02 Driver=usblp
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
T:  Bus=01 Lev=02 Prnt=11 Port=03 Cnt=03 Dev#= 17 Spd=1.5 MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0446 ProdID=0261 Rev= 1.00
S:  Manufacturer=NMB
S:  Product=NMB USB Keyboard
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 60mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=02 Prnt=11 Port=04 Cnt=04 Dev#= 14 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=050d ProdID=0103 Rev= 2.06
S:  Manufacturer=Belkin Components
S:  Product=USB-232 Adapter
S:  SerialNumber=BLA3660
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=serial
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=  1ms
T:  Bus=01 Lev=02 Prnt=11 Port=05 Cnt=05 Dev#= 15 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=050d ProdID=0103 Rev= 2.06
S:  Manufacturer=Belkin Components
S:  Product=USB-232 Adapter
S:  SerialNumber=BLA3661
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=serial
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=  1ms
T:  Bus=01 Lev=02 Prnt=11 Port=06 Cnt=06 Dev#= 16 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=1293 ProdID=0002 Rev= 1.04
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr= 98mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=07(print) Sub=01 Prot=01 Driver=usblp
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
I:  If#= 0 Alt= 1 #EPs= 2 Cls=07(print) Sub=01 Prot=02 Driver=usblp
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
I:  If#= 0 Alt= 2 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=ff Driver=usblp
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=   4 Ivl=  1ms

Here's me typing quick brown fox on my usb keyboard (this message was
composed on my ps/2.  The following is on my usb keyboard.  As you can
see it still gets a good number of characters through, just it loses
some 'scancodes' and starts repeating way too fast for me):

[USB] the quick brown fox jumps over thlazy oog.
[USB] the quick rown foox  umps over thelazy dog
[USB]
[USB] the quick brown o jumps over the az dog.

If I hunt and peck and be sure to release my keys before hitting the next:
[USB] the quicbrown x jumss over h lazzy dg



On Wed, 10 Jan 2001, Vojtech Pavlik wrote:

> Date: Wed, 10 Jan 2001 12:49:11 +0100
> From: Vojtech Pavlik <vojtech@suse.cz>
> To: Benson Chow <blc@q.dyndns.org>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: USB Keyboards for x86/uhci in 2.4- kernels?
>
> On Tue, Jan 09, 2001 at 11:55:14PM -0700, Benson Chow wrote:
> > Anyone tried using these beasts on a x86?
> >
> > Anyway, what's happening:   In BIOS my USB keyboard works really poorly -
> > it almost seems scancodes get dropped left and right.  Ok, so I don't mind
> > too much, i'm sure BIOS has a very limited driver.  After booting
> > Microsoft's offerring, it would work fine after it installs its driver.
> > I also tried this same keyboard on a HPUX Visualize C3600 workstation and
> > it also works nicely.
> >
> > However linux would never fix  this "scancode drop" syndrome even after
> > loading the hid or usbkbd driver.  Both my Via uhci USB motherboard and
> > PIIX3 USB motherboard exhibit this usb keyboard strangeness
> > with the hid or usbkbd driver is installed.  I think the PIIX3
> > motherboard's bios doesnt handle USB properly so it doesn't even work in
> > BIOS setup.  Any idea what's going on?  Is there some other driver or
> > utility I need to install/run to get it working?  Maybe just my bad bios?
> >
> > BTW: my USB Mouse, and USB Printer seem to work nicely in 2.4.0-release.
> >
> > USB KBD: NMB USB 104-key PC-Style
> > USB Mouse: Microsoft Intellimouse w/Intellieye 1.0, Logitech Optical Wheel
> > USB Printer: HP Deskjet 880C
> > USB Hub: Belkin 4-port
> > Intel 82437SB(?) PIIX3 and Via 82C686(?) USB controller
> >
> > Working: Stock HPUX10.2 HP Visualize C3600 PARISC2 Workstation
> > Working: Microsoft Windows 98 First Edition on the Via.
>
> What modules are loaded?
> What's in /proc/bus/usb/devices?
> What's in dmesg?
>
> --
> Vojtech Pavlik
> SuSE Labs
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
