Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVANG5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVANG5z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 01:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVANG5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 01:57:55 -0500
Received: from waste.org ([216.27.176.166]:9640 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261195AbVANG5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 01:57:53 -0500
Date: Thu, 13 Jan 2005 22:57:01 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Davis <paul@linuxaudiosystems.com>, nickpiggin@yahoo.com.au,
       lkml@s2y4n2c.de, rlrevell@joe-job.com, arjanv@redhat.com, joq@io.com,
       chrisw@osdl.org, hch@infradead.org, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       kernel@kolivas.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050114065701.GG2940@waste.org>
References: <1105669451.5402.38.camel@npiggin-nld.site> <200501140240.j0E2esKG026962@localhost.localdomain> <20050113191237.25b3962a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113191237.25b3962a.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 07:12:37PM -0800, Andrew Morton wrote:
> Paul Davis <paul@linuxaudiosystems.com> wrote:
> >
> > >SCHED_FIFO and SCHED_RR are definitely privileged operations and you
> > 
> > this is the crux of what this whole debate is about. for all of you
> > people who think about linux on multi-user systems with network
> > connectivity, running servers and so forth, this is clearly a given.
> > 
> > but there is large and growing body of machines that run linux where
> > the sole human user of the machine has a strong and overwhelming
> > desire to have tasks run with the characteristics offered by
> > SCHED_FIFO and/or SCHED_RR. are they still "privileged" operations on
> > this class of linux system? what about linux installed on an embedded
> > system, with a small LCD screen and the sole purpose of running audio
> > apps live? are they still privileged then?
> > 
> 
> Paul.  Everyone agrees with you.  I think.  We just need to work out
> the best way of doing it.
> 
> Would I be right in suspecting that we know what to do, but nobody has
> stepped up to write the code?  It's kinda looking like that?

The closest thing to concensus I've seen yet was a new rlimit for
scheduling with code from Chris Wright. The version I last saw had
some rough edges on the API (exposing the internal scheduler priority
levels) but wasn't too bad in principle. We really ought not get in
the habit of adding new rlimits though.

Perhaps he can post whatever he has again, I'm not sure what the
current state is.

-- 
Mathematics is the supreme nostalgia of our time.
