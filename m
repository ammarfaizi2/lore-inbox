Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317263AbSHLGgN>; Mon, 12 Aug 2002 02:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317073AbSHLGgN>; Mon, 12 Aug 2002 02:36:13 -0400
Received: from 200-162-192-51.mail.ajato.com.br ([200.162.192.51]:20982 "HELO
	mail.ajato.com.br") by vger.kernel.org with SMTP id <S317263AbSHLGgL>;
	Mon, 12 Aug 2002 02:36:11 -0400
Date: Mon, 12 Aug 2002 03:39:50 -0300
From: Carlos Laviola <carlos@laviola.org>
To: linux-kernel@vger.kernel.org
Subject: Change in USB (HID?) from 2.4.18 to 2.4.19 breaks support for my Joystick
Message-ID: <20020812063950.GA1247@laviola.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Debian GNU/Linux (sid) [Linux 2.4.19-rmap13c i686]
X-Message-Flag: Get yourself a real email client. http://www.mutt.org/
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
Reply-By: Mon, 15 Jul 2002 09:30:05 -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've recently bought a generic Playstation + Nintendo 64 joystick
adapter that connects to USB ports.  This joystick works fine on 2.4.18
with the following modules only: usbcore, input, hid & usb-uhci.  On
2.4.19, all of the mentioned modules load like in 2.4.18, but I get a
"no such device" when I try to test the joystick with jstest.  To be
sure, I went to 2.4.20-pre1-ac1, and the joystick doesn't work with it
too.

I'm including the output from lsusb -v below.  If there's something else
I can do to help discover the problem, please tell me.

Here it is:

Bus 002 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 Virtual
  idProduct          0x0000 Hub
  bcdDevice            0.00
  iManufacturer           0 
  iProduct                2 USB UHCI Root Hub
  iSerial                 1 d000
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          8
        bInterval             255
  Language IDs: (length=4)
     0000 (null)((null))

Bus 001 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 Virtual
  idProduct          0x0000 Hub
  bcdDevice            0.00
  iManufacturer           0 
  iProduct                2 USB UHCI Root Hub
  iSerial                 1 d400
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          8
        bInterval             255
  Language IDs: (length=4)
     0000 (null)((null))

Bus 001 Device 002: ID 6666:0667 Eclectic VG SmartJoy PSX
  Language IDs: none (invalid length string descriptor bf; len=0)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            0 Interface
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x6666 Eclectic VG
  idProduct          0x0667 SmartJoy PSX
  bcdDevice            2.88
  iManufacturer           0 
  iProduct                0 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.00
          bCountryCode            0
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      82
cannot get report descriptor
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          6
        bInterval              10
  Language IDs: none (invalid length string descriptor bf; len=0)

-end-

-- 
Carlos Laviola <carlos@laviola.org>
