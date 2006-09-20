Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751911AbWITQs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbWITQs4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 12:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbWITQsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 12:48:55 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:60889 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751925AbWITQsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 12:48:53 -0400
Message-ID: <451170B9.4010101@sgi.com>
Date: Wed, 20 Sep 2006 18:47:53 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bjorn_helgaas@hp.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>,
       Dean Nelson <dcn@sgi.com>, Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch] do_no_pfn()
References: <Pine.LNX.4.64.0609192126070.4388@g5.osdl.org>	<yq0u033c84a.fsf@jaguar.mkp.net> <20060920084638.900c9a69.rdunlap@xenotime.net>
In-Reply-To: <20060920084638.900c9a69.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On 20 Sep 2006 03:25:25 -0400 Jes Sorensen wrote:
>> +#define NOPFN_SIGBUS	((unsigned long) -1)
>> +#define NOPFN_OOM	((unsigned long) -2)
> 
> Is there any difference in the above and
> 
> #define NOPFN_SIGBUS		-1UL
> #define NOPFN_OOM		-2UL

I don't think there is, but I was trying to keep it consistent with the
NOPAGE_foo versions - the way it's done is more explicit so less likely
anyone will get confused over it.

I can change it if it's a sticking point, but I'd claim thats more noise
than it's worth.

Thanks,
Jes

