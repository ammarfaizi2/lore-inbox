Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318318AbSHKPxf>; Sun, 11 Aug 2002 11:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318319AbSHKPxf>; Sun, 11 Aug 2002 11:53:35 -0400
Received: from pcp748446pcs.manass01.va.comcast.net ([68.49.120.237]:43446
	"EHLO pcp748343pcs.manass01.va.comcast.net") by vger.kernel.org
	with ESMTP id <S318318AbSHKPxb>; Sun, 11 Aug 2002 11:53:31 -0400
Date: Sun, 11 Aug 2002 11:57:13 -0400
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: USB problem with 2.5.3[0-1]?
Message-ID: <20020811155713.GA8319@bittwiddlers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
X-Delivery-Agent: TMDA/0.58
Reply-To: Matthew Harrell 
	  <mharrell-dated-1029513433.43d927@bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Using essentially the same config file from 2.5.25 amd 2.5.27 (the last good
working kernels I have) with 2.5.3[0-1] gives me errors trying to use my
USB devices.  The relevent parts of the config file are below.  The 2.5.25
kernel does this

  usb.c: registered new driver usbfs
  usb.c: registered new driver hub
  ...
  usb.c: registered new driver hiddev
  usb.c: registered new driver hid
  hid-core.c: v1.31:USB HID core driver
  usb.c: registered new driver serial
  usbserial.c: USB Serial support registered for Generic
  usbserial.c: USB Serial Driver core v1.5
  mice: PS/2 mouse device common for all mice
  ...
  uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
  hcd-pci.c: uhci-hcd @ 00:11.2, VIA Technologies, Inc. UHCI USB
  hcd-pci.c: irq 10, io base 00001200
  hcd.c: new USB bus registered, assigned bus number 1
  hub.c: USB hub found at /
  hub.c: 2 ports detected
  hub.c: new USB device 00:11.2-2, assigned address 2
  hub.c: USB hub found at 2
  hub.c: 9 ports detected
  hub.c: new USB device 00:11.2-2.3, assigned address 3
  hub.c: USB hub found at 2.3
  hub.c: 3 ports detected
  hub.c: new USB device 00:11.2-2.7, assigned address 4
  usb.c: USB device 4 (vend/prod 0x4b3/0x203) is not claimed by any active driver.
  hub.c: new USB device 00:11.2-2.8, assigned address 5
  input.c: calling /sbin/hotplug input [HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add PRODUCT=3/4b3/4481/100 NAME=IBM IBM PS/2 Keyboard And Mouse I/F]
  input: USB HID v1.00 Keyboard [IBM IBM PS/2 Keyboard And Mouse I/F] on usb-00:11.2-2.8
  hid-core.c: ctrl urb status -32 received
  hid-core.c: usb_submit_urb(ctrl) failed
  hub.c: new USB device 00:11.2-2.9, assigned address 6
  usb.c: USB device 6 (vend/prod 0x4b3/0x4482) is not claimed by any active driver.
  hub.c: new USB device 00:11.2-2.3.1, assigned address 7
  input.c: calling /sbin/hotplug input [HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add PRODUCT=3/5ac/201/102 NAME=Alps Electric Apple USB Keyboard]
  input: USB HID v1.00 Keyboard [Alps Electric Apple USB Keyboard] on usb-00:11.2-2.3.1
  hub.c: new USB device 00:11.2-2.3.3, assigned address 8
  input.c: calling /sbin/hotplug input [HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add PRODUCT=3/46d/c402/210 NAME=Logitech USB-PS/2 Trackball]
  input: USB HID v1.00 Mouse [Logitech USB-PS/2 Trackball] on usb-00:11.2-2.3.3

but the recent kernels do this

  usb.c: registered new driver usbfs
  usb.c: registered new driver hub
  ...
  uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
  hcd-pci.c: uhci-hcd @ 00:11.2, VIA Technologies, Inc. UHCI USB
  hcd-pci.c: irq 10, io base 00001200
  hcd.c: new USB bus registered, assigned bus number 1
  hub.c: USB hub found at 0
  hub.c: 2 ports detected
  usb.c: registered new driver hiddev
  usb.c: registered new driver hid
  hid-core.c: v1.31:USB HID core driver
  mice: PS/2 mouse device common for all mice
  ...
  hub.c: new USB device 00:11.2-2, assigned address 2
  hub.c: USB hub found at 2
  hub.c: 9 ports detected
  hub.c: new USB device 00:11.2-2.3, assigned address 3
  hub.c: USB hub found at 2.3
  hub.c: 3 ports detected
  hub.c: new USB device 00:11.2-2.7, assigned address 4
  usb.c: USB device 4 (vend/prod 0x4b3/0x203) is not claimed by any active driver.
  hub.c: new USB device 00:11.2-2.8, assigned address 5
  hid-core.c: ctrl urb status -32 received
  hid-core.c: usb_submit_urb(ctrl) failed

with essentially the same config.  How come the later kernel isn't recognizing
the hub and it's devices any more?

-- 
  Matthew Harrell                          You're just jealous because the
  Bit Twiddlers, Inc.                       voices only talk to me.
  mharrell@bittwiddlers.com     

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=".config"

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_LONG_TIMEOUT is not set
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD_ALT=y

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
# CONFIG_HID_PID is not set
# CONFIG_LOGITECH_FF is not set
CONFIG_USB_HIDDEV=y
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_STV680 is not set

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
CONFIG_USB_KAWETH=m
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_USBNET=m

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19QW is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19QI is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SAFE_PADDED is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set

--PEIAKu/WMn1b1Hv9--
