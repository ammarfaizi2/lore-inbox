Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317987AbSHDQs1>; Sun, 4 Aug 2002 12:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317997AbSHDQs1>; Sun, 4 Aug 2002 12:48:27 -0400
Received: from dsl-213-023-061-042.arcor-ip.net ([213.23.61.42]:45840 "EHLO
	spot.local") by vger.kernel.org with ESMTP id <S317987AbSHDQs1>;
	Sun, 4 Aug 2002 12:48:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Feiler <kiza@gmx.net>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.4.19, USB_HID only works compiled in, not as module
Date: Sun, 4 Aug 2002 18:53:04 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200208041656.21035.kiza@gmx.net> <20020804162030.GA22588@kroah.com>
In-Reply-To: <20020804162030.GA22588@kroah.com>
X-PGP-KeyID: 0x561D4FD2
X-PGP-Key: http://www.lionking.org/~kiza/pgpkey.shtml
X-Species: Snow Leopard
X-Operating-System: Linux i686
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208041853.04578.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 August 2002 18:20, Greg KH wrote:
> On Sun, Aug 04, 2002 at 04:56:19PM +0200, Oliver Feiler wrote:
> > Hi,
> >
> > Since 2.4.19 a usb mouse does not work anymore if
> >
> > CONFIG_USB_HID=m
> > and
> > CONFIG_INPUT_MOUSEDEV=m
> >
> > is set. It only works if both are compiled into the kernel. Yes, I have
> > set CONFIG_USB_HIDINPUT=y.
> >
> > I've also seen other complaints about usb mice not working in 2.4.19, I
> > guess that's the problem?
> >
> > If the stuff is compiled as modules, everything seems to be fine. The
> > kernel messages are the same, everything is detected fine. Except that
> > 'cat /dev/input/mice' does not give any output if the driver is compiled
> > as module.
>
> Are you sure the hid.o module is loaded?  :)

Yes I am. ;)  mousdev.o and hid.o are both loaded and the device is listed in 
/proc/bus/usb/devices.

I don't know really, maybe I did indeed something wrong since it works for 
others. Though I don't know what that might have been. It works now with the 
driver compiled in.

Most other reports I've seen (two) were probably resolved with 
CONFIG_USB_HIDINPUT.

-- 
Oliver Feiler  <kiza@(gmx(pro).net|lionking.org|claws-and-paws.com)>
http://www.lionking.org/~kiza/  <--   homepage
PGP-key ID 0x561D4FD2    --> /pgpkey.shtml
http://www.lionking.org/~kiza/journal/

