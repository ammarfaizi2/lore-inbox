Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289730AbSAWIoh>; Wed, 23 Jan 2002 03:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289735AbSAWIo2>; Wed, 23 Jan 2002 03:44:28 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:33554 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S289730AbSAWIoU>; Wed, 23 Jan 2002 03:44:20 -0500
Date: Wed, 23 Jan 2002 09:44:14 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Greg KH <greg@kroah.com>
Cc: Torrey Hoffman <thoffman@arnor.net>, vojtech@ucw.cz,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: depmod problem for 2.5.2-dj4
Message-ID: <20020123094414.D5170@suse.cz>
In-Reply-To: <1011744752.2440.0.camel@shire.arnor.net> <20020123045405.GA12060@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020123045405.GA12060@kroah.com>; from greg@kroah.com on Tue, Jan 22, 2002 at 08:54:05PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2002 at 08:54:05PM -0800, Greg KH wrote:
> On Tue, Jan 22, 2002 at 04:12:30PM -0800, Torrey Hoffman wrote:
> > 
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.5.2-dj4/kernel/drivers/usb/hid.o
> > depmod: 	usb_make_path
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.5.2-dj4/kernel/drivers/usb/usbkbd.o
> > depmod: 	usb_make_path
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.5.2-dj4/kernel/drivers/usb/usbmouse.o
> > depmod: 	usb_make_path
> > make: *** [_modinst_post] Error 1
> 
> Looks like you need to add a:
> 	EXPORT_SYMBOL(usb_make_path);
> to the usb.c file.

Correct.

> Vojtech, is this a USB function that you want added to usb.c?

Yes, please. This will change later when Pat Mochels devicefs kicks in,
but for the time being, it'd be very useful.

> Didn't you (or someone else) propose a function like this in the past?

I'm not sure, I may have proposed it. I'm not sure of the outcome
either. The input subsystem needs to use the bus topology for matching
the devices - there is no other way to differentiate between two
identical USB mice.

Do you think it could be added?

-- 
Vojtech Pavlik
SuSE Labs
