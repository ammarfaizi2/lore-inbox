Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262319AbVAKTjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbVAKTjY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 14:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbVAKThQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 14:37:16 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:53453 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262343AbVAKTgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 14:36:51 -0500
Date: Tue, 11 Jan 2005 11:29:09 -0800
From: Greg KH <greg@kroah.com>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH] add support for sysdev class attributes
Message-ID: <20050111192909.GA4623@kroah.com>
References: <1105136891.13391.20.camel@pants.austin.ibm.com> <20050108050729.GA7587@kroah.com> <1105372684.27280.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105372684.27280.3.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 09:58:03AM -0600, Nathan Lynch wrote:
> On Fri, 2005-01-07 at 21:07 -0800, Greg KH wrote:
> > On Fri, Jan 07, 2005 at 04:28:12PM -0600, Nathan Lynch wrote:
> > > @@ -88,6 +123,12 @@ int sysdev_class_register(struct sysdev_
> > >  	INIT_LIST_HEAD(&cls->drivers);
> > >  	cls->kset.subsys = &system_subsys;
> > >  	kset_set_kset_s(cls, system_subsys);
> > > +
> > > +	/* I'm not going to claim to understand this; see
> > > +	 * fs/sysfs/file::check_perm for how sysfs_ops are selected
> > > +	 */
> > > +	cls->kset.kobj.ktype = &sysdev_class_ktype;
> > > +
> > 
> > I think you need to understand this, and then submit a patch without
> > such a comment :)
> > 
> > And probably without such code, as I don't think you need to do that.
> 
> Sure, now I'm not sure how I convinced myself that bit was needed.
> Things work fine without it.
> 
> Before I repatch, does sysdev_class_ktype need a release function?

Why would it not?

thanks,

greg k-h
