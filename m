Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWFLHaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWFLHaQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 03:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbWFLHaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 03:30:15 -0400
Received: from munin.agotnes.com ([202.173.149.60]:52904 "EHLO
	mail.agotnes.com") by vger.kernel.org with ESMTP id S1751035AbWFLHaN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 03:30:13 -0400
Message-ID: <448D17DC.5000400@agotnes.com>
Date: Mon, 12 Jun 2006 17:29:32 +1000
From: Johny <kernel@agotnes.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
CC: =?ISO-8859-1?Q?Johny_=C5gotnes?= <kernel@agotnes.com>
Subject: Re: 2.6.17-rc5-mm3 - USB issues
References: <448B7A88.5070009@agotnes.com>
In-Reply-To: <448B7A88.5070009@agotnes.com>
Content-Type: multipart/mixed;
 boundary="------------040902090504040108030908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040902090504040108030908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Further to this, I tested with 2.6.17-rc6-mm2 today, no changes. I've 
attached as .txt files the following;

lsusb output for both a 2.6.16 kernel and the 2.6.17-rc6-mm2 kernel
/proc/bus/usb/devices output, again for the same kernels.

Noting that there are a lot less devices in the -mm kernel due to the 
error below.

Again, any further debugging I can provide, just let me know!

:)J

Please advise

