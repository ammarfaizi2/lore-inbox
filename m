Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932708AbVJ2WbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708AbVJ2WbF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 18:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbVJ2WbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 18:31:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40908 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932696AbVJ2WbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 18:31:03 -0400
Date: Sat, 29 Oct 2005 15:30:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git patches] 2.6.x libata updates
In-Reply-To: <20051029152157.01369c35.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0510291526040.3348@g5.osdl.org>
References: <20051029182228.GA14495@havoc.gtf.org> <20051029121454.5d27aecb.akpm@osdl.org>
 <4363CB60.2000201@pobox.com> <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
 <20051029152157.01369c35.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 29 Oct 2005, Andrew Morton wrote:
> 
> However there's usually little overlap between the subsystems trees - with
> a net update, a USB update, a SCSI update and an ia64 update it's usually
> pretty obvious which one caused a particular regression.

Yes, that's true, but the subsystem trees themselves now tend to have more 
time to grow, and tend to be merged more int one go.

Which is all intentional, of course - the whole _point_ of the new thing 
is that they should be in your tree and tested and then merged into my 
tree during a short "merge window" for further testing.

But it means that updates that used to "tricke in" to my kernel now tend 
to be more of a "big merge", making the daily snapshot less effective.

So when we get a "uhhuh, networking failed between daily snapshot X and 
X+1" we now more often have a single biger merge of networking stuff that 
was just waiting for the merge window to open..

> The individual -mm-only patches tend to be more scattered around the tree,
> which is why I send them as batches of 100-200 every couple of days: to get
> a bit of separation in the -git snapshots.  This hasn't actually proven to
> be very useful, though.

One issue is of course that a lot of people doing reports don't actually
even test the daily snapshots.

Some bug reporters do, and I'm very grateful, and they are wonderful 
people. Others do after some prodding, and yet others will never bother to 
try a couple of different kernels at all ;/

So the snapshot separation doesn't always necessarily help, even when it's 
there.

		Linus
