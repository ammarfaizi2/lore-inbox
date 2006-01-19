Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030492AbWASDgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030492AbWASDgx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 22:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030486AbWASDgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 22:36:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:41931 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030483AbWASDgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 22:36:51 -0500
Date: Wed, 18 Jan 2006 19:35:32 -0800
From: Greg KH <gregkh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/base/: proper prototypes
Message-ID: <20060119033532.GA16518@suse.de>
References: <20060119013242.GX19398@stusta.de> <20060119025146.GA15257@suse.de> <20060119032808.GJ19398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119032808.GJ19398@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 04:28:08AM +0100, Adrian Bunk wrote:
> On Wed, Jan 18, 2006 at 06:51:47PM -0800, Greg KH wrote:
> > On Thu, Jan 19, 2006 at 02:32:42AM +0100, Adrian Bunk wrote:
> > > This patch contains the following changes:
> > > - move prototypes to base.h
> > > - sys.c should #include "base.h" for getting the prototype of it's
> > >   global function system_bus_init()
> > > 
> > > Note that hidden in this patch there's a bugfix:
> > > 
> > > Caller and callee disagreed regarding the return type of 
> > > sysdev_shutdown().
> > > 
> > > 
> > > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > > 
> > > ---
> > > 
> > >  drivers/base/base.h           |    6 ++++++
> > >  drivers/base/power/resume.c   |    3 +--
> > >  drivers/base/power/shutdown.c |    2 +-
> > >  drivers/base/power/suspend.c  |    3 +--
> > >  drivers/base/sys.c            |    2 ++
> > >  5 files changed, 11 insertions(+), 5 deletions(-)
> > > 
> > > --- linux-2.6.16-rc1-mm1-full/drivers/base/base.h.old	2006-01-18 23:17:52.000000000 +0100
> > > +++ linux-2.6.16-rc1-mm1-full/drivers/base/base.h	2006-01-18 23:41:33.000000000 +0100
> > > @@ -1,6 +1,8 @@
> > >  
> > >  /* initialisation functions */
> > >  
> > > +#include <linux/device.h>
> > > +
> > 
> > Why is this extra #include needed?  It shouldn't be.
> 
> struct class_device and struct class_device_attribute are needed since 
> they are used in base.h .

But anyone who includes base.h will have already included this header
file, right?  That was my point.

thanks,

greg k-h
