Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318319AbSGYFQC>; Thu, 25 Jul 2002 01:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318323AbSGYFQC>; Thu, 25 Jul 2002 01:16:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25874 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318319AbSGYFQC>; Thu, 25 Jul 2002 01:16:02 -0400
Date: Wed, 24 Jul 2002 22:19:33 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: george anzinger <george@mvista.com>
cc: Robert Love <rml@tech9.net>, Andrew Morton <akpm@zip.com.au>,
       <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: [PATCH] updated low-latency zap_page_range
In-Reply-To: <3D3F56C6.B045E8A@mvista.com>
Message-ID: <Pine.LNX.4.44.0207242216150.1231-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 24 Jul 2002, george anzinger wrote:
> >
> > That may be a bug in preempt_count(), of course.
> >
> Didn't we just put bh_count and irq_count in the same
> word???

Yes. But that doesn't mean that the "preempt_count()" macro necessarily
needs to reflect that.

In particular, we have separate macros for getting the irq bits from that
shared word ("irq_count()" etc). Right now they happen to use the
"preempt_count()" macro, but that's not really fundamental.

No big deal either way, I suspect.

		Linus

