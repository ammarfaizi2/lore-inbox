Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWEIXKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWEIXKu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 19:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWEIXKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 19:10:50 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:9091 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932066AbWEIXKu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 19:10:50 -0400
Date: Tue, 9 May 2006 16:13:47 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 25/35] Add Xen time abstractions
Message-ID: <20060509231347.GD24291@moss.sous-sol.org>
References: <20060509084945.373541000@sous-sol.org> <20060509085157.908244000@sous-sol.org> <200605092350.03886.ak@suse.de> <200605100103.54875.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605100103.54875.ioe-lkml@rameria.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Oeser (ioe-lkml@rameria.de) wrote:
> On Tuesday, 9. May 2006 23:50, Andi Kleen wrote:
> > On Tuesday 09 May 2006 09:00, Chris Wright wrote:
> > > Add support for Xen time abstractions. To avoid expensive traps into
> > > the hypervisor, the passage of time is extrapolated from the local TSC
> > > and a set of timestamps and scaling factors exported to the guest via
> > > shared memory. Xen also provides a periodic interrupt facility which
> > > is used to drive updates of xtime and jiffies, and perform the usual
> > > process accounting and profiling.
> > 
> > There is far too much code duplication in there. I think you need to
> > refactor the main time.c a bit first and strip that down.
> > 
> > Also you can drop all the __x86_64__ support for now.
> 
> Isn't time and timer handling a moving target anyway?
> The refactoring will be done by the timer people in a completly different
> manner anyway.
> 
> Are you sure, you want to disturb these efforts by requiring another
> refactoring here?

Yes.  Otherwise we end up with either duplicated code if the moving
target winds up not moving, or outdated code if it does.  I agree with
Andi.  It's on the todo list to refactor, but I wanted to get the
patches out even though it's a work in progress.

thanks,
-chris
