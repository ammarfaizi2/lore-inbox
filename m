Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261653AbREOW0I>; Tue, 15 May 2001 18:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261654AbREOW0A>; Tue, 15 May 2001 18:26:00 -0400
Received: from mta1.snfc21.pbi.net ([206.13.28.122]:19634 "EHLO
	mta1.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S261653AbREOWZu>; Tue, 15 May 2001 18:25:50 -0400
Date: Tue, 15 May 2001 15:21:28 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: LANANA: To Pending Device Number Registrants
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <045a01c0dd8d$6377d9a0$6800000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And my opinion is that the "hot-plugged" approach works for devices even 
> if they are soldered down ...

Yep.  Though I tend to look at the whole problem as "autoconfiguration"
lately.  Solving device naming (even the major/minor subproblem) is only
one part of having a complete autoconfiguration infrastructure.


> Now, if we just fundamentally try to think about any device as being 
> hot-pluggable, you realize that things like "which PCI slot is this device 
> in" are completely _worthless_ as device identification, because they 
> fundamentally take the wrong approach, and they don't fit the generic 
> approach at all. 

Well, "completely" goes too far IMO.  Unless by "identifier" you imply
something of which there's only one?  In my book, devices can have many
kinds of identifiers.

The reason is that such "physical" identifiers (or "device topology" IDs)
may be all that's available to distinguish some devices.  For example,
network adapters (no major/minor numbers :) and parallel/printer/serial
ports may have no better "stable" (over reboots) identifier available.

Without "stable" names, it's too easy to have bad things happen, like
your "confidential materials" printer output get redirected into the
lobby printer, or trust your network DMZ as if it were the internal
network.  Given hotplugging, I think the best solution to such issues
does involve exposing topological IDs such as PCI slot names.
(What IDs the different applications use is a different issue.)

- Dave


