Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbTIMP0q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 11:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbTIMP0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 11:26:45 -0400
Received: from kogut.o2.pl ([212.126.20.60]:39305 "EHLO kogut.o2.pl")
	by vger.kernel.org with ESMTP id S261211AbTIMP0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 11:26:37 -0400
Message-ID: <3F633724.8050907@o2.pl>
Date: Sat, 13 Sep 2003 17:26:28 +0200
From: Tom Czerwinski <bs0d@o2.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [2.6.0-test5-bk2] [PROBLEM] - usblp with Lexmark Z35
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello List!

	My experience with 2.6.0 is a nearly success story but I'm stuck with
printer fault.
	I've installed lexmark drivers for Z35 - everything works with 2.4.20
kernel. But with 2.6.0 printer is strangely behaving -  when I start
print job the printer powers on, gets paper, and starts to print. Only
(about 1,5 cm) bar on top of page is printed (left side is correct and
right - some noise), after that printer stops responding.
	
Regards.


RedHat 9
2.6.0-test5-bk2
gcc 3.2.2
modutils 2.4.25
hotplug-2003_08_05-1_rh9
hotplug-base-2003_08_05
module-init-tools-0.9.14
usbutils-0.11-1

cat /proc/kmsg:

<6>drivers/usb/core/usb.c: registered new driver usbfs
<6>drivers/usb/core/usb.c: registered new driver hub
<6>drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface
driver v2.1
<6>uhci-hcd 0000:00:11.4: UHCI Host Controller
<6>uhci-hcd 0000:00:11.4: irq 5, io base 0000dc00
<6>uhci-hcd 0000:00:11.4: new USB bus registered, assigned bus number 1
<6>drivers/usb/host/uhci-hcd.c: detected 2 ports
<7>uhci-hcd 0000:00:11.4: root hub device address 1
<7>usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
<7>drivers/usb/core/message.c: USB device number 1 default language ID 0x409
<6>usb usb1: Product: UHCI Host Controller
<6>usb usb1: Manufacturer: Linux 2.6.0-test5-bk2-debug uhci-hcd
<6>usb usb1: SerialNumber: 0000:00:11.4
<7>usb usb1: usb_new_device - registering interface 1-0:0
<7>hub 1-0:0: usb_probe_interface
<7>hub 1-0:0: usb_probe_interface - got id
<6>hub 1-0:0: USB hub found
<6>hub 1-0:0: 2 ports detected
<7>hub 1-0:0: standalone hub
<7>hub 1-0:0: ganged power switching
<7>hub 1-0:0: global over-current protection
<7>hub 1-0:0: Port indicators are not supported
<7>hub 1-0:0: power on to power good time: 2ms
<7>hub 1-0:0: hub controller current requirement: 0mA
<7>hub 1-0:0: local power source is good
<7>hub 1-0:0: no over-current condition exists
<7>hub 1-0:0: enabling power on all ports
<7>hub 1-0:0: port 1, status 100, change 3, 12 Mb/s
<7>hub 1-0:0: port 2, status 101, change 3, 12 Mb/s
<6>hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
<6>hub 1-0:0: new USB device on port 2, assigned address 2
<7>usb 1-2: new device strings: Mfr=1, Product=2, SerialNumber=0
<7>drivers/usb/core/message.c: USB device number 2 default language ID 0x409
<6>usb 1-2: Product: Inkjet color printer
<6>usb 1-2: Manufacturer: Lexmark
<7>usb 1-2: usb_new_device - registering interface 1-2:0
<7>hub 1-0:0: port 1 enable change, status 100
<7>usblp 1-2:0: usb_probe_interface
<7>usblp 1-2:0: usb_probe_interface - got id
<6>drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if
0 alt 0 proto 2 vid 0x043D pid 0x0057
<7>drivers/usb/core/file.c: looking for a minor, starting at 0
<6>drivers/usb/core/usb.c: registered new driver usblp
<6>drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver


cat /proc/bus/usb/devices:

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.0-test5-bk2-debug uhci-hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:11.4
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=043d ProdID=0057 Rev= 1.00
S:  Manufacturer=Lexmark
S:  Product=Inkjet color printer
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  4mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=07(print) Sub=01 Prot=02 Driver=usblp
E:  Ad=05(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS=  16 Ivl=0ms


lspci:

00:00.0 Host bridge: VIA Technologies, Inc. VT8375 [KM266] Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP]
00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
04)
00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port
(rev 01)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus
Master IDE (rev 06)
00:11.4 USB Controller: VIA Technologies, Inc. USB (rev 1b)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97
Audio Controller (rev 30)
01:00.0 VGA compatible controller: S3 Inc. [ProSavageDDR K4M266]

lsmod:

Module                  Size  Used by
floppy                 59796  0
usblp                  13440  1
ipt_REJECT              6912  2
iptable_filter          2944  1
ip_tables              17552  2 ipt_REJECT,iptable_filter
uhci_hcd               31496  0
ohci_hcd               18176  0
ehci_hcd               24320  0
usbcore               107860  7 usblp,uhci_hcd,ohci_hcd,ehci_hcd
sr_mod                 17824  0
ide_scsi               15872  0
scsi_mod               83480  2 sr_mod,ide_scsi
ide_cd                 41088  0
cdrom                  36000  2 sr_mod,ide_cd
nls_iso8859_1           4224  1
nls_cp437               5888  1
vfat                   15232  1
fat                    46880  1 vfat
nls_utf8                2176  1



