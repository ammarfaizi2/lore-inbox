Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbUKFNyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbUKFNyh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 08:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbUKFNyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 08:54:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45978 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261394AbUKFNye
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 08:54:34 -0500
Date: Sat, 6 Nov 2004 08:41:49 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] Remove OOM killer ...
Message-ID: <20041106104149.GA22629@logos.cnet>
References: <20041105200118.GA20321@logos.cnet> <20041106125317.GB9144@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041106125317.GB9144@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andries,

On Sat, Nov 06, 2004 at 01:53:17PM +0100, Andries Brouwer wrote:
> On Fri, Nov 05, 2004 at 06:01:18PM -0200, Marcelo Tosatti wrote:
> 
> > My wife is almost killing me, its Friday night and I've been telling her
> > "just another minute" for hours. Have to run.
> 
> :-)
> 
> > As you know the OOM is very problematic in 2.6 right now - so I went
> > to investigate it.
> 
> I have always been surprised that so few people investigated
> doing things right, that is, entirely without OOM killer.
> Apparently developers do not think about using Linux for serious work
> where it can be a disaster, possibly even a life-threatening disaster,
> when any process can be killed at any time.

Its just that the majority of users use total overcommit (the default), 
but you have a point.

> Ten years ago it was a bad waste of resources to have swapspace
> lying around that would be used essentially 0% of the time.
> But with todays disk sizes it is entirely feasible to have
> a few hundred MB of "unused" swap space. A small price to
> pay for the guarantee that no process will be OOM killed.
> 
> A month ago I showed a patch that made overcommit mode 2
> work for me. Google finds it in http://lwn.net/Articles/104959/
> 
> So far, nobody commented.
> 
> This is not in a state such that I would like to submit it,
> but I think it would be good to focus some energy into
> offering a Linux that is guaranteed free of OOM surprises.

I dont have any useful comments on patch on a quick look at it  - 
but yes non-overcommit should be working correctly.

> So, let me repeat the RFC.
> Apply the above patch, and do "echo 2 > /proc/sys/vm/overcommit_memory".
> Now test. In case you have no, or only a small amount of swap space,
> also do "echo 80 > /proc/sys/vm/overcommit_ratio" or so.

Will test your patch later on the weekend and take a slower look 
at it, hopefully with useful comments.
