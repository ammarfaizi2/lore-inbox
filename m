Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWH1Qnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWH1Qnl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 12:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWH1Qnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 12:43:41 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:36757 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751193AbWH1Qnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 12:43:40 -0400
Date: Mon, 28 Aug 2006 22:13:45 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Paul E McKenney <paulmck@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] RCU: various merge candidates
Message-ID: <20060828164345.GH3325@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060828160845.GB3325@in.ibm.com> <1156781748.3034.212.camel@laptopd505.fenrus.org> <20060828162904.GG3325@in.ibm.com> <1156782789.3034.216.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156782789.3034.216.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 06:33:09PM +0200, Arjan van de Ven wrote:
> On Mon, 2006-08-28 at 21:59 +0530, Dipankar Sarma wrote:
> > On Mon, Aug 28, 2006 at 06:15:48PM +0200, Arjan van de Ven wrote:
> > > On Mon, 2006-08-28 at 21:38 +0530, Dipankar Sarma wrote:
> > Hi Arjan,
> > 
> > See this for a background - http://lwn.net/Articles/129511/
> > 
> > Primarily, rcupreempt allows read-side critical sections to
> > be preempted unline classic RCU currently in mainline. It is
> > also a bit more aggressive in terms of grace periods by counting
> > the number of readers as opposed to periodic checks in classic
> > RCU.
> > 
> 
> hi,
> 
> thanks for the explenation, this for sure explains one half of the
> equation; the other half is ... "why do we not always want this"?

It comes with read-side overheads for keeping track
of critical sections and we need to carefully
check its impact on performance over a more wide variety
of workload before deciding to switch the default.

See table 2 of page 10 in this paper -

http://www.rdrop.com/users/paulmck/RCU/OLSrtRCU.2006.08.11a.pdf

Thanks
Dipankar
