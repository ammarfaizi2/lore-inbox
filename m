Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030446AbWALPSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030446AbWALPSD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 10:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030447AbWALPSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 10:18:03 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:18375 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030446AbWALPSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 10:18:00 -0500
Date: Thu, 12 Jan 2006 07:17:41 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Keith Owens <kaos@sgi.com>
Cc: John Hesterberg <jh@sgi.com>, Matt Helsley <matthltc@us.ibm.com>,
       Jes Sorensen <jes@trained-monkey.org>,
       Shailabh Nagar <nagar@watson.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Jay Lan <jlan@engr.sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       elsa-devel@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       Erik Jacobson <erikj@sgi.com>, Jack Steiner <steiner@sgi.com>
Subject: Re: [Lse-tech] Re: [ckrm-tech] Re: [PATCH 00/01] Move Exit Connectors
Message-ID: <20060112151741.GA25299@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060112065115.GB23673@us.ibm.com> <19140.1137052234@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19140.1137052234@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 06:50:34PM +1100, Keith Owens wrote:
> "Paul E. McKenney" (on Wed, 11 Jan 2006 22:51:15 -0800) wrote:
> >On Thu, Jan 12, 2006 at 05:19:01PM +1100, Keith Owens wrote:
> >> OK, I have thought about it and ...
> >> 
> >>   notifier_call_chain_lockfree() must be called with preempt disabled.
> >> 
> >Fair enough!  A comment, perhaps?  In a former life I would have also
> >demanded debug code to verify that preemption/interrupts/whatever were
> >actually disabled, given the very subtle nature of any resulting bugs...
> 
> Comment - OK.  Debug code is not required, the reference to
> smp_processor_id() already does all the debug checks that
> notifier_call_chain_lockfree() needs.  CONFIG_PREEMPT_DEBUG is your
> friend.

Ah, debug_smp_processor_id().  Very cool!!!

							Thanx, Paul
