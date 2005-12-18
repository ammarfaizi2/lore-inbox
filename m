Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932676AbVLRDNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932676AbVLRDNR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 22:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932677AbVLRDNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 22:13:17 -0500
Received: from lame.durables.org ([64.81.244.120]:9138 "EHLO
	calliope.durables.org") by vger.kernel.org with ESMTP
	id S932676AbVLRDNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 22:13:16 -0500
Subject: Re: [PATCH 07/13]  [RFC] ipath core misc files
From: Robert Walsh <rjwalsh@pathscale.com>
To: Andrew Morton <akpm@osdl.org>
Cc: rolandd@cisco.com, linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20051217191007.a77d23af.akpm@osdl.org>
References: <200512161548.KglSM2YESlGlEQfQ@cisco.com>
	 <200512161548.3fqe3fMerrheBMdX@cisco.com>
	 <20051217123850.aa6cfd53.akpm@osdl.org>
	 <1134855235.20575.22.camel@phosphene.durables.org>
	 <20051217191007.a77d23af.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 17 Dec 2005 19:13:09 -0800
Message-Id: <1134875589.20575.122.camel@phosphene.durables.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-17 at 19:10 -0800, Andrew Morton wrote:
> Robert Walsh <rjwalsh@pathscale.com> wrote:
> >
> > > > +int ipath_mlock(unsigned long start_page, size_t num_pages, struct page **p)
> > > OK.  It's perhaps not a very well named function.
> > 
> > Really?  Suggestion for a better name?
> > 
> 
> ipath_get_user_pages() would cause the least surprise.

Seems reasonable.  I'll look at the related functions, too.

> > > I don't think we want to be setting the user's VMA's vm_flags in this
> > > manner.  This is purely to retain the physical page across fork?
> > 
> > I didn't write this bit of the driver, but I believe this is the case.
> > Is there a better way of doing this?
> 
> This stuff has been churning a bit lately.  I've drawn Hugh Dickins's
> attention to the patch - he'd have a better handle on what the best
> approach would be.

OK then - I'll wait and see.

Regards,
 Robert.

-- 
Robert Walsh                                 Email: rjwalsh@pathscale.com
PathScale, Inc.                              Phone: +1 650 934 8117
2071 Stierlin Court, Suite 200                 Fax: +1 650 428 1969
Mountain View, CA 94043.


