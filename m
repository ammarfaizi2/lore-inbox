Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267150AbTAPRGC>; Thu, 16 Jan 2003 12:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267160AbTAPRGC>; Thu, 16 Jan 2003 12:06:02 -0500
Received: from pd208.katowice.sdi.tpnet.pl ([213.76.228.208]:20864 "EHLO finwe")
	by vger.kernel.org with ESMTP id <S267150AbTAPRGA>;
	Thu, 16 Jan 2003 12:06:00 -0500
Date: Thu, 16 Jan 2003 18:14:51 +0100
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: linux-kernel@vger.kernel.org, mdharm-usb@one-eyed-alien.net
Subject: Re: 2.4.20/2.4.21-pre3 usb Oops
Message-ID: <20030116171451.GA1647@finwe.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	mdharm-usb@one-eyed-alien.net
References: <20030115111234.GA1322@finwe.eu.org> <20030115233303.GA26255@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030115233303.GA26255@kroah.com>
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> > I've got ide disk connected as usb-storage device.

> > Oops is reproductable (output from ksymoops below). 
> > I had to copy it from screen (I hope effects are 
> > reliable).
> Can you switch UHCI drivers and see if the problem is still there?

Hello! 

It's better (no oops anyway). I'm not sure if problem
it's still usb-related now (?). 

BTW. I booted to 2.5.58 (CONFIG_USB_UHCI_HCD=m)
and there was no oops, but fdisk fell in 'D' state. I can
try to extract something more from logs if it could be helpful.

2.4.20, uhci:
-------------
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
scsi0 : SCSI emulation for USB Mass Storage devices
Vendor:           Model:                   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 02
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
usb.c: usb-storage driver claimed interface ce462700
USB Mass Storage support registered.
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 80043265 512-byte hdwr sectors (40982 MB)
sda: Write Protect is off
 sda: sda1 sda2 sda3 sda4

after fdisk /dev/sda
--------------------
hub.c: port 1, portstatus 103, change 0, 12 Mb/s
usb.c: ignoring set_interface for dev 2, iface 0, alt 0
scsi: device set offline - not ready or command retry failed after bus reset: host 0 channel 0 id 0 lun 0
 I/O error: dev 08:00, sector 0

bye

PS 

-- 
Jacek Kawa
