Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932771AbVLJHzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932771AbVLJHzZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 02:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932772AbVLJHzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 02:55:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:50399 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932771AbVLJHzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 02:55:24 -0500
Date: Fri, 9 Dec 2005 23:50:16 -0800
From: Greg KH <greg@kroah.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Adrian Bunk <bunk@stusta.de>, akpm@osdl.org, cotte@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 3/17] s390: move s390_root_dev_* out of the cio layer.
Message-ID: <20051210075016.GA21423@kroah.com>
References: <20051209152345.GD6532@skybase.boeblingen.de.ibm.com> <20051209165150.GD23349@stusta.de> <1134147283.5576.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134147283.5576.1.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 05:54:43PM +0100, Martin Schwidefsky wrote:
> On Fri, 2005-12-09 at 17:51 +0100, Adrian Bunk wrote:
> > On Fri, Dec 09, 2005 at 04:23:45PM +0100, Martin Schwidefsky wrote:
> > > +extern struct device *s390_root_dev_register(const char *);
> > > +extern void s390_root_dev_unregister(struct device *);
> > >...
> > 
> > If you do _really_ need these wrappers, simply make them
> > "static inline"'s in the header file.
> 
> We can't. The point here is that we need an external release function
> that is still available after the module has been unloaded that uses
> these wrappers.

release is find and understandable.  But the unregister one is just
pretty foolish :)

thanks,

greg k-h