Johny Ågotnes wrote:
> All,
> 
> My USB hub isn't recognised with the latest -mm series, whereas with 
> 2.6.16 vanilla it is picked up & used immediately.
> 
> The error I get in dmesg is;
> 
> hub 4-0:1.0: USB hub found
> hub 4-0:1.0: 2 ports detected
> usb 1-4: new high speed USB device using ehci_hcd and address 3
> ehci_hcd 0000:00:10.3: Unlink after no-IRQ?  Controller is probably 
> using the wrong IRQ.
> usb 1-4: device not accepting address 3, error -110
> usb 1-4: new high speed USB device using ehci_hcd and address 4
> usb 1-4: device not accepting address 4, error -110
> usb 1-4: new high speed USB device using ehci_hcd and address 5
> usb 1-4: device not accepting address 5, error -110
> usb 1-4: new high speed USB device using ehci_hcd and address 6
> usb 1-4: device not accepting address 6, error -110
> usb 2-2: new full speed USB device using uhci_hcd and address 2
> 
> Which seems to be related to my Belkin hub. The full USB related dmesg 
> information can be found below, I'm happy to provide further debugging 
> information as required :)
> 
> ACPI (acpi_bus-0192): Device `USB9]is not power manageable [20060310]
> ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
> PCI: setting IRQ 10 as level-triggered
> ACPI: PCI Interrupt 0000:00:10.3[D] -> Link [LNKD] -> GSI 10 (level, 
> low) -> IRQ 10
> ehci_hcd 0000:00:10.3: EHCI Host Controller
> ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
> ehci_hcd 0000:00:10.3: irq 10, io mem 0xea022000
> ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
> usb usb1: new device found, idVendor=0000, idProduct=0000
> usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb1: Product: EHCI Host Controller
> usb usb1: Manufacturer: Linux 2.6.17-rc5-mm3 ehci_hcd
> usb usb1: SerialNumber: 0000:00:10.3
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 6 ports detected
> USB Universal Host Controller Interface driver v3.0
> ACPI (acpi_bus-0192): Device `USB6]is not power manageable [20060310]
> ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKA] -> GSI 11 (level, 
> low) -> IRQ 11
> uhci_hcd 0000:00:10.0: UHCI Host Controller
> uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
> uhci_hcd 0000:00:10.0: irq 11, io base 0x0000d000
> usb usb2: new device found, idVendor=0000, idProduct=0000
> usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb2: Product: UHCI Host Controller
> usb usb2: Manufacturer: Linux 2.6.17-rc5-mm3 uhci_hcd
> usb usb2: SerialNumber: 0000:00:10.0
> usb usb2: configuration #1 chosen from 1 choice
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 2 ports detected
> ACPI (acpi_bus-0192): Device `USB7]is not power manageable [20060310]
> ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
> ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [LNKB] -> GSI 11 (level, 
> low) -> IRQ 11
> uhci_hcd 0000:00:10.1: UHCI Host Controller
> uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
> uhci_hcd 0000:00:10.1: irq 11, io base 0x0000d400
> usb usb3: new device found, idVendor=0000, idProduct=0000
> usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb3: Product: UHCI Host Controller
> usb usb3: Manufacturer: Linux 2.6.17-rc5-mm3 uhci_hcd
> usb usb3: SerialNumber: 0000:00:10.1
> usb usb3: configuration #1 chosen from 1 choice
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 2 ports detected
> ACPI (acpi_bus-0192): Device `USB8]is not power manageable [20060310]
> ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
> ACPI: PCI Interrupt 0000:00:10.2[C] -> Link [LNKC] -> GSI 10 (level, 
> low) -> IRQ 10
> uhci_hcd 0000:00:10.2: UHCI Host Controller
> uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
> uhci_hcd 0000:00:10.2: irq 10, io base 0x0000d800
> usb usb4: new device found, idVendor=0000, idProduct=0000
> usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb4: Product: UHCI Host Controller
> usb usb4: Manufacturer: Linux 2.6.17-rc5-mm3 uhci_hcd
> usb usb4: SerialNumber: 0000:00:10.2
> usb usb4: configuration #1 chosen from 1 choice
> hub 4-0:1.0: USB hub found
> hub 4-0:1.0: 2 ports detected
> usb 1-4: new high speed USB device using ehci_hcd and address 3
> ehci_hcd 0000:00:10.3: Unlink after no-IRQ?  Controller is probably 
> using the wrong IRQ.
> usb 1-4: device not accepting address 3, error -110
> usb 1-4: new high speed USB device using ehci_hcd and address 4
> usb 1-4: device not accepting address 4, error -110
> usb 1-4: new high speed USB device using ehci_hcd and address 5
> usb 1-4: device not accepting address 5, error -110
> usb 1-4: new high speed USB device using ehci_hcd and address 6
> usb 1-4: device not accepting address 6, error -110
> usb 2-2: new full speed USB device using uhci_hcd and address 2
> usb 2-2: new device found, idVendor=0731, idProduct=0528
> usb 2-2: new device strings: Mfr=0, Product=0, SerialNumber=0
> usb 2-2: configuration #1 chosen from 1 choice
> usbcore: registered new driver usblp
> drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
> Initializing USB Mass Storage driver...
> usbcore: registered new driver usb-storage
> USB Mass Storage support registered.
> usbcore: registered new driver usbhid
> drivers/usb/input/hid-core.c: v2.6:USB HID core driver
> 

--------------040902090504040108030908
Content-Type: text/plain;
 name="usb-dev-16.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="usb-dev-16.txt"


T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.16-gentoo-r7 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:10.2
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.16-gentoo-r7 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:10.1
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.16-gentoo-r7 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:10.0
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0731 ProdID=0528 Rev= 0.01
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E:  Ad=81(I) Atr=03(Int.) MxPS=  10 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
B:  Alloc=  0/800 us ( 0%), #Int=  1, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.16-gentoo-r7 ehci_hcd
S:  Product=EHCI Host Controller
S:  SerialNumber=0000:00:10.3
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms

T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  3 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=6017 ProdID=2230 Rev=c5.bd
S:  Manufacturer=Sunplus Technology Inc.
S:  Product=USB to Serial-ATA bridge
S:  SerialNumber=External D000FFFF_00000000_0_A
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  2mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=usb-storage
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

T:  Bus=01 Lev=01 Prnt=01 Port=03 Cnt=02 Dev#=  4 Spd=480 MxCh= 7
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=02 MxPS=64 #Cfgs=  1
P:  Vendor=050d ProdID=0237 Rev= 0.00
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  2mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=01 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=256ms
I:  If#= 0 Alt= 1 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=02 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=256ms

