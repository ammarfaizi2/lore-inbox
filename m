Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289124AbSBEGvx>; Tue, 5 Feb 2002 01:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289185AbSBEGvl>; Tue, 5 Feb 2002 01:51:41 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:43524 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S289124AbSBEGvc>;
	Tue, 5 Feb 2002 01:51:32 -0500
Date: Mon, 4 Feb 2002 22:49:12 -0800
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: Patrick Mochel <mochel@osdl.org>, Dave Jones <davej@suse.de>,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driverfs support for USB - take 2
Message-ID: <20020205064912.GA31487@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0201291711560.800-100000@segfault.osdlab.org> <08cf01c1a933$f45ac460$6800000a@brownell.org> <20020130040908.GA23261@kroah.com> <0a1501c1a9c9$bdf427e0$6800000a@brownell.org> <20020202001804.GC10313@kroah.com> <0e9101c1ac1d$b18b25c0$6800000a@brownell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e9101c1ac1d$b18b25c0$6800000a@brownell.org>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 08 Jan 2002 04:42:49 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2002 at 11:13:26AM -0800, David Brownell wrote:
> > No, I'll say that we need to stay one physical device per device in the
> > tree. 
> 
> But we aren't that way today.  Examples:

<snip>

Ok, you're right.  We want to tell the drivers to shut down (remember,
the original goal of driverfs was for power management), so all drivers
that attach to a device need to be shown.

I'll play with the code some more and make this kind of change.

> >     If you want to do an interface tree, let's put that in usbfs,
> > where it belongs :)
> 
> Ah, but changing usbfs is impractical at this point since lots of
> userspace programs rely on it not changing.  Which is why I
> was pointing this out in the context of driverfs, which can still
> be improved in such ways ... "usbdevfs" was always advertised
> as "preliminary", anyway! :)

Heh, I took the "preliminary" tag off of it a short while ago, as so
many different userspace programs were using it.  Maybe usbfs2? :)

Seriously, I've had some ideas of a different way to implement the
functionality of usbfs, possibly without all of the ioctl calls, but I
have not had the time to experiment with it...

thanks,

greg k-h
