Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319065AbSIDFqj>; Wed, 4 Sep 2002 01:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319067AbSIDFqj>; Wed, 4 Sep 2002 01:46:39 -0400
Received: from [64.6.248.2] ([64.6.248.2]:30684 "EHLO greenie.frogspace.net")
	by vger.kernel.org with ESMTP id <S319065AbSIDFqg>;
	Wed, 4 Sep 2002 01:46:36 -0400
Date: Tue, 3 Sep 2002 22:50:59 -0700 (PDT)
From: Peter <cogweb@cogweb.net>
X-X-Sender: cogweb@greenie.frogspace.net
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-ac4 build problem
Message-ID: <Pine.LNX.4.44.0209032237460.25475-100000@greenie.frogspace.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there a fix for this compilation problem? I've tried gcc 2.95.3, 3.0, 
and 3.1 and get the same:

drivers/usb/usbdrv.o: In function `hidinput_hid_event':
drivers/usb/usbdrv.o(.text+0x127f1): undefined reference to `input_event'
drivers/usb/usbdrv.o(.text+0x12889): undefined reference to `input_event'
drivers/usb/usbdrv.o(.text+0x128e1): undefined reference to `input_event'
drivers/usb/usbdrv.o(.text+0x12967): undefined reference to `input_event'
drivers/usb/usbdrv.o: In function `hidinput_connect':
drivers/usb/usbdrv.o(.text+0x12bc0): undefined reference to `input_register_device'
drivers/usb/usbdrv.o: In function `hidinput_hid_event':
drivers/usb/usbdrv.o(.text+0x12848): undefined reference to `input_event'
drivers/usb/usbdrv.o: In function `hidinput_disconnect':
drivers/usb/usbdrv.o(.text+0x12bdd): undefined reference to `input_unregister_device'
make: *** [vmlinux] Error 1

I'm trying to get USB keyboard and mouse support, so I'd like to keep the 
hidinput options.

Cheers,
Peter


#
# Input core support
#
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_EVDEV is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_LONG_TIMEOUT is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_UHCI=y
# CONFIG_USB_UHCI_ALT is not set
# CONFIG_USB_OHCI is not set


#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH is not set
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
CONFIG_USB_STORAGE_ISD200=y
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_WACOM is not set

#
# USB Imaging devices
#
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
CONFIG_USB_SCANNER=m
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

No additional USB devices are set.

