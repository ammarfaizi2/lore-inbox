Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264600AbTL3GgR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 01:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264605AbTL3GgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 01:36:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:51845 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264600AbTL3GgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 01:36:12 -0500
Date: Mon, 29 Dec 2003 22:36:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthias Andree <matthias.andree@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0 - Watchdog patches
In-Reply-To: <20031230004907.GA29143@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.58.0312292226240.4176@home.osdl.org>
References: <20030906125136.A9266@infomag.infomag.iguana.be>
 <20031229205246.A32604@infomag.infomag.iguana.be> <Pine.LNX.4.58.0312291209150.2113@home.osdl.org>
 <20031229212221.J30061@infomag.infomag.iguana.be> <Pine.LNX.4.58.0312291226400.2113@home.osdl.org>
 <20031230004907.GA29143@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Dec 2003, Matthias Andree wrote:
> 
> Not being very used to BK, does that mean I have several trees around:

The answer to that question is always a resounding "yes".

BK really thrives on having several trees around. You don't _have_ to have 
them, but basically the default rule should be: use separate trees for 
everything you can think of that isn't directly dependent on stuff in 
another tree.

That does _not_ mean that you should necessarily create "temporary trees". 
I actually do that a lot of the time, because I tend to create a totally 
new clone when I start applying long series of patches or do anything even 
half-way strange: it's just a lot easier to throw failures away, than it 
is to try to sort it out later.

But most people probably do _not_ want to have that kind of "temporary
tree" mentality in general. People should realize that it's ok, and in
particular that if you're doing something experimental it's fine to just
create a new tree and later on decide that it was crap and just do a full
"rm -rf" on it, and realize that the only thing you lost was some time.

> 1. the official release tree
> 2. an "old tree" with my local change that I'm forwarding
> 3. a temporary test tree to see if the merge would succeed, which
>    I'll get by cloning (1) and then pulling from (2)?

The tree doesn't really need to be temporary per se. It can be your "work 
tree" - the tree where you merge all the different sources of BK input. I 
realize that a lot of people only really have two sources of input (the 
standard tree and their own development tree), but if you get that concept 
early, you'll find it trivial to merge in other peoples trees into your 
"work tree", and keep track of many different development trees at the 
same time and just let BK do the merging for you.

> Or am I missing some obvious short cut?

Basically, the obvious shortcut is to keep your work-tree around, so you 
don't have to clone and re-pull it all the time.

After a while, your work-tree is really messy (especially if you pull from 
multiple different development trees), but the point should be that no 
actual development gets done there, so you don't care: you can always just 
flush it entirely, and re-create it anew.

But you don't have to flush and re-create it _all_ the time. That would 
just be wasteful. Although if you have the hardware, it isn't that 
painful..

		Linus
