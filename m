Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWIOUlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWIOUlu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 16:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWIOUlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 16:41:50 -0400
Received: from opersys.com ([64.40.108.71]:22795 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S932236AbWIOUls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 16:41:48 -0400
Message-ID: <450B1263.4060702@opersys.com>
Date: Fri, 15 Sep 2006 16:51:47 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com>	 <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com>	 <20060915132052.GA7843@localhost.usen.ad.jp>	 <Pine.LNX.4.64.0609151535030.6761@scrub.home>	 <20060915135709.GB8723@localhost.usen.ad.jp> <450AB5F9.8040501@opersys.com>	 <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com>	 <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com>	 <1158332447.5724.423.camel@localhost.localdomain>	 <20060915111644.c857b2cf.akpm@osdl.org> <1158352633.29932.141.camel@localhost.localdomain>
In-Reply-To: <1158352633.29932.141.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox wrote:
> A lot of us have plenty of experience helping customers and end users
> trace bugs. Thats a good part of why we get paid in the first place.

But of course, and I wouldn't dare compare my experience with yours.

FWIW, though, I submit to you that there is a difference in between
helping a customer trace something and actually attempting to create
a tool which standard users can use to trace their own stuff.

Then, again, my experience may just be lacking.

Here's an example just for the fun of it: I was giving a class at
a customer's site. It so happened they scheduled this class right
after product delivery (advice: this is a mistake.) And, predictably,
in came the technician asking for Joe, out went Joe, in came Joe,
repeat. They spent quite some time after hours trying to figure
this one out. Midweek, they asked if I could help, they were
having some odd behavior in user-space on a custom-developed board.
Try as I may, none of the standard user-space stuff was effective.
Ok, time to try ltt. Now this was a "vendor" kernel, with
preemption (ok, I'm not telling who, but this was definitely
before Ingo's work) -- the sort of which I hadn't dabbled in
before. I spent the evening trying to figure out how the heck the
thing worked to no avail -- the locking mechanisms were just
wrong for what ltt needed at the time. Last day I asked him if
they could get a *normal* kernel on there and someone somewhere
found an odd-port stable enough to run. So got an ltt patch,
customized it for said kernel (would have had to do something
similar if it were probe points instead of static traces), got a
trace, and within 5 minutes we had found a bug in their custom
hardware (and no, their drivers were just fine). This customer
would not have even needed me or needed to waste their time if he
had been able to get a trace for his bastardized kernel. But
the way the anti-static-instrumentation creed goes this
customer would still have needed me ... or someone else ...
<conspiracy> wait a minute, maybe that's not a coincidence ...
</conspiracy> ;)

Karim

