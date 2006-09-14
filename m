Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWINRlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWINRlO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 13:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWINRlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 13:41:14 -0400
Received: from opersys.com ([64.40.108.71]:25359 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1750801AbWINRlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 13:41:13 -0400
Message-ID: <45099695.4030703@opersys.com>
Date: Thu, 14 Sep 2006 13:51:17 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0609141623570.6761@scrub.home>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Roman Zippel wrote:
> Even dynamic tracepoints have a maintainance overhead and I doubt there is 
> much difference. The big problem is having to maintain them outside the 
> mainline kernel, that's why it's so important to get them into the 
> mainline kernel.

Thanks for pointing this out. This is indeed the nugget. We can try
slicing the pie in any direction we think is best, but the bottom
line is that there's somebody somewhere that is matching source code
to important events (regardless of whether the instrumentation is
static or dynamic.) For a very long time the mantra on LKML was
"instrumentation is evil: it's a maintenance nightmare." Try as I
may, every argument I put forth was countered by this mantra.

Unfortunately for me, but fortunately for the current ltt maintainers,
time is a powerful argument. So, with that in mind, here are some
excerpts of a discussion I had with Andrew back in the summer of
2004:

Here's Andrew pulling the "instrumentation is evil" mantra:
http://marc.theaimsgroup.com/?l=linux-kernel&m=108873232414895&w=2

Here's me demonstrating that the mantra is wrong by comparing a
patch against 2.2.13 dated 1999/11/18 and a patch against 2.6.3
dated 2004/03/15:
http://marc.theaimsgroup.com/?l=linux-kernel&m=108874078111041&w=2

And here's Andrew, to his credit, saying "Fair enough."
http://marc.theaimsgroup.com/?l=linux-kernel&m=108874940728542&w=2

Now, this is 2 years ago and I haven't done the analysis recently,
but I'd bet the comparison would probably yield very similar
results. The 1st ltt patch was made in July 1999, that's more
than **7** years ago. How much longer can anybody continue saying
with a straight face that static instrumentation is a maintenance
problem? In my opinion the real problem is what impact the fact
that this issue has lingered on for so long has in encouraging people
and/or companies in investing any sort of effort in the kernel
development process. There's just no excuse for Linux not to have
something that is clearly as essential as this.

I think now is a good time to put this issue to rest and drop the
misleading mantra.

Cheers,

Karim

