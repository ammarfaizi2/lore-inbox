Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTIMHNZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 03:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbTIMHNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 03:13:25 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:39066 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262063AbTIMHNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 03:13:22 -0400
Date: Sat, 13 Sep 2003 09:13:02 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Raphael Assenat <raph@raphnet.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ioctl entries for joystick in compat_ioctl.h
Message-ID: <20030913071302.GA9315@ucw.cz>
References: <20030912112557.C10099@raphnet.net> <20030912184145.GB5805@elf.ucw.cz> <20030912200148.GA7711@ucw.cz> <20030912211306.GA444@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030912211306.GA444@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 11:13:06PM +0200, Pavel Machek wrote:

> > > > I wanted to use a joystick on my sparc64 workstation, and discovered that the
> > > > joystick driver uses simple ioclt that are safe to pass from 32bit user space
> > > > to 64bit kernel space. My patch adds the necessary entries in compat_ioctl.h.
> > > > 
> > > > There is only one missing ioctl in the patch. The ioctl is defined like this:
> > > > #define JSIOCGNAME(len)         _IOC(_IOC_READ, 'j', 0x13, len)
> > > > so the command does not have a fixed value. I dont know how to handle this one,
> > > > but it is only used to get the joystick name, all the applications I tried work
> > > > well even if this ioctl fails.
> > > 
> > > Well, whoever invented that JSIOCGNAME should be shot. That is not
> > > single ioctl, its 2^14 of them!
> > 
> > Well, who could ever have known that this will be a problem in 1998?
> > It's not the only ioctl done this way.
> 
> So it was you? :-)

Yes. :)

> I believe ultrasparcs were around in '98. Anyway, what are other
> ioctls doing this? They look pretty problematic from compat_ioctl
> perspective.

I don't remember - I know I just copied the concept from elsewhere.
I'm sure you'll be able to grep for it.

> We could do better by pushing compat handler down to the drivers for
> ugly cases like this...

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
