Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316594AbSGGWeG>; Sun, 7 Jul 2002 18:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316595AbSGGWeF>; Sun, 7 Jul 2002 18:34:05 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:26797 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316594AbSGGWeE> convert rfc822-to-8bit; Sun, 7 Jul 2002 18:34:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: BKL removal
Date: Mon, 8 Jul 2002 00:38:14 +0200
User-Agent: KMail/1.4.1
Cc: Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L.0207061306440.8346-100000@imladris.surriel.com> <200207072328.34244.oliver@neukum.name> <3D28B97E.3050401@us.ibm.com>
In-Reply-To: <3D28B97E.3050401@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207080038.14490.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  > If you really want to make maximum impact, do tests. Very few
>  > people can measure lock contention on a 4-CPU system.
>
> Do you mean "see lock contention", or "have the hardware to measure
> lock contention"?  We probably use lockmeter more than just about

Both, most use UP exclusively. You know, SMP costs serious money.
Actually very few people can walk over to some colleagues to gain access
to a 16-CPU box.

> anyone else.  But, I do not, nor have I ever contended, that things
> like driverfs's BKL use have a performance impact.  I just consider
> them messy, and bad practice.

Then show some creativity, if you must publish statistics on subsystems
having most inexplicable uses of the BKL. Make it a challenge, not an attack.

>  > And please rest assured that nobody wants to be maintainer of the
>  > subsystem that ruins scalability.
>
> I agree completely.  All of the maintainers who are handed data that
> shows bad BKL contention have either done something about it, or are
> doing something about it now.  2.5 is 2 orders of magnitude better
> than 2.4 for BKL contention in most of the workloads that I see.

Good - which lock is next in your noble quest for scalability?

>  > And if you see a use of the BKL you don't understand ask first, or
>  > send a patch to the subsystem's mailing list, not lkml. People will
>  >  look at BKL usage if you ask. In fact such a look might even
>  > uncover bugs as in case of USB.
>
> I guess I got discouraged by a few non-responsive mailing lists in the
> past.  I'll make an effort to use them more in the future.

Yes, please. "Linus, let's rip out some random locks which offend my sense
of beauty" tends to piss off people. Linus might even agree, but you don't
enjoy His Excellency's priviledges ;-)

	Regards
		Oliver

