Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265175AbUFVUMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265175AbUFVUMK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbUFVUKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 16:10:06 -0400
Received: from smtp-out7.xs4all.nl ([194.109.24.8]:4104 "EHLO
	smtp-out7.xs4all.nl") by vger.kernel.org with ESMTP id S265880AbUFVT6e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 15:58:34 -0400
Message-ID: <40D88F79.6010309@zwanebloem.nl>
Date: Tue, 22 Jun 2004 21:58:49 +0200
From: Tommy Faasen <tommy@zwanebloem.nl>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-usb-devel@lists.sourceforge.net,
       linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [bug?] usb device ok with ohci, fails to accept an address with uhci
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-zwanebloem-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a sweex usb-wifi stick see also 
http://sourceforge.net/projects/linux-lc100020/ and it's forums.
And I have 2 machines
Machine 1: Via kt133a chipset  -> uhci_hcd
Machine 2:  Sis 748 Chipset -> ohci_hcd

The device works without a problem on machine 2 with at least kernels 
2.6.6 and 2.6.7.
The usb wifi stick fails to accept an address on machine 1. There is a 
good faq about it with things you can try. (turn off acpi, irq for usb, 
no irq sharing, removing all pci cards,etc) I tried everything but with 
no luck.
I tried kernels 2.4.26 till and including 2.6.7 without luck, however on 
the same machine is also connected an usb joystick that works without a 
problem, so my usb does work.

The usb wifi stick is known to need to get a descriptor before settings 
it's address but even with this patch I can't get it to work ( I didn't 
need the patch for machine 2).

I read some usb specs/docs kernel usb stuff, but since I'm no expert I 
cannot see where the problem is, therefore posted below is some 
information that hopefully is helpfull to you.

Please let me know what else I can do to help,

Tommy

Dmesg output:
uhci_hcd 0000:00:07.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller
uhci_hcd 0000:00:07.2: irq 10, io base 0000d400
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: detected 2 ports
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: default language 0x0409
usb usb1: Product: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
usb usb1: Manufacturer: Linux 2.6.7 uhci_hcd
usb usb1: SerialNumber: 0000:00:07.2
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: local power source is good
PCI: Found IRQ 10 for device 0000:00:07.3
PCI: Sharing IRQ 10 with 0000:00:07.2
PCI: Sharing IRQ 10 with 0000:00:0d.0
PCI: Sharing IRQ 10 with 0000:00:0b.0
uhci_hcd 0000:00:07.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (#2)
uhci_hcd 0000:00:07.3: irq 10, io base 0000d800
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:07.3: detected 2 ports
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: default language 0x0409
usb usb2: Product: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (#2)
usb usb2: Manufacturer: Linux 2.6.7 uhci_hcd
usb usb2: SerialNumber: 0000:00:07.3
usb usb2: hotplug
usb usb2: adding 2-0:1.0 (cuhci_hcd 0000:00:07.2: port 1 portsc 01ab
hub 1-0:1.0: port 1, status 0301, change 0003, 1.5 Mb/s
uhci_hcd 0000:00:07.2: port 1 portsc 01a9
uhci_hcd 0000:00:07.2: port 1 portsc 01a9
uhci_hcd 0000:00:07.2: port 1 portsc 01a9
usb 2-0:1.0: hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: individual port over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
uhci_hcd 0000:00:07.2: port 1 portsc 01a9
uhci_hcd 0000:00:07.2: port 1 portsc 01a9
hub 1-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x301
usb 1-1: new low speed USB device using address 2
usb 1-1: skipped 1 descriptor after interface
usb 1-1: new device strings: Mfr=4, Product=32, SerialNumber=0
usb 1-1: default language 0x0409
usb 1-1: Product: WingMan Gamepad
usb 1-1: Manufacturer: Logitech Inc.
usb 1-1: hotplug
usb 1-1: adding 1-1:1.0 (config #1, interface 0)
usb 1-1:1.0: hotplug
uhci_hcd 0000:00:07.2: port 2 portsc 018a
hub 1-0:1.0: port 2, status 0300, change 0003, 1.5 Mb/s
uhci_hcd 0000:00:07.2: port 2 portsc 0188
hub 1-0:1.0: port 2 enable change, status 00000300
uhci_hcd 0000:00:07.3: port 1 portsc 018a
hub 2-0:1.0: port 1, status 0300, change 0003, 1.5 Mb/s
uhci_hcd 0000:00:07.3: port 2 portsc 008a
hub 2-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
uhci_hcd 0000:00:07.3: port 1 portsc 0188
hub 2-0:1.0: port 1 enable change, status 00000300
uhci_hcd 0000:00:07.3: port 2 portsc 0088
hub 2-0:1.0: port 2 enable change, status 00000100
uhci_hcd 0000:00:07.3: suspend_hc
uhci_hcd 0000:00:07.2: port 2 portsc 0093
hub 1-0:1.0: port 2, status 0101, change 0001, 12 Mb/s
hub 1-0:1.0: debounce: port 2: delay 100ms stable 4 status 0x101
usb 1-2: new full speed USB device using address 3
uhci_hcd 0000:00:07.2: uhci_result_control: failed with status 440000
[e6fe4240] link (26fe41e2) element (26fe3040)
  0: [e6fe3040] link (26fe3080) e0 Stalled CRC/Timeo Length=7 MaxLen=7 
DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=255aeec8)
  1: [e6fe3080] link (26fe30c0) e3 SPD Active Length=0 MaxLen=7 DT1 
EndPt=0 Dev=0, PID=69(IN) (buf=273ddf14)
  2: [e6fe30c0] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 
EndPt=0 Dev=0, PID=e1(OUT) (buf=00000000)

uhci_hcd 0000:00:07.2: uhci_result_control: failed with status 440000
[e6fe4240] link (26fe41e2) element (26fe3040)
  0: [e6fe3040] link (26fe3080) e0 Stalled CRC/Timeo Length=7 MaxLen=7 
DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=255aeec8)
  1: [e6fe3080] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 
EndPt=0 Dev=0, PID=69(IN) (buf=00000000)

uhci_hcd 0000:00:07.2: uhci_result_control: failed with status 440000
[e6fe4240] link (26fe41e2) element (26fe3040)
  0: [e6fe3040] link (26fe3080) e0 Stalled CRC/Timeo Length=7 MaxLen=7 
DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=255aeec8)
  1: [e6fe3080] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 
EndPt=0 Dev=0, PID=69(IN) (buf=00000000)

usb 1-2: device not accepting address 3, error -71
usb 1-2: new full speed USB device using address 4
uhci_hcd 0000:00:07.2: uhci_result_control: failed with status 440000
[e6fe4240] link (26fe41e2) element (26fe3040)
  0: [e6fe3040] link (26fe3080) e0 Stalled CRC/Timeo Length=7 MaxLen=7 
DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=255aeec8)
  1: [e6fe3080] link (26fe30c0) e3 SPD Active Length=0 MaxLen=7 DT1 
EndPt=0 Dev=0, PID=69(IN) (buf=273ddf14)
  2: [e6fe30c0] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 
EndPt=0 Dev=0, PID=e1(OUT) (buf=00000000)

uhci_hcd 0000:00:07.2: uhci_result_control: failed with status 440000
[e6fe4240] link (26fe41e2) element (26fe3040)
  0: [e6fe3040] link (26fe3080) e0 Stalled CRC/Timeo Length=7 MaxLen=7 
DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=255aeec8)
  1: [e6fe3080] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 
