Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262697AbVAFBlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbVAFBlT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 20:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262698AbVAFBlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 20:41:18 -0500
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:1125 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262697AbVAFBkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 20:40:52 -0500
Message-ID: <41DC971F.9030705@yahoo.com.au>
Date: Thu, 06 Jan 2005 12:40:47 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: riel@redhat.com, marcelo.tosatti@cyclades.com, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
References: <Pine.LNX.4.61.0501031224400.25392@chimarrao.boston.redhat.com>	<20050105020859.3192a298.akpm@osdl.org>	<20050105180651.GD4597@dualathlon.random>	<Pine.LNX.4.61.0501051350150.22969@chimarrao.boston.redhat.com>	<20050105174934.GC15739@logos.cnet>	<20050105134457.03aca488.akpm@osdl.org>	<20050105203217.GB17265@logos.cnet>	<41DC7D86.8050609@yahoo.com.au>	<Pine.LNX.4.61.0501052025450.11550@chimarrao.boston.redhat.com>	<41DC955D.9020505@yahoo.com.au> <20050105173739.2d91deb3.akpm@osdl.org>
In-Reply-To: <20050105173739.2d91deb3.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>Rik van Riel wrote:
>>
>>>On Thu, 6 Jan 2005, Nick Piggin wrote:
>>>
>>>
>>>>I think what Andrea is worried about is that blk_congestion_wait is 
>>>>fairly vague, and can be a source of instability in the scanning 
>>>>implementation.
>>>
>>>
>>>The recent OOM kill problem has been happening:
>>>1) with cache pressure on lowmem only, due to a block device write
>>>2) with no block congestion at all
>>>3) with pretty much all pageable lowmme pages in writeback state
>>>
>>>It appears the VM has trouble dealing with the situation where
>>>there is no block congestion to wait on...
>>>
>>
>>Try, together with your nr_scanned patch, to replace blk_congestion_wait
>>with io_schedule_timeout.
> 
> 
> Why?  Is the nr_scanned fix insufficient?
> 

I thought it sounded like he implied that nr_scanned was insufficient
(otherwise he might have said "to wait on ... but my patch fixes it").


