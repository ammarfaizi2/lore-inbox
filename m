Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262974AbVDBCUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbVDBCUP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 21:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262971AbVDBCUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 21:20:15 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:8530 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262974AbVDBCTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 21:19:38 -0500
Message-ID: <424E0137.1090401@yahoo.com.au>
Date: Sat, 02 Apr 2005 12:19:35 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Ingo Molnar'" <mingo@elte.hu>, Paul Jackson <pj@engr.sgi.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Industry db benchmark result on recent 2.6 kernels
References: <200504012232.j31MWTg03706@unix-os.sc.intel.com> <Pine.LNX.4.58.0504011447580.4774@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504011447580.4774@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 1 Apr 2005, Chen, Kenneth W wrote:
> 
>>Paul, you definitely want to check this out on your large numa box.  I booted
>>a kernel with this patch on a 32-way numa box and it took a long .... time
>>to produce the cost matrix.
> 
> 
> Is there anything fundamentally wrong with the notion of just initializing
> the cost matrix to something that isn't completely wrong at bootup, and
> just lettign user space fill it in?
> 

That's probably not a bad idea. You'd have to do things like
set RT scheduling for your user tasks, and not have any other
activity happening. So that effectively hangs your system for
a while anyway.

But if you run it once and dump the output to a config file...

Anyway we're faced with the immediate problem of crap performance
for 2.6.12 (for people with 1500 disks), so an in-kernel solution
might be better in the short term. I'll see if we can adapt Ingo's
thingy with something that is "good enough" and doesn't take years
to run on a 512 way.

Nick

-- 
SUSE Labs, Novell Inc.

