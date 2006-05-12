Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWELPPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWELPPw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 11:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWELPPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 11:15:52 -0400
Received: from mail.suse.de ([195.135.220.2]:29676 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932121AbWELPPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 11:15:51 -0400
Date: Fri, 12 May 2006 08:13:58 -0700
From: Greg KH <greg@kroah.com>
To: Razvan Gavril <razvan.g@plutohome.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Coldpluging or USB Issues ?
Message-ID: <20060512151358.GA22871@kroah.com>
References: <4462F4E1.4060008@plutohome.com> <20060511234452.GA18542@kroah.com> <44647AEE.6040106@plutohome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44647AEE.6040106@plutohome.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 03:09:18PM +0300, Razvan Gavril wrote:
> Greg KH wrote:
> >On Thu, May 11, 2006 at 11:25:05AM +0300, Razvan Gavril wrote:
> >  
> >>As far as i know since 2.6.15 there is a new coldplug mechanism using 
> >>uevent and switching to a newer version of udevd that can do the cold 
> >>plugging and replacing the old hotplug scripts would be the natural next 
> >>step but before doing this i need to ask some questions like :
> >>1) Where there any changes sine 2.6.15 that could cause the old hotplug 
> >>scripts to work reliable because most part of the time (95%) they are 
> >>working ?
> >>    
> >
> >I don't know, what is failing?
> >
> >  
> Sometimes if fails to load the modules for the usb devices at boot but 
> there are no step to reproduce, looks totally random and only on rare 
> occasions if failing.

I have not heard of this problem before, nor can I think of anything
that has changed to affect this.

But those hotplug scripts are old and crufty and not really supported by
anyone anymore.

> >>2) Upgrading to newer version of udevd to let the udev scripts to do 
> >>the coldpluging can solve any issues that where described ?
> >>    
> >
> >Probably, that's what all of the major distros have already done.  It
> >makes the startup logic much smaller and simpler.
> >
> >This should be continued on the linux-hotplug-devel mailing list if you
> >are interested.
> I know that most major distros made the switch, but does anything 
> changed so it would make debian's hotplug scripts (and i don't thing 
> they are only used on debian) incompatible with kernels greater than 
> 2.6.15 ?

Why not ask the Debian maintainer of these scripts.  I'm sure that a lot
of Debian users still use them without udev.

> I cannot risk to upgrade to udev and have the same unstable platform.
> The most secure option that i have now is going back to 2.6.13 if udev
> can't give me a satisfactory answer.
> 
> PS: I can't find any mailing list named linux-hotplug-devel as i would 
> be more that happy to move my mail there.

http://www.google.com/search?q=linux-hotplug-devel+mailing+list second
hit shows the mailman interface to sign up or send mail to it.

thanks,

greg k-h
