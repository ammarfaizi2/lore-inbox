Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbULPTmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbULPTmo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 14:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbULPTmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 14:42:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:32463 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261998AbULPTml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 14:42:41 -0500
Date: Thu, 16 Dec 2004 11:42:24 -0800
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: debugfs in the namespace
Message-ID: <20041216194224.GA6640@kroah.com>
References: <20041216110002.3e0ddf52@lembas.zaitcev.lan> <20041216190835.GE5654@kroah.com> <20041216113357.4c2714bb@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216113357.4c2714bb@lembas.zaitcev.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 11:33:57AM -0800, Pete Zaitcev wrote:
> On Thu, 16 Dec 2004 11:08:35 -0800, Greg KH <greg@kroah.com> wrote:
> 
> > On Thu, Dec 16, 2004 at 11:00:02AM -0800, Pete Zaitcev wrote:
> > > what is the canonic place to mount debugfs: /debug, /debugfs, or anything
> > > else? The reason I'm asking is that USBMon has to find it somewhere and
> > > I'd really hate to see it varying from distro to distro.
> > 
> > Hm, in my testing I've been putting it in /dbg, but I don't like vowels :)
> 
> Oh, that's right: usr and creat. How could I forget.
> 
> > Anyway, I don't really know.  /dev/debug/ ?  /proc/debug ?  /debug ?
> > 
> > What do people want?  I guess it's time to write up a LSB proposal :(
> 
> I use /debug but it's not too late to change. Fedora does not ship it yet,
> so I don't think we have an institutional opinion about it.
> 
> Personally, I'm against the doubles to prevent issues with the mounting
> order on boot, but that's rather weak. The /dev can be specially managed
> and I'm concerned with people running find(1) on it. The /proc sounds
> better, but mounting anything under /proc requires a kernel component
> to create a directory, does it not?

Yes it does, but debugfs could create the mount point, if people agree
that this is a good place to put it (like usbfs does.)

Personally, I don't want to put it there, but that's just because I hate
proc stuff :)

So, /debug sounds good to me.  Any objections?

thanks,

greg k-h
