Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbWIQR4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbWIQR4w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 13:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbWIQR4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 13:56:52 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:52881 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965037AbWIQR4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 13:56:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ji9XnHf248B9lq9rhNMgZuxUhzHb8g10mBszLp4cgtGJdr53Ac2+yGrZ8tdCPTcNe42SXcek0xAwjsZS7NjKNffYQ9aN6Krp2YA6QplGnU2204TDaGN8tn8vT935QXaa5jC+JHPWKyOCryk4/BoHRtkgHaFFmRrpp6r/pzbTWTw=  ;
Message-ID: <450D8C58.5000506@yahoo.com.au>
Date: Mon, 18 Sep 2006 03:56:40 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       karim@opersys.com, Andrew Morton <akpm@osdl.org>,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060915215112.GB12789@elte.hu> <Pine.LNX.4.64.0609160018110.6761@scrub.home> <20060915231419.GA24731@elte.hu> <Pine.LNX.4.64.0609160139130.6761@scrub.home> <20060916082214.GD6317@elte.hu> <Pine.LNX.4.64.0609161831270.6761@scrub.home> <20060916230031.GB20180@elte.hu> <Pine.LNX.4.64.0609170310580.6761@scrub.home> <20060917084207.GA8738@elte.hu> <Pine.LNX.4.64.0609171627400.6761@scrub.home> <20060917152527.GC20225@elte.hu> <Pine.LNX.4.64.0609171744570.6761@scrub.home> <450D7EF0.3020805@yahoo.com.au> <Pine.LNX.4.64.0609171918430.6761@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0609171918430.6761@scrub.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Mon, 18 Sep 2006, Nick Piggin wrote:
> 
> 
>>Above, weren't you asking about static vs dynamic trace-*points*, rather
>>than the implementation of the tracer itself. I think Ingo said that
>>some "static tracepoints" (eg. annotation) could be acceptable.
> 
> 
> No, he made it rather clear, that as far as possible he only wants dynamic 
> annotations (e.g. via function attributes).

OK we must have him interpreted differently. I won't speak for Ingo,
but he can respond if he likes.

>>Now it seems you are talking about compiled vs runtime inserted traces,
>>which is different. And so far I have to agree with Ingo: dynamic seems
>>to be better in almost every way. Implementation may be more complex,
>>but that's never stood in the way of a better solution before, and I
>>don't think anybody has shown it to be prohibitive ("I won't implement
>>it" notwithstanding)
> 
> 
> I don't deny that dynamic tracer are more flexible, but I simply don't 
> have the resources to implement one. If those who demand I use a dynamic 
> tracer, would also provide the appropriate funding, it would change the 
> situation completely, but without that I have to live with the tools 
> available to me.

You definitely don't have to use a dynamic tracer, nor even implement
one on m68k (that will presumably happen if/when somebody does want a
dynamic tracer enough).

But equally nobody can demand that a feature go into the upstream
kernel. Especially not if there is a more flexible alternative
already available that just requires implementing for their arch.

This shouldn't be surprising, the kernel doesn't have a doctrine of
unlimited choice or merge features because they exist. For example
people wanted pluggable (runtime and/or compile time CPU scheduler
in the kernel. This was rejected (IIRC by Linus, Andrew, Ingo, and
myself). No doubt it would have been useful for a small number of
people but it was decided that it would split testing and development
resources. The STREAMS example is another one.

As an aside, there are quite a number of different types of tracing
things (mostly static, compile out) in the kernel. Everything from
blktrace to various userspace notifiers to lots of /proc/stuff could
be considered a type of static event tracing. I don't know what my
point is other than all these big, disjoint frameworks trying to be
pushed into the kernel. Are there any plans for working some things
together, or is that somebody else's problem?

Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
