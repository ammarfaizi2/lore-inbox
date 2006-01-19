Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161110AbWASF2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161110AbWASF2M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 00:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161115AbWASF2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 00:28:12 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17931 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161110AbWASF2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 00:28:11 -0500
Date: Thu, 19 Jan 2006 04:28:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/base/: proper prototypes
Message-ID: <20060119032808.GJ19398@stusta.de>
References: <20060119013242.GX19398@stusta.de> <20060119025146.GA15257@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119025146.GA15257@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 06:51:47PM -0800, Greg KH wrote:
> On Thu, Jan 19, 2006 at 02:32:42AM +0100, Adrian Bunk wrote:
> > This patch contains the following changes:
> > - move prototypes to base.h
> > - sys.c should #include "base.h" for getting the prototype of it's
> >   global function system_bus_init()
> > 
> > Note that hidden in this patch there's a bugfix:
> > 
> > Caller and callee disagreed regarding the return type of 
> > sysdev_shutdown().
> > 
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > ---
> > 
> >  drivers/base/base.h           |    6 ++++++
> >  drivers/base/power/resume.c   |    3 +--
> >  drivers/base/power/shutdown.c |    2 +-
> >  drivers/base/power/suspend.c  |    3 +--
> >  drivers/base/sys.c            |    2 ++
> >  5 files changed, 11 insertions(+), 5 deletions(-)
> > 
> > --- linux-2.6.16-rc1-mm1-full/drivers/base/base.h.old	2006-01-18 23:17:52.000000000 +0100
> > +++ linux-2.6.16-rc1-mm1-full/drivers/base/base.h	2006-01-18 23:41:33.000000000 +0100
> > @@ -1,6 +1,8 @@
> >  
> >  /* initialisation functions */
> >  
> > +#include <linux/device.h>
> > +
> 
> Why is this extra #include needed?  It shouldn't be.

struct class_device and struct class_device_attribute are needed since 
they are used in base.h .

> thanks,
> 
> greg k-h

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

