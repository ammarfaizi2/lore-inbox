Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbVLaATK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbVLaATK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 19:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbVLaATK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 19:19:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:16364 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750778AbVLaATH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 19:19:07 -0500
Date: Fri, 30 Dec 2005 16:12:12 -0800
From: Greg KH <greg@kroah.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 8 of 20] ipath - core driver, part 1 of 4
Message-ID: <20051231001212.GC20314@kroah.com>
References: <patchbomb.1135816279@eng-12.pathscale.com> <ddd21709e12c0cd55bdc.1135816287@eng-12.pathscale.com> <20051230083928.GD7438@kroah.com> <1135986427.13318.79.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135986427.13318.79.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 03:47:07PM -0800, Bryan O'Sullivan wrote:
> On Fri, 2005-12-30 at 00:39 -0800, Greg KH wrote:
> 
> > > +void ipath_chip_done(void)
> > > +{
> > > +}
> > > +
> > > +void ipath_chip_cleanup(struct ipath_devdata * dd)
> > > +{
> > > +}
> > 
> > What are these two empty functions for?
> 
> They're just as dead as they look.

Then you might want to remove them :)

> > > +static ssize_t show_status_str(struct device *dev,
> 
> > how big can this "status string" be?
> 
> Just a few dozen bytes.
> 
> >   If it's even getting close to
> > PAGE_SIZE, this doesn't need to be a sysfs attribute, but you should
> > break it up into its individual pieces.
> 
> Do you think that's still warranted, given this?

No I don't, unless you think that message will grow somehow...

thanks,

greg k-h
