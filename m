Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288411AbSAHV24>; Tue, 8 Jan 2002 16:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288333AbSAHV2j>; Tue, 8 Jan 2002 16:28:39 -0500
Received: from maila.telia.com ([194.22.194.231]:6132 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S288402AbSAHV2f>;
	Tue, 8 Jan 2002 16:28:35 -0500
Message-Id: <200201082128.g08LS0Z08702@maila.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Andrew Morton <akpm@zip.com.au>, Christoph Hellwig <hch@caldera.de>
Subject: Re: [PATCH] preempt abstraction
Date: Tue, 8 Jan 2002 22:25:20 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Robert Love <rml@tech9.net>, David Howells <dhowells@redhat.com>,
        torvalds@transmeta.com, arjanv@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <10940.1010511619@warthog.cambridge.redhat.com> <20020108195920.A14642@caldera.de> <3C3B5C02.9929B8@zip.com.au>
In-Reply-To: <3C3B5C02.9929B8@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday den 8 January 2002 21.52, Andrew Morton wrote:
> Christoph Hellwig wrote:
> > On Tue, Jan 08, 2002 at 01:57:28PM -0500, Robert Love wrote:
> > > Why not use the more commonly named conditional_schedule instead of
> > > preempt() ?  In addition to being more in-use (low-latency, lock-break,
> > > and Andrea's aa patch all use it) I think it better conveys its
> > > meaning, which is a schedule() but only conditionally.
> >
> > I think the choice is very subjective, but I prefer preempt().
> > It's nicely short to type (!) and similar in spirit to Ingo's yield()..
>
> naah.  preempt() means preempt.  But the implementation
> is in fact maybe_preempt(), or preempt_if_needed().
>

how about

  preemption_point();


A point of (possible) preemption...
It might be nice to add the orthogonal

  preempt_disable()
  preemtion_enable()

At the same time - see Robert Loves patch for places.
(mostly around CPU specific data)
But they should be null statements for now...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
