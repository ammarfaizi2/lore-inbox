Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316927AbSEWQE3>; Thu, 23 May 2002 12:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316934AbSEWQE2>; Thu, 23 May 2002 12:04:28 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:31239 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316884AbSEWQEZ>;
	Thu, 23 May 2002 12:04:25 -0400
Date: Thu, 23 May 2002 09:04:10 -0700
From: Greg KH <greg@kroah.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: gowdy@slac.stanford.edu, Andre Bonin <kernel@bonin.ca>,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Linux-usb-users@lists.sourceforge.net
Subject: Re: [Linux-usb-users] Re: What to do with all of the USB UHCI drivers in the kernel?
Message-ID: <20020523160410.GC11153@kroah.com>
In-Reply-To: <Pine.LNX.4.44.0205230746500.1824-100000@router-273.sgowdy.org> <3CECFBEE.9010802@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 25 Apr 2002 14:44:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 04:25:50PM +0200, Martin Dalecki wrote:
> 
> Well what I know is the following: Kudzu did set up my system
> to use usb-ohci driver similar. And now you have apparently
> started to obsolete some of them. I know that there are still
> two drivers supported. So I would really really wellcome it
> if you would just write up some documentation about the *whole*
> transition from using some old driver to the one which is
> supposed to be the driver used in the future.

Hm, Kudzu shouldn't care, you just should not be able to load the
usb-ohci module on startup.  At least that's what happens to me on my
boxes.

Anyway, here's the documentation that you need:
	The module usb-ohci is now gone.  Use ohci-hcd instead.

The people with UHCI controllers have a big more documentation to read:
	The module uhci is now gone.  If you used this module, use
	uhci-hcd instead.  The module usb-uhci is now gone.  If you used
	this module, use usb-uhci-hcd instead.  If you have a preference
	over which UHCI module works better for you, please email
	greg@kroah.com your comments, as one of these modules will be
	going away in the near future.

> Most likely this would be of course module aliasing entires
> which could be used in /etc/modules.conf to cheat around
> kudzu  - this way it would be for example possible
> to have a nice dual boot configuration.

Heh, I don't mess around with module aliasing, so I don't know the first
thing of what to do in this situation.  Someone reading the above
documentation should be able to figure it all out.

> (I can adjust my boot scripts to set up an apriopriate symlink
> from /etc/modules.conf to modules-2.5.18.confg and
> modules-2.4.18.conf debpending what I'm booting anyway...)
> 
> In short - if you change something about the configuration
> and usage - just document it please.

We really don't use CHANGES anymore.  Where do you propose things like
the above few sentences go to where everyone will know to look?

thanks,

greg k-h
