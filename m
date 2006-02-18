Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751807AbWBRAgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbWBRAgf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 19:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbWBRAgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:36:35 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:44955
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751807AbWBRAge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:36:34 -0500
Date: Fri, 17 Feb 2006 16:36:25 -0800
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Nathan Lynch <ntl@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: sysfs-related oops during module unload (2.6.16-rc2)
Message-ID: <20060218003625.GB474@kroah.com>
References: <20060211220351.GA3293@localhost.localdomain> <20060212053849.GA27587@kroah.com> <20060216215023.GA30417@kroah.com> <200602162253.45621.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602162253.45621.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2006 at 10:53:45PM -0500, Dmitry Torokhov wrote:
> On Thursday 16 February 2006 16:50, Greg KH wrote:
> > +???????mod->modinfo_attrs = kzalloc((sizeof(struct module_attribute) *
> > +???????????????????????????????????????(ARRAY_SIZE(modinfo_attrs) + 1)),
> > +???????????????????????????????????????GFP_KERNEL);
> > 
> 
> kcalloc() perhaps? Here you explecitely create n elements of a given size...

Heh, sure, the one time I actually are creating n elements :)

I'll go change that.

thanks for pointing it out.

greg k-h
