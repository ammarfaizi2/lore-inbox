Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVCQWz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVCQWz0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 17:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVCQWz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 17:55:26 -0500
Received: from waste.org ([216.27.176.166]:414 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261332AbVCQWzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 17:55:15 -0500
Date: Thu, 17 Mar 2005 14:55:07 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, sameer.abhinkar@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: KGDB question
Message-ID: <20050317225507.GZ32638@waste.org>
References: <D30E01168D637641AA9D3667F3BB741603F9125F@orsmsx403.amr.corp.intel.com> <20050317135417.6cee8336.akpm@osdl.org> <200503171409.07290.jbarnes@engr.sgi.com> <20050317142958.462822d2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050317142958.462822d2.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2005 at 02:29:58PM -0800, Andrew Morton wrote:
> Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> >
> > > kgdb patches are maintained in -mm kernels.
> > >
> > > Patches are in
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11
> > >-mm1/broken-out/*kgdb*
> > >
> > > And the patch application order is described in
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11
> > >-mm1/patch-series -
> > 
> > What's the latest status on these?  Last I heard, some cleanup was going to 
> > happen to make kgdb suitable for the mainline, did that ever happen?
> 
> It part-happened, then the effort seemed to die.
> 
> >  Also, 
> > it would be nice if I could connect to a remote kernel running the kgdb stubs 
> > w/o having to run gdb on the same ethernet segment.  Would that be difficult 
> > to fix?
> 
> <tries to remember how ethernet works>
> 
> Maybe we'd have to teach kgdboe to arp for the remote debug host.  I think
> Matt was talking about that a while back.
> 
> <tries to remember how ethernet switches work>
> 
> If switches send the destination MAC address through unchanged then maybe
> the problem is that the switch simply doesn't know the MAC address of the
> remote debug host yet?  If the switch has its own MAC address (it doesn't,
> does it), or if it's actually a router then perhaps you should specify the
> router's MAC address and not the remote debug host's.

I haven't tried this, but I believe you need to set up kgdboe's
destination MAC address as the MAC of the next IP hop. Switches should
be invisible to kgdboe.

-- 
Mathematics is the supreme nostalgia of our time.
