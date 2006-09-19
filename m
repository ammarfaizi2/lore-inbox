Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWISTZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWISTZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 15:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWISTZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 15:25:29 -0400
Received: from smtp-out.google.com ([216.239.45.12]:43442 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751028AbWISTZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 15:25:28 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=Bpqbn9060rq8AgMIkOQuVjDWc8Y10b+d2147vQ9GAK9osRKScNguAM5IdHAgcPfkd
	eZYO72OW8NRKqczdwnSkw==
Message-ID: <451043E2.8010808@google.com>
Date: Tue, 19 Sep 2006 12:24:18 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
CC: Vara Prasad <prasadav@us.ibm.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, "Frank Ch. Eigler" <fche@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com> <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> <45102641.7000101@google.com> <4510413F.2030200@us.ibm.com> <20060919191652.GC30556@Krystal>
In-Reply-To: <20060919191652.GC30556@Krystal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> * Vara Prasad (prasadav@us.ibm.com) wrote:
> 
>>Martin Bligh wrote:
>>
>>
>>>[...]
>>>Depends what we're trying to fix. I was trying to fix two things:
>>>
>>>1. Flexibility - kprobes seem unable to access all local variables etc
>>>easily, and go anywhere inside the function. Plus keeping low overhead
>>>for doing things like keeping counters in a function (see previous
>>>example I mentioned for counting pages in shrink_list).
>>>
>>
>>Using tools like systemtap on can consult DWARF information and put 
>>probes in the middle of the function and access local variables as well, 
>>that is not the real problem. The issue here is compiler doesn't seem to 
>>generate required DWARF information in some cases due to optimizations.  
>>The other related problem is when there exists debug information, the 
>>way to specify the breakpoint location is using line number which is not 
>>maintainable, having a marker solves this problem as well. Your proposal 
>>still doesn't solve the need for markers if i understood correctly.
>
> His implementation makes a heavy use of a marker mechanism : this is exactly
> what permits to create the instrumented objects from the same source code, but
> with different #defines.

I don't think it ties us to markers, though I think they're superior for
maintaintance, personally. It could equally well be an out of tree
normal flat patch with all the tracing in, which would make Andrew
happy, even if I think it sucks ;-)

M.
