Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129300AbRB0AUX>; Mon, 26 Feb 2001 19:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129310AbRB0AUP>; Mon, 26 Feb 2001 19:20:15 -0500
Received: from [216.161.55.93] ([216.161.55.93]:1265 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S129300AbRB0AUG>;
	Mon, 26 Feb 2001 19:20:06 -0500
Date: Mon, 26 Feb 2001 16:23:54 -0800
From: Greg KH <greg@wirex.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Pifko Krisztian <pifko@kirowski.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] philips rush usb support
Message-ID: <20010226162354.F5492@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>, Pavel Machek <pavel@suse.cz>,
	Pifko Krisztian <pifko@kirowski.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0102241730370.19866-100000@pifko.kirowski.com> <20010224121312.S16341@sventech.com> <20010225192454.A1697@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010225192454.A1697@bug.ucw.cz>; from pavel@suse.cz on Sun, Feb 25, 2001 at 07:24:54PM +0100
X-Operating-System: Linux 2.4.2-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2001 at 07:24:54PM +0100, Pavel Machek wrote:
> > > Userspace stuff should be found at http://openrush.sourceforge.net
> > > if you have a rush. It works for me on ia32 with the model sa125.
> > 
> > Why can't the entire driver be in userspace? It appears it uses a
> > completely proprietary protocol and you've created a completely
> > proprietary interface to the kernel.
> 
> Would not making it "usb-serial" device do the trick?

That would work if you don't want to use a new minor number for the
device.  But all of the current usb-serial drivers are there because
userspace tools expect the device to act just like a serial port.  Since
the userspace tools for this device is closely tied to the driver, that
restriction isn't really there.

I also agree with Johannes, this would probably be better off as a
userspace program.

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
