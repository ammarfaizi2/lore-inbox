Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbUAMASn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 19:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbUAMASn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 19:18:43 -0500
Received: from mail.kroah.org ([65.200.24.183]:5084 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262913AbUAMASl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 19:18:41 -0500
Date: Mon, 12 Jan 2004 16:18:33 -0800
From: Greg KH <greg@kroah.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restrict class names to valid file names
Message-ID: <20040113001833.GB4848@kroah.com>
References: <20040112151357.5c9702b7.shemminger@osdl.org> <20040113000514.GA4848@kroah.com> <20040112161336.3e147996.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040112161336.3e147996.shemminger@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12, 2004 at 04:13:36PM -0800, Stephen Hemminger wrote:
> On Mon, 12 Jan 2004 16:05:14 -0800
> Greg KH <greg@kroah.com> wrote:
> 
> > On Mon, Jan 12, 2004 at 03:13:57PM -0800, Stephen Hemminger wrote:
> > > It is possible to name network devices with names like "my/bogus" or "." or ".."
> > > which leaves /sys/class/net/ a mess.  Since other subsystems could have the same
> > > problem, it made sense to me to enforce some restrictions in the class device
> > > layer.
> > > 
> > > A lateer patch fixes the network device registration path because the
> > > sysfs registration takes place after the register_netdevice call has taken place.
> > 
> > Heh, so you will have already "scrubbed" the name before you submit it
> > to the driver core?  If so, why add this patch?
> 
> Because name won't be scrubbed for the rename case

Why not?  Does that mean that those characters are valid names for
network devices if the device is renamed from userspace?

> , and other class devices probably have the same possible problem

I don't know of any other class device code in the kernel that accepts
userspace input as its name.

thanks,

greg k-h
