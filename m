Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbUD1Tio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUD1Tio (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 15:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUD1Ti3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:38:29 -0400
Received: from mail.kroah.org ([65.200.24.183]:58593 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265020AbUD1RpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 13:45:22 -0400
Date: Wed, 28 Apr 2004 10:44:58 -0700
From: Greg KH <greg@kroah.com>
To: Michael_E_Brown@Dell.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] add SMBIOS tables to sysfs
Message-ID: <20040428174458.GH32040@kroah.com>
References: <0960978B185D2848BF5BBAE1BFB343E104F581@ausx2kmps315.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0960978B185D2848BF5BBAE1BFB343E104F581@ausx2kmps315.aus.amer.dell.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 12:37:19PM -0500, Michael_E_Brown@Dell.com wrote:
> Looks good. You can go ahead and add it to your tree. 

Ok, will do, thanks for testing.

> I do have one question, though. Here:
> 
> > +static struct kobj_type ktype_smbios = {
> > +	.sysfs_ops	= &smbios_attr_ops,
> > +	.default_attrs	= def_attrs,
> > +	/* statically allocated, no release method necessary */
> > +};
> 
> I have no .release method because I have not kmalloc'ed any 
> instances of this struct. Do I need to re-add a release
> method here?

No, you are ok here.  Static kobj_type structures are ok for 2.6.  For
2.7 we will probably fix up all of this properly, we've learned a lot in
the past few years :)

thanks,

greg k-h
