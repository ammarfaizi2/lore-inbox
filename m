Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbTJYU4W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 16:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262835AbTJYU4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 16:56:22 -0400
Received: from ns.suse.de ([195.135.220.2]:39335 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262805AbTJYU4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 16:56:21 -0400
Date: Sat, 25 Oct 2003 22:56:17 +0200
From: Andi Kleen <ak@suse.de>
To: John Levon <levon@movementarian.org>
Cc: Andi Kleen <ak@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [AMD64 1/3] fix C99-style declarations
Message-ID: <20031025205617.GD27754@wotan.suse.de>
References: <20031025182824.GA12117@gtf.org> <20031025202750.GC27754@wotan.suse.de> <20031025204717.GA78345@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031025204717.GA78345@compsoc.man.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 25, 2003 at 09:47:17PM +0100, John Levon wrote:
> On Sat, Oct 25, 2003 at 10:27:50PM +0200, Andi Kleen wrote:
> 
> > x86-64 always used C99 and there is no x86-64 compiler 
> > around that doesn't support it. I must say I was somewhat pissed off
> > that someone added that nasty warning to the toplevel Makefile
> > just to comfort some gcc 2.95 users on i386 ("all world is a i386")
> 
> Sorry, that is bullshit. The change was entirely designed to prevent
> people on such architectures hacking general files where there *do*
> exist older compilers, to avoid breakage being introduced without it
> being flagged.

I don't think it makes much difference. People hacking on one architecture
break other architectures all the time for various reasons, e.g.
the implicit includes in different architectures vary widely.

The few people left who use 2.95 will just have to live with
occasional breakage when they insist on using a non standards
compliant compiler.

> 
> This has happened more than once in the tree.
> 
> When all the architectures have a minimum gcc requirement that accepts
> mixed code and declarations by default, it can be removed ...

Would be my prefered solution. Discourage 2.95.

Sooner or later we have to do that anyways when a bug in 2.95 
is found that breaks code (has happened with all gccs so far). 
Sooner would be better, as supporting 2.95 seems to be already
a significant mainteance burden.

-Andi

