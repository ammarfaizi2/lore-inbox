Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbUAEHkI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 02:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265825AbUAEHkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 02:40:08 -0500
Received: from mail.kroah.org ([65.200.24.183]:21160 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265817AbUAEHkE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 02:40:04 -0500
Date: Sun, 4 Jan 2004 23:39:57 -0800
From: Greg KH <greg@kroah.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@osdl.org>, Daniel Jacobowitz <dan@debian.org>,
       Andries Brouwer <aebr@win.tue.nl>, Rob Love <rml@ximian.com>,
       rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Message-ID: <20040105073957.GA13651@kroah.com>
References: <Pine.LNX.4.58.0401031856130.2162@home.osdl.org> <20040104142111.A11279@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105030737.GA29964@nevyn.them.org> <Pine.LNX.4.58.0401041918260.2162@home.osdl.org> <20040105035037.GD4176@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0401041954010.2162@home.osdl.org> <20040105043830.GE4176@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040105043830.GE4176@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 04:38:30AM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> Then we'd better have a very good idea of the things that are going to
> break.  Note that right now even late-boot code in kernel itself will
> break on that - there are explicit checks for ROOT_DEV==MKDEV(2,0),
> all sorts of weird crap deep in the bowels of arch/ppc/*/*, etc.
> 
> It won't be an easy transition - I know that Greg is very optimistic
> about it, but there will be a *lot* of crap to take care of.

Oh I know it's going to be tough, and there's going to be a lot of crap
to take care of, but in the end, I think it will be worth it...hopefully
if I'm still sane then...

> ObOtherStraightforwardThings: net_device refcounting.  Take a look at
> Jeff's queue someday - by now it's one big merge short of getting it
> right for practically all drivers.  1.9Mb total + 247Kb pending patches
> here.  Several hundreds changesets, practically all of them fixing
> exploitable holes.  And yes, most of them had been bugs all along -
> since 2.2 if not earlier.  Sure, that made things better, but if somebody
> comes along and makes similar "fun" necessary for e.g. ALSA...

Yeah, ALSA scares me, along with the input layer code.  I had dreams of
easily converting them to use proper refcounting, but now know there's
no way that would be an easy conversion and have pretty much given up on
it.  For 2.6 at least.  

That's why my "simple_class" patch will have to be a band-aid for now to
get sysfs representation for those types of devices.

thanks,

greg k-h
