Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbTHYGYb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 02:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbTHYGYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 02:24:31 -0400
Received: from catv-50624ad9.szolcatv.broadband.hu ([80.98.74.217]:27523 "EHLO
	boszi-lnx.localdomain") by vger.kernel.org with ESMTP
	id S261508AbTHYGY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 02:24:26 -0400
Message-ID: <3F49AB95.7090105@freemail.hu>
Date: Mon, 25 Aug 2003 08:24:21 +0200
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, hu
MIME-Version: 1.0
To: Daniel Egger <degger@fhm.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to use an USB<->serial adapter?
References: <3F44BEA2.8010108@freemail.hu> <1061507883.8723.45.camel@sonja>
In-Reply-To: <1061507883.8723.45.camel@sonja>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Egger wrote:
> Am Don, 2003-08-21 um 14.44 schrieb Boszormenyi Zoltan:
> 
> 
>>usb.c: registered new driver serial
>>usbserial.c: USB Serial support registered for Generic
>>usbserial.c: USB Serial Driver core v1.4
>>usbserial.c: USB Serial support registered for PL-2303
>>usbserial.c: PL-2303 converter detected
>>usbserial.c: PL-2303 converter now attached to ttyUSB0 \
>>(or usb/tts/0 for devfs)
>>pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.9
> 
> 
> Works for me, even on PowerPC. I'm typically using minicom and ckermit
> but mgetty and others work fine, too.

What product is this? Mine is a Wiretek UN8BE, based on Prolific 2303.

# lsusb -s 001:002
Bus 001 Device 002: ID 067b:2303 Prolific Technology, Inc. PL2303 Serial 
Port
   Language IDs: none (invalid length string descriptor 63; len=7)
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.10
   bDeviceClass            0 Interface
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0         8
   idVendor           0x067b Prolific Technology, Inc.
   idProduct          0x2303 PL2303 Serial Port
   bcdDevice            2.02
   iManufacturer           0   <--- should'nt these two be set?
   iProduct                0   <--- (or not, it is optional)
   iSerial                 0
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           39
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xa0
       Remote Wakeup
     MaxPower              100mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           3
       bInterfaceClass       255 Vendor Specific Class
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
         wMaxPacketSize         10
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x02  EP 2 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               none
         wMaxPacketSize         64
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               none
         wMaxPacketSize         64
         bInterval               0
   Language IDs: none (invalid length string descriptor 63; len=7)

In the shop they said this one cannot be used as a null-link but works
with external serial devices, e.g. modems. I have yet to verify this
statement myself.

>>setserial produces an error:
> 
> 
> What do you need this relic from former times for?

I tried to query the USB serial line's current parameters.
Is there any other utilities that can do this for me?

-- 
Best regards,
Zoltán Böszörményi

---------------------
What did Hussein say about his knife?
One in Bush worth two in the hand.

