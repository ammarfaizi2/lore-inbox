Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130753AbQKWWCd>; Thu, 23 Nov 2000 17:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130756AbQKWWCX>; Thu, 23 Nov 2000 17:02:23 -0500
Received: from db0bm.automation.fh-aachen.de ([193.175.144.197]:5639 "EHLO
        db0bm.ampr.org") by vger.kernel.org with ESMTP id <S130753AbQKWWCH>;
        Thu, 23 Nov 2000 17:02:07 -0500
Date: Thu, 23 Nov 2000 22:32:01 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200011232132.WAA29552@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: 2.2.18pre, usb mouse messages
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I use an USB mouse, it works perfectly both with 'gpm' and with X-window but
time to time, I've this kind of message stream :

[root@debian-f5ibh] ~ # usb-uhci.c: interrupt, status 3, frame# 20
usb-uhci.c: interrupt, status 3, frame# 44
usb-uhci.c: interrupt, status 3, frame# 68
usb-uhci.c: interrupt, status 3, frame# 92
usb-uhci.c: interrupt, status 3, frame# 116
usb-uhci.c: interrupt, status 3, frame# 140
usb-uhci.c: interrupt, status 3, frame# 164
usb-uhci.c: interrupt, status 3, frame# 188
usb-uhci.c: interrupt, status 3, frame# 212
hub.c: already running port 2 disabled by hub (EMI?), re-enabling...

This message appears with most (all ?) of the 2.2.18pre releases, the actual
one is 2.2.18pre23.

Computer is pentium 200MMX, 64Mb SDRAM.

Relevant CONFIG bits :
----------------------
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_HOTPLUG=y
# CONFIG_USB_BANDWIDTH is not set

#
# USB Controllers
#
CONFIG_USB_UHCI=m
# CONFIG_USB_UHCI_ALT is not set
# CONFIG_USB_OHCI is not set

#
# USB Devices
#
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_PLUSB is not set
# CONFIG_USB_PEGASUS is not set
#
# USB HID
#
CONFIG_USB_HID=m
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_WMFORCE is not set
# CONFIG_INPUT_KEYBDEV is not set
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set


boot messages :
---------------
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb.c: registered new driver hid
usb-uhci.c: $Revision: 1.237 $ time 23:53:07 Nov 23 2000
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0x6100, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
usb.c: USB new device connect, assigned device number 1
hub.c: USB hub found
hub.c: 2 ports detected
mice: PS/2 mouse device common for all mice
usb.c: USB new device connect, assigned device number 2
mouse0: PS/2 mouse device for input0
input0: USB HID v1.00 Mouse [Cypress Sem. Cypress USB Mouse] on usb1:2.0
hub.c: already running port 2 disabled by hub (EMI?), re-enabling...
usb.c: USB disconnect on device 2
usb.c: USB new device connect, assigned device number 2
mouse0: PS/2 mouse device for input0
input0: USB HID v1.00 Mouse [Cypress Sem. Cypress USB Mouse] on usb1:2.0

----
Regards

Jean-Luc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
