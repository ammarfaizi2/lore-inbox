Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbUCIOKA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 09:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbUCIOJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 09:09:59 -0500
Received: from meel.advalvas.be ([194.7.83.67]:52921 "EHLO meel.advalvas.be")
	by vger.kernel.org with ESMTP id S261952AbUCIOIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 09:08:31 -0500
Message-ID: <7384.194.7.240.2.1078841308.squirrel@webmail.advalvas.be>
Date: Tue, 9 Mar 2004 15:08:28 +0100 (CET)
Subject: problem: 2.6.3 USB keyboard not always detected
From: lode.leroy@advalvas.be
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Most of the time, my Logitech USB Keyboard is not detected on boot.
(it's a network boot, and it does ALWAYS work for accessing BIOS and
PXEGRUB boot menu)
After the kernel is booted, I almost always get
hid: probe of 2-1:1.1 failed with error -5

unplugging and re-plugging the keyboard sometimes fixes the problem.
(doing it enough times ALWAYS gets it working, but it's
kind of annoying :-)

I didn't see that with 2.6.0-test2, which is the previous kernel I used on
that machine...

The kernel is compiled without module support, so maybe
something is not getting run in the right order during boot?

-- lode
PS: attached is a big chunk of dmesg output...
uname -a = Linux 2.6.3 #4 Thu Mar 4 14:22:17 CET 2004 i686 unknown

