Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWCGTqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWCGTqz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 14:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWCGTqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 14:46:55 -0500
Received: from hera.kernel.org ([140.211.167.34]:56501 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932204AbWCGTqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 14:46:54 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] Document Linux's memory barriers
Date: Tue, 7 Mar 2006 11:46:30 -0800
Organization: OSDL
Message-ID: <20060307114630.3c97f9ad@localhost.localdomain>
References: <200603071213.47885.ak@suse.de>
	<200603071134.52962.ak@suse.de>
	<31492.1141753245@warthog.cambridge.redhat.com>
	<7621.1141756240@warthog.cambridge.redhat.com>
	<8620.1141759443@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1141760789 6471 10.8.0.54 (7 Mar 2006 19:46:29 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 7 Mar 2006 19:46:29 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Mar 2006 19:24:03 +0000
David Howells <dhowells@redhat.com> wrote:

> Andi Kleen <ak@suse.de> wrote:
> 
> > > > You're not supposed to do it this way anyways. The official way to access
> > > > MMIO space is using read/write[bwlq]
> > > 
> > > True, I suppose. I should make it clear that these accessor functions imply
> > > memory barriers, if indeed they do, 
> > 
> > I don't think they do.
> 
> Hmmm.. Seems Stephen Hemminger disagrees:
> 
> | > > 1) Access to i/o mapped memory does not need memory barriers.
> | > 
> | > There's no guarantee of that. On FRV you have to insert barriers as
> | > appropriate when you're accessing I/O mapped memory if ordering is required
> | > (accessing an ethernet card vs accessing a frame buffer), but support for
> | > inserting the appropriate barriers is built into gcc - which knows the rules
> | > for when to insert them.
> | > 
> | > Or are you referring to the fact that this should be implicit in inX(),
> | > outX(), readX(), writeX() and similar?
> | 

The problem with all this is like physics it is all relative to the observer.
I get confused an lost when talking about the general case because there are so many possible
specific examples where a barrier is or is not needed.
