Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311710AbSDNWCP>; Sun, 14 Apr 2002 18:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312476AbSDNWCO>; Sun, 14 Apr 2002 18:02:14 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:18889 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S311710AbSDNWCO>; Sun, 14 Apr 2002 18:02:14 -0400
Message-ID: <3CB9FC61.7C70B8E0@delusion.de>
Date: Mon, 15 Apr 2002 00:02:09 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.8 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: vojtech@suse.cz
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: USB HID: control queue full
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Vojtech,

USB HID support under 2.5.8-final prints a lot of the following errors:

hid-core.c: control queue full
usb-uhci.c: ENXIO 80000400, flags 0, urb cf89fc40, burb cf89fbc0

The relevant dmesg output...

usb-uhci.c: $Revision: 1.275 $ time 23:28:14 Apr 14 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 9 for device 00:04.2
PCI: Sharing IRQ 9 with 00:04.3
PCI: Sharing IRQ 9 with 00:09.0
PCI: Sharing IRQ 9 with 00:09.1
PCI: Sharing IRQ 9 with 00:0d.0
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 9
usb-uhci.c: Detected 2 ports
hcd.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found at /
hub.c: 2 ports detected
PCI: Found IRQ 9 for device 00:04.3
PCI: Sharing IRQ 9 with 00:04.2
PCI: Sharing IRQ 9 with 00:09.0
PCI: Sharing IRQ 9 with 00:09.1
PCI: Sharing IRQ 9 with 00:0d.0
usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 9
usb-uhci.c: Detected 2 ports
hcd.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found at /
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.31:USB HID core driver
usb.c: registered new driver usbscanner
hub.c: new USB device on bus 1 path /1, assigned address 2
hub.c: new USB device on bus 1 path /2, assigned address 3
hub.c: USB hub found at /2
hub.c: 5 ports detected
hub.c: new USB device on bus 1 path /2/1, assigned address 4
hid-core.c: control queue full
hid-core.c: control queue full
hid-core.c: control queue full
hid-core.c: control queue full
... <lots more of these>
usb-uhci.c: ENXIO 80000400, flags 0, urb cf89fc40, burb cf89fbc0
usb-uhci.c: ENXIO 80000400, flags 0, urb cf89fc40, burb cf89fbc0
usb-uhci.c: ENXIO 80000400, flags 0, urb cf89fc40, burb cf89fbc0
usb-uhci.c: ENXIO 80000400, flags 0, urb cf89fc40, burb cf89fbc0
... <lots more of these>
hiddev0: USB HID v1.10 Pointer [EIZO EIZO USB HID Monitor] on usb1:2.1
hub.c: new USB device on bus 2 path /2, assigned address 2
hub.c: USB hub found at /2
hub.c: 4 ports detected


-Udo.