T:  Bus=01 Lev=02 Prnt=04 Port=01 Cnt=01 Dev#=  5 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=05a9 ProdID=4519 Rev= 1.00
S:  Manufacturer=OmniVision Technologies, Inc.
S:  Product=USB Camera
C:* #Ifs= 3 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E:  Ad=81(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 0 Alt= 1 #EPs= 1 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E:  Ad=81(I) Atr=01(Isoc) MxPS= 384 Ivl=1ms
I:  If#= 0 Alt= 2 #EPs= 1 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E:  Ad=81(I) Atr=01(Isoc) MxPS= 512 Ivl=1ms
I:  If#= 0 Alt= 3 #EPs= 1 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E:  Ad=81(I) Atr=01(Isoc) MxPS= 768 Ivl=1ms
I:  If#= 0 Alt= 4 #EPs= 1 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E:  Ad=81(I) Atr=01(Isoc) MxPS= 896 Ivl=1ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=(none)
I:  If#= 2 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00 Driver=(none)
I:  If#= 2 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=(none)
E:  Ad=82(I) Atr=05(Isoc) MxPS=  40 Ivl=1ms

T:  Bus=01 Lev=02 Prnt=04 Port=02 Cnt=02 Dev#=  6 Spd=12  MxCh= 0
D:  Ver= 1.01 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=13b1 ProdID=001d Rev= 1.40
S:  Manufacturer=LINKSYS
S:  Product=Linksys CIT200
S:  SerialNumber=USBGAP00000000000000000000166124961
C:* #Ifs= 4 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=(none)
I:  If#= 1 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00 Driver=(none)
I:  If#= 1 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=(none)
E:  Ad=02(O) Atr=05(Isoc) MxPS=  64 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00 Driver=(none)
I:  If#= 2 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=(none)
E:  Ad=81(I) Atr=05(Isoc) MxPS=  64 Ivl=1ms
I:  If#= 3 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=(none)
E:  Ad=83(I) Atr=03(Int.) MxPS=  64 Ivl=255ms

T:  Bus=01 Lev=02 Prnt=04 Port=05 Cnt=03 Dev#=  7 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a12 ProdID=0001 Rev= 2.72
C:* #Ifs= 3 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)

--------------040902090504040108030908
Content-Type: text/plain;
 name="usb-dev-mm.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="usb-dev-mm.txt"


T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.17-rc6-mm2 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:10.2
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.17-rc6-mm2 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:10.1
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.17-rc6-mm2 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:10.0
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0731 ProdID=0528 Rev= 0.01
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E:  Ad=81(I) Atr=03(Int.) MxPS=  10 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.17-rc6-mm2 ehci_hcd
S:  Product=EHCI Host Controller
S:  SerialNumber=0000:00:10.3
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms

--------------040902090504040108030908
Content-Type: text/plain;
 name="lsusb-16.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lsusb-16.txt"

Bus 004 Device 001: ID 0000:0000  
Bus 003 Device 001: ID 0000:0000  
Bus 002 Device 002: ID 0731:0528 Susteen, Inc. SonyEricsson DCU-11 Cable
Bus 002 Device 001: ID 0000:0000  
Bus 001 Device 007: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)
Bus 001 Device 006: ID 13b1:001d Linksys 
Bus 001 Device 005: ID 05a9:4519 OmniVision Technologies, Inc. 
Bus 001 Device 004: ID 050d:0237 Belkin Components 
Bus 001 Device 003: ID 6017:2230  
Bus 001 Device 001: ID 0000:0000  

--------------040902090504040108030908
Content-Type: text/plain;
 name="lsusb-mm.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lsusb-mm.txt"

Bus 004 Device 001: ID 0000:0000  
Bus 003 Device 001: ID 0000:0000  
Bus 002 Device 002: ID 0731:0528 Susteen, Inc. SonyEricsson DCU-11 Cable
Bus 002 Device 001: ID 0000:0000  
Bus 001 Device 001: ID 0000:0000  

--------------040902090504040108030908--
