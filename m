Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129481AbRBDRaG>; Sun, 4 Feb 2001 12:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129202AbRBDR34>; Sun, 4 Feb 2001 12:29:56 -0500
Received: from mail15.jump.net ([206.196.91.15]:49811 "EHLO mail15.jump.net")
	by vger.kernel.org with ESMTP id <S129481AbRBDR3k>;
	Sun, 4 Feb 2001 12:29:40 -0500
Message-ID: <3A7D919F.F2213EA2@sgi.com>
Date: Sun, 04 Feb 2001 11:30:07 -0600
From: Eric Sandeen <sandeen@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-XFS i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Rothwell <rothwell@holly-springs.nc.us>
CC: linux-kernel@vger.kernel.org
Subject: Re: "kaweth" usb ethernet driver in 2.4?
In-Reply-To: <200102040727.f147RAQ14787@513.holly-springs.nc.us>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Rothwell wrote:

> > It also doesn't seem to work in 2.2.  :)  The original development of
> > this driver was going on at http://drivers.rd.ilan.net/kaweth/ but there
> > have been no updates for quite some time.
> 
> Well, it doesn't work you _you_ on 2.2, obviously. But it works for us
> and other people. Can you provide any information to diagnose the
> problem you're having?

I'm sorry, I should have provided that info.  I searched the 'net, and
saw many people with problems on several mailing lists, and saw no
solutions, or reports of success, so I assumed that it was a widespread,
possibly even known, problem with the driver.

I'll preface this by saying that Brad Hards sent me an updated version
that works much better, at least as long as the module is loaded before
the device is plugged in.

But here's what I get with a 2.2 kernel and the stock driver:

Kawasaki USB->Ethernet Driver loading... 
usb.c: registered new driver kaweth 
usb.c: USB new device connect, assigned device number 2 
Kawasaki Device Probe (Device number:2): 0x0846:0x1001 
Device at c2192600 
Descriptor length: 12 type: 1 
NetGear EA-101 connected... 
Reading kaweth configuration 
Request type: c0  Request: 0  Value: 0 Index: 0 Length: 12 
usb-uhci.c: interrupt, status 2, frame# 1929 
kaweth control message failed (urb addr: c2c05ca0) 
usb_control/bulk_msg: timeout 
usb-uhci.c: interrupt, status 2, frame# 851 
Actual length: 0, length 18 
Resetting... 
usb-uhci.c: interrupt, status 2, frame# 854 
Downloading firmware at c48abb6c to kaweth device at c31be000... 
Firmware length: 3838 
Request type: 40  Request: ff  Value: 0 Index: 0 Length: efe 
usb-uhci.c: interrupt, status 2, frame# 871 
kaweth control message failed (urb addr: c213ab60) 
usb-uhci.c: interrupt, status 2, frame# 877 
usb-uhci.c: interrupt, status 2, frame# 882 
Actual length: 0, length 3838 
Error downloading firmware (-110), no net device created
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
