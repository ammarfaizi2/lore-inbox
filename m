Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261606AbSIXTZt>; Tue, 24 Sep 2002 15:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261623AbSIXTZt>; Tue, 24 Sep 2002 15:25:49 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:34054 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261606AbSIXTZs>;
	Tue, 24 Sep 2002 15:25:48 -0400
Date: Tue, 24 Sep 2002 12:29:56 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: 2.5.26 hotplug failure
Message-ID: <20020924192956.GA25963@kroah.com>
References: <Pine.LNX.4.44.0209241118130.966-200000@cherise.pdx.osdl.net> <Pine.LNX.4.33.0209241146520.7652-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0209241146520.7652-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2002 at 11:55:00AM -0700, Linus Torvalds wrote:
> 
> So I'd suggest you just export a text-file that describes the thing. 
> Something like
> 
>  - legacy name (the kernel knows about these anyway, see /proc/mounts and 
>    friends)

I would like to see all of the /proc/mounts and friends info that
"knows" about the legacy name, to disappear if possible.  Yes, I know
the root filesystem logic will have to stay, but I don't want to see
this be used like the devfs name is used throughout the kernel.  That
info should not be in the kernel, it's up to the user what to name their
"USB mouse, connected to the EHCI host controller's 3 hub port".

>  - major number, minor number) and char vs block

Yes, this info is needed, and if presented in a file, that would be
fine.  It was just that the device node was a nice compact version of
this :)
But I can see how the device node would be abused, and it's fine with me
if it isn't present in driverfs.

thanks,

greg k-h
