Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267396AbUIJNE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267396AbUIJNE6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 09:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267400AbUIJNE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 09:04:58 -0400
Received: from gizmo03bw.bigpond.com ([144.140.70.13]:18617 "HELO
	gizmo03bw.bigpond.com") by vger.kernel.org with SMTP
	id S267396AbUIJNE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 09:04:56 -0400
Message-ID: <4141A674.7010708@bigpond.net.au>
Date: Fri, 10 Sep 2004 23:04:52 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.9-rc1-bk14 Oops] In groups_search()
References: <413FA9AE.90304@bigpond.net.au> <20040909010610.28ca50e1.akpm@osdl.org> <4140EE3E.5040602@bigpond.net.au> <20040909171450.6546ee7a.akpm@osdl.org> <4141092B.2090608@bigpond.net.au> <20040909200650.787001fc.akpm@osdl.org> <41413F64.40504@bigpond.net.au> <20040909231858.770ab381.akpm@osdl.org> <414149A0.1050006@bigpond.net.au> <20040909235217.5a170840.akpm@osdl.org> <41415B15.1050402@bigpond.net.au> <20040910005454.23bbf9fb.akpm@osdl.org> <4141621D.7020301@bigpond.net.au> <414169F0.1040202@bigpond.net.au> <20040910015436.343c9a4d.akpm@osdl.org>
In-Reply-To: <20040910015436.343c9a4d.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Peter Williams <pwil3058@bigpond.net.au> wrote:
> 
>> >  I 
>> > still have the original four patches applied.  I'll try again with an 
>> > unpatched bk16 and let you know the results shortly.
>> > 
>>
>> With out of the box bk16 plus your rock.c patch and with 
>> CONFIG_DEBUG_SLAB and CONFIG_DEBUG_PAGEALLOC selected I get no oops in 
>> in_groupse_p() or kfree() but I still get the scheduling while atomic 
>> messages when I do "make install".
> 
> 
> OK.  Could you please resend one of the scheduling-while-atomic messages?
> 
> Also, try disabling CONFIG_DEBUG_SLAB, and then reenable it and try
> disabling CONFIG_DEBUG_PAGEALLOC.  ie: one at a time, not both at the same
> time.
> 

CONFIG_DEBUG_SLAB is the one that when selected causes the oops to go 
away.  I.e. CONFIG_DEBUG_SLAB alone gives NO oops; 
CONFIG_DEBUG_PAGEALLOC alone gives oops.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

