Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266758AbUJFCIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266758AbUJFCIF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 22:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266786AbUJFCIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 22:08:05 -0400
Received: from havoc.gtf.org ([69.28.190.101]:45015 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266758AbUJFCHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 22:07:53 -0400
Date: Tue, 5 Oct 2004 22:07:34 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Robert Love <rml@novell.com>, Roland Dreier <roland@topspin.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive (SCSI-libsata, VIA SATA))
Message-ID: <20041006020734.GA29383@havoc.gtf.org>
References: <4136E4660006E2F7@mail-7.tiscali.it> <41634236.1020602@pobox.com> <52is9or78f.fsf_-_@topspin.com> <4163465F.6070309@pobox.com> <41634A34.20500@yahoo.com.au> <41634CF3.5040807@pobox.com> <1097027575.5062.100.camel@localhost> <20041006015515.GA28536@havoc.gtf.org> <41635248.5090903@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41635248.5090903@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 12:02:48PM +1000, Nick Piggin wrote:
> Jeff Garzik wrote:
> >On Tue, Oct 05, 2004 at 09:52:55PM -0400, Robert Love wrote:
> >
> >>On Tue, 2004-10-05 at 21:40 -0400, Jeff Garzik wrote:
> >>
> >>
> >>>And with preempt you're still hiding stuff that needs fixing.  And when 
> >>>it gets fixed, you don't need preempt.
> >>>
> >>>Therefore, preempt is just a hack that hides stuff that wants fixing 
> >>>anyway.
> 
> What is it hiding exactly?

Bugs and high latency code paths that should instead be fixed.


> >>This actually sounds like the argument for preempt, and against
> >
> >
> >As opposed to fixing drivers???  Please fix the drivers and code first.
> >
> 
> I thought you just said preempt should be turned off because it
> breaks things (ie. as opposed to fixing the things that it breaks).
> 
> But anyway, yeah obviously fixing drivers always == good. I don't
> think anybody advocated otherwise.

By _definition_, when you turn on preempt, you hide the stuff I just
described above.

Hiding that stuff means that users and developers won't see code paths
that need fixing.  If users and developers aren't aware of code paths
that need fixing, they don't get fixed.

Therefore, by advocating preempt, you are advocating a solution _other
than_ actually making the necessary fixes.

	Jeff