hub 1-0:1.0: global over-current protection
hub 1-0:1.0: Port indicators are not supported
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: hub controller current requirement: 0mA
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: enabling power on all ports
ohci_hcd 0000:00:01.2: created debug files
ohci_hcd 0000:00:01.2: OHCI controller state
ohci_hcd 0000:00:01.2: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:01.2: control 0x083 HCFS=operational CBSR=3
ohci_hcd 0000:00:01.2: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:01.2: intrstatus 0x00000004 SF
ohci_hcd 0000:00:01.2: intrenable 0x80000002 MIE WDH
ohci_hcd 0000:00:01.2: hcca frame #0010
ohci_hcd 0000:00:01.2: roothub.a 01000203 POTPGT=1 NPS NDP=3
ohci_hcd 0000:00:01.2: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:01.2: roothub.status 00000000
ohci_hcd 0000:00:01.2: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:01.2: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:01.2: roothub.portstatus [2] 0x00000100 PPS
PCI: Found IRQ 9 for device 0000:00:01.3
PCI: Sharing IRQ 9 with 0000:00:01.2
ohci_hcd 0000:00:01.3: OHCI Host Controller
ohci_hcd 0000:00:01.3: reset, control = 0x0
ohci_hcd 0000:00:01.3: irq 9, pci mem cc804000
ohci_hcd 0000:00:01.3: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:01.3: root hub device address 1
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
/usr/src/linux-2.6.3/drivers/usb/core/message.c: USB device number 1
default lan
guage ID 0x409
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.3 ohci_hcd
usb usb2: SerialNumber: 0000:00:01.3
usb usb2: registering 2-0:1.0 (config #1, interface 0)
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: unknown reserved power switching mode
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: Port indicators are not supported
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: hub controller current requirement: 0mA
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
hub 2-0:1.0: enabling power on all ports
ohci_hcd 0000:00:01.3: created debug files
ohci_hcd 0000:00:01.3: OHCI controller state
ohci_hcd 0000:00:01.3: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:01.3: control 0x083 HCFS=operational CBSR=3
ohci_hcd 0000:00:01.3: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:01.3: intrstatus 0x00000044 RHSC SF
ohci_hcd 0000:00:01.3: intrenable 0x80000002 MIE WDH
ohci_hcd 0000:00:01.3: hcca frame #0011
ohci_hcd 0000:00:01.3: roothub.a 01000203 POTPGT=1 NPS NDP=3
ohci_hcd 0000:00:01.3: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:01.3: roothub.status 00000000
ohci_hcd 0000:00:01.3: roothub.portstatus [0] 0x00010301 CSC SDA PPS CCS
ohci_hcd 0000:00:01.3: roothub.portstatus [1] 0x00010301 CSC SDA PPS CCS
ohci_hcd 0000:00:01.3: roothub.portstatus [2] 0x00000100 PPS
/usr/src/linux-2.6.3/drivers/usb/host/uhci-hcd.c: USB Universal Host
Controller Interface driver v2.1
/usr/src/linux-2.6.3/drivers/usb/core/usb.c: registered new driver usblp
/usr/src/linux-2.6.3/drivers/usb/class/usblp.c: v0.13: USB Printer Device
Class
driver
Initializing USB Mass Storage driver...
/usr/src/linux-2.6.3/drivers/usb/core/usb.c: registered new driver
usb-storage
USB Mass Storage support registered.
/usr/src/linux-2.6.3/drivers/usb/core/usb.c: registered new driver hid
/usr/src/linux-2.6.3/drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
ohci_hcd 0000:00:01.3: GetStatus roothub.portstatus [1] = 0x00010301 CSC
LSDA PP
S CCS
hub 2-0:1.0: port 1, status 301, change 1, 1.5 Mb/s
NET: Registered protocol family 1
NET: Registered protocol family 17
RAMDISK: Compressed image found at block 0
hub 2-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x301
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 336k freed
ohci_hcd 0000:00:01.3: GetStatus roothub.portstatus [1] = 0x00100303 PRSC
LSDA P
PS PES CCS
usb 2-1: new low speed USB device using address 2
usb 2-1: new device strings: Mfr=1, Product=2, SerialNumber=0
/usr/src/linux-2.6.3/drivers/usb/core/message.c: USB device number 2
default lan
guage ID 0x409
usb 2-1: Product: Logitech USB Keyboard
usb 2-1: Manufacturer: Logitech
usb 2-1: registering 2-1:1.0 (config #1, interface 0)
hid 2-1:1.0: usb_probe_interface
hid 2-1:1.0: usb_probe_interface - got id
hid: probe of 2-1:1.0 failed with error -5
usb 2-1: registering 2-1:1.1 (config #1, interface 1)
hid 2-1:1.1: usb_probe_interface
hid 2-1:1.1: usb_probe_interface - got id
ohci_hcd 0000:00:01.3: urb c1390da0 path 1 ep0in 5ec20000 cc 5 --> status
-110
hid: probe of 2-1:1.1 failed with error -5
ohci_hcd 0000:00:01.3: GetStatus roothub.portstatus [2] = 0x00010301 CSC
LSDA PPS CCS
hub 2-0:1.0: port 2, status 301, change 1, 1.5 Mb/s
hub 2-0:1.0: debounce: port 2: delay 100ms stable 4 status 0x301
ohci_hcd 0000:00:01.3: GetStatus roothub.portstatus [2] = 0x00100303 PRSC
LSDA PPS PES CCS
usb 2-2: new low speed USB device using address 3
usb 2-2: new device strings: Mfr=1, Product=3, SerialNumber=0
/usr/src/linux-2.6.3/drivers/usb/core/message.c: USB device number 3
default language ID 0x409
usb 2-2: Product: Microsoft 3-Button Mouse with IntelliEye(TM)
usb 2-2: Manufacturer: Microsoft
usb 2-2: registering 2-2:1.0 (config #1, interface 0)
hid 2-2:1.0: usb_probe_interface
hid 2-2:1.0: usb_probe_interface - got id
input: USB HID v1.10 Mouse [Microsoft Microsoft 3-Button Mouse with
IntelliEye(TM)] on usb-0000:00:01.3-2
spurious 8259A interrupt: IRQ7.
ohci_hcd 0000:00:01.3: GetStatus roothub.portstatus [1] = 0x00030300 PESC
CSC LSDA PPS
hub 2-0:1.0: port 1, status 300, change 3, 1.5 Mb/s
usb 2-1: USB disconnect, address 2
usb 2-1: usb_disable_device nuking all URBs
usb 2-1: unregistering interface 2-1:1.0
usb 2-1: unregistering interface 2-1:1.1
usb 2-1: unregistering device
ohci_hcd 0000:00:01.3: GetStatus roothub.portstatus [1] = 0x00020300 PESC
LSDA PPS
hub 2-0:1.0: port 1 enable change, status 300
ohci_hcd 0000:00:01.2: GetStatus roothub.portstatus [2] = 0x00010301 CSC
LSDA PPS CCS
hub 1-0:1.0: port 2, status 301, change 1, 1.5 Mb/s
hub 1-0:1.0: debounce: port 2: delay 100ms stable 4 status 0x301
ohci_hcd 0000:00:01.2: GetStatus roothub.portstatus [2] = 0x00100303 PRSC
LSDA PPS PES CCS
usb 1-2: new low speed USB device using address 2
usb 1-2: new device strings: Mfr=1, Product=2, SerialNumber=0
/usr/src/linux-2.6.3/drivers/usb/core/message.c: USB device number 2
default language ID 0x409
usb 1-2: Product: Logitech USB Keyboard
usb 1-2: Manufacturer: Logitech
usb 1-2: registering 1-2:1.0 (config #1, interface 0)
hid 1-2:1.0: usb_probe_interface
hid 1-2:1.0: usb_probe_interface - got id
input: USB HID v1.10 Keyboard [Logitech Logitech USB Keyboard] on
usb-0000:00:01.2-2
usb 1-2: registering 1-2:1.1 (config #1, interface 1)
hid 1-2:1.1: usb_probe_interface
hid 1-2:1.1: usb_probe_interface - got id
hid: probe of 1-2:1.1 failed with error -5


----------------------------------------------------------------------------------
Plaats je zoekertjes GRATIS op AdValvas
Placez votre petite annonce GRATUITEMENT sur AdValvas
http://www.advalvas.be
