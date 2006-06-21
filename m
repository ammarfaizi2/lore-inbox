Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbWFUU7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbWFUU7G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 16:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWFUU7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 16:59:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25262 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030277AbWFUU7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 16:59:04 -0400
Date: Wed, 21 Jun 2006 13:58:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: vgoyal@in.ibm.com
Cc: greg@kroah.com, gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 64bit resources start end value fix
Message-Id: <20060621135855.ce68720f.akpm@osdl.org>
In-Reply-To: <20060621204120.GA14739@in.ibm.com>
References: <20060621172903.GC9423@in.ibm.com>
	<20060621132227.ec401f93.akpm@osdl.org>
	<20060621204120.GA14739@in.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 16:41:21 -0400
Vivek Goyal <vgoyal@in.ibm.com> wrote:

> > > @@ -32,8 +32,8 @@ EXPORT_SYMBOL(ioport_resource);
> > >  
> > >  struct resource iomem_resource = {
> > >  	.name	= "PCI mem",
> > > -	.start	= 0UL,
> > > -	.end	= ~0UL,
> > > +	.start	= 0,
> > > +	.end	= -1,
> > >  	.flags	= IORESOURCE_MEM,
> > >  };
> > >  
> > 
> > Confused.  This patch won't apply.  It will apply with `patch -R', and if
> > you do that you'll break iomem_reosurce.end by setting it to
> > 0x00000000ffffffff.
> > 
> > I don't think any additional changes are needed here.
> 
> Andrew, you don't have to apply this patch. It is supposed to be picked
> by Greg.
> 
> There seems to be some confusion. Just few days back Greg consolidated
> and re-organized all the 64bit resources patches and posted on LKML for
> review.
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=115015916118671&w=2
> 
> There were few review comments regarding kconfig options.
> I reworked the patch and CONFING_RESOURCES_32BIT was changed to
> CONFIG_RESOURCES_64BIT.
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=115072559700302&w=2
> 
> Now Greg's tree and your tree are not exact replica when it comes to 
> 64bit resource patches. Hence this patch is supposed to be picked by 
> Greg to make sure things are not broken in his tree.

I'm working against Greg's tree, always...

