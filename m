Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbULJQ0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbULJQ0p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 11:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbULJQ0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 11:26:45 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:2234 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261215AbULJQ0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 11:26:38 -0500
Subject: Re: [RFC PATCH] debugfs - yet another in-kernel file system
From: Josh Boyer <jdub@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20041210153027.GB5827@kroah.com>
References: <20041210005055.GA17822@kroah.com>
	 <1102689974.26320.39.camel@weaponx.rchland.ibm.com>
	 <20041210153027.GB5827@kroah.com>
Content-Type: text/plain
Message-Id: <1102695997.26320.54.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 10 Dec 2004 10:26:37 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-10 at 09:30, Greg KH wrote:
> > 
> > Writing 'Y', 'y', or '1' is allowed, but only 'Y' is ever returned by
> > the read function (similar for the "false" case).  That can be confusing
> > to a program if it writes '1', and then checks to see if the value it
> > wrote took and it gets back 'Y'.  Maybe only allow what you are going to
> > return for bool values in the write case?
> 
> No, this is the exact same way (and pretty much the same code) as the
> module param stuff is in sysfs today.  Just trying to be consistant
> here.

Ok.  Consistency is a good thing.

> 
> > > +#define DEBUG_MAGIC	0x64626720
> > 
> > #define DEBUGFS_MAGIC
> 
> Hm, ok, sure.  That doesn't really matter.

No, not really.  Just a nit.

> 
> > > +static inline struct dentry *debugfs_create_bool(const char *name, mode_t mode, struct dentry *parent, u32 *value)
> > > +{ return EFF_PTR(-ENODEV); }
> > 
> > Could these just return NULL perhaps?  Would be more like procfs then,
> > which is what I'd assume most drivers will be converting from.
> 
> No, see my previous response as to why this would be a bad thing to do.
> We should all learn from the mistakes made in the past and try not to
> repeat them.

Yep, agreed.

josh

