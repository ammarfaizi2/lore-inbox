Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbTLBK2X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 05:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbTLBK2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 05:28:23 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:32225 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S261788AbTLBK1t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 05:27:49 -0500
Message-ID: <3FCC6921.9000909@softhome.net>
Date: Tue, 02 Dec 2003 11:27:45 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: USB Audio, Alsa & HK SoundSticks
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

   [ better to cc: me, if this is FAQ - then private mail is more 
appropriate. but I do not expect to find much Harman/Kardon fans around 
;-) ]

   I have little problem.
   Or probably some-one can enlighten me what is going wrong here.

   Short: RH's 2.4.20-20.9 + alsa 0.9.8 + HK SoundSticks + xmms w/alsa 
output pluging will result in hanging of xmms. something hanged in 
kernel space hard enough (probably ksoftirqs or keventd) - so for 
example ps stoped working - but it least it was killable. I was able to 
leave X but reboot hanged somewhere in the middle of shutdown procedure.

   2.6.0-test11 does work without any problems.

   For now I'm using Alan's usb/audio.c driver - it works with little or 
no problems. I need on my dev system 2.4 - so upgrade to 2.6 is not yet 
feasible.

   I have diffed alsa 0.9.8 and alsa from 2.6.0-test11 and found no big 
differences in usb audio module.

   So I suspect problems with USB subsystem.

   Did anyone observed this kind of behaviour?

P.S. Is it related or is it not: "usbview -v" pauses for several seconds 
on HK SoundSticks: it prints line with bus and name, then pauses (as if 
getting info takes that long time) and then goes on. Probably something 
doesn't handle slow device like mine not corectly...

P.P.S. 2.4.20's usbview -vx:

Unknown line at line 58

Bus 004 Device 001: ID 0000:0000
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.00
   bDeviceClass            9 Hub
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0         8
   idVendor           0x0000
   idProduct          0x0000
   bcdDevice            0.00
   iManufacturer           0
   iProduct                2 USB UHCI Root Hub
   iSerial                 1 b400
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

Bus 003 Device 001: ID 0000:0000
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.00
   bDeviceClass            9 Hub
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0         8
   idVendor           0x0000
   idProduct          0x0000
   bcdDevice            0.00
   iManufacturer           0
   iProduct                2 USB UHCI Root Hub
   iSerial                 1 b800
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

