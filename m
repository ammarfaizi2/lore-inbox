Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265095AbUFVXou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265095AbUFVXou (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 19:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265098AbUFVXou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 19:44:50 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:12935 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265095AbUFVXos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 19:44:48 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Driver Core patches for 2.6.7
Date: Tue, 22 Jun 2004 18:44:38 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <1087926108744@kroah.com> <200406221821.02128.dtor_core@ameritech.net> <20040622233139.GF13197@kroah.com>
In-Reply-To: <20040622233139.GF13197@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406221844.38299.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 June 2004 06:31 pm, Greg KH wrote:
> On Tue, Jun 22, 2004 at 06:21:01PM -0500, Dmitry Torokhov wrote:
> > On Tuesday 22 June 2004 12:41 pm, Greg KH wrote:
> > 
> > >  
> > >  void class_unregister(struct class * cls)
> > >  {
> > >  	pr_debug("device class '%s': unregistering\n",cls->name);
> > > +	remove_class_attrs(cls);
> > >  	subsystem_unregister(&cls->subsys);
> > >  }
> > >  
> > 
> > Question: is it necessary to call remove_class_attrs? I thought that sysfs
> > automatically destroys all children when parent is destroyed? Am I imagining
> > things?
> 
> No, you aren't imagining things.  But it's considered "good form" to
> remove them if you can, as this will probably change in 2.7, and it will
> make my life easier trying to audit the whole tree at that time...
> 

Is there any specific reason for such a change? I kinda like the idea of
registering attributes and then having driver code do the bean counting
for me.

Btw, is there a chance for platform_device_register_simple that I sent to
you earlier be included?

-- 
Dmitry
