Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136746AbREIRAW>; Wed, 9 May 2001 13:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136744AbREIRAO>; Wed, 9 May 2001 13:00:14 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:52744 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S136742AbREIRAD>; Wed, 9 May 2001 13:00:03 -0400
Message-ID: <3AF9778F.B551ADFF@delusion.de>
Date: Wed, 09 May 2001 18:59:59 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: USB Problem with reenabling hub
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I have an USB hub built into my monitor (Eizo T761) which disconnects
and powers down the hub when the monitor gets switched off. After
switching it back on, a problem occurs with reenabling the ports on
that USB hub. The kernel output follows.

Comments anyone?

Regards,
Udo.


[Detect USB Ports on mainboard]

usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Found IRQ 9 for device 00:04.2
PCI: The same IRQ used for device 00:04.3
PCI: The same IRQ used for device 00:09.0
PCI: The same IRQ used for device 00:09.1
PCI: The same IRQ used for device 00:0d.0
uhci.c: USB UHCI at I/O 0xd400, IRQ 9
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 9 for device 00:04.3
PCI: The same IRQ used for device 00:04.2
PCI: The same IRQ used for device 00:09.0
PCI: The same IRQ used for device 00:09.1
PCI: The same IRQ used for device 00:0d.0
uhci.c: USB UHCI at I/O 0xd000, IRQ 9
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected

[Detect USB HUB in monitor]

hub.c: USB new device connect on bus1/1, assigned device number 2
hub.c: USB hub found
hub.c: 5 ports detected
hub.c: USB new device connect on bus1/1/1, assigned device number 3
usb.c: USB device 3 (vend/prod 0x56d/0x2) is not claimed by any active driver.
hub.c: USB new device connect on bus2/2, assigned device number 2
hub.c: USB hub found
hub.c: 4 ports detected

[switch monitor off]

usb.c: USB disconnect on device 2
usb.c: USB disconnect on device 3

[switch monitor back on]
hub.c: USB new device connect on bus1/1, assigned device number 4
usb.c: USB device not accepting new address=4 (error=-110)
hub.c: USB new device connect on bus1/1, assigned device number 5
usb.c: USB device not accepting new address=5 (error=-110)
