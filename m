Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932679AbVLRDKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679AbVLRDKQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 22:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932677AbVLRDKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 22:10:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42118 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932679AbVLRDKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 22:10:13 -0500
Date: Sat, 17 Dec 2005 19:10:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Robert Walsh <rjwalsh@pathscale.com>
Cc: rolandd@cisco.com, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 07/13]  [RFC] ipath core misc files
Message-Id: <20051217191007.a77d23af.akpm@osdl.org>
In-Reply-To: <1134855235.20575.22.camel@phosphene.durables.org>
References: <200512161548.KglSM2YESlGlEQfQ@cisco.com>
	<200512161548.3fqe3fMerrheBMdX@cisco.com>
	<20051217123850.aa6cfd53.akpm@osdl.org>
	<1134855235.20575.22.camel@phosphene.durables.org>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Walsh <rjwalsh@pathscale.com> wrote:
>
> > > +int ipath_mlock(unsigned long start_page, size_t num_pages, struct page **p)
> > OK.  It's perhaps not a very well named function.
> 
> Really?  Suggestion for a better name?
> 

ipath_get_user_pages() would cause the least surprise.

> > > +	}
> > > +	vm->vm_flags |= VM_SHM | VM_LOCKED;
> > > +
> > > +	return 0;
> > > +}
> > 
> > I don't think we want to be setting the user's VMA's vm_flags in this
> > manner.  This is purely to retain the physical page across fork?
> 
> I didn't write this bit of the driver, but I believe this is the case.
> Is there a better way of doing this?

This stuff has been churning a bit lately.  I've drawn Hugh Dickins's
attention to the patch - he'd have a better handle on what the best
approach would be.

