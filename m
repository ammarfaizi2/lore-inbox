Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288333AbSAHV25>; Tue, 8 Jan 2002 16:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288404AbSAHV2h>; Tue, 8 Jan 2002 16:28:37 -0500
Received: from zero.tech9.net ([209.61.188.187]:43528 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288333AbSAHV2b>;
	Tue, 8 Jan 2002 16:28:31 -0500
Subject: Re: [PATCH] preempt abstraction
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: Christoph Hellwig <hch@caldera.de>, David Howells <dhowells@redhat.com>,
        torvalds@transmeta.com, arjanv@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <3C3B5C02.9929B8@zip.com.au>
In-Reply-To: <10940.1010511619@warthog.cambridge.redhat.com>
	<1010516250.3229.21.camel@phantasy>, <1010516250.3229.21.camel@phantasy>;
	from rml@tech9.net on Tue, Jan 08, 2002 at 01:57:28PM -0500
	<20020108195920.A14642@caldera.de>  <3C3B5C02.9929B8@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 08 Jan 2002 16:30:31 -0500
Message-Id: <1010525436.3383.118.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-08 at 15:52, Andrew Morton wrote:

> naah.  preempt() means preempt.  But the implementation
> is in fact maybe_preempt(), or preempt_if_needed().

Agreed.  preempt has me envision various things, none of which are what
we want.  What is the difference between schedule vs preempt? 
Confusing.

What we are calling preempt here is the same as schedule, but we check
if it is needed.  So I suggest conditional_schedule, which has the
benefit of being widely used in at least three patches. 
schedule_if_needed, sched_if_needed, etc. both fit.  Why introduce the
namespace preempt when we already have sched?

sched_conditional() and sched_needed() ?

	Robert Love

