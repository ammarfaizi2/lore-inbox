Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbUKWUlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbUKWUlp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 15:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUKWUkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 15:40:21 -0500
Received: from poros.telenet-ops.be ([195.130.132.44]:26552 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261526AbUKWUij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 15:38:39 -0500
From: Jan De Luyck <lkml@kcore.org>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] [2.6.10-rc2] ehci_hcd causes oops after some use of usb harddisk
Date: Tue, 23 Nov 2004 21:38:32 +0100
User-Agent: KMail/1.7.1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-usb-users@lists.sourceforge.net
References: <200411231912.05504.lkml@kcore.org> <200411231203.41184.david-b@pacbell.net>
In-Reply-To: <200411231203.41184.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411232138.33454.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 November 2004 21:03, David Brownell wrote:

> > lsusb -v for the specific device:
> > Bus 001 Device 002: ID 05e3:0702 Genesys Logic, Inc. USB 2.0 IDE Adapter
> > Device Descriptor:
> >   bLength                18
> >   bDescriptorType         1
> >   bcdUSB               2.00
> >   bDeviceClass            0 (Defined at Interface level)
> >   bDeviceSubClass         0
> >   bDeviceProtocol         0
> >   bMaxPacketSize0        64
> >   idVendor           0x05e3 Genesys Logic, Inc.
> >   idProduct          0x0702 USB 2.0 IDE Adapter
>
> ... those GeneSys devices have been sufficiently problematic that I,
> for one, won't investigate bug reports involving them any more.  The
> devices have several problems where they lock up when Linux does
> perfectly legal things.  Avoid them.

Yeah... well, unfortunately, it's almost impossible to get your hands on a usb 
enclosure, break the seals on the wrapping, test it, then go back nagging it 
doesn't work at the vendor - while it does work in <insert certain os name 
here>. While I do agree - and try to find linux-compatible devices whenever 
possible - this isn't really helpful to the end-user imo...

I've got it working now, and it works great after the udelay(200); 
modification.

Jan

-- 
Witch!  Witch!  They'll burn ya!
  -- Hag, "Tomorrow is Yesterday", stardate unknown

