Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932684AbVJ2WWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbVJ2WWg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 18:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932644AbVJ2WWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 18:22:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51402 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932502AbVJ2WWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 18:22:35 -0400
Date: Sat, 29 Oct 2005 15:21:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git patches] 2.6.x libata updates
Message-Id: <20051029152157.01369c35.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
References: <20051029182228.GA14495@havoc.gtf.org>
	<20051029121454.5d27aecb.akpm@osdl.org>
	<4363CB60.2000201@pobox.com>
	<Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Sat, 29 Oct 2005, Jeff Garzik wrote:
> > 
> > Even so, it's easy, to I'll ask him to test 2.6.14, 2.6.14-git1, and
> > (tonight's upcoming) 2.6.14-git2 (with my latest pull included) to see if
> > anything breaks.
> 
> Side note: one of the downsides of the new "merge lots of stuff early in 
> the development series" approach is that the first few daily snapshots end 
> up being _huge_. 
> 
> So the -git1 and -git2 patches are/will be very big indeed.
> 
> For example, patch-2.6.14-git1 literally ended up being a megabyte 
> compressed. Right now my diff to 2.6.14 (after just two days) is 1.6MB 
> compressed.
> 

However there's usually little overlap between the subsystems trees - with
a net update, a USB update, a SCSI update and an ia64 update it's usually
pretty obvious which one caused a particular regression.

And given that the size of each individual subsystem update is unaltered,
it doesn't really matter whether or not they all came on the same day.

The individual -mm-only patches tend to be more scattered around the tree,
which is why I send them as batches of 100-200 every couple of days: to get
a bit of separation in the -git snapshots.  This hasn't actually proven to
be very useful, though.
