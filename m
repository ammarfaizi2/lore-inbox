Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbTIHJsw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 05:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbTIHJsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 05:48:51 -0400
Received: from mail-08.iinet.net.au ([203.59.3.40]:21995 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262327AbTIHJr4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 05:47:56 -0400
Subject: RE: USB - UHCI not SMP capable? linux-2.6-test4
From: Sven Dowideit <svenud@ozemail.com.au>
Reply-To: svenud@ozemail.com.au
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-acpi <linux-acpi@intel.com>
In-Reply-To: <7F740D512C7C1046AB53446D3720017304AF12@scsmsx402.sc.intel.com>
References: <7F740D512C7C1046AB53446D3720017304AF12@scsmsx402.sc.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UNb1HxI6JQS/44kfGRFq"
Message-Id: <1063050150.2977.17.camel@sven>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 09 Sep 2003 05:42:30 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UNb1HxI6JQS/44kfGRFq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

ok , as I have not had any success with ACPI i have it turned off on all
my computers. I added acpi=3Doff to my boot parameters just in case, but
USB is still non-functional.

sorry, that wasn't it

sven

On Mon, 2003-09-08 at 01:05, Nakajima, Jun wrote:
> Sounds like an ACPI issue, especially with APIC mode, assuming you have
> ACPI configured. Can you try the SMP kernel with the boot parameter
> "acpi=3Doff"? We have a fix to that in 2.4 ACPI bk tree, and Len is
> working on patches for 2.6.
>=20
> Thanks,
> Jun
>=20
> > -----Original Message-----
> > From: Sven Dowideit [mailto:svenud@ozemail.com.au]
> > Sent: Sunday, September 07, 2003 4:55 PM
> > To: linux-kernel
> > Subject: USB - UHCI not SMP capable? linux-2.6-test4
> >=20
> > I have a dual pIII VIA VP6 which is not doing usb properly. it appears
> > to work when i re-build with SMP off , but with SMP on devices don't
> get
> > detected/powered up.
> >=20
> > as a simple test I have a logitech usb mouse plugged in (but you don't
> > get to see it :).
> >=20
> > as an added wierdness, when i added a pcmcia-PCI bridge to the system,
> > to test Russell's pcmcia patch (when didn't work well (but that could
> > have been config issues)) and repeatedly pulled and added pcmcia
> cards,
> > the usb mouse somethimes turned up.. but not at boot time.
> >=20
> > does anyone have any ideas?
> >=20
> > the following logs are with SMP enabled
> > ------
> > dmesg
> >=20
> > niform CD-ROM driver Revision: 3.12
> > drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface
> > driver v2.1
> > uhci-hcd 0000:00:07.2: UHCI Host Controller
> > uhci-hcd 0000:00:07.2: irq 19, io base 0000a400
> > uhci-hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
> > PM: Adding info for usb:usb1
> > hub 1-0:0: USB hub found
> > hub 1-0:0: 2 ports detected
> > PM: Adding info for usb:1-0:0
> > uhci-hcd 0000:00:07.3: UHCI Host Controller
> > uhci-hcd 0000:00:07.3: irq 19, io base 0000a800
> > uhci-hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
> > PM: Adding info for usb:usb2
> > hub 2-0:0: USB hub found
> > hub 2-0:0: 2 ports detected
> > PM: Adding info for usb:2-0:0
> > drivers/usb/core/usb.c: registered new driver hid
> > drivers/usb/input/hid-core.c: v2.0:USB HID core driver
> > mice: PS/2 mouse device common for all mice
> > input: PS/2 Logitech Mouse on isa0060/serio1
> > serio: i8042 AUX port at 0x60,0x64 irq 12
> > input: AT Set 2 keyboard on isa0060/serio0
> > serio: i8042 KBD port at 0x60,0x64 irq 1
> > I2O Core - (C) Copyright 1999 Red Hat Software
> > I2O: Event thread created as pid 19
> >=20
> > ------
> > lspci -v
> >=20
> > 00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if
> 00
> > [UHCI])
> >         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
> >         Flags: bus master, medium devsel, latency 32, IRQ 19
> >         I/O ports at a400 [size=3D32]Bus 002 Device 001: ID 0000:0000
> >         Capabilities: [80] Power Management version 2
> >=20
> > 00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if
> 00
> > [UHCI])
> >         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
> >         Flags: bus master, medium devsel, latency 32, IRQ 19
> >         I/O ports at a800 [size=3D32]
> >         Capabilities: [80] Power Management version 2
> >=20
> >=20
> > ---------
> > lsusb -v
> >=20
> > Bus 002 Device 001: ID 0000:0000
> > Device Descriptor:
> >   bLength                18
> >   bDescriptorType         1
> >   bcdUSB               1.10
> >   bDeviceClass            9 Hub
> >   bDeviceSubClass         0
> >   bDeviceProtocol         0
> >   bMaxPacketSize0         8
> >   idVendor           0x0000
> >   idProduct          0x0000
> >   bcdDevice            2.06
> >   iManufacturer           3 Linux 2.6.0-test4 uhci-hcd
> >   iProduct                2 UHCI Host Controller
> >   iSerial                 1 0000:00:07.3
> >   bNumConfigurations      1
> >   Configuration Descriptor:
> >     bLength                 9
> >     bDescriptorType         2
> >     wTotalLength           25
> >     bNumInterfaces          1
> >     bConfigurationValue     1
> >     iConfiguration          0
> >     bmAttributes         0x40
> >       Self Powered
> >     MaxPower                0mA
> >     Interface Descriptor:
> >       bLength                 9
> >       bDescriptorType         4
> >       bInterfaceNumber        0
> >       bAlternateSetting       0
> >       bNumEndpoints           1
> >       bInterfaceClass         9 Hub
> >       bInterfaceSubClass      0
> >       bInterfaceProtocol      0
> >       iInterface              0
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x81  EP 1 IN
> >         bmAttributes            3
> >           Transfer Type            Interrupt
> >           Synch Type               none
> >         wMaxPacketSize          2
> >         bInterval             255
> >   Language IDs: (length=3D4)
> >      0409 English(US)
> >=20
> > Bus 001 Device 001: ID 0000:0000
> > Device Descriptor:
> >   bLength                18
> >   bDescriptorType         1
> >   bcdUSB               1.10
> >   bDeviceClass            9 Hub
> >   bDeviceSubClass         0
> >   bDeviceProtocol         0
> >   bMaxPacketSize0         8
> >   idVendor           0x0000
> >   idProduct          0x0000
> >   bcdDevice            2.06
> >   iManufacturer           3 Linux 2.6.0-test4 uhci-hcd
> >   iProduct                2 UHCI Host Controller
> >   iSerial                 1 0000:00:07.2
> >   bNumConfigurations      1
> >   Configuration Descriptor:
> >     bLength                 9
> >     bDescriptorType         2
> >     wTotalLength           25
> >     bNumInterfaces          1
> >     bConfigurationValue     1
> >     iConfiguration          0
> >     bmAttributes         0x40
> >       Self Powered
> >     MaxPower                0mA
> >     Interface Descriptor:
> >       bLength                 9
> >       bDescriptorType         4
> >       bInterfaceNumber        0
> >       bAlternateSetting       0
> >       bNumEndpoints           1
> >       bInterfaceClass         9 Hub
> >       bInterfaceSubClass      0
> >       bInterfaceProtocol      0
> >       iInterface              0
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x81  EP 1 IN
> >         bmAttributes            3
> >           Transfer Type            Interrupt
> >           Synch Type               none
> >         wMaxPacketSize          2
> >         bInterval             255
> >   Language IDs: (length=3D4)
> >      0409 English(US)
> >=20
> >=20
> > ------
> > .config
> >=20
> > #
> > # USB
> > support
> > #
> > CONFIG_USB=3Dy
> > # CONFIG_USB_DEBUG is not
> > set
> >=20
> > #
> > # Miscellaneous USB
> > options
> > #
> > CONFIG_USB_DEVICEFS=3Dy
> > # CONFIG_USB_BANDWIDTH is not
> > set
> > # CONFIG_USB_DYNAMIC_MINORS is not
> > set
> >=20
> > #
> > # USB Host Controller
> > Drivers
> > #
> > # CONFIG_USB_EHCI_HCD is not
> > set
> > # CONFIG_USB_OHCI_HCD is not
> > set
> > CONFIG_USB_UHCI_HCD=3Dy
> >=20
> > #
> > # USB Device Class
> > drivers
> > #
> > # CONFIG_USB_AUDIO is not
> > set
> > # CONFIG_USB_BLUETOOTH_TTY is not
> > set
> > # CONFIG_USB_MIDI is not
> > set
> > # CONFIG_USB_ACM is not
> > set
> > CONFIG_USB_PRINTER=3Dm
> >=20
> > #
> > # SCSI support is needed for USB
> > Storage
> > #
> > # CONFIG_USB_STORAGE is not
> > set
> >=20
> > #
> > # USB Human Interface Devices
> > (HID)
> > #
> > CONFIG_USB_HID=3Dy
> > CONFIG_USB_HIDINPUT=3Dy
> > # CONFIG_HID_FF is not
> > set
> > # CONFIG_USB_HIDDEV is not
> > set
> > # CONFIG_USB_AIPTEK is not
> > set
> > # CONFIG_USB_WACOM is not
> > set
> > # CONFIG_USB_KBTAB is not
> > set
> > # CONFIG_USB_POWERMATE is not
> > set
> > # CONFIG_USB_XPAD is not
> > set
> >=20
> > #
> > # USB Imaging
> > devices
> > #
> > # CONFIG_USB_MDC800 is not
> > set
> > # CONFIG_USB_SCANNER is not
> > set
> >=20
> > #
> > # USB Multimedia
> > devices
> > #
> > # CONFIG_USB_DABUSB is not
> > set
> > # CONFIG_USB_VICAM is not
> > set
> > # CONFIG_USB_DSBR is not
> > set
> > # CONFIG_USB_IBMCAM is not
> > set
> > # CONFIG_USB_KONICAWC is not
> > set
> > # CONFIG_USB_OV511 is not
> > set
> > # CONFIG_USB_PWC is not
> > set
> > # CONFIG_USB_SE401 is not
> > set
> > # CONFIG_USB_STV680 is not
> > set
> >=20
> > #
> > # USB Network
> > adaptors
> > #
> > # CONFIG_USB_AX8817X is not
> > set
> > # CONFIG_USB_CATC is not
> > set
> > # CONFIG_USB_KAWETH is not
> > set
> > # CONFIG_USB_PEGASUS is not
> > set
> > # CONFIG_USB_RTL8150 is not
> > set
> > # CONFIG_USB_USBNET is not
> > set
> >=20
> > #
> > # USB port
> > drivers
> > #
> > # CONFIG_USB_USS720 is not
> > set
> >=20
> > #
> > # USB Serial Converter
> > support
> > #
> > # CONFIG_USB_SERIAL is not
> > set
> >=20
> > #
> > # USB Miscellaneous
> > drivers
> > #
> > # CONFIG_USB_TIGL is not
> > set
> > # CONFIG_USB_AUERSWALD is not
> > set
> > # CONFIG_USB_RIO500 is not
> > set
> > # CONFIG_USB_BRLVGER is not
> > set
> > # CONFIG_USB_LCD is not
> > set
> > # CONFIG_USB_TEST is not
> > set
> > # CONFIG_USB_GADGET is not set
> >=20
> >=20
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

--=-UNb1HxI6JQS/44kfGRFq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/XNujPAwzu0QrW+kRAoC7AJ0Y5iIF8peXsCfC4Wvz8OMxOAnP8gCbB7QV
KWd/Ex7PNexjdLwdpkIUNFQ=
=OMFS
-----END PGP SIGNATURE-----

--=-UNb1HxI6JQS/44kfGRFq--

