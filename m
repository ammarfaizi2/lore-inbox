Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbVLTSGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbVLTSGl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 13:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbVLTSGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 13:06:41 -0500
Received: from relay03.pair.com ([209.68.5.17]:50705 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1750807AbVLTSGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 13:06:40 -0500
X-pair-Authenticated: 67.163.102.102
Date: Tue, 20 Dec 2005 12:06:58 -0600 (CST)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: "linux-os \\(Dick Johnson\\)" <linux-os@analogic.com>
cc: Sean <seanlkml@sympatico.ca>, Mike Snitzer <snitzer@gmail.com>,
       Adrian Bunk <bunk@stusta.de>, Mark Lord <lkml@rtr.ca>,
       "J.A. Magallon" <jamagallon@able.es>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>, nel@vger.kernel.org,
       mpm@selenic.com
Subject: Re: About 4k kernel stack size....
In-Reply-To: <Pine.LNX.4.61.0512201202090.27692@chaos.analogic.com>
Message-ID: <Pine.LNX.4.64.0512201157140.7859@turbotaz.ourhouse>
References: <20051218231401.6ded8de2@werewolf.auna.net>     <43A77205.2040306@rtr.ca>
 <20051220133729.GC6789@stusta.de>    <170fa0d20512200637l169654c9vbe38c9931c23dfb1@mail.gmail.com>
 <46578.10.10.10.28.1135094132.squirrel@linux1> <Pine.LNX.4.61.0512201202090.27692@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2005, linux-os \(Dick Johnson\) wrote:
> See, isn't rule-making fun? This whole 4k stack-
> thing is really dumb. Other operating systems
> use paged virtual memory for stacks, except
> for the interrupt stack. If Linux used paged
> virtual memory for stacks, the pages would not
> have to be contiguous so dynamic stack allocation
> would practically never fail. But Linux doesn't
> use paged virtual memory for stacks. So, there
> needs to be some rule to control the amount
> of kernel stack allocated to each task when it
> executes a system call.

Pardon, but why should "Other operating systems use paged virtual memory 
for stacks" have anything to do with the design of Linux? Other operating 
systems also look for a file called AUTORUN.INF whenever you insert a CD, 
and they'll happily run arbitrary code... which is great when you're a 
motherboard manufacturer providing crappy drivers on a crappy CD with 
crappy artwork and you want to play a jingle before slapping a hideous GUI 
up in front of your unsuspecting user; or perhaps you're Sony and you want 
to hook people's kernel such that you become a sort of media hypervisor. 
And this is the most deployed OS in the game...

Linux is a kernel - not a perl script. Programmer laziness is about the 
only excuse I've been able to spot in this discussion that has been raised 
in support of big stacks. (Perhaps all the arguments against aren't worded 
as such; but as far as I've seen they all reduce to it).

If Linux used 4k stacks, we wouldn't have to worry about virtual 
memory *or* contiguous allocations.

- Chase
