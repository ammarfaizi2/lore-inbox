Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265000AbUFVXd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265000AbUFVXd0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 19:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265057AbUFVXdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 19:33:25 -0400
Received: from mail.kroah.org ([65.200.24.183]:25069 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265000AbUFVXdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 19:33:19 -0400
Date: Tue, 22 Jun 2004 16:31:40 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core patches for 2.6.7
Message-ID: <20040622233139.GF13197@kroah.com>
References: <1087926108744@kroah.com> <200406221821.02128.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406221821.02128.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 06:21:01PM -0500, Dmitry Torokhov wrote:
> On Tuesday 22 June 2004 12:41 pm, Greg KH wrote:
> 
> >  
> >  void class_unregister(struct class * cls)
> >  {
> >  	pr_debug("device class '%s': unregistering\n",cls->name);
> > +	remove_class_attrs(cls);
> >  	subsystem_unregister(&cls->subsys);
> >  }
> >  
> 
> Question: is it necessary to call remove_class_attrs? I thought that sysfs
> automatically destroys all children when parent is destroyed? Am I imagining
> things?

No, you aren't imagining things.  But it's considered "good form" to
remove them if you can, as this will probably change in 2.7, and it will
make my life easier trying to audit the whole tree at that time...

thanks,

greg k-h
