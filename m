Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129558AbRBMQuW>; Tue, 13 Feb 2001 11:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129937AbRBMQuM>; Tue, 13 Feb 2001 11:50:12 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:11788 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129558AbRBMQt4>; Tue, 13 Feb 2001 11:49:56 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBE043@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Elmer Joandi'" <elmer@linking.ee>
Cc: linux-kernel@vger.kernel.org
Subject: RE: USB mouse jumping
Date: Tue, 13 Feb 2001 08:49:29 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Elmer Joandi [mailto:elmer@linking.ee]
> 
> On Tue, 13 Feb 2001, Dunlap, Randy wrote:
> 
> > If USB mice had serial numbers (like some USB storage devices
> > do), then we could tell that it's the same mouse on the
> > same connector and not change from mouse0 to mouse1.
> > Currently it looks like a new device attachment.
> > 
> > One possible solution is for you to use /dev/usb/mice,
> > which is all USB mice merged into one input stream.
> 
> 
> Please, if it is possible, make it simple and sensible.
> 
> if to have true multihead, with 5 keyboards and mice, I would 
> really wish
> that the device numbers are connected to physical holes for plugs,
> otherwise anyone (of schoolchildren for example) can do simple nasty
> stupid things.

It's currently not designed for multihead usage.
I haven't looked at it much, but I believe that the
linux-console project is working on that.  (?)
(http://sourceforge.net/projects/linuxconsole/)

I agree; your suggestion (same physical device on same connector =>
same logical device) makes sense to me, at least for some
devices, like mice and keyboards.  For some devices it could
lead to misuse of the device.

> And also it is the dream for true dumbuser with one mouse, 
> because it then just works out of box.

Use /dev/input/mice for this case, not /dev/input/mouse0 .

(Ah, I said /dev/usb/mice earlier; should be /dev/input/mice .)

> Or you tell that with USB internal design you can not know physical
> connector unique number ?

Yes, we can/do know what physical connector a device is attached
on.

~Randy

