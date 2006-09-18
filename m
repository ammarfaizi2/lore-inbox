Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751867AbWIRRyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbWIRRyh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 13:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbWIRRyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 13:54:37 -0400
Received: from dvhart.com ([64.146.134.43]:16869 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751867AbWIRRyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 13:54:37 -0400
Message-ID: <450EDD5B.907@mbligh.org>
Date: Mon, 18 Sep 2006 10:54:35 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Frank Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Paul Mundt <lethal@linux-sh.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>
Subject: Re: tracepoint maintainance models
References: <20060918000703.GA22752@elte.hu> <450DF28E.3050101@opersys.com>	 <20060918011352.GB30835@elte.hu> <20060918122527.GC3951@redhat.com>	 <20060918150231.GA8197@elte.hu>	 <1158594491.6069.125.camel@localhost.localdomain>	 <20060918152230.GA12631@elte.hu>	 <1158596341.6069.130.camel@localhost.localdomain>	 <20060918161526.GL3951@redhat.com>	 <1158598927.6069.141.camel@localhost.localdomain>	 <20060918172705.GN3951@redhat.com> <1158602662.6069.147.camel@localhost.localdomain>
In-Reply-To: <1158602662.6069.147.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Llu, 2006-09-18 am 13:27 -0400, ysgrifennodd Frank Ch. Eigler:
> 
>>Unless one's worried about planetary-scale energy use, I see no point
>>in multiplying overheads by "every box on the planet".
> 
> 
> Because we are all paying for your debug stuff we aren't using. Systems
> get slow and sucky by the death of a million cuts not by one stupid
> action.

Bear in mind that it could be CONFIG'ed out, so you can still do as you
choose. But for many people, the ability to get insight into their
application's interaction with the kernel and get several % performance
improvement by understanding their environment will outweigh the 0.01%
overhead of a few nops.

IME, most performance problems are not little tiny instruction-cycle
level things, they're huge sucking wounds that people just don't know
how to fix, or that they even exist (such as "oops, I single-threaded
all my IO from my app").

M.
