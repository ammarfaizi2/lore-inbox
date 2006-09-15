Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWIOXA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWIOXA0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 19:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWIOXAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 19:00:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44519 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932350AbWIOXAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 19:00:24 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: "Jose R. Santos" <jrs@us.ibm.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, karim@opersys.com, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <450AB957.2050206@opersys.com>
	<20060915142836.GA9288@localhost.usen.ad.jp>
	<450ABE08.2060107@opersys.com>
	<1158332447.5724.423.camel@localhost.localdomain>
	<20060915111644.c857b2cf.akpm@osdl.org>
	<20060915181907.GB17581@elte.hu>
	<Pine.LNX.4.64.0609152111030.6761@scrub.home>
	<20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal>
	<450B164B.7090404@us.ibm.com> <20060915220345.GC12789@elte.hu>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 15 Sep 2006 18:59:19 -0400
In-Reply-To: <20060915220345.GC12789@elte.hu>
Message-ID: <y0m3basg2ig.fsf@ton.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar <mingo@elte.hu> writes:

> [...]  NOTE: i still accept the temporary (or non-temporary)
> introduction of static markers, to help dynamic tracing. But my
> expectation is that these markers will be less intrusive than static
> tracepoints, and a lot more flexible.

It seems like an agreement on this is coming together.  You and Karim
may be in violent agreement, even if others haven't quite come around:

Let us design a static marker mechanism that can be coupled at run
time either to a dynamic system such as systemtap, or by a specialized
tracing system such as lttnng (!).  Then "markers" === "static
instrumentation", for purposes of the kernel developer.  If the
markers are lightweight enough, then a distribution kernel can afford
keeping them compiled in.


- FChE
