Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbTLQAj1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 19:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbTLQAj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 19:39:27 -0500
Received: from fmr05.intel.com ([134.134.136.6]:43732 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262725AbTLQAjY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 19:39:24 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [CFT][RFC] HT scheduler
Date: Tue, 16 Dec 2003 16:38:28 -0800
Message-ID: <7F740D512C7C1046AB53446D372001736187C8@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [CFT][RFC] HT scheduler
Thread-Index: AcPENHrpQHljw5B7Sm6O/nvHOLWIrAAANjJw
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Davide Libenzi" <davidel@xmailserver.org>,
       "Linus Torvalds" <torvalds@osdl.org>
Cc: "Jamie Lokier" <jamie@shareable.org>,
       "Nick Piggin" <piggin@cyberone.com.au>,
       "bill davidsen" <davidsen@tmr.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Dec 2003 00:38:29.0077 (UTC) FILETIME=[1710F050:01C3C436]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You forgot the one where no HT knowledge can be used for
optimizations.
> 
> - Asserting the CPU's #LOCK pin to take control of the system bus.
That in
>   MP system translate into the signaling CPU taking full control of
the
>   system bus until the pin is deasserted.
>

It is not the case with UP (single socket) using HT, where some
optimization for locks could be available. But you still need locks for
the logical processors.

	Jun

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Davide Libenzi
> Sent: Tuesday, December 16, 2003 4:25 PM
> To: Linus Torvalds
> Cc: Jamie Lokier; Nick Piggin; bill davidsen; Linux Kernel Mailing
List
> Subject: Re: [CFT][RFC] HT scheduler
> 
> On Tue, 16 Dec 2003, Linus Torvalds wrote:
> 
> > I bet it is. In a big way.
> >
> > The lock does two independent things:
> >  - it tells the core that it can't just crack up the load and store.
> >  - it also tells other memory ops that they can't re-order around
it.
> 
> You forgot the one where no HT knowledge can be used for
optimizations.
> 
> - Asserting the CPU's #LOCK pin to take control of the system bus.
That in
>   MP system translate into the signaling CPU taking full control of
the
>   system bus until the pin is deasserted.
> 
> 
> 
> - Davide
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
