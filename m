Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265037AbTFRBj5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 21:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265038AbTFRBj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 21:39:57 -0400
Received: from [65.39.167.210] ([65.39.167.210]:17794 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S265037AbTFRBj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 21:39:56 -0400
Date: Tue, 17 Jun 2003 21:50:54 -0400 (EDT)
From: Gerhard Mack <gmack@innerfire.net>
To: James Simmons <jsimmons@infradead.org>
cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.71 - random console corruption
In-Reply-To: <Pine.LNX.4.44.0306172149490.21214-100000@phoenix.infradead.org>
Message-ID: <Pine.LNX.4.44.0306172149150.8889-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jun 2003, James Simmons wrote:

> > > For userland<->kernel transactions we have the console_semaphore to
> > > protect us. It is also used for console_callback. The console_semaphore is
> > > not used internally to protect global variables :-( To do this properly
> > > would take quite a bit of work.
> >
> > It looks like all these globals need a lock -- they can race on SMP or
> > with kernel preemption.
> >
> > Is it really going to be that hard to wrap a lock around their access,
> > because I think this is going to bite SMP users.
>
> For things like fg_console and currcon it will be. Those variables are
> used everyway like mad. That is a whole lot of locks. I doubt this issue
> will be solved until 2.7.X.

Interestingly enough it's not console switching that does it.. it's
scrolling also as I mentioned before it's not just with preempt enabled.

I wonder if theres another problem somewhere?

	Gerhard

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

