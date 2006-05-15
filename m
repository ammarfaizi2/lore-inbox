Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751641AbWEOT5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbWEOT5D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbWEOT5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:57:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62117 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751642AbWEOT5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:57:00 -0400
Date: Mon, 15 May 2006 12:59:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: mingo@elte.hu, haveblue@us.ibm.com, apw@shadowen.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 NUMA panic compile error
Message-Id: <20060515125906.5c7af5ac.akpm@osdl.org>
In-Reply-To: <200605152147.02232.ak@suse.de>
References: <20060515005637.00b54560.akpm@osdl.org>
	<20060515192614.GA24887@elte.hu>
	<20060515123929.76b9b693.akpm@osdl.org>
	<200605152147.02232.ak@suse.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> 
> [... feels the love ...]

heh.

> On Monday 15 May 2006 21:39, Andrew Morton wrote:
> > Ingo Molnar <mingo@elte.hu> wrote:
> > >
> > > Nevertheless for hard-to-debug bugs i prefer if they can be reproduced 
> > > and debugged on 32-bit too, because x86_64 debugging is still quite a 
> > > PITA and wastes alot of time: for example it has no support for exact 
> > > kernel stacktraces. Also, the printout of the backtrace is butt-ugly and 
> > > as un-ergonomic to the human eye as it gets
> > 
> > Yes, I find x86_64 traces significantly harder to follow.  And I miss the
> > display of the length of the functions (do_md_run+1208 instead of
> > do_md_run+1208/2043).  The latter form makes it easier to work out
> > whereabouts in the function things happened.
> > 
> > That, plus the mix of hex and decimal numbers..
> > 
> > > who came up with that 
> > > "two-maybe-one function entries per-line" nonsense? [Whoever did it he 
> > > never had to look at (and make sense of) hundreds of stacktraces in a 
> > > row.]
> > 
> > Plus they're wide enough to get usefully wordwrapped when someone mails
> > them to you.
> 
> Hmm, I didn't realize they were _that_ unpopular. If you got the i386 
> like space wasting backtraces would you guys all switch your development machines
> to x86-64 ? @)
> 

Developers use serial consoles for such things.  (I discovered
`console=uart,...' yesterday.  It works nicely as an earlyprintk on ia64..)

It's reports-from-the-field which are the problem.

A lot of these problems can be address by simple cranking up the VGA screen
resolution, but I discovered that I don't know how to do that - I've always
used `vga=extended', but that doesn't work on an EFI-booted ia64 box.

Does anyone know what the magic option is to make the vga console use 50
rows?

