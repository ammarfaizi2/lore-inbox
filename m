Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWIZUo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWIZUo5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 16:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWIZUo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 16:44:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39399 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932303AbWIZUor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 16:44:47 -0400
Date: Tue, 26 Sep 2006 13:44:42 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: x86/x86-64 merge for 2.6.19
In-Reply-To: <200609262226.09418.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0609261339050.3952@g5.osdl.org>
References: <200609261244.43863.ak@suse.de> <200609262202.28846.ak@suse.de>
 <Pine.LNX.4.64.0609261318240.3952@g5.osdl.org> <200609262226.09418.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Sep 2006, Andi Kleen wrote:
> 
> Yes that is why I did it. I still use quilt for my tree because it works
> best for me, but together with all the i386 stuff I was over 230 patches
> and email clearly didn't scale well to that much.

Right. I'm actually surprised not more peole use git that way. It was 
literally one of the _design_goals_ of git to have people use quilt a a 
more "willy-nilly" front-end process, with git giving the true distributed 
nature that you can't get from that kind of softer patch-queue like 
system.

We discussed some quilt integration stuff, but nobody actually ended up 
ever using both (except indirectly, as with the whole Andrew->Linus 
stage). StGit kind of comes closest.

So I don't think your usage should be considered to be even strange. I 
think it makes sense. I just think that everybody agrees that if we can do 
it in chunks of a few tens of patches most of the time instead of chunks 
of 225, everybody will have an easier time, if only because the latency 
goes down, and it's just easier to react.

That said, the merges with Andrew are also sometimes in the 150+ patch 
range, and merging with other git trees can sometimes bring in even more. 
So I'm not claiming any hard limits or anything like that, just that in 
general it's nicer to get updates trickle in over time rather than all at 
once.

I suspect this was mostly a one-time startup-event.

			Linus
