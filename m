Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263552AbUCTV7i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 16:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263553AbUCTV7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 16:59:38 -0500
Received: from mail.kroah.org ([65.200.24.183]:52934 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263552AbUCTV7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 16:59:36 -0500
Date: Sat, 20 Mar 2004 13:59:09 -0800
From: Greg KH <greg@kroah.com>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] Sysfs for framebuffer
Message-ID: <20040320215909.GA26277@kroah.com>
References: <20040320174956.GA3177@dreamland.darkstar.lan> <20040320213030.GA3950@kroah.com> <20040320215219.GA20277@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040320215219.GA20277@dreamland.darkstar.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 10:52:19PM +0100, Kronos wrote:
> Il Sat, Mar 20, 2004 at 01:30:30PM -0800, Greg KH ha scritto: 
> > On Sat, Mar 20, 2004 at 06:49:56PM +0100, Kronos wrote:
> > > Hi,
> > > the following patch (against 2.6.5-rc2) teaches fb to use class_simple.
> > > With this patch udev will automagically create device nodes for each
> > > framebuffer registered. Once all drivers are converted to
> > > framebuffer_{alloc,release} we can switch to our own class.
> > 
> > yeah, it's about time!  Didn't I post this patch a few months ago... :)
> 
> Hum, I remeber your patch that did the same thing, but it didn't use
> class_simple, did it?

I think I had one version that did, but who cares, it doesn't really
matter :)

> > > notebook:~# tree /sys/class/graphics/
> > > /sys/class/graphics/
> > 
> > "graphics"?  Why that?  Why not "fb"?
> > 
> > It doesn't really matter to me, just curious.
> 
> It was discussed a while ago (this is James):
> 
> <quote>
> On Tue, 9 Sep 2003, Benjamin Herrenschmidt wrote:
> > > On Tue, 2003-09-09 at 21:24, Kronos wrote:
> > > > +static struct class fb_class = {
> > > > + .name           = "video",
> > >
> > > I'd rather use "display" here. "video" is too broad and will cause
> > > confusion with multimedia stuff.
> >
> > Exactly my comment. I was thinking about `graphics' instead of
> > `video', but indeed `display' sounds better. Gr{oetje,eeting}s,
> 
> I prefere graphics myself. Display sounds to generic. That is what video
> and graphics output is piped to. Since fbdev doesn't handle video ouput
> normally this is kind of fuzzy sounding.
> </quote>

Well, /sys/class/video is already taken by the V4L core code, so if
"graphics" doesn't confuse people, it's ok with me.

thanks,

greg k-h
