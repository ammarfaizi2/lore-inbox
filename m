Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbQLEJm6>; Tue, 5 Dec 2000 04:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130364AbQLEJms>; Tue, 5 Dec 2000 04:42:48 -0500
Received: from [216.10.14.151] ([216.10.14.151]:27154 "EHLO virtual.vdi.net")
	by vger.kernel.org with ESMTP id <S129610AbQLEJml>;
	Tue, 5 Dec 2000 04:42:41 -0500
Date: Tue, 5 Dec 2000 04:12:18 -0500
From: "J. Nick Koston" <lists@bdraco.org>
To: "Dunlap, Randy" <randy.dunlap@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Nightly usb oops
Message-ID: <20001205041218.A11997@bdraco.org>
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDDD2@orsmsx31.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDDD2@orsmsx31.jf.intel.com>; from randy.dunlap@intel.com on Mon, Dec 04, 2000 at 11:15:49AM -0800
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - virtual.vdi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [514 514] / [514 514]
X-AntiAbuse: Sender Address Domain - virtual.vdi.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

      I'll try pre4 tonight and see (could take up to 48 hours).

This is what I'm getting with test11 in my syslog (at least what I was
able to catch)

hub.c: already running port 3 disabled by hub (EMI?), re-enabling...
usb.c: USB disconnect on device 6
hub.c: USB new device connect on bus1/2/3, assigned device number 11
printer.c: usblp1: USB Bidirectional printer dev 11 if 0 alt 1
usb.c: USB disconnect on device 11
hub.c: USB new device connect on bus1/2/3, assigned device number 12
printer.c: usblp1: USB Bidirectional printer dev 12 if 0 alt 1
usb.c: USB disconnect on device 12
hub.c: USB new device connect on bus1/2/3, assigned device number 13
printer.c: usblp1: USB Bidirectional printer dev 13 if 0 alt 1
hub.c: already running port 3 disabled by hub (EMI?), re-enabling...
usb.c: USB disconnect on device 13
hub.c: USB new device connect on bus1/2/3, assigned device number 14
printer.c: usblp1: USB Bidirectional printer dev 14 if 0 alt 1
hub.c: already running port 3 disabled by hub (EMI?), re-enabling...
usb.c: USB disconnect on device 14
hub.c: USB new device connect on bus1/2/3, assigned device number 15
printer.c: usblp1: USB Bidirectional printer dev 15 if 0 alt 1
hub.c: already running port 3 disabled by hub (EMI?), re-enabling...
usb.c: USB disconnect on device 15
hub.c: USB new device connect on bus1/2/3, assigned device number 16
printer.c: usblp1: USB Bidirectional printer dev 16 if 0 alt 1
hub.c: already running port 3 disabled by hub (EMI?), re-enabling...
usb.c: USB disconnect on device 16
hub.c: USB new device connect on bus1/2/3, assigned device number 17
printer.c: usblp1: USB Bidirectional printer dev 17 if 0 alt 1
hub.c: already running port 3 disabled by hub (EMI?), re-enabling...
usb.c: USB disconnect on device 17
hub.c: USB new device connect on bus1/2/3, assigned device number 18
printer.c: usblp1: USB Bidirectional printer dev 18 if 0 alt 1
hub.c: already running port 3 disabled by hub (EMI?), re-enabling...
usb.c: USB disconnect on device 18
hub.c: USB new device connect on bus1/2/3, assigned device number 19
printer.c: usblp1: USB Bidirectional printer dev 19 if 0 alt 1
hub.c: already running port 3 disabled by hub (EMI?), re-enabling...
usb.c: USB disconnect on device 19
hub.c: USB new device connect on bus1/2/3, assigned device number 20
printer.c: usblp1: USB Bidirectional printer dev 20 if 0 alt 1


