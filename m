Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288548AbSAHWJg>; Tue, 8 Jan 2002 17:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288528AbSAHWJ2>; Tue, 8 Jan 2002 17:09:28 -0500
Received: from dsl-213-023-038-231.arcor-ip.net ([213.23.38.231]:37131 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288554AbSAHWJL>;
	Tue, 8 Jan 2002 17:09:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Roger Larsson <roger.larsson@norran.net>, Andrew Morton <akpm@zip.com.au>,
        Christoph Hellwig <hch@caldera.de>
Subject: Re: [PATCH] preempt abstraction
Date: Tue, 8 Jan 2002 23:12:02 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Robert Love <rml@tech9.net>, David Howells <dhowells@redhat.com>,
        torvalds@transmeta.com, arjanv@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <10940.1010511619@warthog.cambridge.redhat.com> <3C3B5C02.9929B8@zip.com.au> <200201082128.g08LS0Z08702@maila.telia.com>
In-Reply-To: <200201082128.g08LS0Z08702@maila.telia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16O4TT-0000BS-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 8, 2002 10:25 pm, Roger Larsson wrote:
> On Tuesday den 8 January 2002 21.52, Andrew Morton wrote:
> > Christoph Hellwig wrote:
> > > On Tue, Jan 08, 2002 at 01:57:28PM -0500, Robert Love wrote:
> > > > Why not use the more commonly named conditional_schedule instead of
> > > > preempt() ?  In addition to being more in-use (low-latency, lock-break,
> > > > and Andrea's aa patch all use it) I think it better conveys its
> > > > meaning, which is a schedule() but only conditionally.
> > >
> > > I think the choice is very subjective, but I prefer preempt().
> > > It's nicely short to type (!) and similar in spirit to Ingo's yield()..
> >
> > naah.  preempt() means preempt.  But the implementation
> > is in fact maybe_preempt(), or preempt_if_needed().
> >
> 
> how about
> 
>   preemption_point();
> 
> A point of (possible) preemption...

It's not, it's a point of possible rescheduling.  With that in mind I'd
suggest... [drum roll]... [drum roll]...

    schedule_point();

--
Daniel
