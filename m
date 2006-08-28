Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbWH1Q25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWH1Q25 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 12:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWH1Q25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 12:28:57 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:55450 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751002AbWH1Q24
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 12:28:56 -0400
Date: Mon, 28 Aug 2006 21:59:04 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Paul E McKenney <paulmck@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] RCU: various merge candidates
Message-ID: <20060828162904.GG3325@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060828160845.GB3325@in.ibm.com> <1156781748.3034.212.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156781748.3034.212.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 06:15:48PM +0200, Arjan van de Ven wrote:
> On Mon, 2006-08-28 at 21:38 +0530, Dipankar Sarma wrote:
> > This patchset consists of various merge candidates that would
> > do well to have some testing in -mm. This patchset breaks
> > out RCU implementation from its APIs to allow multiple
> > implementations, 
> 
> 
> can you explain why we would want multiple RCU implementations?
> Isn't one going to be plenty already?

Hi Arjan,

See this for a background - http://lwn.net/Articles/129511/

Primarily, rcupreempt allows read-side critical sections to
be preempted unline classic RCU currently in mainline. It is
also a bit more aggressive in terms of grace periods by counting
the number of readers as opposed to periodic checks in classic
RCU.

The hope is that it will help mainline users who look for
better latency.

Thanks
Dipankar
