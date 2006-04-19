Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWDSA27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWDSA27 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 20:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWDSA27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 20:28:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:20151 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750808AbWDSA27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 20:28:59 -0400
Date: Tue, 18 Apr 2006 17:25:13 -0700
From: Greg KH <gregkh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Nigel Cunningham <ncunningham@cyclades.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kernel doesn't compile with CONFIG_HOTPLUG && !CONFIG_NET
Message-ID: <20060419002513.GA8204@suse.de>
References: <200604190844.25476.ncunningham@cyclades.com> <20060418161614.321b61e7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060418161614.321b61e7.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2006 at 04:16:14PM -0700, Andrew Morton wrote:
> Nigel Cunningham <ncunningham@cyclades.com> wrote:
> >
> > --- 9904.patch-old/kernel/sysctl.c	2006-04-19 08:40:47.000000000 +1000
> > +++ 9904.patch-new/kernel/sysctl.c	2006-04-17 21:06:23.000000000 +1000
> > @@ -401,7 +401,7 @@ static ctl_table kern_table[] = {
> >  		.strategy	= &sysctl_string,
> >  	},
> >  #endif
> > -#ifdef CONFIG_HOTPLUG
> > +#if defined(CONFIG_HOTPLUG) && defined(CONFIG_NET)
> 
> I've had this in -mm for a couple of weeks now but rmk points out that it's
> rather silly.  Because if you have CONFIG_HOTPLUG=y, CONFIG_NET=n then the
> kernel cannot deliver hotplug events to userspace..
> 
> So perhaps CONFIG_HOTPLUG should depend upon CONFIG_NET or, better,
> CONFIG_NETLINK.

I have a patch in the queue from Kay that should fix this.  Hopefully...
Will get to it tomorrow.

> Dunno.  I left this in Greg's lap, but he's hiding.

Hiding?  A -stable release a day sure isn't hiding :)

thanks,

greg k-h
