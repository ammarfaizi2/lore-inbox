Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263012AbTC0PeG>; Thu, 27 Mar 2003 10:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263028AbTC0PeG>; Thu, 27 Mar 2003 10:34:06 -0500
Received: from jessie.softnet.si ([212.103.128.68]:42646 "EHLO softnet.si")
	by vger.kernel.org with ESMTP id <S263012AbTC0PeE>;
	Thu, 27 Mar 2003 10:34:04 -0500
Date: Thu, 27 Mar 2003 16:45:23 +0100
From: Damjan Bole <damjanbole@gmx.net>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre6: usb ports/mouse not detected
Message-Id: <20030327164523.1030f0ff.damjanbole@gmx.net>
In-Reply-To: <20030327142101.6a414743.martin.zwickel@technotrend.de>
References: <20030327130546.1f1d6d1f.damjanbole@gmx.net>
	<20030327142101.6a414743.martin.zwickel@technotrend.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the hint, I compiled usb stuff as modules and I get little further, optical mouse light is on (successful init?) but still no go. Usb driver reports this unknown device is not claimed by any active driver. Broken compatibility with via kt266a?


usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 15:31:12 Mar 27 2003
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xdc00, IRQ 12
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xd800, IRQ 12
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 12
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,4), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Real Time Clock Driver v1.10e
hub.c: new USB device 00:11.2-2, assigned address 2
usb.c: USB device 2 (vend/prod 0x46d/0xc00c) is not claimed by any active driver


 

On Thu, 27 Mar 2003 14:21:01 +0100
Martin Zwickel <martin.zwickel@technotrend.de> wrote:

> On Thu, 27 Mar 2003 13:05:46 +0100
> Damjan Bole <damjanbole@gmx.net> bubbled:
> 
> > Hi
> > 
> > Switching from 2.4.21pre5 to pre6 I've found out my usb mouse is
> > dead and no usb port is detected on my msi kt266pro2. I used same
> > (make oldconfig) as in pre5. I included dmesg logs below. regards
> 
> I had the same problem few hours ago.
> Loading usb-ohci/ehci-hcd as a module fixed it for me ...
> But it's just a "It Works for Me(tm)" ...
