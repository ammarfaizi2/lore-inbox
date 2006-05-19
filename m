Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbWESXD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWESXD4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 19:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWESXDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 19:03:54 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:44482 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751423AbWESXDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 19:03:54 -0400
Message-ID: <446E4ED6.6020000@de.ibm.com>
Date: Sat, 20 May 2006 01:03:50 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Balbir Singh <balbir@in.ibm.com>
Subject: Re: [Patch 0/6] statistics infrastructure
References: <1148054876.2974.10.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <20060519092411.6b859b51.akpm@osdl.org>
In-Reply-To: <20060519092411.6b859b51.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Martin Peschke <mp3@de.ibm.com> wrote:
>> My patch series is a proposal for a generic implementation of statistics.
> 
> This uses debugfs for the user interface, but the
> per-task-delay-accounting-*.patch series from Balbir creates an extensible
> netlink-based system for passing instrumentation results back to userspace.
> 
> Can this code be converted to use those netlink interfaces, or is Balbir's
> approach unsuitable, or hasn't it even been considered, or what?

Andrew, Balbir,

I will read Balbir's patches. Probably, I won't manage it this weekend,
as a friend of mine is visiting.

Why doesn't come it as a surprise that the user interface appears to
restart the discussion ;-)
I can't comment on netlink yet. There are some thoughts on why I
chose debugfs in my documentation file.

Balbir, could you try to summarise briefly what the main issues are that
your patches solve?

To summarise the issues I want to solve with my paches:

First, we have a requirement to provide statistics for our FCP attachment
(transport latencies, utilisation of likely bottlenecks, etc.),
mostly for customer service reasons. This is what the small exploitation
patches are about.

Second, I thought it useful to get there by implementing and using a generic
statistics infrastructure that could be called by other kernel components.
This is what the bulk of my patches and all of the documentation is about.
Debugfs is just one aspect of it (- it shouldn't be too difficult to rip
it out and use some other transport). But, there are other features like
the various modes for accumulating data, and that the on-the-fly data
processing is configurable by users to a certain degree.

Martin


