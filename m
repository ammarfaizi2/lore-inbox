Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVATRtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVATRtQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 12:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVATRtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 12:49:15 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:49079 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262219AbVATRrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 12:47:15 -0500
Date: Thu, 20 Jan 2005 09:47:08 -0800
From: Greg KH <greg@kroah.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: kobject_uevent.c moved to kernel connector.
Message-ID: <20050120174708.GA10045@kroah.com>
References: <20041124222857.GG3584@kroah.com> <1102504677.3363.55.camel@uganda> <20041221204101.GA9831@kroah.com> <1103707272.3432.6.camel@uganda> <20041225180241.38ffb9d8@zanzibar.2ka.mipt.ru> <20050104060211.50c2bf47@zanzibar.2ka.mipt.ru> <20050112190615.GC10885@kroah.com> <20050113011519.6e087fb4@zanzibar.2ka.mipt.ru> <20050119230518.GA5569@kroah.com> <1106210906.5264.46.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106210906.5264.46.camel@uganda>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 11:48:26AM +0300, Evgeniy Polyakov wrote:
> On Wed, 2005-01-19 at 15:05 -0800, Greg KH wrote:
> > On Thu, Jan 13, 2005 at 01:15:19AM +0300, Evgeniy Polyakov wrote:
> > > --- include/linux/connector.h~	2005-01-13 00:21:55.000000000 +0300
> > > +++ include/linux/connector.h	2005-01-13 00:53:21.000000000 +0300
> > > @@ -24,6 +24,9 @@
> > >  
> > >  #include <asm/types.h>
> > >  
> > > +#define CONN_IDX_KOBJECT_UEVENT		0xabcd
> > > +#define CONN_VAL_KOBJECT_UEVENT		0x0000
> > > +
> > >  #define CONNECTOR_MAX_MSG_SIZE 	1024
> > >  
> > >  struct cb_id
> > > --- linux-2.6/drivers/connector/connector.c.orig	2005-01-13 00:21:23.000000000 +0300
> > > +++ linux-2.6/drivers/connector/connector.c	2005-01-13 00:32:48.000000000 +0300
> > > @@ -46,6 +46,8 @@
> > >  
> > >  static struct cn_dev cdev;
> > >  
> > > +int cn_already_initialized = 0;
> > 
> > <snip>
> > 
> > Hm, this patch needs to be rediffed, now that I've accepted the
> > connector code, right?  The connector.c change seems to already be in
> > your last connector patch, and the .h change is there with a different
> > #define spelling, causing the uevent code to need to be changed.
> > 
> > Care to redo it?
> 
> Sure. Patch attached. 

Applied, thanks.

greg k-h
