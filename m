Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbVKOTNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbVKOTNS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 14:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbVKOTNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 14:13:18 -0500
Received: from spirit.analogic.com ([204.178.40.4]:18949 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S965006AbVKOTNR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 14:13:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20051115102425.0iln2874xjoc4g84@coolrunningconcepts.com>
References: <20051115102425.0iln2874xjoc4g84@coolrunningconcepts.com>
X-OriginalArrivalTime: 15 Nov 2005 19:13:16.0370 (UTC) FILETIME=[A1BF2320:01C5EA18]
Content-class: urn:content-classes:message
Subject: Re: Timer idea
Date: Tue, 15 Nov 2005 14:13:16 -0500
Message-ID: <Pine.LNX.4.61.0511151401400.6145@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Timer idea
Thread-Index: AcXqGKHI6hyy5WM8ScOSQf82hwxYGg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: <evan@coolrunningconcepts.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Nov 2005 evan@coolrunningconcepts.com wrote:

> I was thinking about benchmarking, profiling, and various other applications
> that might need frequent access to the current time.  Polling timers or
> frequent timer signal delivery both seem like there would be a lot of
> overhead.
> I was thinking it would be nice if you could just read the time information
> without making an OS call.
>
> I figure the kernel keeps accurate records of current time information and the
> values of various timers.  I then had the idea that one could have a /dev or
> maybe a /proc entry that would allow you to mmap() the kernel records (read
> only) and then you could read this information right from the kernel without
> any overhead.

Great invention, read some timer without any overhead! I guess if
you can figure it out you are up for a Nobel Prize, certainly a new
breakthrough.

FYI, even if you put some kernel spinning count in shared-memory,
it would have overhead. In fact, users might even be able DOS the
machine by spinning on that count. Putting time in /proc or /dev
also has great overhead. Have you ever looked at how these
file-systems work?

On ix86 machines, basic time comes from chip(s), read from ports.
That's just another tiny little problem.

The time-keeping in Linux certainly has a few problems and they
don't seem to be getting resolved, just exchanging one set of
problems for another as the timer code has been rewritten many
times. It would helpful if somebody did take a fresh new look
at timekeeping, but reading something from shared memory just
isn't relevant.

>
> Comments?  Please CC me on replies.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.51 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
