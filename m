Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283854AbRLAALt>; Fri, 30 Nov 2001 19:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283853AbRLAALl>; Fri, 30 Nov 2001 19:11:41 -0500
Received: from TK212017087078.teleweb.at ([212.17.87.78]:53747 "EHLO
	elch.elche") by vger.kernel.org with ESMTP id <S283854AbRLAALX>;
	Fri, 30 Nov 2001 19:11:23 -0500
Date: Sat, 1 Dec 2001 01:10:45 +0100
From: Armin Obersteiner <armin@xos.net>
To: Greg KH <greg@kroah.com>
Cc: Armin Obersteiner <armin@xos.net>, linux-kernel@vger.kernel.org
Subject: Re: usb slow in >2.4.10
Message-ID: <20011201011045.A1602@elch.elche>
In-Reply-To: <20011130040719.A21515@elch.elche> <20011129202959.B8633@kroah.com> <20011130141616.B25328@elch.elche> <20011130074753.C9866@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011130074753.C9866@kroah.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

ok i'm using usb-uhci right now. (instead uhci)
[everything kernel 2.4.15+ide bugfix]

Dec  1 00:58:15 elch kernel: usb-uhci.c: $Revision: 1.268 $ time 12:34:31 Nov 24 2001
Dec  1 00:58:15 elch kernel: usb-uhci.c: High bandwidth mode enabled
Dec  1 00:58:15 elch kernel: PCI: Found IRQ 9 for device 00:04.3
Dec  1 00:58:15 elch kernel: PCI: Sharing IRQ 9 with 00:04.2
Dec  1 00:58:15 elch kernel: PCI: Sharing IRQ 9 with 00:10.0
Dec  1 00:58:15 elch kernel: usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 9
Dec  1 00:58:15 elch kernel: usb-uhci.c: Detected 2 ports
Dec  1 00:58:15 elch kernel: usb.c: new USB bus registered, assigned bus number 1
Dec  1 00:58:15 elch kernel: usb.c: kmalloc IF eed0b2a0, numif 1
Dec  1 00:58:15 elch kernel: usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
Dec  1 00:58:15 elch kernel: usb.c: USB device number 1 default language ID 0x0

the camera (usb-storage) works fine and fast again.

BUT my rio500 does not work at all: (it's detected right, but nothing more)

Dec  1 01:05:16 elch kernel: hub.c: USB new device connect on bus2/2, assigned device number 5
Dec  1 01:05:19 elch kernel: usb_control/bulk_msg: timeout
Dec  1 01:05:19 elch kernel: usb.c: USB device not accepting new address=5 (error=-110)
Dec  1 01:05:19 elch kernel: hub.c: port 2, portstatus 103, change 0, 12 Mb/s
Dec  1 01:05:19 elch kernel: hub.c: USB new device connect on bus2/2, assigned device number 6
Dec  1 01:05:22 elch kernel: usb_control/bulk_msg: timeout
Dec  1 01:05:22 elch kernel: usb.c: USB device not accepting new address=6 (error=-110)
Dec  1 01:05:31 elch kernel: usb.c: deregistering driver rio500
Dec  1 01:05:37 elch kernel: hub.c: port 2 connection change
Dec  1 01:05:37 elch kernel: hub.c: port 2, portstatus 100, change 3, 12 Mb/s
Dec  1 01:05:37 elch kernel: hub.c: port 2 enable change, status 100
Dec  1 01:05:39 elch kernel: usb.c: registered new driver rio500
Dec  1 01:05:39 elch kernel: rio500.c: v1.1:USB Rio 500 driver
Dec  1 01:05:41 elch kernel: hub.c: port 2 connection change
Dec  1 01:05:41 elch kernel: hub.c: port 2, portstatus 101, change 1, 12 Mb/s
Dec  1 01:05:41 elch kernel: hub.c: port 2, portstatus 103, change 0, 12 Mb/s
Dec  1 01:05:41 elch kernel: hub.c: USB new device connect on bus2/2, assigned device number 7
Dec  1 01:05:44 elch kernel: usb_control/bulk_msg: timeout
Dec  1 01:05:44 elch kernel: usb.c: USB device not accepting new address=7 (error=-110)
Dec  1 01:05:44 elch kernel: hub.c: port 2, portstatus 103, change 0, 12 Mb/s
Dec  1 01:05:44 elch kernel: hub.c: USB new device connect on bus2/2, assigned device number 8
Dec  1 01:05:47 elch kernel: usb_control/bulk_msg: timeout
Dec  1 01:05:47 elch kernel: usb.c: USB device not accepting new address=8 (error=-110)
Dec  1 01:05:49 elch kernel: hub.c: port 2 connection change
Dec  1 01:05:49 elch kernel: hub.c: port 2, portstatus 100, change 3, 12 Mb/s
Dec  1 01:05:49 elch kernel: hub.c: port 2 enable change, status 100
 
> On Fri, Nov 30, 2001 at 02:16:16PM +0100, Armin Obersteiner wrote:
> > 
> > Nov 24 12:52:21 elch kernel: uhci.c: USB Universal Host Controller Interface driver v1.1
> > Nov 24 12:52:21 elch kernel: uhci.c: USB UHCI at I/O 0xd000, IRQ 9
> > Nov 24 12:52:21 elch kernel: uhci.c: detected 2 ports
> 
> You're using the uhci driver.  Can you try and see if you have the same
> problem with the usb-uhci driver?  The uhci driver had some big changes
> right around the time that you have reported things slowing down.
> 
> thanks,
> 
> greg k-h

Thanx &
MfG,
	Armin Obersteiner
--
armin@xos.net                        pgp public key on request        CU
