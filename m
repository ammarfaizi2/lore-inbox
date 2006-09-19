Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751972AbWISTfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbWISTfQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 15:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbWISTfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 15:35:16 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:3048 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751972AbWISTfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 15:35:14 -0400
Date: Tue, 19 Sep 2006 12:36:05 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20060919193604.GI1310@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <Pine.LNX.4.44L0.0609191332470.4345-100000@iolanthe.rowland.org> <45102E21.2060301@yahoo.com.au> <20060919181919.GG1310@us.ibm.com> <45103B8D.1040006@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45103B8D.1040006@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 04:48:45AM +1000, Nick Piggin wrote:
> Paul E. McKenney wrote:
> >On Wed, Sep 20, 2006 at 03:51:29AM +1000, Nick Piggin wrote:
> 
> >>If store forwarding is able to occur outside cache coherency protocol,
> >>then I don't see why not. I would also be interested to know if this
> >>is the case on real systems.
> >
> >
> >We are discussing multiple writes to the same variable, correct?
> >
> >Just checking...
> 
> Correct.

I am having a hard time seeing how this would happen.

Sooner or later, the cacheline comes to the store queue, defining
the ordering.  All changes that occurred in the store queue while
waiting for the cache line appear to other CPUs as having happened
in very quick succession while the cacheline resides with the store
queue in question.

So, what am I missing?

						Thanx, Paul
