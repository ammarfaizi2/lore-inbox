Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbWDMSvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbWDMSvP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 14:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWDMSvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 14:51:15 -0400
Received: from ns2.suse.de ([195.135.220.15]:57265 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964954AbWDMSvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 14:51:15 -0400
Date: Thu, 13 Apr 2006 11:50:14 -0700
From: Greg KH <gregkh@suse.de>
To: tyler@agat.net
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kmod optimization
Message-ID: <20060413185014.GA27130@suse.de>
References: <20060413180345.GA10910@Starbuck> <20060413182401.GA26885@suse.de> <20060413183617.GB10910@Starbuck>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413183617.GB10910@Starbuck>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 08:36:17PM +0200, tyler@agat.net wrote:
> On Thu, Apr 13, 2006 at 11:24:01AM -0700, Greg KH wrote:
> > On Thu, Apr 13, 2006 at 08:03:45PM +0200, tyler@agat.net wrote:
> > > Hi,
> > > 
> > > the request_mod functions try to load automatically a module by running
> > > a user mode process helper (modprobe).
> > > 
> > > The user process is launched even if the module is already loaded. I
> > > think it would be better to test if the module is already loaded.
> > 
> > Does this cause a problem somehow?  request_mod is called _very_
> > infrequently from a normal kernel these days, so I really don't think
> > this is necessary.
> 
> Yes I agree it _should_ be very infrequently called but it _will_ be very
> infrequently called just if the user space configuration is done properly.

What do you mean by this?  Almost all 2.6 distros use udev today, which
prevents this code from ever getting called.  So odds are, you are
optimising something that no one will ever use :)

> I personnaly think we shouldn't trust the configuration and the way the
> different modules are loaded.

What way different modules are loaded?  What problem are you referring
to here?

thanks,

greg k-h
