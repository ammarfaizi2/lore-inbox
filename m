Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVG1ItA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVG1ItA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 04:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVG1ItA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 04:49:00 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:22912 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261336AbVG1Is6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 04:48:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=TvcVFVSYIyOuwZ/DutAQAdjxOe9m+2sX0Re5U5TW0jhTbkDaBhK+x0wXULK8Kal2rqUxSUM8GxfkQxr6EFxQKn2p1fqWRVrE1sd7Dp/oWHlY/QVkSwMLjQoMNca1qmOSXV/TqGf0YbOrI+1RTDH6F/Em7f9eEtZGhbqRGpg68FE=  ;
Message-ID: <42E89BE6.6040304@yahoo.com.au>
Date: Thu, 28 Jul 2005 18:48:38 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Keith Owens <kaos@ocs.com.au>, David.Mosberger@acm.org,
       Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Add prefetch switch stack hook in scheduler function
References: <10613.1122538148@kao2.melbourne.sgi.com> <42E897FD.6060506@yahoo.com.au> <20050728083544.GA22740@elte.hu>
In-Reply-To: <20050728083544.GA22740@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>>No, they can be up to 30K apart.  See include/asm-ia64/ptrace.h.
>>>thread_info is at ~0xda0, depending on the config.  The switch_stack
>>>can be as high as 0x7bd0 in the kernel stack, depending on why the task
>>>is sleeping.
>>>
>>
>>Just a minor point, I agree with David: I'd like it to be called 
>>prefetch_task(), because some architecture may want to prefetch other 
>>memory.
> 
> 
> such as?
> 

Not sure. thread_info? Maybe next->timestamp or some other fields
in next, something in next->mm?

I didn't really have a concrete example, but in the interests of
being future proof...

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
