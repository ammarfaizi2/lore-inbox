Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264550AbSIQVBA>; Tue, 17 Sep 2002 17:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264580AbSIQVAi>; Tue, 17 Sep 2002 17:00:38 -0400
Received: from pcow034o.blueyonder.co.uk ([195.188.53.122]:61453 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S264550AbSIQU7r>;
	Tue, 17 Sep 2002 16:59:47 -0400
Subject: Re: Problems accessing USB Mass Storage
From: Mark C <gen-lists@blueyonder.co.uk>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-users <linux-usb-users@lists.sourceforge.net>
Cc: ted@cypress.com
In-Reply-To: <3D878BFD.4040308@cypress.com>
References: <1032261937.1170.13.camel@stimpy.angelnet.internal>
	<20020917151816.GB2144@kroah.com> <3D876861.9000601@cypress.com>
	<20020917174631.GD2569@kroah.com>  <3D878BFD.4040308@cypress.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 17 Sep 2002 22:01:02 +0100
Message-Id: <1032296466.1275.16.camel@stimpy.angelnet.internal>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-17 at 21:09, Thomas Dodd wrote:
> 
> 
> Greg KH wrote:
> > On Tue, Sep 17, 2002 at 12:37:37PM -0500, Thomas Dodd wrote:
> > 
> >>I get the feeling it's not a true mass storage device.
> > 
> > 
> > Sounds like it.
> 
> > Windows drivers don't help me much, maybe one of the other usb
> > developers could help.
> 
> Looking at the driver files, this is interesting:
> 
> 	dmusic.sys
> 	gm16.dls
> 	kmixer.sys
> 	ks.sys
> 	ksclockf.ax
> 	ksdata.ax
> 	ksinterf.ax
> 	ksproxy.ax
> 	kstvtune.ax
> 	ksuser.dll
> 	ksvpintf.ax
> 	kswdmcap.ax
> 	ksxbar.ax
> 	msh263.drv
> 	mskssrv.sys
> 	mspclock.sys
> 	portcls.sys
> 	redbook.sys
> 
> redbook? isn't that CD related?
> 
> 
> 	sbemul.sys
> 	stream.sys
> 	swmidi.sys
> 	sysaudio.sys
> 	usbaudio.sys
> 	vfwwdm.drv
> 	vfwwdm32.dll
> 	wdmaud.drv
> 	wdmaud.sys
> 
> I also see a lot of audio related files like usbaudio, sbemul,gm16,
> swmidi, and dmusic.
> 
> Mark, are there any other interfaces in the output form lsusb?
> I didn't see them in dmesg from the connection. But the windows drivers
> make me think there should be a usb-audio interface.
> 

Please find below the output of: /sbin/lsusb (only relevant to the
camera)

Bus 001 Device 002: ID 0733:1310 ViewQuest Technologies, Inc. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            0 Interface
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0733 ViewQuest Technologies, Inc.
  idProduct          0x1310 
  bcdDevice            1.00
  iManufacturer           1 ViewQuest Technologies Inc.
  iProduct                2 1.3M DigitalCAM
  iSerial                 3 01.00.00
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           39
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
      bNumEndpoints           3
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      6 SCSI
      bInterfaceProtocol     80 Bulk (Zip)
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x87  EP 7 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x08  EP 8 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x89  EP 9 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          1
        bInterval               1
  Language IDs: (length=4)
     0409 English(US)

I will be running dd (as per you're other email shortly and return the
output for that).

Mark


-- 
---
To steal ideas from one person is plagiarism;
to steal from many is research.

