Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbWIQQ7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbWIQQ7j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 12:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbWIQQ7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 12:59:39 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:47526 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965004AbWIQQ7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 12:59:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=zjAAtO6dE3Jqicgb7DHdIS6L7P4/E8qMYwk0k9LTxulHuDPQUZjR9Cvzl6iDOp3F5pIuDumsi6Kmd4X0DRSLxCd8c3YtykgAtf3jCDhJXD2GX+CixSt0Ujt+QvJTDBMn30xcHvL+BdioHbJqF1ffzRFttb7ocW8ljevGMMWfyVc=  ;
Message-ID: <450D7EF0.3020805@yahoo.com.au>
Date: Mon, 18 Sep 2006 02:59:28 +1000
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
References: <20060915215112.GB12789@elte.hu> <Pine.LNX.4.64.0609160018110.6761@scrub.home> <20060915231419.GA24731@elte.hu> <Pine.LNX.4.64.0609160139130.6761@scrub.home> <20060916082214.GD6317@elte.hu> <Pine.LNX.4.64.0609161831270.6761@scrub.home> <20060916230031.GB20180@elte.hu> <Pine.LNX.4.64.0609170310580.6761@scrub.home> <20060917084207.GA8738@elte.hu> <Pine.LNX.4.64.0609171627400.6761@scrub.home> <20060917152527.GC20225@elte.hu> <Pine.LNX.4.64.0609171744570.6761@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0609171744570.6761@scrub.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Roman Zippel wrote:
> Hi,
> 
> On Sun, 17 Sep 2006, Ingo Molnar wrote:
> 
> 
>>>The foremost issue is still that there is only limited kprobes 
>>>support.
>>
>>>The main issue in supporting static tracers are the tracepoints and so 
>>>far I haven't seen any convincing proof that the maintainance overhead 
>>>of dynamic and static tracepoints has to be significantly different.

Above, weren't you asking about static vs dynamic trace-*points*, rather
than the implementation of the tracer itself. I think Ingo said that
some "static tracepoints" (eg. annotation) could be acceptable.

>>to both points i (and others) already replied in great detail - please 
>>follow up on them. (I can quote message-IDs if you cannot find them.)
> 
> 
> What you basically tell me is (rephrased to make it more clear): Implement 
> kprobes support or fuck off! You make it very clear, that you're unwilling 
> to support static tracers even to point to make _any_ static trace support 

Now it seems you are talking about compiled vs runtime inserted traces,
which is different. And so far I have to agree with Ingo: dynamic seems
to be better in almost every way. Implementation may be more complex,
but that's never stood in the way of a better solution before, and I
don't think anybody has shown it to be prohibitive ("I won't implement
it" notwithstanding)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
