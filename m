Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262130AbSIYWoi>; Wed, 25 Sep 2002 18:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262131AbSIYWoi>; Wed, 25 Sep 2002 18:44:38 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:14345 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262130AbSIYWoh>;
	Wed, 25 Sep 2002 18:44:37 -0400
Date: Wed, 25 Sep 2002 15:48:33 -0700
From: Greg KH <greg@kroah.com>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [RFC] consolidate /sbin/hotplug call for pci and usb
Message-ID: <20020925224833.GB420@kroah.com>
References: <20020925212955.GA32487@kroah.com> <Pine.LNX.4.44.0209251703060.28659-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209251703060.28659-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 05:04:25PM -0500, Kai Germaschewski wrote:
> On Wed, 25 Sep 2002, Greg KH wrote:
> 
> > diff -Nru a/drivers/base/Makefile b/drivers/base/Makefile
> > --- a/drivers/base/Makefile	Wed Sep 25 14:22:28 2002
> > +++ b/drivers/base/Makefile	Wed Sep 25 14:22:28 2002
> > @@ -5,6 +5,10 @@
> >  
> >  obj-y		+= fs/
> >  
> > +ifeq ($(CONFIG_HOTPLUG),y)
> > +	obj-y	+= hotplug.o
> > +endif
> > +
> >  export-objs	:= core.o power.o sys.o bus.o driver.o \
> >  			class.o intf.o
> >  
> 
> Why not the simpler
> 
> obj-$(CONFIG_HOTPLUG)	+= hotplug.o

Thanks, Pat also pointed this out to me.  
I'll fix it.

thanks,

greg k-h
