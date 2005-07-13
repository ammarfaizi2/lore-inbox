Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262776AbVGMU0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbVGMU0x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 16:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262741AbVGMUYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 16:24:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:42399 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262776AbVGMUXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 16:23:21 -0400
Date: Wed, 13 Jul 2005 13:19:06 -0700
From: Greg KH <greg@kroah.com>
To: Doug Warzecha <Douglas_Warzecha@dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: Add Dell Systems Management Base driver
Message-ID: <20050713201906.GB15573@kroah.com>
References: <20050706001333.GA3569@sysman-doug.us.dell.com> <20050706041702.GA10253@kroah.com> <20050706155734.GA4271@sysman-doug.us.dell.com> <20050706160737.GC13115@kroah.com> <20050713005716.GA15298@sysman-doug.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713005716.GA15298@sysman-doug.us.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 07:57:16PM -0500, Doug Warzecha wrote:
> On Wed, Jul 06, 2005 at 11:07:37AM -0500, Greg KH wrote:
> >    On Wed, Jul 06, 2005 at 10:57:35AM -0500, Doug Warzecha wrote:
> >    > On Tue, Jul 05, 2005 at 11:17:03PM -0500, Greg KH wrote:
> >    > >
> >    > >    I'm sure I commented on this driver already, yet, I never got a
> >    response
> >    > >    and the code is not changed.  Is there some reason for this? 
> >    That's a
> >    > >    sure way to prevent your patch from ever being applied...
> >    >
> >    > This is the first comment on the release function.  The code has been
> >    > changing in response to comments from you and others.  We'll continue
> >    > to make changes as needed.
> > 
> >    You never responded to those questions though, so determining if the
> >    code was changed is difficult.  And I still see you using ioctls, which,
> >    if I remember, was what I asked about.
> > 
> 
> The dcdbas driver has been shipping outside of the kernel tree for
> some time now in support of the systems listed in the source and is
> expected to support the listed systems for some time to come.  The
> driver has always used ioctls for Dell systems management software to
> communicate with it.

Well, your code has always been wrong then :)

> The systems that are supported by the driver are
> older Dell PowerEdge systems which contain Dell proprietary hardware
> systems management interfaces.  The latest shipping PowerEdge systems
> support the standard IPMI hardware systems management interface which
> can be accessed by the in-kernel standard IPMI driver (which uses
> ioctls).  Future PowerEdge systems are expected to support the IPMI
> systems management interface as well.

Then only support the "new" interface for newer systems.

> Even though the dcdbas driver is not expected to be needed for future
> PowerEdge systems, we would like to make it easier for Dell customers
> to run Dell systems management software with the latest kernel on the
> systems supported by the dcdbas driver by making the driver available
> in the kernel tree.  We would like to do that without impacting the
> existing Dell systems management software for the older systems so
> that we can focus our resources on the newer systems.
> 
> Is it an absolute "must" that this driver not use ioctls?

Yes.  Sorry.

thanks,

greg k-h
