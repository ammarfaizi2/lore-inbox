Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbVLPBoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbVLPBoZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 20:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbVLPBoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 20:44:24 -0500
Received: from fsmlabs.com ([168.103.115.128]:2227 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1751275AbVLPBoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 20:44:24 -0500
X-ASG-Debug-ID: 1134697458-4757-81-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Thu, 15 Dec 2005 17:49:45 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
X-ASG-Orig-Subj: Re: [2.6 patch] i386: always use 4k stacks
Subject: Re: [2.6 patch] i386: always use 4k stacks
In-Reply-To: <20051215223000.GU23349@stusta.de>
Message-ID: <Pine.LNX.4.64.0512151746270.1678@montezuma.fsmlabs.com>
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org>
 <20051215223000.GU23349@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.6340
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2005, Adrian Bunk wrote:

> On Thu, Dec 15, 2005 at 02:00:13PM -0800, Andrew Morton wrote:
> 
> > Supporting 8k stacks is a small amount of code and nobody has seen a need
> > to make changes in there for quite a long time.  So there's little cost to
> > keeping the existing code.
> > 
> > And the existing code is useful:
> > 
> > a) people can enable it to confirm that their weird crash was due to a
> >    stack overflow.
> > 
> > b) If I was going to put together a maximally-stable kernel for a
> >    complex server machine, I'd select 8k stacks.  We're still just too
> >    squeezy, and we've had too many relatively-recent overflows, and there
> >    are still some really deep callpaths in there.
> 
> a1) People turn off 4k stacks and never report the problem / noone 
>     really debugs and fixes the reported problem.
> 
> Me threatening people with enabling 4k stacks for everyone already 
> resulted in several fixes.

How about this, we apply this patch and perhaps add some debug option to 
enable 8k by changing THREAD_SIZE. This way we have the seperate interrupt 
stacks and 8k stacks for when someone suspects a stack overflow.
