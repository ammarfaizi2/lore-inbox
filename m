Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVBJShZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVBJShZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 13:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVBJShY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 13:37:24 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:8930 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261191AbVBJShG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 13:37:06 -0500
Date: Thu, 10 Feb 2005 10:37:03 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: David Brownell <david-b@pacbell.net>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       Al Borchers <alborchers@steinerpoint.com>
Subject: Re: [RFC PATCH] add wait_event_*_lock() functions
Message-ID: <20050210183703.GF2364@us.ibm.com>
References: <20050210173948.GE2364@us.ibm.com> <200502101021.58630.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502101021.58630.david-b@pacbell.net>
X-Operating-System: Linux 2.6.11-rc3 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 10:21:58AM -0800, David Brownell wrote:
> On Thursday 10 February 2005 9:39 am, Nishanth Aravamudan wrote:
> > Hi David, LKML,
> > 
> > It came up on IRC that the wait_cond*() functions from
> > usb/serial/gadget.c could be useful in other parts of the kernel. Does
> > the following patch make sense towards this? 
> 
> I know that Al Borchers -- who wrote those -- did so with that
> specific notion.  And it certainly makes sense to me, in
> principle, that such primitives exist in the kernel ... maybe
> with some tweaks first.  (And docs for all the wait_* calls?)

I would be happy to document all the wait_* callers, especially when
which should be used, their correspondence to the other sleep-functions,
etc.

> But nobody's pressed the issue before, to the relevant audience:
> namely, LKML.  I'd be interested to hear what other folk think.
> Clearly these particular primitives don't understand how to cope
> with nested spinlocks, but those are worth avoiding anyway.

Yes, I was considering that issue, but I figured let's go for the simple
case now and that should be good enough for *most* cases.

Thanks for the feedback!

-Nish
