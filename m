Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbTCUXK1>; Fri, 21 Mar 2003 18:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261782AbTCUXK1>; Fri, 21 Mar 2003 18:10:27 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:32264 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261353AbTCUXK0>;
	Fri, 21 Mar 2003 18:10:26 -0500
Date: Fri, 21 Mar 2003 15:21:31 -0800
From: Greg KH <greg@kroah.com>
To: "Kevin P. Fleming" <kpfleming@cox.net>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: small devfs patch for 2.5.65, plan to replace /sbin/hotplug
Message-ID: <20030321232131.GA18010@kroah.com>
References: <20030321014048.A19537@baldur.yggdrasil.com> <3E7B79D5.3060903@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E7B79D5.3060903@cox.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 01:45:09PM -0700, Kevin P. Fleming wrote:
> Adam J. Richter wrote:
> >	I believe that the only change in this version of devfs is
> >moving the code to invoke the user level devfs_helper program to a
> >separate file, fs/devfs/notify.c.  This change will simplify a future
> >code shrink inspired by David Brownell's suggesting that I think about
> >unifying hotplug with devfs.  In the future I would like to lift
> >fs/devfs/notify.c out of devfs so that the code that currently invokes
> >user level helpers for hot plug events can be replaced with two calls
> >to a renamed devfs_event() on
> >/sys/bus/<bustype>/devices/<bus#>/<whatever>, one for insertion and
> >one for removal.

Adam, right now we get /sbin/hotplug events for every device insertion
and removal in the kernel.  Do you want more than this?

> Are you still considering smalldevfs for 2.6 inclusion? If not, then I'd 
> like to discuss with you (and Greg KH) the possibility of just eliminating 
> devfs entirely, and moving to a userspace version that is driven entirely 
> by /sbin/hotplug.

You mean with something like this:
	http://www.linuxsymposium.org/2003/view_abstract.php?talk=94
:)

thanks,

greg k-h
