Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWBAIuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWBAIuM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 03:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWBAIuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 03:50:12 -0500
Received: from tim.rpsys.net ([194.106.48.114]:12952 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750807AbWBAIuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 03:50:10 -0500
Subject: Re: [PATCH 6/11] LED: Add LED device support for the zaurus corgi
	and spitz models
From: Richard Purdie <rpurdie@rpsys.net>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060201055416.GA23520@kroah.com>
References: <1138714903.6869.132.camel@localhost.localdomain>
	 <20060201055416.GA23520@kroah.com>
Content-Type: text/plain
Date: Wed, 01 Feb 2006 08:50:04 +0000
Message-Id: <1138783805.6455.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-31 at 21:54 -0800, Greg KH wrote:
> On Tue, Jan 31, 2006 at 01:41:43PM +0000, Richard Purdie wrote:
> > Adds LED drivers for LEDs found on the Sharp Zaurus c7x0 (corgi, 
> > shepherd, husky) and cxx00 (akita, spitz, borzoi) models.
> > 
> > Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
> > 
> > Index: linux-2.6.15/arch/arm/mach-pxa/corgi.c
> > ===================================================================
> > --- linux-2.6.15.orig/arch/arm/mach-pxa/corgi.c	2006-01-29 16:02:30.000000000 +0000
> > +++ linux-2.6.15/arch/arm/mach-pxa/corgi.c	2006-01-29 16:11:47.000000000 +0000
> > @@ -165,6 +165,15 @@
> >  
> >  
> >  /*
> > + * Corgi LEDs
> > + */
> > +static struct platform_device corgiled_device = {
> > +	.name		= "corgi-led",
> > +	.id		= -1,
> > +};
> 
> Please use the platform device interface to create these dynamically and
> don't make static structures.

This is very much in keeping with the rest of that file and the way this
has been traditionally been handled in arm board support files.
Admittedly, definitions are usually more complex than this.

Russell, do you have a view on this?

Richard

