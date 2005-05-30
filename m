Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVE3Ley@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVE3Ley (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 07:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVE3Lex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 07:34:53 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:62132 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261478AbVE3Len
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 07:34:43 -0400
Date: Mon, 30 May 2005 13:34:00 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: kus Kusche Klaus <kus@keba.com>, James Bruce <bruce@andrew.cmu.edu>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
In-Reply-To: <429AEE3A.5080803@yahoo.com.au>
Message-Id: <Pine.OSF.4.05.10505301306510.12471-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2005, Nick Piggin wrote:

> kus Kusche Klaus wrote:
> 
> >>You don't explain how making the Linux kernel hard-RT
> >>will be so much simpler and more supportable!
> > 
> > 
> > I didn't state that a hard-RT linux is simpler, technically 
> > (however, personally, I believe that once RT linux is there, *our*
> > job of writing RT applications, device drivers, ... will be simpler
> > compared to a nanokernel approach).
> > 
> 
> Perhaps very slightly simpler. Let's keep in mind that we're
> not talking about "hello, world" apps here though, so I don't
> think such a general statement is of any use.
>

One important aspect: Time to marked. Linux does have good hardware
support compared to commercial RTOSs and guest kernels! I.e. if you can
use the native Linux driver you very soon has your board up and running.
On the other hand if you first have to write and debug (or buy) drivers
for your RTOS or guest kernel you are already delayed for months.

I do like the idea of guest kernels - especially the ability to enforce a
strict seperation of RT and non-RT. But you can't use _any_ part of the
Linux kernel in your RT application - not even drivers. I know a lot of
stuff in Linux wont ever be useable as it is highly non-deterministic (the
file system forinstance); but some of it might turn up to become
deterministic (enough :-) once people start to work on it with that
ind mind  - the network stack would be a good place to start....

Esben

