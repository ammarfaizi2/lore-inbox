Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268368AbUJHKAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268368AbUJHKAP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 06:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUJHKAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 06:00:15 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:58451 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268368AbUJHKAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 06:00:06 -0400
Message-ID: <416663B7.5000901@yahoo.com.au>
Date: Fri, 08 Oct 2004 19:53:59 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Erich Focht <efocht@hpce.nec.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>,
       Simon.Derr@bull.net, colpatch@us.ibm.com, pwil3058@bigpond.net.au,
       frankeh@watson.ibm.com, dipankar@in.ibm.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <20041007105425.02e26dd8.pj@sgi.com> <1344740000.1097172805@[10.10.2.4]> <200410081123.45762.efocht@hpce.nec.com>
In-Reply-To: <200410081123.45762.efocht@hpce.nec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erich Focht wrote:
> On Thursday 07 October 2004 20:13, Martin J. Bligh wrote:
> 
>>It all just seems like a lot of complexity for a fairly obscure set of
>>requirements for a very limited group of users, to be honest. Some bits
>>(eg partitioning system resources hard in exclusive sets) would seem likely
>>to be used by a much broader audience, and thus are rather more attractive.
> 
> 
> May I translate the first sentence to: the requirements and usage
> models described by Paul (SGI), Simon (Bull) and myself (NEC) are
> "fairly obscure" and the group of users addressed (those mainly
> running high performance computing (AKA HPC) applications) is "very
> limited"? If this is what you want to say then it's you whose view is
> very limited. Maybe I'm wrong with what you really wanted to say but I
> remember similar arguing from your side when discussing benchmark
> results in the context of the node affine scheduler.
> 
> This "very limited group of users" (small part of them listed in
> www.top500.org) is who drives computer technology, processor design,
> network interconnect technology forward since the 1950s. Their
> requirements on the operating system are rather limited and that might
> be the reason why kernel developers tend to ignore them. All that
> counts for HPC is measured in GigaFLOPS or TeraFLOPS, not in elapsed
> seconds for a kernel compile, AIM-7, Spec-SDET or Javabench. The way
> of using these machines IS different from what YOU experience in day
> by day work and Linux is not yet where it should be (though getting
> close). Paul's endurance in this thread is certainly influenced by the
> perspective of having to support soon a 20x512 CPU NUMA cluster at
> NASA...
> 
> As a side note: put in the right context your statement on fairly
> obscure requirements for a very limited group of users is a marketing
> argument ... against IBM.
> 
> Thanks ;-)
> Erich
> 

With all due respect, Linux gets driven as much from the bottom up
as it does from the top down I think. Compared to desktop and small
servers, yes you are obscure :)

My view on it is this, we can do *exclusive* dynamic partitioning
today (we're very close to it - it wouldn't add complexity in the
scheduler to support it). You can also hack up a fair bit of other
functionality with cpu affinity masks.

So with any luck, that will hold you over until everyone working on
this can agree and produce a nice implementation that doesn't add
complexity to the normal case (or can be configured out), and then
pull it into the kernel.