Bus 003 Device 002: ID 05fc:7849 Harman Multimedia
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.10
   bDeviceClass            0 Interface
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0         8
   idVendor           0x05fc Harman Multimedia
   idProduct          0x7849
   bcdDevice            0.01
   iManufacturer           3 harman/kardon
   iProduct                1 SoundSticks
   iSerial                 0
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength          239
     bNumInterfaces          3
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xc0
       Self Powered
     MaxPower                0mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           0
       bInterfaceClass         1 Audio
       bInterfaceSubClass      1 Control Device
       bInterfaceProtocol      0
       iInterface              0
       AudioControl Interface Descriptor:
         bLength                 9
         bDescriptorType        36
         bDescriptorSubtype      1 (HEADER)
         bcdADC               1.00
         wTotalLength           43
         bInCollection           1
         baInterfaceNr( 0)       1
       AudioControl Interface Descriptor:
         bLength                12
         bDescriptorType        36
         bDescriptorSubtype      2 (INPUT_TERMINAL)
         bTerminalID             1
         wTerminalType      0x0101 USB Streaming
         bAssocTerminal          0
         bNrChannels             2
         wChannelConfig     0x0003
           Left Front (L)
           Right Front (R)
         iChannelNames           0
         iTerminal               0
       AudioControl Interface Descriptor:
         bLength                13
         bDescriptorType        36
         bDescriptorSubtype      6 (FEATURE_UNIT)
         bUnitID                 2
         bSourceID               1
         bControlSize            2
         bmaControls( 0)      0x55
         bmaControls( 1)      0x01
           Mute
           Bass
           Treble
           Automatic Gain
           Bass Boost
         bmaControls( 0)      0x02
         bmaControls( 1)      0x00
           Volume
         bmaControls( 0)      0x02
         bmaControls( 1)      0x00
           Volume
         iFeature                0
       AudioControl Interface Descriptor:
         bLength                 9
         bDescriptorType        36
         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
         bTerminalID             3
         wTerminalType      0x0301 Speaker
         bAssocTerminal          0
         bSourceID               2
         iTerminal               0
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       0
       bNumEndpoints           0
       bInterfaceClass         1 Audio
       bInterfaceSubClass      2 Streaming
       bInterfaceProtocol      0
       iInterface              0
     Interface Descriptor:
       bLength                11
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       1
       bNumEndpoints           1
       bInterfaceClass         1 Audio
       bInterfaceSubClass      2 Streaming
       bInterfaceProtocol      0
       iInterface              0
       junk at descriptor end: 01 00
       AudioControl Interface Descriptor:
         bLength                 7
         bDescriptorType        36
         bDescriptorSubtype      1 (AS_GENERAL)
         bTerminalLink           1
         bDelay                  0 frames
         wFormatTag              1 PCM
       AudioControl Interface Descriptor:
         bLength                14
         bDescriptorType        36
         bDescriptorSubtype      2 (FORMAT_TYPE)
         bFormatType             1 (FORMAT_TYPE_I)
         bNrChannels             1
         bSubframeSize           2
         bBitResolution         16
         bSamFreqType            0 Continuous
         tLowerSamFreq        5000
         tUpperSamFreq       50000
       Endpoint Descriptor:
         bLength                 9
         bDescriptorType         5
         bEndpointAddress     0x01  EP 1 OUT
         bmAttributes            9
           Transfer Type            Isochronous
           Synch Type               Adaptive
         wMaxPacketSize        112
         bInterval               1
         bRefresh                0
         bSynchAddress           0
         AudioControl Endpoint Descriptor:
           bLength                 7
           bDescriptorType        37
           bDescriptorSubtype      1 (EP_GENERAL)
           bmAttributes         0x00
           bLockDelayUnits         2 Decoded PCM samples
           wLockDelay              1 Decoded PCM samples
     Interface Descriptor:
       bLength                11
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       2
       bNumEndpoints           1
       bInterfaceClass         1 Audio
       bInterfaceSubClass      2 Streaming
       bInterfaceProtocol      0
       iInterface              0
       junk at descriptor end: 01 00
       AudioControl Interface Descriptor:
         bLength                 7
         bDescriptorType        36
         bDescriptorSubtype      1 (AS_GENERAL)
         bTerminalLink           1
         bDelay                  0 frames
         wFormatTag              1 PCM
       AudioControl Interface Descriptor:
         bLength                14
         bDescriptorType        36
         bDescriptorSubtype      2 (FORMAT_TYPE)
         bFormatType             1 (FORMAT_TYPE_I)
         bNrChannels             2
         bSubframeSize           2
         bBitResolution         16
         bSamFreqType            0 Continuous
         tLowerSamFreq        5000
         tUpperSamFreq       50000
       Endpoint Descriptor:
         bLength                 9
         bDescriptorType         5
         bEndpointAddress     0x01  EP 1 OUT
         bmAttributes            9
           Transfer Type            Isochronous
           Synch Type               Adaptive
         wMaxPacketSize        224
         bInterval               1
         bRefresh                0
         bSynchAddress           0
         AudioControl Endpoint Descriptor:
           bLength                 7
           bDescriptorType        37
           bDescriptorSubtype      1 (EP_GENERAL)
           bmAttributes         0x00
           bLockDelayUnits         2 Decoded PCM samples
           wLockDelay              1 Decoded PCM samples
     Interface Descriptor:
       bLength                11
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       3
       bNumEndpoints           1
       bInterfaceClass         1 Audio
       bInterfaceSubClass      2 Streaming
       bInterfaceProtocol      0
       iInterface              0
       junk at descriptor end: 01 00
       AudioControl Interface Descriptor:
         bLength                 7
         bDescriptorType        36
         bDescriptorSubtype      1 (AS_GENERAL)
         bTerminalLink           1
         bDelay                  0 frames
         wFormatTag              1 PCM
       AudioControl Interface Descriptor:
         bLength                14
         bDescriptorType        36
         bDescriptorSubtype      2 (FORMAT_TYPE)
         bFormatType             1 (FORMAT_TYPE_I)
         bNrChannels             2
         bSubframeSize           3
         bBitResolution         24
         bSamFreqType            0 Continuous
         tLowerSamFreq        5000
         tUpperSamFreq       50000
       Endpoint Descriptor:
         bLength                 9
         bDescriptorType         5
         bEndpointAddress     0x01  EP 1 OUT
         bmAttributes            9
           Transfer Type            Isochronous
           Synch Type               Adaptive
         wMaxPacketSize        336
         bInterval               1
         bRefresh                0
         bSynchAddress           0
         AudioControl Endpoint Descriptor:
           bLength                 7
           bDescriptorType        37
           bDescriptorSubtype      1 (EP_GENERAL)
           bmAttributes         0x00
           bLockDelayUnits         2 Decoded PCM samples
           wLockDelay              1 Decoded PCM samples
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        2
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
           wDescriptorLength      49
