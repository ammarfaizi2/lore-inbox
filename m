Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274054AbRISIPr>; Wed, 19 Sep 2001 04:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274026AbRISIPi>; Wed, 19 Sep 2001 04:15:38 -0400
Received: from 64-51-242-19.client.dsl.net ([64.51.242.19]:2176 "EHLO
	mcgruff.krimedawg.org") by vger.kernel.org with ESMTP
	id <S274028AbRISIPa> convert rfc822-to-8bit; Wed, 19 Sep 2001 04:15:30 -0400
Date: Wed, 19 Sep 2001 01:15:52 -0700 (PDT)
From: <lkml@krimedawg.org>
X-X-Sender: <plumpy@mcgruff.krimedawg.org>
To: <linux-kernel@vger.kernel.org>
Subject: USB hub broken between 2.4.10-pre6 and 2.4.10-pre12
Message-ID: <Pine.LNX.4.33.0109190110330.590-100000@mcgruff.krimedawg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrading from 2.4.10-pre6 and -pre12, my USB hub stopped working.
This happens with both of the UHCI drivers.  If there's anything I can do
to help (narrow it down to a specific release?) let me know...

Here are the USB-related kernel messages (the interesting stuff is, of
course, at the bottom):

usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Found IRQ 5 for device 00:07.2
PCI: Sharing IRQ 5 with 00:07.3
PCI: Sharing IRQ 5 with 00:08.0
uhci.c: USB UHCI at I/O 0xa400, IRQ 5
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 5 for device 00:07.3
PCI: Sharing IRQ 5 with 00:07.2
PCI: Sharing IRQ 5 with 00:08.0
uhci.c: USB UHCI at I/O 0xa800, IRQ 5
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
uhci.c: :USB Universal Host Controller Interface driver
usb.c: registered new driver hid
hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
usb.c: registered new driver usblp
printer.c: v0.8:USB Printer Device Class driver
mice: PS/2 mouse device common for all mice
hub.c: USB new device connect on bus1/1, assigned device number 2
printer.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 0
hub.c: USB new device connect on bus1/2, assigned device number 3
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: USB new device connect on bus1/2/1, assigned device number 4
input0: USB HID v1.00 Keyboard [Mitsumi Electric Mitsumi USB Keyboard] on usb1:4.0
hub.c: USB new device connect on bus1/2/2, assigned device number 5
input1: USB HID v1.00 Mouse [Microsoft Microsoft Wheel Mouse Optical®] on usb1:5.0
hub.c: USB new device connect on bus1/2/3, assigned device number 6
input2: USB HID v1.00 Joystick [LTS Studio PSX for USB Converter] on usb1:6.0
usb_control/bulk_msg: timeout
hub.c: get_port_status failed (err = -110)
usb_control/bulk_msg: timeout
hub.c: get_hub_status failed
usb_control/bulk_msg: timeout
hub.c: get_port_status failed (err = -110)
usb_control/bulk_msg: timeout
hub.c: get_port_status failed (err = -110)
usb_control/bulk_msg: timeout
hub.c: get_port_status failed (err = -110)
usb_control/bulk_msg: timeout
hub.c: get_port_status failed (err = -110)
usb_control/bulk_msg: timeout
hub.c: get_hub_status failed

