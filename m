Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWANGNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWANGNt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 01:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWANGNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 01:13:49 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:47988 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750749AbWANGNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 01:13:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=N/wHm82EymR8/yuxEn58uZDgg9yanGpPJhSvC2I4wuBzu9zjhFmFZFullFor1ZINxMXgxWeyuyo1pkIj1OpkRFTur9ooiwUhHAGHh3YFtiD3aDwBnlp6viGRiigmJJnZr64S/3Xl5rK53JV2jDqRpviupxusqZAQQFPVNnkhoS8=  ;
Message-ID: <43C89698.5050405@yahoo.com.au>
Date: Sat, 14 Jan 2006 17:13:44 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Martin Bligh <mbligh@google.com>, Andy Whitcroft <apw@shadowen.org>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <43C4A3E9.1040301@google.com> <43C4F8EE.50208@bigpond.net.au> <200601120129.16315.kernel@kolivas.org> <43C58117.9080706@bigpond.net.au> <43C5A8C6.1040305@bigpond.net.au> <43C6A24E.9080901@google.com> <43C6B60E.2000003@bigpond.net.au> <43C6D636.8000105@bigpond.net.au> <43C75178.80809@bigpond.net.au> <43C7D4D1.10200@shadowen.org> <43C7E96D.7000003@shadowen.org> <43C81073.1040805@google.com> <43C84496.6060506@bigpond.net.au> <43C8861E.5070203@yahoo.com.au> <43C891C5.2030807@bigpond.net.au>
In-Reply-To: <43C891C5.2030807@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Nick Piggin wrote:
> 

> I figured using the weights (which go away for nice=0 tasks) would make 
> it behave nicely with the rest of the load balancing code.
> 

OK, if you keep working on it that would be great.

>> but I didn't quite look close enough to
>> work out what's going wrong.
> 
> 
> My testing (albeit on an old 2 cpu Celeron) showed no statistically 
> significant difference between with the patch and without.  If you 
> ignored the standard deviations and statistical practice and just looked 
> at the raw numbers you'd think it was better with the patch than without 
> it.  :-)
> 
> I assume that Andy Whitcroft is doing a kernbench with the patch removed 
> from 2.6.15-mm3 (otherwise why would he ask for a patch to do that) and 
> I'm waiting to see how that compares with the run he did with it in. 
> There were other scheduling changes in 2.6.15-mm3 so I think this 
> comparison is needed in order to be sure that any degradation is still 
> due to my patch.
> 
> Peter
> PS As load balancing maintainer, is the value 128 set in cement for 
> SCHED_LOAD_SCALE?  The reason I ask is that if it was changed to be a 
> multiple of NICE_TO_BIAS_PRIO(0) (i.e. 20) my modification could be made 
> slightly more efficient.

Not set in stone but it should really be a power of two because there are
quite a lot of multiplies and divides done with it.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
