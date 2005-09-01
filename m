Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbVIAUWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbVIAUWF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbVIAUWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:22:05 -0400
Received: from host247-102.pool8258.interbusiness.it ([82.58.102.247]:12937
	"EHLO DarkStar.sns.it") by vger.kernel.org with ESMTP
	id S1030366AbVIAUWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:22:02 -0400
From: Luigi Genoni <genoni@sns.it>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: HELP: unable to use I-MATE SP3 as USB (HTC) gprs modem
Date: Thu, 1 Sep 2005 22:21:21 +0200
User-Agent: KMail/1.8.2
Cc: Oliver Neukum <oliver@neukum.org>, linux-usb-users@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       luigi.genoni@pirelli.com, David Brownell <david-b@pacbell.net>
References: <4185.192.167.206.189.1125581964.squirrel@new.host.name> <200509011922.04804.oliver@neukum.org> <20050901173202.GA448@midnight.suse.cz>
In-Reply-To: <20050901173202.GA448@midnight.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509012221.21806.genoni@sns.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lsusb -v gives:

Bus 001 Device 003: ID 0bb4:00cf High Tech Computer Corp.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            2 Communications
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x0bb4 High Tech Computer Corp.
  idProduct          0x00cf
  bcdDevice            0.90
  iManufacturer           0
  iProduct                0
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           39
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass         2 Communications
      bInterfaceSubClass    255
      bInterfaceProtocol    255
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval              80

As I said, cdc-acm is not satisfied with this kind of device. I do not know 
how to make it work. Also usbserial didn't work. How could I make them work?

Please, note that the same command, used when the gprs modem is disabled (so i 
am using ipaq module in this case), gives:

Bus 001 Device 005: ID 0bb4:0a51 High Tech Computer Corp. SPV C400 / T-Mobile 
SDA GSM/GPRS Pocket PC
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass       255 Vendor Specific Subclass
  bDeviceProtocol       255 Vendor Specific Protocol
  bMaxPacketSize0        64
  idVendor           0x0bb4 High Tech Computer Corp.
  idProduct          0x0a51 SPV C400 / T-Mobile SDA GSM/GPRS Pocket PC
  bcdDevice            0.00
  iManufacturer           0
  iProduct                0
  iSerial                 0
  bNumConfigurations      3
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           32
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           32
    bNumInterfaces          1
    bConfigurationValue     2
    iConfiguration          0
    bmAttributes         0x80
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           32
    bNumInterfaces          1
    bConfigurationValue     3
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower                2mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0

which is, for what I understand (not to mutch to say the truth) really 
different.

Obviously I will be happy to make all the test you will ask me.

Luigi Genoni

On Thursday 01 September 2005 19:32, Vojtech Pavlik wrote:
> On Thu, Sep 01, 2005 at 07:22:04PM +0200, Oliver Neukum wrote:
> > > I should use as an USB gprs modem.
> > >
> > > Since it is possible to configure it to be a (HTC) modem, using it's
> > > menu, when I enable it to act as a modem on the usb port the content of
> > > /proc/bus/usb/devices who refers to the phone changes to: I
> > >
> > >
> > > T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 37 Spd=12  MxCh= 0
> > > D:  Ver= 1.00 Cls=02(comm.) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> > > P:  Vendor=0bb4 ProdID=00cf Rev= 0.90
> > > C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=100mA
> > > I:  If#= 0 Alt= 0 #EPs= 3 Cls=02(comm.) Sub=ff Prot=ff Driver=(none)
> > > E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > > E:  Ad=03(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > > E:  Ad=86(I) Atr=03(Int.) MxPS=  16 Ivl=80ms
> > >
> > > The hotplug does not work anymore using the ipaq driver (as I
> > > exspected), and the device is not attacched to ttyUSB0.
> > >
> > > I read Cls=02(comm.). I suppose there should be a way to use something
> > > like cdc-acm driver. Unfortunatelly this driver does not seem to like
> > > my phone.
> > > All I get is a sad:
> > >
> > > usb 1-1: new full speed USB device using uhci_hcd and address 39
> > >
> > >
> > > Is there a way to solve this problem and to use I-mate SP3 smartphone
> > > as gprs modem for linux or should I surrender?
> >
> > Is there just one interface?
> > If so, looks like somebody tried to be clever and collapsed the control
> > and the data interfaces of the acm specification. The ACM driver can be
> > hacked to support that.
>
> That is, if the ACM command set actually works, otherwise it's a job for
> usb-serial.
>
> > Can you confirm that there's just one interface and no extra descriptors?
> > (lsusb -v)
> >
> > 	Regards
> > 		Oliver
