Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbVDBCMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVDBCMf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 21:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbVDBCMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 21:12:35 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:133 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261664AbVDBCM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 21:12:26 -0500
Message-ID: <424DFF88.30003@yahoo.com.au>
Date: Sat, 02 Apr 2005 12:12:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: "'Ingo Molnar'" <mingo@elte.hu>, "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Industry db benchmark result on recent 2.6 kernels
References: <200504020100.j3210fg04870@unix-os.sc.intel.com>
In-Reply-To: <200504020100.j3210fg04870@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:
> Ingo Molnar wrote on Thursday, March 31, 2005 8:52 PM
> 
>>the current defaults for cache_hot_time are 10 msec for NUMA domains,
>>and 2.5 msec for SMP domains. Clearly too low for CPUs with 9MB cache.
>>Are you increasing cache_hot_time in your experiment? If that solves
>>most of the problem that would be an easy thing to fix for 2.6.12.
> 
> 
> 
> Chen, Kenneth W wrote on Thursday, March 31, 2005 9:15 PM
> 
>>Yes, we are increasing the number in our experiments.  It's in the queue
>>and I should have a result soon.
> 
> 
> Hot of the press: bumping up cache_hot_time to 10ms on our db setup brings
> 2.6.11 performance on par with 2.6.9.  Theory confirmed.
> 

OK, that's good. I'll look at whether we can easily use Ingo's
tool on the SMP domain only, to avoid the large O(n^2). That might
be an acceptable short term solution for 2.6.12.

If you get a chance to also look at those block layer patches that
would be good - if they give you a nice improvement, that would
justify getting them into -mm.

-- 
SUSE Labs, Novell Inc.

