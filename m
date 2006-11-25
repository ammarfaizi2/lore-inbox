Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934963AbWKYNVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934963AbWKYNVj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 08:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934965AbWKYNVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 08:21:39 -0500
Received: from rwcrmhc15.comcast.net ([216.148.227.155]:15787 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S934963AbWKYNVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 08:21:38 -0500
Message-ID: <45684360.1060801@comcast.net>
Date: Sat, 25 Nov 2006 08:21:36 -0500
From: Ed Sweetman <safemode2@comcast.net>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.19-rc5-mm2 : usb keeps resetting usb keyboard.
References: <4567BB70.6080907@comcast.net> <200611242321.02776.gene.heskett@verizon.net>
In-Reply-To: <200611242321.02776.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> On Friday 24 November 2006 22:41, Ed Sweetman wrote:
>   
>> I just upgraded from a ps2 keyboard to usb and have been getting these
>> messages seemingly randomly, which also corresponds to whatever key i'm
>> pressing at the time they occur to act like it's stuck down.
>>
>> usb 2-2: reset low speed USB device using ohci_hcd and address 3
>> usb 2-2: reset low speed USB device using ohci_hcd and address 3
>> usb 2-2: reset low speed USB device using ohci_hcd and address 3
>> usb 2-2: reset low speed USB device using ohci_hcd and address 3
>> usb 2-2: reset low speed USB device using ohci_hcd and address 3
>> usb 2-2: reset low speed USB device using ohci_hcd and address 3
>> usb 2-2: reset low speed USB device using ohci_hcd and address 3
>>
>> (repeated a few hundred times )
>>
>>     
> All the data below doesn't point to the culprit.  
>
> I also have this, and I'd bet the common point is going to be an M$ 
> wireless mouse like I have.  The mouse works ok as near as I can tell, so 
> I'm not sure of the exact cause.
>
> To verify, unplug the receiver for that mouse, wait 5secs, and plug it 
> back in, which if thats it should move the mouse, and the log message to 
> a higher number on the usb tree.
>
> Also, FWIW dear lkml readers, my logs have been contaminated with this 
> since about a year ago, running kernel.org kernels on an FC2 system, but 
> using the latest FC6 non-xen kernel.
>   
I dont have a wireless usb mouse or any hardware from microsoft 
running.  My usb mouse is a standard logitech that i've been using for a 
couple years.   I haven't had these errors in my log before installing 
my usb keyboard. 

These are the only usb devices in the system.

below is my lsusb -v.  For what it's worth.

Bus 002 Device 003: ID 046d:c00c Logitech, Inc. Optical Wheel Mouse
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x046d Logitech, Inc.
  idProduct          0xc00c Optical Wheel Mouse
  bcdDevice            6.10
  iManufacturer           1 Logitech
  iProduct                2 USB Mouse
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      68
         Report Descriptors:
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              10
Device Status:     0x0000
  (Bus Powered)

Bus 002 Device 002: ID 1267:0103 Logic3 / SpectraVideo plc
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x1267 Logic3 / SpectraVideo plc
  idProduct          0x0103
  bcdDevice            1.01
  iManufacturer           0
  iProduct                0
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           59
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      1 Keyboard
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      54
         Report Descriptors:
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              10
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      52
         Report Descriptors:
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0003  1x 3 bytes
        bInterval              10
Device Status:     0x0000
  (Bus Powered)

Bus 002 Device 001: ID 0000:0000
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 Full speed hub
  bMaxPacketSize0        64
  idVendor           0x0000
  idProduct          0x0000
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.19-rc5-mm2 ohci_hcd
  iProduct                2 OHCI Host Controller
  iSerial                 1 0000:00:02.0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed hub
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval             255
Hub Descriptor:
  bLength              11
  bDescriptorType      41
  nNbrPorts            10
  wHubCharacteristic 0x0002
    No power switching (usb 1.0)
    Ganged overcurrent protection
  bPwrOn2PwrGood        1 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00 0x00
  PortPwrCtrlMask    0xff 0xff
 Hub Port Status:
   Port 1: 0000.0303 lowspeed power enable connect
   Port 2: 0000.0303 lowspeed power enable connect
   Port 3: 0000.0100 power
   Port 4: 0000.0100 power
   Port 5: 0000.0100 power
   Port 6: 0000.0100 power
   Port 7: 0000.0100 power
   Port 8: 0000.0100 power
   Port 9: 0000.0100 power
   Port 10: 0000.0100 power
Device Status:     0x0003
  Self Powered
  Remote Wakeup Enabled

Bus 001 Device 001: ID 0000:0000
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         1 Single TT
  bMaxPacketSize0        64
  idVendor           0x0000
  idProduct          0x0000
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.19-rc5-mm2 ehci_hcd
  iProduct                2 EHCI Host Controller
  iSerial                 1 0000:00:02.1
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed hub
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval              12
Hub Descriptor:
  bLength              11
  bDescriptorType      41
  nNbrPorts            10
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
    TT think time 8 FS bits
  bPwrOn2PwrGood       10 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00 0x00
  PortPwrCtrlMask    0xff 0xff
 Hub Port Status:
   Port 1: 0000.0000
   Port 2: 0000.0000
   Port 3: 0000.0100 power
   Port 4: 0000.0100 power
   Port 5: 0000.0100 power
   Port 6: 0000.0100 power
   Port 7: 0000.0100 power
   Port 8: 0000.0100 power
   Port 9: 0000.0100 power
   Port 10: 0000.0100 power
Device Status:     0x0003
  Self Powered
  Remote Wakeup Enabled



> >From an lsusb -v:
> ----------
> Bus 002 Device 003: ID 045e:008c Microsoft Corp. Wireless Intellimouse 
> Explorer 2.0
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0         8
>   idVendor           0x045e Microsoft Corp.
>   idProduct          0x008c Wireless Intellimouse Explorer 2.0
>   bcdDevice            0.57
>   iManufacturer           1 Microsoft
>   iProduct                2 Microsoft Wireless Optical Mouse 1.0A
>   iSerial                 0
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           34
>     bNumInterfaces          1
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0xa0
>       Remote Wakeup
>     MaxPower               50mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         3 Human Interface Devices
>       bInterfaceSubClass      1 Boot Interface Subclass
>       bInterfaceProtocol      2 Mouse
>       iInterface              0
>         HID Device Descriptor:
>           bLength                 9
>           bDescriptorType        33
>           bcdHID               1.11
>           bCountryCode            0 Not supported
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength     209
>          Report Descriptors:
>            ** UNAVAILABLE **
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0008  1x 8 bytes
>         bInterval              10
> -------------------
>
> How close am I in this suposition?
>
>   

