Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWBAOcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWBAOcd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 09:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWBAOcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 09:32:33 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:4505 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932130AbWBAOcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 09:32:33 -0500
Subject: Re: [PATCH] Avoid moving tasks when a schedule can be made.
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060201142249.GB6277@elte.hu>
References: <1138736609.7088.35.camel@localhost.localdomain>
	 <43E02CC2.3080805@bigpond.net.au>
	 <1138797874.7088.44.camel@localhost.localdomain>
	 <43E0B24E.8080508@yahoo.com.au> <43E0B342.6090700@yahoo.com.au>
	 <20060201132054.GA31156@elte.hu> <43E0BBEC.3020209@yahoo.com.au>
	 <20060201140041.GA5298@elte.hu> <43E0C127.8060401@yahoo.com.au>
	 <20060201142249.GB6277@elte.hu>
Content-Type: text/plain
Date: Wed, 01 Feb 2006 09:32:17 -0500
Message-Id: <1138804337.7088.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-01 at 15:22 +0100, Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> > >rwsems/rwlocks are not an issue in -rt because they have different 
> > >semantics there - and thus readers cannot amass. I do think rwsems and 
> > >rwlocks have pretty nasty characteristics [non-latency ones] for the 
> > >mainline kernel's use too, but that's not being argued here ;)
> > 
> > But all I'm saying is that while there are equivalent magnitudes of 
> > interrupts off regions in mainline, there is little point introducing 
> > a hack like this to "solve" one of them.
> 
> nobody is arguing to have this hack included. Hacks are to be introduced 
> into the scheduler only over my cold dead body ;-) Steve only sent this 
> as an RFC thing, to raise the issue.

I'll confirm this. Even in my submission, I stated that this was
probably wrong, and wanted comments (thank you btw for commenting :).  I
just wanted to show where the problem was, and that the problem went
away with the "hack".

-- Steve


