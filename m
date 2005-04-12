Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbVDLBUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVDLBUA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 21:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbVDLBT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 21:19:57 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:25975 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262000AbVDLBT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 21:19:26 -0400
Subject: Re: Processes stuck on D state on Dual Opteron
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Claudio Martins <ctpm@rnl.ist.utl.pt>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>
In-Reply-To: <200504120122.48168.ctpm@rnl.ist.utl.pt>
References: <200504050316.20644.ctpm@rnl.ist.utl.pt>
	 <200504111505.44284.ctpm@rnl.ist.utl.pt> <425B013A.5020108@yahoo.com.au>
	 <200504120122.48168.ctpm@rnl.ist.utl.pt>
Content-Type: text/plain
Date: Tue, 12 Apr 2005 11:19:19 +1000
Message-Id: <1113268760.5090.13.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-12 at 01:22 +0100, Claudio Martins wrote:
> On Monday 11 April 2005 23:59, Nick Piggin wrote:
> >
> > >   OK, I'll try them in a few minutes and report back.
> >
> > I'm not overly hopeful. If they fix the problem, then it's likely
> > that the real bug is hidden.
> >
> 
>   Well, the thing is, they do fix the problem. Or at least they hide it very 
> well ;-)
> 
>   It has been running for more than 5 hours now with stress with no problems 
> and no stuck processes.
> 

Well, that is good... I guess ;)

Actually the patches I have sent you do fix real bugs, but they also
make the block layer less likely to recurse into page reclaim, so it
may be eg. hiding the problem that Neil's patch fixes.

It may be that your fundamental problem is solved by my patches, but
we need to be sure.

>   I think I'm going to give a try to Neil's patch, but I'll have to apply some 
> patches from -mm.
> 

Yep that would be good. Please test -rc2 with Andrew's patch, and
obviously my patches backed out. Thanks for sticking with it.

Nick



