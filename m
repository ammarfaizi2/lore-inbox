Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTICPY5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 11:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263829AbTICPY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:24:57 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:44752 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263752AbTICPYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:24:31 -0400
Date: Wed, 03 Sep 2003 08:23:44 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>, Anton Blanchard <anton@samba.org>
cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-ID: <27780000.1062602622@[10.10.2.4]>
In-Reply-To: <3F55907B.1030700@cyberone.com.au>
References: <20030903040327.GA10257@work.bitmover.com> <20030903041850.GA2978@krispykreme> <20030903042953.GC10257@work.bitmover.com> <20030903062817.GA19894@krispykreme> <3F55907B.1030700@cyberone.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think LM advocates aiming single image scalability at or before the knee
> of the CPU vs performance curve. Say thats 4 way, it means you should get
> good performance on 8 ways while keeping top performance on 1 and 2 and 4
> ways. (Sorry if I mis-represent your position).

Splitting big machines into a cluster is not a solution. However, oddly 
enough I actually agree with Larry, with one major caveat ... you have to
make it an SSI cluster (single system image) - that way it's transparent
to users. Unfortunately that's hard to do, but since we still have a 
system that's single memory image coherent, it shouldn't actually be nearly 
as hard as doing it across machines, as you can still fudge in the odd 
global piece if you need it. 

Without SSI, it's pretty useless, you're just turning an expensive box
into a cheap cluster, and burning a lot of cash.

> I don't think anyone advocates sacrificing UP performance for 32 ways, but
> as he says it can happen .1% at a time.
> 
> But it looks like 2.6 will scale well to 16 way and higher. I wonder if
> there are many regressions from 2.4 or 2.2 on small systems.

You want real data instead of FUD? How *dare* you? ;-)

Would be real interesting to see this ... there are actually plenty of
real degredations there, none of which (that I've seen) come from any
scalability changes. Things like RMAP on fork times (for which there are
other legitimite reasons) are more responsible (for which the "scalability" 
people have offered a solution).

Numbers would be cool ... particularly if people can refrain from the
"it's worse, therefore it must be some scalability change that's at fault"
insta-moron-leap-of-logic.

M.

