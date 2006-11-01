Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752329AbWKAUrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbWKAUrY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 15:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752327AbWKAUrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 15:47:24 -0500
Received: from mail.first.fraunhofer.de ([194.95.169.2]:50175 "EHLO
	mail.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1752331AbWKAUrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 15:47:23 -0500
Subject: Re: Fwd: Re: [linux-usb-devel] usb initialization
	order	(usbhid	vs. appletouch)
From: Soeren Sonnenburg <kernel@nn7.de>
To: Joseph Fannin <jhf@columbus.rr.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Oliver Neukum <oliver@neukum.name>,
       Sergey Vlasov <vsu@altlinux.ru>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20061030200516.GA26137@nineveh.rivenstone.net>
References: <1161856438.5214.2.camel@no.intranet.wo.rk>
	 <1162054576.3769.15.camel@localhost> <200610282043.59106.oliver@neukum.org>
	 <200610282055.29423.oliver@neukum.name> <1162067266.4044.2.camel@localhost>
	 <20061030101202.GB9265@nineveh.rivenstone.net>
	 <1162212211.3512.2.camel@localhost>
	 <20061030200516.GA26137@nineveh.rivenstone.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 01 Nov 2006 20:47:02 +0000
Message-Id: <1162414022.17275.32.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-30 at 15:05 -0500, Joseph Fannin wrote:
> On Mon, Oct 30, 2006 at 01:43:31PM +0100, Soeren Sonnenburg wrote:
> > On Mon, 2006-10-30 at 05:12 -0500, Joseph Fannin wrote:
> > > On Sat, Oct 28, 2006 at 10:27:46PM +0200, Soeren Sonnenburg wrote:
> > > > On Sat, 2006-10-28 at 20:55 +0200, Oliver Neukum wrote:
> > > > > > From: Sergey Vlasov <vsu@altlinux.ru>
> > > > > > Subject: usbhid: Add HID_QUIRK_IGNORE_MOUSE flag
> > > > > >
> > > > > > Some HID devices by Apple have both keyboard and mouse interfaces; the
> > > > > > keyboard interface is handled by usbhid, but the mouse (really
> > > > > > touchpad) interface must be handled by the separate 'appletouch'
> > > > > > driver.  Using HID_QUIRK_IGNORE will make hiddev ignore both
> > > > > > interfaces, therefore a new quirk flag to ignore only the mouse
> > > > > > interface is required.
> > >
> > >     The appletouch driver doesn't work properly on the MacBook
> > > (non-Pro).  It claims the device, and sort of functions, but is
> > > basically unusable.
> > >
> > >     If this goes in, and blacklists the MacBook touchpad too, Macbook
> > > users will be unhappy.  I think the MacBook and the -Pro use the same
> > > IDs, though, which makes a problem for this patch until appletouch is
> > > fixed on MacBooks.
> >
> > Can you please be a bit more specific on this ? Other sites mention it
> > works http://bbbart.ulyssis.be/gentoomacbook/ ... what are you missing ?
> > Sensitivity and such can all be tweaked in xorg.conf ...
> 
>     That's the first I've heard of it working on a vanilla MacBook.
> I'm glad.  I've only heard of failures before, some by people way
> smarter than me.

[lots of problems with the appletouch driver]

OK I am asking this on the mactel-linux list... Lets see if these
problems are gone and I find some happy mb appletouch user...

In the worst case this patch could be a config option or will have to be
kept separate.

Soeren.
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.
