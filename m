Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270930AbTHFTBs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 15:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270967AbTHFTBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 15:01:48 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:4872
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270930AbTHFTBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 15:01:46 -0400
Date: Wed, 6 Aug 2003 12:01:42 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Timothy Miller <miller@techsource.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: Interactivity improvements
Message-ID: <20030806190142.GE21290@matchmail.com>
Mail-Followup-To: Timothy Miller <miller@techsource.com>,
	Nick Piggin <piggin@cyberone.com.au>,
	Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <200308050207.18096.kernel@kolivas.org> <200308051220.04779.kernel@kolivas.org> <3F2F149F.1020201@cyberone.com.au> <200308051306.38180.kernel@kolivas.org> <3F2F21DF.1050601@cyberone.com.au> <3F314D6B.9090302@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F314D6B.9090302@techsource.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 02:48:11PM -0400, Timothy Miller wrote:
> The idea I'm proposing, however poorly formed, is that if we allow some 
> "excessive" oscillation early on in the life of a process, we may be 
> able to more quickly get processes to NEAR its correct priority, OR get 
> its CPU time over the course of three times being run for the 
> underdamped case to be about the same as it would be if we knew in 
> advance what the priority should be.  But in the underdamped case, the 
> priority would continue to oscillate up and down around the correct 
> level, because we are intentionally overshooting the mark each time we 
> adjust priority.
> 
> This may not be related, but something that pops into my mind is a 
> numerical method called Newton's Method.  It's a way to solve for roots 
> of an equation, and it involved derivatives, and I don't quite remember 
> how it works.  But in any event, the results are less accurate than, 
> say, bisection, but you get to the answer MUCH more quickly.

Sounds interesting.

Much like a decaying average, or average over the entire lifetime of the
process which can be weighed into the short term interactivity calculations
also.

I think Con is working on something like this already, except that it's
taking the short term into account more than the long term.
