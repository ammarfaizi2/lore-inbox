Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbVJaBmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbVJaBmh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 20:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbVJaBmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 20:42:37 -0500
Received: from cantor2.suse.de ([195.135.220.15]:61845 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751161AbVJaBmh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 20:42:37 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: New (now current development process)
Date: Mon, 31 Oct 2005 03:41:02 +0100
User-Agent: KMail/1.8
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, torvalds@osdl.org,
       tony.luck@gmail.com, paolo.ciarrocchi@gmail.com,
       linux-kernel@vger.kernel.org
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com> <20051031001647.GK2846@flint.arm.linux.org.uk> <20051030172247.743d77fa.akpm@osdl.org>
In-Reply-To: <20051030172247.743d77fa.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510310341.02897.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 October 2005 02:22, Andrew Morton wrote:

> There is nothing stopping anyone from working with the originators to get
> these things fixed up at any time.
>
> Why is it necessary for me to chase maintainers to get their bugs fixed?
>
> Why are maintainers working on new features when they have unresolved bugs?

Because zero bugs is just unrealistic and they would never get anything done
if that was the requirement? 

(especially considering that a lot of the bugs at least on x86-64 are 
hardware/firmware bugs of some sort, so often it is not really a linux
bug but just a missing ha^w^wwork^w^w^w^wfix for something else) 

I agree regressions are a problem and need to be addressed, but handling all 
non regressions on a non trivial platforms is just impossible IMHO...

Perhaps it would be nice to have better bug classification: e.g.
regression/new hardware/reported by more than one person etc.  I think
with some prioritization like that it would be much easier to keep the bugs
under control. 

Sometimes bugs are less important than others.
e.g. on x86-64 the bootmem issue was obscure at best, affecting
only a very small part of the user base. Sure the few people hit by it
will be annoyed, but trying to make everyone happy is impossible so
one has to try to just make the majority of users happy. So it was imho
ok to just revert the patch to fix ARM again and not breaking IA64 (I cannot 
assess how many users were on ARM/IA64 affected)  for the next release and 
try to sort it out later.

Regressions are important, everything else has to be prioritized based on the 
impact on the user base (and this doesn't necessarily mean the most noisy 
part of the userbase) 

Perhaps some people could volunteer to set some flags in bugzilla for obvious 
things, like regression or new hardware or missing basic information or for 
really old kernel and no report for a new one and that could be used to 
filter the queries better. Should be an relatively easy task.

-Andi