cannot get report descriptor
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               none
         wMaxPacketSize          2
         bInterval               8
   Language IDs: (length=6)
      0009 English(English)
      0004 Chinese(Chinese)

Bus 003 Device 003: ID 0a12:0001 Cambridge Silicon Radio Ltd.
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.10
   bDeviceClass          224
   bDeviceSubClass         1
   bDeviceProtocol         1
   bMaxPacketSize0        64
   idVendor           0x0a12 Cambridge Silicon Radio Ltd.
   idProduct          0x0001
   bcdDevice            5.25
   iManufacturer           0
   iProduct                0
   iSerial                 0
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength          193
     bNumInterfaces          3
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xc0
       Self Powered
     MaxPower                0mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           3
       bInterfaceClass       224
       bInterfaceSubClass      1
       bInterfaceProtocol      1
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               none
         wMaxPacketSize         16
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x02  EP 2 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               none
         wMaxPacketSize         64
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x82  EP 2 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               none
         wMaxPacketSize         64
         bInterval               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       0
       bNumEndpoints           2
       bInterfaceClass       224
       bInterfaceSubClass      1
       bInterfaceProtocol      1
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x03  EP 3 OUT
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               none
         wMaxPacketSize          0
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               none
         wMaxPacketSize          0
         bInterval               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       1
       bNumEndpoints           2
       bInterfaceClass       224
       bInterfaceSubClass      1
       bInterfaceProtocol      1
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x03  EP 3 OUT
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               none
         wMaxPacketSize          9
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               none
         wMaxPacketSize          9
         bInterval               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       2
       bNumEndpoints           2
       bInterfaceClass       224
       bInterfaceSubClass      1
       bInterfaceProtocol      1
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x03  EP 3 OUT
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               none
         wMaxPacketSize         17
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               none
         wMaxPacketSize         17
         bInterval               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       3
       bNumEndpoints           2
       bInterfaceClass       224
       bInterfaceSubClass      1
       bInterfaceProtocol      1
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x03  EP 3 OUT
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               none
         wMaxPacketSize         25
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               none
         wMaxPacketSize         25
         bInterval               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       4
       bNumEndpoints           2
       bInterfaceClass       224
       bInterfaceSubClass      1
       bInterfaceProtocol      1
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x03  EP 3 OUT
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               none
         wMaxPacketSize         33
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               none
         wMaxPacketSize         33
         bInterval               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       5
       bNumEndpoints           2
       bInterfaceClass       224
       bInterfaceSubClass      1
       bInterfaceProtocol      1
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x03  EP 3 OUT
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               none
         wMaxPacketSize         49
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               none
         wMaxPacketSize         49
         bInterval               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        2
       bAlternateSetting       0
       bNumEndpoints           0
       bInterfaceClass       254
       bInterfaceSubClass      1
       bInterfaceProtocol      0
       iInterface              0
   unknown descriptor type: 07 21 07 88 13 ff 03
   Language IDs: (length=4)
      0409 English(US)

Bus 002 Device 001: ID 0000:0000
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.00
   bDeviceClass            9 Hub
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0         8
   idVendor           0x0000
   idProduct          0x0000
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

Bus 002 Device 002: ID 046d:c00e Logitech Inc. Optical Mouse
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass            0 Interface
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0         8
   idVendor           0x046d Logitech Inc.
   idProduct          0xc00e Optical Mouse
   bcdDevice           11.10
   iManufacturer           1 Logitech
   iProduct                2 USB-PS/2 Optical Mouse
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
       Remote Wakeup
     MaxPower               98mA
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
           bCountryCode            0
           bNumDescriptors         1
           bDescriptorType        34 Report
           wDescriptorLength      52
cannot get report descriptor
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               none
         wMaxPacketSize          4
         bInterval              10
   Language IDs: (length=4)
      0409 English(US)

Bus 001 Device 001: ID 0000:0000
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass            9 Hub
   bDeviceSubClass         0
   bDeviceProtocol         1
   bMaxPacketSize0         8
   idVendor           0x0000
   idProduct          0x0000
   bcdDevice            2.04
   iManufacturer           3 Linux 2.4.20-20.9 ehci-hcd
   iProduct                2 VIA Technologies, Inc. USB 2.0
   iSerial                 1 00:10.3
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
         wMaxPacketSize          2
         bInterval              12
   Language IDs: (length=4)
      0000 (null)((null))


-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  Because the kernel depends on it existing. "init"          |_|*|_|
  literally _is_ special from a kernel standpoint,           |_|_|*|
  because its' the "reaper of zombies" (and, may I add,      |*|*|*|
  that would be a great name for a rock band).
                                 -- Linus Torvalds