EndPt=0 Dev=0, PID=69(IN) (buf=00000000)

uhci_hcd 0000:00:07.2: uhci_result_control: failed with status 440000
[e6fe4240] link (26fe41e2) element (26fe3040)
  0: [e6fe3040] link (26fe3080) e0 Stalled CRC/Timeo Length=7 MaxLen=7 
DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=255aeec8)
  1: [e6fe3080] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 
EndPt=0 Dev=0, PID=69(IN) (buf=00000000)

usb 1-2: device not accepting address 4, error -71
uhci_hcd 0000:00:07.2: port 2 portsc 008a
hub 1-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
uhci_hcd 0000:00:07.2: port 2 portsc 0088

lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] 
(rev 03)
        Flags: bus master, medium devsel, latency 8
        Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] 
(prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: da000000-dbffffff
        Prefetchable memory behind bridge: d8000000-d9ffffff
        Capabilities: [80] Power Management version 2

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. Bus Master IDE
        Flags: bus master, medium devsel, latency 32
        I/O ports at d000 [size=16]
        Capabilities: [c0] Power Management version 2

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
        Flags: medium devsel, IRQ 7
        Capabilities: [68] Power Management version 2

00:09.0 SCSI storage controller: Adaptec AHA-2940U2/W
        Subsystem: Adaptec: Unknown device a180
        Flags: bus master, medium devsel, latency 32, IRQ 11
        BIST result: 00
        I/O ports at dc00 [disabled] [size=256]
        Memory at dd200000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1

00:0d.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 05)
        Subsystem: Compaq Computer Corporation NC3120
        Flags: bus master, medium devsel, latency 32, IRQ 10
        Memory at dd203000 (32-bit, prefetchable) [size=4K]
        I/O ports at ec00 [size=32]
        Memory at dd100000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 1

01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 
15) (prog-if 00 [VGA])
        Subsystem: Unknown device 17f2:4010
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 5
        Memory at da000000 (32-bit, non-prefetchable) [size=16M]
        Memory at d8000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
        Capabilities: [44] AGP version 2.0

cat /proc/bus/usb/devices

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.7 uhci_hcd
S:  Product=VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
S:  SerialNumber=0000:00:07.3
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.7 uhci_hcd
S:  Product=VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
S:  SerialNumber=0000:00:07.2
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=c209 Rev= 1.03
S:  Manufacturer=Logitech Inc.
S:  Product=WingMan Gamepad
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr= 40mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=(none)
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms

cat /proc/interrupts
           CPU0
  0:    2040665          XT-PIC  timer
  1:          8          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
 10:      71185          XT-PIC  EMU10K1, uhci_hcd, uhci_hcd, eth1
 11:      19586          XT-PIC  aic7xxx
 12:      30728          XT-PIC  Bt87x audio, bttv0, eth0
 15:         18          XT-PIC  ide1
NMI:          0
LOC:    2040654
ERR:       2234
MIS:          0





