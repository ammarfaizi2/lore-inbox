Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292153AbSBBAUD>; Fri, 1 Feb 2002 19:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292156AbSBBATx>; Fri, 1 Feb 2002 19:19:53 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:63243 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S292153AbSBBATs>;
	Fri, 1 Feb 2002 19:19:48 -0500
Date: Fri, 1 Feb 2002 16:18:04 -0800
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: Patrick Mochel <mochel@osdl.org>, Dave Jones <davej@suse.de>,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [PATCH] driverfs support for USB - take 2
Message-ID: <20020202001804.GC10313@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0201291711560.800-100000@segfault.osdlab.org> <08cf01c1a933$f45ac460$6800000a@brownell.org> <20020130040908.GA23261@kroah.com> <0a1501c1a9c9$bdf427e0$6800000a@brownell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a1501c1a9c9$bdf427e0$6800000a@brownell.org>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 04 Jan 2002 21:46:21 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 12:07:26PM -0800, David Brownell wrote:
> > And also remember, the status file in a device's directory also provides
> > a _lot_ of information.  We haven't even started to fill up the fields
> > there...
> 
> And there can be a lot more such files.  Though that 4KB limit
> may become an issue at some point.

I doubt it, we are talking one value per file here.  I can't see any USB
driver wanting to go over 4Kb for 1 value (and if it does, I'll change
it :)

> What sort of USB information were you thinking should show
> up?  Current configuration and altsetting?  Power consumption
> for hubs (not that we budget that yet :)?  There really aren't any
> examples of this in the kernel yet.

Bandwidth is a good one.
Current config and altsetting might be useful.
I haven't really thought about the different files yet.

> Also, one could argue that each USB function ("interface")
> should be presented as an individual device, just like each PCI
> function is handled ... after all, USB drivers bind to interfaces,
> not devices, and this is the "driver" FS!  :)

No, I'll say that we need to stay one physical device per device in the
tree.  If you want to do an interface tree, let's put that in usbfs,
where it belongs :)

thanks,

greg k-h