Thats a deskjet 932C on the other end.  I don't even use it in linux
:-(

As for pulling anything out of the hub, I'm not touching anything and
its securely plugged into the wall on a UPS.



         Nick




--cpu info---
processor   : 0
vendor_id   : AuthenticAMD
cpu family  : 6
model    : 2
model name  : AMD Athlon(tm) Processor
stepping : 1
cpu MHz     : 853.000658
cache size  : 512 KB
fdiv_bug : no
hlt_bug     : no
f00f_bug : no
coma_bug : no
fpu      : yes
fpu_exception  : yes
cpuid level : 1
wp    : yes
features : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips : 1690.83
-------------

--proc usb devices--
T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  2 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI-alt Root Hub
S:  SerialNumber=d800
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=222/900 us (25%), #Int=  3, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI-alt Root Hub
S:  SerialNumber=d400
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  3 Spd=12  MxCh= 7
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0451 ProdID=1446 Rev= 1.00
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms
T:  Bus=01 Lev=02 Prnt=03 Port=00 Cnt=01 Dev#=  4 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=1645 ProdID=0006 Rev= 1.00
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
T:  Bus=01 Lev=02 Prnt=03 Port=01 Cnt=02 Dev#=  5 Spd=1.5 MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0428 ProdID=4001 Rev= 2.00
S:  Manufacturer=Gravis
S:  Product=GamePad Pro USB 
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   6 Ivl= 10ms
T:  Bus=01 Lev=02 Prnt=03 Port=02 Cnt=03 Dev#= 20 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=03f0 ProdID=1204 Rev= 1.00
S:  Manufacturer=Hewlett-Packard
S:  Product=DeskJet 930C
S:  SerialNumber=MY04S1124VJL
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  2mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=07(print) Sub=01 Prot=01 Driver=usblp
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
I:  If#= 0 Alt= 1 #EPs= 2 Cls=07(print) Sub=01 Prot=02 Driver=usblp
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
T:  Bus=01 Lev=02 Prnt=03 Port=03 Cnt=04 Dev#=  7 Spd=1.5 MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=05c7 ProdID=2011 Rev= 1.12
S:  Manufacturer=QTRONIX
S:  Product=USB Keyboard and Mouse
C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr= 50mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl= 20ms
I:  If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid
E:  Ad=82(I) Atr=03(Int.) MxPS=   3 Ivl= 10ms
T:  Bus=01 Lev=02 Prnt=03 Port=04 Cnt=05 Dev#=  8 Spd=1.5 MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0428 ProdID=4001 Rev= 2.00
S:  Manufacturer=Gravis
S:  Product=GamePad Pro USB 
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   6 Ivl= 10ms
T:  Bus=01 Lev=02 Prnt=03 Port=05 Cnt=06 Dev#=  9 Spd=12  MxCh= 0
D:  Ver= 1.01 Cls=ff(vend.) Sub=ff Prot=ff MxPS= 8 #Cfgs=  1
P:  Vendor=0545 ProdID=8080 Rev= 3.0a
S:  Product=USB IMAGING DEVICE
C:* #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=81(I) Atr=01(Isoc) MxPS=   0 Ivl=  1ms
I:  If#= 0 Alt= 1 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=81(I) Atr=01(Isoc) MxPS=1022 Ivl=  1ms
I:  If#= 1 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=82(I) Atr=02(Bulk) MxPS=   0 Ivl=  1ms
I:  If#= 1 Alt= 1 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=82(I) Atr=02(Bulk) MxPS=1022 Ivl=  1ms
T:  Bus=01 Lev=02 Prnt=03 Port=06 Cnt=07 Dev#= 10 Spd=1.5 MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=045e ProdID=001e Rev= 1.03
S:  Manufacturer=Microsoft
S:  Product=Microsoft IntelliMouse® Explorer
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl= 10ms
-------------------------

On Mon, Dec 04, 2000 at 11:15:49AM -0800, Dunlap, Randy wrote:
> Envelope-to: lists@bdraco.org
> Delivery-date: Mon, 04 Dec 2000 14:17:09 -0500
> From:	"Dunlap, Randy" <randy.dunlap@intel.com>
> To:	"'J. Nick Koston'" <lists@bdraco.org>, linux-kernel@vger.kernel.org
> Subject: RE: Nightly usb oops
> Date:	Mon, 4 Dec 2000 11:15:49 -0800 
> X-Mailer: Internet Mail Service (5.5.2650.21)
> Precedence: bulk
> X-Mailing-List:	linux-kernel@vger.kernel.org
> 
> Hi,
> 
> What kernel (test10)?
> >      -m /boot/System.map-2.4.0-test10 (specified)
> 
> What compiler/version?
> 
> Please post a list of your USB devices from
> /proc/bus/usb/devices .
> 
> Are you inserting or unplugging a USB device when this happens?
> If not, are you doing anything with USB when this happens?
> 
> Thanks,
> ~Randy_________________________________________
> |randy.dunlap_at_intel.com        503-677-5408|
> |NOTE: Any views presented here are mine alone|
> |& may not represent the views of my employer.|
> -----------------------------------------------
> 
> > -----Original Message-----
> > From: J. Nick Koston [mailto:lists@bdraco.org]
> > Sent: Monday, December 04, 2000 7:13 AM
> > To: linux-kernel@vger.kernel.org
> > Subject: Nightly usb oops
> > 
> > 
> > My machine crashes almost every night with this oops.  I've finally
> > managed to catch it before it was totally gone.
> > 
> > 
> > ksymoops 2.3.4 on i686 2.4.0-test10.  Options used
> >      -V (default)
> >      -k /proc/ksyms (default)
> >      -l /proc/modules (default)
> >      -o /lib/modules/2.4.0-test10 (specified)
> >      -m /boot/System.map-2.4.0-test10 (specified)
> > 
> > Warning (compare_maps): snd symbol pm_register not found in 
> > /lib/modules/2.4.0-test10/misc/snd.o.  Ignoring 
> > /lib/modules/2.4.0-test10/misc/snd.o entry
> > Warning (compare_maps): snd symbol pm_send not found in 
> > /lib/modules/2.4.0-test10/misc/snd.o.  Ignoring 
> > /lib/modules/2.4.0-test10/misc/snd.o entry
> > Warning (compare_maps): snd symbol pm_unregister not found in 
> > /lib/modules/2.4.0-test10/misc/snd.o.  Ignoring 
> > /lib/modules/2.4.0-test10/misc/snd.o entry
> >       0fef3340 e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 
> > EndPt=0 Dev=1b, PID=2d(SETUP) (buf=0bd41580)
> ... (many STALL/CRC/Timeouts for Dev=1b, 22, 25) ...
> > Unable to handle kernel NULL pointer dereference at virtual 
> > address 00000014
> > c01faed6
> > *pde = 00000000
> > Oops: 0000
> > CPU:    0
> > EIP:    0010:[<c01faed6>]
> > Using defaults from ksymoops -t elf32-i386 -a i386
> > EFLAGS: 00010282
> > eax: 00000008   ebx: cbd41385   ecx: cbd41380   edx: 00000008
> > esi: 00000000   edi: cfe12400   ebp: 00000001   esp: c14fdf0c
> > ds: 0018   es: 0018   ss: 0018
> > Process khubd (pid: 7, stackpage=c14fd000)
> > Stack: cbd41385 00000000 cfe12400 00000001 00000008 00000000 
> > 00000009 00000000 
> >        00000001 00000000 00000000 c01fb1f3 cfe12400 00000000 
> > cfe12400 c5985802 
> >        cfe12400 00000000 cbd41380 cbd41380 c01fb7f1 cfe12400 
> > 00000001 00000000 
> > Call Trace: [<c01fb1f3>] [<c01fb7f1>] [<c01fcc60>] 
> > [<c01fce32>] [<c0293580>] [<c0293647>] [<c01fcfa5>] 
> >        [<c0105000>] [<c0108c03>] 
> > Code: 8b 42 0c c7 44 24 24 00 00 00 00 0f b6 72 04 39 74 24 24 0f 
> > 
> > >>EIP; c01faed6 <usb_set_maxpacket+46/120>   <=====
> > Trace; c01fb1f3 <usb_set_configuration+e3/f0>
> > Trace; c01fb7f1 <usb_new_device+171/1d0>
> > Trace; c01fcc60 <usb_hub_port_connect_change+270/300>
> > Trace; c01fce32 <usb_hub_events+142/270>
> > Trace; c0293580 <usb_bandwidth_option+1bf8/28ec>
> > Trace; c0293647 <usb_bandwidth_option+1cbf/28ec>
> > Trace; c01fcfa5 <usb_hub_thread+45/70>
> > Trace; c0105000 <empty_bad_page+0/1000>
> > Trace; c0108c03 <kernel_thread+23/30>
> > Code;  c01faed6 <usb_set_maxpacket+46/120>
> > 00000000 <_EIP>:
> > Code;  c01faed6 <usb_set_maxpacket+46/120>   <=====
> >    0:   8b 42 0c                  mov    0xc(%edx),%eax   <=====
> > Code;  c01faed9 <usb_set_maxpacket+49/120>
> >    3:   c7 44 24 24 00 00 00      movl   $0x0,0x24(%esp,1)
> > Code;  c01faee0 <usb_set_maxpacket+50/120>
> >    a:   00 
> > Code;  c01faee1 <usb_set_maxpacket+51/120>
> >    b:   0f b6 72 04               movzbl 0x4(%edx),%esi
> > Code;  c01faee5 <usb_set_maxpacket+55/120>
> >    f:   39 74 24 24               cmp    %esi,0x24(%esp,1)
> > Code;  c01faee9 <usb_set_maxpacket+59/120>
> >   13:   0f 00 00                  sldt   (%eax)
> > 
> > Unable to handle kernel NULL pointer dereference at virtual 
> > address 00000008
> > c013ed99
> > *pde = 00000000
> > Oops: 0000
> > CPU:    0
> > EIP:    0010:[<c013ed99>]
> > EFLAGS: 00010246
> > eax: 00000008   ebx: 00000000   ecx: 0000000c   edx: 00000002
> > esi: 00000000   edi: 00000000   ebp: 00000008   esp: c36f3f08
> > ds: 0018   es: 0018   ss: 0018
> > Process initlog (pid: 532, stackpage=c36f3000)
> > Stack: c36f2000 00000000 00000002 00000000 0000000c 0000000e 
> > c013eec3 00000002 
> >        00000008 c36f3f48 c36f3f4c c36f2000 00000002 00000002 
> > 00000000 c36f2000 
> >        00000000 00000000 c013f133 00000002 00000000 00000002 
> > cbd41140 c36f3fb8 
> > Call Trace: [<c013eec3>] [<c013f133>] [<c01203ed>] [<c010a637>] 
> > Code: 8b 45 00 85 c0 7c 59 e8 6b 1f ff ff 89 c6 bb 20 00 00 00 85 
> > 
> > >>EIP; c013ed99 <do_pollfd+29/b0>   <=====
> > Trace; c013eec3 <do_poll+a3/e0>
> > Trace; c013f133 <sys_poll+233/350>
> > Trace; c01203ed <sys_nanosleep+10d/190>
> > Trace; c010a637 <system_call+33/38>
> > Code;  c013ed99 <do_pollfd+29/b0>
> > 00000000 <_EIP>:
> > Code;  c013ed99 <do_pollfd+29/b0>   <=====
> >    0:   8b 45 00                  mov    0x0(%ebp),%eax   <=====
> > Code;  c013ed9c <do_pollfd+2c/b0>
> >    3:   85 c0                     test   %eax,%eax
> > Code;  c013ed9e <do_pollfd+2e/b0>
> >    5:   7c 59                     jl     60 <_EIP+0x60> 
> > c013edf9 <do_pollfd+89/b0>
> > Code;  c013eda0 <do_pollfd+30/b0>
> >    7:   e8 6b 1f ff ff            call   ffff1f77 
> > <_EIP+0xffff1f77> c0130d10 <fget+0/30>
> > Code;  c013eda5 <do_pollfd+35/b0>
> >    c:   89 c6                     mov    %eax,%esi
> > Code;  c013eda7 <do_pollfd+37/b0>
> >    e:   bb 20 00 00 00            mov    $0x20,%ebx
> > Code;  c013edac <do_pollfd+3c/b0>
> >   13:   85 00                     test   %eax,(%eax)
> > 
> > Unable to handle kernel NULL pointer dereference at virtual 
> > address 00000040
> > c013ed99
> > *pde = 00000000
> > Oops: 0000
> > CPU:    0
> > EIP:    0010:[<c013ed99>]
> > EFLAGS: 00210246
> > eax: 00000040   ebx: 00000000   ecx: 00000044   edx: 00000006
> > esi: 00000000   edi: 00000000   ebp: 00000040   esp: c09a7f08
> > ds: 0018   es: 0018   ss: 0018
> > Process deskguide_apple (pid: 835, stackpage=c09a7000)
> > Stack: c09a6000 00000000 00000006 00000000 00000044 00000046 
> > c013eec3 00000006 
> >        00000040 c09a7f48 c09a7f4c c09a6000 00000006 00000006 
> > 00000000 c09a6000 
> >        00000000 00000000 c013f133 00000006 00000000 00000006 
> > cbd41880 c09a7fb8 
> > Call Trace: [<c013eec3>] [<c013f133>] [<c010a637>] 
> > Code: 8b 45 00 85 c0 7c 59 e8 6b 1f ff ff 89 c6 bb 20 00 00 00 85 
> > 
> > >>EIP; c013ed99 <do_pollfd+29/b0>   <=====
> > Trace; c013eec3 <do_poll+a3/e0>
> > Trace; c013f133 <sys_poll+233/350>
> > Trace; c010a637 <system_call+33/38>
> > Code;  c013ed99 <do_pollfd+29/b0>
> > 00000000 <_EIP>:
> > Code;  c013ed99 <do_pollfd+29/b0>   <=====
> >    0:   8b 45 00                  mov    0x0(%ebp),%eax   <=====
> > Code;  c013ed9c <do_pollfd+2c/b0>
> >    3:   85 c0                     test   %eax,%eax
> > Code;  c013ed9e <do_pollfd+2e/b0>
> >    5:   7c 59                     jl     60 <_EIP+0x60> 
> > c013edf9 <do_pollfd+89/b0>
> > Code;  c013eda0 <do_pollfd+30/b0>
> >    7:   e8 6b 1f ff ff            call   ffff1f77 
> > <_EIP+0xffff1f77> c0130d10 <fget+0/30>
> > Code;  c013eda5 <do_pollfd+35/b0>
> >    c:   89 c6                     mov    %eax,%esi
> > Code;  c013eda7 <do_pollfd+37/b0>
> >    e:   bb 20 00 00 00            mov    $0x20,%ebx
> > Code;  c013edac <do_pollfd+3c/b0>
> >   13:   85 00                     test   %eax,(%eax)
> > 
> > 
> > 3 warnings issued.  Results may not be reliable.
> > -
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
